-- Ordem crescente:
DO
$$
BEGIN
	FOR cont IN 1..10 LOOP
		IF (MOD(cont, 2) > 0) THEN
			RAISE NOTICE '%', cont;
		END IF;
	END LOOP;
END
$$;

-- Ordem decrescente: REVERSE
DO
$$
BEGIN
	FOR cont IN REVERSE 10..1 LOOP
		IF (MOD(cont, 2) > 0) THEN
			RAISE NOTICE '%', cont;
		END IF;
	END LOOP;
END
$$;

CREATE OR REPLACE FUNCTION impares () 
RETURNS int LANGUAGE plpgsql AS $$

BEGIN
	FOR cont IN 1..10 LOOP
		IF (MOD(cont, 2) > 0) THEN
			RAISE NOTICE '%', cont;
		END IF;
	END LOOP;
END;
$$;

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


CREATE OR REPLACE FUNCTION anosBissexto ()
RETURNS int LANGUAGE plpgsql AS $$

BEGIN
	FOR ano IN 2000..2100 LOOP 
		IF (MOD(ano,400) = 0 OR (MOD(ano,4) = 0 AND MOD(ano,100) <> 0)) 
		THEN RAISE NOTICE '%', ano;
		END IF;
	END LOOP;
END;
$$;

select impares()
SELECT anosBissexto()

-- 2. Mostre os números da sequência Fibonacci existentes entre 1 e 100.
-- Os números desta sequência são iguais à soma de seus dois antecessores.
-- Dica: guarde os dois últimos números em variáveis.