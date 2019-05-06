create or replace procedure delete_reservation
    (reservation_id_in number,
    submit varchar2) is
begin
    delete from reservations
    where reservation_id = reservation_id_in;
    
    htp.print('<!DOCTYPE HTML PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
    <html>
        <head>
            <link rel="stylesheet" href="index.css">
        </head>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head>
        </div>
        <hr>
    <title align>Reservation Deleted</title>
    <body>
        <h1 style="text-align:center">Reservation Deleted</h1>
        <p style="text-align:center">
            This represents confirmation that Reservation <b>'||reservation_id_in||'</b> has been deleted. Please use the
            navigation buttons above to go to another page.
        </p>
    </body>
    </html>');
end;