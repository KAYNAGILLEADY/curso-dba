-- 1) Mostre os números de 1 a 15

-- a) usando FOR
DO
$$
BEGIN
	FOR cont IN 1..15 LOOP
		RAISE NOTICE '%', cont;
	END LOOP;
END;
$$;


-- b) usando WHILE
DO
$$
DECLARE
	cont int := 1;
BEGIN
	WHILE (cont <= 15) LOOP
		RAISE NOTICE '%', cont;
		cont := cont + 1;
	END LOOP;
END;
$$;

-- c) usando LOOP
DO
$$
DECLARE
	cont int := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', cont;
		cont := cont + 1;
	EXIT WHEN cont > 15;
	END LOOP;
END;
$$;

-- 1.1) Mostre os números de 1 a 15 decrescente

-- a) usando FOR
DO
$$
BEGIN
	FOR cont IN REVERSE 15..1 LOOP
		RAISE NOTICE '%', cont;
	END LOOP;
END;
$$;


-- b) usando WHILE
DO
$$
DECLARE
	cont int := 15;
BEGIN
	WHILE (cont >= 1) LOOP
		RAISE NOTICE '%', cont;
		cont := cont - 1;
	END LOOP;
END;
$$;

-- c) usando LOOP
DO
$$
DECLARE
	cont int := 15;
BEGIN
	LOOP
		RAISE NOTICE '%', cont;
		cont := cont - 1;
	EXIT WHEN cont < 1;
	END LOOP;
END;
$$;

-- 2) Mostre os nomes na tabela autores do banco de dados 
-- da livraria usando FOR.

DO
$$
DECLARE
	registro RECORD;
BEGIN
	FOR registro IN SELECT * FROM livro LOOP
		RAISE NOTICE '%', registro.titulo;
	END LOOP;
END;
$$;