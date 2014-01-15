-- Speed joins from actors to casts, specifically #5
CREATE INDEX ON casts (pid);

-- Speeds joins from casts to movies, specifically #5
CREATE INDEX ON casts (mid);