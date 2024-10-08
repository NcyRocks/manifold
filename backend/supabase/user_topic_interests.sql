-- This file is autogenerated from regen-schema.ts
create table if not exists
  user_topic_interests (
    created_time timestamp with time zone default now() not null,
    group_ids_to_activity jsonb not null,
    id bigint primary key generated always as identity not null,
    user_id text not null
  );

-- Row Level Security
alter table user_topic_interests enable row level security;

-- Indexes
drop index if exists user_topic_interests_created_time;

create index user_topic_interests_created_time on public.user_topic_interests using btree (user_id, created_time desc);

drop index if exists user_topic_interests_pkey;

create unique index user_topic_interests_pkey on public.user_topic_interests using btree (id);
