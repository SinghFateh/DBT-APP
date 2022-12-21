
/*
    transaction view
*/

{{ config(materialized='view') }}

select id,amount
from test_schema.transaction


