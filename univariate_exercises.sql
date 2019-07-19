USE telco_churn;
SELECT customers.customer_id,customers.tenure,customers.total_charges FROM customers
JOIN contract_types ON (customers.contract_type_id=contract_types.contract_type_id);