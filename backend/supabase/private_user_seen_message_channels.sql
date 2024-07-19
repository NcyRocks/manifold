-- This file is autogenerated from regen-schema.ts
create table if not exists
  private_user_seen_message_channels (
    id bigint not null,
    user_id text not null,
    channel_id bigint not null,
    created_time timestamp with time zone default now() not null
  );

-- Policies
alter table private_user_seen_message_channels enable row level security;

drop policy if exists "private member insert" on private_user_seen_message_channels;

create policy "private member insert" on private_user_seen_message_channels for insert
with
  check (
    (
      (firebase_uid () is not null)
      and can_access_private_messages (channel_id, firebase_uid ())
    )
  );

drop policy if exists "private member read" on private_user_seen_message_channels;

create policy "private member read" on private_user_seen_message_channels for
select
  using (
    (
      (firebase_uid () is not null)
      and can_access_private_messages (channel_id, firebase_uid ())
    )
  );

-- Indexes
drop index if exists private_user_seen_message_channels_pkey;

create unique index private_user_seen_message_channels_pkey on public.private_user_seen_message_channels using btree (id);

drop index if exists user_seen_private_messages_created_time_desc_idx;

create index user_seen_private_messages_created_time_desc_idx on public.private_user_seen_message_channels using btree (user_id, channel_id, created_time desc);