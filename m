Return-Path: <netdev+bounces-47213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A17E8CF7
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281091C2083F
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C31DFE1;
	Sat, 11 Nov 2023 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0qXo6Av"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E91DFCC
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 21:57:31 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905D2737
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:30 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f084cb8b54so1958243fac.1
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739847; x=1700344647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRjCguQAxTRUszaUSoLu66y6AGiagR4ChKN9bUhcBHA=;
        b=A0qXo6AvjNdZFyOdF0decwPmiAtsL9lFPS2fpOpwXh3jXxobnItNoXItmdbmnKg6v8
         0psUmioi4X8ivnVcvKyaEJ/t2z2POfivKLzmWMspCzbAUxSgd3RATHiIjphAkLYfvr8f
         k3C/2eGlVs1ZHchBFpN2MyqSogZ9HZKdVeU5Heu4jmqmP546ngCAzcunBd9o3xruG6jK
         LAJxyh60/JlucCAnun1T3O4X9lIyD4D5FJoRPiJ0Y6Grx+Fi3p0K1aELyHD1imLt76Zt
         mXPrpdVnu/ntqstt30toGQw1Q+ZVhZ7Cje5sYtFvObGZDEsKILS4P57mOF29VBwQhDji
         SQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739847; x=1700344647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRjCguQAxTRUszaUSoLu66y6AGiagR4ChKN9bUhcBHA=;
        b=bnWPQZx7l77D+ckuIrt8fuY7Q3CAlGN+NyrRHy0ObhfwnPskcOdJNrNAhGvTfjAJci
         4rI7kV5XuxQklRSJKGeEAKgffvS/LhH1sk3lrih7GItQTiJ1o49unliXTB5tJN1X1BEL
         e66x0xLwvaWq0KAuzxca6cUbRnAnuIYC9A6xYyDkgZRyWicFShAmU4Vyi7+my/1bJgbv
         oShCh1s2m24ka7/uurp60F1lN3FEONc6bhohOukmBHpnBJm0A9HisrU+QuobgKuWjcI7
         5gtOu+iPxuXZB4i3x4PUG9wJV7semLCa5Foe37y6F8XEDA79mmiCpDbnpoQUSBE1Su4X
         BHBg==
X-Gm-Message-State: AOJu0YzejVHyX3575ua/HnDP+1b8EXhE375rRc2/igoSqFxxgyqvdbla
	P4Hlg0kzb3C5+hONMipez1RqZs1yPCdd+w==
X-Google-Smtp-Source: AGHT+IGoe11qaQ8DN/FV0G43cfoq1hxrrxCWElchiV8BSrMUwjkYz1kvqI1sTUT3duIGh0cn1CHiaw==
X-Received: by 2002:a05:6871:4087:b0:1ea:ce71:dd12 with SMTP id kz7-20020a056871408700b001eace71dd12mr4359904oab.3.1699739847594;
        Sat, 11 Nov 2023 13:57:27 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:27 -0800 (PST)
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
Subject: [RFC net-next 5/5] net: dsa: realtek: support reset controller
Date: Sat, 11 Nov 2023 18:51:08 -0300
Message-ID: <20231111215647.4966-6-luizluca@gmail.com>
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

The 'reset-gpios' will not work when the switch reset is controlled by a
reset controller.

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset state was asserted, the driver will
not detect it.

The reset controller will take precedence over the reset GPIO.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 53 +++++++++++++++++++++---
 drivers/net/dsa/realtek/realtek-common.h |  3 ++
 drivers/net/dsa/realtek/realtek.h        |  2 +
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index e383db21c776..1450e5c206c3 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -163,17 +163,25 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		dev_err_probe(dev, ret, "failed to get reset control\n");
+		goto err_variant_put;
+	}
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		ret = PTR_ERR(priv->reset);
 		dev_err(dev, "failed to get RESET GPIO\n");
 		goto err_variant_put;
 	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+
+	if (priv->reset_ctl || priv->reset) {
+		realtek_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		realtek_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -208,11 +216,46 @@ void realtek_common_remove(struct realtek_priv *priv)
 	realtek_variant_put(priv->variant);
 
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_reset_assert(priv);
 }
 EXPORT_SYMBOL(realtek_common_remove);
 
+void realtek_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_assert(priv->reset_ctl);
+		if (!ret)
+			return;
+
+		dev_warn(priv->dev,
+			 "Failed to assert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, true);
+}
+
+void realtek_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_deassert(priv->reset_ctl);
+		if (!ret)
+			return;
+
+		dev_warn(priv->dev,
+			 "Failed to deassert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, false);
+}
+
 const struct of_device_id realtek_common_of_match[] = {
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
 	{ .compatible = "realtek,rtl8366rb", .data = REALTEK_RTL8366RB_MODNAME, },
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 089fda2d4fa9..603b4f9891d3 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -16,4 +16,7 @@ const struct realtek_variant *realtek_variant_get(
 		const struct of_device_id *match);
 void realtek_variant_put(const struct realtek_variant *var);
 
+void realtek_reset_assert(struct realtek_priv *priv);
+void realtek_reset_deassert(struct realtek_priv *priv);
+
 #endif
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index f9bd6678e3bd..86f33327155b 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#include <linux/reset.h>
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -80,6 +81,7 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+	struct reset_control    *reset_ctl;
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
-- 
2.42.1


