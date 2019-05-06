create or replace procedure edit_reservation
    (reservation_id_in number,
    submit varchar2) is
    customer_id_text customers.customer_id%type;
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
    price_text varchar2(30);
    max_adults rooms.fits_no_adults%type;
    max_kids rooms.fits_no_kids%type;
    counter1 reservations.adults%type;
    counter2 reservations.kids%type;
begin
    select c.customer_id, c.first, c.last, c.card_no, c.card_type, re.arrive_date, re.depart_date, re.adults, re.kids, l.city, ro.room_id, ro.room_no, to_char(ro.price, '$999.99')
    into customer_id_text, first_text, last_text, card_no_text, card_type_text, arrive_date_text, depart_date_text, adults_text, kids_text, city_text, room_id_text, room_no_text, price_text
    from customers c, locations l, rooms ro, reservations re
    where c.customer_id = re.customer_id
        and ro.room_id = re.room_id
        and l.location_id = ro.location_id
        and re.reservation_id = reservation_id_in;

    max_adults := max_people('adults', room_id_text);
    max_kids := max_people('kids', room_id_text);
    
    counter1 := 1;
    counter2 := 0;
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Edit Reservation</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head>
        </div>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <h1>Edit Reservation</h1> 
            
            <section><section>');
                htp.prn('<p style="text-align: center;">Reservation number: <b>'||reservation_id_in||'</b></p>');
                htp.prn('<p><b>'||city_text||'</b>: Room '||room_no_text||' priced at '||price_text||' per night.</p>');
                htp.print('<form action="edit_reservation_response" method="post">
                    First Name: <input type="text" name="first_name_in" value="'||first_text||'"><br>
                    Last Name: <input type="text" name="last_name_in" value="'||last_text||'"><br><br>
                    Card Information: <input type="text" name="card_number_in" value="'||card_no_text||'"> <select name="card_type_in">');
                        if card_type_text = 'Visa' then
                            htp.prn('<option value="Visa" selected="selected">Visa</option>'); 
                        else 
                            htp.prn('<option value="Visa">Visa</option>');
                        end if;
                        if card_type_text = 'MasterCard' then
                            htp.prn('<option value="MasterCard" selected="selected">MasterCard</option>'); 
                        else 
                            htp.prn('<option value="MasterCard">MasterCard</option>');
                        end if;
                        if card_type_text = 'Discover' then
                            htp.prn('<option value="Discover" selected="selected">Discover</option>'); 
                        else 
                            htp.prn('<option value="Discover">Discover</option>');
                        end if;
                        if card_type_text = 'American Express' then
                            htp.prn('<option value="American Express" selected="selected">American Express</option>'); 
                        else 
                            htp.prn('<option value="American Express">American Express</option>');
                        end if;
                    htp.print('</select><br><br>
                    <p>Current Dates of Stay: '||arrive_date_text||' - '||depart_date_text||'</p>
                    Arrival Date: <input type="date" name="arrival_date_in"><br>
                    Depart Date: <input type="date" name="depart_date_in"><br><br>
                    Adults: <select name="adults_in">');
                        for counter1 in 1..max_adults
                        loop
                            if counter1 = adults_text then
                                htp.prn('<option value="'||counter1||'" selected="selected">'||counter1||'</option>');
                            else
                                htp.prn('<option value="'||counter1||'">'||counter1||'</option>');
                            end if;
                        end loop;
                    htp.print('</select><br>
                    Children: <select name="children_in">');
                        for counter2 in 0..max_kids
                        loop
                            if counter2 = kids_text then
                                htp.prn('<option value="'||counter2||'" selected="selected">'||counter2||'</option>');
                            else
                                htp.prn('<option value="'||counter2||'">'||counter2||'</option>');
                            end if;
                        end loop;
                    htp.print('</select><br><br>
                    <input type="hidden" name="reservation_id_in" value="'||reservation_id_in||'">
                    <input type="hidden" name="customer_id_in" value="'||customer_id_text||'">
                    <input type="hidden" name="room_id_in" value="'||room_id_text||'">
                    <input type="submit" name="submit" value="Submit">
                </form>');
                htp.print('<form action="delete_reservation" method="post">
                    <input type="hidden" name="reservation_id_in" value="'||reservation_id_in||'">
                    <input type="submit" name="submit" value="Delete Reservation">
                </form>');
            htp.print('</section></section>
        </div>
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;