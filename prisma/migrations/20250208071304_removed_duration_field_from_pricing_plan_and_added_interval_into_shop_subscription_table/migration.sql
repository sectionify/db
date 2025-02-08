/*
  Warnings:

  - You are about to drop the column `duration` on the `Pricing_Plan` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "SubscriptionInterval" AS ENUM ('NO_INTERVAL', 'ONE_MONTH', 'QUARTER_YEAR', 'HALF_YEAR', 'ONE_YEAR');

-- AlterTable
ALTER TABLE "Pricing_Plan" DROP COLUMN "duration";

-- AlterTable
ALTER TABLE "Shop_Subscription" ADD COLUMN     "interval" "SubscriptionInterval" NOT NULL DEFAULT 'NO_INTERVAL';
