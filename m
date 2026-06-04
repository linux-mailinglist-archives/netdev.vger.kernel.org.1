Return-Path: <netdev+bounces-295075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 40HGDi8tIWqLAAEAu9opvQ
	(envelope-from <netdev+bounces-295075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C479D63DB89
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=V8gZ9K9G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295075-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295075-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059CA3045472
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144D3AE6FD;
	Thu,  4 Jun 2026 07:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CA316197;
	Thu,  4 Jun 2026 07:42:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558973; cv=none; b=L/LhZ5Ss8KaT94zA2ySKFTqP542MPYnP2ajK0euEVHkAFMt2QKGhXgGhjugHqUYa5XRg7cJ8dYHCg2nRv6vbsTrAE2ghZ0NgdH7pyjSnl+OHEpqv1J3/mRqFkoJeRf2XXxSsDhEYaeczkW/rCbyZ4RKWs6d6Et7Er7MlCqtFjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558973; c=relaxed/simple;
	bh=f6cmgyX+WLpaS3zfafxutVbR5V+SQpo3MhY6f8s0vE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bytF14ANMnZpPph9c8+yBIWVJWTz7SQPH5zhlQdiP7dPuUhT/1tjHbqNjojU5OOcK5mZyE3x6p7ZqtoMv5Nz9JDxEi0pk2hbXxn381I5Kaozka9HDOYMgbe9ZiQ/SnI1n1a4aQnLhR5ApSQeudxGQKcr+OLobYMNEoBUYNdeGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=V8gZ9K9G; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547gCouD206040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558932;
	bh=zy2QVwalgN4GPrRYE8ptnYvMH3zopfJzoys6siMKYEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=V8gZ9K9GFbOulfPiZOfWyKI4ahQ4Hs9d54dhPleRuCLFzK9iatmOGcOAAWsoOI6Mn
	 //xUJ19ZzDfo9hwukWZFgBIgHfzrLPlMJi/TKtvKqrWcax7HH+/svBxisaJfQYOqMQ
	 tp69uGHM00kNkQdbn3CUIq+X/RhZc/dPWcT4Ua4lTUgRU/U14DFvmU7u+pzdou0+qY
	 OojVEZ7yPkGAejIkUqc4FNubVDeVHP4tutet+5RMf9W0ZhXIHPhV6E1PaB9M4Ie5lP
	 VrVyaiZZ0del98MfTZ+W7yHyyxh9obsXOtDB5YYJQ/e506JsaCEP2s2IogG0bl5pFP
	 mRNT3grdAumfA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547gCouD206040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:42:12 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:42:11 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 15:42:11 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 3/4] net: phy: realtek: add support for RTL8261C_CG
Date: Thu, 4 Jun 2026 15:42:08 +0800
Message-ID: <20260604074209.93-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604074209.93-1-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295075-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:javen_xu@realsil.com.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C479D63DB89

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
0x001cc898.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - remove RTL8261D, only support RTL8261C_CG
 - remove speed 500, rarely used
 - add helper function, genphy_c45_soft_reset() and genphy_c45_config_master_slave()
---
 drivers/net/phy/realtek/realtek_main.c | 178 +++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..86788feaae92 100644
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
@@ -251,6 +255,33 @@
 #define RTL_8221B_VM_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
+#define RTL_8261C_CG				0x001cc898
+
+#define RTL8261C_CE_MODEL		0x00
+#define RTL8261X_GBCR_REG		0xa412
+#define RTL8261X_IMR			0xa4d2
+#define RTL8261X_ISR			0xa4d4
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
+					 RTL8261X_INT_LINK_CHG)
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
@@ -270,6 +301,10 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+struct rtl8261x_priv {
+	u8 sub_phy_id;
+};
+
 static int rtl821x_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -310,6 +345,137 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 	return phy_restore_page(phydev, oldpage, ret);
 }
 
+static int rtl8261x_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct rtl8261x_priv *priv;
+	int sub_phy_id, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
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
+	priv->sub_phy_id = sub_phy_id;
+
+	switch (sub_phy_id) {
+	case RTL8261C_CE_MODEL:
+		phydev_info(phydev, "RTL8261C detected (sub_id 0x%02x)\n", sub_phy_id);
+		break;
+
+	default:
+		phydev_err(phydev, "Unknown sub_id 0x%02x\n", sub_phy_id);
+		return -ENODEV;
+	}
+	phydev->priv = priv;
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
+static int rtl8261x_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_ISR);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_IMR,
+				    RTL8261X_INT_MASK_DEFAULT);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_IMR, 0);
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
+	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_ISR);
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
+	bool changed = false;
+	u16 adv_1g = 0;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = genphy_c45_config_master_slave(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			      phydev->advertising))
+		adv_1g = ADVERTISE_1000FULL;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
+				     RTL8261X_GBCR_REG,
+				     ADVERTISE_1000FULL, adv_1g);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 || changed)
+		return genphy_c45_restart_aneg(phydev);
+
+	return 0;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -3001,6 +3167,18 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
+		.name			= "Realtek RTL8261C 10Gbps PHY",
+		.probe			= rtl8261x_probe,
+		.get_features		= rtl8261x_get_features,
+		.config_aneg		= rtl8261x_config_aneg,
+		.read_status		= genphy_c45_read_status,
+		.config_intr		= rtl8261x_config_intr,
+		.handle_interrupt	= rtl8261x_handle_interrupt,
+		.soft_reset		= genphy_c45_soft_reset,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0


