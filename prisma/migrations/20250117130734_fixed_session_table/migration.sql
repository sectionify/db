/*
  Warnings:

  - The primary key for the `Session` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `accessToken` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Made the column `state` on table `Session` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Session" DROP CONSTRAINT "Session_pkey",
ADD COLUMN     "accessToken" TEXT NOT NULL,
ADD COLUMN     "expires" TIMESTAMP(3),
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "state" SET NOT NULL,
ALTER COLUMN "isOnline" SET DEFAULT false,
ALTER COLUMN "scope" DROP NOT NULL,
ALTER COLUMN "userId" SET DATA TYPE BIGINT,
ADD CONSTRAINT "Session_pkey" PRIMARY KEY ("id");
