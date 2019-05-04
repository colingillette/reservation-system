create or replace procedure room_picker
    (first_name_in varchar2,
    last_name_in varchar2,
    adults_in number,
    children_in number,
    arrival_in varchar2,
    depart_in varchar2,
    city_in varchar2,
    card_number_in varchar2,
    card_company_name_in varchar2,
    submit_button_in varchar2) IS
    room_no_text rooms.room_no%type;
    cursor room_cursor is
        select r.room_id, r.room_no, r.is_smoking, to_char(r.price, '$999.99') as price, r.fits_no_adults, r.fits_no_kids
        from rooms r, locations l
        where r.location_id = l.location_id
            and l.city = city_in;
    room_row room_cursor%rowtype;
    room_good boolean;
    arrival_in_date reservations.arrive_date%type;
    depart_in_date reservations.depart_date%type;
begin
    if check_for_customer(first_name_in, last_name_in, card_number_in, card_company_name_in) = false then
        create_customer(first_name_in, last_name_in, card_number_in, card_company_name_in);
    end if;
    
    arrival_in_date := to_date(arrival_in, 'yyyy/mm/dd');
    depart_in_date := to_date(depart_in, 'yyyy/mm/dd');

    htp.prn('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Room Selection</title>
    </head>
    <body>
        <div align="center"><p><h2>Example Rooms</h2></p>
            <!-- Navigation Bar Links -->
            <a href="">Home</a><br>
        <hr /></div>
        <!-- Start Page Content -->
        <form action="new_reservation" method="post" align="center">
            <p align="center"><b>Rooms Available</b></p> ');
            
             for room_row in room_cursor
             loop
                room_good := true;
        
                room_good := get_date_conflicts(room_row.room_id, depart_in_date, depart_in_date);
                
                if room_row.fits_no_adults < adults_in or room_row.fits_no_kids < children_in then
                    room_good := false;
                end if;
                
                if room_good = true then
                    htp.prn('<input type="radio" name="room_id_in" value="'||room_row.room_id||'"> 
                        Room '||room_row.room_no||'
                        Is Smoking: '||room_row.is_smoking||'
                        Price: '||room_row.price||' per night
                    <br>');
                end if;
             end loop;
             
             htp.prn('<input type="hidden" name="first_name_in" value="'||first_name_in||'">
                <input type="hidden" name="last_name_in" value="'||last_name_in||'">
                <input type="hidden" name="adults_in" value="'||adults_in||'">
                <input type="hidden" name="children_in" value="'||children_in||'">
                <input type="hidden" name="arrival_in" value="'||arrival_in_date||'">
                <input type="hidden" name="depart_in" value="'||depart_in_date||'">
                <input type="hidden" name="city_in" value="'||city_in||'">
                <input type="hidden" name="card_number_in" value="'||card_number_in||'">
                <input type="hidden" name="card_company_name_in" value="'||card_company_name_in||'">');
            
            htp.prn('<br /><br />
            <input type="submit" name="submit_button_in" value="Select Rooms"/>
        </form>
    <!-- End Page Content -->
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;
