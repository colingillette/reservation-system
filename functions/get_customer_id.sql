create or replace function get_customer_id
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return number is
    customer_id_text customers.customer_id%type;
begin
    select customer_id
    into customer_id_text
    from customers
    where first = first_name_in
        and last = last_name_in
        and card_no = card_no_in
        and card_type = card_type_in;
    
    return customer_id_text;
end;