create or replace procedure edit_reservation
    (reservation_id_in reservations.reservation_id%type,
    submit varchar2) is
    first_text customers.first%type;
    last_text customers.last%type;
    card_no_text customers.card_no%type;
    card_type_text customers.card_type%type;
    arrive_date_text reservations.arrive_date%type;
    depart_date_text reservations.depart_date%type;
    adults_text reservations.adults%type;
    kids_text reservations.kids%type;
    city_text locations.city%type;
    room_id_text rooms.room_id%type;
    room_no_text rooms.room_no%type;
    price_text rooms.price%type;
    max_adults rooms.fits_no_adults%type;
    max_kids rooms.fits_no_kids%type;
begin
    select c.first, c.last, c.card_no, c.card_type, re.arrive_date, re.depart_date, re.adults, re.kids, l.city, ro.room_id, ro.room_no, to_char(ro.price, '$999.99')
    into first_text, last_text, card_no_text, card_type_text, arrive_date_text, depart_date_text, adults_text, kids_text, city_text, room_id_text, room_no_text, price_text
    from customers c, locations l, rooms ro, reservations re
    where c.customer_id = re.customer_id
        and ro.room_id = re.room_id
        and l.location_id = ro.location_id
        and re.reservation_id = reservation_id_in;

    max_adults := max_people('adults', room_id_text);
    max_kids := max_people('kids', room_id_text);

    for i in 1..max_adults
    loop
        dbms_output.put_line(i);
    end loop;

    for j in 0..max_kids
    loop
        dbms_output.put_line(j);
    end loop;
end;