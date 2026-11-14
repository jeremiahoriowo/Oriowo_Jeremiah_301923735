-- Show related enrollment, learner, course records (up to 20).
SELECT t0."enrollment_id" AS "enrollment_enrollment_id",
       t0."enrolled_on" AS "enrollment_enrolled_on",
       t1."learner_id" AS "learner_learner_id",
       t1."email" AS "learner_email",
       t2."course_id" AS "course_course_id",
       t2."course_code" AS "course_course_code"
FROM portfolio."enrollment" t0
JOIN portfolio."learner" t1 ON t0."learner_id" = t1."learner_id"
JOIN portfolio."course" t2 ON t0."course_id" = t2."course_id"
ORDER BY t0."enrollment_id", t1."learner_id", t2."course_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."enrollment_id" AS "enrollment_enrollment_id",
       t0."enrolled_on" AS "enrollment_enrolled_on",
       t1."learner_id" AS "learner_learner_id",
       t1."email" AS "learner_email",
       t2."course_id" AS "course_course_id",
       t2."course_code" AS "course_course_code"
FROM portfolio."enrollment" t0
JOIN portfolio."learner" t1 ON t0."learner_id" = t1."learner_id"
JOIN portfolio."course" t2 ON t0."course_id" = t2."course_id"
ORDER BY t0."enrollment_id", t1."learner_id", t2."course_id"
LIMIT 20;

-- Find enrollment records where status matches "active" (up to 20).
SELECT * FROM portfolio."enrollment"
WHERE "status" IS NOT DISTINCT FROM 'active'
ORDER BY "enrollment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."enrollment"
WHERE "status" IS NOT DISTINCT FROM 'active'
ORDER BY "enrollment_id"
LIMIT 20;

-- Count enrollment records for each learner_id (up to 20 groups).
SELECT "learner_id", count(*) AS record_count
FROM portfolio."enrollment"
GROUP BY "learner_id"
ORDER BY record_count DESC, "learner_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "learner_id", count(*) AS record_count
FROM portfolio."enrollment"
GROUP BY "learner_id"
ORDER BY record_count DESC, "learner_id" NULLS LAST
LIMIT 20;

-- Count assessment_event records for each enrollment_id (up to 20 groups).
SELECT "enrollment_id", count(*) AS record_count
FROM portfolio."assessment_event"
GROUP BY "enrollment_id"
ORDER BY record_count DESC, "enrollment_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "enrollment_id", count(*) AS record_count
FROM portfolio."assessment_event"
GROUP BY "enrollment_id"
ORDER BY record_count DESC, "enrollment_id" NULLS LAST
LIMIT 20;
