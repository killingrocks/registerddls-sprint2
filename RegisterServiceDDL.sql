CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  price int NOT NULL DEFAULT(0),
  quantity int NOT NULL DEFAULT(0),
  active boolean NOT NULL DEFAULT(FALSE),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");
  
INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 50 
     , 10
     , true
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode2'
     , 100
     , 2
     , false
     , current_timestamp
);

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE), 
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);


INSERT INTO employee VALUES (
       uuid_generate_v4()
     , 'rystewar'
     , 'Ryan'
     , 'Stewart'
     , 'wait'
     , false
     , 3
     , uuid_generate_v4()
     , current_timestamp
);

CREATE TABLE transactionentity (
 id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  price int NOT NULL DEFAULT(0),
  quantity int NOT NULL DEFAULT(0),
   CONSTRAINT record_transactionentity PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE transaction (
  id uuid NOT NULL,
  cashierid character varying(32) NOT NULL DEFAULT(''),
  totalamount int NOT NULL DEFAULT(0),
  transactiontype int NOT NULL DEFAULT(0),
  referenceid uuid NOT NULL,
  CONSTRAINT reference_cashieried FOREIGN KEY(referenceid)
	REFERENCES transaction (id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT record_transaction PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
INSERT INTO transaction VALUES (
       '00000000-0000-0000-0000-000000000000'
     , 'same'
     , '100'
     , '0'
     , '00000000-0000-0000-0000-000000000000'
	 , current_timestamp
);