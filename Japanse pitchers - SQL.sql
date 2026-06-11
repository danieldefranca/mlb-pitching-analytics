USE MLB

SELECT * FROM tb_japan
WHERE player_name_eng = 'Shohei Ohtani' AND pitch_name = 'Sweeper'

CREATE VIEW vw_japan AS SELECT * FROM tb_japan

SELECT * FROM vw_japan
ORDER BY pitch_type

UPDATE vw_japan
SET release_speed = release_speed / 10.0;

CREATE VIEW vw_japan_clean AS
SELECT * FROM vw_japan WHERE pitch_type IS NOT NULL
AND release_speed IS NOT NULL


SELECT * FROM vw_japan_clean 
ORDER BY release_pos_z


UPDATE vw_japan_clean
SET release_pos_x = release_pos_x / 100.0

UPDATE vw_japan_clean
SET release_pos_z =
    CASE 
        WHEN release_pos_z >= 12 AND release_pos_z <= 74 THEN release_pos_z / 10.0
        ELSE release_pos_z
    END;


UPDATE vw_japan_clean
SET release_pos_z =
    CASE 
        WHEN release_pos_z >= 95 AND release_pos_z <= 99 THEN release_pos_z / 100.0
        ELSE release_pos_z
    END;


UPDATE vw_japan_clean
SET release_pos_z =
    CASE 
        WHEN release_pos_z >= 100 AND release_pos_z <= 800 THEN release_pos_z / 100.0
        ELSE release_pos_z
    END;



SELECT * FROM vw_japan_clean 
ORDER BY zone

UPDATE vw_japan_clean
SET zone = zone / 10.0



SELECT * FROM vw_japan_clean 
ORDER BY plate_z

UPDATE vw_japan_clean
SET pfx_x = pfx_x / 100.0

UPDATE vw_japan_clean
SET pfx_z = pfx_z / 100.0

UPDATE vw_japan_clean
SET plate_x = plate_x / 100.0, 
    plate_z = plate_z / 100.0


 
SELECT * FROM vw_japan_clean
WHERE hit_distance_sc IS NOT NULL
/* 33118 linhas */

 
SELECT * FROM vw_japan_clean
WHERE launch_speed IS NOT NULL
/* 33938 linhas */

SELECT * FROM vw_japan_clean
ORDER BY hit_distance_sc


SELECT hit_distance_sc, description FROM vw_japan_clean
WHERE hit_distance_sc = 0
ORDER BY hit_distance_sc

SELECT 
    events,
    COUNT(*) AS qtd
FROM vw_japan_clean
WHERE hit_distance_sc = 0
GROUP BY events
ORDER BY qtd DESC;


SELECT *
FROM vw_japan_clean
WHERE hit_distance_sc = NULL
  AND description = 'hit_into_play';

UPDATE vw_japan_clean
SET hit_distance_sc = NULL
WHERE hit_distance_sc = 0
  AND description = 'hit_into_play';



SELECT * FROM vw_japan_clean
ORDER BY woba_value

SELECT launch_angle, description, events,  des
FROM vw_japan_clean
WHERE launch_angle IS NULL AND description = 'hit_into_play'
ORDER BY events


SELECT 
    description,
    COUNT(*) AS qtd
FROM vw_japan_clean
WHERE launch_speed IS NULL
GROUP BY description
ORDER BY qtd DESC;


UPDATE vw_japan_clean
SET launch_speed = launch_speed / 10.0

UPDATE vw_japan_clean
SET hit_distance_sc = hit_distance_sc / 10.0

UPDATE vw_japan_clean
SET launch_angle = launch_angle / 10.0

UPDATE vw_japan_clean
SET effective_speed = effective_speed / 10.0

UPDATE vw_japan_clean
SET release_spin_rate = release_spin_rate / 10.0

UPDATE vw_japan_clean
SET release_extension = release_extension / 10.0

SELECT estimated_ba_using_speedangle, des FROM vw_japan_clean
WHERE estimated_ba_using_speedangle IS NULL

SELECT * FROM vw_japan_clean
ORDER BY estimated_slg_using_speedangle

UPDATE vw_japan_clean
SET estimated_ba_using_speedangle = estimated_ba_using_speedangle / 10.0

UPDATE vw_japan_clean
SET spin_axis = spin_axis / 10.0


SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_japan_clean'
  AND COLUMN_NAME = 'estimated_slg_using_speedangle';

SELECT TOP 200 estimated_slg_using_speedangle
FROM vw_japan_clean
ORDER BY estimated_slg_using_speedangle DESC;


SELECT * FROM vw_japan_clean
ORDER BY api_break_z_with_gravity

UPDATE vw_japan_clean
SET arm_angle = arm_angle / 10.0


UPDATE vw_japan_clean
SET api_break_z_with_gravity =
    CASE 
        WHEN api_break_z_with_gravity < 0 THEN api_break_z_with_gravity / 100.0
        ELSE api_break_z_with_gravity
    END;


UPDATE vw_japan_clean
SET api_break_z_with_gravity =
    CASE 
        WHEN api_break_z_with_gravity >= 0 THEN api_break_z_with_gravity / 100.0
        ELSE api_break_z_with_gravity
    END;


SELECT * FROM vw_japan_clean
ORDER BY api_break_x_batter_in

UPDATE vw_japan_clean
SET api_break_x_arm = api_break_x_arm / 100.0 

UPDATE vw_japan_clean
SET api_break_x_batter_in = api_break_x_batter_in / 100.0 


SELECT * FROM vw_japan_clean
ORDER BY game_type


SELECT *
FROM tb_japan
WHERE game_type = 'S';


BEGIN TRANSACTION;

DELETE FROM tb_japan
WHERE game_type = 'S';

SELECT COUNT(*) FROM tb_japan WHERE game_type = 'S';

COMMIT;

-- caso dê problema
-- ROLLBACK;


BEGIN TRANSACTION;

DELETE FROM vw_japan_clean
WHERE player_name = 'Clippard, Tyler';

SELECT COUNT(*) FROM vw_japan_clean WHERE player_name = 'Clippard, Tyler';

COMMIT;


SELECT * FROM vw_japan_clean