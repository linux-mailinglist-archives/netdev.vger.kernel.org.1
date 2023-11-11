Return-Path: <netdev+bounces-47212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E17E8CF6
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BDFB20A67
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983271DFD1;
	Sat, 11 Nov 2023 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWG5p6em"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A781DFCC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 21:57:27 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC43253
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso3005942a91.2
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739844; x=1700344644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1H5txFFqn5OFTfh/LqNKrPLRjDeTeFCxnPBeLUeS/M=;
        b=fWG5p6emGm2YF2P7fywcqsnD/VAULGLjH94xF2JqD2I64itL+frMwRv86nm5etrnFB
         uDaeas0bu2+wTBdQjMrdEG/WsA/tow9wUIAyMl+2IFGQq/3sDYjLU+ZkaKL4NGy/AI7X
         YuN4tg8WLYAeRCrsCIgVQpLFRD9rbmXF3DH7Mr+jIskRSZgMGhDxfdWbBDgtSDxyjc1X
         ygMPtaz3PHKNAnyd+BJn+srSgiDZIx/QKrBO46HtID07rXHDlrA7g/xTuLwricQfW1HL
         lUl3+fqlZraTG2mU2Ggr0eLWCGZjULNkl3Pu13wkbNrwgwI1CIQJpwVMdgomIEO+Xa4A
         NlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739844; x=1700344644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1H5txFFqn5OFTfh/LqNKrPLRjDeTeFCxnPBeLUeS/M=;
        b=UQ/809ZFhP3P3HpeWSiULdc4i3uc88AQ6YUKyHiBfMQqyW2cwWkQMfql206Zao9KOT
         Iok5mH96Ajaz2qjnpb/FBpiari32PmZEMah86SpSvK3DYCbm4idN1efOxlHyA7DwGlSG
         dB9AnO0fupB9DbQ7EKzNpyjjUUiITVyS7BgEJvy5AQKKk7xNVeu1KK9WIuji9Yw9ACzp
         AFceWKofJ3mmFin2khbHlNiWmlaqaE+rJO6JeLahV3Ux0iKzjVVq3kXoXNDHXK8WIup/
         HZfA7leWjkHJgVhaSGNqlHJ7qomgLnWoAT7LNq+AYjQuDODYiTD8yA93FHaqAT9j+UVu
         HXfA==
X-Gm-Message-State: AOJu0YwsIfFi8YpHvApiG3468wAKwBWGsJhb1LGDYWEQciTxe3RyHfpf
	Q0VTlN2ACTxYVfdGXa9yDr56j/By0Ggs2A==
X-Google-Smtp-Source: AGHT+IFynvinJ6IDWeQL0agl1QMv/t9hZy1eRPkhWcisftfCrRT6fldRcrYh5qJNoQfnMgbhpUvnIw==
X-Received: by 2002:a17:90b:164d:b0:281:858:a086 with SMTP id il13-20020a17090b164d00b002810858a086mr3292025pjb.6.1699739843533;
        Sat, 11 Nov 2023 13:57:23 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:23 -0800 (PST)
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
Subject: [RFC net-next 4/5] net: dsa: realtek: load switch variants on demand
Date: Sat, 11 Nov 2023 18:51:07 -0300
Message-ID: <20231111215647.4966-5-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231111215647.4966-1-luizluca@gmail.com>
References: <20231111215647.4966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

realtek-common had a hard dependency on both switch variants. That way,
it was not possible to selectively load only one model at runtime. Now
variants are registered at the realtek-common module and interface
modules look for a variant using the compatible string.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 125 ++++++++++++++++++++---
 drivers/net/dsa/realtek/realtek-common.h |   3 +
 drivers/net/dsa/realtek/realtek-mdio.c   |   9 +-
 drivers/net/dsa/realtek/realtek-smi.c    |   9 +-
 drivers/net/dsa/realtek/realtek.h        |  36 ++++++-
 drivers/net/dsa/realtek/rtl8365mb.c      |   4 +-
 drivers/net/dsa/realtek/rtl8366rb.c      |   4 +-
 7 files changed, 162 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 36f8b60771be..e383db21c776 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -1,10 +1,76 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 #include "realtek.h"
 #include "realtek-common.h"
 
+static LIST_HEAD(realtek_variants_list);
+static DEFINE_MUTEX(realtek_variants_lock);
+
+void realtek_variant_register(struct realtek_variant_entry *var_ent)
+{
+	mutex_lock(&realtek_variants_lock);
+	list_add_tail(&var_ent->list, &realtek_variants_list);
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_register);
+
+void realtek_variant_unregister(struct realtek_variant_entry *var_ent)
+{
+	mutex_lock(&realtek_variants_lock);
+	list_del(&var_ent->list);
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_unregister);
+
+const struct realtek_variant *realtek_variant_get(
+		const struct of_device_id *match)
+{
+	const struct realtek_variant *var = ERR_PTR(-ENOENT);
+	struct realtek_variant_entry *var_ent;
+	const char *modname = match->data;
+
+	request_module(modname);
+
+	mutex_lock(&realtek_variants_lock);
+	list_for_each_entry(var_ent, &realtek_variants_list, list) {
+		const struct realtek_variant *tmp = var_ent->variant;
+
+		if (strcmp(match->compatible, var_ent->compatible))
+			continue;
+
+		if (!try_module_get(var_ent->owner))
+			break;
+
+		var = tmp;
+		break;
+	}
+	mutex_unlock(&realtek_variants_lock);
+
+	return var;
+}
+EXPORT_SYMBOL_GPL(realtek_variant_get);
+
+void realtek_variant_put(const struct realtek_variant *var)
+{
+	struct realtek_variant_entry *var_ent;
+
+	mutex_lock(&realtek_variants_lock);
+	list_for_each_entry(var_ent, &realtek_variants_list, list) {
+		if (var_ent->variant != var)
+			continue;
+
+		if (var_ent->owner)
+			module_put(var_ent->owner);
+
+		break;
+	}
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_put);
+
 void realtek_common_lock(void *ctx)
 {
 	struct realtek_priv *priv = ctx;
@@ -25,18 +91,30 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 		struct regmap_config rc, struct regmap_config rc_nolock)
 {
 	const struct realtek_variant *var;
+	const struct of_device_id *match;
 	struct realtek_priv *priv;
 	struct device_node *np;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	if (!var)
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data)
 		return ERR_PTR(-EINVAL);
 
+	var = realtek_variant_get(match);
+	if (IS_ERR(var)) {
+		ret = PTR_ERR(var);
+		dev_err_probe(dev, ret,
+			      "failed to get module for '%s'. Is '%s' loaded?",
+			      match->compatible, match->data);
+		goto err_variant_put;
+	}
+
 	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
 			    GFP_KERNEL);
-	if (!priv)
-		return ERR_PTR(-ENOMEM);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_variant_put;
+	}
 
 	mutex_init(&priv->map_lock);
 
@@ -45,14 +123,14 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	if (IS_ERR(priv->map)) {
 		ret = PTR_ERR(priv->map);
 		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ERR_PTR(ret);
+		goto err_variant_put;
 	}
 
 	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
 	if (IS_ERR(priv->map_nolock)) {
 		ret = PTR_ERR(priv->map_nolock);
 		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ERR_PTR(ret);
+		goto err_variant_put;
 	}
 
 	/* Link forward and backward */
@@ -69,23 +147,27 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 
 	/* Fetch MDIO pins */
 	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdc))
-		return ERR_CAST(priv->mdc);
+
+	if (IS_ERR(priv->mdc)) {
+		ret = PTR_ERR(priv->mdc);
+		goto err_variant_put;
+	}
 
 	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdio))
-		return ERR_CAST(priv->mdio);
+	if (IS_ERR(priv->mdio)) {
+		ret = PTR_ERR(priv->mdio);
+		goto err_variant_put;
+	}
 
 	np = dev->of_node;
-
 	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
-
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
 		dev_err(dev, "failed to get RESET GPIO\n");
-		return ERR_CAST(priv->reset);
+		goto err_variant_put;
 	}
 	if (priv->reset) {
 		gpiod_set_value(priv->reset, 1);
@@ -97,13 +179,20 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	}
 
 	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return ERR_PTR(-ENOMEM);
+	if (!priv->ds) {
+		ret = -ENOMEM;
+		goto err_variant_put;
+	}
 
 	priv->ds->dev = dev;
 	priv->ds->priv = priv;
 
 	return priv;
+
+err_variant_put:
+	realtek_variant_put(var);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(realtek_common_probe);
 
@@ -116,6 +205,8 @@ void realtek_common_remove(struct realtek_priv *priv)
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
 
+	realtek_variant_put(priv->variant);
+
 	/* leave the device reset asserted */
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
@@ -124,10 +215,10 @@ EXPORT_SYMBOL(realtek_common_remove);
 
 const struct of_device_id realtek_common_of_match[] = {
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+	{ .compatible = "realtek,rtl8366rb", .data = REALTEK_RTL8366RB_MODNAME, },
 #endif
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{ .compatible = "realtek,rtl8365mb", .data = &rtl8366rb_variant, },
+	{ .compatible = "realtek,rtl8365mb", .data = REALTEK_RTL8365MB_MODNAME, },
 #endif
 	{ /* sentinel */ },
 };
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 90a949386518..089fda2d4fa9 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -12,5 +12,8 @@ void realtek_common_unlock(void *ctx);
 struct realtek_priv *realtek_common_probe(struct device *dev,
 		struct regmap_config rc, struct regmap_config rc_nolock);
 void realtek_common_remove(struct realtek_priv *priv);
+const struct realtek_variant *realtek_variant_get(
+		const struct of_device_id *match);
+void realtek_variant_put(const struct realtek_variant *var);
 
 #endif
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 6f610386c977..6d81cd88dbe6 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -146,7 +146,7 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 	ret = priv->ops->detect(priv);
 	if (ret) {
 		dev_err(dev, "unable to detect switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	priv->ds->num_ports = priv->num_ports;
@@ -155,10 +155,15 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 	if (ret) {
 		dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
 			      ERR_PTR(ret));
-		return ret;
+		goto err_variant_put;
 	}
 
 	return 0;
+
+err_variant_put:
+	realtek_variant_put(priv->variant);
+
+	return ret;
 }
 
 static void realtek_mdio_remove(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 0cf89f9db99e..a772bb7dbe35 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -413,7 +413,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	ret = priv->ops->detect(priv);
 	if (ret) {
 		dev_err(dev, "unable to detect switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	priv->ds->num_ports = priv->num_ports;
@@ -422,10 +422,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err_probe(dev, ret, "unable to register switch ret = %pe\n",
 			      ERR_PTR(ret));
-		return ret;
+		goto err_variant_put;
 	}
 
 	return 0;
+
+err_variant_put:
+	realtek_variant_put(priv->variant);
+
+	return ret;
 }
 
 static void realtek_smi_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 8d9d546bf5f5..f9bd6678e3bd 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -16,6 +16,38 @@
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
 
+#define REALTEK_RTL8365MB_MODNAME	"rtl8365mb"
+#define REALTEK_RTL8366RB_MODNAME	"rtl8366"
+
+struct realtek_variant_entry {
+	const struct realtek_variant *variant;
+	const char *compatible;
+	struct module *owner;
+	struct list_head list;
+};
+
+#define module_realtek_variant(__variant, __compatible)			\
+static struct realtek_variant_entry __variant ## _entry = {		\
+	.compatible = __compatible,					\
+	.variant = &(__variant),					\
+	.owner = THIS_MODULE,						\
+};									\
+static int __init realtek_variant_module_init(void)			\
+{									\
+	realtek_variant_register(&__variant ## _entry);			\
+	return 0;							\
+}									\
+module_init(realtek_variant_module_init)				\
+									\
+static void __exit realtek_variant_module_exit(void)			\
+{									\
+	realtek_variant_unregister(&__variant ## _entry);		\
+}									\
+module_exit(realtek_variant_module_exit)
+
+void realtek_variant_register(struct realtek_variant_entry *var_ent);
+void realtek_variant_unregister(struct realtek_variant_entry *var_ent);
+
 struct realtek_ops;
 struct dentry;
 struct inode;
@@ -120,6 +152,7 @@ struct realtek_ops {
 struct realtek_variant {
 	const struct dsa_switch_ops *ds_ops_smi;
 	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct realtek_variant_info *info;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
@@ -146,7 +179,4 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset);
 void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data);
 
-extern const struct realtek_variant rtl8366rb_variant;
-extern const struct realtek_variant rtl8365mb_variant;
-
 #endif /*  _REALTEK_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0875e4fc9f57..b5b22a4d01eb 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2163,7 +2163,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.phy_write = rtl8365mb_phy_write,
 };
 
-const struct realtek_variant rtl8365mb_variant = {
+static const struct realtek_variant rtl8365mb_variant = {
 	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
 	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
 	.ops = &rtl8365mb_ops,
@@ -2172,7 +2172,7 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
 };
-EXPORT_SYMBOL_GPL(rtl8365mb_variant);
+module_realtek_variant(rtl8365mb_variant, "realtek,rtl8365mb");
 
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index b39b719a5b8f..208a8f17a089 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1911,7 +1911,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 	.phy_write	= rtl8366rb_phy_write,
 };
 
-const struct realtek_variant rtl8366rb_variant = {
+static const struct realtek_variant rtl8366rb_variant = {
 	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
 	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
 	.ops = &rtl8366rb_ops,
@@ -1920,7 +1920,7 @@ const struct realtek_variant rtl8366rb_variant = {
 	.cmd_write = 0xa8,
 	.chip_data_sz = sizeof(struct rtl8366rb),
 };
-EXPORT_SYMBOL_GPL(rtl8366rb_variant);
+module_realtek_variant(rtl8366rb_variant, "realtek,rtl8366rb");
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");
-- 
2.42.1


