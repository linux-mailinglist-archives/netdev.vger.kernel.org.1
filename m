Return-Path: <netdev+bounces-273358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KFQH9D9ymk2CgYAu9opvQ
	(envelope-from <netdev+bounces-273358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7F3621C5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68CB530229D6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6DB3EBF1F;
	Mon, 30 Mar 2026 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Eae+iKb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AC2BDC2F;
	Mon, 30 Mar 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910835; cv=none; b=rZIMLMVlzGu1Wd46JZDjygdMzD9yITwukEenhS0bBx2duZSHCfxNnCwOuJ6jDHlXxwwqqWDa46zeTcydopMA2ahZW1Hv/dyvEVXTnGkNFi5jZQzJpuY6rHMqPUM5A0YsYhlsdTGLy7R7FnimUFRNJdfkFa9n/jQW/u0GFlEfcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910835; c=relaxed/simple;
	bh=9l95vLinQu+IIsUJEP4Jae1zoVonmMyOJA4S3YGs/Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBOwQ5p8Sikt/rGCEGWgJEpGGUcT2sebG5tikbr1FJYr52rW3n22MI3J8YpWkMHPkTwk9MLG4IOiuj3Plt1F8pneSUTjJBfyIvQBc57hrNQEo6dqucS5ffYGnKvvx3/tFx+9sqgwMXTfllIGZkV8HCcDHO729G3ELHwJovqJGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Eae+iKb8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3466A5870;
	Tue, 31 Mar 2026 00:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774910827; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HAu4YjCqQGYlGoSD018Aqwo2kP7zuF3PCyK7rHr9s1Y=;
	b=Eae+iKb8tI0ZbbBbOhBjWOkQp3W8r8Vom1GdbZVl4IFYLF97ea24UaVCteemRhe9WK7q3H
	TZVB4MoSYfowDAVifB/4AZR4pGCGXgcXg8Hpw94GehMIDxTXJYZtpU0hKU8qLjYzVPKbPz
	Ix7kUQB/UIgh0X2y6YX5FgTIfrIddTDaLJPF18XsBvCFTRYnETCJBDYFiyBbux9NL9qqyN
	1vj1gOUHDftn8giB2gUNItZ2/fxMsMN7RyF0IOt10koUjjwE6ksuEHmSfURph3GiqiCnMa
	UAuji29J+2Tsi8b6crO/e9fofS7BSq+cmd19wHqBTxdFEjK2wCswHEeYDOrVRg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] net: phy: microchip: add downshift tunable support for LAN88xx
Date: Tue, 31 Mar 2026 00:46:26 +0200
Message-ID: <20260330224630.579937-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330224630.579937-1-nb@tipi-net.de>
References: <20260330224630.579937-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273358-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[raspberrypi.com,tipi-net.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 14B7F3621C5
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


