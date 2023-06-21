CREATE TABLE customer (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE qualification (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  hourly_rate NUMERIC(10, 2) NOT NULL
);

CREATE TABLE position (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  hourly_rate NUMERIC(10, 2) NOT NULL
);

CREATE TABLE contract_category (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  hourly_rate_multiplier NUMERIC(10, 2) NOT NULL
);

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  position_id INTEGER NOT NULL REFERENCES position(id),
  qualification_id INTEGER NOT NULL REFERENCES qualification(id),
  daily_working_hours NUMERIC(5, 2) NOT NULL CHECK (daily_working_hours <= 10)
);

CREATE TABLE project (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  customer_id INTEGER NOT NULL REFERENCES customer(id),
  project_manager VARCHAR(255) NOT NULL,
  planned_duration INTEGER NOT NULL, -- in days
  complexity VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  contract_category_id INTEGER NOT NULL REFERENCES contract_category(id)
);

CREATE TABLE project_employee (
  project_id INTEGER NOT NULL REFERENCES project(id),
  employee_id INTEGER NOT NULL REFERENCES employee(id),
  PRIMARY KEY (project_id, employee_id)
);

CREATE TABLE work_log (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER NOT NULL REFERENCES employee(id),
  project_id INTEGER NOT NULL REFERENCES project(id),
  work_date DATE NOT NULL,
  hours_worked NUMERIC(5, 2) NOT NULL,
  activity TEXT
);

CREATE TABLE invoice (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customer(id),
  project_id INTEGER NOT NULL REFERENCES project(id),
  issue_date DATE NOT NULL,
  due_date DATE NOT NULL,
  amount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE salary (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER NOT NULL REFERENCES employee(id),
  month DATE NOT NULL,
  amount NUMERIC(10, 2) NOT NULL
);

CREATE SEQUENCE invoice_number_seq START 1000;

ALTER TABLE invoice
  ALTER COLUMN id SET DEFAULT nextval('invoice_number_seq');

   
