-- Fictional sample records for An IT Learning Management System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active") VALUES (101, 'ava.chen@example.edu', 'Ava Chen', '2026-01-10', TRUE);
INSERT INTO portfolio."learner" ("learner_id", "email", "display_name", "joined_on", "active") VALUES (102, 'noah.patel@example.edu', 'Noah Patel', '2026-01-12', TRUE);
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on") VALUES (201, 'NET101', 'Network Fundamentals', 'Dr. Lina Ortiz', '2026-02-01', '2026-03-15');
INSERT INTO portfolio."course" ("course_id", "course_code", "title", "instructor_name", "starts_on", "ends_on") VALUES (202, 'SEC201', 'Security Principles', 'Prof. Marcus Lee', '2026-02-05', '2026-03-20');
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status") VALUES (301, 101, 201, '2026-01-15', 'active');
INSERT INTO portfolio."enrollment" ("enrollment_id", "learner_id", "course_id", "enrolled_on", "status") VALUES (302, 102, 202, '2026-01-16', 'completed');
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at") VALUES (401, 301, 'Network Quiz', 88, '2026-02-20T10:00:00Z');
INSERT INTO portfolio."assessment_event" ("assessment_event_id", "enrollment_id", "assessment_name", "score", "recorded_at") VALUES (402, 302, 'Security Exam', 76, '2026-03-10T14:30:00Z');
COMMIT;
