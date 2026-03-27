Return-Path: <netdev+bounces-272682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCkEAX3pxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:33:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1D34B061
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED701321F140
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0433F8B1;
	Fri, 27 Mar 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="UzlKpIJ+"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7373803D1;
	Fri, 27 Mar 2026 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642966; cv=none; b=GnpdTOYj1jyMs+50gnbla+/EHjgv+HfS/AYTXhIe/p0FfnhM+zpFDDG0P0lvHeGuYxSQDAIy1dl8dq5scJ6ce4cItvblHBEB7QMBlot1OZhIXk3GGFvgh1s6pBZUyQlu4/lsJIuWcfKNSAxLqKPGnD+vChoOVznsRR4GW1axqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642966; c=relaxed/simple;
	bh=IMczZJ5EpmZ/jhP8MlzU+8UMoEl5TSQcpq8UFP2Mvac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LycX470hElMlLLQ+q4u1B4IIbydNV0MUXNTryFyRFh0qBNyi93yHo9XvpVvamas45KmuTLDEyGaLeWGkY+WApRquxKdcS8nHGbCrSASGnex1hrRjgkVw9veITONpifr1XqMDItTCfnKheVqkTkj22LKHx028fC7rITZRergHggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=UzlKpIJ+; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed4701bfa09bcb9dcee3f7b116.dip0.t-ipconnect.de [IPv6:2003:ed:4701:bfa0:9bcb:9dce:e3f7:b116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id 5661340293;
	Fri, 27 Mar 2026 21:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1774642875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hx3OyUWNAbordCl0xtcofmMXwfp0i+JgS6dQqnfJI5A=;
	b=UzlKpIJ+Mt7uAgQvT9p/oh/Sc82FzL1JLDydgAhRMggnCLYe+HyUaRh1PhWfRuiPXzb0S2
	Hw+HgoBPd2HBJJyFoF4vrdXyg/WLJlTm84CqkNVOSMOGgOCMK/B3Je8YfA1XSibNHAAOPq
	KpRnPHy7FRg6u9Uzoh4DzmCejiaTmrxFhyedvxxHH707Q+Z/YraQn9WjzNoDNzzBIzXOUA
	ryYNXU4Ea+cqF+r/qelSJ+XqWF7NQYOv9zMxZpcTJ2Q0adGgG5UdJ8WEWEudv3SN4DYmqb
	bFJiKHr9w1tTOcdWp97rWpw9noyGZyoOqxOO0w9Nx6ZcclI006hX7PsXvRfFpw==
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
Subject: [PATCH net-next v2] net: phy: realtek: support MDI swapping for RTL8226-CG
Date: Fri, 27 Mar 2026 20:32:28 +0100
Message-ID: <20260327202001.413280-1-jan@3e8.eu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[3e8.eu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[3e8.eu:s=mail20211217];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de];
	TAGGED_FROM(0.00)[bounces-272682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[3e8.eu:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[3e8.eu:dkim,3e8.eu:email,3e8.eu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53F1D34B061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
property "enet-phy-pair-order" is specified.

Unfortunately, no documentation about this feature is available, but
this implementation still tries to avoid magic numbers and raw register
numbers where it seems clear what is going on. As it is unknown whether
the patching step can be safely reversed, only enabling MDI swapping is
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
v2:
 - Added register/field definitions where possible. For some registers,
   it seems hard to find a proper name, but I still defined them where
   some of the fields are known.
 - Introduced new helper function to swap RG_LPF_CAP and RG_LPF_CAP_XG
   values, in order to reduce duplication.

 drivers/net/phy/realtek/realtek_main.c | 149 ++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605b..2f007dc8ec8c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -174,6 +174,20 @@
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
 #define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
+#define RTL8226_VND1_UNKNOWN_6A21		0x6a21
+#define  RTL8226_VND1_UNKNOWN_6A21_MDI_SWAP_EN	BIT(5)
+
+#define RTL8226_VND2_UNKNOWN_D068		0xd068
+#define  RTL8226_VND2_UNKNOWN_D068_PAIR_SEL	GENMASK(4, 3)
+#define RTL8226_VND2_ADCCAL_OFFSET		0xd06a
+
+#define RTL8226_VND2_RG_LPF_CAP_XG_P0_P1	0xbd5a
+#define RTL8226_VND2_RG_LPF_CAP_XG_P2_P3	0xbd5c
+#define RTL8226_VND2_RG_LPF_CAP_P0_P1		0xbc18
+#define RTL8226_VND2_RG_LPF_CAP_P2_P3		0xbc1a
+#define  RTL8226_RG_LPF_CAP_PAIR_A_MASK		GENMASK(4, 0)
+#define  RTL8226_RG_LPF_CAP_PAIR_B_MASK		GENMASK(12, 8)
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -1447,6 +1461,139 @@ static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
 	}
 }
 
+static int rtl8226_set_mdi_swap(struct phy_device *phydev, bool swap_enable)
+{
+	u16 val = swap_enable ? RTL8226_VND1_UNKNOWN_6A21_MDI_SWAP_EN : 0;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, RTL8226_VND1_UNKNOWN_6A21,
+			      RTL8226_VND1_UNKNOWN_6A21_MDI_SWAP_EN, val);
+}
+
+static int rtl8226_swap_rg_lpf_cap(struct phy_device *phydev, u32 reg_p0_p1, u32 reg_p2_p3)
+{
+	u16 val_p0, val_p1, val_p2, val_p3;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, reg_p0_p1);
+	if (ret < 0)
+		return ret;
+
+	val_p0 = FIELD_GET(RTL8226_RG_LPF_CAP_PAIR_A_MASK, ret);
+	val_p1 = FIELD_GET(RTL8226_RG_LPF_CAP_PAIR_B_MASK, ret);
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, reg_p2_p3);
+	if (ret < 0)
+		return ret;
+
+	val_p2 = FIELD_GET(RTL8226_RG_LPF_CAP_PAIR_A_MASK, ret);
+	val_p3 = FIELD_GET(RTL8226_RG_LPF_CAP_PAIR_B_MASK, ret);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, reg_p0_p1,
+			     RTL8226_RG_LPF_CAP_PAIR_A_MASK | RTL8226_RG_LPF_CAP_PAIR_B_MASK,
+			     FIELD_PREP(RTL8226_RG_LPF_CAP_PAIR_A_MASK, val_p3) |
+			     FIELD_PREP(RTL8226_RG_LPF_CAP_PAIR_B_MASK, val_p2));
+	if (ret < 0)
+		return ret;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, reg_p2_p3,
+			     RTL8226_RG_LPF_CAP_PAIR_A_MASK | RTL8226_RG_LPF_CAP_PAIR_B_MASK,
+			     FIELD_PREP(RTL8226_RG_LPF_CAP_PAIR_A_MASK, val_p1) |
+			     FIELD_PREP(RTL8226_RG_LPF_CAP_PAIR_B_MASK, val_p0));
+}
+
+static int rtl8226_patch_mdi_swap(struct phy_device *phydev)
+{
+	u16 adccal_offset[4];
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_UNKNOWN_D068);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & BIT(1))) {
+		/* already swapped */
+		return 0;
+	}
+
+	/* The exact meaning of these bits is unknown. We only know that bit 1
+	 * is used as a flag that swapping is already done.
+	 */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_UNKNOWN_D068, 0x7, 0x1);
+	if (ret < 0)
+		return ret;
+
+	for (int i = 0; i < 4; i++) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_UNKNOWN_D068,
+				     RTL8226_VND2_UNKNOWN_D068_PAIR_SEL,
+				     FIELD_PREP(RTL8226_VND2_UNKNOWN_D068_PAIR_SEL, i));
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_ADCCAL_OFFSET);
+		if (ret < 0)
+			return ret;
+
+		adccal_offset[i] = ret;
+	}
+
+	for (int i = 0; i < 4; i++) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_UNKNOWN_D068,
+				     RTL8226_VND2_UNKNOWN_D068_PAIR_SEL,
+				     FIELD_PREP(RTL8226_VND2_UNKNOWN_D068_PAIR_SEL, i));
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_ADCCAL_OFFSET,
+				    adccal_offset[3 - i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = rtl8226_swap_rg_lpf_cap(phydev, RTL8226_VND2_RG_LPF_CAP_XG_P0_P1,
+				      RTL8226_VND2_RG_LPF_CAP_XG_P2_P3);
+	if (ret < 0)
+		return ret;
+
+	return rtl8226_swap_rg_lpf_cap(phydev, RTL8226_VND2_RG_LPF_CAP_P0_P1,
+				       RTL8226_VND2_RG_LPF_CAP_P2_P3);
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
@@ -2384,7 +2531,7 @@ static struct phy_driver realtek_drvs[] = {
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


