Return-Path: <netdev+bounces-303936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xc7PCi/ZRWoSGAsAu9opvQ
	(envelope-from <netdev+bounces-303936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D26F332E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=QJScZ8oW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303936-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303936-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28AD8301F16A
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DD312832;
	Thu,  2 Jul 2026 03:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5D431E52;
	Thu,  2 Jul 2026 03:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962468; cv=none; b=Za/6EdSK8u0nbVYEj3g3iipQND9Q7LGHTPVWWmzjZfLCnkNnAGs/lQDPOpNi7wJSGzX4hW6+9xfNiBlniLp2KN7XB9ikbqqBsNTz0F1GNM0CNpGlxn/fTZvFdFSElbApUI+EISvsMirq8So4enuky2SGAaSLWvQMwZVgljj/WWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962468; c=relaxed/simple;
	bh=p5CVcFQHcNwWIEc1vV3swXznb/rfX4Zh6thOZpPjaMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8kHvYerk3EqIqUaTS4yajPZcTYZLSCfCnsvNph7VGUtMbyLaGpvA0ncEbszow8b17adqR/UWoi6pULN+DTgdCEus4DC4mGb8RXXztVGKtWKyO5tfACuhoN9aBy9+U/Ym7rXBlVsD5zg3AFFbUqPhNlS4z2upWMNklTMlpIisJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=QJScZ8oW; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6623KOD001649089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782962424;
	bh=+TT/RwV6P6z/Vcq7enF3u5kts75OANs6/mGeU0RPRFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QJScZ8oWYnzd12Lw8ZyLOFvd1NvCv77vz7wP9Omu0Q7mAxW3ezL0/J8HdeLGCjsDA
	 LvPHxTfqFOd2pWvjBVmhry+oi5Kab4VXVYJ/h+HHVk8TEuDCC/+tmMdK52k4bOM5ji
	 f8mFAtxCI0O3Jr/YHB5AQa1Omi7wQpEQIdL0qGdDNpBxBv5WH8MAG5RtYesgz6YwmA
	 reVi42p9IupTeW9mtVWs6D2p+itgFClOZ1+dyDUEZPCYJReGcHanc9kM66jCE+aYBR
	 sYygMUn36GIfreJJ/X+qH/F0gf6Ky858s898yIREmOmLPaHMBVKT9itSSPdUU9PeYt
	 fCy8OfZs4T51A==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6623KOD001649089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 11:20:24 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Jul 2026 11:20:23 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Jul 2026 11:20:23 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 3/4] net: phy: realtek: add support for RTL8261C_CG
Date: Thu, 2 Jul 2026 11:20:18 +0800
Message-ID: <20260702032020.589-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260702032020.589-1-javen_xu@realsil.com.cn>
References: <20260702032020.589-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303936-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A3D26F332E

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
0x001cc898.
This patch introduces a distinct family of handlers (probe, get_features,
config_aneg, read_status, config_intr, handle_interrupt).

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file

Changes in v3:
 - re-order function according to the order in phy-c45.c
 - add kernel-doc about return value
 - add MASTER_SLAVE_CFG_MASTER_PREFERRED,
   MASTER_SLAVE_CFG_SLAVE_PREFERRED, MASTER_SLAVE_CFG_UNKNOWN,
   MASTER_SLAVE_CFG_UNSUPPORTED, MASTER_SLAVE_CFG_SLAVE_PREFERRED cfg

Changes in v4:
 - no changes

Changes in v5:
 - remove genphy_c45_pma_setup_forced() for this is already done when
   calling genphy_c45_config_aneg()

Changes in v6:
 - when PHY_INTERRUPT_DISABLE, clear IMR and ISR
 - if AUTONEG_DISABLE, nothing need to do in rtl8261x_config_aneg
 - add rtl8261x_read_status, support 1G speed

Changes in v7:
 - remove RTL8261X_IMR and RTL8261X_ISR, duplicated definition
 - modify commit message
 - continue with default behavior when meet unknown sub_phy_id
 - change the internal order of rtl8261x_read_status
 - expand RTL8261X_INT_MASK_DEFAULT
 - add the handle for ADVERTISE_1000HALF in rtl8261x_config_aneg
 
Changes in v8:
 - no changes
---
 drivers/net/phy/realtek/realtek_main.c | 186 +++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..ef3700894ebf 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -141,6 +141,10 @@
 #define RTL8211F_PHYSICAL_ADDR_WORD1		17
 #define RTL8211F_PHYSICAL_ADDR_WORD2		18
 
+#define RTL8261X_EXT_ADDR_REG			0xa436
+#define RTL8261X_EXT_DATA_REG			0xa438
+#define RTL_8261X_SUB_PHY_ID_ADDR		0x801d
+
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
 #define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
@@ -251,6 +255,32 @@
 #define RTL_8221B_VM_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
+#define RTL_8261C_CG				0x001cc898
+
+#define RTL8261C_CE_MODEL		0x00
+#define RTL8261X_INT_AUTONEG_ERROR	BIT(0)
+#define RTL8261X_INT_PAGE_RECV		BIT(2)
+#define RTL8261X_INT_AUTONEG_DONE	BIT(3)
+#define RTL8261X_INT_LINK_CHG		BIT(4)
+#define RTL8261X_INT_PHY_REG_ACCESS	BIT(5)
+#define RTL8261X_INT_PME		BIT(7)
+#define RTL8261X_INT_ALDPS_CHG		BIT(9)
+#define RTL8261X_INT_JABBER		BIT(10)
+
+#define RTL8261X_INT_MASK_DEFAULT	(RTL8261X_INT_AUTONEG_DONE | \
+					 RTL8261X_INT_LINK_CHG | \
+					 RTL8261X_INT_AUTONEG_ERROR | \
+					 RTL8261X_INT_JABBER)
+
+#define RTL8261X_INT_MASK_ALL		(RTL8261X_INT_AUTONEG_ERROR | \
+					 RTL8261X_INT_PAGE_RECV | \
+					 RTL8261X_INT_AUTONEG_DONE | \
+					 RTL8261X_INT_LINK_CHG | \
+					 RTL8261X_INT_PHY_REG_ACCESS | \
+					 RTL8261X_INT_PME | \
+					 RTL8261X_INT_ALDPS_CHG | \
+					 RTL8261X_INT_JABBER)
+
 
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -310,6 +340,150 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 	return phy_restore_page(phydev, oldpage, ret);
 }
 
+static int rtl8261x_probe(struct phy_device *phydev)
+{
+	int sub_phy_id, ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_ADDR_REG,
+			    RTL_8261X_SUB_PHY_ID_ADDR);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_DATA_REG);
+	if (ret < 0)
+		return ret;
+
+	sub_phy_id = (ret >> 8) & 0xff;
+
+	switch (sub_phy_id) {
+	case RTL8261C_CE_MODEL:
+		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
+		break;
+
+	default:
+		phydev_warn(phydev, "Unknown sub_id 0x%02x, default behavior\n", sub_phy_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+	/*
+	 * Supplement Multi-Gig speeds that may not be automatically detected
+	 * RTL8261X supports 2.5G/5G in addition to standard 10G
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
+static int rtl8261x_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   RTL822X_VND2_C22_REG(MII_STAT1000));
+		if (val < 0)
+			return val;
+
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	}
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rtl8261x_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INSR);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INER,
+				    RTL8261X_INT_MASK_DEFAULT);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INER, 0);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INSR);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static irqreturn_t rtl8261x_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221B_VND2_INSR);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (!(irq_status & RTL8261X_INT_MASK_ALL))
+		return IRQ_NONE;
+
+	if (irq_status & (RTL8261X_INT_LINK_CHG | RTL8261X_INT_AUTONEG_DONE |
+	    RTL8261X_INT_AUTONEG_ERROR | RTL8261X_INT_JABBER))
+		phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
+static int rtl8261x_config_aneg(struct phy_device *phydev)
+{
+	u16 adv_1g = 0;
+	int ret;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			      phydev->advertising))
+		adv_1g = ADVERTISE_1000FULL;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+			      phydev->advertising))
+		adv_1g |= ADVERTISE_1000HALF;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
+				     RTL822X_VND2_C22_REG(MII_CTRL1000),
+				     ADVERTISE_1000FULL | ADVERTISE_1000HALF,
+				     adv_1g);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return genphy_c45_restart_aneg(phydev);
+
+	return 0;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -3001,6 +3175,18 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
+		.name			= "Realtek RTL8261C 10Gbps PHY",
+		.probe			= rtl8261x_probe,
+		.get_features		= rtl8261x_get_features,
+		.config_aneg		= rtl8261x_config_aneg,
+		.read_status		= rtl8261x_read_status,
+		.config_intr		= rtl8261x_config_intr,
+		.handle_interrupt	= rtl8261x_handle_interrupt,
+		.soft_reset		= genphy_c45_soft_reset,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0


