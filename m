Return-Path: <netdev+bounces-238620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35320C5C126
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 614DB4F2FA0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637392FF648;
	Fri, 14 Nov 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zFLehK29"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02592FDC2F;
	Fri, 14 Nov 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109880; cv=none; b=PhVFr1pcilXFP2cQL0wCEzQzV0NQCuL5fbbmj0vpjEt3GeEznkxPllgODiFTglY/yz92sh/ph/KLbmOmjZdfGR4uRxI0upKXV1QKZBhGq7HhNk9kEymWOANfuvvrtgQOG3E2rXxbhfX3G/bjqDid5aBBKfIWHMsvPC7GinOvjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109880; c=relaxed/simple;
	bh=rRvncGdOGg0uNk0kiNdObKfcBCZSsD86n7PS2OVUAUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTInEk/m6vxE0gS9CuR8s8CjsVe1AZWHkGpczos6Toi3m78CWzRjqQi6eJGNDvnVZcTjKDsQnYLKLuP1fFF+nzkhx2dl5RYG7BkWpw6lkMrwuDGo0lxLy4eg9cLXGr8ERxBwYTn9957GypHeASIHcu+mpn02bVzILGwoWrbMJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zFLehK29; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763109878; x=1794645878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rRvncGdOGg0uNk0kiNdObKfcBCZSsD86n7PS2OVUAUw=;
  b=zFLehK29ms7U63jtCkPPvpnRWmiC3qXpe86Kg43gNIn+uqbPprJ7U5We
   EWRsJEnd24Li04yp4mrIi0NR/9WWx2xlw/FLm/8k8KV9atSFHALu1oVAY
   yyeMKKq3h6RDJDb2AGiRvOda3uGLSJHycv+aufZU8a9nHwRLkFulgfKz5
   iczgC825A3EgXXQ3vbTdquL6wnxyrvbp9IJPbc7OqdnSAIUzg7OdilbND
   bmGojPBsfZXBc28u2cWIdSgCz02noRCuVnghxWwCintPMALjpvIgrpLpl
   +MI0+0nkkUeqEKRbt63Fq2NoYuYrP7CMw8qAKSomh/cEyBXnOwSc5qCb2
   Q==;
X-CSE-ConnectionGUID: /Ggoq0RNSZuLUQBlucezTA==
X-CSE-MsgGUID: sKeKuc4uT3GlyZnq7XfE6w==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="55599272"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 01:44:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 14 Nov 2025 01:44:10 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 14 Nov 2025 01:44:08 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: lan8814: Enable in-band auto-negotiation
Date: Fri, 14 Nov 2025 09:42:24 +0100
Message-ID: <20251114084224.3268928-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan8814 supports two interfaces towards the host (QSGMII and QUSGMII).
Currently the lan8814 disables the auto-negotiation towards the host
side. So, extend this to allow to configure to use in-band
auto-negotiation.
I have tested this only with the QSGMII interface.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 57ea947369fed..5d90ccc20df75 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2988,6 +2988,8 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
 #define LAN_EXT_PAGE_ACCESS_ADDRESS_DATA		0x17
 #define LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC		0x4000
 
+#define LAN8814_QSGMII_TX_CONFIG			0x35
+#define LAN8814_QSGMII_TX_CONFIG_QSGMII			BIT(3)
 #define LAN8814_QSGMII_SOFT_RESET			0x43
 #define LAN8814_QSGMII_SOFT_RESET_BIT			BIT(0)
 #define LAN8814_QSGMII_PCS1G_ANEG_CONFIG		0x13
@@ -4501,12 +4503,24 @@ static void lan8814_setup_led(struct phy_device *phydev, int val)
 static int lan8814_config_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *lan8814 = phydev->priv;
+	int ret;
 
-	/* Disable ANEG with QSGMII PCS Host side */
-	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
-			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
-			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
-			       0);
+	/* Based on the interface type select how the advertise ability is
+	 * encoded, to set as SGMII or as USGMII.
+	 */
+	if (phydev->interface == PHY_INTERFACE_MODE_QSGMII)
+		ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+					     LAN8814_QSGMII_TX_CONFIG,
+					     LAN8814_QSGMII_TX_CONFIG_QSGMII,
+					     LAN8814_QSGMII_TX_CONFIG_QSGMII);
+	else
+		ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+					     LAN8814_QSGMII_TX_CONFIG,
+					     LAN8814_QSGMII_TX_CONFIG_QSGMII,
+					     0);
+
+	if (ret < 0)
+		return ret;
 
 	/* MDI-X setting for swap A,B transmit */
 	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS_DIGITAL, LAN8814_ALIGN_SWAP,
@@ -6640,6 +6654,8 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= kszphy_resume,
 	.config_intr	= lan8814_config_intr,
+	.inband_caps	= lan8842_inband_caps,
+	.config_inband	= lan8842_config_inband,
 	.handle_interrupt = lan8814_handle_interrupt,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
-- 
2.34.1


