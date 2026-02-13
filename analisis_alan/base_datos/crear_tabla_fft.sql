-- Creación de tabla (básica, con id y permite valores flotantes)
CREATE TABLE fft(
    id  INTEGER PRIMARY KEY,
    distal  NUMERIC(10, 7),
    medial NUMERIC(10, 7),
    proximal    NUMERIC(10, 7)
);