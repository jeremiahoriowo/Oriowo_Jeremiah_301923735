# An IT Learning Management System — database design

My case study records learner, course, enrollment, assessment_event.

## Users

- learners
- instructors
- registrars
- academic administrators

## Main operations

- register a learner for a course
- record an assessment result
- review learner progress
- produce course enrollment reports

## Entities

| Entity | Information stored |
| --- | --- |
| learner | Stores people registered to use the learning management system. |
| course | Stores IT courses offered by the learning management system. |
| enrollment | Associates a learner with a course and records registration status. |
| assessment_event | Records a learner assessment result within an enrollment. |

## learner

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| learner_id | BIGINT | PK | Yes |
| email | TEXT | Unique | Yes |
| display_name | TEXT |  | Yes |
| joined_on | DATE |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (email).

## course

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| course_id | BIGINT | PK | Yes |
| course_code | TEXT | Unique | Yes |
| title | TEXT |  | Yes |
| instructor_name | TEXT |  | Yes |
| starts_on | DATE |  | Yes |
| ends_on | DATE |  | Yes |
- Unique key: (course_code).

## enrollment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| enrollment_id | BIGINT | PK | Yes |
| learner_id | BIGINT | FK | Yes |
| course_id | BIGINT | FK | Yes |
| enrolled_on | DATE |  | Yes |
| status | TEXT |  | Yes |
- learner_id → learner.learner_id
- course_id → course.course_id

## assessment_event

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| assessment_event_id | BIGINT | PK | Yes |
| enrollment_id | BIGINT | FK | Yes |
| assessment_name | TEXT |  | Yes |
| score | NUMERIC(18,2) |  | Yes |
| recorded_at | TIMESTAMPTZ |  | Yes |
- enrollment_id → enrollment.enrollment_id

## Relationships and business rules

- Every learner must have an email address.
- A learner email address must identify at most one learner.
- Every enrollment must reference an existing learner.
- Every enrollment must reference an existing course.
- Every assessment event must reference an existing enrollment.
- Each assessment score must be between 0 and 100 inclusive.
- For each learner and course pair, at most one enrollment may have status active.

## Assumptions

- Each learner has one system account identified by a unique email address.
- Each course has one responsible instructor recorded as text for this exercise.
- An enrollment represents one learner's participation in one course.
- Assessment scores are percentages from 0 through 100.
- For normalization practice, enrollment is the worked root entity and is decomposed into learner and course references without repeating ancestor roles.
- Only synthetic learner, course, enrollment, and assessment data may be used.

