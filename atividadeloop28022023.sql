-- 1) Mostrar os anos bissextos existentes entre 2000 e 2100.
CREATE OR REPLACE FUNCTION anosBissexto ()
RETURNS int LANGUAGE plpgsql AS $$

BEGIN
	FOR ano IN 2000..2100 LOOP 
		IF (ano%400 = 0 OR (ano%4 = 0 AND ano%100 <> 0)) 
		THEN RAISE NOTICE '%', ano;
		END IF;
	END LOOP;
END;
$$;

SELECT anosBissexto()

-- 2) Mostrar os números pertencentes à sequência Fibonacci existentes entre 1 e 100.
DO
$$
DECLARE
	ultimo int := 1;
	penultimo int := 0;

BEGIN
	FOR atual IN 1..100 LOOP
		IF (atual = (ultimo + penultimo)) THEN
			RAISE NOTICE '%', atual;
			penultimo := ultimo;
			ultimo := atual;
		END IF;
	END LOOP;
END
$$

-- 3) Crie uma procedure que mostre os números múltiplos de 2 e 3 existentes entre 1 e 500.
DO
$$
BEGIN
	FOR cont IN 1..500 LOOP
		IF (cont%2 = 0 AND cont%3 = 0) THEN
			RAISE NOTICE '%', cont;
		END IF;
	END LOOP;
END
$$

-- 3.1) Some os resultados dos multíplos de 2 e de 3 e mostre no resultado.
DO
$$
DECLARE
	soma int;
BEGIN
	soma := 0;
	FOR cont IN 1..500 LOOP
		IF (cont%2 = 0 AND cont%3 = 0) THEN
			RAISE NOTICE '%', cont;
			soma := soma + cont;
		END IF;
	END LOOP;
	RAISE NOTICE 'A soma é: %', soma;
END
$$

