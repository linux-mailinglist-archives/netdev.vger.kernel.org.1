Return-Path: <netdev+bounces-15126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11C745C74
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B740D280C59
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF40F9CE;
	Mon,  3 Jul 2023 12:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68996F9CD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:44:48 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AAEAF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:44:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so6836203e87.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688388285; x=1690980285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH+d2J7K6bZFFPKbWxdxgDecrHnu6ovoU4nbqXxwEhg=;
        b=J+l5H6DX6msIpSpGZowPGQ2tMpUDBL05RJnBoWKl/Pnpm2vk/sih6D9KlpC2E3JBXF
         bEnmaMOOZOlNIwlLXtmKpzuXuFOxKsrpUzo3Qk6Pvigi/QCyJzzILzS4kuKcToCuuGTz
         P3IHU4bt8admnlsMZEIRAtjvN47UitcLDEAL2KKu7XWU+h0eglMXzhW1RGd4MZvzWQPz
         SYyR9yc2koVbggp4gWT4LhtwmVqekmcKdRj7GgoBxZGaKv830DhhLxnm3aaQCzzCQccE
         QbMvIZH6esnXhnhJDudzY0LzMbzIwbh/gZdp/p7IpE7XGhpUfYggXMc+KOKXZ3qUvust
         uWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388285; x=1690980285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH+d2J7K6bZFFPKbWxdxgDecrHnu6ovoU4nbqXxwEhg=;
        b=GJ31pkHiXuuMQwIVQhasQrk6RfjC+GBPJKszBAJpTi/wuyuaXlcwLg0cTr2Ry2blDJ
         6JeNRkC4b/8znvswE7qgFGmaBG6jY58XPmJQItbfuaWhLKZdhXR5qiq6TpQ5bMSPu7fd
         CUqkWHHI/Fgxr0oNzJMlaJeVTnLhp5/ksjYk8ZzQ26UiFOae3eqt9D6IGlD1VGXJWcUW
         50AdRHRPVEdJ+/XGnxiD6ZMsTshhAZOD9hi1C6iECt4nN4DTJw2UDZt8BxEMFffZV2kt
         z71sc9WT+1n8Ee+Ehb1sBVpqK/7XkBGmz2YqCIjOi9X1QzWTk+Ytl6xA3xlhoWivQeFG
         2BZg==
X-Gm-Message-State: ABy/qLYLiFON0+Acu83rzh+gTpLzD/Yya954Vmcrti8l3c2uubSJs0xl
	dN/vwvtF//cocEF2riniAcPPeDXkPY9GFQ==
X-Google-Smtp-Source: APBJJlE0ssHGsyJjbcjSpvCLNrOAMS1ZLCwAUPpPBcSret5XODtza4Sce9wYdRoJicn7uWJaVSGwkw==
X-Received: by 2002:ac2:5059:0:b0:4fb:7c94:b3e4 with SMTP id a25-20020ac25059000000b004fb7c94b3e4mr6413638lfm.29.1688388284534;
        Mon, 03 Jul 2023 05:44:44 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:a288:787a:8e86:8fea])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm26650681wmb.26.2023.07.03.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:44:43 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	francesco.dolcini@toradex.com
Subject: [PATCH v1 2/2] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY
Date: Mon,  3 Jul 2023 14:44:40 +0200
Message-Id: <20230703124440.391970-3-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124440.391970-1-eichest@gmail.com>
References: <20230703124440.391970-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a driver for the Marvell 88Q2110. This driver is minimalistic, but
already allows to detect the link, switch between 100BASE-T1 and
1000BASE-T1 and switch between master and slave mode. Autonegotiation
supported by the PHY is not yet implemented.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/Kconfig           |   6 +
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 217 ++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 93b8efc792273..2913b145d5406 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -223,6 +223,12 @@ config MARVELL_88X2222_PHY
 	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
 	  Transceiver.
 
+config MARVELL_88Q2XXX_PHY
+	tristate "Marvell 88Q2XXX PHY"
+	help
+	  Support for the Marvell Automotive 88Q2XXX 100/1000BASE-T1 Ethernet
+	  PHYs.
+
 config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
 	select POLYNOMIAL if HWMON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f289ab16a1dab..15d1908fd5cb7 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)	+= mediatek-ge.o
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
new file mode 100644
index 0000000000000..637697e9f19fa
--- /dev/null
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Marvell 88Q2XXX automotive 100BASE-T1/1000BASE-T1 PHY driver
+ */
+
+#include <linux/marvell_phy.h>
+#include <linux/phy.h>
+#include <linux/ethtool_netlink.h>
+
+#define MARVELL_PHY_ID_88Q2110		0x002b0981
+
+static int mv88q2xxx_soft_reset(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, 3, 0x0900, 0x8000);
+
+	return 0;
+}
+
+static void init_fast_ethernet(struct phy_device *phydev)
+{
+	u16 value = phy_read_mmd(phydev, 1, 0x0834);
+
+	value = value & 0xFFF0;
+
+	phy_write_mmd(phydev, 1, 0x0834, value);
+}
+
+static void init_gbit_ethernet(struct phy_device *phydev)
+{
+	u16 value = phy_read_mmd(phydev, 1, 0x0834);
+
+	value = (value & 0xFFF0) | 0x0001;
+
+	phy_write_mmd(phydev, 1, 0x0834, value);
+}
+
+static int setup_master_slave(struct phy_device *phydev)
+{
+	u16 reg_data = phy_read_mmd(phydev, 1, 0x0834);
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+		reg_data |= 0x4000;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		reg_data &= ~0x4000;
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		return 0;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	phy_write_mmd(phydev, 1, 0x0834, reg_data);
+
+	return 0;
+}
+
+static int mv88q2xxx_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->speed == SPEED_100)
+		init_fast_ethernet(phydev);
+	else if (phydev->speed == SPEED_1000)
+		init_gbit_ethernet(phydev);
+
+	ret = setup_master_slave(phydev);
+	if (ret)
+		return ret;
+
+	mv88q2xxx_soft_reset(phydev);
+
+	return 0;
+}
+
+static int mv88q2xxx_config_init(struct phy_device *phydev)
+{
+	return mv88q2xxx_config_aneg(phydev);
+}
+
+static int get_speed(struct phy_device *phydev)
+{
+	u16 value = 0;
+
+	if (phydev->autoneg)
+		value = (phy_read_mmd(phydev, 7, 0x801a) & 0x4000) >> 14;
+	else
+		value = (phy_read_mmd(phydev, 1, 0x0834) & 0x1);
+
+	return value ? SPEED_1000 : SPEED_100;
+}
+
+static int check_link(struct phy_device *phydev)
+{
+	u16 ret1, ret2;
+
+	if (phydev->speed == SPEED_1000) {
+		ret1 = phy_read_mmd(phydev, 3, 0x0901);
+		ret1 = phy_read_mmd(phydev, 3, 0x0901);
+		ret2 = phy_read_mmd(phydev, 7, 0x8001);
+	} else {
+		ret1 = phy_read_mmd(phydev, 3, 0x8109);
+		ret2 = phy_read_mmd(phydev, 3, 0x8108);
+	}
+
+	return (0x0 != (ret1 & 0x0004)) && (0x0 != (ret2 & 0x3000)) ? 1 : 0;
+}
+
+static int read_master_slave(struct phy_device *phydev)
+{
+	int reg;
+
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	reg = phy_read_mmd(phydev, 7, 0x8001);
+	if (reg & (1 << 14)) {
+		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
+		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+	} else {
+		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
+		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+	}
+
+	return 0;
+}
+
+static int mv88q2xxx_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	phydev->link = check_link(phydev);
+	phydev->speed = get_speed(phydev);
+
+	ret = read_master_slave(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mv88q2xxx_probe(struct phy_device *phydev)
+{
+	if (!phydev->is_c45)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int mv88q2xxxx_cable_test_start(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static int mv88q2xxxx_cable_test_get_status(struct phy_device *phydev,
+					    bool *finished)
+{
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				ETHTOOL_A_CABLE_RESULT_CODE_OK);
+	return 0;
+}
+
+static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+{
+	u16 value;
+
+	if (phydev->speed == SPEED_100)
+		value = (phy_read_mmd(phydev, 3, 0x8230) >> 12) & 0x0F;
+	else
+		value = phy_read_mmd(phydev, 3, 0xfc88) & 0x0F;
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
+		.cable_test_start	= mv88q2xxxx_cable_test_start,
+		.cable_test_get_status	= mv88q2xxxx_cable_test_get_status,
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
+	{ /*sentinel*/ },
+};
+MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);
+
+MODULE_DESCRIPTION("Marvell Automotive 100BASE-T1/1000BASE-T1 Ethernet PHY driver (MV88Q2xxx)");
+MODULE_LICENSE("GPL");
-- 
2.39.2


