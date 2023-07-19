Return-Path: <netdev+bounces-18852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B32758E0E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9D281655
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D3BE40;
	Wed, 19 Jul 2023 06:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEDC8C0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:29 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DC1FCE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso8659837a12.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749006; x=1692341006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yixXqZX7eF/4cDROyITTMI6IjRRU7qXkpHSTf8PAF+8=;
        b=dF4AzClD6ps09v7vhPqd9BNVLM5OF8fY9kXM9jc0xMAhQm6Zf5l4dI1HExPiNu4U4W
         cnot1qtD16VvXCN8yjcqlxaI2XX5i7R0U+YIUukEUpi+me3lxMSmlJ9eYzpJ0jajpqZs
         AXP6w2WoDIkBw2VagEcTU9YU6pAUDazlGfEryxcz4rx2czv3fTNuTip3qcgupueOz4ky
         kwyny3ae+11q1Ptcf1VLVUyEGBW8At5FS2e7U78BjGh9vMEO1MoN+imz/rM4FowVp6Pj
         u6iPBFcfmiMJkNYIAvWuRj7+xufiGHmtZV2ju8vA/KbnzeUotsw1/RQUN78g5oFmABBf
         UHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749006; x=1692341006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yixXqZX7eF/4cDROyITTMI6IjRRU7qXkpHSTf8PAF+8=;
        b=gF5iJVGUhDp/TlPaag60JeHPNg4yRTWuJea3K3QeSCAUBM4fjtPTll9m8DvTw1uyJF
         vO5/wSGp9orE0hHdsSiNqQD0Af75gzoF1IkMKp3vO3ZxCaIWZEhsxPjd+crnj4ENOC0X
         Lg4UvElM7utr43avFerDvztWpP98S9Ktn80ayT/YErB82tQr94HM+vEGbyuM+tc7c37/
         lCtsS82KznbwLv+t0Erm2UcAX2Hth86z/QoKLIlMk1Rbt3QTIAllKOKx8Mz55ibkXura
         OFSLu08YbH5bEPXdKEuFBAtTyDWg/OSZPqDV+RbtA2KnhCGwk7q9XfMXW4nuj+wouThu
         GXuQ==
X-Gm-Message-State: ABy/qLZIe46i13HRgH5m7PGBRJyDzQ0vrwIeFBVurBGFHbcuOJJqtarw
	QfUIboipvpX624lqAjLeL3/dNvXLNnoNvA==
X-Google-Smtp-Source: APBJJlHE/BpLtC06qsBdMCysHS01sSgdlXeJogZKzugenLvDRqPvlfpurWuKpopBwjJ+ECXs0O1IMg==
X-Received: by 2002:aa7:d1d8:0:b0:51d:9f71:23e2 with SMTP id g24-20020aa7d1d8000000b0051d9f7123e2mr1565499edp.21.1689749006053;
        Tue, 18 Jul 2023 23:43:26 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b88b:69a9:6066:94ef])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0051e0f8aac74sm2301868edy.8.2023.07.18.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	francesco.dolcini@toradex.com,
	kabel@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eichest@gmail.com
Subject: [PATCH net-next v4 5/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY
Date: Wed, 19 Jul 2023 08:42:58 +0200
Message-Id: <20230719064258.9746-6-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719064258.9746-1-eichest@gmail.com>
References: <20230719064258.9746-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a driver for the Marvell 88Q2110. This driver allows to detect the
link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
master and slave mode. Autonegotiation supported by the PHY does not yet
work.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig           |   6 +
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 263 ++++++++++++++++++++++++++++++
 include/linux/marvell_phy.h       |   1 +
 4 files changed, 271 insertions(+)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 78e6981650d94..87b8238587173 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -217,6 +217,12 @@ config MARVELL_10G_PHY
 	help
 	  Support for the Marvell Alaska MV88X3310 and compatible PHYs.
 
+config MARVELL_88Q2XXX_PHY
+	tristate "Marvell 88Q2XXX PHY"
+	help
+	  Support for the Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet
+	  PHYs.
+
 config MARVELL_88X2222_PHY
 	tristate "Marvell 88X2222 PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2fe51ea83babe..35142780fc9da 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
+obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)	+= mediatek-ge.o
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
new file mode 100644
index 0000000000000..1c3ff77de56b4
--- /dev/null
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell 88Q2XXX automotive 100BASE-T1/1000BASE-T1 PHY driver
+ */
+#include <linux/ethtool_netlink.h>
+#include <linux/marvell_phy.h>
+#include <linux/phy.h>
+
+#define MDIO_MMD_AN_MV_STAT			32769
+#define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
+#define MDIO_MMD_AN_MV_STAT_LOCAL_RX		0x1000
+#define MDIO_MMD_AN_MV_STAT_REMOTE_RX		0x2000
+#define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER	0x4000
+#define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
+
+#define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR	0x00FF
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_LINK		0x0200
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_RX		0x1000
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_REMOTE_RX		0x2000
+#define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_MASTER	0x4000
+
+#define MDIO_MMD_PCS_MV_100BT1_STAT2		33033
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_JABBER	0x0001
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_POL	0x0002
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
+#define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
+
+static int mv88q2xxx_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+	int val;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			    MDIO_PCS_1000BT1_CTRL, MDIO_PCS_1000BT1_CTRL_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PCS,
+					 MDIO_PCS_1000BT1_CTRL, val,
+					 !(val & MDIO_PCS_1000BT1_CTRL_RESET),
+					 50000, 600000, true);
+}
+
+static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
+{
+	int ret;
+	bool link = false;
+
+	/* Read vendor specific Auto-Negotiation status register to get local
+	 * and remote receiver status according to software initialization
+	 * guide.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
+	if (ret < 0) {
+		return ret;
+	} else if ((ret & MDIO_MMD_AN_MV_STAT_LOCAL_RX) &&
+		   (ret & MDIO_MMD_AN_MV_STAT_REMOTE_RX)) {
+		/* The link state is latched low so that momentary link
+		 * drops can be detected. Do not double-read the status
+		 * in polling mode to detect such short link drops except
+		 * the link was already down.
+		 */
+		if (!phy_polling_mode(phydev) || !phydev->link) {
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			if (ret < 0)
+				return ret;
+			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
+				link = true;
+		}
+
+		if (!link) {
+			ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+			if (ret < 0)
+				return ret;
+			else if (ret & MDIO_PCS_1000BT1_STAT_LINK)
+				link = true;
+		}
+	}
+
+	phydev->link = link;
+
+	return 0;
+}
+
+static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
+{
+	int ret;
+
+	/* The link state is latched low so that momentary link
+	 * drops can be detected. Do not double-read the status
+	 * in polling mode to detect such short link drops except
+	 * the link was already down. In case we are not polling,
+	 * we always read the realtime status.
+	 */
+	if (!phy_polling_mode(phydev) || !phydev->link) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_100BT1_STAT1);
+		if (ret < 0)
+			return ret;
+		else if (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LINK)
+			goto out;
+	}
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_100BT1_STAT1);
+	if (ret < 0)
+		return ret;
+
+out:
+	/* Check if we have link and if the remote and local receiver are ok */
+	if ((ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LINK) &&
+	    (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_RX) &&
+	    (ret & MDIO_MMD_PCS_MV_100BT1_STAT1_REMOTE_RX))
+		phydev->link = true;
+	else
+		phydev->link = false;
+
+	return 0;
+}
+
+static int mv88q2xxx_read_link(struct phy_device *phydev)
+{
+	int ret;
+
+	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
+	 * therefore we need to read the link status from the vendor specific
+	 * registers depending on the speed.
+	 */
+	if (phydev->speed == SPEED_1000)
+		ret = mv88q2xxx_read_link_gbit(phydev);
+	else
+		ret = mv88q2xxx_read_link_100m(phydev);
+
+	return ret;
+}
+
+static int mv88q2xxx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mv88q2xxx_read_link(phydev);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_read_pma(phydev);
+}
+
+static int mv88q2xxx_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* We need to read the baset1 extended abilities manually because the
+	 * PHY does not signalize it has the extended abilities register
+	 * available.
+	 */
+	ret = genphy_c45_pma_baset1_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* The PHY signalizes it supports autonegotiation. Unfortunately, so
+	 * far it was not possible to get a link even when following the init
+	 * sequence provided by Marvell. Disable it for now until a proper
+	 * workaround is found or a new PHY revision is released.
+	 */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int mv88q2xxx_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	return mv88q2xxx_soft_reset(phydev);
+}
+
+static int mv88q2xxx_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* The 88Q2XXX PHYs do have the extended ability register available, but
+	 * register MDIO_PMA_EXTABLE where they should signalize it does not
+	 * work according to specification. Therefore, we force it here.
+	 */
+	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
+
+	/* Read the current PHY configuration */
+	ret = genphy_c45_read_pma(phydev);
+	if (ret)
+		return ret;
+
+	return mv88q2xxx_config_aneg(phydev);
+}
+
+static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->speed == SPEED_100) {
+		/* Read the SQI from the vendor specific receiver status
+		 * register
+		 */
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		if (ret < 0)
+			return ret;
+
+		ret = ret >> 12;
+	} else {
+		/* Read from vendor specific registers, they are not documented
+		 * but can be found in the Software Initialization Guide. Only
+		 * revisions >= A0 are supported.
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret & 0x0F;
+}
+
+static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
+{
+	return 15;
+}
+
+static struct phy_driver mv88q2xxx_driver[] = {
+	{
+		.phy_id			= MARVELL_PHY_ID_88Q2110,
+		.phy_id_mask		= MARVELL_PHY_ID_MASK,
+		.name			= "mv88q2110",
+		.get_features		= mv88q2xxx_get_features,
+		.config_aneg		= mv88q2xxx_config_aneg,
+		.config_init		= mv88q2xxx_config_init,
+		.read_status		= mv88q2xxx_read_status,
+		.soft_reset		= mv88q2xxx_soft_reset,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= mv88q2xxxx_get_sqi,
+		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+	},
+};
+
+module_phy_driver(mv88q2xxx_driver);
+
+static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
+	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
+	{ /*sentinel*/ }
+};
+MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);
+
+MODULE_DESCRIPTION("Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet PHY driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 0f06c2287b527..9b54c4f0677f8 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -25,6 +25,7 @@
 #define MARVELL_PHY_ID_88X3310		0x002b09a0
 #define MARVELL_PHY_ID_88E2110		0x002b09b0
 #define MARVELL_PHY_ID_88X2222		0x01410f10
+#define MARVELL_PHY_ID_88Q2110		0x002b0980
 
 /* Marvel 88E1111 in Finisar SFP module with modified PHY ID */
 #define MARVELL_PHY_ID_88E1111_FINISAR	0x01ff0cc0
-- 
2.39.2


