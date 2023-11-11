Return-Path: <netdev+bounces-47211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCB7E8CF5
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4464280DE5
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9A1DDDF;
	Sat, 11 Nov 2023 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZSojA2+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A26200AC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 21:57:23 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8502A2737
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:21 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58a0d0cdcc1so1038727eaf.1
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739840; x=1700344640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYpmLsQs+dQQCyYUPYba+b1wzeVO8kEdwnR5cr6h/Cw=;
        b=NZSojA2+SqIe6fIe97Lu9Da5qvzx68ZBoO3encMZKmkFxad7V5PsN1F+QF//8BesyY
         O+4BJheW2+petIJbd38xgFt0/SwaVwiyO/phywDjaSDL9czwneK9MutcJ5zYpimN6qrk
         IGfFPsqk6I52HK7M3HksoVKzzBLgqTZSo4sV/9Ixxt2THlJ2tE8+22g1Gv1YDxNLXCns
         wC+Ujk7dY06tZEP34DVs80t/Y57ufR0Ev1+l4mjMrmNNzO5Im9vcvkid+NmMKGZtTHuu
         /TS854ACygqcVuxFaATF5L9/ERsL64GOziXg3spD9jB3vBu8OGDSTC63NpOKfPAKN4wF
         y4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739840; x=1700344640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYpmLsQs+dQQCyYUPYba+b1wzeVO8kEdwnR5cr6h/Cw=;
        b=qBf3uj9TJllakHQd1Y942va5t85Q3D8gVnZnT6A6dd1ASpdwX2/a0Sl3PVqsguCAV0
         SAd9ltAIVd8dWREgsvO37TAnTEzKAI6MjrBcoe97hd7bRjncwlwHIYc8fYsy9L0iZ5ec
         yxU3CLVTGhhKVnl63ggkwAi8xl+5vKF8pUcm4+BvF5gdul1iFPkzBa3fMj4EYH/Flpte
         JI4xNyM8XEuYebPxcq4ptPXOBbt+DdPGAIxBAXZ5prvxxgMRvuvqmzQDUuaz38eiWrmc
         EVCtgg4g6W8bSqnl/3woDypQ3UHGGGykrCVxAsRiIrcOod1AP92dcOrLtFJIaHA1ZruA
         C09g==
X-Gm-Message-State: AOJu0YxX1pdv+ulEADOdJoiJEa2t3pq8320ms7akmZUcn7h3go026xMm
	gF2wkCudWxlhD8hh+fCTDjDKsnWrgnakOQ==
X-Google-Smtp-Source: AGHT+IFYxf22m4HPbyr3x9Rbd/u7RGQEPQR8UEqV7Qlqj4B/lJQcfmAYrRgti+0ao3P1R26W6gEOKA==
X-Received: by 2002:a05:6870:3b11:b0:1f2:dfbf:607b with SMTP id gh17-20020a0568703b1100b001f2dfbf607bmr4214213oab.25.1699739839476;
        Sat, 11 Nov 2023 13:57:19 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:19 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
Date: Sat, 11 Nov 2023 18:51:06 -0300
Message-ID: <20231111215647.4966-4-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231111215647.4966-1-luizluca@gmail.com>
References: <20231111215647.4966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code can be shared between both interface modules (MDIO and SMI)
and amongst variants. For now, these interface functions are shared:

- realtek_common_lock
- realtek_common_unlock
- realtek_common_probe
- realtek_common_remove

The reset during probe was moved to the last moment before a variant
detects the switch. This way, we avoid a reset if anything else fails.

The symbols from variants used in of_match_table are now in a single
match table in realtek-common, used by both interfaces.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/realtek-common.c | 139 +++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-common.h |  16 +++
 drivers/net/dsa/realtek/realtek-mdio.c   | 116 +++----------------
 drivers/net/dsa/realtek/realtek-smi.c    | 127 +++------------------
 drivers/net/dsa/realtek/realtek.h        |   2 +
 6 files changed, 184 insertions(+), 217 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/realtek-common.c
 create mode 100644 drivers/net/dsa/realtek/realtek-common.h

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..5e0c1ef200a3 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-common.o
 obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
 obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
new file mode 100644
index 000000000000..36f8b60771be
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/module.h>
+
+#include "realtek.h"
+#include "realtek-common.h"
+
+void realtek_common_lock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_lock(&priv->map_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_common_lock);
+
+void realtek_common_unlock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_unlock(&priv->map_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_common_unlock);
+
+struct realtek_priv *realtek_common_probe(struct device *dev,
+		struct regmap_config rc, struct regmap_config rc_nolock)
+{
+	const struct realtek_variant *var;
+	struct realtek_priv *priv;
+	struct device_node *np;
+	int ret;
+
+	var = of_device_get_match_data(dev);
+	if (!var)
+		return ERR_PTR(-EINVAL);
+
+	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
+			    GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&priv->map_lock);
+
+	rc.lock_arg = priv;
+	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map)) {
+		ret = PTR_ERR(priv->map);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
+	if (IS_ERR(priv->map_nolock)) {
+		ret = PTR_ERR(priv->map_nolock);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* Link forward and backward */
+	priv->dev = dev;
+	priv->clk_delay = var->clk_delay;
+	priv->cmd_read = var->cmd_read;
+	priv->cmd_write = var->cmd_write;
+	priv->variant = var;
+	priv->ops = var->ops;
+	priv->chip_data = (void *)priv + sizeof(*priv);
+
+	dev_set_drvdata(dev, priv);
+	spin_lock_init(&priv->lock);
+
+	/* Fetch MDIO pins */
+	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->mdc))
+		return ERR_CAST(priv->mdc);
+
+	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->mdio))
+		return ERR_CAST(priv->mdio);
+
+	np = dev->of_node;
+
+	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
+
+	/* TODO: if power is software controlled, set up any regulators here */
+
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return ERR_CAST(priv->reset);
+	}
+	if (priv->reset) {
+		gpiod_set_value(priv->reset, 1);
+		dev_dbg(dev, "asserted RESET\n");
+		msleep(REALTEK_HW_STOP_DELAY);
+		gpiod_set_value(priv->reset, 0);
+		msleep(REALTEK_HW_START_DELAY);
+		dev_dbg(dev, "deasserted RESET\n");
+	}
+
+	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return ERR_PTR(-ENOMEM);
+
+	priv->ds->dev = dev;
+	priv->ds->priv = priv;
+
+	return priv;
+}
+EXPORT_SYMBOL(realtek_common_probe);
+
+void realtek_common_remove(struct realtek_priv *priv)
+{
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+	if (priv->user_mii_bus)
+		of_node_put(priv->user_mii_bus->dev.of_node);
+
+	/* leave the device reset asserted */
+	if (priv->reset)
+		gpiod_set_value(priv->reset, 1);
+}
+EXPORT_SYMBOL(realtek_common_remove);
+
+const struct of_device_id realtek_common_of_match[] = {
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
+	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+#endif
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
+	{ .compatible = "realtek,rtl8365mb", .data = &rtl8366rb_variant, },
+#endif
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, realtek_common_of_match);
+EXPORT_SYMBOL_GPL(realtek_common_of_match);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_DESCRIPTION("Realtek DSA switches common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
new file mode 100644
index 000000000000..90a949386518
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_INTERFACE_H
+#define _REALTEK_INTERFACE_H
+
+#include <linux/regmap.h>
+
+extern const struct of_device_id realtek_common_of_match[];
+
+void realtek_common_lock(void *ctx);
+void realtek_common_unlock(void *ctx);
+struct realtek_priv *realtek_common_probe(struct device *dev,
+		struct regmap_config rc, struct regmap_config rc_nolock);
+void realtek_common_remove(struct realtek_priv *priv);
+
+#endif
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..6f610386c977 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -99,20 +100,6 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
 	return ret;
 }
 
-static void realtek_mdio_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_mdio_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
 static const struct regmap_config realtek_mdio_regmap_config = {
 	.reg_bits = 10, /* A4..A0 R4..R0 */
 	.val_bits = 16,
@@ -123,8 +110,8 @@ static const struct regmap_config realtek_mdio_regmap_config = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_mdio_lock,
-	.unlock = realtek_mdio_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_mdio_nolock_regmap_config = {
@@ -142,75 +129,19 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 
 static int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
-	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
-	const struct realtek_variant *var;
-	struct regmap_config rc;
-	struct device_node *np;
+	struct realtek_priv *priv;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	if (!var)
-		return -EINVAL;
-
-	priv = devm_kzalloc(&mdiodev->dev,
-			    size_add(sizeof(*priv), var->chip_data_sz),
-			    GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_mdio_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	rc = realtek_mdio_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
+	priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
+				    realtek_mdio_nolock_regmap_config);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	priv->mdio_addr = mdiodev->addr;
 	priv->bus = mdiodev->bus;
-	priv->dev = &mdiodev->dev;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
-	priv->ops = var->ops;
-
 	priv->write_reg_noack = realtek_mdio_write;
-
-	np = dev->of_node;
-
-	dev_set_drvdata(dev, priv);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
+	priv->ds->ops = priv->variant->ds_ops_mdio;
 
 	ret = priv->ops->detect(priv);
 	if (ret) {
@@ -218,18 +149,12 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
 	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
-	priv->ds->ops = var->ds_ops_mdio;
 
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
-		dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
+		dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
+			      ERR_PTR(ret));
 		return ret;
 	}
 
@@ -243,11 +168,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
-
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 
 static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
@@ -262,21 +183,10 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 
-static const struct of_device_id realtek_mdio_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
-
 static struct mdio_driver realtek_mdio_driver = {
 	.mdiodrv.driver = {
 		.name = "realtek-mdio",
-		.of_match_table = realtek_mdio_of_match,
+		.of_match_table = realtek_common_of_match,
 	},
 	.probe  = realtek_mdio_probe,
 	.remove = realtek_mdio_remove,
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..0cf89f9db99e 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -310,20 +311,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static void realtek_smi_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_smi_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
 static const struct regmap_config realtek_smi_regmap_config = {
 	.reg_bits = 10, /* A4..A0 R4..R0 */
 	.val_bits = 16,
@@ -334,8 +321,8 @@ static const struct regmap_config realtek_smi_regmap_config = {
 	.reg_read = realtek_smi_read,
 	.reg_write = realtek_smi_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_smi_lock,
-	.unlock = realtek_smi_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_smi_nolock_regmap_config = {
@@ -410,78 +397,18 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 
 static int realtek_smi_probe(struct platform_device *pdev)
 {
-	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
 	struct realtek_priv *priv;
-	struct regmap_config rc;
-	struct device_node *np;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	np = dev->of_node;
-
-	priv = devm_kzalloc(dev, sizeof(*priv) + var->chip_data_sz, GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_smi_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	rc = realtek_smi_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	/* Link forward and backward */
-	priv->dev = dev;
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
-	priv->ops = var->ops;
+	priv = realtek_common_probe(dev, realtek_smi_regmap_config,
+				    realtek_smi_nolock_regmap_config);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	priv->setup_interface = realtek_smi_setup_mdio;
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-
-	dev_set_drvdata(dev, priv);
-	spin_lock_init(&priv->lock);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
-
-	/* Fetch MDIO pins */
-	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdc))
-		return PTR_ERR(priv->mdc);
-	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdio))
-		return PTR_ERR(priv->mdio);
-
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
+	priv->ds->ops = priv->variant->ds_ops_smi;
 
 	ret = priv->ops->detect(priv);
 	if (ret) {
@@ -489,20 +416,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
 	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
 
-	priv->ds->ops = var->ds_ops_smi;
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
-		dev_err_probe(dev, ret, "unable to register switch\n");
+		dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
+			      ERR_PTR(ret));
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -513,13 +435,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 
 static void realtek_smi_shutdown(struct platform_device *pdev)
@@ -534,27 +450,10 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
-static const struct of_device_id realtek_smi_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{
-		.compatible = "realtek,rtl8366rb",
-		.data = &rtl8366rb_variant,
-	},
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{
-		.compatible = "realtek,rtl8365mb",
-		.data = &rtl8365mb_variant,
-	},
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
-
 static struct platform_driver realtek_smi_driver = {
 	.driver = {
 		.name = "realtek-smi",
-		.of_match_table = realtek_smi_of_match,
+		.of_match_table = realtek_common_of_match,
 	},
 	.probe  = realtek_smi_probe,
 	.remove_new = realtek_smi_remove,
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..8d9d546bf5f5 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -79,6 +79,8 @@ struct realtek_priv {
 	int			vlan_enabled;
 	int			vlan4k_enabled;
 
+	const struct realtek_variant *variant;
+
 	char			buf[4096];
 	void			*chip_data; /* Per-chip extra variant data */
 };
-- 
2.42.1


