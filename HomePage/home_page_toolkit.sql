create or replace procedure home_page is
begin
  htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <html>
      <head>
          <title>Hotel Reservation System</title>
      </head>
      <div style="text-align:center;">
        <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
        <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
        <head><a href="show_current_reservations">Administration</a></head>
    </div>
  <title>Example Hotel Company</title>
  <body>
      <div style="text-align: center;">
          <h1>Example Hotel Company</h1>
          <p><h2>This will contain detail about the company.</h2>
          </p>
      </div>
  </body>
  </html>');
end;