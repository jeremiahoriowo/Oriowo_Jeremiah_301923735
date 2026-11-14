-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. learner pk test. Expected: pk_learner, SQLSTATE 23505.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (101, 'pk.test@example.edu', 'PK Test', '2026-04-01', TRUE);

-- 2. learner unique test. Expected: uq_learner_0, SQLSTATE 23505.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (1001, 'ava.chen@example.edu', 'Unique Test', '2026-04-01', TRUE);

-- 3. learner id not null test. Expected: learner_id, SQLSTATE 23502.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (NULL, 'null.id@example.edu', 'Null ID', '2026-04-01', TRUE);

-- 4. learner email not null test. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (1002, NULL, 'Null Email', '2026-04-01', TRUE);

-- 5. learner display name not null test. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (1003, 'null.name@example.edu', NULL, '2026-04-01', TRUE);

-- 6. learner joined on not null test. Expected: joined_on, SQLSTATE 23502.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (1004, 'null.date@example.edu', 'Null Date', NULL, TRUE);

-- 7. learner active not null test. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active")
VALUES (1005, 'null.active@example.edu', 'Null Active', '2026-04-01', NULL);

-- 8. course pk test. Expected: pk_course, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (201, 'PKTEST', 'PK Test', 'Test Instructor', '2026-04-01', '2026-05-01');

-- 9. course unique test. Expected: uq_course_0, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1006, 'NET101', 'Unique Test', 'Test Instructor', '2026-04-01', '2026-05-01');

-- 10. course id not null test. Expected: course_id, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (NULL, 'NULLID', 'Null ID', 'Test Instructor', '2026-04-01', '2026-05-01');

-- 11. course code not null test. Expected: course_code, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1007, NULL, 'Null Code', 'Test Instructor', '2026-04-01', '2026-05-01');

-- 12. course title not null test. Expected: title, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1008, 'NULLTITLE', NULL, 'Test Instructor', '2026-04-01', '2026-05-01');

-- 13. course instructor not null test. Expected: instructor_name, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1009, 'NULLINST', 'Null Instructor', NULL, '2026-04-01', '2026-05-01');

-- 14. course starts on not null test. Expected: starts_on, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1010, 'NULLSTART', 'Null Start', 'Test Instructor', NULL, '2026-05-01');

-- 15. course ends on not null test. Expected: ends_on, SQLSTATE 23502.
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on")
VALUES (1011, 'NULLEND', 'Null End', 'Test Instructor', '2026-04-01', NULL);

-- 16. enrollment pk test. Expected: pk_enrollment, SQLSTATE 23505.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (301, 101, 201, '2026-04-01', 'completed');

-- 17. enrollment learner fk test. Expected: fk_enrollment_0, SQLSTATE 23503.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1012, 9991, 201, '2026-04-01', 'pending');

-- 18. enrollment course fk test. Expected: fk_enrollment_1, SQLSTATE 23503.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1013, 101, 9992, '2026-04-01', 'pending');

-- 19. enrollment id not null test. Expected: enrollment_id, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (NULL, 101, 201, '2026-04-01', 'pending');

-- 20. enrollment learner not null test. Expected: learner_id, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1014, NULL, 201, '2026-04-01', 'pending');

-- 21. enrollment course not null test. Expected: course_id, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1015, 101, NULL, '2026-04-01', 'pending');

-- 22. enrollment date not null test. Expected: enrolled_on, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1016, 101, 201, NULL, 'pending');

-- 23. enrollment status not null test. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (1017, 101, 201, '2026-04-01', NULL);

-- 24. assessment pk test. Expected: pk_assessment_event, SQLSTATE 23505.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (401, 302, 'PK Test', 50, '2026-04-01T10:00:00Z');

-- 25. assessment enrollment fk test. Expected: fk_assessment_event_0, SQLSTATE 23503.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1018, 9993, 'FK Test', 50, '2026-04-01T10:00:00Z');

-- 26. assessment id not null test. Expected: assessment_event_id, SQLSTATE 23502.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (NULL, 302, 'Null ID', 50, '2026-04-01T10:00:00Z');

-- 27. assessment enrollment not null test. Expected: enrollment_id, SQLSTATE 23502.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1019, NULL, 'Null Enrollment', 50, '2026-04-01T10:00:00Z');

-- 28. assessment name not null test. Expected: assessment_name, SQLSTATE 23502.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1020, 302, NULL, 50, '2026-04-01T10:00:00Z');

-- 29. assessment score not null test. Expected: score, SQLSTATE 23502.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1021, 302, 'Null Score', NULL, '2026-04-01T10:00:00Z');

-- 30. assessment recorded at not null test. Expected: recorded_at, SQLSTATE 23502.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1022, 302, 'Null Timestamp', 50, NULL);

-- 31. assessment score range test. Expected: assessment_score_range, SQLSTATE 23514.
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at")
VALUES (1023, 302, 'Invalid Score', 101, '2026-04-01T10:00:00Z');

-- 32. active enrollment partial unique test. Expected: one_active_enrollment_per_pair, SQLSTATE 23505.
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status")
VALUES (303, 101, 201, '2026-04-02', 'active');
