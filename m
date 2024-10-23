Return-Path: <netdev+bounces-138426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B49AD74D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700B41F212FD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B12208968;
	Wed, 23 Oct 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qGAJKwRL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B2200120;
	Wed, 23 Oct 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720982; cv=none; b=XIBBYXtjkdfW+zCCc/NOx/9bM4UWyobeaL6K/K28Md0Mp5hVoW24zSFdyiWqTHJ7VP75RIG9vznDCMfqpdtTSJjFwFCgCh6x+YbS0tqdbK1tFa0TUb38BKGYjHP/T2SxJC6IQ/dwnv6ubLRLBd8YC2PzCBqpy7iwEW0opuKky0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720982; c=relaxed/simple;
	bh=esNMXB8X1MNGOmYz9S2m1lVZA9GJT5ND8odp2j2gb6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Vs4yRmNJoA9MteS899g6k5UD8Qlus76Lb9MpdLyAH8fHLTiqtFCrHVbV4QoK434kvM5TxVIVtYbEJvoJeUQXDYE/67rv8LCqtgF++AcgIy0xsDdByZSykbMstaAN+77su0EUt0qUreRzpStflGkG1SF5JWgy+8I2iFrLMvGCEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qGAJKwRL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720980; x=1761256980;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=esNMXB8X1MNGOmYz9S2m1lVZA9GJT5ND8odp2j2gb6Q=;
  b=qGAJKwRLcbre0hEdB4jV30Fy2aOFhy+H5EaYtoaL7esb2jhqYzyq42Xi
   OBiQXK5drDXi0lgfMaeUTrB77F2rR+cFCtQsi5n82TDh0b0M4NY0dBczW
   ltlEY2fcSNkJT//GQRvg9R+HF+S3UUcYt/lAUgWGIYZvPPCNU2ONRQpRd
   f+cTuQPgmOGebvieZdYcpDNStRh50ULs+SoFdiBU9fU7Fz0J/Sc274RIz
   ENwbq2aCQKgm8CHIy+a8+muioEnUc21KNBF9aeyVzsTAOh+3BIoeFCRDf
   LlQutq8ZXxNEIxFqQmwASxoRAmyoVBm93n5t365AOjzl8dvXEoS30vS/p
   A==;
X-CSE-ConnectionGUID: oMPErp9qRFmiMc0P9W4Bgw==
X-CSE-MsgGUID: dsoK4pyNSSyagCAMHqgqUA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="264507062"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:42 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:38 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:34 +0200
Subject: [PATCH net-next v2 15/15] net: sparx5: add feature support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-15-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Lan969x supports a number of different features, depending on the
target. Add new field sparx5->features and initialize the features based
on the target. Also add the function sparx5_has_feature() and use it
throughout. For now, we only need to handle features: PSFP and PTP -
more will come in the future.

[1] https://www.microchip.com/en-us/product/lan9698

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 40 +++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  7 ++++
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |  5 +++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index fde9e06b3458..4f2d5413a64f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -229,6 +229,40 @@ bool is_sparx5(struct sparx5 *sparx5)
 	}
 }
 
+static void sparx5_init_features(struct sparx5 *sparx5)
+{
+	switch (sparx5->target_ct) {
+	case SPX5_TARGET_CT_7546:
+	case SPX5_TARGET_CT_7549:
+	case SPX5_TARGET_CT_7552:
+	case SPX5_TARGET_CT_7556:
+	case SPX5_TARGET_CT_7558:
+	case SPX5_TARGET_CT_7546TSN:
+	case SPX5_TARGET_CT_7549TSN:
+	case SPX5_TARGET_CT_7552TSN:
+	case SPX5_TARGET_CT_7556TSN:
+	case SPX5_TARGET_CT_7558TSN:
+	case SPX5_TARGET_CT_LAN9691VAO:
+	case SPX5_TARGET_CT_LAN9694TSN:
+	case SPX5_TARGET_CT_LAN9694RED:
+	case SPX5_TARGET_CT_LAN9692VAO:
+	case SPX5_TARGET_CT_LAN9696TSN:
+	case SPX5_TARGET_CT_LAN9696RED:
+	case SPX5_TARGET_CT_LAN9693VAO:
+	case SPX5_TARGET_CT_LAN9698TSN:
+	case SPX5_TARGET_CT_LAN9698RED:
+		sparx5->features = (SPX5_FEATURE_PSFP | SPX5_FEATURE_PTP);
+		break;
+	default:
+		break;
+	}
+}
+
+bool sparx5_has_feature(struct sparx5 *sparx5, enum sparx5_feature feature)
+{
+	return sparx5->features & feature;
+}
+
 static int sparx5_create_targets(struct sparx5 *sparx5)
 {
 	const struct sparx5_main_io_resource *iomap = sparx5->data->iomap;
@@ -771,7 +805,8 @@ static int sparx5_start(struct sparx5 *sparx5)
 		sparx5->xtr_irq = -ENXIO;
 	}
 
-	if (sparx5->ptp_irq >= 0) {
+	if (sparx5->ptp_irq >= 0 &&
+	    sparx5_has_feature(sparx5, SPX5_FEATURE_PTP)) {
 		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
 						NULL, ops->ptp_irq_handler,
 						IRQF_ONESHOT, "sparx5-ptp",
@@ -915,6 +950,9 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5->target_ct = (enum spx5_target_chiptype)
 		GCB_CHIP_ID_PART_ID_GET(sparx5->chip_id);
 
+	/* Initialize the features based on the target */
+	sparx5_init_features(sparx5);
+
 	/* Initialize Switchcore and internal RAMs */
 	err = sparx5_init_switchcore(sparx5);
 	if (err) {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 1828e2a7d610..146bdc938adc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -75,6 +75,11 @@ enum sparx5_cal_bw {
 	SPX5_CAL_SPEED_12G5 = 7
 };
 
+enum sparx5_feature {
+	SPX5_FEATURE_PSFP = BIT(0),
+	SPX5_FEATURE_PTP  = BIT(1),
+};
+
 #define SPX5_PORTS             65
 #define SPX5_PORTS_ALL         70 /* Total number of ports */
 
@@ -337,6 +342,7 @@ struct sparx5 {
 	struct device *dev;
 	u32 chip_id;
 	enum spx5_target_chiptype target_ct;
+	u32 features;
 	void __iomem *regs[NUM_TARGETS];
 	int port_count;
 	struct mutex lock; /* MAC reg lock */
@@ -404,6 +410,7 @@ struct sparx5 {
 
 /* sparx5_main.c */
 bool is_sparx5(struct sparx5 *sparx5);
+bool sparx5_has_feature(struct sparx5 *sparx5, enum sparx5_feature feature);
 
 /* sparx5_switchdev.c */
 int sparx5_register_notifier_blocks(struct sparx5 *sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index c3bbed140554..4dc1ebd5d510 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -1284,6 +1284,11 @@ static int sparx5_tc_flower_replace(struct net_device *ndev,
 
 	/* Setup PSFP */
 	if (tc_sg_idx >= 0 || tc_pol_idx >= 0) {
+		if (!sparx5_has_feature(sparx5, SPX5_FEATURE_PSFP)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
 		err = sparx5_tc_flower_psfp_setup(sparx5, vrule, tc_sg_idx,
 						  tc_pol_idx, &sg, &fm, &sf);
 		if (err)

-- 
2.34.1


