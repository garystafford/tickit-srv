-- create all database objects
BEGIN;

DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;

CREATE SEQUENCE public.buyer_buyer_id_seq
    INCREMENT 1
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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
    START 25
    MINVALUE 1
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


--insert sample data
BEGIN;

INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (1, 'NEF62DQX', 'Serena', 'Miller', 'Glendora', 'NT', 'vel.convallis@pellentesquemassa.org', '(219) 745-3381',
        true, false, false, false, false, false, true, false, false, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (2, 'FXV50UTL', 'Petra', 'Pugh', 'West Hartford', 'CA', 'dui.Cras@quamCurabitur.org', '(255) 422-5204', false,
        false, false, false, false, true, true, false, false, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (3, 'BSE37FQC', 'Wendy', 'Nelson', 'Martinsburg', 'AK', 'Quisque.purus@ametdiam.ca', '(120) 487-0670', false,
        false, false, false, false, false, true, false, true, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (4, 'ULK75TQW', 'Blaine', 'Page', 'Keene', 'RI', 'eget@tinciduntorciquis.com', '(577) 873-1307', false, false,
        false, false, true, false, false, false, true, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (5, 'SPS65QXC', 'David', 'Barr', 'San Jose', 'SK', 'consectetuer@nonummy.edu', '(987) 699-8923', false, false,
        true, false, true, true, false, true, false, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (6, 'FZJ39SLO', 'Sheila', 'Hardy', 'Rancho Santa Margarita', 'QC', 'Praesent.eu@pharetraQuisque.ca',
        '(927) 204-4914', false, false, false, false, true, false, false, false, false, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (7, 'GMC69XRX', 'Charles', 'Hudson', 'Geneva', 'FL', 'malesuada@lectusCum.org', '(294) 956-1806', false, false,
        true, false, true, false, true, false, true, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (8, 'XXJ34RWW', 'Demetrius', 'Ewing', 'Bismarck', 'GA', 'vitae@nuncsit.org', '(407) 609-3346', false, true,
        false, false, true, true, false, true, false, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (9, 'OEM77BDE', 'Salvador', 'Prince', 'Wilson', 'NT', 'amet@sapiengravidanon.org', '(989) 492-4586', false,
        false, false, false, false, false, true, true, false, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (10, 'QRK23UUV', 'Jillian', 'Bernard', 'Hartford', 'AZ', 'dis.parturient.montes@auguescelerisquemollis.org',
        '(463) 491-4020', false, true, false, false, true, false, true, true, true, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (11, 'MVH03VWV', 'Jenna', 'Cannon', 'Tonawanda', 'YT', 'nunc@Cras.org', '(655) 598-5641', false, true, true,
        false, true, true, false, false, false, true);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (12, 'SNI06JXH', 'Gwendolyn', 'Fuller', 'Tallahassee', 'YT', 'cursus.Integer@condimentum.ca', '(317) 937-0039',
        false, true, false, false, true, false, true, false, true, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (13, 'VNW44QQQ', 'Daryl', 'Freeman', 'Orem', 'MB', 'consectetuer.mauris@Nulla.com', '(156) 924-1626', false,
        true, false, false, true, true, false, false, true, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (14, 'IVU58GFI', 'Lucius', 'Norton', 'Vermillion', 'SK', 'arcu.vel.quam@ornareegestas.com', '(747) 405-4749',
        false, false, true, false, true, true, true, true, false, false);
INSERT INTO public.buyer(buyerid, username, firstname, lastname, city, state, email, phone, likesports, liketheatre,
                         likeconcerts, likejazz, likeclassical, likeopera, likerock, likevegas, likebroadway,
                         likemusicals)
VALUES (15, 'USQ75NOE', 'Keegan', 'Holcomb', 'Jeffersontown', 'NU', 'gravida@dictum.ca', '(989) 129-1673', false, true,
        false, false, false, false, false, true, true, false);

INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (1, 'JSG99FHE', 'Rafael', 'Taylor', 'Kent', 'WA', 'Etiam.laoreet.libero@sodalesMaurisblandit.edu',
        '(664) 602-4412', '906449521');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (2, 'IFT66TXU', 'Lars', 'Ratliff', 'High Point', 'ME', 'amet.faucibus.ut@condimentumegetvolutpat.ca',
        '(624) 767-2465', '340523005');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (3, 'XDZ38RDD', 'Barry', 'Roy', 'Omaha', 'AB', 'sed@lacusUtnec.ca', '(355) 452-8168', '987019751');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (4, 'AEB55QTM', 'Reagan', 'Hodge', 'Forest Lake', 'NS', 'Cum@accumsan.com', '(476) 519-9131', '402433958');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (5, 'MVZ73SEM', 'Daquan', 'Lang', 'Half Moon Bay', 'NL', 'Nunc.mauris@mattis.ca', '(323) 413-1924', '785840975');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (6, 'RIS28ICA', 'Alma', 'Oneil', 'Muncie', 'ON', 'ac@justo.com', '(616) 606-8785', '527862557');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (7, 'KZX83URU', 'Giacomo', 'Mcconnell', 'Coos Bay', 'MN', 'ipsum.cursus@sagittis.org', '(165) 835-1329',
        '146499244');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (8, 'PGP12OQS', 'Bo', 'Graves', 'Littleton', 'DE', 'et@non.edu', '(954) 241-9533', '733846050');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (9, 'AUC61QBI', 'Lev', 'Mack', 'Merced', 'NU', 'molestie@risusDonec.org', '(277) 435-3702', '243568189');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (10, 'XIC27UFA', 'Branden', 'Foster', 'Twin Falls', 'MB', 'odio@eleifendCrassed.org', '(495) 274-2665',
        '900631570');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (11, 'GGJ37LJO', 'Germane', 'Burks', 'Mequon', 'SK', 'scelerisque@Suspendissecommodotincidunt.edu',
        '(956) 881-0009', '678880822');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (12, 'IKH45MHY', 'Celeste', 'Ferguson', 'East Rutherford', 'NS', 'faucibus.leo.in@rhoncusProinnisl.ca',
        '(187) 493-0765', '196422872');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (13, 'SCF32JUT', 'Austin', 'Hester', 'Lincoln', 'NB', 'sem.Nulla.interdum@nibhDonec.org', '(584) 510-3916',
        '180010770');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (14, 'BDJ72RUP', 'Cyrus', 'Lloyd', 'Davis', 'NM', 'Aliquam@feugiatSednec.com', '(981) 324-0059', '430462388');
INSERT INTO public.seller (sellerid, username, firstname, lastname, city, state, email, phone, tin)
VALUES (15, 'XKR51LWK', 'Phyllis', 'Holder', 'Scottsbluff', 'BC', 'nascetur@ipsumprimisin.ca', '(220) 199-7681',
        '781515435');

INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (1, 'Columbus Crew Stadium', 'Columbus', 'OH', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (2, 'CommunityAmerica Ballpark', 'Kansas City', 'KS', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (3, 'Gillette Stadium', 'Foxborough', 'MA', 68756);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (4, 'BMO Field', 'Toronto', 'ON', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (5, 'Dick''s Sporting Goods Park', 'Commerce City', 'CO', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (6, 'Pizza Hut Park', 'Frisco', 'TX', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (7, 'Redwing Stadium', 'Rochester', 'NY', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (8, 'McAfee Coliseum', 'Oakland', 'CA', 63026);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (9, 'TD Banknorth Garden', 'Boston', 'MA', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (10, 'Madison Square Garden', 'New York City', 'NY', 20000);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (11, 'Wachovia Center', 'Philadelphia', 'PA', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (12, 'Quicken Loans Arena', 'Cleveland', 'OH', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (13, 'The Palace of Auburn Hills', 'Auburn Hills', 'MI', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (14, 'Conseco Fieldhouse', 'Indianapolis', 'IN', 0);
INSERT INTO public.venue (venueid, venuename, venuecity, venuestate, venueseats)
VALUES (15, 'Bradley Center', 'Milwaukee', 'WI', 0);

INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (1, 'Sports', 'MLB', 'Major League Baseball');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (2, 'Sports', 'NHL', 'National Hockey League');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (3, 'Sports', 'NFL', 'National Football League');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (4, 'Sports', 'NBA', 'National Basketball Association');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (5, 'Sports', 'MLS', 'Major League Soccer');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (6, 'Shows', 'Musicals', 'Musical theatre');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (7, 'Shows', 'Plays', 'All non-musical theatre');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (8, 'Shows', 'Opera', 'All opera and light opera');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (9, 'Concerts', 'Pop', 'All rock and pop music concerts');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (10, 'Concerts', 'Jazz', 'All jazz singers and bands');
INSERT INTO public.category (catid, catgroup, catname, catdesc)
VALUES (11, 'Concerts', 'Classical', 'All symphony, concerto, and choir concerts');

INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (1, 5, 8, 'La Damnation de Faust', '2008-01-01 19:30:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (2, 6, 6, 'The King and I', '2008-01-01 14:30:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (3, 7, 6, 'The King and I', '2008-01-01 14:30:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (4, 8, 7, 'The Bacchae', '2008-01-01 19:30:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (5, 9, 5, 'Zappa Plays Zappa', '2008-01-01 14:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (6, 10, 9, 'Fab Faux', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (7, 1, 9, 'Beck', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (8, 2, 6, 'Herbie Hancock', '2008-01-01 19:30:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (9, 3, 2, 'Wallflowers', '2008-01-01 14:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (10, 4, 1, 'Gretchen Wilson', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (11, 11, 3, 'Keith Urban', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (12, 12, 9, 'Dierks Bentley', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (13, 13, 4, 'Hot Chip', '2008-01-01 19:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (14, 14, 6, 'Spamalot', '2008-01-02 15:00:00.000000');
INSERT INTO public.event (eventid, venueid, catid, eventname, starttime)
VALUES (15, 15, 7, 'The Cherry Orchard', '2008-01-02 14:30:00.000000');

INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (1, 15, 1, 8, 47.00, 376.00, '2008-01-01 05:54:44.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (2, 14, 3, 10, 40.00, 400.00, '2008-01-01 03:32:37.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (3, 13, 5, 9, 126.00, 1134.00, '2008-01-01 04:05:41.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (4, 12, 7, 16, 118.00, 1888.00, '2008-01-01 01:16:37.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (5, 11, 9, 16, 43.00, 688.00, '2008-01-01 03:10:06.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (6, 10, 11, 1, 79.00, 79.00, '2008-01-01 06:03:47.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (7, 1, 13, 6, 233.00, 1398.00, '2008-01-01 11:34:43.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (8, 2, 15, 2, 91.00, 182.00, '2008-01-01 07:55:03.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (9, 3, 1, 26, 177.00, 4602.00, '2008-01-01 08:52:52.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (10, 4, 2, 10, 157.00, 1570.00, '2008-01-01 10:29:56.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (11, 6, 3, 18, 201.00, 3618.00, '2008-01-01 08:14:04.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (12, 6, 4, 20, 185.00, 3700.00, '2008-01-01 05:44:30.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (13, 7, 5, 14, 25.00, 350.00, '2008-01-01 01:03:11.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (14, 8, 12, 10, 167.00, 1670.00, '2008-01-01 11:37:04.000000');
INSERT INTO public.listing (listid, sellerid, eventid, numtickets, priceperticket, totalprice, listtime)
VALUES (15, 9, 13, 26, 99.00, 2574.00, '2008-01-01 03:59:41.000000');

INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (1, 15, 2, 4, 472.00, 70.80, '2008-01-01 06:06:57.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (2, 14, 4, 2, 708.00, 106.20, '2008-01-01 02:30:52.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (3, 13, 6, 1, 347.00, 52.05, '2008-01-01 01:00:19.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (4, 12, 8, 2, 4192.00, 628.80, '2008-01-01 12:59:34.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (5, 11, 10, 1, 177.00, 26.55, '2008-01-02 01:52:35.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (6, 10, 12, 2, 108.00, 16.20, '2008-01-02 05:13:52.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (7, 1, 14, 2, 810.00, 121.50, '2008-01-02 09:31:15.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (8, 2, 1, 1, 354.00, 53.10, '2008-01-02 02:31:12.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (9, 3, 2, 1, 269.00, 40.35, '2008-01-02 04:04:32.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (10, 4, 4, 1, 196.00, 29.40, '2008-01-02 03:34:14.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (11, 5, 6, 4, 8672.00, 1300.80, '2008-01-02 03:20:32.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (12, 6, 8, 3, 603.00, 90.45, '2008-01-03 01:18:41.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (13, 7, 10, 2, 342.00, 51.30, '2008-01-03 06:36:27.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (14, 8, 15, 2, 92.00, 13.80, '2008-01-03 05:35:58.000000');
INSERT INTO public.sale (saleid, listid, buyerid, qtysold, pricepaid, commission, saletime)
VALUES (15, 9, 1, 2, 156.00, 23.40, '2008-01-03 05:58:02.000000');

COMMIT;