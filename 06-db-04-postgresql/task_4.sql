--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5 (Debian 13.5-1.pgdg110+1)
-- Dumped by pg_dump version 13.5 (Debian 13.5-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL unique,
    price integer DEFAULT 0
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_new; Type: TABLE; Schema: public; Owner: mbagirov
--

CREATE TABLE public.orders_new (
    id integer NOT NULL,
    title character varying(40) unique,
    price integer
)
PARTITION BY RANGE (price);


ALTER TABLE public.orders_new OWNER TO mbagirov;

--
-- Name: orders_new_id_seq; Type: SEQUENCE; Schema: public; Owner: mbagirov
--

CREATE SEQUENCE public.orders_new_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_new_id_seq OWNER TO mbagirov;

--
-- Name: orders_new_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mbagirov
--

ALTER SEQUENCE public.orders_new_id_seq OWNED BY public.orders_new.id;


--
-- Name: orders_1; Type: TABLE; Schema: public; Owner: mbagirov
--

CREATE TABLE public.orders_1 (
    id integer DEFAULT nextval('public.orders_new_id_seq'::regclass) NOT NULL,
    title character varying(40) unique,
    price integer
);
ALTER TABLE ONLY public.orders_new ATTACH PARTITION public.orders_1 FOR VALUES FROM (0) TO (500);


ALTER TABLE public.orders_1 OWNER TO mbagirov;

--
-- Name: orders_2; Type: TABLE; Schema: public; Owner: mbagirov
--

CREATE TABLE public.orders_2 (
    id integer DEFAULT nextval('public.orders_new_id_seq'::regclass) NOT NULL,
    title character varying(40) unique,
    price integer
);
ALTER TABLE ONLY public.orders_new ATTACH PARTITION public.orders_2 FOR VALUES FROM (500) TO (MAXVALUE);


ALTER TABLE public.orders_2 OWNER TO mbagirov;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: orders_new id; Type: DEFAULT; Schema: public; Owner: mbagirov
--

ALTER TABLE ONLY public.orders_new ALTER COLUMN id SET DEFAULT nextval('public.orders_new_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, title, price) FROM stdin;
1	War and peace	100
2	My little database	500
3	Adventure psql time	300
4	Server gravity falls	300
5	Log gossips	123
6	WAL never lies	900
7	Me and my bash-pet	499
8	Dbiezdmin	501
\.


--
-- Data for Name: orders_1; Type: TABLE DATA; Schema: public; Owner: mbagirov
--

COPY public.orders_1 (id, title, price) FROM stdin;
1	War and peace	100
3	Adventure psql time	300
4	Server gravity falls	300
5	Log gossips	123
7	Me and my bash-pet	499
9	test_input_3	10
\.


--
-- Data for Name: orders_2; Type: TABLE DATA; Schema: public; Owner: mbagirov
--

COPY public.orders_2 (id, title, price) FROM stdin;
2	My little database	500
6	WAL never lies	900
8	Dbiezdmin	501
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 8, true);


--
-- Name: orders_new_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mbagirov
--

SELECT pg_catalog.setval('public.orders_new_id_seq', 9, true);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.orders TO mbagirov;


--
-- PostgreSQL database dump complete
--

