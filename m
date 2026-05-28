Return-Path: <netdev+bounces-292582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGEZGhf2F2q5WAgAu9opvQ
	(envelope-from <netdev+bounces-292582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD795EE2C3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5069B3194499
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA28352012;
	Thu, 28 May 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="pDArlws8"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAF3546F1;
	Thu, 28 May 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954848; cv=none; b=B9A8mfFkZNMPnMEn4nEoAZorXiuZik32HFQ0vHTSfWB+BtUHCX48QC7cGXu+Kt+lKeILsdKSEtAzD2PEL4ZErrPj/tcJrnuzWm2kUvgDfGLeXWPfS74BBO9zYfqzmv3uA573TAKk5HQxUJyrdn0Laad1xgoaVayvKs+mk5j6Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954848; c=relaxed/simple;
	bh=P7qMu2Jn9cKZHjG86fuRMluqCeP24phFHg32tRypnbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AR3x0LecrtAXuXm3OqBB3H1LR1cvuxNy9oX/mHtdu63FOwY1Qh8oyl9HD59z9BoLx5u9JTGrhk0yoxdOR7Gc42+TUOLEvm5b5P7EyxFn5MWGjRJnKkJkceqFrxbEWiPVdAbJLLwUzgU0WeBpxqxKTOOsiqSogf0s5vK80HN6dFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=pDArlws8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64S7rPTq93171895, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779954806;
	bh=i0v7UdCz5ih9TJtCWsSynLCRG2gLpxggSD47L8joPao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pDArlws8jqhJbfD0ElKjSKQCkBJo9RQY93w9ZXe6RSkkdHZf/++vtpGM73KxnBqcZ
	 jPOlMoozhTronPMLgbA94q7Jl0dCtoy4Zp4ZnVgzMvZl3VHbSrsXLb+V2jTNvggrJQ
	 06JFPXmALgOHUeXIqI/OYEwKMPBcbOxcCSRPEbL+FdIWQV1vGuW+tLgLVPxreJyz6J
	 M8xKCwROruAwSX2Ei5mRagasljIG3K9wGmgOPUHC7JDjUGSS/6a1lcc20hRLiOD+OI
	 r37gi5onOSuWpUnqHQlDeiIJcedNvTTgXlFvRdrtuIQQGVBKtjmBYYmPql3uft94ta
	 tCkqkimcZzboA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64S7rPTq93171895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 15:53:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 May 2026 15:53:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 28 May 2026 15:53:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/2] net: phy: realtek: add support for RTL8261
Date: Thu, 28 May 2026 15:52:25 +0800
Message-ID: <20260528075226.1054-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260528075226.1054-1-javen_xu@realsil.com.cn>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292582-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Queue-Id: 9FD795EE2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for Realtek phy chip RTL8261. Its PHY id is
0x001cc898 and 0x001cc899.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 315 +++++++++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27268811f564..fe743fd0421b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -22,6 +22,9 @@
 #include "../phylib.h"
 #include "realtek.h"
 
+#define RTL_8261C_CG			0x001cc898
+#define RTL_8261CE_CG			0x001cc899
+
 #define RTL8201F_IER_PAGE			0x07
 #define RTL8201F_IER				0x13
 #define RTL8201F_IER_LINK			BIT(13)
@@ -141,6 +144,10 @@
 #define RTL8211F_PHYSICAL_ADDR_WORD1		17
 #define RTL8211F_PHYSICAL_ADDR_WORD2		18
 
+#define RTL8261X_EXT_ADDR_REG			0xa436
+#define RTL8261X_EXT_DATA_REG			0xa438
+#define RTL_8261X_SUB_PHY_ID_ADDR		0x801d
+
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
 #define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
@@ -252,6 +259,57 @@
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
 
+#define RTL8261C_CE_MODEL		0x00
+#define RTL8261D_MODEL			0x81
+#define RTL8261X_PHYSR_REG		0xa434
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
+#define RTL8261X_PHYSR_LINK		BIT(2)
+#define RTL8261X_PHYSR_DUPLEX		BIT(3)
+#define RTL8261X_PHYSR_SPEED_L		GENMASK(5, 4)
+#define RTL8261X_PHYSR_SPEED_H		GENMASK(10, 9)
+
+/* Concatenated 4-bit speed code values (SPD_H << 2 | SPD_L) */
+#define RTL8261X_SPEED_CODE_500M	0x3	/* H=0, L=3 */
+#define RTL8261X_SPEED_CODE_1000M	0x7	/* H=1, L=3 */
+#define RTL8261X_SPEED_CODE_2500M	0x8	/* H=2, L=0 */
+#define RTL8261X_SPEED_CODE_5000M	0x9	/* H=2, L=1 */
+#define RTL8261X_SPEED_500		500
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
+#define RTL8261X_MULTIG_CTRL		0x0020
+#define RTL8261X_MASTER_SLAVE_MASK	GENMASK(15, 14)
+
+#define RTL8261X_MS_AUTO		0x0000
+#define RTL8261X_MS_SLAVE		0x8000
+#define RTL8261X_MS_MASTER		0xC000
+
+enum rtl8261x_chip_model {
+	RTL8261_MODEL_C_CE = 0,
+	RTL8261_MODEL_D,
+	RTL8261_MODEL_GENERIC,
+};
+
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
 
@@ -270,6 +328,12 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+struct rtl8261x_priv {
+	enum rtl8261x_chip_model model;
+	u8 sub_phy_id;
+	bool is_generic;
+};
+
 static int rtl821x_read_page(struct phy_device *phydev)
 {
 	return __phy_read(phydev, RTL821x_PAGE_SELECT);
@@ -310,6 +374,233 @@ static int rtl821x_modify_ext_page(struct phy_device *phydev, u16 ext_page,
 	return phy_restore_page(phydev, oldpage, ret);
 }
 
+static int rtl8261x_soft_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, MDIO_CTRL1_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
+					 MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 100000, true);
+}
+
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
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_EXT_DATA_REG);
+	if (ret < 0)
+		return ret;
+
+	sub_phy_id = (ret >> 8) & 0xff;
+	priv->sub_phy_id = sub_phy_id;
+	priv->is_generic = false;
+
+	switch (sub_phy_id) {
+	case RTL8261C_CE_MODEL:
+		priv->model = RTL8261_MODEL_C_CE;
+		phydev_info(phydev, "RTL8261C/CE detected (sub_id 0x%02x)\n", sub_phy_id);
+		break;
+
+	case RTL8261D_MODEL:
+		priv->model = RTL8261_MODEL_D;
+		phydev_info(phydev, "RTL8261D detected (sub_id 0x%02x)\n", sub_phy_id);
+		break;
+
+	default:
+		priv->model = RTL8261_MODEL_GENERIC;
+		priv->is_generic = true;
+		phydev_warn(phydev, "Unknown sub_id 0x%02x! Using GENERIC mode. Update driver for full support.\n",
+			    sub_phy_id);
+		break;
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
+static int rtl8261x_config_master_slave(struct phy_device *phydev)
+{
+	u16 val;
+	/*
+	 * Configure bits 15:14 of MMD 7.0x0020
+	 *
+	 * Bit 15 (Enable) | Bit 14 (Value) | Mode
+	 * ----------------|----------------|-------------
+	 *       0         |       0        | Auto (disabled)
+	 *       1         |       0        | Force Slave
+	 *       1         |       1        | Force Master
+	 */
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		val = RTL8261X_MS_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		val = RTL8261X_MS_SLAVE;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+	default:
+		val = RTL8261X_MS_AUTO;
+		break;
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, RTL8261X_MULTIG_CTRL,
+			      RTL8261X_MASTER_SLAVE_MASK, val);
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
+static int rtl8261x_read_status(struct phy_device *phydev)
+{
+	int ret, val, speed_code;
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_PHYSR_REG);
+	if (val < 0)
+		return val;
+
+	phydev->link = !!(val & RTL8261X_PHYSR_LINK);
+	if (!phydev->link) {
+		phydev->speed  = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+		return 0;
+	}
+
+	phydev->duplex = (val & RTL8261X_PHYSR_DUPLEX) ? DUPLEX_FULL : DUPLEX_HALF;
+	speed_code = (FIELD_GET(RTL8261X_PHYSR_SPEED_H, val) << 2) |
+		      FIELD_GET(RTL8261X_PHYSR_SPEED_L, val);
+	switch (speed_code) {
+	case RTL8261X_SPEED_CODE_500M:
+		phydev->speed = RTL8261X_SPEED_500;
+		break;
+	case RTL8261X_SPEED_CODE_1000M:
+		phydev->speed = SPEED_1000;
+		break;
+	case RTL8261X_SPEED_CODE_2500M:
+		phydev->speed = SPEED_2500;
+		break;
+	case RTL8261X_SPEED_CODE_5000M:
+		phydev->speed = SPEED_5000;
+		break;
+	default:
+		phydev_warn(phydev, "unknown speed code 0x%x (PHYSR=0x%04x)\n", speed_code, val);
+		phydev->speed = SPEED_UNKNOWN;
+	break;
+	}
+
+	return 0;
+}
+
+static int rtl8261x_config_aneg(struct phy_device *phydev)
+{
+	u16 adv_1g = 0;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = rtl8261x_config_master_slave(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			      phydev->advertising))
+		adv_1g = BIT(9);
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
+				     RTL8261X_GBCR_REG,
+				     BIT(9), adv_1g);
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0)
+		return genphy_c45_restart_aneg(phydev);
+
+	return 0;
+}
+
 static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -3001,6 +3292,30 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
+		.name             = "Realtek RTL8261C_RTL8261D 10Gbps PHY",
+		.probe            = rtl8261x_probe,
+		.get_features     = rtl8261x_get_features,
+		.config_aneg      = rtl8261x_config_aneg,
+		.read_status      = rtl8261x_read_status,
+		.config_intr      = rtl8261x_config_intr,
+		.handle_interrupt = rtl8261x_handle_interrupt,
+		.soft_reset       = rtl8261x_soft_reset,
+		.suspend          = genphy_c45_pma_suspend,
+		.resume           = genphy_c45_pma_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
+		.name             = "Realtek RTL8261CE 10Gbps PHY",
+		.probe            = rtl8261x_probe,
+		.get_features     = rtl8261x_get_features,
+		.config_aneg      = rtl8261x_config_aneg,
+		.read_status      = rtl8261x_read_status,
+		.config_intr      = rtl8261x_config_intr,
+		.handle_interrupt = rtl8261x_handle_interrupt,
+		.soft_reset       = rtl8261x_soft_reset,
+		.suspend          = genphy_c45_pma_suspend,
+		.resume           = genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0


