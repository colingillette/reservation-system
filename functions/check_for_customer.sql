-- At work. Currently not tested

create or replace function check_for_customer
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return boolean is
    cursor customer_cursor is
        select first, last, card_no, card_type
        from customers;
    customer_row customer_cursor%rowtype;
begin
    for customer_row in customer_cursor
    loop
        if customer_row.first = first_name_in and customer_row.last = last_name_in and customer.card_no = card_no_in and customer_row.card_type = card_type_in then
            return true;
        end if;
    end loop;

    return false;
end;