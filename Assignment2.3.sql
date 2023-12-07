-- Assignment 2.3 Ex1
INSERT INTO terms (terms_id, terms_description, terms_due_days)
VALUES (6, 'Net due 120 days', 120);

-- Ex 2
UPDATE terms
SET terms_description = 'Net due 125 days',
    terms_due_days = 125
WHERE terms_id = 6;

-- Ex 3
DELETE FROM terms
WHERE terms_id =6;

-- Ex 4
INSERT INTO invoices
VALUES (NULL, 32, 'AX-014-027', '2018-08-01', 434.58, 0.00, 0.00, 2, '2018-08-31', NULL);

-- Ex 5 
INSERT INTO invoice_line_items
VALUES (LAST_INSERT_ID(),1,160,180.23,'Hard drive'), (LAST_INSERT_ID(),2,527,254.35,'Exchange Server Update');

-- Ex 5 hard coded
INSERT INTO invoice_line_items VALUES
    (115, 1, 160, 180.23, 'Hard drive'),
    (115, 2, 527, 254.35, 'Exchange Server update');

-- Ex 6 
UPDATE invoices
SET credit_total = (invoice_total*0.1),
    payment_total = (invoice_total - credit_total)
WHERE invoice_id = 115;

-- Ex 7 
UPDATE vendors
SET default_account_number = 403
WHERE vendor_id = 44;

-- Ex 8 
UPDATE invoices
SET terms_id = 2
WHERE vendor_id IN
    (SELECT vendor_id
     FROM vendors
     WHERE default_terms_id = 2);

-- Ex 9
DELETE FROM invoice_line_items
WHERE invoice_id = 115;
DELETE FROM invoices
WHERE invoice_id = 115;



    