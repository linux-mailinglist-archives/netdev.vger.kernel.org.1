Return-Path: <netdev+bounces-232249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB0C03274
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD9FF4FD5C8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF122882CE;
	Thu, 23 Oct 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N+kGPbix"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F312356C7;
	Thu, 23 Oct 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246943; cv=none; b=kuClwzbmthtM7TfaMDhYceot/pMgvpf537TJn9rVwcYUBoHcSj5twnVe4IriQfAykZeBKMXpFo29biV6HyvdTJVEbmortAnLnsSuYMrD5tTqQfht7D6pgLnYdsIyQtNgLdQ8zSa4njHYFsdPYk42H9Pb7U0V6u7xC08zfYYxorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246943; c=relaxed/simple;
	bh=lBwBnWTT656kmdcY7xIZ2C12l4MOlTwkkMGrs0lq+18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du504Nb3lBGdUzWwa1ir80+hqnE0veGcnmJwE8rEHEUZS4amitYQQWlqXV/P8Tr7NN8wKkUypAqsDyyBN8Vw4VrnGptT6Uk1wW+Nzw3Vvj1ek+Q7TEUVFPEevUHP8djGU42n/VkXQWBkuqsIy/Wsp7itAGRBK4sY0q/JNz6Ains=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N+kGPbix; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761246941; x=1792782941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBwBnWTT656kmdcY7xIZ2C12l4MOlTwkkMGrs0lq+18=;
  b=N+kGPbixEQQhzt0JhSKVO6aESdg8uuRFVtnwAYDgPt/2jKdw2H8wqKuP
   o/CTiqM9ILrO0VAbUyVYetzYyJvDa0Q2w49lLiaPm5aLr5fYAjilMHAis
   sP/YXt5VM3gPBpD/ef00xIxtiTwQZdgfbDboctnwPASTGd0C2nl0lWVZT
   EIK3kS6tnYuIGr+fEktGWVV33Ka42RVkEJhkJAtTJWEw5wgYxcKwuIMvf
   svhYNaMprpABwD41hdCZjlybZpjeYNly52NPNVoUGEYHkZoXj5nvm73SY
   EXKc9sFbuo6SIcFyR1uvo6gQS3SezikyPgQixh7puIoUXx/mudiMhvkj6
   g==;
X-CSE-ConnectionGUID: w2V51oyKREaPdSMAbb7Zcg==
X-CSE-MsgGUID: h/QNsp0JQ52A7AwNAY/qRQ==
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="54427351"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2025 12:15:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 23 Oct 2025 12:15:16 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 23 Oct 2025 12:15:13 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <steen.hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 1/2] phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X
Date: Thu, 23 Oct 2025 21:13:49 +0200
Message-ID: <20251023191350.190940-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023191350.190940-1-horatiu.vultur@microchip.com>
References: <20251023191350.190940-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As the PHYs VSC8584, VSC8582, VSC8575 and VSC856X exists only as rev B,
we can use PHY_ID_MATCH_EXACT to match exactly on revision B of the PHY.
Because of this change then there is not need the check if it is a
different revision than rev B in the function vsc8584_probe() as we
already know that this will never happen.
These changes are a preparation for the next patch because in that patch
we will make the PHYs VSC8574 and VSC8572 to use vsc8584_probe() and
these PHYs have multiple revision.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
index ef0ef1570d392..9343ed3b000d4 100644
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
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC856X),
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
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8575),
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
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8582),
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
+	PHY_ID_MATCH_EXACT(PHY_ID_VSC8584),
 	.name		= "Microsemi GE VSC8584 SyncE",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_GBIT_FEATURES */
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
-- 
2.34.1


