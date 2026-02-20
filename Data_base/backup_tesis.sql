--
-- PostgreSQL database dump
--

\restrict K37febAyEOJUOzsAq9f5tNkjViQHYspbVz5ldAzR3wP4Zdmb4DbKwcEb1CCc8y8

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: fft; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fft (
    id integer NOT NULL,
    distal numeric(10,7),
    medial numeric(10,7),
    proximal numeric(10,7)
);


ALTER TABLE public.fft OWNER TO postgres;

--
-- Name: h_551_r_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_551_r_1 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_551_r_1 OWNER TO postgres;

--
-- Name: h_551_r_1_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_551_r_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_551_r_1_id_seq OWNER TO postgres;

--
-- Name: h_551_r_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_551_r_1_id_seq OWNED BY public.h_551_r_1.id;


--
-- Name: h_551_r_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_551_r_2 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_551_r_2 OWNER TO postgres;

--
-- Name: h_551_r_2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_551_r_2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_551_r_2_id_seq OWNER TO postgres;

--
-- Name: h_551_r_2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_551_r_2_id_seq OWNED BY public.h_551_r_2.id;


--
-- Name: h_551_r_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_551_r_3 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_551_r_3 OWNER TO postgres;

--
-- Name: h_551_r_3_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_551_r_3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_551_r_3_id_seq OWNER TO postgres;

--
-- Name: h_551_r_3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_551_r_3_id_seq OWNED BY public.h_551_r_3.id;


--
-- Name: h_563_r_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_563_r_1 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_563_r_1 OWNER TO postgres;

--
-- Name: h_563_r_1_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_563_r_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_563_r_1_id_seq OWNER TO postgres;

--
-- Name: h_563_r_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_563_r_1_id_seq OWNED BY public.h_563_r_1.id;


--
-- Name: h_563_r_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_563_r_2 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_563_r_2 OWNER TO postgres;

--
-- Name: h_563_r_2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_563_r_2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_563_r_2_id_seq OWNER TO postgres;

--
-- Name: h_563_r_2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_563_r_2_id_seq OWNED BY public.h_563_r_2.id;


--
-- Name: h_563_r_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_563_r_3 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_563_r_3 OWNER TO postgres;

--
-- Name: h_563_r_3_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_563_r_3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_563_r_3_id_seq OWNER TO postgres;

--
-- Name: h_563_r_3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_563_r_3_id_seq OWNED BY public.h_563_r_3.id;


--
-- Name: h_564_r_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_564_r_1 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_564_r_1 OWNER TO postgres;

--
-- Name: h_564_r_1_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_564_r_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_564_r_1_id_seq OWNER TO postgres;

--
-- Name: h_564_r_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_564_r_1_id_seq OWNED BY public.h_564_r_1.id;


--
-- Name: h_564_r_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_564_r_2 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_564_r_2 OWNER TO postgres;

--
-- Name: h_564_r_2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_564_r_2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_564_r_2_id_seq OWNER TO postgres;

--
-- Name: h_564_r_2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_564_r_2_id_seq OWNED BY public.h_564_r_2.id;


--
-- Name: h_564_r_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_564_r_3 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_564_r_3 OWNER TO postgres;

--
-- Name: h_564_r_3_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_564_r_3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_564_r_3_id_seq OWNER TO postgres;

--
-- Name: h_564_r_3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_564_r_3_id_seq OWNED BY public.h_564_r_3.id;


--
-- Name: h_573_r_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_573_r_1 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_573_r_1 OWNER TO postgres;

--
-- Name: h_573_r_1_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_573_r_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_573_r_1_id_seq OWNER TO postgres;

--
-- Name: h_573_r_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_573_r_1_id_seq OWNED BY public.h_573_r_1.id;


--
-- Name: h_573_r_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_573_r_2 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_573_r_2 OWNER TO postgres;

--
-- Name: h_573_r_2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_573_r_2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_573_r_2_id_seq OWNER TO postgres;

--
-- Name: h_573_r_2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_573_r_2_id_seq OWNED BY public.h_573_r_2.id;


--
-- Name: h_573_r_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.h_573_r_3 (
    id integer NOT NULL,
    distal numeric(10,7) NOT NULL,
    medial numeric(10,7) NOT NULL,
    proximal numeric(10,7) NOT NULL
);


ALTER TABLE public.h_573_r_3 OWNER TO postgres;

--
-- Name: h_573_r_3_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.h_573_r_3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.h_573_r_3_id_seq OWNER TO postgres;

--
-- Name: h_573_r_3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.h_573_r_3_id_seq OWNED BY public.h_573_r_3.id;


--
-- Name: h_551_r_1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_1 ALTER COLUMN id SET DEFAULT nextval('public.h_551_r_1_id_seq'::regclass);


--
-- Name: h_551_r_2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_2 ALTER COLUMN id SET DEFAULT nextval('public.h_551_r_2_id_seq'::regclass);


--
-- Name: h_551_r_3 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_3 ALTER COLUMN id SET DEFAULT nextval('public.h_551_r_3_id_seq'::regclass);


--
-- Name: h_563_r_1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_1 ALTER COLUMN id SET DEFAULT nextval('public.h_563_r_1_id_seq'::regclass);


--
-- Name: h_563_r_2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_2 ALTER COLUMN id SET DEFAULT nextval('public.h_563_r_2_id_seq'::regclass);


--
-- Name: h_563_r_3 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_3 ALTER COLUMN id SET DEFAULT nextval('public.h_563_r_3_id_seq'::regclass);


--
-- Name: h_564_r_1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_1 ALTER COLUMN id SET DEFAULT nextval('public.h_564_r_1_id_seq'::regclass);


--
-- Name: h_564_r_2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_2 ALTER COLUMN id SET DEFAULT nextval('public.h_564_r_2_id_seq'::regclass);


--
-- Name: h_564_r_3 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_3 ALTER COLUMN id SET DEFAULT nextval('public.h_564_r_3_id_seq'::regclass);


--
-- Name: h_573_r_1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_1 ALTER COLUMN id SET DEFAULT nextval('public.h_573_r_1_id_seq'::regclass);


--
-- Name: h_573_r_2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_2 ALTER COLUMN id SET DEFAULT nextval('public.h_573_r_2_id_seq'::regclass);


--
-- Name: h_573_r_3 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_3 ALTER COLUMN id SET DEFAULT nextval('public.h_573_r_3_id_seq'::regclass);


--
-- Data for Name: fft; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fft (id, distal, medial, proximal) FROM stdin;
551	1.0850580	1.5934620	1.6815130
563	6.0351390	5.9724170	5.8265880
564	3.2103280	0.8079495	3.5614920
573	1.7653130	1.4089970	1.2420080
\.


--
-- Data for Name: h_551_r_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_551_r_1 (id, distal, medial, proximal) FROM stdin;
551	0.7326742	1.1804550	1.4064620
\.


--
-- Data for Name: h_551_r_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_551_r_2 (id, distal, medial, proximal) FROM stdin;
551	1.4072500	1.8625910	2.8257880
\.


--
-- Data for Name: h_551_r_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_551_r_3 (id, distal, medial, proximal) FROM stdin;
551	1.1152500	1.7373410	0.8122879
\.


--
-- Data for Name: h_563_r_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_563_r_1 (id, distal, medial, proximal) FROM stdin;
563	7.0744090	6.1883710	10.9158900
\.


--
-- Data for Name: h_563_r_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_563_r_2 (id, distal, medial, proximal) FROM stdin;
563	3.5281520	5.0988640	3.2082420
\.


--
-- Data for Name: h_563_r_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_563_r_3 (id, distal, medial, proximal) FROM stdin;
563	7.5028560	6.6300150	3.3556360
\.


--
-- Data for Name: h_564_r_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_564_r_1 (id, distal, medial, proximal) FROM stdin;
564	0.9425758	0.6892424	6.6323180
\.


--
-- Data for Name: h_564_r_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_564_r_2 (id, distal, medial, proximal) FROM stdin;
564	0.8649470	0.8502803	3.2006970
\.


--
-- Data for Name: h_564_r_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_564_r_3 (id, distal, medial, proximal) FROM stdin;
564	7.8234620	0.8843258	0.8514621
\.


--
-- Data for Name: h_573_r_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_573_r_1 (id, distal, medial, proximal) FROM stdin;
573	1.8983560	1.1592120	1.9545450
\.


--
-- Data for Name: h_573_r_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_573_r_2 (id, distal, medial, proximal) FROM stdin;
573	1.6208180	1.8191440	1.0408790
\.


--
-- Data for Name: h_573_r_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.h_573_r_3 (id, distal, medial, proximal) FROM stdin;
573	1.7767650	1.2486360	0.7305985
\.


--
-- Name: h_551_r_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_551_r_1_id_seq', 1, false);


--
-- Name: h_551_r_2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_551_r_2_id_seq', 1, false);


--
-- Name: h_551_r_3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_551_r_3_id_seq', 1, false);


--
-- Name: h_563_r_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_563_r_1_id_seq', 1, false);


--
-- Name: h_563_r_2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_563_r_2_id_seq', 1, false);


--
-- Name: h_563_r_3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_563_r_3_id_seq', 1, false);


--
-- Name: h_564_r_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_564_r_1_id_seq', 1, false);


--
-- Name: h_564_r_2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_564_r_2_id_seq', 1, false);


--
-- Name: h_564_r_3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_564_r_3_id_seq', 1, false);


--
-- Name: h_573_r_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_573_r_1_id_seq', 1, false);


--
-- Name: h_573_r_2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_573_r_2_id_seq', 1, false);


--
-- Name: h_573_r_3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.h_573_r_3_id_seq', 1, false);


--
-- Name: fft fft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fft
    ADD CONSTRAINT fft_pkey PRIMARY KEY (id);


--
-- Name: h_551_r_1 h_551_r_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_1
    ADD CONSTRAINT h_551_r_1_pkey PRIMARY KEY (id);


--
-- Name: h_551_r_2 h_551_r_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_2
    ADD CONSTRAINT h_551_r_2_pkey PRIMARY KEY (id);


--
-- Name: h_551_r_3 h_551_r_3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_551_r_3
    ADD CONSTRAINT h_551_r_3_pkey PRIMARY KEY (id);


--
-- Name: h_563_r_1 h_563_r_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_1
    ADD CONSTRAINT h_563_r_1_pkey PRIMARY KEY (id);


--
-- Name: h_563_r_2 h_563_r_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_2
    ADD CONSTRAINT h_563_r_2_pkey PRIMARY KEY (id);


--
-- Name: h_563_r_3 h_563_r_3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_563_r_3
    ADD CONSTRAINT h_563_r_3_pkey PRIMARY KEY (id);


--
-- Name: h_564_r_1 h_564_r_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_1
    ADD CONSTRAINT h_564_r_1_pkey PRIMARY KEY (id);


--
-- Name: h_564_r_2 h_564_r_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_2
    ADD CONSTRAINT h_564_r_2_pkey PRIMARY KEY (id);


--
-- Name: h_564_r_3 h_564_r_3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_564_r_3
    ADD CONSTRAINT h_564_r_3_pkey PRIMARY KEY (id);


--
-- Name: h_573_r_1 h_573_r_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_1
    ADD CONSTRAINT h_573_r_1_pkey PRIMARY KEY (id);


--
-- Name: h_573_r_2 h_573_r_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_2
    ADD CONSTRAINT h_573_r_2_pkey PRIMARY KEY (id);


--
-- Name: h_573_r_3 h_573_r_3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.h_573_r_3
    ADD CONSTRAINT h_573_r_3_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict K37febAyEOJUOzsAq9f5tNkjViQHYspbVz5ldAzR3wP4Zdmb4DbKwcEb1CCc8y8

