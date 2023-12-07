-- Assignment 4.2
-- Ex1
SELECT DISTINCT vendor_name
FROM Vendors
WHERE vendor_id IN (
    SELECT vendor_id
    FROM Invoices
)
ORDER BY vendor_name;

-- Ex2
SELECT invoice_number, invoice_total
FROM Invoices
WHERE payment_total > (
    SELECT AVG(payment_total)
    FROM Invoices
    WHERE payment_total > 0
)
ORDER BY invoice_total DESC;

-- Ex3 
SELECT account_number, account_description
FROM General_Ledger_Accounts
WHERE NOT EXISTS (
    SELECT 1
    FROM Invoice_Line_Items
    WHERE General_Ledger_Accounts.account_number = Invoice_Line_Items.account_number
)
ORDER BY account_number;

-- Ex4 
SELECT vendor_name, i.invoice_id, invoice_sequence, line_item_amount
FROM vendors v JOIN invoices i
  ON v.vendor_id = i.vendor_id
JOIN invoice_line_items li
  ON i.invoice_id = li.invoice_id
WHERE i.invoice_id IN
      (SELECT DISTINCT invoice_id
       FROM invoice_line_items               
       WHERE invoice_sequence > 1)
ORDER BY vendor_name, i.invoice_id, invoice_sequence;

-- Ex5 
SELECT SUM(invoice_max) AS sum_of_maximums
FROM (SELECT vendor_id, MAX(invoice_total) AS invoice_max
      FROM invoices
      WHERE invoice_total - credit_total - payment_total > 0
      GROUP BY vendor_id) t;

-- ex6 
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_state, vendor_city) NOT IN 
    (SELECT CONCAT(vendor_state, vendor_city) as vendor_city_state FROM vendors GROUP BY (vendor_state) HAVING COUNT(*) > 1)
ORDER BY vendor_state, vendor_city;

-- ex7 
SELECT
    V.vendor_name,
    I1.invoice_number,
    I1.invoice_date,
    I1.invoice_total
FROM Vendors V
LEFT JOIN Invoices I1 ON V.vendor_id = I1.vendor_id
WHERE I1.invoice_date = (
    SELECT MIN(invoice_date)
    FROM Invoices I2
    WHERE I2.vendor_id = V.vendor_id
)
ORDER BY V.vendor_name;



