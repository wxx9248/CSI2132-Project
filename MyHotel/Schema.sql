CREATE TABLE customer
(
    id                   INT,
    full_name            VARCHAR(64)  NOT NULL,
    sin_number           VARCHAR(9)   NOT NULL,
    address              VARCHAR(128) NOT NULL,
    date_of_registration DATE         NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE employee
(
    id         INT,
    full_name  VARCHAR(64)  NOT NULL,
    sin_number VARCHAR(9)   NOT NULL,
    address    VARCHAR(128) NOT NULL,
    salary     NUMERIC(8, 2) DEFAULT 0.00,
    role       VARCHAR(64)  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE hotel_brand
(
    hotel_brand_name     VARCHAR(64),
    main_office_location VARCHAR(128) NOT NULL,
    physical_address     VARCHAR(128) NOT NULL,
    --email_address
    --phone_number
    total_phone_number   VARCHAR(16)  NOT NULL,
    PRIMARY KEY (hotel_brand_name)
);

CREATE TABLE hotel_brand_email_address
(
    hotel_brand_name VARCHAR(64),
    email_address    VARCHAR(32) NOT NULL,
    PRIMARY KEY (hotel_brand_name),
    FOREIGN KEY (hotel_brand_name) REFERENCES hotel_brand (hotel_brand_name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE hotel_brand_phone_number
(
    hotel_brand_name VARCHAR(64),
    phone_number     VARCHAR(16) NOT NULL,
    PRIMARY KEY (hotel_brand_name),
    FOREIGN KEY (hotel_brand_name) REFERENCES hotel_brand (hotel_brand_name) ON UPDATE CASCADE ON DELETE CASCADE
);

-- TODO: May tighten the constraint of the "email" column
CREATE TABLE hotel
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    star_category    INT DEFAULT 0,
    number_of_rooms  INT DEFAULT 0,
    address          VARCHAR(128) NOT NULL,
    email_address    VARCHAR(32)  NOT NULL,
    --phone_number
    PRIMARY KEY (hotel_brand_name, hotel_name),
    FOREIGN KEY (hotel_brand_name) REFERENCES hotel_brand (hotel_brand_name) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT range_star_category CHECK (star_category BETWEEN 0 AND 5),
    CONSTRAINT range_number_of_rooms CHECK (number_of_rooms >= 0),
    CONSTRAINT verification_email CHECK (email_address LIKE '%@%')
);

CREATE TABLE hotel_phone_number
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    phone_number     VARCHAR(16) NOT NULL,
    PRIMARY KEY (hotel_brand_name, hotel_name),
    FOREIGN KEY (hotel_brand_name, hotel_name) REFERENCES hotel (hotel_name, hotel_brand_name) ON UPDATE CASCADE ON DELETE CASCADE
);

-- TODO: May create more room capacity
CREATE TABLE room
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    room_id          INT,
    price            NUMERIC(4, 2) DEFAULT 0.00,
    --amenity
    room_capacity    VARCHAR(16) NOT NULL,
    --view
    --extensibility
    PRIMARY KEY (hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (hotel_brand_name, hotel_name) REFERENCES hotel (hotel_brand_name, hotel_name) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT range_price CHECK (price >= 0.00),
    CONSTRAINT range_room_capacity CHECK (room_capacity IN ('single', 'double'))
);

CREATE TABLE room_amenity
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    room_id          INT,
    amenity          VARCHAR(32) NOT NULL,
    PRIMARY KEY (hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (hotel_brand_name, hotel_name, room_id) REFERENCES room (hotel_brand_name, hotel_name, room_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE room_view
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    room_id          INT,
    view             VARCHAR(32) NOT NULL,
    PRIMARY KEY (hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (hotel_brand_name, hotel_name, room_id) REFERENCES room (hotel_brand_name, hotel_name, room_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE room_extensibility
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    room_id          INT,
    extensibility    VARCHAR(32) NOT NULL,
    PRIMARY KEY (hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (hotel_brand_name, hotel_name, room_id) REFERENCES room (hotel_brand_name, hotel_name, room_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE book
(
    customer_id            INT,
    hotel_brand_name       VARCHAR(64),
    hotel_name             VARCHAR(64),
    room_id                INT,
    date                   DATE        NOT NULL,
    room_type              VARCHAR(16) NOT NULL,
    total_number_occupants INT DEFAULT 1,
    PRIMARY KEY (customer_id, hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON UPDATE CASCADE,
    FOREIGN KEY (hotel_brand_name, hotel_name, room_id) REFERENCES room (hotel_brand_name, hotel_name, room_id) ON UPDATE CASCADE
);

CREATE TABLE rent
(
    customer_id            INT,
    hotel_brand_name       VARCHAR(64),
    hotel_name             VARCHAR(64),
    room_id                INT,
    employee_id            INT,
    date                   DATE        NOT NULL,
    room_type              VARCHAR(16) NOT NULL,
    total_number_occupants INT           DEFAULT 1,
    bill_amount            NUMERIC(4, 2) DEFAULT 0.0,
    duration               INTERVAL    NOT NULL,
    PRIMARY KEY (customer_id, hotel_brand_name, hotel_name, room_id),
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON UPDATE CASCADE,
    FOREIGN KEY (hotel_brand_name, hotel_name, room_id) REFERENCES room (hotel_brand_name, hotel_name, room_id) ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee (id) ON UPDATE CASCADE
);

CREATE TABLE employment
(
    hotel_brand_name VARCHAR(64),
    hotel_name       VARCHAR(64),
    employee_id      INT,
    PRIMARY KEY (hotel_brand_name, hotel_name, employee_id),
    FOREIGN KEY (hotel_brand_name, hotel_name) REFERENCES hotel (hotel_brand_name, hotel_name) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee (id) ON UPDATE CASCADE ON DELETE CASCADE
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO xwang532;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO fzhan081;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO jguo108;
