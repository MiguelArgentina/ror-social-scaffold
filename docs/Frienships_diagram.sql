CREATE TABLE "users" (
  "id" int PRIMARY KEY,
  "email" varchar UNIQUE NOT NULL,
  "full_name" type NOT NULL
);

CREATE TABLE "posts" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "content" varchar
);

CREATE TABLE "comments" (
  "id" int PRIMARY KEY,
  "content" varchar,
  "post_id" int,
  "user_id" int
);

CREATE TABLE "friendships" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "friend_id" int,
  "confirmed" boolean
);

CREATE TABLE "likes" (
  "id" int PRIMARY KEY,
  "post_id" int,
  "user_id" int
);

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "friendships" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "friendships" ADD FOREIGN KEY ("friend_id") REFERENCES "users" ("id");
