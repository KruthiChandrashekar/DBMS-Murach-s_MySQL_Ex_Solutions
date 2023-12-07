SELECT *
FROM vendors
JOIN invoices
ON vendors.vendor_id = invoices.vendor_id;

-- Ex2 
SELECT vendor_name, invoice_number, invoice_date,
       invoice_total - payment_total - credit_total AS balance_due
FROM vendors v 
JOIN invoices i
  ON v.vendor_id = i.vendor_id
WHERE invoice_total - payment_total - credit_total <> 0
ORDER BY vendor_name;

-- Ex3
SELECT v.vendor_name, v.default_account_number 'default_account', g.account_description 'description'
FROM vendors v
JOIN general_ledger_accounts g
ON v.default_account_number = g.account_number
ORDER BY account_description, vendor_name;

-- Ex4
SELECT v.vendor_name, i.invoice_date,  i.invoice_number, l.invoice_sequence 'li_sequence', l.line_item_amount 'li_amount'
FROM invoices i
JOIN vendors v
USING (vendor_id)
JOIN invoice_line_items l
USING (invoice_id)
ORDER BY v.vendor_name, i.invoice_date, i.invoice_number, l.invoice_sequence;

-- Ex5
SELECT v.vendor_id, v.vendor_name, CONCAT(v.vendor_contact_first_name, ' ', v.vendor_contact_last_name)
FROM vendors
JOIN vendors v
WHERE ((vendors.vendor_id != v.vendor_id) AND (vendors.vendor_contact_last_name = v.vendor_contact_last_name))
ORDER BY v.vendor_contact_last_name;

-- Ex6
SELECT 
    gla.account_number,
    gla.account_description,
    ili.invoice_id
FROM 
    General_Ledger_Accounts gla
LEFT JOIN 
    Invoice_Line_Items ili
ON 
    gla.account_number = ili.account_number
WHERE 
    ili.invoice_id IS NULL
ORDER BY
     gla.account_number;
    
-- Ex7 CHECK
  SELECT vendor_name, vendor_state
  FROM vendors
  WHERE vendor_state = 'CA'
UNION
  SELECT vendor_name, 'Outside CA'
  FROM vendors
  WHERE vendor_state <> 'CA'
ORDER BY vendor_name






