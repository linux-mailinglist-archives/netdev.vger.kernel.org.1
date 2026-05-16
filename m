Return-Path: <netdev+bounces-288662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNQoE23CCGph4AMAu9opvQ
	(envelope-from <netdev+bounces-288662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF955D7F1
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A57300B05C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A43603E1;
	Sat, 16 May 2026 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="A9K4MNZ7"
X-Original-To: netdev@vger.kernel.org
Received: from srv4.3e8.eu (srv4.3e8.eu [193.25.101.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70735A933;
	Sat, 16 May 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.25.101.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958877; cv=none; b=MrYODrZWGOc/4kwqiNc9s/QGjP/L8ICWHHI1CdAMZzXfVL1xpR8W3ur2pcS7nqhqnA1nCvxxYGbxpLirQdduKWAWg6rsiG+DZA1iINrwPgZ5z+Op4bBDu77gjBy5iMklmJIVlmkLTCi0ptN+cGJI3Dx4Um4t5z40eGWiMjOH/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958877; c=relaxed/simple;
	bh=6HluhRRZpWJv0CAyBmyjhEA4nUf08erKvWtpyyQtpaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCsWZNUewvPoV+y3ZMwGrC68xI5GHfG4fjc/MHTPr38FB8tTqRmmUDQDxm2SSHes0x+HHFAR76kE0cG8a/AT4PyoQwNioRIFH/D3j0sAmF9bQW6mjKjjLol8BADASeP5b707Kp6yir+6qe0aW7oraENdlj0OTqE2/MpzD6zYhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=A9K4MNZ7; arc=none smtp.client-ip=193.25.101.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Received: from jan-pc (p200300ed473225a050c356a035128308.dip0.t-ipconnect.de [IPv6:2003:ed:4732:25a0:50c3:56a0:3512:8308])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv4.3e8.eu (Postfix) with ESMTPSA id DF5C840186;
	Sat, 16 May 2026 21:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1778958327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wtx0OcCAVMkEom9JQXQuE8wkRRBPDlD+ZHEyWFtHUxM=;
	b=A9K4MNZ7e3XAssn1dJsq7eIrRS6sa+tBNPNg8gyVKNpEq2fya4m6pJseve9x8odTYFwGz5
	fJwYVVPnyQdup8/ChLCDgl1RM50JELPjPjrKYSzIWOF5mMPUwMupBPCvlDOupUnFq6E225
	HpAlXz4AqYQvk1uhBxJtZtK90nnEdj2fVrDa3nfoEVtyB5VLjUzupxdu6ZBRyqBmQvYlC0
	0IJxVqiDniPwQUIkfbmclBQOzzIvKs2gUtf1GMLEmavFDJL+K86Y+fxFPO1lw9fPTKoyyN
	4axQuOpr1w/otLZMvZIRIdNlPgoYDay3FeP36assBScq6oR8wwX/ew+OeA8udg==
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
Subject: [PATCH net-next v4] net: phy: realtek: support MDI swapping for RTL8226-CG
Date: Sat, 16 May 2026 21:03:45 +0200
Message-ID: <20260516190456.387768-1-jan@3e8.eu>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8DF955D7F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[3e8.eu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[3e8.eu:s=mail20211217];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288662-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[3e8.eu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@3e8.eu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
property "enet-phy-pair-order" is specified.

Unfortunately, no documentation about this feature is available, but
this implementation still tries to avoid magic numbers and raw register
numbers where it seems clear what is going on.

As it is unknown whether the patching step can be safely reversed, only
enabling MDI swapping is fully supported. A value of "0" for the "enet-
phy-pair-order" property is not accepted if the PHY has already been
patched for MDI swapping (however, this should not occur in practice).

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
v4:
 - Use phydev_err instead of phydev_warn, as that branch causes probing
   to fail.

v3:
 - Accept value of "0" for "enet-phy-pair-order" property.
 - Do configuration in .probe instead of .config_init, as it only needs
   to be done once and survives soft reset.

v2:
 - Added register/field definitions where possible. For some registers,
   it seems hard to find a proper name, but I still defined them where
   some of the fields are known.
 - Introduced new helper function to swap RG_LPF_CAP and RG_LPF_CAP_XG
   values, in order to reduce duplication.

 drivers/net/phy/realtek/realtek_main.c | 154 +++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 3d98df197a33..27268811f564 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -206,6 +206,21 @@
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
 #define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
+#define RTL8226_VND1_UNKNOWN_6A21		0x6a21
+#define  RTL8226_VND1_UNKNOWN_6A21_MDI_SWAP_EN	BIT(5)
+
+#define RTL8226_VND2_UNKNOWN_D068		0xd068
+#define  RTL8226_VND2_UNKNOWN_D068_MDI_SWAP_FLAG	BIT(1)
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
 
@@ -1485,6 +1500,144 @@ static int rtl822xb_write_mmd(struct phy_device *phydev, int devnum, u16 reg,
 	return write_ret;
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
+static int rtl8226_patch_mdi_swap(struct phy_device *phydev, bool swap_enable)
+{
+	u16 adccal_offset[4];
+	bool is_patched;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8226_VND2_UNKNOWN_D068);
+	if (ret < 0)
+		return ret;
+
+	is_patched = !(ret & RTL8226_VND2_UNKNOWN_D068_MDI_SWAP_FLAG);
+
+	if (is_patched == swap_enable) {
+		/* Nothing to do */
+		return 0;
+	}
+
+	if (!swap_enable) {
+		/* Patching is only implemented one-way, see next comment. */
+		phydev_err(phydev, "MDI swapping disabled, but PHY is already patched.\n");
+		return -EINVAL;
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
+	bool swap_enable;
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
+	if (order & ~1)
+		return -EINVAL;
+
+	swap_enable = !!(order & 1);
+
+	ret = rtl8226_set_mdi_swap(phydev, swap_enable);
+	if (ret)
+		return ret;
+
+	return rtl8226_patch_mdi_swap(phydev, swap_enable);
+}
+
+static int rtl8226_probe(struct phy_device *phydev)
+{
+	return rtl8226_config_mdi_order(phydev);
+}
+
 static int rtl822x_set_serdes_option_mode(struct phy_device *phydev, bool gen1)
 {
 	bool has_2500, has_sgmii;
@@ -2684,6 +2837,7 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset	= rtl822x_c45_soft_reset,
 		.get_features	= rtl822x_c45_get_features,
 		.config_aneg	= rtl822x_c45_config_aneg,
+		.probe		= rtl8226_probe,
 		.config_init	= rtl822x_config_init,
 		.inband_caps	= rtl822x_inband_caps,
 		.config_inband	= rtl822x_config_inband,
-- 
2.54.0


