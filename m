Return-Path: <netdev+bounces-130892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B006298BE76
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4481F244BD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9E1C6F6D;
	Tue,  1 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nDdomUXb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A51C6882;
	Tue,  1 Oct 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790691; cv=none; b=Po2uFuBX0Nn6R7Zt7i9ba/l+SfhurFtiuCc1yrJJ8EsCE7YMz0v/jR+955ybhCu8M5AISmzvDgUr67RTxW5P7UhrXUDlu1PElkZxlOAlsH9T9s0HNWC3g50+QUrjQaHxB8FzpkwKw0pxKocOZlokI2/j6HL1etgxmdORE+htAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790691; c=relaxed/simple;
	bh=ijMW5RzCkyQoUXSiJAYPdvPuN261oROQzb5ESEblIEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fyJwgtDqiH1/fThZ9ZrzMMVgnnYCv0bQ43Cy7i4RJCMR1s+eVgoVk/UamyRqhgUaCbrjioe6a8h6z/Ft9+UGF8xLyz5lF/wVphoPdvMQvhQQXvcJZtQjGtkFQR0nZYUdHsLaP29zk/SWLqEwzvdefMH0h/OYfQ2Zr5GaTZ9614M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nDdomUXb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790689; x=1759326689;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ijMW5RzCkyQoUXSiJAYPdvPuN261oROQzb5ESEblIEQ=;
  b=nDdomUXb4DNQGBRP+KYBG5JE5++mwQ+vveDBON5CBxvYPGdo1UHyxhap
   toVqvcPvsgnuVJVzeR7buBMezuYFBpaXZqOytgxQkWP/A4rTZYJ3oUR+H
   Rny2K2CuCMejUwvkxEBzLToScJTmYEAADsMqdZtKm+ZhmwqPjuwOKzcRN
   bWH7Lw0m8bTOpPyQajtM4PvrS8O6wuuGPxV4IPzY7XpFHa3k9UwbmT8mK
   X0j1O3P0CNgiAFGZ31jPXhQ0jChlqrr0WJX5e3qU2vEPDVZ5JtwH7g6A4
   1VQMEPPw7DhJBlN6ybEyTKVIEj32jijkBrqNXHR1+3SwjO8PUmx9sIjBA
   g==;
X-CSE-ConnectionGUID: xZlwFxFMQxGj0XznyNUoig==
X-CSE-MsgGUID: p80BGmBvRoCdME4RkCMzeg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057486"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:02 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:50:59 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:31 +0200
Subject: [PATCH net-next 01/15] net: sparx5: add support for private match
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-1-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, add support for private match data. This
will be needed for abstracting away differences between the Sparx5 and
lan969x platforms. We initially add values for: iomap, iomap size and
ioranges. Update the use of these throughout.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 36 +++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 13 ++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index b64c814eac11..179a1dc0d8f6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -45,12 +45,6 @@ struct sparx5_ram_config {
 	u32 init_val;
 };
 
-struct sparx5_main_io_resource {
-	enum sparx5_target id;
-	phys_addr_t offset;
-	int range;
-};
-
 static const struct sparx5_main_io_resource sparx5_main_iomap[] =  {
 	{ TARGET_CPU,                         0, 0 }, /* 0x600000000 */
 	{ TARGET_FDMA,                  0x80000, 0 }, /* 0x600080000 */
@@ -216,21 +210,24 @@ static const struct sparx5_main_io_resource sparx5_main_iomap[] =  {
 
 static int sparx5_create_targets(struct sparx5 *sparx5)
 {
+	const struct sparx5_main_io_resource *iomap = sparx5->data->iomap;
+	int iomap_size = sparx5->data->iomap_size;
+	int ioranges = sparx5->data->ioranges;
 	struct resource *iores[IO_RANGES];
 	void __iomem *iomem[IO_RANGES];
 	void __iomem *begin[IO_RANGES];
 	int range_id[IO_RANGES];
 	int idx, jdx;
 
-	for (idx = 0, jdx = 0; jdx < ARRAY_SIZE(sparx5_main_iomap); jdx++) {
-		const struct sparx5_main_io_resource *iomap = &sparx5_main_iomap[jdx];
+	for (idx = 0, jdx = 0; jdx < iomap_size; jdx++) {
+		const struct sparx5_main_io_resource *io = &iomap[jdx];
 
-		if (idx == iomap->range) {
+		if (idx == io->range) {
 			range_id[idx] = jdx;
 			idx++;
 		}
 	}
-	for (idx = 0; idx < IO_RANGES; idx++) {
+	for (idx = 0; idx < ioranges; idx++) {
 		iores[idx] = platform_get_resource(sparx5->pdev, IORESOURCE_MEM,
 						   idx);
 		if (!iores[idx]) {
@@ -245,12 +242,12 @@ static int sparx5_create_targets(struct sparx5 *sparx5)
 				iores[idx]->name);
 			return -ENOMEM;
 		}
-		begin[idx] = iomem[idx] - sparx5_main_iomap[range_id[idx]].offset;
+		begin[idx] = iomem[idx] - iomap[range_id[idx]].offset;
 	}
-	for (jdx = 0; jdx < ARRAY_SIZE(sparx5_main_iomap); jdx++) {
-		const struct sparx5_main_io_resource *iomap = &sparx5_main_iomap[jdx];
+	for (jdx = 0; jdx < iomap_size; jdx++) {
+		const struct sparx5_main_io_resource *io = &iomap[jdx];
 
-		sparx5->regs[iomap->id] = begin[iomap->range] + iomap->offset;
+		sparx5->regs[io->id] = begin[io->range] + io->offset;
 	}
 	return 0;
 }
@@ -759,6 +756,9 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5->dev = &pdev->dev;
 	spin_lock_init(&sparx5->tx_lock);
 
+	sparx5->data = device_get_match_data(sparx5->dev);
+	if (!sparx5->data)
+		return -EINVAL;
 	/* Do switch core reset if available */
 	reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
 	if (IS_ERR(reset))
@@ -937,8 +937,14 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	destroy_workqueue(sparx5->mact_queue);
 }
 
+static const struct sparx5_match_data sparx5_desc = {
+	.iomap = sparx5_main_iomap,
+	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
+	.ioranges = 3,
+};
+
 static const struct of_device_id mchp_sparx5_match[] = {
-	{ .compatible = "microchip,sparx5-switch" },
+	{ .compatible = "microchip,sparx5-switch", .data = &sparx5_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp_sparx5_match);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 3309060b1e4c..845f918aaf5e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -226,6 +226,18 @@ struct sparx5_mall_entry {
 #define SPARX5_SKB_CB(skb) \
 	((struct sparx5_skb_cb *)((skb)->cb))
 
+struct sparx5_main_io_resource {
+	enum sparx5_target id;
+	phys_addr_t offset;
+	int range;
+};
+
+struct sparx5_match_data {
+	const struct sparx5_main_io_resource *iomap;
+	int ioranges;
+	int iomap_size;
+};
+
 struct sparx5 {
 	struct platform_device *pdev;
 	struct device *dev;
@@ -293,6 +305,7 @@ struct sparx5 {
 	struct list_head mall_entries;
 	/* Common root for debugfs */
 	struct dentry *debugfs_root;
+	const struct sparx5_match_data *data;
 };
 
 /* sparx5_switchdev.c */

-- 
2.34.1


