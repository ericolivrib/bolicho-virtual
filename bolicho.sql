--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

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
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    usuario_id integer
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cliente ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    id integer NOT NULL,
    valor numeric(16,2),
    data_pedido date,
    cliente_id integer,
    vendedor_id integer,
    item_id integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- Name: compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pedido ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id integer NOT NULL,
    rua text NOT NULL,
    numero_casa integer,
    bairro text NOT NULL,
    complemento text
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- Name: endereco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.endereco ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.endereco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: item_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_compra (
    id integer NOT NULL,
    quantidade integer,
    produto_id integer
);


ALTER TABLE public.item_compra OWNER TO postgres;

--
-- Name: item_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.item_compra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.item_compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: permissao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissao (
    id integer NOT NULL,
    descricao text NOT NULL
);


ALTER TABLE public.permissao OWNER TO postgres;

--
-- Name: permissao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.permissao ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id integer NOT NULL,
    nome text NOT NULL,
    preco numeric(16,2),
    detalhes text DEFAULT 'Produto colonial'::text NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produto ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: status_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_compra (
    id integer NOT NULL,
    descricao text NOT NULL,
    data_status date,
    motivo text
);


ALTER TABLE public.status_compra OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.status_compra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome text NOT NULL,
    telefone text NOT NULL,
    email text NOT NULL,
    senha text NOT NULL,
    endereco_id integer,
    data_cadastro date,
    ativo boolean
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.usuario ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: usuario_permissao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_permissao (
    id integer NOT NULL,
    usuario_id integer,
    permissao_id integer
);


ALTER TABLE public.usuario_permissao OWNER TO postgres;

--
-- Name: usuario_permissao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.usuario_permissao ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vendedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedor (
    id integer NOT NULL,
    usuario_id integer
);


ALTER TABLE public.vendedor OWNER TO postgres;

--
-- Name: vendedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vendedor ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vendedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, usuario_id) FROM stdin;
2	7
4	12
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (id, valor, data_pedido, cliente_id, vendedor_id, item_id, status_id) FROM stdin;
12	30.00	2021-08-11	4	3	13	12
13	122.20	2021-08-11	4	5	14	13
\.


--
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco (id, rua, numero_casa, bairro, complemento) FROM stdin;
7	Avenida Roraima	1000	Camobi	CEU II
8	Avenida Roraima	1000	Caturrita	
10	Avenida Roraima	1000	Camobi	
12	Avenida Roraima 	1000	Camobi	
13	Davenir Pereira	103	ChÃ¡cara das Flores	Onde o vento faz a curva
14	Avenida Roraima	1000	Camobi	CEU II
16	Avenida Roraima	1000	Camobi	CEU II
\.


--
-- Data for Name: item_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_compra (id, quantidade, produto_id) FROM stdin;
4	2	7
5	3	7
6	3	7
7	5	2
8	5	2
9	4	6
10	3	6
11	6	7
12	3	2
13	6	2
14	4	10
\.


--
-- Data for Name: permissao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissao (id, descricao) FROM stdin;
1	CLIENTE
2	VENDEDOR
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id, nome, preco, detalhes) FROM stdin;
2	Chimia	5.00	Produto colonial
1	Queijo da Colonia	27.49	Produto colonial
6	Licor 600ml	20.56	Produto colonial
7	Conserva de Pepino	7.00	Produto colonial
10	Cachaca	30.55	Ingredientes
\.


--
-- Data for Name: status_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status_compra (id, descricao, data_status, motivo) FROM stdin;
4	CONCLUÍDO	2021-08-10	\N
5	CANCELADO	2021-08-10	O cliente desistiu!
7	CANCELADO	2021-08-11	O cliente desistiu!
9	CANCELADO	2021-08-11	Cancelado pelo cliente
6	CONCLUÃDO	2021-08-11	
8	CONCLUÃDO	2021-08-11	
10	CONCLUIDO	2021-08-11	
11	CONCLUÃDO	2021-08-11	
13	CANCELADO	2021-08-11	Faltou cachaÃ§a
12	CONCLUIDO	2021-08-11	
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nome, telefone, email, senha, endereco_id, data_cadastro, ativo) FROM stdin;
7	Diogo Santana	88 88888-8888	diogosantana@teste.com	940299	8	2021-08-05	\N
11	Helena Oliveira	99 99999-9999	helenaoliveira@teste.com	9930405	12	2021-08-05	\N
12	Erico Ribeiro	99 99999-9999	ericoribeiro@teste.com	9930394	13	2021-08-11	\N
13	Magno Alves	44 44444-4444	magnoalves@teste.com	003304405	14	2021-08-11	\N
15	Glenio D.	00 00000-0022	gleniodescovi@teste.com	imnfisdfin	16	2021-08-11	\N
\.


--
-- Data for Name: usuario_permissao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_permissao (id, usuario_id, permissao_id) FROM stdin;
1	7	1
4	11	2
5	12	1
6	13	2
8	15	2
\.


--
-- Data for Name: vendedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendedor (id, usuario_id) FROM stdin;
3	11
4	13
5	15
\.


--
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 5, true);


--
-- Name: compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compra_id_seq', 13, true);


--
-- Name: endereco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_id_seq', 16, true);


--
-- Name: item_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_compra_id_seq', 14, true);


--
-- Name: permissao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissao_id_seq', 2, true);


--
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_seq', 10, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 13, true);


--
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 15, true);


--
-- Name: usuario_permissao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_permissao_id_seq', 8, true);


--
-- Name: vendedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedor_id_seq', 5, true);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- Name: pedido compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id);


--
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- Name: item_compra item_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_compra
    ADD CONSTRAINT item_compra_pkey PRIMARY KEY (id);


--
-- Name: permissao permissao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT permissao_pkey PRIMARY KEY (id);


--
-- Name: produto produto_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_nome_key UNIQUE (nome);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- Name: status_compra status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_compra
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_email_telefone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_telefone_key UNIQUE (email, telefone);


--
-- Name: usuario_permissao usuario_permissao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: vendedor vendedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id);


--
-- Name: cliente cliente_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- Name: pedido compra_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT compra_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: pedido compra_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT compra_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item_compra(id) NOT VALID;


--
-- Name: pedido compra_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT compra_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status_compra(id) NOT VALID;


--
-- Name: pedido compra_vendedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT compra_vendedor_id_fkey FOREIGN KEY (vendedor_id) REFERENCES public.vendedor(id);


--
-- Name: item_compra item_compra_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_compra
    ADD CONSTRAINT item_compra_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- Name: usuario usuario_endereco_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_endereco_id_fkey FOREIGN KEY (endereco_id) REFERENCES public.endereco(id);


--
-- Name: usuario_permissao usuario_permissao_permissao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_permissao_id_fkey FOREIGN KEY (permissao_id) REFERENCES public.permissao(id);


--
-- Name: usuario_permissao usuario_permissao_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- Name: vendedor vendedor_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- PostgreSQL database dump complete
--

