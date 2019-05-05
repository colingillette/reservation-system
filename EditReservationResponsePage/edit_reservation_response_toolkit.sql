create or replace procedure edit_reservation_response
    (first_name_in varchar2 default null,
    last_name_in varchar2 default null,
    card_number_in varchar2 default null,
    card_type_in varchar2 default null,
    arrival_date_in varchar2 default null,
    depart_date_in varchar2 default null,
    adults_in number default null,
    children_in number default null,
    reservation_id_in number default null,
    customer_id_in number default null,
    room_id_in number default null,
    submit varchar2 default null) is
        arrival_text reservations.arrive_date%type;
        depart_text reservations.depart_date%type;
        previous_arrival reservations.arrive_date%type;
        previous_depart reservations.depart_Date%type;
        previous_adults reservations.adults%type;
        previous_kids reservations.kids%type;
begin
    select arrive_date, depart_date, adults, kids
    into previous_arrival, previous_depart, previous_adults, previous_kids
    from reservations
    where reservation_id = reservation_id_in;

    update customers 
    set first = first_name_in, last = last_name_in, card_no = card_number_in, card_type = card_type_in
    where customer_id = customer_id_in;

    arrival_text := to_date(arrival_date_in, 'yyyy/mm/dd');
    depart_text := to_date(depart_date_in, 'yyyy/mm/dd');

    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Reservation Edited</title>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
            <br />
            <!-- Navigation Bar Links -->
            <a href="home_page">Homepage</a><br>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div allign="center">
            <p>The following Customer information has been saved for Reservation '||reservation_id_in||'</p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr><td>Full Name:</td><td>'||first_name_in||' '||last_name_in||'</td></tr>
                <tr><td>Card Number:</td><td>'||card_number_in||'</td></tr>
                <tr><td>Card Company:</td><td>'||card_type_in||'</td></tr>
            </table>');
    if arrival_text = previous_arrival and depart_text = previous_depart and adults_in = previous_adults and children_in = previous_kids then
        htp.print('<p>No changes were made to the reservation.</p>');
        htp.print('<table border="0" cellpadding="1" cellspacing="1" summary="">
                    <tr><td>Number of Adults:</td><td>'||adults_in||'</td></tr>
                    <tr><td>Number of Kids:</td><td>'||children_in||'</td></tr>
                    <tr><td>Arrive Date:</td><td>'||arrival_date_in||'</td></tr>
                    <tr><td>Depart Date:</td><td>'||depart_date_in||'</td></tr>
                </table>');
    else
        if get_date_conflicts(room_id_in, arrival_text, depart_text) then
            update reservations
            set arrive_date = arrival_text, depart_date = depart_text, adults = adults_in, kids = children_in
            where reservation_id = reservation_id_in;
            
            htp.print('<p>The following Reservation information has been updated and saved for Reservation '||reservation_id_in||'</p>
                <table border="0" cellpadding="1" cellspacing="1" summary="">
                    <tr><td>Number of Adults:</td><td>'||adults_in||'</td></tr>
                    <tr><td>Number of Kids:</td><td>'||children_in||'</td></tr>
                    <tr><td>Arrive Date:</td><td>'||arrival_date_in||'</td></tr>
                    <tr><td>Depart Date:</td><td>'||depart_date_in||'</td></tr>
                </table>');
            
        else
            htp.prn('Thinks stuff is: '||room_id_in||' '||arrival_text||' - '||depart_text||' ');
            htp.print('<p>While we could save any changes to the customer, there was a conflict with that room on 
                        the selected dates. You will have to delete this reservation and complete a new one in 
                        a different room if you require these dates.</p>');
        end if;
    end if;
    
    htp.print('</div>
        </body>
    </html>');
    
    exception
    when others then
    htp.prn(sqlerrm);
end;