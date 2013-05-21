
-- -------------------------------
-- TABLES
-- -------------------------------

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS taxons;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS variants;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS payments_methods;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS inventory_units;
DROP TABLE IF EXISTS line_items;
DROP TABLE IF EXISTS images;

CREATE TABLE products (
  id               integer(11)   NOT NULL AUTO_INCREMENT,
  name             varchar(127)  NOT NULL,
  description      text          NOT NULL,
  permalink        varchar(255),
  meta_description text,
  meta_keywords    text,
  count_on_hand    integer(11)            DEFAULT 0,
  safety_stock     integer(11)            DEFAULT 10,  
  available_on     datetime               DEFAULT '0000-00-00 00:00:00',
  deleted_at       datetime               DEFAULT '0000-00-00 00:00:00',
  created_at       datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at       timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  taxon_id         integer(11)   REFERENCES taxons, 

  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Products';

-- Taxons
DROP SYNONYM IF EXISTS taxons_fr;
DROP VIEW IF EXISTS taxons_view;
CREATE TABLE taxons (
  id               integer(11)   NOT NULL AUTO_INCREMENT,
  name             varchar(127)  NOT NULL,
  position         integer(3)    NOT NULL,
  permalink        varchar(255)  NOT NULL,
  lft              integer(3)    NOT NULL,
  rgt              integer(3)    NOT NULL,
  description      text          NOT NULL,
  hidden           boolean       NOT NULL DEFAULT 0,
  home_page        boolean       NOT NULL DEFAULT 0,
  short_name       varchar(63)   NOT NULL,

  PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Taxons';

CREATE TABLE users (
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  email                 varchar(127)  NOT NULL,
  encrypted_password    varchar(127)  NOT NULL,
  password_salt         varchar(127)  NOT NULL,
  remember_token        varchar(127)  NOT NULL,
  created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  persistence_token     varchar(172)  NOT NULL,
  reset_password_token  VARCHAR(100)  NOT NULL,
  perishable_token      varchar(100)  NOT NULL,
  sign_in_count         integer(11)   NOT NULL,
  failed_attempts       integer(11)   NOT NULL,
  last_request_at       datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  last_sign_in_at       datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  lasts_sign_in_ip      varchar(100)  NOT NULL,
  login                 varchar(100)  NOT NULL,
  authentification_token varchar(100) NOT NULL,
  unlock_token          varchar(90)   NOT NULL,
  locked_at             datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  

  PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Users';

CREATE TABLE orders (
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  item_total            decimal(5)    NOT NULL,
  total                 decimal(5)    NOT NULL,
  created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  state                 varchar(100)  NOT NULL,
  adjustement_total     decimal(5)    NOT NULL,
  credit_total          decimal(5)    NOT NULL,
  completed_at          datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  payment_total         decimal(5)    NOT NULL,
  user_id               integer(11)   REFERENCES users,
  address_id             integer(11)   REFERENCES address,

  PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Orders';

CREATE TABLE variants (
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  sku                   varchar(20)   NOT NULL,
  price                 decimal(5)    NOT NULL,
  weight                decimal(5)    NOT NULL,  
  height                decimal(5)    NOT NULL,
  width                 decimal(5)    NOT NULL,
  depth                 decimal(5)    NOT NULL,
  deleted_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_master             boolean,
  count_on_hand         integer(5)    NOT NULL,
  cost_price            decimal(5)    NOT NULL,
  position              integer(5)    NOT NULL,
  product_id            integer(11)   NOT NULL REFERENCES product,

 PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Variants';

CREATE TABLE payments (
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  amount                decimal(5)    NOT NULL,
  state                 varchar(50)   NOT NULL,
  response_code         varchar(50)   NOT NULL,
  avs_response          varchar(50)   NOT NULL,

 PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Payments';

CREATE TABLE payments_methods(
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  type                  varchar(50)   NOT NULL,
  name                  varchar(50)   NOT NULL,
  description           varchar(260)   NOT NULL,
  active                boolean       NOT NULL,
  created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
 display_on             varchar(50)   NOT NULL, 
  payments_id           integer(11)   REFERENCES payments,
PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Payments Methods';

CREATE TABLE addresses (
  id                    integer(11)   NOT NULL AUTO_INCREMENT,
  firstname             varchar(50)   NOT NULL,
  lastname              varchar(50)   NOT NULL,  
  address1              varchar(50)   NOT NULL,  
  address2              varchar(50)   NOT NULL,  
  city                  varchar(30)   NOT NULL,  
  state                 varchar(30)   NOT NULL,  
  zipcode               varchar(20)   NOT NULL,  
  country               varchar(25)   NOT NULL,  
  phone                 varchar(20)   NOT NULL,  
  created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
  updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Addresses';

CREATE TABLE shipments (
    id                    integer(11)   NOT NULL AUTO_INCREMENT,
    tracking              varchar(50)   NOT NULL,
    created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
    updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    number                varchar(60)   NOT NULL,
    cost                  decimal(5)    NOT NULL,
    shipped_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
    state                 varchar(40)   NOT NULL,
    address_id            integer(11)   REFERENCES addresses,
    order_id              integer(11)   REFERENCES orders,

PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Shipments';

CREATE TABLE inventory_units (
    id                    integer(11)   NOT NULL AUTO_INCREMENT,
    state                 VARCHAR(40)   NOT NULL,
    lock_version          integer(11)   NOT NULL DEFAULT 0,
    created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
    updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    variant_id            integer(10)   REFERENCES variants,
    order_id              integer(10)   REFERENCES orders,
    shipment_id           integer(10)   REFERENCES shipments,
PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Inventorys Units';

CREATE TABLE line_items (
    id                    integer(11)   NOT NULL AUTO_INCREMENT,
    quantity              integer(50),
    price                 decimal(5),
    created_at            datetime      NOT NULL DEFAULT '0000-00-00 00:00:00',
    updated_at            timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    order_id              integer(10)   REFERENCES orders,
    variant_id            integer(10)   REFERENCES variants,

PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Line Items';

CREATE TABLE images (
  id               integer(11)   NOT NULL AUTO_INCREMENT,
  alt_text         text          NOT NULL,
  position         integer(3)    NOT NULL,
  product_id       integer(11)   NOT NULL REFERENCES product,

  PRIMARY KEY (id)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ecommerce Images';

-- -------------------------------
-- SYNONYMS
-- -------------------------------

DROP SYNONYM IF EXISTS products_fr;
DROP SYNONYM IF EXISTS taxons_fr;
DROP SYNONYM IF EXISTS users_fr;
DROP SYNONYM IF EXISTS orders_fr;
DROP SYNONYM IF EXISTS variants_fr;
DROP SYNONYM IF EXISTS payments_fr;
DROP SYNONYM IF EXISTS payments_methods_fr;
DROP SYNONYM IF EXISTS addresses_fr;
DROP SYNONYM IF EXISTS shipments_fr;
DROP SYNONYM IF EXISTS inventory_units_fr;
DROP SYNONYM IF EXISTS line_items_fr;
DROP SYNONYM IF EXISTS images_fr;

CREATE SYNONYM products_fr FOR products@ecommerce.fr;
CREATE SYNONYM taxons_fr FOR products@ecommerce.fr;
CREATE SYNONYM users_fr FOR users@ecommerce.fr;
CREATE SYNONYM orders_fr FOR orders@ecommerce.fr;
CREATE SYNONYM variants_fr FOR variants@ecommerce.fr;
CREATE SYNONYM payments_fr FOR payments@ecommerce.fr;
CREATE SYNONYM payment_methods_fr FOR payment_methods@ecommerce.fr;
CREATE SYNONYM addresses_fr FOR addresses@ecommerce.fr;
CREATE SYNONYM shipments_fr FOR shipments@ecommerce.fr;
CREATE SYNONYM inventory_units_fr FOR inventory_units@ecommerce.fr;
CREATE SYNONYM line_items_fr FOR line_items@ecommerce.fr;
CREATE SYNONYM images_fr FOR images@ecommerce.fr;

-- -------------------------------
-- VIEWS
-- -------------------------------

DROP VIEW IF EXISTS products_view;
DROP VIEW IF EXISTS products_view;
DROP VIEW IF EXISTS taxons_view;
DROP VIEW IF EXISTS users_view;
DROP VIEW IF EXISTS orders_view;
DROP VIEW IF EXISTS variants_view;
DROP VIEW IF EXISTS payments_view;
DROP VIEW IF EXISTS payments_methods_view;
DROP VIEW IF EXISTS addresses_view;
DROP VIEW IF EXISTS shipments_view;
DROP VIEW IF EXISTS inventory_units_view;
DROP VIEW IF EXISTS line_items_view;
DROP VIEW IF EXISTS images_view;

CREATE VIEW   products_view AS
SELECT * FROM products UNION 
SELECT * FROM products_fr;

CREATE VIEW   taxons_view AS
SELECT * FROM taxons UNION 
SELECT * FROM taxons_fr;

CREATE VIEW   users_view AS
SELECT * FROM users UNION 
SELECT * FROM users_fr;

CREATE VIEW   orders_view AS
SELECT * FROM orders UNION 
SELECT * FROM orders_fr;

CREATE VIEW   variants_view AS
SELECT * FROM variants UNION 
SELECT * FROM variants_fr;

CREATE VIEW   payments_view AS
SELECT * FROM payments UNION 
SELECT * FROM payments_fr;

CREATE VIEW   payment_methods_view AS
SELECT * FROM payment_methods UNION 
SELECT * FROM payment_methods_fr;

CREATE VIEW   addresses_view AS
SELECT * FROM addresses UNION 
SELECT * FROM addresses_fr;

CREATE VIEW   shipments_view AS
SELECT * FROM shipments UNION 
SELECT * FROM shipments_fr;

CREATE VIEW   inventory_units_view AS
SELECT * FROM inventory_units UNION 
SELECT * FROM inventory_units_fr;

CREATE VIEW   line_items_view AS
SELECT * FROM line_items UNION 
SELECT * FROM line_items_fr;

CREATE VIEW   images_view AS
SELECT * FROM images UNION 
SELECT * FROM images_fr;
