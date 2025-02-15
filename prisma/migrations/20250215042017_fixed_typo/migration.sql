/*
  Warnings:

  - The values [DECLAINED] on the enum `SubscriptionEndedType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "SubscriptionEndedType_new" AS ENUM ('DECLINED', 'TRIAL_CENCELLED', 'TRIAL_SUCCESS', 'FAILED_PAYMENT', 'REFUNED', 'UPGRADED', 'DOWNGRADED');
ALTER TABLE "Shop_Subscription" ALTER COLUMN "ended_type" TYPE "SubscriptionEndedType_new" USING ("ended_type"::text::"SubscriptionEndedType_new");
ALTER TYPE "SubscriptionEndedType" RENAME TO "SubscriptionEndedType_old";
ALTER TYPE "SubscriptionEndedType_new" RENAME TO "SubscriptionEndedType";
DROP TYPE "SubscriptionEndedType_old";
COMMIT;
