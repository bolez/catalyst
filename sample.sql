
USE ROLE ACCOUNTADMIN;
GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER5;
GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER5 WITH GRANT OPTION;

use role orgadmin;
SELECT SYSTEM$IS_GLOBAL_DATA_SHARING_ENABLED_FOR_ACCOUNT('PQ57060');

USE ROLE ACCOUNTADMIN;
SELECT SYSTEM$ENABLE_GLOBAL_DATA_SHARING_FOR_ACCOUNT(

'PQ57060'
);


GRANT MANAGE LISTING AUTO FULFILLMENT ON ACCOUNT TO ROLE ACCOUNTADMIN;





---------
CREATE OR REPLACE PROCEDURE GB.OPS.onboarding(domain varchar, product varchar)
RETURNS VARCHAR(16777216)
LANGUAGE PYTHON
RUNTIME_VERSION = '3.9'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'main'

AS '

def main(session, domain, product):
    role_name = f"{domain}_engginer"
    role_create = f"create role if not EXISTS {role_name}"
    session.sql(role_create).collect()
    
    user_grant = f"GRANT ROLE {role_name} TO USER gauravsnow;"
    session.sql(user_grant).collect()
    
    db_grant = f"grant create database on account to role {role_name};"
    session.sql(db_grant).collect()
    
    wh = f"""CREATE OR REPLACE WAREHOUSE {domain}_wh WITH WAREHOUSE_SIZE="X-SMALL";"""
    session.sql(wh).collect()
    wh_grant = f"grant usage on warehouse {domain}_wh to role {role_name};"
    session.sql(wh_grant).collect()
    
    share_grants = f"GRANT CREATE SHARE ON ACCOUNT TO ROLE {role_name};"
    session.sql(share_grants).collect()
    grant_list = f"GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE {role_name};"
    session.sql(grant_list).collect()
    
    grant_option = f"GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE {role_name} WITH GRANT OPTION;"
    session.sql(grant_option).collect()
    #session.sql(f"USE ROLE {role_name};").collect()
    #session.sql(f"create or replace database {domain}_db;").collect()
    #session.sql(f"create or replace schema {domain}_db.{product};").collect()
    #session.sql(f"GRANT ALL PRIVILEGES ON DATABASE {domain}_db TO ROLE {role_name}").collect()
    #session.sql(f"GRANT ALL PRIVILEGES ON SCHEMA {domain}_db.{product} TO ROLE {role_name}").collect()

';
use role accountadmin;
call  GB.OPS.onboarding('demo_gb12', 'dbg12');
show grants on database demo_database_db;

use role accountadmin;
use role demo_gb12_engginer;
GRANT MANAGE LISTING AUTO FULFILLMENT ON ACCOUNT TO ROLE demo_gb12_engginer;
create database demo_gb12_db;
create schema dbg12;
GRANT OWNERSHIP ON DATABASE demo_d_db TO ROLE demo_d_engginer
REVOKE CURRENT GRANTS;

GRANT OWNERSHIP ON SCHEMA demo_d_db.demo_p TO ROLE demo_d_engginer
REVOKE CURRENT GRANTS;

use role test_dom_engginer;


select * from demo_gb_db.dbg.customer_nation;

----------------
M9ZL7B17BEZA91RXDKQJ79NM

https://coin.zerodha.com/mf/fund/INF754K01JN6/edelweiss-small-cap-fund-direct-growth




create database d1;
USE DATABASE d1;

CREATE DATABASE ROLE r1;

CREATE DATABASE ROLE r2;

create schema s1;
GRANT USAGE ON SCHEMA d1.s1 TO DATABASE ROLE d1.r1;
CREATE VIEW v1 AS 
SELECT CURRENT_DATE() AS today_date;

GRANT SELECT ON VIEW d1.s1.v1 TO DATABASE ROLE d1.r1;


GRANT USAGE ON SCHEMA d1.s1 TO DATABASE ROLE d1.r2;
CREATE VIEW v2 AS 
SELECT CURRENT_DATE() AS today_date;
GRANT SELECT ON VIEW d1.s1.v2 TO DATABASE ROLE d1.r2;

SHOW GRANTS TO DATABASE ROLE d1.r1;
SHOW GRANTS TO DATABASE ROLE d1.r2;

CREATE SHARE share1;
create role gb;
GRANT CREATE SHARE ON ACCOUNT TO ROLE gb;
GRANT USAGE ON DATABASE d1 TO ROLE gb;
GRANT USAGE ON SCHEMA d1.s1 TO ROLE gb;
GRANT SELECT ON view d1.s1.v1 TO ROLE gb;
use role gb;

GRANT ROLE gb TO USER gauravsnow;
create share gbd;
CREATE OR REPLACE SHARE allow_non_secure_views
 SECURE_OBJECTS_ONLY=FALSE;
use role accountadmin;
grant database role r2 to role gb;
show grants to role gb;
GRANT USAGE ON DATABASE d1 TO SHARE ALLOW_NON_SECURE_VIEWS;
SHOW GRANTS ON DATABASE d1;

GRANT SELECT ON view d1.s1.v1 TO SHARE allow_non_secure_views;

GRANT USAGE ON DATABASE d1 TO ROLE gb WITH GRANT OPTION;
GRANT USAGE ON schema d1.s1 TO ROLE gb WITH GRANT OPTION;
GRANT SELECT ON view d1.s1.v1 TO ROLE gb WITH GRANT OPTION;
SHOW OBJECTS IN SHARE 'ALLOW_NON_SECURE_VIEWS';
DESC SHARE ALLOW_NON_SECURE_VIEWS;

GRANT CREATE SHARE ON ACCOUNT TO ROLE gb;
use role accountadmin;
use role gb;
grant create DATA EXCHANGE LISTING to role gb;
CREATE EXTERNAL LISTING SHARED_AND_REPLICATED
SHARE ALLOW_NON_SECURE_VIEWS AS
$$
   title: "weather data"
   description: "Listing containing weather data for all zipcodes in America"
   listing_terms:
     type: "OFFLINE"
   targets:
     accounts: ["ik00045"]
   auto_fulfillment:
     refresh_type: SUB_DATABASE
     refresh_schedule: '10 MINUTE'
$$;
SELECT SYSTEM$IS_GLOBAL_DATA_SHARING_ENABLED_FOR_ACCOUNT(
  'ik00045.ap-southeast-1'
  );
GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE gb;
GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE gb WITH GRANT OPTION;
https://ik00045.ap-southeast-1.snowflakecomputing.com
show grants to role gb;


CREATE ORGANIZATION LISTING ORG_LISTING
SHARE ALLOW_NON_SECURE_VIEWS AS
$$
title : 'My title'
organization_profile: INTERNAL
organization_targets:
    access:
    - all_accounts : false 
locations:
  access_regions:
  - name: "ALL"
auto_fulfillment:
  refresh_type: "SUB_DATABASE"
  refresh_schedule: "10 MINUTE"
$$;



USE ROLE ACCOUNTADMIN;
CREATE ROLE ORG_LISTING_PROVIDER3;
GRANT ROLE ORG_LISTING_PROVIDER3 TO USER gauravsnow;
GRANT CREATE SHARE ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER3;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER3;

USE ROLE ORG_LISTING_PROVIDER3;
CREATE OR REPLACE DATABASE DEVORGDB2;
USE DATABASE DEVORGDB2;
CREATE SHARE ORG_SHARE2 SECURE_OBJECTS_ONLY=FALSE;
GRANT USAGE ON DATABASE DEVORGDB2 TO SHARE ORG_SHARE2;
GRANT USAGE ON SCHEMA PUBLIC TO SHARE ORG_SHARE2;
CREATE OR REPLACE TABLE TUTORIAL_TABLE ( item_id INT, item_name STRING );
GRANT SELECT ON TABLE DEVORGDB2.PUBLIC.TUTORIAL_TABLE TO SHARE ORG_SHARE2;
INSERT INTO TUTORIAL_TABLE (item_id, item_name) VALUES (1,'Tutorial table');
create or replace warehouse foundational_wh with warehouse_size = xsmall;
grant usage on warehouse foundational_wh to role ORG_LISTING_PROVIDER3;

USE ROLE orgadmin;
GRANT MANAGE LISTING AUTO FULFILLMENT ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER;
use role ORG_LISTING_PROVIDER;
USE ROLE ORG_LISTING_PROVIDER;
SHOW ORGANIZATION ACCOUNTS;
use role orgadmin;
SHOW ORGANIZATION ACCOUNTS;

SELECT SYSTEM$IS_GLOBAL_DATA_SHARING_ENABLED_FOR_ACCOUNT('ZLUQRAP');
USE ROLE ACCOUNTADMIN;

GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER3;
GRANT CREATE DATA EXCHANGE LISTING ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER3 WITH GRANT OPTION;
use role ORG_LISTING_PROVIDER;
USE ROLE ORG_LISTING_PROVIDER3;
create data EXCHANGE LISTING;
SHOW GRANTS OF MANAGE LISTING AUTOFULFILLMENT;
SELECT SYSTEM$IS_GLOBAL_DATA_SHARING_ENABLED_FOR_ACCOUNT('TB69321');
SHOW ORGANIZATION ACCOUNTS;
SHOW ACCOUNTS;
SELECT SYSTEM$IS_GLOBAL_DATA_SHARING_ENABLED_FOR_ACCOUNT('TB69321');
CALL SYSTEM$ENABLE_GLOBAL_DATA_SHARING_FOR_ACCOUNT('TB69321');
USE ROLE ACCOUNTADMIN;
GRANT MANAGE LISTING AUTO FULFILLMENT ON ACCOUNT TO ROLE ORG_LISTING_PROVIDER3;


CREATE ORGANIZATION LISTING ORG_LISTING
SHARE ORG_SHARE2 AS
$$
title : 'My title'
organization_profile: INTERNAL
organization_targets:
    access:
    - all_accounts : false 
locations:
  access_regions:
  - name: "ALL"
auto_fulfillment:
  refresh_type: "SUB_DATABASE"
  refresh_schedule: "10 MINUTE"
$$;

-- https://docs.snowflake.com/en/user-guide/collaboration/listings/organizational/org-listing-auto-fulfillment

-- https://docs.snowflake.com/en/user-guide/collaboration/listings/organizational/org-listing-tutorial
