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
    
    insert into reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        values (reservation_id_seq.nextval, room_id_in, customer_id_text, arrival_in, depart_in, adults_in, children_in);
    
    arrival_in_date := to_date(arrival_in, 'yyyy/mm/dd');
    depart_in_date := to_date(depart_in, 'yyyy/mm/dd');
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>New Reservations Created</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head></div>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <p><b>Your Reservation</b></p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr></tr>
                <tr><td>Full Name:</td><td>'||first_name_in||' '||last_name_in||'</td></tr>
                <tr><td>Reservation ID:</td><td>'||reservation_id_seq.currval||'</td></tr>
                <tr><td>Arrival Date:</td><td>'||arrival_in||'</td></tr>
                <tr><td>Depart Date:</td><td>'||depart_in||'</td></tr>
                <tr><td>Reservation Location:</td><td>'||city_in||' Room '||room_no_text||'</td></tr>
                <tr><td>Adults</td><td>'||adults_in||'</td></tr>
                <tr><td>Kids</td><td>'||children_in||'</td></tr>
            </table>
            ');
        htp.prn('</div>
        <!-- End Page Content -->
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;