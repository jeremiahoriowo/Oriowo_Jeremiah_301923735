-- An IT Learning Management System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."learner" (
  "learner_id" bigint NOT NULL,
  "email" text NOT NULL,
  "display_name" text NOT NULL,
  "joined_on" date NOT NULL,
  "active" boolean NOT NULL,
  CONSTRAINT "pk_learner" PRIMARY KEY ("learner_id"),
  CONSTRAINT "uq_learner_0" UNIQUE ("email")
);
CREATE TABLE portfolio."course" (
  "course_id" bigint NOT NULL,
  "course_code" text NOT NULL,
  "title" text NOT NULL,
  "instructor_name" text NOT NULL,
  "starts_on" date NOT NULL,
  "ends_on" date NOT NULL,
  CONSTRAINT "pk_course" PRIMARY KEY ("course_id"),
  CONSTRAINT "uq_course_0" UNIQUE ("course_code")
);
CREATE TABLE portfolio."enrollment" (
  "enrollment_id" bigint NOT NULL,
  "learner_id" bigint NOT NULL,
  "course_id" bigint NOT NULL,
  "enrolled_on" date NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_enrollment" PRIMARY KEY ("enrollment_id")
);
CREATE TABLE portfolio."assessment_event" (
  "assessment_event_id" bigint NOT NULL,
  "enrollment_id" bigint NOT NULL,
  "assessment_name" text NOT NULL,
  "score" numeric(18,2) NOT NULL,
  "recorded_at" timestamptz NOT NULL,
  CONSTRAINT "pk_assessment_event" PRIMARY KEY ("assessment_event_id")
);
ALTER TABLE portfolio."enrollment" ADD CONSTRAINT "fk_enrollment_0" FOREIGN KEY ("learner_id") REFERENCES portfolio."learner" ("learner_id");
ALTER TABLE portfolio."enrollment" ADD CONSTRAINT "fk_enrollment_1" FOREIGN KEY ("course_id") REFERENCES portfolio."course" ("course_id");
ALTER TABLE portfolio."assessment_event" ADD CONSTRAINT "fk_assessment_event_0" FOREIGN KEY ("enrollment_id") REFERENCES portfolio."enrollment" ("enrollment_id");
ALTER TABLE portfolio."assessment_event" ADD CONSTRAINT "assessment_score_range" CHECK (("score" >= 0) AND ("score" <= 100));
CREATE UNIQUE INDEX "one_active_enrollment_per_pair" ON portfolio."enrollment" ("learner_id", "course_id") WHERE ("status" = 'active');
COMMIT;
