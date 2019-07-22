USE telco_churn;
SELECT customers.customer_id,customers.tenure,customers.monthly_charges,customers.total_charges FROM customers
JOIN contract_types AS contract ON (customers.contract_type_id=contract.contract_type_id)
WHERE contract.contract_type='Two year';