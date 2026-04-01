Return-Path: <netdev+bounces-274093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA38EE0SzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0B37A954
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57C3F301E5DC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7640711E;
	Wed,  1 Apr 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="uvfTnLCm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CE37FF54;
	Wed,  1 Apr 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047169; cv=none; b=BZCywT9YxfLMQd4kFMV0+b8AnBzIlzUBmd506rXOlujVw2mTuSi6eyp+chV0mzYK/OIK6WExrKemsEDHfc6eDoPjmbRIL2wBpWS/Agfzrm0S5s44SOfikYU1LboT/lfUaPCVxe56OxTW1RQVN5QtjAktZ5Oy7ZFP3mngnXoluk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047169; c=relaxed/simple;
	bh=uAK6uWtl2N3QCgz9CIEbY8RPXDs1VTQYnZdTU+twbw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs1fiwwKF9HF9sMV2x9oR+jqx0ouTT8SiPPVaU2f81d4U/CB3mruS38I4wM3/6Nzo89ZVOSR/X0+5jM4Lg10zP5uRZUymDHvIKAuyySsWxmqCfaIPTnFUEEkL55paMw5C6uGqXME/URhxee2gjIGrbtwDfAqla8fZqska+RmEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uvfTnLCm; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4680FA587F;
	Wed,  1 Apr 2026 14:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775047163; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9We7FbIvBoBxpg7u48qiuIazUloFk5vsmTNY4Xnisvw=;
	b=uvfTnLCmiR4s7P/HLF1EZouVs85qajd6tvbzy9Dtbk+rO9lfweCEXsmQwQHjM1kh2kZ2tK
	W1Ne28WprSFPdaQyFbamwWIDePvcQR+nWfwFNnKZB0oNtFvQVhNkGbd1wdFRJTTmHKgbYi
	AhVmpoowFNIXkFOhzbBrgKdABtycXGnv0Ukz6IV7bZ6vdupPg81pGKuZklSCdaYnioDwYD
	a2w4Z1calwhuGhuY6CX1C6sSALmpQN3mrQuIY5+D8NbcHxuGbJv2K8XfIBGhZp2S5RA7Lj
	QZNIc7rWVxOZYjq4r3Wg69B5mGoWGuYhtC9AZOJFlxoWD6Z4nh3XkfbcVK86Kw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: phy: microchip: add downshift tunable support for LAN88xx
Date: Wed,  1 Apr 2026 14:38:44 +0200
Message-ID: <20260401123848.696766-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401123848.696766-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260401123848.696766-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274093-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[raspberrypi.com,armlinux.org.uk,lunn.ch,tipi-net.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: D9D0B37A954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the standard ETHTOOL_PHY_DOWNSHIFT tunable for the LAN88xx
PHY. This allows runtime configuration of the auto-downshift feature
via ethtool:

  ethtool --set-phy-tunable eth0 downshift on count 3

The LAN88xx PHY supports downshifting from 1000BASE-T to 100BASE-TX
after 2-5 failed auto-negotiation attempts. Valid count values are
2, 3, 4 and 5.

This is based on an earlier downstream implementation by Phil Elwell.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/microchip.c  | 64 ++++++++++++++++++++++++++++++++++++
 include/linux/microchipphy.h |  5 +++
 2 files changed, 69 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index dc8634e7bcbe..bc293d2dd130 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Microchip Technology
  */
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mii.h>
@@ -193,6 +194,67 @@ static void lan88xx_config_TR_regs(struct phy_device *phydev)
 		phydev_warn(phydev, "Failed to Set Register[0x1686]\n");
 }
 
+static int lan88xx_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val;
+
+	val = phy_read_paged(phydev, 1, LAN78XX_PHY_CTRL3);
+	if (val < 0)
+		return val;
+
+	if (!(val & LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT)) {
+		*data = DOWNSHIFT_DEV_DISABLE;
+		return 0;
+	}
+
+	*data = FIELD_GET(LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK, val) + 2;
+
+	return 0;
+}
+
+static int lan88xx_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u32 mask = LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK |
+		   LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT;
+
+	if (cnt == DOWNSHIFT_DEV_DISABLE)
+		return phy_modify_paged(phydev, 1, LAN78XX_PHY_CTRL3,
+					LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT, 0);
+
+	if (cnt == DOWNSHIFT_DEV_DEFAULT_COUNT)
+		cnt = 2;
+
+	if (cnt < 2 || cnt > 5)
+		return -EINVAL;
+
+	return phy_modify_paged(phydev, 1, LAN78XX_PHY_CTRL3, mask,
+				FIELD_PREP(LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK,
+					   cnt - 2) |
+				LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT);
+}
+
+static int lan88xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return lan88xx_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lan88xx_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return lan88xx_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int lan88xx_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -499,6 +561,8 @@ static struct phy_driver microchip_phy_driver[] = {
 	.set_wol	= lan88xx_set_wol,
 	.read_page	= lan88xx_read_page,
 	.write_page	= lan88xx_write_page,
+	.get_tunable	= lan88xx_get_tunable,
+	.set_tunable	= lan88xx_set_tunable,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
diff --git a/include/linux/microchipphy.h b/include/linux/microchipphy.h
index 517288da19fd..7da956c666a0 100644
--- a/include/linux/microchipphy.h
+++ b/include/linux/microchipphy.h
@@ -61,6 +61,11 @@
 /* Registers specific to the LAN7800/LAN7850 embedded phy */
 #define LAN78XX_PHY_LED_MODE_SELECT		(0x1D)
 
+/* PHY Control 3 register (page 1) */
+#define LAN78XX_PHY_CTRL3			(0x14)
+#define  LAN78XX_PHY_CTRL3_AUTO_DOWNSHIFT	BIT(4)
+#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK	GENMASK(3, 2)
+
 /* DSP registers */
 #define PHY_ARDENNES_MMD_DEV_3_PHY_CFG		(0x806A)
 #define PHY_ARDENNES_MMD_DEV_3_PHY_CFG_ZD_DLY_EN_	(0x2000)
-- 
2.51.0


