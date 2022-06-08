-- create all database objects
BEGIN;

DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;

CREATE SEQUENCE public.buyer_buyer_id_seq
    INCREMENT 1
    START 50000
    MINVALUE 50000
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.buyer
(
    buyerid       integer      NOT NULL DEFAULT nextval('public.buyer_buyer_id_seq'::regclass),
    username      varchar(8)   NOT NULL,
    firstname     varchar(30)  NOT NULL,
    lastname      varchar(30)  NOT NULL,
    city          varchar(30)  NOT NULL,
    state         varchar(2)   NOT NULL,
    email         varchar(100) NOT NULL,
    phone         varchar(14)  NOT NULL,
    likesports    boolean      NOT NULL DEFAULT FALSE,
    liketheatre   boolean      NOT NULL DEFAULT FALSE,
    likeconcerts  boolean      NOT NULL DEFAULT FALSE,
    likejazz      boolean      NOT NULL DEFAULT FALSE,
    likeclassical boolean      NOT NULL DEFAULT FALSE,
    likeopera     boolean      NOT NULL DEFAULT FALSE,
    likerock      boolean      NOT NULL DEFAULT FALSE,
    likevegas     boolean      NOT NULL DEFAULT FALSE,
    likebroadway  boolean      NOT NULL DEFAULT FALSE,
    likemusicals  boolean      NOT NULL DEFAULT FALSE,
    CONSTRAINT buyer_pkey PRIMARY KEY (buyerid),
    CONSTRAINT buyer_username_unique UNIQUE (username)
);

CREATE SEQUENCE public.seller_seller_id_seq
    INCREMENT 1
    START 50000
    MINVALUE 50000
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.seller
(
    sellerid  integer      NOT NULL DEFAULT nextval('public.seller_seller_id_seq'::regclass),
    username  varchar(8)   NOT NULL,
    firstname varchar(30)  NOT NULL,
    lastname  varchar(30)  NOT NULL,
    city      varchar(30)  NOT NULL,
    state     varchar(2)   NOT NULL,
    email     varchar(100) NOT NULL,
    phone     varchar(14)  NOT NULL,
    tin       varchar(9)   NOT NULL,
    CONSTRAINT seller_pkey PRIMARY KEY (sellerid),
    CONSTRAINT seller_username_unique UNIQUE (username)
);

CREATE SEQUENCE public.venue_venue_id_seq
    INCREMENT 1
    START 350
    MINVALUE 350
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.venue
(
    venueid    integer      NOT NULL DEFAULT nextval('public.venue_venue_id_seq'::regclass),
    venuename  varchar(100) NOT NULL,
    venuecity  varchar(30)  NOT NULL,
    venuestate varchar(2)   NOT NULL,
    venueseats integer      NOT NULL DEFAULT 0,
    CONSTRAINT venue_pkey PRIMARY KEY (venueid)
);

CREATE SEQUENCE public.category_cat_id_seq
    INCREMENT 1
    START 15
    MINVALUE 15
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.category
(
    catid    integer     NOT NULL DEFAULT nextval('public.category_cat_id_seq'::regclass),
    catgroup varchar(20) NOT NULL,
    catname  varchar(20) NOT NULL,
    catdesc  varchar(50) NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (catid)
);

CREATE SEQUENCE public.event_event_id_seq
    INCREMENT 1
    START 10000
    MINVALUE 10000
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.event
(
    eventid   integer      NOT NULL DEFAULT nextval('public.event_event_id_seq'::regclass),
    venueid   integer      NOT NULL,
    catid     integer      NOT NULL,
    eventname varchar(200) NOT NULL,
    starttime timestamp    NOT NULL DEFAULT now(),
    CONSTRAINT event_pkey PRIMARY KEY (eventid),
    CONSTRAINT event_venueid_fk FOREIGN KEY (venueid)
        REFERENCES public.venue (venueid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT venue_catid_fk FOREIGN KEY (catid)
        REFERENCES public.category (catid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE SEQUENCE public.listing_list_id_seq
    INCREMENT 1
    START 250000
    MINVALUE 250000
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.listing
(
    listid         integer       NOT NULL DEFAULT nextval('public.listing_list_id_seq'::regclass),
    sellerid       integer       NOT NULL,
    eventid        integer       NOT NULL,
    numtickets     smallint      NOT NULL,
    priceperticket decimal(8, 2) NOT NULL,
    totalprice     decimal(8, 2) NOT NULL,
    listtime       timestamp     NOT NULL DEFAULT now(),
    CONSTRAINT listing_pkey PRIMARY KEY (listid),
    CONSTRAINT listing_eventid_fk FOREIGN KEY (eventid)
        REFERENCES public.event (eventid) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT listing_sellerid_fk FOREIGN KEY (sellerid)
        REFERENCES public.seller (sellerid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE SEQUENCE public.sale_sale_id_seq
    INCREMENT 1
    START 175000
    MINVALUE 175000
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE public.sale
(
    saleid     integer       NOT NULL DEFAULT nextval('public.sale_sale_id_seq'::regclass),
    listid     integer       NOT NULL,
    buyerid    integer       NOT NULL,
    qtysold    smallint      NOT NULL,
    pricepaid  decimal(8, 2) NOT NULL,
    commission decimal(8, 2) NOT NULL,
    saletime   timestamp     NOT NULL DEFAULT now(),
    CONSTRAINT sales_pkey PRIMARY KEY (saleid),
    CONSTRAINT sale_buyerid_fk FOREIGN KEY (buyerid)
        REFERENCES public.buyer (buyerid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sale_listid_fk FOREIGN KEY (listid)
        REFERENCES public.listing (listid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMIT;

-- -- tickit_app
-- REVOKE ALL PRIVILEGES ON SCHEMA public FROM tickit_app CASCADE;
-- DROP ROLE IF EXISTS tickit_app;

BEGIN;

CREATE ROLE tickit_app LOGIN PASSWORD 'tickitapp123';
GRANT USAGE ON SCHEMA public TO tickit_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO tickit_app;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tickit_app;

COMMIT;