Return-Path: <netdev+bounces-304388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmANF1diR2oJXgAAu9opvQ
	(envelope-from <netdev+bounces-304388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0576FF7BE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=DnmVDSHS;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304388-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304388-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A823047BF3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDA38B7D2;
	Fri,  3 Jul 2026 07:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CB38B7A6;
	Fri,  3 Jul 2026 07:15:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062907; cv=none; b=PPbruChRzKy1417JBSdaEgM/7MGXPlIctiP/HgUds2/5sC21ncocNa7QzDqWn8xplg7hBQznzH+2h3sZg/VO5Brl5N/fCetjL+8FhAWYj27uD6MCFY2NOX3B6FTvm3qB8eclO5ILYmj19n4DcN/3iw92jK9B9n30HLMbTejowoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062907; c=relaxed/simple;
	bh=dBQSSkHXc8BFXAPs3WZyVqAgorHKu4KCMcBSLltS4HA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8A/wTSI3qRoo78STg/Uj6C9CrnehvjUrZ6txkkr4t4mNjQ8CWKaVzJmvngFtDj6TmLpd3RSyq8vVvq3RcKijkgquUKGnZIOK14U7sHlY/bl0ZpoBRntaAH8xJEMaNvwATbIYsCpIhVkKOzu/9c1c0gFacwB2rXdQO7cpi+RH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DnmVDSHS; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6637DYlS42503821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783062814;
	bh=Q4MDX0IlQyUrQg+hS3kJwDShxeqI1nz/Z1+evrwl9Og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DnmVDSHSxZj8w5Xab5gYxrBGc2rt/ucY64TratOMtd3RqDdiLEgf68Y7TbV/yyZ5X
	 GqSKWKVI7kgAGecSzi93pkeKTu8tlwEp0v4XnPnFeMbj7mf0ajCd865F9bDgYJ5WiD
	 grfiywWe/93kzpIrn6V5iBTqBVl4EL74AQnOSLgL4QV9sFNkkzMis5BlcKEOXEBytQ
	 BRPMi5FWZDmWGd6qFiHb+rdQzKtvhLBoOa1I5XkTOACWpE6KFG64CbLQstCA2ZN8DM
	 y85zqUdShg18b7a1Yh9TQDkMjAHphhjxBKyqBc5EuhXskvTzdLtu7HM/A96RBiVQjr
	 /LYImWWGWy5Hw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6637DYlS42503821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 15:13:34 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 15:13:33 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 15:13:33 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v9 3/4] net: phy: realtek: add support for RTL8261C_CG
Date: Fri, 3 Jul 2026 15:13:29 +0800
Message-ID: <20260703071330.1707-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260703071330.1707-1-javen_xu@realsil.com.cn>
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304388-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,bootlin.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A0576FF7BE

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
0x001cc898.
This patch introduces a distinct family of handlers (probe, get_features,
config_aneg, read_status, config_intr, handle_interrupt).

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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

Changes in v9:
 - get an status from genphy_c45_aneg_done()
---
 drivers/net/phy/realtek/realtek_main.c | 192 +++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..bd12f10843d9 100644
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
@@ -310,6 +340,156 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
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
+	int ret, val = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_c45_aneg_done(phydev);
+		if (ret < 0)
+			return ret;
+
+		if (ret) {
+			val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+					   RTL822X_VND2_C22_REG(MII_STAT1000));
+			if (val < 0)
+				return val;
+		}
+	}
+
+	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
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
@@ -3001,6 +3181,18 @@ static struct phy_driver realtek_drvs[] = {
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
+		.soft_reset		= genphy_c45_pma_soft_reset,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0


