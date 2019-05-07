-- Run this to create all functions at once

create or replace function check_for_customer
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return boolean is
    cursor customer_cursor is
        select first, last, card_no, card_type
        from customers;
    customer_row customer_cursor%rowtype;
begin
    for customer_row in customer_cursor
    loop
        if customer_row.first = first_name_in and customer_row.last = last_name_in and customer_row.card_no = card_no_in and customer_row.card_type = card_type_in then
            return true;
        end if;
    end loop;

    return false;
end;
/

create or replace function get_customer_id
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return number is
    customer_id_text customers.customer_id%type;
begin
    select customer_id
    into customer_id_text
    from customers
    where first = first_name_in
        and last = last_name_in
        and card_no = card_no_in
        and card_type = card_type_in;
    
    return customer_id_text;
end;
/

-- Out of some stroke of genius I apparently had, this returns true if the dates do not conlfict.

create or replace function get_date_conflicts
    (room_id_in IN rooms.room_id%type,
    arrival_in IN reservations.arrive_date%type,
    depart_in IN reservations.depart_date%type)
    return boolean is
begin
    for reservation in (select arrive_date, depart_date from reservations where room_id = room_id_in)
        loop
            if (reservation.arrive_date < arrival_in and reservation.depart_date > arrival_in) 
                or (reservation.arrive_date < depart_in and reservation.depart_date > depart_in)
                or (arrival_in < reservation.arrive_date and depart_in > reservation.depart_date) then
                    return false;
            end if;
        end loop;
    return true;
end;
/

create or replace function get_room_number
    (room_id_in rooms.room_id%type)
    return rooms.room_no%type is
    room_no_text rooms.room_no%type;
begin
    select room_no
    into room_no_text
    from rooms
    where room_id = room_id_in;

    return room_no_text;
end;
/

create or replace function max_people
    (person_type varchar2,
    room_id_in rooms.room_id%type)
    return number is
    num number(2);
begin
    if person_type = 'adults' then
        select fits_no_adults
        into num
        from rooms
        where room_id = room_id_in;
    else
        select fits_no_adults
        into num
        from rooms
        where room_id = room_id_in;
    end if;

    return num;
end;