Return-Path: <netdev+bounces-16608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FB74DFEA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C66A1C20BE0
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3516417;
	Mon, 10 Jul 2023 20:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A11640B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:59:09 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312DA8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso51011235e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022746; x=1691614746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIGDKkJAteMVs794jJ1dzt4soFTuOfuP4Ng6K1V+EoM=;
        b=UkD5osAXrjq6OSHOr3UyrSe6+JvKKSmBmCO6vpVWS2iVW5yl8B/Y8OvUUZ4nXNvF06
         8Tax71G7apbN2Y55HCpY/xqrUN9UFE7Z8uUXi74rWDjEmXNXoZKbmG80uLyERx3r5M14
         zEhjcZd4rQ2tl65pTfWwnY+NTbtP2elIlUPtUMT3sIKJqxFSYXEXjkyOIASNvaYfaySI
         Q7yEgtG9c/py9PBwRJaLlPToAp5npDN4s5zeMepMv9tQEeIfywMUC+LtT4P652W/SLKf
         HQmJ+zcgeugNtcs0u26wmelgP6aUwKOpGPgAaIrWch1JGi/ZX21KZC+9xhTSW/VUx0TV
         7atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022746; x=1691614746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIGDKkJAteMVs794jJ1dzt4soFTuOfuP4Ng6K1V+EoM=;
        b=FyuVsclT2nHzZKD9cj9EaA7UmzmoeJxEM4hIrFemYHpbQv+kXvD3O1eSj/LSo/YADQ
         IXJmIgX1Jmc7EgDix+ufdc87Re5vg+lliVXnfs3LGYoQt/ih4SvbVp2lXdoAiniR97CC
         PDw0+hUz1NWXi9DQPCeEV2KFGpFVK3GuPBbWWI4RyTQWqoBc953unDME+L5AOxO9pEfg
         ikjg9Aed+Q8VdJVfvd/ccMta6CFO6ihK/SLqugZNn8qLxGJ2Wp/LpCPm8VWZhqz08hQK
         PtG/P7COet/mcEgkbwjUuagRQzYDOEJewLXlfqNOytarT1xMwBDVsdaG/QCCKx0oZxMP
         c9qA==
X-Gm-Message-State: ABy/qLYc7j0IU0+R3MAg9fTRLZAaIfySnEo5pgJeZIrc0Hmii4CbC2Js
	RyubQlKJrAi5D3/m5A7DHjjOktBIurDORQ==
X-Google-Smtp-Source: APBJJlHNbHXRZFkj07brd7C0Rd2UiAvRsODHG5Rrb3OjCxfm0tWp0OEsZWYLD5mWaBQGJA6yFvkRSw==
X-Received: by 2002:a7b:c392:0:b0:3fb:d1db:5454 with SMTP id s18-20020a7bc392000000b003fbd1db5454mr14217680wmj.35.1689022746472;
        Mon, 10 Jul 2023 13:59:06 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f6df:53b3:3114:b666])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm11167880wmj.14.2023.07.10.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:59:06 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY
Date: Mon, 10 Jul 2023 22:59:00 +0200
Message-Id: <20230710205900.52894-5-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710205900.52894-1-eichest@gmail.com>
References: <20230710205900.52894-1-eichest@gmail.com>
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

Add a driver for the Marvell 88Q2110. This driver is minimalistic, but
already allows to detect the link, switch between 100BASE-T1 and
1000BASE-T1 and switch between master and slave mode. Autonegotiation
supported by the PHY is not yet implemented.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/Kconfig           |   6 ++
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 149 ++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
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
index 0000000000000..a073124c33f5e
--- /dev/null
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell 88Q2XXX automotive 100BASE-T1/1000BASE-T1 PHY driver
+ */
+#include <linux/ethtool_netlink.h>
+#include <linux/marvell_phy.h>
+#include <linux/phy.h>
+
+#define MARVELL_PHY_ID_88Q2110		0x002b0981
+
+static int mv88q2xxx_soft_reset(struct phy_device *phydev)
+{
+	return phy_write_mmd(phydev, MDIO_MMD_PCS,
+			     MDIO_PCS_1000BT1_CTRL, MDIO_PCS_1000BT1_CTRL_RESET);
+}
+
+static int mv88q2xxx_read_link(struct phy_device *phydev)
+{
+	u16 ret1, ret2;
+
+	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
+	 * therefore we need to read the link status from the vendor specific
+	 * registers.
+	 */
+	if (phydev->speed == SPEED_1000) {
+		/* Read twice to clear the latched status */
+		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
+		/* Read vendor specific Auto-Negotiation status register to get
+		 * local and remote receiver status
+		 */
+		ret2 = phy_read_mmd(phydev, MDIO_MMD_AN, 0x8001);
+	} else {
+		/* Read vendor specific status registers, the registers are not
+		 * documented but they can be found in the Software
+		 * Initialization Guide
+		 */
+		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8109);
+		ret2 = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8108);
+	}
+
+	/* Check the link status according to Software Initialization Guide */
+	return (0x0 != (ret1 & 0x0004)) && (0x0 != (ret2 & 0x3000)) ? 1 : 0;
+}
+
+static int mv88q2xxx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	phydev->link = mv88q2xxx_read_link(phydev);
+
+	ret = genphy_c45_read_pma(phydev);
+	if (ret)
+		return ret;
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
+	ret = mv88q2xxx_soft_reset(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
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
+static int mv88q2xxx_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+{
+	u16 value;
+
+	if (phydev->speed == SPEED_100) {
+		/* Read the SQI from the vendor specific receiver status
+		 * register
+		 */
+		value = (phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230) >> 12) & 0x0F;
+	} else {
+		/* Read from vendor specific registers, they are not documented
+		 * but can be found in the Software Initialization Guide. Only
+		 * revisions >= A0 are supported.
+		 */
+		phy_modify_mmd(phydev, MDIO_MMD_PCS, 0xFC5D, 0x00FF, 0x00AC);
+		value = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfc88) & 0x0F;
+	}
+
+	return value;
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
+		.features		= PHY_GBIT_T1_FEATURES,
+		.name			= "mv88q2110",
+		.probe			= mv88q2xxx_probe,
+		.soft_reset		= mv88q2xxx_soft_reset,
+		.config_init		= mv88q2xxx_config_init,
+		.read_status		= mv88q2xxx_read_status,
+		.config_aneg		= mv88q2xxx_config_aneg,
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


