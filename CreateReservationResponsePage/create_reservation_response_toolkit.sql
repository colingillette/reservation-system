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
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>New Reservations Created</title>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
            <br />
            <!-- Navigation Bar Links -->
            <a href="Create_New_Reservation">Homepage</a><br>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div allign="center">
        <table border="0" cellpadding="1" cellspacing="1" summary="">
            <tr><td><b>Your Club</b></td></tr>
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
        htp.prn('<!-- End Page Content -->
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;