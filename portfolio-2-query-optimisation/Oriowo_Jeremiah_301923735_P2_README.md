# An IT Learning Management System — SQL queries

## 1. Show related enrollment, learner, course records (up to 20).

```sql
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
```

| enrollment_enrollment_id | enrollment_enrolled_on | learner_learner_id | learner_email | course_course_id | course_course_code |
| --- | --- | --- | --- | --- | --- |
| 301 | 2026-01-15 | 101 | ava.chen@example.edu | 201 | NET101 |
| 302 | 2026-01-16 | 102 | noah.patel@example.edu | 202 | SEC201 |

## 2. Find enrollment records where status matches "active" (up to 20).

```sql
SELECT * FROM portfolio."enrollment"
WHERE "status" IS NOT DISTINCT FROM 'active'
ORDER BY "enrollment_id"
LIMIT 20;
```

| enrollment_id | learner_id | course_id | enrolled_on | status |
| --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 2026-01-15 | active |

## 3. Count enrollment records for each learner_id (up to 20 groups).

```sql
SELECT "learner_id", count(*) AS record_count
FROM portfolio."enrollment"
GROUP BY "learner_id"
ORDER BY record_count DESC, "learner_id" NULLS LAST
LIMIT 20;
```

| learner_id | record_count |
| --- | --- |
| 101 | 1 |
| 102 | 1 |

## 4. Count assessment_event records for each enrollment_id (up to 20 groups).

```sql
SELECT "enrollment_id", count(*) AS record_count
FROM portfolio."assessment_event"
GROUP BY "enrollment_id"
ORDER BY record_count DESC, "enrollment_id" NULLS LAST
LIMIT 20;
```

| enrollment_id | record_count |
| --- | --- |
| 301 | 1 |
| 302 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.353 | 1.389, 1.353, 1.341 | Sort → Seq Scan | 163 |
| After index | 0.236 | 0.236, 0.214, 0.24 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.353 ms to 0.236 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.361..1.363 rows=25 loops=1)
  Seq Scan on enrollment (actual time=0.016..1.325 rows=25 loops=1)
Planning Time: 0.413 ms
Execution Time: 1.389 ms
```

### Before index, run 2

```text
Sort (actual time=1.308..1.31 rows=25 loops=1)
  Seq Scan on enrollment (actual time=0.016..1.268 rows=25 loops=1)
Planning Time: 0.4 ms
Execution Time: 1.353 ms
```

### Before index, run 3

```text
Sort (actual time=1.316..1.318 rows=25 loops=1)
  Seq Scan on enrollment (actual time=0.016..1.279 rows=25 loops=1)
Planning Time: 0.423 ms
Execution Time: 1.341 ms
```

### After index, run 1

```text
Sort (actual time=0.183..0.185 rows=25 loops=1)
  Bitmap Heap Scan on enrollment (actual time=0.03..0.13 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.016..0.017 rows=25 loops=1)
Planning Time: 0.604 ms
Execution Time: 0.236 ms
```

### After index, run 2

```text
Sort (actual time=0.161..0.163 rows=25 loops=1)
  Bitmap Heap Scan on enrollment (actual time=0.029..0.123 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=25 loops=1)
Planning Time: 0.62 ms
Execution Time: 0.214 ms
```

### After index, run 3

```text
Sort (actual time=0.187..0.189 rows=25 loops=1)
  Bitmap Heap Scan on enrollment (actual time=0.029..0.149 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.016..0.016 rows=25 loops=1)
Planning Time: 0.602 ms
Execution Time: 0.24 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Oriowo_Jeremiah_301923735_P2_Queries.sql, then Oriowo_Jeremiah_301923735_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Oriowo_Jeremiah_301923735_P2_QueryResults.png) · [Index comparison](screenshots/Oriowo_Jeremiah_301923735_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

