###  Installation and setup

### 1. Install homebrew on Mac if not installed already..
- /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### 2. Install DBT and postgres adapter ( you may choose other adapter as well )

- brew update
- brew install git
- brew tap dbt-labs/dbt
- brew install dbt-postgres
- dbt –version


### 3. Install postgres DB
- Download PostgreSQL (enterprisedb.com) – skip..additional tools


### 3.1 Note below Postgres configuration

- Installation Directory: /Library/PostgreSQL/15
- Server Installation Directory: /Library/PostgreSQL/15
- Data Directory: /Library/PostgreSQL/15/data
- Database Port: 5432
- Database Superuser: postgres
- Operating System Account: postgres
- Database Service: postgresql-15
- Command Line Tools Installation Directory: /Library/PostgreSQL/15
- pgAdmin4 Installation Directory: /Library/PostgreSQL/15/pgAdmin 4
- Installation Log: /tmp/install-postgresql.log

### 4 setup new DBT project
- cd CodeBase/DBT-App
- dbt init enrich_transaction

### 4 Setup connectivity between DBT and warehouse ( Postgres )
- cd /Users/fatsingh/.dbt
- vi profiles.yaml

enrich_transaction:
outputs:

    dev:
      type: postgres
      threads: 2
      host: 127.0.0.1
      port: 5432
      user: postgres
      pass: *****
      dbname: test_db
      schema: test_schema

### 4.1 check connectivity 
- dbt debug

### 5 create schema and table in postgres DB using Postgres admin UI
- #### 5.1 Create DB
- #### 5.2 Create schema
- #### 5.3 Create table

SQL:

    CREATE TABLE test_schema.transaction (id integer NOT NULL, 
    amount double precision,txn_date text,
    PRIMARY KEY (id) );

### 5.4 Grant permission to postgres user
SQL:

    ALTER TABLE IF EXISTS test_schema.transaction
    OWNER to postgres;

### 5.5 insert some sample data
SQL:

    insert into test_schema.transaction values (1,12/7/2022,100)

### 6 add model file in DBT project

- Add new .sql file in model directory
- use select commands to specify your view details as a select statement

Sample:

    {{ config(materialized='view') }}
    
    select id,amount
    from test_schema.transaction


### 6.1 specify all the model's schema in schema.yaml

Sample:

    - name: transaction_vw
      description: "raw transactions view"
      columns:
        - name: id
          type: integer
          description: "The primary key for this table"
          tests:
            - unique
            - not_null
        - name: amount
          description: "transaction amount"
          type: double
          tests:
            - not_null

###  7 execute DBT project's models :
- cd DBT-app/enrich_transaction
- dbt debug
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

