Return-Path: <netdev+bounces-143482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D398A9C2968
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939852851A0
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F76A019;
	Sat,  9 Nov 2024 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IE+peCqY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4D3E499;
	Sat,  9 Nov 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117477; cv=none; b=fH5l0YizoIM8pqcKwp7EPQN23KyRtCTytO/Ko5LxGcZ+I+R2bVGCP6dfZoq24H287lo0PQ+K512bxMUm+BJkzGR1Xe/BOSUBRLLQCyakwQgmH6mvPSy7cT05EJRKt/uue9h2qAmqgTv/ryM/ha4kuJDUePyL1dOd7e15VnYMX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117477; c=relaxed/simple;
	bh=t+8wejVrRxHqj2UwCkLz5N3aWYE1M7nIEHcG8LhRq1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZBxHd8B4LnCg9ZaFZCs80Un3BqJyD0R6feOKAbQ/KxykOpsNzZ0Lks9fdfvMKaFd7ojIXSudsOQVgXsXaHJDTIwyZUwACC6PQM69/2CVXqFkEHZO1DC4XWj4OOO/jRPmlMTjZQ4v6oDcDL/Tmabvczu8pjMZ2t76gm5LWCSo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IE+peCqY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731117475; x=1762653475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+8wejVrRxHqj2UwCkLz5N3aWYE1M7nIEHcG8LhRq1c=;
  b=IE+peCqYtrkNN6pkUz7+rAEn1ZkMtdDDfrU3PR7p3lhtTBCinlxtr0lw
   w7VkA2de0NAg/b1h9c3p+x08N78z6MruDsrCXAiCosFYnuDUtJ/FYdnYa
   tshcre+/zWRhAa7HK13U55gKEMqOoTUcK+lvXPulSG++A1FrfDDddvP4G
   NGXxRm9spjTseeXlE6HoHERW5aIxjCWGadDZKCQPjtcN+jZnXAGkOjzvP
   +XlAHoC0v/Id6KOwd4iknMCLlHL5YayGT41rt4rV6jHzimcMIBHTv9qxS
   9PL2jcZIxSMsUi9gxve3AJiIooroMI0FzVOeFJBouZsRy84ri2TlRo+bu
   w==;
X-CSE-ConnectionGUID: pTvoazo0Qby90C19TFh6kw==
X-CSE-MsgGUID: CM/YqHmUQ0ingohVCodjCA==
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="33824495"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 18:57:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 18:57:07 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 18:57:07 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 2/2] net: dsa: microchip: Add LAN9646 switch support to KSZ DSA driver
Date: Fri, 8 Nov 2024 17:57:05 -0800
Message-ID: <20241109015705.82685-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109015705.82685-1-Tristram.Ha@microchip.com>
References: <20241109015705.82685-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

LAN9646 switch is a 6-port switch with functions like KSZ9897.  It has
4 internal PHYs and 1 SGMII port.  The chip id read from hardware is
same as KSZ9477, so software driver needs to create a new chip id and
group allowable functions under its chip data structure to
differentiate the product.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c         |  4 ++
 drivers/net/dsa/microchip/ksz9477_i2c.c     | 14 +++++-
 drivers/net/dsa/microchip/ksz_common.c      | 50 ++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  1 +
 drivers/net/dsa/microchip/ksz_spi.c         |  7 +++
 include/linux/platform_data/microchip-ksz.h |  1 +
 6 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 0ba658a72d8f..d16817e0476f 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1131,6 +1131,10 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 		if (i == dev->cpu_port)
 			continue;
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+
+		/* Power down the internal PHY if port is unused. */
+		if (dsa_is_unused_port(ds, i) && dev->info->internal_phy[i])
+			ksz_pwrite16(dev, i, 0x100, BMCR_PDOWN);
 	}
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index 7d7560f23a73..1c6d7fc16772 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 series register access through I2C
  *
- * Copyright (C) 2018-2019 Microchip Technology Inc.
+ * Copyright (C) 2018-2024 Microchip Technology Inc.
  */
 
 #include <linux/i2c.h>
@@ -16,6 +16,8 @@ KSZ_REGMAP_TABLE(ksz9477, not_used, 16, 0, 0);
 
 static int ksz9477_i2c_probe(struct i2c_client *i2c)
 {
+	const struct ksz_chip_data *chip;
+	struct device *ddev = &i2c->dev;
 	struct regmap_config rc;
 	struct ksz_device *dev;
 	int i, ret;
@@ -24,6 +26,12 @@ static int ksz9477_i2c_probe(struct i2c_client *i2c)
 	if (!dev)
 		return -ENOMEM;
 
+	chip = device_get_match_data(ddev);
+	if (!chip)
+		return -EINVAL;
+
+	/* Save chip id to do special initialization when probing. */
+	dev->chip_id = chip->chip_id;
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = ksz9477_regmap_config[i];
 		rc.lock_arg = &dev->regmap_mutex;
@@ -111,6 +119,10 @@ static const struct of_device_id ksz9477_dt_ids[] = {
 		.compatible = "microchip,ksz9567",
 		.data = &ksz_switch_chips[KSZ9567]
 	},
+	{
+		.compatible = "microchip,lan9646",
+		.data = &ksz_switch_chips[LAN9646]
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f73833e24622..a557847fda11 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1901,6 +1901,41 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   false, false, true, true},
 	},
+
+	[LAN9646] = {
+		.chip_id = LAN9646_CHIP_ID,
+		.dev_name = "LAN9646",
+		.num_vlans = 4096,
+		.num_alus = 4096,
+		.num_statics = 16,
+		.cpu_ports = 0x7F,	/* can be configured as cpu port */
+		.port_cnt = 7,		/* total physical port count */
+		.port_nirqs = 4,
+		.num_tx_queues = 4,
+		.num_ipms = 8,
+		.ops = &ksz9477_dev_ops,
+		.phylink_mac_ops = &ksz9477_phylink_mac_ops,
+		.phy_errata_9477 = true,
+		.mib_names = ksz9477_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz9477_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz9477_regs,
+		.masks = ksz9477_masks,
+		.shifts = ksz9477_shifts,
+		.xmii_ctrl0 = ksz9477_xmii_ctrl0,
+		.xmii_ctrl1 = ksz9477_xmii_ctrl1,
+		.supports_mii	= {false, false, false, false,
+				   false, true, true},
+		.supports_rmii	= {false, false, false, false,
+				   false, true, true},
+		.supports_rgmii = {false, false, false, false,
+				   false, true, true},
+		.internal_phy	= {true, true, true, true,
+				   true, false, false},
+		.gbit_capable	= {true, true, true, true, true, true, true},
+		.wr_table = &ksz9477_register_set,
+		.rd_table = &ksz9477_register_set,
+	},
 };
 EXPORT_SYMBOL_GPL(ksz_switch_chips);
 
@@ -2743,6 +2778,7 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 	case KSZ9896_CHIP_ID:
 		/* KSZ9896C Errata DS80000757A Module 3 */
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		/* KSZ9897R Errata DS80000758C Module 4 */
 		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
 		 *   The EEE feature is enabled by default, but it is not fully
@@ -3003,6 +3039,7 @@ static void ksz_port_teardown(struct dsa_switch *ds, int port)
 	case KSZ9893_CHIP_ID:
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		if (dsa_is_user_port(ds, port))
 			ksz9477_port_acl_free(dev, port);
 	}
@@ -3059,7 +3096,8 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	    dev->chip_id == KSZ9477_CHIP_ID ||
 	    dev->chip_id == KSZ9896_CHIP_ID ||
 	    dev->chip_id == KSZ9897_CHIP_ID ||
-	    dev->chip_id == KSZ9567_CHIP_ID)
+	    dev->chip_id == KSZ9567_CHIP_ID ||
+	    dev->chip_id == LAN9646_CHIP_ID)
 		proto = DSA_TAG_PROTO_KSZ9477;
 
 	if (is_lan937x(dev))
@@ -3178,6 +3216,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case LAN9372_CHIP_ID:
 	case LAN9373_CHIP_ID:
 	case LAN9374_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		return KSZ9477_MAX_FRAME_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	}
 
@@ -3200,6 +3239,7 @@ static int ksz_validate_eee(struct dsa_switch *ds, int port)
 	case KSZ9893_CHIP_ID:
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		return 0;
 	}
 
@@ -3552,7 +3592,10 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		case LAN9372_CHIP_ID:
 		case LAN9373_CHIP_ID:
 		case LAN9374_CHIP_ID:
-			dev->chip_id = id32;
+
+			/* LAN9646 does not have its own chip id. */
+			if (dev->chip_id != LAN9646_CHIP_ID)
+				dev->chip_id = id32;
 			break;
 		case KSZ9893_CHIP_ID:
 			ret = ksz_read8(dev, REG_CHIP_ID4,
@@ -3591,6 +3634,7 @@ static int ksz_cls_flower_add(struct dsa_switch *ds, int port,
 	case KSZ9893_CHIP_ID:
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		return ksz9477_cls_flower_add(ds, port, cls, ingress);
 	}
 
@@ -3611,6 +3655,7 @@ static int ksz_cls_flower_del(struct dsa_switch *ds, int port,
 	case KSZ9893_CHIP_ID:
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		return ksz9477_cls_flower_del(ds, port, cls, ingress);
 	}
 
@@ -4698,6 +4743,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 	case KSZ9893_CHIP_ID:
 	case KSZ9896_CHIP_ID:
 	case KSZ9897_CHIP_ID:
+	case LAN9646_CHIP_ID:
 		return ksz9477_drive_strength_write(dev, of_props,
 						    ARRAY_SIZE(of_props));
 	default:
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index bec846e20682..719bf2f8a524 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -214,6 +214,7 @@ enum ksz_model {
 	LAN9372,
 	LAN9373,
 	LAN9374,
+	LAN9646,
 };
 
 enum ksz_regs {
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 1c6652f2b9fe..108a958dc356 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -54,6 +54,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 	if (!chip)
 		return -EINVAL;
 
+	/* Save chip id to do special initialization when probing. */
+	dev->chip_id = chip->chip_id;
 	if (chip->chip_id == KSZ88X3_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
@@ -203,6 +205,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,lan9374",
 		.data = &ksz_switch_chips[LAN9374]
 	},
+	{
+		.compatible = "microchip,lan9646",
+		.data = &ksz_switch_chips[LAN9646]
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);
@@ -228,6 +234,7 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "lan9372" },
 	{ "lan9373" },
 	{ "lan9374" },
+	{ "lan9646" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 2ee1a679e592..0e0e8fe6975f 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -42,6 +42,7 @@ enum ksz_chip_id {
 	LAN9372_CHIP_ID = 0x00937200,
 	LAN9373_CHIP_ID = 0x00937300,
 	LAN9374_CHIP_ID = 0x00937400,
+	LAN9646_CHIP_ID = 0x00964600,
 };
 
 struct ksz_platform_data {
-- 
2.34.1


