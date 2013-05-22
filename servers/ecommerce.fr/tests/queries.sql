
-- Avant Fragmentation

SELECT login, email 
FROM users 
WHERE password = 'XXX';

SELECT u.login, u.email, a.country
FROM users u, addresses a
WHERE u.id = a.user_id;

SELECT *
FROM products
WHERE locale = 'fr-fr';


-- Après Fragmentation


SELECT login, email
FROM users_secure_view
WHERE password = 'XXX'

SELECT u.login, u.email, a.country
FROM users u, addresses a
WHERE u.id = a.user_id;

SELECT *
FROM products_fr;
