Return-Path: <netdev+bounces-224295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82764B83896
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6733F7219C9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432492FAC15;
	Thu, 18 Sep 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ACt1tF6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C452F9DA7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184452; cv=none; b=fWdvyLyF2DyVjL+N/isidmhdC7ftWkSVNzrmjTJKbIceWq73RcO31AAbjhyAgCZi1c2CBADpcvoe2RR770vmdd4ch+PpZhd7YVB4iw2QRV5E0Ttk+ouZZa2pPaC0AfjUBz4yicyhaGJJHrMwy6O4TnoMHIeF39Lbm8Ry9QrnpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184452; c=relaxed/simple;
	bh=+Ahr5oNqxXsasI3EQWXo7mCLrNIvdckTiHF6ZxjDajA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4YjsgS4LVrXMJRFm4E1Bpd+4q/xeYkXE8cUVN3D/2SchlCTTyu5qFknLxM7xmeyc9wVhfNE1DuqC/1AOM/7IGPAl02XPPmUjASveAt4TTRs9yhmYhGCSQS3Q1F1hWoYdoMmg8EZuDN7H+ESQxqJLWOy78BnYqL+S9hYhK4+Hfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ACt1tF6s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF67E1A0E03;
	Thu, 18 Sep 2025 08:34:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 969506062C;
	Thu, 18 Sep 2025 08:34:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9F17102F1CBF;
	Thu, 18 Sep 2025 10:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EY6yVymLZMeFS52uP2yzPDRoqRTf9+mNLzBhVGM2Bzs=;
	b=ACt1tF6s5DtutmaB8W/6DxpovK/rpF/26Te+HqVmJULQzZ2S7K3LWQDMeQ+NJpSrVucIZG
	5fOVi9vjbsBuoqIYvWUnBZCO5j1JFQlUqTSW+0D5ZngqmWGctN11H3YqWoeWSQohv1zuLj
	7Z/qEeNIMwkmqD+QwLYdEdekFcAsKHY78adlEjwg8+Wrx2Dw0OUTAeOY2wRdcqKJx5uVTV
	8XBS0Q8xglxsnSp6/t2FsWc41SYs7NlY53o3DopcUV8SXI4q4YP+MiJb7PXQBvaBre6IRd
	nQnrCZ8KxrBIONpaMbvurn/yUd1iFZTaPtPlyu/B53HxmAQn0HKRZKLT3J71Kg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 18 Sep 2025 10:33:52 +0200
Subject: [PATCH net-next v3 3/3] net: dsa: microchip: Set SPI as bus
 interface during reset for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ksz-strap-pins-v3-3-16662e881728@bootlin.com>
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
In-Reply-To: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At reset, the KSZ8463 uses a strap-based configuration to set SPI as
bus interface. SPI is the only bus supported by the driver. If the
required pull-ups/pull-downs are missing (by mistake or by design to
save power) the pins may float and the configuration can go wrong
preventing any communication with the switch.

Introduce a ksz8463_configure_straps_spi() function called during the
device reset. It relies on the 'straps-rxd-gpios' OF property and the
'reset' pinmux configuration to enforce SPI as bus interface.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7cac3a0d88bb51339cc287f56ca1d1f..3bfa894d62eecc08dc45b25225e1122fe30b8f99 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -23,6 +23,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <net/dsa.h>
 #include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
@@ -5338,6 +5339,38 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 	return 0;
 }
 
+static int ksz8463_configure_straps_spi(struct ksz_device *dev)
+{
+	struct pinctrl *pinctrl;
+	struct gpio_desc *rxd0;
+	struct gpio_desc *rxd1;
+
+	rxd0 = devm_gpiod_get_index_optional(dev->dev, "straps-rxd", 0, GPIOD_OUT_LOW);
+	if (IS_ERR(rxd0))
+		return PTR_ERR(rxd0);
+
+	rxd1 = devm_gpiod_get_index_optional(dev->dev, "straps-rxd", 1, GPIOD_OUT_HIGH);
+	if (IS_ERR(rxd1))
+		return PTR_ERR(rxd1);
+
+	if (!rxd0 && !rxd1)
+		return 0;
+
+	if ((rxd0 && !rxd1) || (rxd1 && !rxd0))
+		return -EINVAL;
+
+	pinctrl = devm_pinctrl_get_select(dev->dev, "reset");
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
+
+	return 0;
+}
+
+static int ksz8463_release_straps_spi(struct ksz_device *dev)
+{
+	return pinctrl_select_default_state(dev->dev);
+}
+
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
@@ -5353,10 +5386,22 @@ int ksz_switch_register(struct ksz_device *dev)
 		return PTR_ERR(dev->reset_gpio);
 
 	if (dev->reset_gpio) {
+		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
+			ret = ksz8463_configure_straps_spi(dev);
+			if (ret)
+				return ret;
+		}
+
 		gpiod_set_value_cansleep(dev->reset_gpio, 1);
 		usleep_range(10000, 12000);
 		gpiod_set_value_cansleep(dev->reset_gpio, 0);
 		msleep(100);
+
+		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
+			ret = ksz8463_release_straps_spi(dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	mutex_init(&dev->dev_mutex);

-- 
2.51.0


