-- Create the database
CREATE DATABASE datawarehousesql;

-- Start using the newly created database
USE datawarehousesql;

-- Create our layers schema (bronze, silver, and gold)
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

-- The schemas are now created. You can verify by navigating to datawarehousesql>securities>schema.



