/*
  The following can be used to remove all items related to the database.

  If you want to re-add these, use master.sql
*/

DROP TRIGGER prevent_duplicate_res_insert;

DROP TABLE reservations;
DROP TABLE rooms;
DROP TABLE locations;
DROP TABLE customers;

DROP SEQUENCE customer_id_seq;
DROP SEQUENCE location_id_seq;
DROP SEQUENCE room_id_seq;
DROP SEQUENCE reservation_id_seq;

DROP FUNCTION check_for_customer;
DROP FUNCTION get_customer_id;
DROP FUNCTION get_date_conflicts;
DROP FUNCTION get_room_number;
DROP FUNCTION max_people;

DROP PROCEDURE create_customer;
DROP PROCEDURE create_new_reservation;
DROP PROCEDURE delete_reservation;
DROP PROCEDURE edit_reservation;
DROP PROCEDURE edit_reservation_response;
DROP PROCEDURE home_page;
DROP PROCEDURE new_reservation;
DROP PROCEDURE room_picker;
DROP PROCEDURE show_current_reservations;