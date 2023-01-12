select Corpora_Tasks."id", Corpora_Tasks."corpora_id", Corpora_Tasks."is_private", Corpora_Tasks."raw_text", Corpora_Tasks."created_at", count(*) OVER() AS full_count, Corpora_Tasks."sentences_annotations"::text AS predictions from Corpora_Tasks join (select Corpora_Tasks."id", max(Corpora_Tasks."created_at") as most_recent_task from Corpora_Tasks group by id) p ON (Corpora_Tasks.id = p.id and Corpora_Tasks.created_at = p.most_recent_task) where Corpora_Tasks."corpora_id" = (select corpora_id from Corpora_Info order by created_at desc limit 1) order by Corpora_Tasks.id;