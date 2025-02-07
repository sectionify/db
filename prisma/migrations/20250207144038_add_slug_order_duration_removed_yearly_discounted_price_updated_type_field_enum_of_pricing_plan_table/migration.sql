/*
  Warnings:

  - The values [PRO,ELITE] on the enum `PricingPlanType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `yearly_discounted_price` on the `Pricing_Plan` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[slug]` on the table `Pricing_Plan` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `order` to the `Pricing_Plan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `slug` to the `Pricing_Plan` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "PricingPlanType_new" AS ENUM ('FREE', 'RECURRING', 'LIFETIME', 'ENTERPRISE');
ALTER TABLE "Shop_Subscription" ALTER COLUMN "plan_type" DROP DEFAULT;
ALTER TABLE "Pricing_Plan" ALTER COLUMN "type" TYPE "PricingPlanType_new" USING ("type"::text::"PricingPlanType_new");
ALTER TABLE "Shop_Subscription" ALTER COLUMN "plan_type" TYPE "PricingPlanType_new" USING ("plan_type"::text::"PricingPlanType_new");
ALTER TYPE "PricingPlanType" RENAME TO "PricingPlanType_old";
ALTER TYPE "PricingPlanType_new" RENAME TO "PricingPlanType";
DROP TYPE "PricingPlanType_old";
ALTER TABLE "Shop_Subscription" ALTER COLUMN "plan_type" SET DEFAULT 'FREE';
COMMIT;

-- DropIndex
DROP INDEX "Pricing_Plan_type_key";

-- AlterTable
ALTER TABLE "Pricing_Plan" DROP COLUMN "yearly_discounted_price",
ADD COLUMN     "duration" INTEGER,
ADD COLUMN     "order" SMALLINT NOT NULL,
ADD COLUMN     "slug" TEXT NOT NULL,
ALTER COLUMN "type" SET DEFAULT 'FREE';

-- CreateIndex
CREATE UNIQUE INDEX "Pricing_Plan_slug_key" ON "Pricing_Plan"("slug");
