Return-Path: <netdev+bounces-132040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF19903E4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF4D2837B6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0672210198;
	Fri,  4 Oct 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K6KDRtaX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6C1D0E13;
	Fri,  4 Oct 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048022; cv=none; b=Q1iYcZxpYlxQ0Z9gk6GnrBbMCcZRLc29rA3cp86wmvuybJVvFx2vTaoPNdZLqKxFK5VkXKNTqTwUyjAYZHkAA3p/PRsyz7H5Cw7m379ZQl+WpTomrGBVW/1RpzwI8q5bkDod+RcZzzkHRPWcbDJujY3B8W0WPwYJ3iL3Wcmn+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048022; c=relaxed/simple;
	bh=ZgIfoJKE70OfDrnxeepB0+UdKBWVD8lBJiTimBT63eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lSkG4TV63y6zi/XADXQW5MGndLHzYfOR2q2043xsdnjE/Ep4vHXzTPg/j4usteqgg2Gg9g9knOkXByAvGMD1TIpC4NZumaIO8CRr+Sp3Xqhpy0rhM2V0dy8SdH4YXKnj97l47UKPs7xYgau93HRBlLHy02YGSyvjHYcjCdMuzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K6KDRtaX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048020; x=1759584020;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZgIfoJKE70OfDrnxeepB0+UdKBWVD8lBJiTimBT63eg=;
  b=K6KDRtaXsUi7MKtfeJGw5XDaVi1CVLDl4NVYm22ISNhJ91fLx3ytVgPX
   r0yrX1DSfmMDgaB7oX4yEbxJ3IYz2vuZloUF3OpKL0UHWhWKGD85/SV8G
   ewFfoWOqAClaM97G04t5zzMHNFJUFOHi9l7RIp6NtNVt4oqOxydcSryu0
   H2BWKiB8bdajZysth5YsFAb+TbNmyTVKgsp9v0U0MwbmKevUy6HE31O6W
   jZWNHHjbef/byqLui/dy//KH2C/n+dbG5Js8SrCh+mb38oTnd2BPanFsy
   LtnIIgH/zF1MVpMoQAfreWLw3+t+Gb6QvhsNcEoh+Th3bljdSRqPXtK7K
   A==;
X-CSE-ConnectionGUID: tcwBQ5UAQ6iS5vHYLyjR6g==
X-CSE-MsgGUID: UXo280B2RLW+467+kBo9DA==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32444619"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:06 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:27 +0200
Subject: [PATCH net-next v2 01/15] net: sparx5: add support for private
 match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-1-d3290f581663@microchip.com>
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, add support for private match data. This
will be needed for abstracting away differences between the Sparx5 and
lan969x platforms. We initially add values for: iomap, iomap size and
ioranges. Update the use of these throughout.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
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


