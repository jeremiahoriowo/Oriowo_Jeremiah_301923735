# An IT Learning Management System — ER diagram

```mermaid
erDiagram
    direction LR
    learner {
        bigint learner_id PK
        text email UK
        text display_name
        date joined_on
        boolean active
    }
    course {
        bigint course_id PK
        text course_code UK
        text title
        text instructor_name
        date starts_on
        date ends_on
    }
    enrollment {
        bigint enrollment_id PK
        bigint learner_id FK
        bigint course_id FK
        date enrolled_on
        text status
    }
    assessment_event {
        bigint assessment_event_id PK
        bigint enrollment_id FK
        text assessment_name
        numeric score
        timestamptz recorded_at
    }
    learner ||--o{ enrollment : "learner_id"
    course ||--o{ enrollment : "course_id"
    enrollment ||--o{ assessment_event : "enrollment_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Oriowo_Jeremiah_301923735_ERDiagram.png)
