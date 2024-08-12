--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, 'user_1723456687587', 2, 49);
INSERT INTO public.users VALUES (11, 'user_1723457299672', 2, 353);
INSERT INTO public.users VALUES (1, 'user_1723456687588', 5, 43);
INSERT INTO public.users VALUES (3, 'amit', 1, 9);
INSERT INTO public.users VALUES (10, 'user_1723457299673', 5, 110);
INSERT INTO public.users VALUES (12, 'tanna', 0, NULL);
INSERT INTO public.users VALUES (5, 'user_1723456992048', 2, 73);
INSERT INTO public.users VALUES (4, 'user_1723456992049', 5, 533);
INSERT INTO public.users VALUES (15, 'user_1723457986898', 2, NULL);
INSERT INTO public.users VALUES (7, 'user_1723457038882', 2, 642);
INSERT INTO public.users VALUES (13, 'user_1723457986899', 5, NULL);
INSERT INTO public.users VALUES (6, 'user_1723457038883', 5, 374);
INSERT INTO public.users VALUES (22, 'user_1723458321077', 2, NULL);
INSERT INTO public.users VALUES (9, 'user_1723457240809', 2, 655);
INSERT INTO public.users VALUES (20, 'user_1723458321078', 5, NULL);
INSERT INTO public.users VALUES (8, 'user_1723457240810', 5, 588);
INSERT INTO public.users VALUES (28, 'user_1723475493745', 2, 11);
INSERT INTO public.users VALUES (41, 'user_1723476253086', 2, 446);
INSERT INTO public.users VALUES (27, 'user_1723475493746', 5, 167);
INSERT INTO public.users VALUES (40, 'user_1723476253087', 5, 370);
INSERT INTO public.users VALUES (30, 'user_1723475505853', 2, 754);
INSERT INTO public.users VALUES (29, 'user_1723475505854', 5, 184);
INSERT INTO public.users VALUES (43, 'user_1723476380200', 2, 610);
INSERT INTO public.users VALUES (32, 'user_1723475666179', 2, 759);
INSERT INTO public.users VALUES (31, 'user_1723475666180', 5, 67);
INSERT INTO public.users VALUES (42, 'user_1723476380201', 5, 326);
INSERT INTO public.users VALUES (34, 'user_1723475844908', 2, 299);
INSERT INTO public.users VALUES (33, 'user_1723475844909', 5, 501);
INSERT INTO public.users VALUES (35, 'test', 0, NULL);
INSERT INTO public.users VALUES (45, 'user_1723476661495', 2, 806);
INSERT INTO public.users VALUES (37, 'user_1723476119735', 2, 410);
INSERT INTO public.users VALUES (36, 'user_1723476119736', 5, 343);
INSERT INTO public.users VALUES (44, 'user_1723476661496', 5, 599);
INSERT INTO public.users VALUES (39, 'user_1723476162004', 2, 261);
INSERT INTO public.users VALUES (38, 'user_1723476162005', 5, 69);
INSERT INTO public.users VALUES (47, 'user_1723476856471', 2, 542);
INSERT INTO public.users VALUES (46, 'user_1723476856472', 5, 161);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 47, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

