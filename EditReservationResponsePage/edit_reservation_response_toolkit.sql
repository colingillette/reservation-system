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
begin

    update customers 
    set first = first_name_in, last = last_name_in, card_no = card_number_in, card_type = card_type_in
    where customer_id = customer_id_in;

    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Reservation Edited</title>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
            <br />
            <!-- Navigation Bar Links -->
            <a href="Create_New_Reservation">Homepage</a><br>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div allign="center">
            <p>The following Customer information has been saved for Reservation '||reservation_id_in||'</p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr><td>Full Name:</td><td>'||first_name_in||' '||last_name_in||'</td></tr>
                <tr><td>Card Number:</td><td>'||card_number_in||'</td></tr>
                <tr><td>Card Company:</td><td>'||card_type_in||'</td></tr>
            </table>');

    if get_date_conflicts(room_id_in, to_date(arrival_date_in, 'yyyy/mm/dd'), to_date(depart_date_in, 'yyyy/mm/dd')) = false then
        update reservations
        set arrive_date = to_date(arrival_date_in, 'yyyy/mm/dd'), depart_date = to_date(depart_date_in, 'yyyy/mm/dd'), adults = adults_in, kids = children_in
        where reservation_id = reservation_id_in;
        
        htp.print('<p>The following Reservation information has been updated and saved for Reservation '||reservation_id_in||'</p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr><td>Number of Adults:</td><td>'||adults_in||'</td></tr>
                <tr><td>Number of Kids:</td><td>'||children_in||'</td></tr>
                <tr><td>Arrive Date:</td><td>'||arrival_date_in||'</td></tr>
                <tr><td>Depart Date:</td><td>'||depart_date_in||'</td></tr>
            </table>');
        
    else
        htp.print('<p>While we could save any changes to the customer, there was a conflict with that room on 
                    the selected dates. You will have to delete this reservation and complete a new one in 
                    a different room if you require these dates.</p>');
    end if;
    
    htp.print('</div>
        </body>
    </html>');
    
    exception
    when others then
    htp.prn(sqlerrm);
end;