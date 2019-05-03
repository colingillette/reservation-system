-- At work. Changes are untested.

begin
dbms_epg.create_dad('xepsp','/xepsp/*');
end;

create or replace procedure Create_New_Reservation as 
    cursor location_cursor is 
        select city
        from locations;
    location_row location_cursor%rowtype;
begin 
htp.print('<!DOCTYPE HTML PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <link rel="stylesheet" href="index.css">
    </head>
    <head><a href="createReservation.html" id="createreservation">Create Reservation</a></head>
    <head><a href="reservationList.html">Administration</a></head>
    <hr>
<title align = "center">Create Reservation</title>
<body>
    <h1>Create Reservation</h1>

    <form action="room_picker" method="post" align="center">
        First Name:
        <input type="text" name="first_name_in" style="margin-top:20px"><br>
        Last Name:
        <input type="text" name="last_name_in" style="margin-top:15px"><br>
        Number of Adults:
        <select style="margin-top: 15px" name="adults_in">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
        </select><br>
        Number of children:
        <select style="margin-top: 15px" name="children_in">
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select><br>
        Arrival Date:
        <input type="date" name="arrival_in" style="margin-top: 15px"><br>
        Departure Date:
        <input type="date" name="depart_in" style="margin-top: 15px"><br>
        Location:
        <select style="margin-top:15px" name="city_in"> ')
            for location_row in location_cursor
            loop
                htp.prn('<option value="'||city||'">'||city||'</option>');
            end loop;
        htp.print('</select><br>
        Card Number:
        <input type="text" name="card_number_in" style="margin-top: 15px"><br>
        Card Company:
        <select style="margin-top:15px;margin-bottom:15px;" name="card_company_name_in">
            <option value="Visa">Visa</option>
            <option value="Mastercard">MasterCard</option>
            <option value="Discover">Discover</option>
            <option value="American Express">American Express</option>
        </select>
        <input type="submit" name="submit_button_in" value="Proceed"/>
     </form>
    
</body>
</html>
');
end;
