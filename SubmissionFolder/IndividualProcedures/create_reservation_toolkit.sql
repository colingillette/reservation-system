create or replace procedure Create_New_Reservation as 
    cursor location_cursor is 
        select city
        from locations;
    location_row location_cursor%rowtype;
begin 
htp.print('<!DOCTYPE HTML PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>Create New Reservation</title>
    </head>
    <div style="text-align:center;">
        <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
        <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
        <head><a href="show_current_reservations">Administration</a></head>
    </div>
    <hr>
<body>
    <h1 style="text-align:center">Create Reservation</h1>
    <script>
          function amexnumber(cardnumber) {
    var cardno = /^(?:3[47][0-9]{13})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid American Express card number!");
        return false;
    }
}

function visanumber(cardnumber) {
    var cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Visa credit card number!");
        return false;
    }
}
function masternumber(cardnumber) {
    var cardno = /^(?:5[1-5][0-9]{14})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Master card number!");
        return false;
    }
}
function discovernumber(cardnumber) {
    var cardno = /^(?:6(?:011|5[0-9][0-9])[0-9]{12})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Discover card number!");
        return false;
    }
}
        </script>
        <script>
        function checkcard(){
        var selectedtyp = document.getElementById("selecttype").value;
        var cardnumer = document.form1.cardnum;
        if (selectedtyp === "American Express"){
        return amexnumber(cardnumer);
        }else if(selectedtyp === "MasterCard"){
        return masternumber(cardnumer);
        } else if (selectedtyp ==="Discover"){
        return discovernumber(cardnumer);
        }else{
        return visanumber(cardnumer);
        }
        }
      </script>

    <form action="room_picker" method="post" align="center" name ="form1" id ="form1" onsubmit="return checkcard()">
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
        <input type="date" name="arrival_in" id="arrival_in" style="margin-top: 15px"><br>
        <script>
        var today = new Date().toISOString().split("T")[0];
    document.getElementsByName("arrival_in")[0].setAttribute("min", today);
        </script>
        Departure Date:
        <input type="date" name="depart_in" style="margin-top: 15px"><br>
        <script>
        var today = new Date().toISOString().split("T")[0];
    document.getElementsByName("depart_in")[0].setAttribute("min", today);
        </script>
        Location:
        <select style="margin-top:15px" name="city_in"> ');
            for location_row in location_cursor
            loop
                htp.prn('<option value="'||location_row.city||'">'||location_row.city||'</option>');
            end loop;
        htp.print('</select><br>
        Card Number:
        <input type="text" name="card_number_in" id ="cardnum" style="margin-top: 15px" placeholder="1234567891012345"><br>
        Card Company:
        <select style="margin-top:15px;margin-bottom:15px;" name="card_company_name_in" id ="selecttype">
            <option value="Visa">Visa</option>
            <option value="MasterCard">MasterCard</option>
            <option value="Discover">Discover</option>
            <option value="American Express">American Express</option>
        </select><br>
        <input type="submit" name="submit_button_in" value="Proceed"/>
     </form>
    
    <p style="text-align:center;">Valid card numbers for each company start with these numbers:</p>
    <div align="center">
        <table>
            <tr>
                <th>Card Company</th>
                <th>Starts With</th>
            </tr>
            <tr>
                <td>American Express</td>
                <td>3</td>
            </tr>
            <tr>
                <td>Visa</td>
                <td>4</td>
            </tr>
            <tr>
                <td>Mastercard</td>
                <td>5</td>
            </tr>
            <tr>
                <td>Discover</td>
                <td>6</td>
            </tr>
        </table>
    </div>
</body>
</html>
');
exception
when others then
htp.prn(sqlerrm);
end;