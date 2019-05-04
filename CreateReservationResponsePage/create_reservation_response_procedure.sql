create or replace procedure new_reservation
    (first_name_in customers.first%type,
    last_name_in customers.last%type,
    adults_in rooms.fits_no_adults%type,
    children_in rooms.fits_no_kids%type,
    arrival_in reservations.arrive_date%type,
    depart_in reservations.depart_date%type,
    city_in locations.city%type,
    card_number_in customers.card_no%type,
    card_company_name_in customers.card_type%type,
    room_id_in rooms.room_id%type,
    submit_button_in varchar2) IS
        location_id_text locations.location_id%type;
        customer_id_text customers.customer_id%type;
        room_no_text rooms.room_no%type;
begin
    customer_id_text := get_customer_id(first_name_in, last_name_in, card_number_in, card_company_name_in);

    room_no_text := get_room_number(room_id_in);
    
    insert into reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        values (reservation_id_seq.nextval, room_id_in, customer_id_text, arrival_in, depart_in, adults_in, children_in);
    
    dbms_output.put_line('Name: ' || first_name_in || ' ' || last_name_in);
    dbms_output.put_line('Reservation Number: ' || reservation_id_seq.currval);
    dbms_output.put_line('Location and Room: ' || city_in || ': ' || room_no_text);
    dbms_output.put_line(adults_in || ' adults and ' || children_in || ' kids.');
    
    commit;
end;