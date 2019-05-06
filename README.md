# Reservation System Project

## Home Page

This project starts with a home page. This page will have some generic info about chain of small hotels. The user can choose to either **create a reservation** or **edit a current reservation**. At the bottom there will also be instructions for showing the web toolkit in the browser for Colin's benefit, called **Colin's Notes**

## Reservation Creation Track

This track will allow the user to create a new reservation. The procedure or procedures involved in each step will be listed in parentheses to the right of the item.

### Create a Reservation (create_reservation)

The user will get to a **Create Reservation** page, where they can first input the following information:
* First Name
* Last Name
* Card Number
* Card Company/Type
* Number of adults staying in room
* Number of children staying in room
* Location of city they will be staying in
* Arrival Date: the date they will first get to the hotel
* Departure Date: the date they will leave the hotel
* Whether they prefer smoking or non-smoking

If the customer first name, last name, card number, and card type does not already exist as a customer entry, we will create a new customer entry. Otherwise we will use the customer_id that already exists in future pages.

### Room Picker (room_picker and create_customer)

This page will either display a generated list of rooms that are available considering the previously input specifications, or it will tell the user that nothing is available given the current parameters. It would then tell the user to go back to the previous page, and give them a link to do so.

If there is at least one room available for these specifications, we will display radio options for each room. Each room will display:
* Room Number (**Note:** This is different than the room_id)
* Either the words "Smoking" or "Non-Smoking"
* The price per-night

The page will also store all variables from the previous page as input fields with the *hidden* attribute.

### Reservation Response (new_reservation)

This page will show confirmation of the reservation that has been created to the user. This page will also contain the SQL that inserts the reservation row into the database.

## Edit Reservation Track

This track will allow the user to edit a current reservation

### List Current Reservations (show_current_reservation)

This page will list all current reservations organized by location, and sorted by arrival date. A reservation is considered current if the depart date is later than the **sysdate**. Each reservation will list the following information:
* Customer name
* Room number
* An *S* for smoking or an *N* for non-smoking
* The price per night
* The arrival date
* The departure date

### Edit Reservation (edit_reservation)

This page will show all of the available information for the reservation, along with a button to submit edits and a button to delete the resrvation. The following fields will be editable (**Note:** changes will be rejected if they violate the logic of the DB):
* Customer name
* Card number
* Card company/type
* Arrival date
* Departure date
* Number of Adults (only the max for the room will be shown)
* Number of kids (only the max for the room will be shown)

The page will show these fields that will not be editable, locked by a *readonly* tag:
* Location
* Room number
* Reservation number
* Price per night

### Edit Reservation Response (edit_reservation_response and create_customer)

If everything is valid in these changes, they will be made. Otherwise this screen will show a message saying as such. If the changes are valid, the **UPDATE** statement will happen here.

## Colin's Notes

### Show web toolkit in browser

1. Run the following in SQL Developer

> begin
> dbms_epg.create_dad('xepsp','/xepsp/*');
> end;

2. Run the create procedure statement if not done already.

3. In browser, navigate to **127.0.0.1:8080/xepsp/*procedure_name***