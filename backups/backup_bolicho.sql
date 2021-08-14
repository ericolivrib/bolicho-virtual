PGDMP                         y            bolicho_virtual    13.3    13.3 B               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    19151    bolicho_virtual    DATABASE     o   CREATE DATABASE bolicho_virtual WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE bolicho_virtual;
                postgres    false            �            1259    19181    cliente    TABLE     Q   CREATE TABLE public.cliente (
    id integer NOT NULL,
    usuario_id integer
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    19179    cliente_id_seq    SEQUENCE     �   ALTER TABLE public.cliente ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    19217    compra    TABLE     �   CREATE TABLE public.compra (
    id integer NOT NULL,
    valor numeric(16,2),
    data_pedido date,
    cliente_id integer,
    vendedor_id integer,
    item_id integer NOT NULL,
    status_id integer NOT NULL
);
    DROP TABLE public.compra;
       public         heap    postgres    false            �            1259    19215    compra_id_seq    SEQUENCE     �   ALTER TABLE public.compra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    19154    endereco    TABLE     �   CREATE TABLE public.endereco (
    id integer NOT NULL,
    rua text NOT NULL,
    numero_casa integer,
    bairro text NOT NULL,
    complemento text
);
    DROP TABLE public.endereco;
       public         heap    postgres    false            �            1259    19152    endereco_id_seq    SEQUENCE     �   ALTER TABLE public.endereco ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.endereco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    201            �            1259    19234    item_compra    TABLE     m   CREATE TABLE public.item_compra (
    id integer NOT NULL,
    quantidade integer,
    produto_id integer
);
    DROP TABLE public.item_compra;
       public         heap    postgres    false            �            1259    19232    item_compra_id_seq    SEQUENCE     �   ALTER TABLE public.item_compra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.item_compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �            1259    19295 	   permissao    TABLE     X   CREATE TABLE public.permissao (
    id integer NOT NULL,
    descricao text NOT NULL
);
    DROP TABLE public.permissao;
       public         heap    postgres    false            �            1259    19293    permissao_id_seq    SEQUENCE     �   ALTER TABLE public.permissao ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    19205    produto    TABLE     �   CREATE TABLE public.produto (
    id integer NOT NULL,
    nome text NOT NULL,
    preco numeric(16,2),
    detalhes text DEFAULT 'Produto colonial'::text NOT NULL
);
    DROP TABLE public.produto;
       public         heap    postgres    false            �            1259    19203    produto_id_seq    SEQUENCE     �   ALTER TABLE public.produto ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    19338    status_compra    TABLE     �   CREATE TABLE public.status_compra (
    id integer NOT NULL,
    descricao text NOT NULL,
    data_status date,
    motivo text
);
 !   DROP TABLE public.status_compra;
       public         heap    postgres    false            �            1259    19336    status_id_seq    SEQUENCE     �   ALTER TABLE public.status_compra ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    19164    usuario    TABLE     �   CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome text NOT NULL,
    telefone text NOT NULL,
    email text NOT NULL,
    senha text NOT NULL,
    endereco_id integer,
    data_cadastro date
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    19162    usuario_id_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    203            �            1259    19305    usuario_permissao    TABLE     u   CREATE TABLE public.usuario_permissao (
    id integer NOT NULL,
    usuario_id integer,
    permissao_id integer
);
 %   DROP TABLE public.usuario_permissao;
       public         heap    postgres    false            �            1259    19303    usuario_permissao_id_seq    SEQUENCE     �   ALTER TABLE public.usuario_permissao ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    19193    vendedor    TABLE     R   CREATE TABLE public.vendedor (
    id integer NOT NULL,
    usuario_id integer
);
    DROP TABLE public.vendedor;
       public         heap    postgres    false            �            1259    19191    vendedor_id_seq    SEQUENCE     �   ALTER TABLE public.vendedor ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vendedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207                      0    19181    cliente 
   TABLE DATA           1   COPY public.cliente (id, usuario_id) FROM stdin;
    public          postgres    false    205   �K                 0    19217    compra 
   TABLE DATA           e   COPY public.compra (id, valor, data_pedido, cliente_id, vendedor_id, item_id, status_id) FROM stdin;
    public          postgres    false    211   �K                 0    19154    endereco 
   TABLE DATA           M   COPY public.endereco (id, rua, numero_casa, bairro, complemento) FROM stdin;
    public          postgres    false    201   )L                 0    19234    item_compra 
   TABLE DATA           A   COPY public.item_compra (id, quantidade, produto_id) FROM stdin;
    public          postgres    false    213   �L                 0    19295 	   permissao 
   TABLE DATA           2   COPY public.permissao (id, descricao) FROM stdin;
    public          postgres    false    215   M                 0    19205    produto 
   TABLE DATA           <   COPY public.produto (id, nome, preco, detalhes) FROM stdin;
    public          postgres    false    209   JM                 0    19338    status_compra 
   TABLE DATA           K   COPY public.status_compra (id, descricao, data_status, motivo) FROM stdin;
    public          postgres    false    219   �M                 0    19164    usuario 
   TABLE DATA           _   COPY public.usuario (id, nome, telefone, email, senha, endereco_id, data_cadastro) FROM stdin;
    public          postgres    false    203   ~N                 0    19305    usuario_permissao 
   TABLE DATA           I   COPY public.usuario_permissao (id, usuario_id, permissao_id) FROM stdin;
    public          postgres    false    217   hO       
          0    19193    vendedor 
   TABLE DATA           2   COPY public.vendedor (id, usuario_id) FROM stdin;
    public          postgres    false    207   �O                  0    0    cliente_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cliente_id_seq', 5, true);
          public          postgres    false    204                       0    0    compra_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.compra_id_seq', 13, true);
          public          postgres    false    210                       0    0    endereco_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.endereco_id_seq', 16, true);
          public          postgres    false    200                        0    0    item_compra_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.item_compra_id_seq', 14, true);
          public          postgres    false    212            !           0    0    permissao_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.permissao_id_seq', 2, true);
          public          postgres    false    214            "           0    0    produto_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.produto_id_seq', 10, true);
          public          postgres    false    208            #           0    0    status_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.status_id_seq', 13, true);
          public          postgres    false    218            $           0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 15, true);
          public          postgres    false    202            %           0    0    usuario_permissao_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.usuario_permissao_id_seq', 8, true);
          public          postgres    false    216            &           0    0    vendedor_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.vendedor_id_seq', 5, true);
          public          postgres    false    206            f           2606    19185    cliente cliente_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    205            n           2606    19221    compra compra_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    211            `           2606    19161    endereco endereco_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_pkey;
       public            postgres    false    201            p           2606    19238    item_compra item_compra_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.item_compra
    ADD CONSTRAINT item_compra_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.item_compra DROP CONSTRAINT item_compra_pkey;
       public            postgres    false    213            r           2606    19302    permissao permissao_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.permissao
    ADD CONSTRAINT permissao_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.permissao DROP CONSTRAINT permissao_pkey;
       public            postgres    false    215            j           2606    19214    produto produto_nome_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_nome_key UNIQUE (nome);
 B   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_nome_key;
       public            postgres    false    209            l           2606    19212    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    209            v           2606    19345    status_compra status_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.status_compra
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.status_compra DROP CONSTRAINT status_pkey;
       public            postgres    false    219            b           2606    19173 "   usuario usuario_email_telefone_key 
   CONSTRAINT     h   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_telefone_key UNIQUE (email, telefone);
 L   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_telefone_key;
       public            postgres    false    203    203            t           2606    19309 (   usuario_permissao usuario_permissao_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.usuario_permissao DROP CONSTRAINT usuario_permissao_pkey;
       public            postgres    false    217            d           2606    19171    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    203            h           2606    19197    vendedor vendedor_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT vendedor_pkey;
       public            postgres    false    207            x           2606    19186    cliente cliente_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);
 I   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_usuario_id_fkey;
       public          postgres    false    205    203    2916            z           2606    19222    compra compra_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);
 G   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_cliente_id_fkey;
       public          postgres    false    211    2918    205            |           2606    19357    compra compra_item_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.item_compra(id) NOT VALID;
 D   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_item_id_fkey;
       public          postgres    false    211    2928    213            }           2606    19362    compra compra_status_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status_compra(id) NOT VALID;
 F   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_status_id_fkey;
       public          postgres    false    219    211    2934            {           2606    19227    compra compra_vendedor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_vendedor_id_fkey FOREIGN KEY (vendedor_id) REFERENCES public.vendedor(id);
 H   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_vendedor_id_fkey;
       public          postgres    false    207    211    2920            ~           2606    19239 '   item_compra item_compra_produto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.item_compra
    ADD CONSTRAINT item_compra_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(id);
 Q   ALTER TABLE ONLY public.item_compra DROP CONSTRAINT item_compra_produto_id_fkey;
       public          postgres    false    213    209    2924            w           2606    19174     usuario usuario_endereco_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_endereco_id_fkey FOREIGN KEY (endereco_id) REFERENCES public.endereco(id);
 J   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_endereco_id_fkey;
       public          postgres    false    201    203    2912            �           2606    19315 5   usuario_permissao usuario_permissao_permissao_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_permissao_id_fkey FOREIGN KEY (permissao_id) REFERENCES public.permissao(id);
 _   ALTER TABLE ONLY public.usuario_permissao DROP CONSTRAINT usuario_permissao_permissao_id_fkey;
       public          postgres    false    215    2930    217                       2606    19310 3   usuario_permissao usuario_permissao_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_permissao
    ADD CONSTRAINT usuario_permissao_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);
 ]   ALTER TABLE ONLY public.usuario_permissao DROP CONSTRAINT usuario_permissao_usuario_id_fkey;
       public          postgres    false    203    2916    217            y           2606    19198 !   vendedor vendedor_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);
 K   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT vendedor_usuario_id_fkey;
       public          postgres    false    2916    207    203                  x�3�4�2�44����� |�         5   x�]��	  ���.mUp��C�)�|]%!��V�1��K��ʗ'<��]$b
8         �   x���1
�@��z�s�5��R)���3����d��֓x���(���oA����AQ*�5�P�*�団/�Ԫ�bk�v�N��@Fk�Be��������,��F�����]��D��傻@�V;����c�c�i����V0         =   x���� �R1�e�IzI�uD������4�rc!�\�(4,��+��ruT�(��?yp	�         "   x�3�t��t�q�2�s�squ������ P�         �   x�m�1�0 g�~A
IĜ	���,VbQ�4Fi��Ab,��t7@�do���k�VŬU�P5�m,O�B�~�hO��*Y;��
��>�I���MXG~IS����2���pi��E�����5�| �:�         �   x�3�t��s�	=����id`d�k`�kh���e��������*㯐����W����Z�Y\�Y��e�M�!V��ؕ:'�%��$��+�����q����|�U�n)�+!r���x4cw�[bNI~�BrbrF"P��D.C#���qqq )�X         �   x�]��j� ���S��јVo[��^J���b7Hb���ɖ���������g�c��!�!pN:�₁Y�����>��-���A�:���^�S��m�� �K�Q\����6ߢ����x^����|g�̖+�s�ނn�]Z�zzc��i�bk��(.��b[�ڷ�7�^�7(�sS/I�(Dc`��C,}�蠢9]�J����F�v{i         +   x�3�4�4�2�44�4�2�44��8��<NCS ���� dp�      
      x�3�44�2�44�2�44����� A�     