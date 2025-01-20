/*
  Warnings:

  - A unique constraint covering the columns `[shopify_shop_id]` on the table `Shop` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Shop_shopify_shop_id_key" ON "Shop"("shopify_shop_id");
