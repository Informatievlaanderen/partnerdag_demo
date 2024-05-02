-- Table: public.telraam

-- DROP TABLE IF EXISTS public.telraam;


CREATE TABLE IF NOT EXISTS public.geomobility
(
    id character varying,
    object text,
    telling double precision,
    fiets double precision,
    auto double precision,
    zwaar double precision,
    voetganger double precision,
    snelheidv85 double precision,
    tijd text,
    sensor text,
    wegsegment text,
    geometry geometry(geometry, 4326)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.geomobility OWNER to ldes;

CREATE OR REPLACE FUNCTION update_geometry()
RETURNS TRIGGER AS
$$
BEGIN
    -- Assuming SRID 4326; no need to specify it here as the column already enforces it
    NEW.geometry := ST_GeomFromText(NEW.wegsegment, 4326);
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

-- Step 4: Create a trigger that calls the function before inserting or updating the table row
CREATE TRIGGER trig_update_geom
BEFORE INSERT OR UPDATE ON geomobility
FOR EACH ROW EXECUTE FUNCTION update_geometry();