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
submit_button_in varchar2) IS
customers_name_text customers.first%type;
new_customer_id customers.customer_id%type;
new_cust_location_id locations.location_id%type;
new_cust_room_id rooms.room_id%type;
new_cust_reservations_id reservations.reservation_id%type;
new_room_no rooms.room_no%type;
begin
insert into customers values(customer_id_seq.nextval,first_name_in, last_name_in,card_number_in, card_company_name_in);
insert into rooms(room_id,room_no,fits_no_adults, fits_no_kids) values(room_id_seq.nextval,room_no_seq.nextval,adults_in, children_in); 
insert into reservations(reservation_id, arrive_date, depart_date) values(reservation_id_seq.nextval,arrival_in, depart_in);
insert into locations(location_id,city) values(location_id_seq.nextval, city_in);
commit;
Select customer_id_seq.currval into new_customer_id from dual;
Select room_id_seq.currval into new_cust_room_id from dual;
Select reservation_id_seq.currval into new_cust_reservations_id from dual;
Select location_id_seq.currval into new_cust_location_id from dual;
Select room_no_seq.currval into new_room_no from dual;
Select first into customers_name_text from customers;
end;