# An IT Learning Management System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| learner_id | enrollment records (list) |
| --- | --- |
| 101 | [301] |
| 102 | [302] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| enrollment.enrollment_id | enrollment.learner_id | enrollment.course_id | enrollment.status | learner.learner_id | learner.email | course.course_id | course.course_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | active | 101 | ava.chen@example.edu | 201 | NET101 |
| 302 | 102 | 202 | completed | 102 | noah.patel@example.edu | 202 | SEC201 |

Key: enrollment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## enrollment_example

| enrollment.enrollment_id | enrollment.learner_id | enrollment.course_id | enrollment.status | learner.learner_id | learner.email | course.course_id | course.course_code |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | active | 101 | ava.chen@example.edu | 201 | NET101 |
| 302 | 102 | 202 | completed | 102 | noah.patel@example.edu | 202 | SEC201 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## learner

| learner_id | email | display_name | joined_on | active |
| --- | --- | --- | --- | --- |
| 101 | ava.chen@example.edu | Ava Chen | 2026-01-10 | true |
| 102 | noah.patel@example.edu | Noah Patel | 2026-01-12 | true |

## course

| course_id | course_code | title | instructor_name | starts_on | ends_on |
| --- | --- | --- | --- | --- | --- |
| 201 | NET101 | Network Fundamentals | Dr. Lina Ortiz | 2026-02-01 | 2026-03-15 |
| 202 | SEC201 | Security Principles | Prof. Marcus Lee | 2026-02-05 | 2026-03-20 |

## enrollment

| enrollment_id | learner_id | course_id | enrolled_on | status |
| --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-01-15 | active |
| 302 | 102 | 202 | 2026-01-16 | completed |

## assessment_event

| assessment_event_id | enrollment_id | assessment_name | score | recorded_at |
| --- | --- | --- | --- | --- |
| 401 | 301 | Network Quiz | 88 | 2026-02-20T10:00:00+00:00 |
| 402 | 302 | Security Exam | 76 | 2026-03-10T14:30:00+00:00 |

## Dependencies

- learner: (learner_id) → email, display_name, joined_on, active
- course: (course_id) → course_code, title, instructor_name, starts_on, ends_on
- enrollment: (enrollment_id) → learner_id, course_id, enrolled_on, status
- assessment_event: (assessment_event_id) → enrollment_id, assessment_name, score, recorded_at

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
