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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: constellation; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.constellation (
    name character varying(30) NOT NULL,
    constellation_id integer NOT NULL,
    number_of_stars integer NOT NULL,
    constellation_i_know boolean,
    alias character varying(25)
);


ALTER TABLE public.constellation OWNER TO freecodecamp;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    alias character varying(25),
    constellation character varying(20),
    comment text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    name character varying(30) NOT NULL,
    moon_id integer NOT NULL,
    alias character varying(25),
    surnom_lunaire character varying(20),
    comment text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    planet_age integer,
    planet_is_pretty boolean,
    sun_distance numeric,
    planet_description text,
    alias character varying(25),
    closest_planet character varying(20),
    surnom_lunaire character varying(20)
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    name character varying(30) NOT NULL,
    star_id integer NOT NULL,
    alias character varying(25),
    constellation character varying(20),
    closest_planet character varying(20)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: constellation; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.constellation VALUES ('Miki', 1, 7, NULL, NULL);
INSERT INTO public.constellation VALUES ('Lola', 2, 7, NULL, NULL);
INSERT INTO public.constellation VALUES ('Kila', 3, 7, NULL, NULL);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES ('Grand Chien', 1, NULL, 'Grand Chien', NULL);
INSERT INTO public.galaxy VALUES ('Sagittaire', 2, NULL, 'Sagittaire', NULL);
INSERT INTO public.galaxy VALUES ('Grande Ourse II', 3, NULL, 'Grande Ourse', NULL);
INSERT INTO public.galaxy VALUES ('Petite Ourse', 4, NULL, 'Petite Ourse', NULL);
INSERT INTO public.galaxy VALUES ('Dragon', 5, NULL, 'Dragon', NULL);
INSERT INTO public.galaxy VALUES ('Sculpteur', 6, NULL, 'Sculpteur', NULL);
INSERT INTO public.galaxy VALUES ('Centaurus A', 7, NULL, 'Centaurus', NULL);
INSERT INTO public.galaxy VALUES ('Taurus', 8, NULL, 'Taurus', NULL);
INSERT INTO public.galaxy VALUES ('Jupitus', 9, NULL, 'Jupitus', NULL);
INSERT INTO public.galaxy VALUES ('Marsus', 10, NULL, 'Marsus', NULL);
INSERT INTO public.galaxy VALUES ('Saturnusus', 11, NULL, 'Saturnusus', NULL);
INSERT INTO public.galaxy VALUES ('Uranusus', 12, NULL, 'Uranusus', NULL);
INSERT INTO public.galaxy VALUES ('Neptunus', 13, NULL, 'Neptunus', NULL);
INSERT INTO public.galaxy VALUES ('Mercurus', 14, NULL, 'Mercurus', NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES ('Gemeaux', 1, NULL, 'Mercure_Gemeaux', NULL);
INSERT INTO public.moon VALUES ('Taureau', 2, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Toso', 3, NULL, 'Terre_Toso', NULL);
INSERT INTO public.moon VALUES ('Belier', 4, NULL, 'Mars_Belier', NULL);
INSERT INTO public.moon VALUES ('Poisson', 5, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Vache', 6, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Coq', 7, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Elephant', 8, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Chat', 9, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Serpent', 10, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Dragon', 11, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Cancer', 12, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Crocodile', 13, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Aigle', 14, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Lezard', 15, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Rat', 16, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Papillon', 17, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Abeille', 18, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Belette', 19, NULL, 'Venus_Taureau', NULL);
INSERT INTO public.moon VALUES ('Iguane', 20, NULL, 'Venus_Taureau', NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES ('Mercure', 1, NULL, NULL, NULL, NULL, NULL, 'Terre', 'Mercure_Gemeaux');
INSERT INTO public.planet VALUES ('Venus', 2, NULL, NULL, NULL, NULL, NULL, 'Mercure', 'Venus_Taureau');
INSERT INTO public.planet VALUES ('Terre', 3, NULL, NULL, NULL, NULL, NULL, 'Mercure', 'Terre_Toso');
INSERT INTO public.planet VALUES ('Mars', 4, NULL, NULL, NULL, NULL, NULL, 'Terre', 'Mars_Belier');
INSERT INTO public.planet VALUES ('Jupiter', 5, NULL, NULL, NULL, NULL, NULL, 'Mars', 'Jupiter_Sagittaire');
INSERT INTO public.planet VALUES ('Saturne', 6, NULL, NULL, NULL, NULL, NULL, 'Jupiter', 'Saturne_Capricorne');
INSERT INTO public.planet VALUES ('Uranus', 7, NULL, NULL, NULL, NULL, NULL, 'Saturne', 'Uranus_Pouet');
INSERT INTO public.planet VALUES ('Neptune', 8, NULL, NULL, NULL, NULL, NULL, 'Uranus', 'Neptune_Pouet');
INSERT INTO public.planet VALUES ('Mercura', 9, NULL, NULL, NULL, NULL, NULL, 'Terre', 'Mercura_Gema');
INSERT INTO public.planet VALUES ('Venusa', 10, NULL, NULL, NULL, NULL, NULL, 'Mercure', 'Venusa_Tora');
INSERT INTO public.planet VALUES ('Marsa', 11, NULL, NULL, NULL, NULL, NULL, 'Terre', 'Marsa_Belia');
INSERT INTO public.planet VALUES ('Jupitera', 12, NULL, NULL, NULL, NULL, NULL, 'Mars', 'Jupitera_Sagittaira');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES ('Sirius', 1, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Mirzam', 2, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Muliphein', 3, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Wezen', 4, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Adhara', 5, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Furud', 6, NULL, 'Grand Chien', NULL);
INSERT INTO public.star VALUES ('Draconis', 7, NULL, 'Dragon', NULL);
INSERT INTO public.star VALUES ('Proxima Centauri', 8, NULL, 'Centaurus', 'Terre');
INSERT INTO public.star VALUES ('Aldebaran', 10, NULL, 'Taurus', 'Mars');
INSERT INTO public.star VALUES ('Jupius', 11, NULL, 'Jupitus', 'Jupiter');
INSERT INTO public.star VALUES ('Marsius', 12, NULL, 'Marsus', 'Marsus');
INSERT INTO public.star VALUES ('Saturnus', 13, NULL, 'Saturnusus', 'Saturne');
INSERT INTO public.star VALUES ('Neptunus', 14, NULL, 'Neptunus', 'Neptune');
INSERT INTO public.star VALUES ('Uranusus', 15, NULL, 'Uranusus', 'Uranus');
INSERT INTO public.star VALUES ('Proxima Centauri b', 9, NULL, 'Mercurus', 'Mercure');


--
-- Name: constellation constellation_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_name_key UNIQUE (name);


--
-- Name: constellation constellation_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_pkey PRIMARY KEY (constellation_id);


--
-- Name: galaxy galaxy_constellation_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_constellation_key UNIQUE (constellation);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet planet_surnom_lunaire_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_surnom_lunaire_key UNIQUE (surnom_lunaire);


--
-- Name: star star_closest_planet_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_closest_planet_key UNIQUE (closest_planet);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_surnom_lunaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_surnom_lunaire_fkey FOREIGN KEY (surnom_lunaire) REFERENCES public.planet(surnom_lunaire);


--
-- Name: planet planet_closest_planet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_closest_planet_fkey FOREIGN KEY (closest_planet) REFERENCES public.star(closest_planet);


--
-- Name: star star_constellation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_constellation_fkey FOREIGN KEY (constellation) REFERENCES public.galaxy(constellation);


--
-- PostgreSQL database dump complete
--

