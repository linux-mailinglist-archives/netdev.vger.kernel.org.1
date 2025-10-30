Return-Path: <netdev+bounces-234336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E403AC1F820
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 869CD4E894F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A9351FDC;
	Thu, 30 Oct 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LL3w1CwC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F75350D75;
	Thu, 30 Oct 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819829; cv=none; b=LheFjNeIxP5crd8wCUM/0/kZjGhNlZmyRVvVDsB8ghsHYfm4VhsJDZd+Yl+QgohzZMgbKmXemChzn+muX24j32tyZX8G7pvy92EkY1nj203/d5jKi6qf72acX8lwtpXeT07/+hLkA9xU5y4C76zrlKGqJXZybsz7k7uHSATFX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819829; c=relaxed/simple;
	bh=QCWyTeWQTdz2rrkx4IUKjdVVd/IHi+DG0RIMfOoo050=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqoXj2K/HwENoMx+U0l5b3u3NAslKZT3JiMCEmkxoRQZjhsZs9NT3x7CiWfqpQEhu5HJZmmzmu8okQ8QRd4+9WNOm6NIHuiP12Znq6AY/rZ091zlUnvpl1unOuU6v3OWKXBN8fwp/1a59LstjDj+JYjoGHr5uL7m1jhgBP1b0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LL3w1CwC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761819828; x=1793355828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCWyTeWQTdz2rrkx4IUKjdVVd/IHi+DG0RIMfOoo050=;
  b=LL3w1CwCOb/SWyGZIuydeaAjliC++LxRPnohpNHcOLaZFN1NNomcBQWe
   JTRBWmJz0uGyCfWMiIvJE8zg9MQ4ZlLLQ1R71SXVDkNTRzFmFwLonyosG
   xZCz+PlPMjtudgw/c6rfXmK583qgfEChceFZeLMsL9vhvp0fxpkQpGd5/
   jOq4j9NzsojCO68srvyPGWL+uVmTd92pXiNfgaY/Z7vG9gAgpwL+2KLwQ
   LOZANK0iQf8COLMv8HfMYRYcj4q66Nhsg0znO/l1zMF+KHNQQ5QEPGlLl
   6MlG/pSPmXUXqRXU/ze3ZOxyAeU5AHd8LnzwUC3euO/nMdOHrLhntEx3u
   A==;
X-CSE-ConnectionGUID: +ZPQDKOETWui8K32TZrgPQ==
X-CSE-MsgGUID: nw3j8Gw5Qj+gvb+Lg1oBpw==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48965271"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2025 03:23:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Oct 2025 03:23:13 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 03:23:10 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 2/2] net: phy: microchip_t1s: configure link status control for LAN867x Rev.D0
Date: Thu, 30 Oct 2025 15:52:58 +0530
Message-ID: <20251030102258.180061-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
References: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Configure the link status in the Link Status Control register for
LAN8670/1/2 Rev.D0 PHYs, depending on whether PLCA or CSMA/CD mode
is enabled. When PLCA is enabled, the link status reflects the PLCA
status. When PLCA is disabled (CSMA/CD mode), the PHY does not support
autonegotiation, so the link status is forced active by setting
the LINK_STATUS_SEMAPHORE bit.

The link status control is configured:
- During PHY initialization, for default CSMA/CD mode.
- Whenever PLCA configuration is updated.

This ensures correct link reporting and consistent behavior for
LAN867x Rev.D0 devices.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 51 ++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 03e3bacb02bd..bce5cf087b19 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -33,6 +33,17 @@
 #define COL_DET_ENABLE			BIT(15)
 #define COL_DET_DISABLE			0x0000
 
+/* LAN8670/1/2 Rev.D0 Link Status Selection Register */
+#define LAN867X_REG_LINK_STATUS_CTRL	0x0012
+#define LINK_STATUS_CONFIGURATION	GENMASK(12, 11)
+#define LINK_STATUS_SEMAPHORE		BIT(0)
+
+/* Link Status Configuration */
+#define LINK_STATUS_CONFIG_PLCA_STATUS	0x1
+#define LINK_STATUS_CONFIG_SEMAPHORE	0x2
+
+#define LINK_STATUS_SEMAPHORE_SET	0x1
+
 #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
 
 /* The arrays below are pulled from the following table from AN1699
@@ -393,6 +404,32 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
+					       bool plca_enabled)
+{
+	u16 value;
+
+	if (plca_enabled) {
+		/* 0x1 - When PLCA is enabled: link status reflects plca_status.
+		 */
+		value = FIELD_PREP(LINK_STATUS_CONFIGURATION,
+				   LINK_STATUS_CONFIG_PLCA_STATUS);
+	} else {
+		/* 0x2 - Link status is controlled by the value written into the
+		 * LINK_STATUS_SEMAPHORE bit written. Here the link semaphore
+		 * bit is written with 0x1 to set the link always active in
+		 * CSMA/CD mode as it doesn't support autoneg.
+		 */
+		value = FIELD_PREP(LINK_STATUS_CONFIGURATION,
+				   LINK_STATUS_CONFIG_SEMAPHORE) |
+			FIELD_PREP(LINK_STATUS_SEMAPHORE,
+				   LINK_STATUS_SEMAPHORE_SET);
+	}
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2,
+			     LAN867X_REG_LINK_STATUS_CTRL, value);
+}
+
 /* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
  * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
  * normal operation, the device should be operated in PLCA mode. Disabling
@@ -409,6 +446,14 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 {
 	int ret;
 
+	/* Link status selection must be configured for LAN8670/1/2 Rev.D0 */
+	if (phydev->phy_id == PHY_ID_LAN867X_REVD0) {
+		ret = lan867x_revd0_link_active_selection(phydev,
+							  plca_cfg->enabled);
+		if (ret)
+			return ret;
+	}
+
 	ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
 	if (ret)
 		return ret;
@@ -439,7 +484,11 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	return 0;
+	/* Initially the PHY will be in CSMA/CD mode by default. So it is
+	 * required to set the link always active as it doesn't support
+	 * autoneg.
+	 */
+	return lan867x_revd0_link_active_selection(phydev, false);
 }
 
 static int lan86xx_read_status(struct phy_device *phydev)
-- 
2.34.1


