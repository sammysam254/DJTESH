-- Remove duplicate users, keeping only the first one for each id
DELETE FROM users a USING users b
WHERE a.id = b.id 
AND a.created_at > b.created_at;

-- Verify no duplicates remain
SELECT id, email, COUNT(*) 
FROM users 
GROUP BY id, email 
HAVING COUNT(*) > 1;
