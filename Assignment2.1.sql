SELECT vendor_name, vendor_contact_last_name , vendor_contact_first_name 
FROM vendors
ORDER BY vendor_contact_last_name,vendor_contact_first_name;

-- Assignment 2-9
SELECT CONCAT(vendor_contact_last_name, ", ", vendor_contact_first_name) AS full_name
FROM vendors
WHERE vendor_contact_last_name LIKE 'A%'
OR vendor_contact_last_name LIKE 'B%'
OR vendor_contact_last_name LIKE 'C%'
OR vendor_contact_last_name LIKE 'E%'
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

-- Assignment2-10
SELECT invoice_due_date 'Due Date', 
       invoice_total 'Invoice Total', 
       (invoice_total*0.1) '%10', 
       (invoice_total*1.1)'Plus 10%'
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;

-- Assignment2-11
SELECT invoice_number, 
       invoice_total, 
       (payment_total+credit_total) 'payment_credit_total', 
       (invoice_total-(payment_total+credit_total))'balance_due'
FROM invoices
WHERE (invoice_total-(payment_total+credit_total)) >50
ORDER BY (invoice_total-(payment_total+credit_total)) DESC
LIMIT 5;

-- Assignment2-12
SELECT invoice_number, 
       invoice_date, 
       (invoice_total-(payment_total+credit_total))'balance_due',
       payment_date 
FROM invoices
WHERE payment_date is NULL;

-- Assignment2-13 
SELECT DATE_FORMAT(CURRENT_DATE, '%m-%d-%Y') AS "current_date";

-- Assignment2-14
SELECT
  50000 AS starting_principal,
  50000 * 0.065 AS interest,
  50000 + (50000 * 0.065) AS principal_plus_interest;

