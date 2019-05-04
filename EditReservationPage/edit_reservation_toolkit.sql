create or replace procedure edit_reservation
    (reservation_id_in reservations.reservation_id%type,
    submit varchar2) is
    first_text customers.first%type;
    last_text customers.last%type;
    card_no_text customers.card_no%type;
    card_type_text customers.card_type%type;
    arrive_date_text reservations.arrive_date%type;
    depart_date_text reservations.depart_date%type;
    adults_text reservations.adults%type;
    kids_text reservations.kids%type;
    city_text locations.city%type;
    room_id_text rooms.room_id%type;
    room_no_text rooms.room_no%type;
    price_text rooms.price%type;
    max_adults rooms.fits_no_adults%type;
    max_kids rooms.fits_no_kids%type;
begin
    select c.first, c.last, c.card_no, c.card_type, re.arrive_date, re.depart_date, re.adults, re.kids, l.city, ro.room_id, ro.room_no, to_char(ro.price, '$999.99')
    into first_text, last_text, card_no_text, card_type_text, arrive_date_text, depart_date_text, adults_text, kids_text, city_text, room_id_text, room_no_text, price_text
    from customers c, locations l, rooms ro, reservations re
    where c.customer_id = re.customer_id
        and ro.room_id = re.room_id
        and l.location_id = ro.location_id
        and re.reservation_id = reservation_id_in;

    max_adults := max_people('adults', room_id_text);
    max_kids := max_people('kids', room_id_text);
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Edit Reservation</title>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
            <br />
            <!-- Navigation Bar Links -->
            <a href="Create_New_Reservation">Homepage</a><br>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <h1>Edit Reservation</h1> 
            
            <section><section>');
                htp.prn('<p style="text-align: center;">Reservation number: <b>'||reservation_id_in||'</b></p>');
                htp.prn('<p>'||city_text||': Room '||room_no_text||' priced at '||price_text||' per night.</p>');
                htp.print('<form action="edit_reservation_response" method="post">
                    First Name: <input type="text" name="first_name_in" value="'||first_text||'"><br>
                    Last Name: <input type="text" name="last_name_in" value="'||last_text||'"><br><br>
                    Card Information: <input type="text" name="card_number_in" value="'||card_no_text||'> <select>');
                        if card_type_text = 'Visa' then
                            htp.prn('<option name="card_type_in" value="Visa" selected="selected">'); 
                        else 
                            htp.prn('<option name="card_type_in" value="Visa">');
                        end if;
                        if card_type_text = 'MasterCard' then
                            htp.prn('<option name="card_type_in" value="MasterCard" selected="selected">'); 
                        else 
                            htp.prn('<option name="card_type_in" value="MasterCard">');
                        end if;
                        if card_type_text = 'Discover' then
                            htp.prn('<option name="card_type_in" value="Discover" selected="selected">'); 
                        else 
                            htp.prn('<option name="card_type_in" value="Discover">');
                        end if;
                        if card_type_text = 'American Express' then
                            htp.prn('<option name="card_type_in" value="American Express" selected="selected">'); 
                        else 
                            htp.prn('<option name="card_type_in" value="American Express">');
                        end if;
                    htp.print('</select><br><br>
                    Arrival Date: <input type="text" name="arrival_date_in" value='||arrive_date_text||'><br>
                    Depart Date: <input type="text" name="depart_date_in" value='||depart_date_text||'><br><br>
                    Adults: <select>');
                        for counter1 in 1..max_adults
                        loop
                            htp.prn('<option name="adults_in" value='||counter1||'>');
                        end loop;
                    htp.print('</select><br>
                    <select>');
                        for counter1 in 0..max_kids
                        loop
                            htp.prn('<option name="children_in" value='||counter1||'>');
                        end loop;
                    htp.print('</select><br>
                    <input type="submit" name="submit" value="submit">
                </form');
            htp.print('</section></section>
        </div>
    </body>
    </html>
    ');
end;