create or replace procedure create_customer
    (first_in customers.first%type,
    last_in customers.last%type,
    card_no_in customers.card_no%type,
    card_type_in customers.card_type%type) is
begin
    insert into customers (customer_id, first, last, card_no, card_type)
        values (customer_id_seq.nextval, first_in, last_in, card_no_in, card_type_in);
    commit;
end;