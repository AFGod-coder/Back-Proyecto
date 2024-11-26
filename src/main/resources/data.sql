-- Insertar roles si no existen
INSERT INTO roles (name)
SELECT 'ROLE_USER'
    WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER');

INSERT INTO roles (name)
SELECT 'ROLE_ADMIN'
    WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_ADMIN');

-- Insertar admin si no existe
INSERT INTO users (user_name, email, password, phone_number, seller, user_image)
SELECT 'admin', 'admin@admin.com', '$2a$10$VReY3QH7imZ29.gAVgiy3.nPWVAMTE6o5t0YaZ32xB05lohtygByO', '3204920412', true, 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/deportes-con-balones.png'
    WHERE NOT EXISTS (SELECT 1 FROM users WHERE user_name = 'admin');

INSERT INTO users_roles (user_id, rol_id)
SELECT u.id, r.id
FROM users u, roles r
WHERE u.user_name = 'admin'
  AND r.name = 'ROLE_ADMIN'
  AND NOT EXISTS (
    SELECT 1 FROM users_roles
    WHERE user_id = u.id AND rol_id = r.id
);

--Insertar Categorias de productos
INSERT INTO public.product_categories(
    product_category_id, category_name, category_description, category_image)
VALUES
    (1, 'Tecnología', 'Productos electrónicos, gadgets y más', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/tecnologia.png'),
    (2, 'Libros y Material Académico', 'Libros de texto, guías de estudio', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/libros.png'),
    (3, 'Ropa y Accesorios', 'Ropa casual, deportiva, accesorios de moda y calzado', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/ropa-limpia.png'),
    (4, 'Hogar y Decoración', 'Artículos para el hogar, decoración y muebles pequeños', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/muebles.png'),
    (5, 'Deportes', 'Equipamiento deportivo y ropa deportiva', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/deportes-con-balones.png'),
    (6, 'Salud y Belleza', 'Productos de cuidado personal', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/terapia.png'),
    (7, 'Juguetes y Juegos', 'Juguetes educativos y juegos de mesa', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/coche-rc.png'),
    (8, 'Otros', 'Productos variados ', 'https://aplication-web-storage.s3.us-east-2.amazonaws.com/otros.png')
    ON CONFLICT (product_category_id) DO NOTHING;  -- Evita duplicados .