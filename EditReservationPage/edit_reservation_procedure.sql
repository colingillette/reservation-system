-- At work. Changes are untested

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
    room_no_text rooms.room_no%type;
    price_text rooms.price%type;
begin
    select c.first, c.last, c.card_no, c.card_type, re.arrive_date, re.depart_date, re.adults, re.kids, l.city, ro.room_no, to_char(ro.price, '$999.99')
    into first_text, last_text, card_no_text, card_type_text, arrive_date_text, depart_date_text, adults_text, kids_text, city_text, room_no_text, price_text
    from customers c, locations l, rooms ro, reservations re
    where c.customer_id = re.customer_id
        and ro.room_id = re.room_id
        and l.location_id = ro.location_id
        and re.reservation_id = reservation_id_in;

    dbms_output.put_line(first_text || ' ' || last_text ||': Reservation Number ' || reservation_id_in);
    dbms_output.put_line(city_text || ' location, Room: ' || room_no_text || ' - ' || price_text || ' per night.');
    dbms_output.put_line('Credit Card: ' || card_type_text || ' ' || card_no_text);
    dbms_output.put_line('Dates of Stay: ' || arrive_date_text || ' - ' || depart_date_text);
    dbms_output.put_line('Adults: ' || adults_text);
    dbms_output.put_line('Kids: ' || kids_text);
end;