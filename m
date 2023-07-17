Return-Path: <netdev+bounces-18419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FDB756D5E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124A41C20BB0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA4C2FD;
	Mon, 17 Jul 2023 19:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D80C8D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:34:00 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37F9D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso50894645e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622436; x=1692214436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l634TZtc+NZ1tgp3qDzHddNU6DytBR+nzgINQgspDIc=;
        b=aTbno07QXpcH0p6S6uKf51tJphRzNLEEHcpnj7DekCoAXPhYuvBkmv3P+zseYFPb61
         g5coQh45HkTRIzqaPFMDBh7zBhylpshlntS0Cz3CE92+WtftVJa20A4YUuqEE37tA+Wy
         WZJKtpwvloCbrVgxYR3UXMza3BkmiRKzQsyA/Q/d2S0MhqDwHi3SujEdyrpVwFnjY7nS
         lEIr+XpV+pP+XYuD04swLNJK3WvpV1TrQm8yeuGUDJA7rhmk8qAHNMIVLIj+A0lBTEe1
         V6vZhPYim997WGYVaEYLQHtsLI+b0+ToGgvCXmJHcPNnbf2we6+0R/iS55MHEvh4ZwqK
         UiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622436; x=1692214436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l634TZtc+NZ1tgp3qDzHddNU6DytBR+nzgINQgspDIc=;
        b=jrPLjpZiYR5sE/EJrpJG7clOIlbRYJNJFXtZT9d31UxHa/EypYrUNK4LXaG+sOINMQ
         m/1jOGrxiagaZf2amldXMIm7UWR1SE6dO9neoDBWQNqWU0Ls0I56vK3WzNfv1DkiAERE
         LKkFc3z3crHbEao2zUaxISZT1ZvpzCAQv8bLt7TKMCvPx9lyZwz7q2ew+bcaSZnowz/d
         ZN0yvnGLQ3eYiZgTpC06xPr3qLQ4IYrDFshZscmCx/UyYEOyeu/i4Q2JvrUVaN/ODeYg
         uJottzUiM9ZTlhJIKMOPgkVdY0hEovC3a1I9/pDUuYrzIktEEMJeqZM4m5AADJB3o8f1
         F0cw==
X-Gm-Message-State: ABy/qLZY/VWsIqVpI3GBOz3BwLx87G5Nk8D4A5GZ2u1rWF+mhcWsbGW3
	elG071EAlTiSujBPgZf1rDP5FB+p1O43kA==
X-Google-Smtp-Source: APBJJlH+rtMAPuubfxgul+SAdFAMHOYfXCkr2uHpJotTqvkZk0HFmPW8rqN7S9NMWz6xUo5PHGFviw==
X-Received: by 2002:a7b:cd96:0:b0:3fb:424b:ef6e with SMTP id y22-20020a7bcd96000000b003fb424bef6emr263840wmj.23.1689622436424;
        Mon, 17 Jul 2023 12:33:56 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:33:55 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	francesco.dolcini@toradex.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eichest@gmail.com
Subject: [PATCH net-next v3 5/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY
Date: Mon, 17 Jul 2023 21:33:50 +0200
Message-Id: <20230717193350.285003-6-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717193350.285003-1-eichest@gmail.com>
References: <20230717193350.285003-1-eichest@gmail.com>
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
---
 drivers/net/phy/Kconfig           |   6 +
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 265 ++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
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
index 0000000000000..e675b251e01bc
--- /dev/null
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell 88Q2XXX automotive 100BASE-T1/1000BASE-T1 PHY driver
+ */
+#include <linux/ethtool_netlink.h>
+#include <linux/marvell_phy.h>
+#include <linux/phy.h>
+
+#define MARVELL_PHY_ID_88Q2110	0x002b0981
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
-- 
2.39.2


