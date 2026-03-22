Return-Path: <netdev+bounces-270324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6rKBCxZIwGlHFgQAu9opvQ
	(envelope-from <netdev+bounces-270324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 20:50:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5C52EA8CC
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9DC30097F2
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47F2C11FD;
	Sun, 22 Mar 2026 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="EyWK/CKU"
X-Original-To: netdev@vger.kernel.org
Received: from srv5.3e8.eu (srv5.3e8.eu [94.16.113.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C53347C6;
	Sun, 22 Mar 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.113.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209033; cv=none; b=PMujBrv55idTJ+ZB/u6XZRLT9tBZn0yvHYuYn0qT2BP0x8RJ4vdptfW3CUYiEAarKnoUWf4UcPcK52i3tk0/S4XyY3IHC/SJCwlk+L+DRrY4eUO5dt8mR8FdYUGwNHjgZXFzLDiZg2HgFKnTp5FEw4JeSvk8YV678BDpyEO9tDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209033; c=relaxed/simple;
	bh=W9C0qlrJGp9djhtkjoUhYm6oMOMjMoqu2nZXDEg0B48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qT1U4J9VPvN3Ojb/zbRdSWHqHSUx4TRINlYq5TWLR8Rmq/f2Ky1RW8UToE+70j1EzzBevc3ftCy/BEH5CDpAfbskPrF0A17FJRYEfcihEIQSd/O8eHCga4FRWvR6nFxpaW7ceAqXLR5giKF6Gn86+/jSAaj+nbQCZfixNCma+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=EyWK/CKU; arc=none smtp.client-ip=94.16.113.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed4701bfa09bcb9dcee3f7b116.dip0.t-ipconnect.de [IPv6:2003:ed:4701:bfa0:9bcb:9dce:e3f7:b116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv5.3e8.eu (Postfix) with ESMTPSA id A2FFD1201AC;
	Sun, 22 Mar 2026 20:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1774208484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AV2t4ITXWHmUYda9AW/1gVAkFIdm28lD0ire5XJWbgo=;
	b=EyWK/CKU+F052vOhlWRwyJ6+8ihIwzf+XP7W/sx5K4UXlXks6VWPTJJfN5S5/M8ALsml0y
	Nn5yiuC8T+r528W7m4RSCsQ0PdXHXPEoPtoGspicLr4Dkbx0NMe25NnUUkwWYC087ckK7J
	QyDcMrIDrjffTY24ip9zRBUAYujsuQnnnVR8VMdbKLwFhgcPVUvg5WeSM7Llkp0Qe9nib7
	PaNbIiOm8GVfJg/5/S9Xl9EbCTY0c++Ss2mQOU8/9fUeEG/+cfV5ILeuzJnGuLK0TPNsmU
	YcHqx2MSWXm+JFJoL67ypN/9xcQgpVspys4xVQ4Sr3l3mhG0v3yVionldjrjrA==
From: Jan Hoffmann <jan@3e8.eu>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Damien Dejean <dam.dejean@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Hoffmann <jan@3e8.eu>
Subject: [PATCH net-next] net: phy: realtek: support MDI swapping for RTL8226-CG
Date: Sun, 22 Mar 2026 20:31:12 +0100
Message-ID: <20260322193235.990881-1-jan@3e8.eu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270324-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.373];
	DMARC_DNSFAIL(0.00)[3e8.eu : query timed out];
	DKIM_TRACE(0.00)[3e8.eu:?];
	R_DKIM_TEMPFAIL(0.00)[3e8.eu:s=mail20211217];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA5C52EA8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
property "enet-phy-pair-order" is specified.

Unfortunately, no documentation about this feature is available, so the
configuration involves magic values. As it is unknown whether the
patching step can be safely reversed, only enabling MDI swapping is
supported.

Some other Realtek PHYs also support similar mechanisms:

- RTL8221B-VB-CG allows to configure MDI swapping via the same register,
  but does not need the additional patching step. However, it is unclear
  whether a driver implementation for that PHY is necessary, as it is
  known to support configuration via strapping pins (which is working
  fine at least in Zyxel XGS1210-12 rev B1).

- The patching step seems to match the one for the integrated PHYs of
  some Realtek PCIe/USB NICs (see for example the r8152 driver).

For now, only implement this for the RTL8226-CG PHY, where it is needed
for the switches Zyxel XGS1010-12 rev A1 and XGS1210-12 rev A1.

Signed-off-by: Jan Hoffmann <jan@3e8.eu>
---
 drivers/net/phy/realtek/realtek_main.c | 142 ++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605b..2472f54502bd 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1447,6 +1447,146 @@ static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
 	}
 }
 
+static int rtl8226_set_mdi_swap(struct phy_device *phydev, bool swap_enable)
+{
+	u16 val = swap_enable ? BIT(5) : 0;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, 0x6a21, BIT(5), val);
+}
+
+static int rtl8226_patch_mdi_swap(struct phy_device *phydev)
+{
+	u16 values[4];
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xd068);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & BIT(1))) {
+		/* already swapped */
+		return 0;
+	}
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x7, 0x1);
+	if (ret < 0)
+		return ret;
+
+	/* swap adccal_offset */
+
+	for (int i = 0; i < 4; i++) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x3 << 3, i << 3);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xd06a);
+		if (ret < 0)
+			return ret;
+
+		values[i] = ret;
+	}
+
+	for (int i = 0; i < 4; i++) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xd068, 0x3 << 3, i << 3);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, 0xd06a, values[3 - i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* swap rg_lpf_cap_xg */
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbd5a);
+	if (ret < 0)
+		return ret;
+
+	values[0] = ret & 0x1f;
+	values[1] = (ret >> 8) & 0x1f;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbd5c);
+	if (ret < 0)
+		return ret;
+
+	values[2] = ret & 0x1f;
+	values[3] = (ret >> 8) & 0x1f;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xbd5a, 0x1f1f,
+			     values[3] | (values[2] << 8));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xbd5c, 0x1f1f,
+			     values[1] | (values[0] << 8));
+	if (ret < 0)
+		return ret;
+
+	/* swap rg_lpf_cap */
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbc18);
+	if (ret < 0)
+		return ret;
+
+	values[0] = ret & 0x1f;
+	values[1] = (ret >> 8) & 0x1f;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xbc1a);
+	if (ret < 0)
+		return ret;
+
+	values[2] = ret & 0x1f;
+	values[3] = (ret >> 8) & 0x1f;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xbc18, 0x1f1f,
+			     values[3] | (values[2] << 8));
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, 0xbc1a, 0x1f1f,
+			     values[1] | (values[0] << 8));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rtl8226_config_mdi_order(struct phy_device *phydev)
+{
+	u32 order;
+	int ret;
+
+	ret = of_property_read_u32(phydev->mdio.dev.of_node, "enet-phy-pair-order", &order);
+
+	/* Property not present, nothing to do */
+	if (ret == -EINVAL || ret == -ENOSYS)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	/* Only enabling MDI swapping is supported */
+	if (order != 1)
+		return -EINVAL;
+
+	ret = rtl8226_set_mdi_swap(phydev, true);
+	if (ret)
+		return ret;
+
+	return rtl8226_patch_mdi_swap(phydev);
+}
+
+static int rtl8226_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl8226_config_mdi_order(phydev);
+	if (ret)
+		return ret;
+
+	return rtl822x_config_init(phydev);
+}
+
 static int rtl822xb_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
@@ -2384,7 +2524,7 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset	= rtl822x_c45_soft_reset,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
-		.config_init	= rtl822x_config_init,
+		.config_init	= rtl8226_config_init,
 		.inband_caps	= rtl822x_inband_caps,
 		.config_inband	= rtl822x_config_inband,
 		.read_status	= rtl822xb_c45_read_status,
-- 
2.53.0


