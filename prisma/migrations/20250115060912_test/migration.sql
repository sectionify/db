-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('SUPER_USER', 'ADMIN', 'TEAM_MEMBER', 'SHOP_OWNER', 'AFFILIATOR', 'USER');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "ShopStatus" AS ENUM ('ACTIVE', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "DiscountType" AS ENUM ('FLAT', 'PERCENT');

-- CreateEnum
CREATE TYPE "TeamMemberRole" AS ENUM ('ADMINISTRATOR', 'MANAGER', 'DEVELOPER', 'DESIGNER', 'SUPPORT', 'MARKETEER');

-- CreateEnum
CREATE TYPE "BundleType" AS ENUM ('SECTION', 'BLOCK', 'TEMPLATE', 'MIXED');

-- CreateEnum
CREATE TYPE "ElementType" AS ENUM ('SECTION', 'BLOCK', 'TEMPLATE');

-- CreateEnum
CREATE TYPE "GenericStatus" AS ENUM ('DRAFT', 'PUBLISHED', 'INACTIVE');

-- CreateEnum
CREATE TYPE "AssetType" AS ENUM ('SECTION', 'BLOCK', 'TEMPLATE', 'BUNDLE');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "CouponStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "AffiliatorType" AS ENUM ('INFLUENCER', 'TECH_GURU', 'YOUTUBER', 'DEVELOPER', 'MENTOR', 'OTHER');

-- CreateEnum
CREATE TYPE "AffiliatorStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "CommissionStatus" AS ENUM ('APPROVED', 'CANCELED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "CommissionWithdrawStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "PaymentMethod" AS ENUM ('BANK', 'STRIPE', 'PAYPAL', 'PAYONEER', 'SHOPIFY');

-- CreateEnum
CREATE TYPE "PricingPlanType" AS ENUM ('FREE', 'PRO', 'ELITE', 'ENTERPRISE');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('PENDING', 'ON_GOING', 'ENDED');

-- CreateEnum
CREATE TYPE "SubscriptionEndedType" AS ENUM ('DECLAINED', 'TRIAL_CENCELLED', 'TRIAL_SUCCESS', 'FAILED_PAYMENT', 'REFUNED', 'UPGRADED', 'DOWNGRADED');

-- CreateEnum
CREATE TYPE "FaqStatus" AS ENUM ('DRAFT', 'PUBLISHED');

-- CreateEnum
CREATE TYPE "ContactStatus" AS ENUM ('PENDING', 'ON_REVIEW', 'APPROVED', 'DENIED');

-- CreateEnum
CREATE TYPE "AttachmentType" AS ENUM ('IMAGE', 'VIDEO', 'PDF');

-- CreateEnum
CREATE TYPE "AttachmentRefType" AS ENUM ('SUPPORT', 'TICKET_MESSAGE', 'CONTACT', 'WITHDRAW_REQUEST');

-- CreateEnum
CREATE TYPE "SupportRefType" AS ENUM ('SHOP', 'AFFILIATE', 'GENERAL');

-- CreateEnum
CREATE TYPE "SupportCriteria" AS ENUM ('GENERAL', 'TECHNICAL', 'HIRE', 'PURCHASE', 'FEATURE_REQUEST', 'BUG', 'DESIGN_ISSUE', 'ADD_TO_THEME_ISSUE', 'AFFILIATION', 'COUPON', 'COMMISSION_WITHDRAW', 'REFUND', 'OTHERS');

-- CreateEnum
CREATE TYPE "SupportStatus" AS ENUM ('PENDING', 'ON_GOING', 'APPROVED', 'RESOLVED', 'DENIED', 'CLOSED');

-- CreateEnum
CREATE TYPE "SupportLabel" AS ENUM ('SEVERITY_1', 'SEVERITY_2', 'SEVERITY_3');

-- CreateEnum
CREATE TYPE "test" AS ENUM ('SEVERITY_1', 'SEVERITY_2', 'SEVERITY_3');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255),
    "phone" VARCHAR(20),
    "profile_photo" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'USER',
    "status" "UserStatus" DEFAULT 'ACTIVE',
    "is_verified" BOOLEAN DEFAULT false,
    "is_shopify_user" BOOLEAN DEFAULT false,
    "date_of_birth" TIMESTAMP(3),
    "country_code" VARCHAR(10),
    "country" VARCHAR(100),
    "address" TEXT,
    "website_url" TEXT,
    "social_handles" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shop" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "shopify_shop_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "domain" VARCHAR(200) NOT NULL,
    "status" "ShopStatus" NOT NULL DEFAULT 'ACTIVE',
    "subscription_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Shop_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Element" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "featured_image" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "file_name" VARCHAR(255) NOT NULL,
    "status" "GenericStatus" NOT NULL DEFAULT 'DRAFT',
    "type" "ElementType" NOT NULL,
    "price" DECIMAL(6,2) NOT NULL,
    "discount_type" "DiscountType" DEFAULT 'FLAT',
    "discount_value" DECIMAL(6,2),
    "demo_url" TEXT,
    "video_url" TEXT,
    "version" TEXT DEFAULT '1.0.0',
    "user_id" INTEGER NOT NULL,
    "wishlisted_count" INTEGER DEFAULT 0,
    "bookmarked_count" INTEGER DEFAULT 0,
    "added_theme_count" INTEGER DEFAULT 0,
    "view_count" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Element_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bundle" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "featured_image" TEXT NOT NULL,
    "status" "GenericStatus" NOT NULL DEFAULT 'DRAFT',
    "type" "BundleType" NOT NULL,
    "is_auto_price" BOOLEAN DEFAULT false,
    "price" DECIMAL(6,2) NOT NULL,
    "discount_type" "DiscountType" DEFAULT 'FLAT',
    "discount_value" DECIMAL(6,2),
    "demo_url" TEXT,
    "video_url" TEXT,
    "version" TEXT DEFAULT '1.0.0',
    "user_id" INTEGER NOT NULL,
    "view_count" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Bundle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bundle_Element" (
    "id" SERIAL NOT NULL,
    "bundle_id" INTEGER NOT NULL,
    "element_id" INTEGER NOT NULL,
    "element_type" "ElementType" NOT NULL,
    "status" "GenericStatus" NOT NULL DEFAULT 'DRAFT',
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Bundle_Element_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Element_Image" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "element_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Element_Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bundle_Image" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "bundle_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Bundle_Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Element_Best_Use" (
    "id" SERIAL NOT NULL,
    "element_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Element_Best_Use_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "type" "AssetType" NOT NULL,
    "status" "GenericStatus" NOT NULL DEFAULT 'DRAFT',
    "image" TEXT,
    "banner" TEXT,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Element_Category" (
    "id" SERIAL NOT NULL,
    "element_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Element_Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bundle_Category" (
    "id" SERIAL NOT NULL,
    "bundle_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Bundle_Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tag" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "slug" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "description" TEXT,
    "image" TEXT,
    "banner" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Element_Tag" (
    "id" SERIAL NOT NULL,
    "element_id" INTEGER NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Element_Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" INTEGER NOT NULL,
    "shop" TEXT NOT NULL,
    "state" TEXT,
    "isOnline" BOOLEAN NOT NULL,
    "scope" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "shop_id" INTEGER NOT NULL,
    "asset_type" "AssetType" NOT NULL,
    "status" "OrderStatus" NOT NULL DEFAULT 'PENDING',
    "sub_total" DECIMAL(7,2) NOT NULL,
    "discounted_amout" DECIMAL(7,2),
    "coupon_id" INTEGER,
    "coupon_code" VARCHAR(20),
    "coupon_discount_type" "DiscountType" DEFAULT 'FLAT',
    "coupon_discount_value" DECIMAL(6,2),
    "grand_total" DECIMAL(7,2) NOT NULL,
    "affiliated_by" INTEGER,
    "affiliated_commission" DECIMAL(6,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order_Item" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "asset_id" INTEGER NOT NULL,
    "asset_type" "AssetType" NOT NULL,
    "price" DECIMAL(6,2) NOT NULL,
    "discounted_price" DECIMAL(6,2),
    "discount_type" "DiscountType" DEFAULT 'FLAT',
    "discount_value" DECIMAL(6,2),
    "order_bundle_id" INTEGER,

    CONSTRAINT "Order_Item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Coupon" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(20) NOT NULL,
    "status" "CouponStatus" NOT NULL DEFAULT 'INACTIVE',
    "expired_at" TIMESTAMP(3),
    "max_total_applied" INTEGER DEFAULT -1,
    "max_applied_by_shop" INTEGER DEFAULT -1,
    "discount_type" "DiscountType" DEFAULT 'FLAT',
    "discount_value" DECIMAL(6,2),
    "min_order_amount" DECIMAL(6,2),
    "max_discount_limit" DECIMAL(6,2) DEFAULT -1,
    "is_apply_on_asset_discount" BOOLEAN DEFAULT true,
    "affiliated_by" INTEGER,
    "commission_type" "DiscountType" DEFAULT 'FLAT',
    "commission_value" DECIMAL(6,2),
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Coupon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Affiliator" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "invited_by" INTEGER,
    "type" "AffiliatorType" NOT NULL,
    "type_other" TEXT,
    "status" "AffiliatorStatus" NOT NULL DEFAULT 'PENDING',
    "total_earned" DECIMAL(10,2),
    "total_paid" DECIMAL(10,2),
    "current_coupon_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Affiliator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Affiliator_Commission" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "affiliator_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "order_id" INTEGER,
    "shop_id" INTEGER,
    "coupon_id" INTEGER,
    "coupon_code" VARCHAR(20),
    "order_amout" DECIMAL(7,2),
    "coupon_discount_type" "DiscountType" DEFAULT 'FLAT',
    "coupon_discount_value" DECIMAL(6,2),
    "commission_type" "DiscountType" NOT NULL DEFAULT 'FLAT',
    "commission_value" DECIMAL(6,2) NOT NULL,
    "amount" DECIMAL(6,2) NOT NULL,
    "status" "CommissionStatus" NOT NULL DEFAULT 'APPROVED',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Affiliator_Commission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Affiliator_Withdraw_Request" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "affiliator_id" INTEGER NOT NULL,
    "status" "CommissionWithdrawStatus" NOT NULL DEFAULT 'PENDING',
    "amount" DECIMAL(8,2) NOT NULL,
    "payment_method_id" INTEGER NOT NULL,
    "payment_method" "PaymentMethod" NOT NULL,
    "payment_method_details" JSONB NOT NULL,
    "assignee" INTEGER,
    "note" VARCHAR(255),
    "reject_reason" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Affiliator_Withdraw_Request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User_Pament_Method" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "method" "PaymentMethod" NOT NULL,
    "details" JSONB NOT NULL,
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "User_Pament_Method_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pricing_Plan" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "tagline" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" "PricingPlanType" NOT NULL,
    "is_recommended" BOOLEAN NOT NULL DEFAULT false,
    "is_popular" BOOLEAN NOT NULL DEFAULT false,
    "price" DECIMAL(6,2) NOT NULL,
    "discounted_price" DECIMAL(6,2),
    "yearly_discounted_price" DECIMAL(6,2),
    "trial_period" SMALLINT,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Pricing_Plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pricing_Plan_Feature" (
    "id" SERIAL NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "type" TEXT,
    "description" TEXT,

    CONSTRAINT "Pricing_Plan_Feature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shop_Subscription" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "shop_id" INTEGER NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "plan_type" "PricingPlanType" NOT NULL DEFAULT 'FREE',
    "status" "SubscriptionStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ended_at" TIMESTAMP(3),
    "ended_type" "SubscriptionEndedType",
    "updated_at" TIMESTAMP(3) NOT NULL,
    "amount" DECIMAL(8,2) NOT NULL,
    "payment_method" "PaymentMethod" NOT NULL DEFAULT 'SHOPIFY',

    CONSTRAINT "Shop_Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Faq" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "question" TEXT NOT NULL,
    "answer" VARCHAR(1000) NOT NULL,
    "status" "FaqStatus" NOT NULL DEFAULT 'DRAFT',
    "category_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Faq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Faq_Category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(80) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "description" TEXT,
    "banner" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by" INTEGER,

    CONSTRAINT "Faq_Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attachment" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "url" TEXT NOT NULL,
    "type" "AttachmentType" NOT NULL DEFAULT 'IMAGE',
    "ref_id" INTEGER NOT NULL,
    "ref_type" "AttachmentRefType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Attachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wishlist" (
    "id" SERIAL NOT NULL,
    "shop_id" INTEGER NOT NULL,
    "element_id" INTEGER NOT NULL,
    "element_type" "ElementType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Wishlist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bookmark" (
    "id" SERIAL NOT NULL,
    "shop_id" INTEGER NOT NULL,
    "element_id" INTEGER NOT NULL,
    "element_type" "ElementType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Bookmark_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Recent_Used_Element" (
    "id" SERIAL NOT NULL,
    "shop_id" INTEGER NOT NULL,
    "element_id" INTEGER NOT NULL,
    "element_type" "ElementType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Recent_Used_Element_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Support_Ticket" (
    "id" SERIAL NOT NULL,
    "uuid" CHAR(14) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "ref_id" INTEGER NOT NULL,
    "ref_type" "SupportRefType" NOT NULL,
    "criteria" "SupportCriteria" NOT NULL,
    "reason" TEXT NOT NULL,
    "description" VARCHAR(2000) NOT NULL,
    "status" "SupportStatus" DEFAULT 'PENDING',
    "label" "SupportLabel" DEFAULT 'SEVERITY_1',
    "assignee" INTEGER,
    "assigned_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Support_Ticket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ticket_Message" (
    "id" SERIAL NOT NULL,
    "ticket_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "message" VARCHAR(1000) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ticket_Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact_Request" (
    "id" SERIAL NOT NULL,
    "message" VARCHAR(2000) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(20) NOT NULL,
    "country_code" VARCHAR(10) NOT NULL,
    "country" VARCHAR(100),
    "status" "ContactStatus" DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Contact_Request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team_Member" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "role" "TeamMemberRole" NOT NULL DEFAULT 'MANAGER',
    "designation" TEXT,
    "badge" TEXT,
    "invited_by" INTEGER,
    "onboarded_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Team_Member_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Shop_uuid_key" ON "Shop"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Element_slug_key" ON "Element"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Element_file_name_key" ON "Element"("file_name");

-- CreateIndex
CREATE UNIQUE INDEX "Bundle_slug_key" ON "Bundle"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Category_slug_key" ON "Category"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_slug_key" ON "Tag"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Order_uuid_key" ON "Order"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Coupon_code_key" ON "Coupon"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Affiliator_uuid_key" ON "Affiliator"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Affiliator_Commission_uuid_key" ON "Affiliator_Commission"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Affiliator_Withdraw_Request_uuid_key" ON "Affiliator_Withdraw_Request"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Pricing_Plan_type_key" ON "Pricing_Plan"("type");

-- CreateIndex
CREATE UNIQUE INDEX "Shop_Subscription_uuid_key" ON "Shop_Subscription"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Attachment_uuid_key" ON "Attachment"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Support_Ticket_uuid_key" ON "Support_Ticket"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Contact_Request_email_key" ON "Contact_Request"("email");

-- AddForeignKey
ALTER TABLE "Shop" ADD CONSTRAINT "Shop_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shop" ADD CONSTRAINT "Shop_subscription_id_fkey" FOREIGN KEY ("subscription_id") REFERENCES "Shop_Subscription"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element" ADD CONSTRAINT "Element_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle" ADD CONSTRAINT "Bundle_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Element" ADD CONSTRAINT "Bundle_Element_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Element" ADD CONSTRAINT "Bundle_Element_bundle_id_fkey" FOREIGN KEY ("bundle_id") REFERENCES "Bundle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Element" ADD CONSTRAINT "Bundle_Element_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Image" ADD CONSTRAINT "Element_Image_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Image" ADD CONSTRAINT "Bundle_Image_bundle_id_fkey" FOREIGN KEY ("bundle_id") REFERENCES "Bundle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Best_Use" ADD CONSTRAINT "Element_Best_Use_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Category" ADD CONSTRAINT "Category_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Category" ADD CONSTRAINT "Element_Category_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Category" ADD CONSTRAINT "Element_Category_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Category" ADD CONSTRAINT "Bundle_Category_bundle_id_fkey" FOREIGN KEY ("bundle_id") REFERENCES "Bundle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bundle_Category" ADD CONSTRAINT "Bundle_Category_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tag" ADD CONSTRAINT "Tag_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Tag" ADD CONSTRAINT "Element_Tag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "Tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Element_Tag" ADD CONSTRAINT "Element_Tag_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "Shop"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order_Item" ADD CONSTRAINT "Order_Item_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Coupon" ADD CONSTRAINT "Coupon_affiliated_by_fkey" FOREIGN KEY ("affiliated_by") REFERENCES "Affiliator"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Coupon" ADD CONSTRAINT "Coupon_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator" ADD CONSTRAINT "Affiliator_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Commission" ADD CONSTRAINT "Affiliator_Commission_affiliator_id_fkey" FOREIGN KEY ("affiliator_id") REFERENCES "Affiliator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Commission" ADD CONSTRAINT "Affiliator_Commission_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Commission" ADD CONSTRAINT "Affiliator_Commission_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Commission" ADD CONSTRAINT "Affiliator_Commission_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "Shop"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Commission" ADD CONSTRAINT "Affiliator_Commission_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Withdraw_Request" ADD CONSTRAINT "Affiliator_Withdraw_Request_affiliator_id_fkey" FOREIGN KEY ("affiliator_id") REFERENCES "Affiliator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Withdraw_Request" ADD CONSTRAINT "Affiliator_Withdraw_Request_payment_method_id_fkey" FOREIGN KEY ("payment_method_id") REFERENCES "User_Pament_Method"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Affiliator_Withdraw_Request" ADD CONSTRAINT "Affiliator_Withdraw_Request_assignee_fkey" FOREIGN KEY ("assignee") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Pament_Method" ADD CONSTRAINT "User_Pament_Method_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pricing_Plan" ADD CONSTRAINT "Pricing_Plan_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pricing_Plan_Feature" ADD CONSTRAINT "Pricing_Plan_Feature_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "Pricing_Plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shop_Subscription" ADD CONSTRAINT "Shop_Subscription_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "Pricing_Plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Faq" ADD CONSTRAINT "Faq_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Faq" ADD CONSTRAINT "Faq_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Faq_Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Faq_Category" ADD CONSTRAINT "Faq_Category_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wishlist" ADD CONSTRAINT "Wishlist_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "Shop"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wishlist" ADD CONSTRAINT "Wishlist_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bookmark" ADD CONSTRAINT "Bookmark_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "Shop"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bookmark" ADD CONSTRAINT "Bookmark_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recent_Used_Element" ADD CONSTRAINT "Recent_Used_Element_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "Shop"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Recent_Used_Element" ADD CONSTRAINT "Recent_Used_Element_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "Element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support_Ticket" ADD CONSTRAINT "Support_Ticket_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket_Message" ADD CONSTRAINT "Ticket_Message_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket_Message" ADD CONSTRAINT "Ticket_Message_ticket_id_fkey" FOREIGN KEY ("ticket_id") REFERENCES "Support_Ticket"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team_Member" ADD CONSTRAINT "Team_Member_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
