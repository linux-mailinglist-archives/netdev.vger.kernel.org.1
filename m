Return-Path: <netdev+bounces-230347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CABE6D5C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194751A68242
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1A3128AF;
	Fri, 17 Oct 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HlcA9J5B"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA73126DB;
	Fri, 17 Oct 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684054; cv=none; b=JMvS/bdZshNjwTGkpnP6+AoIk6erX8VnvJanIQe0nPFHDyiS/PpkNgPUJOko7YnSG8GUPzpnFZ7l1iLUJiZNObyBr42tzr7cpkNUDrX2vBt6pdaAVOh/6ioqMHC/Sv/oBx+wlXs8xYmTd+0bfhKWxlllepvGF2s3m5/1ADkMfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684054; c=relaxed/simple;
	bh=3A0XwV/s9Cz0cJD1NLMBEssaMoEiPQPonBn6LqMuYqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmjobL3SUWQ5XeIp2vV8dyAJaLE03xM+29N5tNZ0uGlizzhewVs2fBH2jyON2jyB4MuCEm1BpyvEWRas47I54rEiGAfDiP4m3Wy0pgqeOj6WFyB6TTb8dfZ581nC9g+sYM8u3vjgSdrz0qr7EbqAr8YYxpj7tB07oUbpkr1rXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HlcA9J5B; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760684052; x=1792220052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3A0XwV/s9Cz0cJD1NLMBEssaMoEiPQPonBn6LqMuYqw=;
  b=HlcA9J5BeQH/XenE2g2PkzjIh32ocdDLKhSAq5ERg2LdKV+Z4eLPWzig
   fG20FQ+Qi68EvBnOsquCACuZDeOry2fYoMx161F9/Ev32P0tEyg1Uvz6l
   fKHHjg+hSX8IvZmuUSXEVUOrJt/ahKCFeB8w/fJH/Sdh+I5r2mhvJJZ5d
   D+tAvh+gzHFEVI/xo/i7yCygF3e/YILwN5pjsTKaE+Nv9G7/E8FEKp+hf
   8QW9pbFkFcJh8vWey7vblwYoo/FkbwpzWAnHajazfkKRtn0a62K179bCI
   3i41c6xLUObsaalwKeR6MKsm0ScFCTbY7Sy3rZ0uzdDGH9oWwqMz+6sD1
   Q==;
X-CSE-ConnectionGUID: +cWLnLSSQKWQk8EtywTa8g==
X-CSE-MsgGUID: qg+5549WSdKhK3uu7QmnNQ==
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="215250385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 23:54:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 16 Oct 2025 23:53:46 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 16 Oct 2025 23:53:43 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 1/2] phy: mscc: Use PHY_ID_MATCH_MODEL for VSC8584, VSC8582, VSC8575, VSC856X
Date: Fri, 17 Oct 2025 08:48:18 +0200
Message-ID: <20251017064819.3048793-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As the PHYs VSC8584, VSC8582, VSC8575 and VSC856X exists only as rev B,
we can use PHY_ID_MATCH_MODEL to match exactly on revision B of the PHY.
Because of this change then there is not need the check if it is a
different revision than rev B in the function vsc8584_probe() as we
already know that this will never happen.
These changes are a preparation for the next patch because in that patch
we will make the PHYs VSC8574 and VSC8572 to use vsc8584_probe() and
these PHYs have multiple revision.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc.h      |  8 ++++----
 drivers/net/phy/mscc/mscc_main.c | 23 ++++-------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 2d8eca54c40a2..2eef5956b9cc5 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -289,12 +289,12 @@ enum rgmii_clock_delay {
 #define PHY_ID_VSC8540			  0x00070760
 #define PHY_ID_VSC8541			  0x00070770
 #define PHY_ID_VSC8552			  0x000704e0
-#define PHY_ID_VSC856X			  0x000707e0
+#define PHY_ID_VSC856X			  0x000707e1
 #define PHY_ID_VSC8572			  0x000704d0
 #define PHY_ID_VSC8574			  0x000704a0
-#define PHY_ID_VSC8575			  0x000707d0
-#define PHY_ID_VSC8582			  0x000707b0
-#define PHY_ID_VSC8584			  0x000707c0
+#define PHY_ID_VSC8575			  0x000707d1
+#define PHY_ID_VSC8582			  0x000707b1
+#define PHY_ID_VSC8584			  0x000707c1
 #define PHY_VENDOR_MSCC			0x00070400
 
 #define MSCC_VDDMAC_1500		  1500
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ef0ef1570d392..d05f6ed052ad0 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1724,12 +1724,6 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	 * in this pre-init function.
 	 */
 	if (phy_package_init_once(phydev)) {
-		/* The following switch statement assumes that the lowest
-		 * nibble of the phy_id_mask is always 0. This works because
-		 * the lowest nibble of the PHY_ID's below are also 0.
-		 */
-		WARN_ON(phydev->drv->phy_id_mask & 0xf);
-
 		switch (phydev->phy_id & phydev->drv->phy_id_mask) {
 		case PHY_ID_VSC8504:
 		case PHY_ID_VSC8552:
@@ -2290,11 +2284,6 @@ static int vsc8584_probe(struct phy_device *phydev)
 	   VSC8531_DUPLEX_COLLISION};
 	int ret;
 
-	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
-		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
-		return -ENOTSUPP;
-	}
-
 	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
 	if (!vsc8531)
 		return -ENOMEM;
@@ -2587,9 +2576,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_inband  = vsc85xx_config_inband,
 },
 {
-	.phy_id		= PHY_ID_VSC856X,
+	PHY_ID_MATCH_MODEL(PHY_ID_VSC856X),
 	.name		= "Microsemi GE VSC856X SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2667,9 +2655,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_inband  = vsc85xx_config_inband,
 },
 {
-	.phy_id		= PHY_ID_VSC8575,
+	PHY_ID_MATCH_MODEL(PHY_ID_VSC8575),
 	.name		= "Microsemi GE VSC8575 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2693,9 +2680,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_inband  = vsc85xx_config_inband,
 },
 {
-	.phy_id		= PHY_ID_VSC8582,
+	PHY_ID_MATCH_MODEL(PHY_ID_VSC8582),
 	.name		= "Microsemi GE VSC8582 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
@@ -2719,9 +2705,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_inband  = vsc85xx_config_inband,
 },
 {
-	.phy_id		= PHY_ID_VSC8584,
+	PHY_ID_MATCH_MODEL(PHY_ID_VSC8584),
 	.name		= "Microsemi GE VSC8584 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
-- 
2.34.1


