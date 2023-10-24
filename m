Return-Path: <netdev+bounces-44002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA07D5CC8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7511C202D5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA333CCE4;
	Tue, 24 Oct 2023 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ5MD12F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A232C852
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:58:49 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715110E5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:58:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cac925732fso32885025ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698181119; x=1698785919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GGDURy9U9mjy/0Q/rtph0AJvgDV8lMe/NUApwLQAq3w=;
        b=DJ5MD12FMncNos5UPVWUE9THeKtl0fxoxKWcwj5AqTq/F9GA9USgoNm8Da432Rluqe
         vj+t1VY7DbR0mighYuypgPPeKqVo4pfWeDNP9qVPaAwUyPox+Vb65uC5eHcK/FQ5a00W
         bVkYcm0yMsS45PsltZu/0gMbrCTIsfS5ZPgj/xVUa1comn/0ydk3uFW9h9hxBKWaCj2B
         7fFRmmIeDvcpduj0fMP4na4RTt5s2ZujIL8FiCX0u8NbBwtYHc7Oo3rTRFToR6tbs3B7
         0HLzWVMkXOK5EkhpUemX5Lzf1+9maG+GPZNRSpZ2WShK/CzIM+EKkMHvEG8C+a2oQNdO
         rLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181119; x=1698785919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGDURy9U9mjy/0Q/rtph0AJvgDV8lMe/NUApwLQAq3w=;
        b=KQLOErqOi0ZfINeEaeUAW11k39PpmUV1Yy3uXWgi49WEfUQYBfZQSbUNzBZCdcAyR2
         o6Hp6tuCoegRVR+XoIIlVKsJd0Gg6MR+aSqR6J2T0sEfC9Lqc5LV6IubtwY3FhAfowbF
         bmOCfNxCgd0/im8zYO/xRq4ip26MeMrSH+HQaFt3WAKEbnii0H+QVjBo/qPDskFBzAI4
         I5qGozweLVqDCKlaNe0CTYrECRrBbTLinwJliOeEtgLE4ZsJUVBKWtgGERWapPp8qyHc
         5NGjpbTWviHZ+TzbKTQVNcNdkugA3pExHeA4BLK9DkLJ01aDugLSoTFoPDkYahqHrTA5
         ApZQ==
X-Gm-Message-State: AOJu0YwiOhI0A9ENEWdrmKaUZOoDz8eGTz55pCAAGD9okAJeyKXSvVZV
	dlhV4rXyTwYTLuWJM96UMtnmaEeJiqU/Xg==
X-Google-Smtp-Source: AGHT+IGX+b4oFPwqezkyVocNVfEbGb4sUjtGFtI/6rgOmWCPfbpTKzO3tL5I+SV6V70L+YU5lO6mgg==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id n13-20020a170903110d00b001c9e508ad43mr12320669plh.8.1698181119249;
        Tue, 24 Oct 2023 13:58:39 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id je17-20020a170903265100b001c728609574sm7894803plb.6.2023.10.24.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:58:38 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Date: Tue, 24 Oct 2023 17:58:04 -0300
Message-ID: <20231024205805.19314-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'reset-gpios' will not work when the switch reset is controlled by a
reset controller.

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset state was asserted, the driver will
not detect it.

This is an example of how to use the reset controller:

        switch {
                compatible = "realtek,rtl8366rb";

                resets = <&rst 8>;
                reset-names = "switch";

		...
	}

The reset controller will take precedence over the reset GPIO.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c | 36 +++++++++++++++++++++-----
 drivers/net/dsa/realtek/realtek-smi.c  | 34 +++++++++++++++++++-----
 drivers/net/dsa/realtek/realtek.h      |  6 +++++
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..600124c58c00 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -140,6 +140,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
+static int realtek_mdio_hwreset(struct realtek_priv *priv, bool active)
+{
+#ifdef CONFIG_RESET_CONTROLLER
+	if (priv->reset_ctl) {
+		if (active)
+			return reset_control_assert(priv->reset_ctl);
+		else
+			return reset_control_deassert(priv->reset_ctl);
+	}
+#endif
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, active);
+
+	return 0;
+}
+
 static int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv;
@@ -194,20 +211,26 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 
 	dev_set_drvdata(dev, priv);
 
-	/* TODO: if power is software controlled, set up any regulators here */
 	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
 
+#ifdef CONFIG_RESET_CONTROLLER
+	priv->reset_ctl = devm_reset_control_get(dev, "switch");
+	if (IS_ERR(priv->reset_ctl)) {
+		dev_err(dev, "failed to get switch reset control\n");
+		return PTR_ERR(priv->reset_ctl);
+	}
+#endif
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(priv->reset);
 	}
-
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		realtek_mdio_hwreset(priv, 1);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		realtek_mdio_hwreset(priv, 0);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -246,8 +269,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	dsa_unregister_switch(priv->ds);
 
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_mdio_hwreset(priv, 1);
 }
 
 static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index bfd11591faf4..751159d71223 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -408,6 +408,23 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static int realtek_smi_hwreset(struct realtek_priv *priv, bool active)
+{
+#ifdef CONFIG_RESET_CONTROLLER
+	if (priv->reset_ctl) {
+		if (active)
+			return reset_control_assert(priv->reset_ctl);
+		else
+			return reset_control_deassert(priv->reset_ctl);
+	}
+#endif
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, active);
+
+	return 0;
+}
+
 static int realtek_smi_probe(struct platform_device *pdev)
 {
 	const struct realtek_variant *var;
@@ -457,18 +474,24 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->lock);
 
-	/* TODO: if power is software controlled, set up any regulators here */
+#ifdef CONFIG_RESET_CONTROLLER
+	priv->reset_ctl = devm_reset_control_get(dev, "switch");
+	if (IS_ERR(priv->reset_ctl)) {
+		dev_err(dev, "failed to get switch reset control\n");
+		return PTR_ERR(priv->reset_ctl);
+	}
+#endif
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(priv->reset);
 	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		realtek_smi_hwreset(priv, 1);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		realtek_smi_hwreset(priv, 0);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -518,8 +541,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
 		of_node_put(priv->slave_mii_bus->dev.of_node);
 
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_smi_hwreset(priv, 1);
 }
 
 static void realtek_smi_shutdown(struct platform_device *pdev)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 4fa7c6ba874a..ad61e5c13f96 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,9 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#ifdef CONFIG_RESET_CONTROLLER
+#include <linux/reset.h>
+#endif
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -48,6 +51,9 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+#ifdef CONFIG_RESET_CONTROLLER
+	struct reset_control    *reset_ctl;
+#endif
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
-- 
2.42.0


