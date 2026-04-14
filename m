Return-Path: <netdev+bounces-278381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE7BAvMW3mlBmwkAu9opvQ
	(envelope-from <netdev+bounces-278381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:29:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EB3F8AF4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE7C30844E5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3C3D3D0C;
	Tue, 14 Apr 2026 10:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330839B486
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162239; cv=none; b=egb22/0MmmiT238g/r7+UNfOxP1sLBXpkOgSTEC8t0FGfDkhMknXqYuFfHgVxDrHeLfKsDvmdMsmXR85mrm7OuALtJWAnQ0dhHX4aRHo0c+j8EIc7CNUlxPKK/VJpcjlu6lQB8vfXLG2xeNggQ4kIAjSoE56R4AGO6OfwSfcQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162239; c=relaxed/simple;
	bh=kXxYyFY2N/cEQFJ8qJDkGUJKJ4FyU6QZbTb+jig8aIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh2bzyvp4hM2biDKOF7WHaZ4NL8PinzdhQ0/Htm5wX6yyuu9KQLV02ehezE2Bq1AH4tJKAbNrepdoClIuObnb7HfQTUkuO8SF/4GpZ8XzbusrYIJqByGCogtTiYseb22qpclr/1rzsOlHkUwckq29GXI5pa50ixlw7B4hu5xN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=crimson.net.eu.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=crimson.net.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3314275f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162229; x=1776767029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agEPNcn5UfOsWzLW0MOgaJUmP7o4DXe8RlSLgKzjHg4=;
        b=lvlid+5GlTpRCzKPEAxI4wBSln6Ti94vW0nZ1nGbaEZRG+cgI4Pb+QCKVPs1pQFI5S
         /MJxqwjESkdof8OeKTvTvfGgl4Enf8/K4qkcOS3KMVpDH9ILAk8WLdhFD13gF/cUCHON
         l6RjgGoNp2XomIROf5/LwVgNeHgbNEDbIDqVVltJcK2K73k6Zi80daD8mwTgUUAz6mV3
         NHBd6guGjOwaqWqmGPhkmRcQ9r3KLwVrnEzMNcIG5Heh0TyyZRYTQha/50F5QLE0sFCM
         /YhFD0+MIu5/cxu1EwgdnVWLEWhEjLTyCumq8qhfqymI4Nr3q3axfRkM+Lahdj1IECd3
         aGuw==
X-Forwarded-Encrypted: i=1; AFNElJ+SkGgMC0gOzTA+/XXQkGXrUj9K2hdxuOT7je+hHPvFzEL7YEEAw1IP/WcepPIUFNJl+1VG6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHIpU+Aud8MUHQQG9borEwISnJJbr9bjeY9a0EPYeVzt6JP+e
	hfSXbgR9a7mro3XWiBgDoNB0wYh1uMOLuILnxJwBQcC0H98X4Y/p92pk
X-Gm-Gg: AeBDietPEnypZFmUyD69m1e40d3Gm4x2CUw10lpuMmaPZABM4rDo9RWCasEDelgSxcl
	i2/JMDQxLn9EfBQ1uKETMry/ihEl2AOCBD7aCNY2qMGGPR0Ouy7po/hFJpOdn2W6G1F+EMdX8VU
	9ZeNo58pjinArjugd+8f97wRGG6XQrxKKN/dzoiWmT8pkLEgwUpg8Kw41e9LNxbMISqskW+DTvl
	murCUy6VC3K7aeTRJZoevO9+l5tSQf60yXEd1XBcUTlBH6yoEptM69quRpXApjAbaYfp4EZ65CN
	O6+yN8itIrgworhMGkVPD7+uLjGQDLDXXoH1UWEagyr+5CCq36wMjpSbdeNz+EOfQdcoJ6ET13c
	Is8HJRCT6fa3bWI8TISypOxpYLNDhUkeXFqvIQDlg8m1kphuqBQYNLkjsB7n07yj2TTB39Sw5Uz
	dkNt5QtMWHRdfMO2auXbsKKVaA8bZWC4jWW0SEdnQRO/iVLTayAfmm/21c+M8arRXW3wWzq1jOu
	5trCU8RlGGyewaukgbQUdWDBuB4lSOFDLmA/HPI4qdQ8xaR/2xd0rUL5VGfEzMCuov/42k=
X-Received: by 2002:a5d:5d83:0:b0:43b:40ef:5d1a with SMTP id ffacd0b85a97d-43d642552e7mr23917731f8f.5.1776162228496;
        Tue, 14 Apr 2026 03:23:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-18-131-221.retail.telecomitalia.it. [79.18.131.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d750f0ca9sm21461453f8f.37.2026.04.14.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:23:48 -0700 (PDT)
From: deep@crimson.net.eu.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	netdev@vger.kernel.org,
	linux-nfc@lists.01.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Kenet Jovan Sokoli <deep@crimson.net.eu.org>
Subject: [PATCH] nfc: s3fwrn5: switch to GPIO descriptor API
Date: Tue, 14 Apr 2026 12:22:57 +0200
Message-ID: <20260414102257.365421-1-deep@crimson.net.eu.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[crimson.net.eu.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278381-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deep@crimson.net.eu.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 777EB3F8AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kenet Jovan Sokoli <deep@crimson.net.eu.org>

I am working on cleaning up some legacy GPIO usage in the NFC subsystem.
This patch converts the s3fwrn5 driver to use the modern descriptor based
GPIO API instead of the old integer based one.

Specifically:
- I changed the gpio_en and gpio_fw_wake types to struct gpio_desc.
- Replaced the manual DT parsing with devm_gpiod_get() in the probe
functions.
- Updated the calls in phy_common.c to use gpiod_set_value().

This also allowed me to remove the s3fwrn5_i2c_parse_dt and
s3fwrn82_uart_parse_dt functions as they are no longer needed with the
new API.

Signed-off-by: Kenet Jovan Sokoli <deep@crimson.net.eu.org>
---
I have verified that this patch builds successfully with "make M=drivers/nfc/s3fwrn5"
"scripts/checkpatch.pl" with no errors or warnings.
This is very complicated stuff, but I am learning a lot by doing these cleanup works.
I really hope I can contribute as much as possible to this environment, little by little.
---
 drivers/nfc/s3fwrn5/i2c.c        | 58 ++++++--------------------------
 drivers/nfc/s3fwrn5/phy_common.c | 12 +++----
 drivers/nfc/s3fwrn5/phy_common.h |  5 +--
 drivers/nfc/s3fwrn5/uart.c       | 43 ++++++-----------------
 4 files changed, 31 insertions(+), 87 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 110d086cfe5b..a629fbcd3237 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -8,9 +8,8 @@
 
 #include <linux/clk.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/module.h>
 
@@ -146,37 +145,6 @@ static irqreturn_t s3fwrn5_i2c_irq_thread_fn(int irq, void *phy_id)
 	return IRQ_HANDLED;
 }
 
-static int s3fwrn5_i2c_parse_dt(struct i2c_client *client)
-{
-	struct s3fwrn5_i2c_phy *phy = i2c_get_clientdata(client);
-	struct device_node *np = client->dev.of_node;
-
-	if (!np)
-		return -ENODEV;
-
-	phy->common.gpio_en = of_get_named_gpio(np, "en-gpios", 0);
-	if (!gpio_is_valid(phy->common.gpio_en)) {
-		/* Support also deprecated property */
-		phy->common.gpio_en = of_get_named_gpio(np,
-							"s3fwrn5,en-gpios",
-							0);
-		if (!gpio_is_valid(phy->common.gpio_en))
-			return -ENODEV;
-	}
-
-	phy->common.gpio_fw_wake = of_get_named_gpio(np, "wake-gpios", 0);
-	if (!gpio_is_valid(phy->common.gpio_fw_wake)) {
-		/* Support also deprecated property */
-		phy->common.gpio_fw_wake = of_get_named_gpio(np,
-							     "s3fwrn5,fw-gpios",
-							     0);
-		if (!gpio_is_valid(phy->common.gpio_fw_wake))
-			return -ENODEV;
-	}
-
-	return 0;
-}
-
 static int s3fwrn5_i2c_probe(struct i2c_client *client)
 {
 	struct s3fwrn5_i2c_phy *phy;
@@ -193,21 +161,17 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
 	phy->i2c_dev = client;
 	i2c_set_clientdata(client, phy);
 
-	ret = s3fwrn5_i2c_parse_dt(client);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_gpio_request_one(&phy->i2c_dev->dev, phy->common.gpio_en,
-				    GPIOF_OUT_INIT_HIGH, "s3fwrn5_en");
-	if (ret < 0)
-		return ret;
-
-	ret = devm_gpio_request_one(&phy->i2c_dev->dev,
-				    phy->common.gpio_fw_wake,
-				    GPIOF_OUT_INIT_LOW, "s3fwrn5_fw_wake");
-	if (ret < 0)
-		return ret;
+	phy->common.gpio_en = devm_gpiod_get(&client->dev, "en", GPIOD_OUT_HIGH);
+	if (IS_ERR(phy->common.gpio_en)) {
+		return dev_err_probe(&client->dev, PTR_ERR(phy->common.gpio_en),
+				"Failed to get EN gpio\n");
+	}
 
+	phy->common.gpio_fw_wake = devm_gpiod_get(&client->dev, "wake", GPIOD_OUT_LOW);
+	if (IS_ERR(phy->common.gpio_fw_wake)) {
+		return dev_err_probe(&client->dev, PTR_ERR(phy->common.gpio_fw_wake),
+			     "Failed to get WAKE gpio\n");
+	}
 	/*
 	 * S3FWRN5 depends on a clock input ("XI" pin) to function properly.
 	 * Depending on the hardware configuration this could be an always-on
diff --git a/drivers/nfc/s3fwrn5/phy_common.c b/drivers/nfc/s3fwrn5/phy_common.c
index deb2c039f0fd..e802b4e609c8 100644
--- a/drivers/nfc/s3fwrn5/phy_common.c
+++ b/drivers/nfc/s3fwrn5/phy_common.c
@@ -8,7 +8,7 @@
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 
@@ -19,7 +19,7 @@ void s3fwrn5_phy_set_wake(void *phy_id, bool wake)
 	struct phy_common *phy = phy_id;
 
 	mutex_lock(&phy->mutex);
-	gpio_set_value(phy->gpio_fw_wake, wake);
+	gpiod_set_value(phy->gpio_fw_wake, wake);
 	if (wake)
 		msleep(S3FWRN5_EN_WAIT_TIME);
 	mutex_unlock(&phy->mutex);
@@ -33,14 +33,14 @@ bool s3fwrn5_phy_power_ctrl(struct phy_common *phy, enum s3fwrn5_mode mode)
 
 	phy->mode = mode;
 
-	gpio_set_value(phy->gpio_en, 1);
-	gpio_set_value(phy->gpio_fw_wake, 0);
+	gpiod_set_value(phy->gpio_en, 1);
+	gpiod_set_value(phy->gpio_fw_wake, 0);
 	if (mode == S3FWRN5_MODE_FW)
-		gpio_set_value(phy->gpio_fw_wake, 1);
+		gpiod_set_value(phy->gpio_fw_wake, 1);
 
 	if (mode != S3FWRN5_MODE_COLD) {
 		msleep(S3FWRN5_EN_WAIT_TIME);
-		gpio_set_value(phy->gpio_en, 0);
+		gpiod_set_value(phy->gpio_en, 0);
 		msleep(S3FWRN5_EN_WAIT_TIME);
 	}
 
diff --git a/drivers/nfc/s3fwrn5/phy_common.h b/drivers/nfc/s3fwrn5/phy_common.h
index 9cef25436bf9..10210a8fd755 100644
--- a/drivers/nfc/s3fwrn5/phy_common.h
+++ b/drivers/nfc/s3fwrn5/phy_common.h
@@ -13,6 +13,7 @@
 
 #include <linux/mutex.h>
 #include <net/nfc/nci_core.h>
+#include <linux/gpio/consumer.h>
 
 #include "s3fwrn5.h"
 
@@ -21,8 +22,8 @@
 struct phy_common {
 	struct nci_dev *ndev;
 
-	int gpio_en;
-	int gpio_fw_wake;
+	struct gpio_desc *gpio_en;
+	struct gpio_desc *gpio_fw_wake;
 
 	struct mutex mutex;
 
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 4ee481bd7e96..5a7c7741a881 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -15,8 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/serdev.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include "phy_common.h"
 
@@ -92,25 +91,6 @@ static const struct of_device_id s3fwrn82_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, s3fwrn82_uart_of_match);
 
-static int s3fwrn82_uart_parse_dt(struct serdev_device *serdev)
-{
-	struct s3fwrn82_uart_phy *phy = serdev_device_get_drvdata(serdev);
-	struct device_node *np = serdev->dev.of_node;
-
-	if (!np)
-		return -ENODEV;
-
-	phy->common.gpio_en = of_get_named_gpio(np, "en-gpios", 0);
-	if (!gpio_is_valid(phy->common.gpio_en))
-		return -ENODEV;
-
-	phy->common.gpio_fw_wake = of_get_named_gpio(np, "wake-gpios", 0);
-	if (!gpio_is_valid(phy->common.gpio_fw_wake))
-		return -ENODEV;
-
-	return 0;
-}
-
 static int s3fwrn82_uart_probe(struct serdev_device *serdev)
 {
 	struct s3fwrn82_uart_phy *phy;
@@ -144,20 +124,19 @@ static int s3fwrn82_uart_probe(struct serdev_device *serdev)
 
 	serdev_device_set_flow_control(serdev, false);
 
-	ret = s3fwrn82_uart_parse_dt(serdev);
-	if (ret < 0)
-		goto err_serdev;
-
-	ret = devm_gpio_request_one(&phy->ser_dev->dev, phy->common.gpio_en,
-				    GPIOF_OUT_INIT_HIGH, "s3fwrn82_en");
-	if (ret < 0)
+	phy->common.gpio_en = devm_gpiod_get(&serdev->dev, "en", GPIOD_OUT_HIGH);
+	if (IS_ERR(phy->common.gpio_en)) {
+		ret = dev_err_probe(&serdev->dev, PTR_ERR(phy->common.gpio_en),
+			     "failed to get en gpio\n");
 		goto err_serdev;
+	}
 
-	ret = devm_gpio_request_one(&phy->ser_dev->dev,
-				    phy->common.gpio_fw_wake,
-				    GPIOF_OUT_INIT_LOW, "s3fwrn82_fw_wake");
-	if (ret < 0)
+	phy->common.gpio_fw_wake = devm_gpiod_get(&serdev->dev, "wake", GPIOD_OUT_LOW);
+	if (IS_ERR(phy->common.gpio_fw_wake)) {
+		ret = dev_err_probe(&serdev->dev, PTR_ERR(phy->common.gpio_fw_wake),
+			     "failed to get wake gpio\n");
 		goto err_serdev;
+	}
 
 	ret = s3fwrn5_probe(&phy->common.ndev, phy, &phy->ser_dev->dev,
 			    &uart_phy_ops);
-- 
2.43.0


