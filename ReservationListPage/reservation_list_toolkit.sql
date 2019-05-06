create or replace procedure show_current_reservations as
    cursor location_cursor is
    select location_id, city, state_province, country from locations;
    location_row location_cursor%rowtype;
begin
    htp.print('<!DOCTYPE html PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
    <html>
        <head>
            <title>Reservation List</title>
            <link rel="stylesheet" href="index.css">
            <div style="text-align:center;">
                <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
                <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
                <head><a href="show_current_reservations">Administration</a></head>
            </div>
        </head>
        <hr>
        <body>
            <h1 style="text-align:center;">Current Reservations</h1>
            <form action="edit_reservation" method="post">');
                for location_row in location_cursor
                loop
                    
                    htp.print('<section>
                        <h3>'||location_row.city||'</h3>
                        <table>
                            <tr>
                                <th></th>
                                <th>Customer Name</th>
                                <th>Room Number</th>
                                <th>Price per Night</th>
                                <th>Arrival Date</th>
                                <th>Departure Date</th>
                            </tr>');
                            for reservation in (select reservation_id, first, last, room_no, price, arrive_date, depart_date
                                                from customers, rooms, reservations, locations
                                                where customers.customer_id = reservations.customer_id 
                                                    AND rooms.room_id = reservations.room_id 
                                                    AND locations.location_id = rooms.location_id
                                                    AND locations.location_id = location_row.location_id
                                                    AND depart_date > sysdate
                                                order by arrive_date)
                            loop
                                htp.prn('<tr><td><input type="radio" name="reservation_id_in" value="'||reservation.reservation_id||'"></td>');
                                htp.prn('<td>'||reservation.first||' '||reservation.last||'</td>');
                                htp.prn('<td>'||reservation.room_no||'</td>');
                                htp.prn('<td>'||reservation.price||'</td>');
                                htp.prn('<td>'||reservation.arrive_date||'</td>');
                                htp.prn('<td>'||reservation.depart_date||'</td></tr>');
                            end loop;
                        htp.print('</table>
                    </section>');

                end loop;
                
                htp.print('<input type="submit" value="Submit" name="submit" style="font-size: 20px; background-color:darkgrey; margin-left: 47%;">
            </form>
        </body>
    </html>');
end;