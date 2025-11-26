/* ============================================================
   BASE DE DATOS: ejemplo
   Autor: (Andrea Pearl "marco")
   Descripción: Modelo base para gestión de usuarios y perfiles
   Versión: 1.0
   ============================================================ */

-- Crear base de datos con configuración recomendada
CREATE DATABASE IF NOT EXISTS ejemplo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ejemplo;

/* ============================================================
   TABLA: perfil
   Descripción: Catálogo de roles/perfiles disponibles en el sistema
   ============================================================ */

CREATE TABLE IF NOT EXISTS perfil (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

/* Datos iniciales del catálogo de perfiles */
INSERT INTO perfil (nombre) VALUES
('Administrador'),
('Operador'),
('Invitado');

/* ============================================================
   TABLA: usuario
   Descripción: Usuarios del sistema vinculados a un perfil
   ============================================================ */

CREATE TABLE IF NOT EXISTS usuario (
    usuario VARCHAR(30) NOT NULL,
    pass VARCHAR(255) NOT NULL,  -- espacio para hash seguro
    nombre VARCHAR(100) NOT NULL,
    idperfil INT UNSIGNED NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo TINYINT(1) DEFAULT 1,
    PRIMARY KEY (usuario),

    CONSTRAINT fk_usuario_perfil
        FOREIGN KEY (idperfil)
        REFERENCES perfil(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

/* Datos iniciales de usuarios */
/* Nota: en un entorno real deberías guardar contraseñas hasheadas */
INSERT INTO usuario (usuario, pass, nombre, idperfil) VALUES
('alex', '1234', 'Alejandro Vala', 1),
('juan', '5678', 'Juan Rosas', 2);

/* ============================================================
   Índices adicionales (mejoran rendimiento en consultas grandes)
   ============================================================ */
CREATE INDEX idx_usuario_perfil ON usuario(idperfil);
