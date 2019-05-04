create or replace procedure new_reservation
    (first_name_in varchar2,
    last_name_in varchar2,
    adults_in number,
    children_in number,
    arrival_in varchar2,
    depart_in varchar2,
    city_in varchar2,
    card_number_in varchar2,
    card_company_name_in varchar2,
    room_id_in number,
    submit_button_in varchar2) IS
        location_id_text locations.location_id%type;
        customer_id_text customers.customer_id%type;
        room_no_text rooms.room_no%type;
        arrival_in_date reservations.arrive_date%type;
        depart_in_date reservations.depart_date%type;
begin
    customer_id_text := get_customer_id(first_name_in, last_name_in, card_number_in, card_company_name_in);

    room_no_text := get_room_number(room_id_in);
    
    arrival_in_date := to_date(arrival_in, 'yyyy/mm/dd');
    depart_in_date := to_date(depart_in, 'yyyy/mm/dd');
    
    insert into reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        values (reservation_id_seq.nextval, room_id_in, customer_id_text, arrival_in, depart_in, adults_in, children_in);
    
    dbms_output.put_line('Name: ' || first_name_in || ' ' || last_name_in);
    dbms_output.put_line('Reservation Number: ' || reservation_id_seq.currval);
    dbms_output.put_line('Location and Room: ' || city_in || ': ' || room_no_text);
    dbms_output.put_line(adults_in || ' adults and ' || children_in || ' kids.');
    
    commit;
end;