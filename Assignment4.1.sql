-- Assignment4.1
-- Ex 1
SELECT vendor_id, SUM(invoice_total) AS total_invoice_amount
FROM invoices
GROUP BY vendor_id;

-- Ex 2
SELECT v.vendor_name, SUM(i.payment_total) AS sumtotal
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
GROUP BY v.vendor_id
ORDER BY sumtotal desc;

-- Ex 3
SELECT v.vendor_name, COUNT(i.invoice_id), SUM(i.invoice_total)
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
GROUP BY v.vendor_id
ORDER BY COUNT(i.invoice_id) DESC;

-- Ex 4
SELECT
    GLA.account_description,
    COUNT(ILI.account_number) AS item_count,
    SUM(ILI.line_item_amount) AS total_line_item_amount
FROM
    General_Ledger_Accounts GLA
JOIN
    Invoice_Line_Items ILI ON GLA.account_number = ILI.account_number
GROUP BY
    GLA.account_description
HAVING
    item_count > 1
ORDER BY 
	total_line_item_amount desc;

-- Ex 5 
SELECT account_description, COUNT(*) AS line_item_count,
       SUM(line_item_amount) AS line_item_amount_sum
FROM general_ledger_accounts gl 
  JOIN invoice_line_items li
    ON gl.account_number = li.account_number
  JOIN invoices i
    ON li.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING line_item_count > 1
ORDER BY line_item_amount_sum DESC;

-- Ex 6
SELECT
    account_number,
    SUM(line_item_amount) AS total_amount_invoiced
FROM
    Invoice_Line_Items
GROUP BY
    account_number WITH ROLLUP;
 
 -- Ex 7 
SELECT vendor_name,
       COUNT(DISTINCT li.account_number) AS number_of_gl_accounts
FROM vendors v 
  JOIN invoices i
    ON v.vendor_id = i.vendor_id
  JOIN invoice_line_items li
    ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING number_of_gl_accounts > 1
ORDER BY vendor_name;
    
-- Ex 8 
SELECT
    IF(GROUPING(terms_id) = 1, 'Grand Total', IFNULL(terms_id, 'Summary')) AS terms_id,
    IF(GROUPING(vendor_id) = 1, 'Total', IFNULL(vendor_id, 'Summary')) AS vendor_id,
    MAX(payment_date) AS last_payment_date,
    SUM(invoice_total - payment_total - credit_total) AS total_amount_due
FROM
    Invoices
GROUP BY
    terms_id, vendor_id WITH ROLLUP;




