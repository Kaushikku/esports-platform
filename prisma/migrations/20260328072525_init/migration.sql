-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('PLAYER', 'ORG', 'CREATOR', 'BRAND', 'ADMIN');

-- CreateEnum
CREATE TYPE "TournamentStatus" AS ENUM ('DRAFT', 'UPCOMING', 'ONGOING', 'PAST', 'CANCELLED');

-- CreateEnum
CREATE TYPE "TournamentFormat" AS ENUM ('SINGLE_ELIMINATION', 'DOUBLE_ELIMINATION', 'ROUND_ROBIN', 'SWISS', 'BATTLE_ROYALE', 'CUSTOM');

-- CreateEnum
CREATE TYPE "TournamentRegion" AS ENUM ('INDIA', 'GLOBAL', 'SOUTH_ASIA', 'SOUTHEAST_ASIA', 'EUROPE', 'NORTH_AMERICA');

-- CreateEnum
CREATE TYPE "TeamRegistrationStatus" AS ENUM ('PENDING', 'CONFIRMED', 'DISQUALIFIED', 'WITHDRAWN');

-- CreateEnum
CREATE TYPE "ArticleStatus" AS ENUM ('DRAFT', 'REVIEW', 'PUBLISHED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "ArticleCategory" AS ENUM ('NEWS', 'GUIDE', 'ANALYSIS', 'INTERVIEW', 'ESPORTS', 'PATCH_NOTES', 'OPINION');

-- CreateEnum
CREATE TYPE "WikiEntryType" AS ENUM ('CHARACTER', 'WEAPON', 'MAP', 'ABILITY', 'ITEM', 'MECHANIC', 'PATCH');

-- CreateEnum
CREATE TYPE "TierListType" AS ENUM ('EDITOR', 'COMMUNITY', 'PRO');

-- CreateEnum
CREATE TYPE "ClipType" AS ENUM ('HIGHLIGHT', 'FUNNY', 'EDUCATIONAL', 'MONTAGE', 'STREAM_CLIP');

-- CreateEnum
CREATE TYPE "ChatRoomType" AS ENUM ('PUBLIC', 'PRIVATE', 'ORG', 'TOURNAMENT', 'DIRECT');

-- CreateEnum
CREATE TYPE "ChatMemberRole" AS ENUM ('OWNER', 'ADMIN', 'MODERATOR', 'MEMBER');

-- CreateEnum
CREATE TYPE "MessageType" AS ENUM ('TEXT', 'IMAGE', 'VIDEO', 'SYSTEM', 'STICKER', 'FILE');

-- CreateEnum
CREATE TYPE "ScrimRequestStatus" AS ENUM ('PENDING', 'ACCEPTED', 'REJECTED', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('ENTRY_FEE', 'SUBSCRIPTION', 'PAYOUT', 'BOOST', 'DEPOSIT', 'WITHDRAWAL', 'REFUND');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "PaymentGateway" AS ENUM ('RAZORPAY', 'STRIPE', 'INTERNAL');

-- CreateEnum
CREATE TYPE "SubscriptionPlan" AS ENUM ('FREE', 'PRO', 'ORG', 'ENTERPRISE');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('ACTIVE', 'EXPIRED', 'CANCELLED', 'TRIAL');

-- CreateEnum
CREATE TYPE "ContentType" AS ENUM ('YOUTUBE', 'TWITCH', 'INSTAGRAM', 'TIKTOK', 'MIXED');

-- CreateEnum
CREATE TYPE "GamePlatform" AS ENUM ('PC', 'MOBILE', 'CONSOLE', 'CROSS_PLATFORM');

-- CreateEnum
CREATE TYPE "GameGenre" AS ENUM ('BATTLE_ROYALE', 'FPS', 'MOBA', 'STRATEGY', 'SPORTS', 'FIGHTING', 'RPG', 'OTHER');

-- CreateEnum
CREATE TYPE "SectionType" AS ENUM ('TOURNAMENTS', 'LEADERBOARD', 'WIKI', 'TIER_LIST', 'CLIPS', 'ARTICLES', 'TEAMS', 'PLAYERS', 'LFG', 'SCRIMMAGE');

-- CreateEnum
CREATE TYPE "AchievementType" AS ENUM ('TOURNAMENT_WIN', 'TOURNAMENT_TOP3', 'TOURNAMENT_TOP10', 'FIRST_BLOOD', 'KILL_MILESTONE', 'WIN_STREAK', 'VERIFIED_PRO', 'COMMUNITY_STAR', 'CONTENT_CREATOR', 'CUSTOM');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('TOURNAMENT_INVITE', 'TOURNAMENT_UPDATE', 'MATCH_REMINDER', 'SCRIM_REQUEST', 'LFG_MATCH', 'TEAM_INVITE', 'MESSAGE', 'ACHIEVEMENT', 'PAYMENT', 'SYSTEM', 'PREDICTION_RESULT', 'FOLLOW');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "account_type" "AccountType" NOT NULL DEFAULT 'PLAYER',
    "avatar" TEXT,
    "bio" TEXT,
    "region" TEXT,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "is_banned" BOOLEAN NOT NULL DEFAULT false,
    "last_seen_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_profiles" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "ign" TEXT NOT NULL,
    "real_name" TEXT,
    "country" TEXT,
    "date_of_birth" TIMESTAMP(3),
    "game_ids" JSONB NOT NULL DEFAULT '{}',
    "primary_game" TEXT,
    "rank" TEXT,
    "role" TEXT,
    "twitter_url" TEXT,
    "youtube_url" TEXT,
    "twitch_url" TEXT,
    "team_id" TEXT,
    "is_open_to_recruit" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "org_profiles" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "org_name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "logo" TEXT,
    "banner" TEXT,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "verified_at" TIMESTAMP(3),
    "game_titles" TEXT[],
    "country" TEXT,
    "founded_year" INTEGER,
    "website" TEXT,
    "twitter_url" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "org_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "creator_profiles" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "channel_name" TEXT NOT NULL,
    "subscriber_count" INTEGER NOT NULL DEFAULT 0,
    "content_type" "ContentType" NOT NULL,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "verified_at" TIMESTAMP(3),
    "primary_game" TEXT,
    "youtube_url" TEXT,
    "twitch_url" TEXT,
    "twitter_url" TEXT,
    "instagram_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "creator_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teams" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "logo" TEXT,
    "banner" TEXT,
    "tag" TEXT,
    "region" TEXT,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "org_id" TEXT,
    "game_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "games" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "logo" TEXT,
    "banner" TEXT,
    "icon" TEXT,
    "primary_color" TEXT,
    "secondary_color" TEXT,
    "accent_color" TEXT,
    "platform" "GamePlatform" NOT NULL,
    "genre" "GameGenre" NOT NULL,
    "developer" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "release_year" INTEGER,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "games_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_sub_sections" (
    "id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "section_type" "SectionType" NOT NULL,
    "is_enabled" BOOLEAN NOT NULL DEFAULT true,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "config" JSONB,

    CONSTRAINT "game_sub_sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tournaments" (
    "id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "org_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "rules" TEXT,
    "banner_image" TEXT,
    "prize_pool" DECIMAL(12,2),
    "prize_breakdown" JSONB,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "entry_fee" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "format" "TournamentFormat" NOT NULL,
    "status" "TournamentStatus" NOT NULL DEFAULT 'DRAFT',
    "region" "TournamentRegion" NOT NULL DEFAULT 'INDIA',
    "max_teams" INTEGER NOT NULL,
    "min_team_size" INTEGER NOT NULL DEFAULT 1,
    "max_team_size" INTEGER NOT NULL DEFAULT 5,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "registration_deadline" TIMESTAMP(3) NOT NULL,
    "is_public" BOOLEAN NOT NULL DEFAULT true,
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "stream_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tournaments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tournament_teams" (
    "id" TEXT NOT NULL,
    "tournament_id" TEXT NOT NULL,
    "team_id" TEXT NOT NULL,
    "status" "TeamRegistrationStatus" NOT NULL DEFAULT 'PENDING',
    "placement" INTEGER,
    "prize_won" DECIMAL(12,2),
    "registered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "confirmed_at" TIMESTAMP(3),

    CONSTRAINT "tournament_teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tournament_matches" (
    "id" TEXT NOT NULL,
    "tournament_id" TEXT NOT NULL,
    "round" INTEGER NOT NULL,
    "match_number" INTEGER NOT NULL,
    "stage" TEXT,
    "team1_id" TEXT,
    "team2_id" TEXT,
    "winner_id" TEXT,
    "team1_score" INTEGER,
    "team2_score" INTEGER,
    "score_detail" JSONB,
    "scheduled_at" TIMESTAMP(3),
    "played_at" TIMESTAMP(3),
    "stream_url" TEXT,
    "vod_url" TEXT,

    CONSTRAINT "tournament_matches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_stats" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "kills" INTEGER NOT NULL DEFAULT 0,
    "deaths" INTEGER NOT NULL DEFAULT 0,
    "assists" INTEGER NOT NULL DEFAULT 0,
    "wins" INTEGER NOT NULL DEFAULT 0,
    "losses" INTEGER NOT NULL DEFAULT 0,
    "matches_played" INTEGER NOT NULL DEFAULT 0,
    "kd_ratio" DECIMAL(6,2) NOT NULL DEFAULT 0,
    "win_rate" DECIMAL(5,2) NOT NULL DEFAULT 0,
    "avg_damage" DECIMAL(8,2),
    "headshot_rate" DECIMAL(5,2),
    "tournament_points" INTEGER NOT NULL DEFAULT 0,
    "rank" TEXT,
    "peak_rank" TEXT,
    "extra_stats" JSONB,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_stats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_achievements" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "achievement_type" "AchievementType" NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "game_id" TEXT,
    "tournament_id" TEXT,
    "earned_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "player_achievements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "articles" (
    "id" TEXT NOT NULL,
    "author_id" TEXT NOT NULL,
    "game_id" TEXT,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "excerpt" TEXT,
    "content" TEXT NOT NULL,
    "cover_image" TEXT,
    "status" "ArticleStatus" NOT NULL DEFAULT 'DRAFT',
    "category" "ArticleCategory" NOT NULL,
    "tags" TEXT[],
    "views" INTEGER NOT NULL DEFAULT 0,
    "read_time" INTEGER,
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "published_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "articles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wiki_entries" (
    "id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "entry_type" "WikiEntryType" NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "summary" TEXT,
    "image" TEXT,
    "patch_version" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "metadata" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wiki_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tier_lists" (
    "id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "created_by" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "list_type" "TierListType" NOT NULL,
    "patch_version" TEXT,
    "tier_data" JSONB NOT NULL,
    "is_published" BOOLEAN NOT NULL DEFAULT false,
    "votes" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tier_lists_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clips" (
    "id" TEXT NOT NULL,
    "uploader_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "video_url" TEXT NOT NULL,
    "thumbnail" TEXT,
    "duration" INTEGER,
    "clip_type" "ClipType" NOT NULL,
    "likes" INTEGER NOT NULL DEFAULT 0,
    "views" INTEGER NOT NULL DEFAULT 0,
    "shares" INTEGER NOT NULL DEFAULT 0,
    "tags" TEXT[],
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "is_published" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "clips_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_rooms" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "description" TEXT,
    "type" "ChatRoomType" NOT NULL,
    "game_id" TEXT,
    "created_by" TEXT NOT NULL,
    "is_encrypted" BOOLEAN NOT NULL DEFAULT false,
    "max_members" INTEGER,
    "avatar" TEXT,
    "last_message_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "chat_rooms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_members" (
    "id" TEXT NOT NULL,
    "room_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "role" "ChatMemberRole" NOT NULL DEFAULT 'MEMBER',
    "is_muted" BOOLEAN NOT NULL DEFAULT false,
    "last_read_at" TIMESTAMP(3),
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chat_members_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "messages" (
    "id" TEXT NOT NULL,
    "room_id" TEXT NOT NULL,
    "sender_id" TEXT NOT NULL,
    "content_encrypted" TEXT NOT NULL,
    "type" "MessageType" NOT NULL DEFAULT 'TEXT',
    "media_url" TEXT,
    "reply_to_id" TEXT,
    "is_edited" BOOLEAN NOT NULL DEFAULT false,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "edited_at" TIMESTAMP(3),
    "sent_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lfg_posts" (
    "id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "rank" TEXT,
    "role" TEXT,
    "availability" TEXT,
    "playstyle" TEXT,
    "languages" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lfg_posts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lfp_posts" (
    "id" TEXT NOT NULL,
    "org_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "role_needed" TEXT NOT NULL,
    "rank_requirement" TEXT,
    "compensation" TEXT,
    "description" TEXT,
    "requirements" TEXT[],
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lfp_posts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scrim_requests" (
    "id" TEXT NOT NULL,
    "team1_id" TEXT NOT NULL,
    "team2_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "format" TEXT NOT NULL,
    "scheduled_at" TIMESTAMP(3) NOT NULL,
    "status" "ScrimRequestStatus" NOT NULL DEFAULT 'PENDING',
    "server_region" TEXT,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "scrim_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "predictions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "match_id" TEXT NOT NULL,
    "predicted_winner" TEXT NOT NULL,
    "predicted_score" TEXT,
    "predicted_mvp" TEXT,
    "points_earned" INTEGER NOT NULL DEFAULT 0,
    "is_correct" BOOLEAN,
    "is_resolved" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "predictions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wallets" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "balance_inr" DECIMAL(14,2) NOT NULL DEFAULT 0,
    "balance_usd" DECIMAL(14,2) NOT NULL DEFAULT 0,
    "last_updated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wallets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "type" "TransactionType" NOT NULL,
    "amount" DECIMAL(14,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "status" "TransactionStatus" NOT NULL DEFAULT 'PENDING',
    "gateway" "PaymentGateway" NOT NULL DEFAULT 'RAZORPAY',
    "gateway_id" TEXT,
    "description" TEXT,
    "metadata" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "plan" "SubscriptionPlan" NOT NULL DEFAULT 'FREE',
    "status" "SubscriptionStatus" NOT NULL DEFAULT 'ACTIVE',
    "started_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3),
    "cancelled_at" TIMESTAMP(3),
    "gateway_subscription_id" TEXT,
    "auto_renew" BOOLEAN NOT NULL DEFAULT true,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "action_url" TEXT,
    "image_url" TEXT,
    "ref_id" TEXT,
    "ref_type" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE INDEX "users_email_idx" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_username_idx" ON "users"("username");

-- CreateIndex
CREATE INDEX "users_account_type_idx" ON "users"("account_type");

-- CreateIndex
CREATE INDEX "users_region_idx" ON "users"("region");

-- CreateIndex
CREATE INDEX "users_created_at_idx" ON "users"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "player_profiles_user_id_key" ON "player_profiles"("user_id");

-- CreateIndex
CREATE INDEX "player_profiles_user_id_idx" ON "player_profiles"("user_id");

-- CreateIndex
CREATE INDEX "player_profiles_primary_game_idx" ON "player_profiles"("primary_game");

-- CreateIndex
CREATE INDEX "player_profiles_team_id_idx" ON "player_profiles"("team_id");

-- CreateIndex
CREATE UNIQUE INDEX "org_profiles_user_id_key" ON "org_profiles"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "org_profiles_slug_key" ON "org_profiles"("slug");

-- CreateIndex
CREATE INDEX "org_profiles_slug_idx" ON "org_profiles"("slug");

-- CreateIndex
CREATE INDEX "org_profiles_is_verified_idx" ON "org_profiles"("is_verified");

-- CreateIndex
CREATE UNIQUE INDEX "creator_profiles_user_id_key" ON "creator_profiles"("user_id");

-- CreateIndex
CREATE INDEX "creator_profiles_user_id_idx" ON "creator_profiles"("user_id");

-- CreateIndex
CREATE INDEX "creator_profiles_is_verified_idx" ON "creator_profiles"("is_verified");

-- CreateIndex
CREATE UNIQUE INDEX "teams_slug_key" ON "teams"("slug");

-- CreateIndex
CREATE INDEX "teams_slug_idx" ON "teams"("slug");

-- CreateIndex
CREATE INDEX "teams_org_id_idx" ON "teams"("org_id");

-- CreateIndex
CREATE INDEX "teams_game_id_idx" ON "teams"("game_id");

-- CreateIndex
CREATE UNIQUE INDEX "games_slug_key" ON "games"("slug");

-- CreateIndex
CREATE INDEX "games_slug_idx" ON "games"("slug");

-- CreateIndex
CREATE INDEX "games_is_active_idx" ON "games"("is_active");

-- CreateIndex
CREATE INDEX "games_genre_idx" ON "games"("genre");

-- CreateIndex
CREATE INDEX "game_sub_sections_game_id_idx" ON "game_sub_sections"("game_id");

-- CreateIndex
CREATE UNIQUE INDEX "game_sub_sections_game_id_section_type_key" ON "game_sub_sections"("game_id", "section_type");

-- CreateIndex
CREATE UNIQUE INDEX "tournaments_slug_key" ON "tournaments"("slug");

-- CreateIndex
CREATE INDEX "tournaments_game_id_idx" ON "tournaments"("game_id");

-- CreateIndex
CREATE INDEX "tournaments_org_id_idx" ON "tournaments"("org_id");

-- CreateIndex
CREATE INDEX "tournaments_status_idx" ON "tournaments"("status");

-- CreateIndex
CREATE INDEX "tournaments_region_idx" ON "tournaments"("region");

-- CreateIndex
CREATE INDEX "tournaments_start_date_idx" ON "tournaments"("start_date");

-- CreateIndex
CREATE INDEX "tournaments_is_featured_idx" ON "tournaments"("is_featured");

-- CreateIndex
CREATE INDEX "tournaments_slug_idx" ON "tournaments"("slug");

-- CreateIndex
CREATE INDEX "tournament_teams_tournament_id_idx" ON "tournament_teams"("tournament_id");

-- CreateIndex
CREATE INDEX "tournament_teams_team_id_idx" ON "tournament_teams"("team_id");

-- CreateIndex
CREATE INDEX "tournament_teams_status_idx" ON "tournament_teams"("status");

-- CreateIndex
CREATE UNIQUE INDEX "tournament_teams_tournament_id_team_id_key" ON "tournament_teams"("tournament_id", "team_id");

-- CreateIndex
CREATE INDEX "tournament_matches_tournament_id_idx" ON "tournament_matches"("tournament_id");

-- CreateIndex
CREATE INDEX "tournament_matches_round_idx" ON "tournament_matches"("round");

-- CreateIndex
CREATE INDEX "tournament_matches_scheduled_at_idx" ON "tournament_matches"("scheduled_at");

-- CreateIndex
CREATE INDEX "player_stats_player_id_idx" ON "player_stats"("player_id");

-- CreateIndex
CREATE INDEX "player_stats_game_id_idx" ON "player_stats"("game_id");

-- CreateIndex
CREATE INDEX "player_stats_tournament_points_idx" ON "player_stats"("tournament_points");

-- CreateIndex
CREATE UNIQUE INDEX "player_stats_player_id_game_id_key" ON "player_stats"("player_id", "game_id");

-- CreateIndex
CREATE INDEX "player_achievements_player_id_idx" ON "player_achievements"("player_id");

-- CreateIndex
CREATE INDEX "player_achievements_achievement_type_idx" ON "player_achievements"("achievement_type");

-- CreateIndex
CREATE INDEX "player_achievements_earned_at_idx" ON "player_achievements"("earned_at");

-- CreateIndex
CREATE UNIQUE INDEX "articles_slug_key" ON "articles"("slug");

-- CreateIndex
CREATE INDEX "articles_author_id_idx" ON "articles"("author_id");

-- CreateIndex
CREATE INDEX "articles_game_id_idx" ON "articles"("game_id");

-- CreateIndex
CREATE INDEX "articles_slug_idx" ON "articles"("slug");

-- CreateIndex
CREATE INDEX "articles_status_idx" ON "articles"("status");

-- CreateIndex
CREATE INDEX "articles_category_idx" ON "articles"("category");

-- CreateIndex
CREATE INDEX "articles_published_at_idx" ON "articles"("published_at");

-- CreateIndex
CREATE INDEX "articles_is_featured_idx" ON "articles"("is_featured");

-- CreateIndex
CREATE INDEX "wiki_entries_game_id_idx" ON "wiki_entries"("game_id");

-- CreateIndex
CREATE INDEX "wiki_entries_entry_type_idx" ON "wiki_entries"("entry_type");

-- CreateIndex
CREATE INDEX "wiki_entries_patch_version_idx" ON "wiki_entries"("patch_version");

-- CreateIndex
CREATE UNIQUE INDEX "wiki_entries_game_id_slug_key" ON "wiki_entries"("game_id", "slug");

-- CreateIndex
CREATE INDEX "tier_lists_game_id_idx" ON "tier_lists"("game_id");

-- CreateIndex
CREATE INDEX "tier_lists_list_type_idx" ON "tier_lists"("list_type");

-- CreateIndex
CREATE INDEX "tier_lists_patch_version_idx" ON "tier_lists"("patch_version");

-- CreateIndex
CREATE INDEX "clips_uploader_id_idx" ON "clips"("uploader_id");

-- CreateIndex
CREATE INDEX "clips_game_id_idx" ON "clips"("game_id");

-- CreateIndex
CREATE INDEX "clips_clip_type_idx" ON "clips"("clip_type");

-- CreateIndex
CREATE INDEX "clips_is_featured_idx" ON "clips"("is_featured");

-- CreateIndex
CREATE INDEX "clips_created_at_idx" ON "clips"("created_at");

-- CreateIndex
CREATE INDEX "chat_rooms_type_idx" ON "chat_rooms"("type");

-- CreateIndex
CREATE INDEX "chat_rooms_game_id_idx" ON "chat_rooms"("game_id");

-- CreateIndex
CREATE INDEX "chat_rooms_created_by_idx" ON "chat_rooms"("created_by");

-- CreateIndex
CREATE INDEX "chat_rooms_last_message_at_idx" ON "chat_rooms"("last_message_at");

-- CreateIndex
CREATE INDEX "chat_members_room_id_idx" ON "chat_members"("room_id");

-- CreateIndex
CREATE INDEX "chat_members_user_id_idx" ON "chat_members"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "chat_members_room_id_user_id_key" ON "chat_members"("room_id", "user_id");

-- CreateIndex
CREATE INDEX "messages_room_id_idx" ON "messages"("room_id");

-- CreateIndex
CREATE INDEX "messages_sender_id_idx" ON "messages"("sender_id");

-- CreateIndex
CREATE INDEX "messages_sent_at_idx" ON "messages"("sent_at");

-- CreateIndex
CREATE INDEX "messages_reply_to_id_idx" ON "messages"("reply_to_id");

-- CreateIndex
CREATE INDEX "lfg_posts_player_id_idx" ON "lfg_posts"("player_id");

-- CreateIndex
CREATE INDEX "lfg_posts_game_id_idx" ON "lfg_posts"("game_id");

-- CreateIndex
CREATE INDEX "lfg_posts_is_active_idx" ON "lfg_posts"("is_active");

-- CreateIndex
CREATE INDEX "lfg_posts_expires_at_idx" ON "lfg_posts"("expires_at");

-- CreateIndex
CREATE INDEX "lfp_posts_org_id_idx" ON "lfp_posts"("org_id");

-- CreateIndex
CREATE INDEX "lfp_posts_game_id_idx" ON "lfp_posts"("game_id");

-- CreateIndex
CREATE INDEX "lfp_posts_is_active_idx" ON "lfp_posts"("is_active");

-- CreateIndex
CREATE INDEX "scrim_requests_team1_id_idx" ON "scrim_requests"("team1_id");

-- CreateIndex
CREATE INDEX "scrim_requests_team2_id_idx" ON "scrim_requests"("team2_id");

-- CreateIndex
CREATE INDEX "scrim_requests_game_id_idx" ON "scrim_requests"("game_id");

-- CreateIndex
CREATE INDEX "scrim_requests_status_idx" ON "scrim_requests"("status");

-- CreateIndex
CREATE INDEX "scrim_requests_scheduled_at_idx" ON "scrim_requests"("scheduled_at");

-- CreateIndex
CREATE INDEX "predictions_user_id_idx" ON "predictions"("user_id");

-- CreateIndex
CREATE INDEX "predictions_match_id_idx" ON "predictions"("match_id");

-- CreateIndex
CREATE INDEX "predictions_is_resolved_idx" ON "predictions"("is_resolved");

-- CreateIndex
CREATE UNIQUE INDEX "predictions_user_id_match_id_key" ON "predictions"("user_id", "match_id");

-- CreateIndex
CREATE UNIQUE INDEX "wallets_user_id_key" ON "wallets"("user_id");

-- CreateIndex
CREATE INDEX "wallets_user_id_idx" ON "wallets"("user_id");

-- CreateIndex
CREATE INDEX "transactions_user_id_idx" ON "transactions"("user_id");

-- CreateIndex
CREATE INDEX "transactions_type_idx" ON "transactions"("type");

-- CreateIndex
CREATE INDEX "transactions_status_idx" ON "transactions"("status");

-- CreateIndex
CREATE INDEX "transactions_gateway_id_idx" ON "transactions"("gateway_id");

-- CreateIndex
CREATE INDEX "transactions_created_at_idx" ON "transactions"("created_at");

-- CreateIndex
CREATE UNIQUE INDEX "subscriptions_user_id_key" ON "subscriptions"("user_id");

-- CreateIndex
CREATE INDEX "subscriptions_user_id_idx" ON "subscriptions"("user_id");

-- CreateIndex
CREATE INDEX "subscriptions_plan_idx" ON "subscriptions"("plan");

-- CreateIndex
CREATE INDEX "subscriptions_status_idx" ON "subscriptions"("status");

-- CreateIndex
CREATE INDEX "subscriptions_expires_at_idx" ON "subscriptions"("expires_at");

-- CreateIndex
CREATE INDEX "notifications_user_id_idx" ON "notifications"("user_id");

-- CreateIndex
CREATE INDEX "notifications_is_read_idx" ON "notifications"("is_read");

-- CreateIndex
CREATE INDEX "notifications_type_idx" ON "notifications"("type");

-- CreateIndex
CREATE INDEX "notifications_created_at_idx" ON "notifications"("created_at");

-- AddForeignKey
ALTER TABLE "player_profiles" ADD CONSTRAINT "player_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_profiles" ADD CONSTRAINT "player_profiles_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "teams"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "org_profiles" ADD CONSTRAINT "org_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_profiles" ADD CONSTRAINT "creator_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teams" ADD CONSTRAINT "teams_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "org_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teams" ADD CONSTRAINT "teams_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_sub_sections" ADD CONSTRAINT "game_sub_sections_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournaments" ADD CONSTRAINT "tournaments_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournaments" ADD CONSTRAINT "tournaments_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "org_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournament_teams" ADD CONSTRAINT "tournament_teams_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "tournaments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournament_teams" ADD CONSTRAINT "tournament_teams_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tournament_matches" ADD CONSTRAINT "tournament_matches_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "tournaments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_stats" ADD CONSTRAINT "player_stats_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_stats" ADD CONSTRAINT "player_stats_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_achievements" ADD CONSTRAINT "player_achievements_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "articles" ADD CONSTRAINT "articles_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "articles" ADD CONSTRAINT "articles_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wiki_entries" ADD CONSTRAINT "wiki_entries_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tier_lists" ADD CONSTRAINT "tier_lists_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tier_lists" ADD CONSTRAINT "tier_lists_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clips" ADD CONSTRAINT "clips_uploader_id_fkey" FOREIGN KEY ("uploader_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clips" ADD CONSTRAINT "clips_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_rooms" ADD CONSTRAINT "chat_rooms_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_members" ADD CONSTRAINT "chat_members_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "chat_rooms"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_members" ADD CONSTRAINT "chat_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "chat_rooms"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_reply_to_id_fkey" FOREIGN KEY ("reply_to_id") REFERENCES "messages"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lfg_posts" ADD CONSTRAINT "lfg_posts_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lfg_posts" ADD CONSTRAINT "lfg_posts_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lfp_posts" ADD CONSTRAINT "lfp_posts_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "org_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lfp_posts" ADD CONSTRAINT "lfp_posts_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scrim_requests" ADD CONSTRAINT "scrim_requests_team1_id_fkey" FOREIGN KEY ("team1_id") REFERENCES "teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scrim_requests" ADD CONSTRAINT "scrim_requests_team2_id_fkey" FOREIGN KEY ("team2_id") REFERENCES "teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scrim_requests" ADD CONSTRAINT "scrim_requests_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "predictions" ADD CONSTRAINT "predictions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "predictions" ADD CONSTRAINT "predictions_match_id_fkey" FOREIGN KEY ("match_id") REFERENCES "tournament_matches"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wallets" ADD CONSTRAINT "wallets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
