create or replace procedure edit_reservation_response
    (customer_id_in number,
    first_name_in varchar2,
    last_name_in varchar2,
    card_number_in varchar2,
    card_type_in varchar2,
    arrival_date_in varchar2,
    depart_date_in varchar2,
    adults_in number,
    children_in number,
    reservation_id_in number,
    submit varchar2) is
        arrival_text reservations.arrive_date%type;
        depart_text reservations.depart_date%type;
begin

    arrival_text := to_date(arrival_date_in, 'yyyy/mm/dd');
    depart_text := to_date(depart_date_in, 'yyyy/mm/dd');

    update customers 
    set first = first_name_in, last = last_name_in, card_no = card_number_in, card_type = card_type_in
    where customer_id = customer_id_in;
    
    update reservations
    set arrive_date = arrival_text, depart_date = depart_text, adults = adults_in, kids = children_in
    where reservation_id = reservation_id_in;
end;