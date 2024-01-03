Return-Path: <netdev+bounces-61154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BD822B74
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E4285769
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998718C1B;
	Wed,  3 Jan 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="aibxjvKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7418B1D
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7be1c65dso6811802e87.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1704278074; x=1704882874; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0z8cYO02BrG4qyBa27UqKaO66VHJAlsfrBcR2HkWU8k=;
        b=aibxjvKzvGjh4WkAMihzrfWVcuTvo2CaeM7xOV3h87gp2wamVdG/3XBEaeG3cMF3Pu
         9EF7uZ9QIm0tOG2ztv0iq7662zkz9WhL3Lr17Rjue9weSf3WBu9kqJzFd1Nv+ALnLfAO
         gKgZNg+PDFdENVZ75RFGFhMvoMgktPpjuE9luyuVTSvXklAuJGsDmrAAA3mNQ0f6z0Uq
         G1L48uF2wI96q2wuYNPu1GF26wgSUVPov9wAVaGEg2R+/gLEvEFmFy6SJuhTCDaOKlgN
         q8n9dlxCj96npxTRqZVRWAF8NnSUuY3CJ4s1ftPAc8VBZEzuMXyB/vOND4PbIQk1KBIl
         MYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278074; x=1704882874;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z8cYO02BrG4qyBa27UqKaO66VHJAlsfrBcR2HkWU8k=;
        b=h1vh/2J9/RgWRMDr/Unh017ZJtXgQ+ZrE32/KLK+5Xi2rn2iOJlT6yxnpDK7EYVQrb
         6lQIgTCEoKB1BWjD9iFRsPCI6BhwfH9ycI8n8xOIzBvh039eE+3EPuf9prSEm+YLaWW8
         oOPdAFq+XntU5NoCHCUGBF6QrIuBApqmY+DQ97yuEJXZd7lGM2UvcVKkRFRilHzLErne
         bRQadSUtQ0X4LEsfJXo3gYoyAEX39uEK3/Gh7YzTAubN0PsM+Q08C7PMPZHD1FLimQe5
         DDxPghSFsaiWsAH2hi3i824t0BiGiZXbzgj/JkavK+CFYX91onO2ycFrs4fgLvYZ1Kfu
         wcvw==
X-Gm-Message-State: AOJu0YwUEHqqXTIp7C5M5UgdPM/IqI+AJrl2Gd3fSmSbJXpeTTgmDt5V
	x1H0GnLBrHm+1q6uLCbgRGdOqWaSFV8nBA==
X-Google-Smtp-Source: AGHT+IFSjBICrpsAb95XEDDgsFdhoJNOQoZkbQ7k91kF73NcXemVzGim9riUzjKWbyU6gaQPf6TQeg==
X-Received: by 2002:a05:6512:144:b0:50e:1bf3:628d with SMTP id m4-20020a056512014400b0050e1bf3628dmr6608130lfo.81.1704278073843;
        Wed, 03 Jan 2024 02:34:33 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id p14-20020a05651238ce00b0050e5ae6243dsm3867924lft.295.2024.01.03.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:34:32 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
Date: Wed,  3 Jan 2024 11:33:50 +0100
Message-Id: <20240103103351.1188835-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103103351.1188835-1-tobias@waldekranz.com>
References: <20240103103351.1188835-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Parse LEDs from DT and register them with the kernel, for chips that
support it. No actual implementations exist yet, they will be added in
upcoming commits.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/Makefile |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |   5 +
 drivers/net/dsa/mv88e6xxx/chip.h   |   4 +
 drivers/net/dsa/mv88e6xxx/leds.c   | 195 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/leds.h   |  12 ++
 5 files changed, 217 insertions(+)
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.h

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index a9a9651187db..6720d9303914 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -9,6 +9,7 @@ mv88e6xxx-objs += global2.o
 mv88e6xxx-objs += global2_avb.o
 mv88e6xxx-objs += global2_scratch.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += hwtstamp.o
+mv88e6xxx-objs += leds.o
 mv88e6xxx-objs += pcs-6185.o
 mv88e6xxx-objs += pcs-6352.o
 mv88e6xxx-objs += pcs-639x.o
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6f59..8fab16badc9e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -37,6 +37,7 @@
 #include "global1.h"
 #include "global2.h"
 #include "hwtstamp.h"
+#include "leds.h"
 #include "phy.h"
 #include "port.h"
 #include "ptp.h"
@@ -4006,6 +4007,10 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
+	err = mv88e6xxx_port_setup_leds(ds, port);
+	if (err)
+		return err;
+
 	if (chip->info->ops->pcs_ops &&
 	    chip->info->ops->pcs_ops->pcs_init) {
 		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7..c229e3d6a265 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -206,6 +206,7 @@ struct mv88e6xxx_gpio_ops;
 struct mv88e6xxx_avb_ops;
 struct mv88e6xxx_ptp_ops;
 struct mv88e6xxx_pcs_ops;
+struct mv88e6xxx_led_ops;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -653,6 +654,9 @@ struct mv88e6xxx_ops {
 	/* Precision Time Protocol operations */
 	const struct mv88e6xxx_ptp_ops *ptp_ops;
 
+	/* LED operations */
+	const struct mv88e6xxx_led_ops *led_ops;
+
 	/* Phylink */
 	void (*phylink_get_caps)(struct mv88e6xxx_chip *chip, int port,
 				 struct phylink_config *config);
diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
new file mode 100644
index 000000000000..1f331a632065
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <net/dsa.h>
+
+#include "chip.h"
+#include "port.h"
+
+struct mv88e6xxx_led {
+	struct mv88e6xxx_chip *chip;
+	int port;
+	u8 index;
+
+	struct led_classdev ldev;
+};
+
+struct mv88e6xxx_led_ops {
+	int (*brightness_set)(struct mv88e6xxx_led *led,
+			      enum led_brightness brightness);
+	int (*blink_set)(struct mv88e6xxx_led *led,
+			 unsigned long *delay_on, unsigned long *delay_off);
+	int (*hw_control_is_supported)(struct mv88e6xxx_led *led,
+				       unsigned long flags);
+	int (*hw_control_set)(struct mv88e6xxx_led *led, unsigned long flags);
+	int (*hw_control_get)(struct mv88e6xxx_led *led, unsigned long *flags);
+};
+
+static int mv88e6xxx_led_brightness_set(struct led_classdev *ldev,
+					enum led_brightness brightness)
+{
+	const struct mv88e6xxx_led_ops *ops;
+	struct mv88e6xxx_led *led;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	ops = led->chip->info->ops->led_ops;
+
+	if (!ops->brightness_set)
+		return -EOPNOTSUPP;
+
+	return ops->brightness_set(led, brightness);
+}
+
+static int mv88e6xxx_led_blink_set(struct led_classdev *ldev,
+				   unsigned long *delay_on,
+				   unsigned long *delay_off)
+{
+	const struct mv88e6xxx_led_ops *ops;
+	struct mv88e6xxx_led *led;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	ops = led->chip->info->ops->led_ops;
+
+	if (!ops->blink_set)
+		return -EOPNOTSUPP;
+
+	return ops->blink_set(led, delay_on, delay_off);
+}
+
+static int mv88e6xxx_led_hw_control_is_supported(struct led_classdev *ldev,
+						 unsigned long flags)
+{
+	const struct mv88e6xxx_led_ops *ops;
+	struct mv88e6xxx_led *led;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	ops = led->chip->info->ops->led_ops;
+
+	if (!ops->hw_control_is_supported)
+		return -EOPNOTSUPP;
+
+	return ops->hw_control_is_supported(led, flags);
+}
+
+static int mv88e6xxx_led_hw_control_set(struct led_classdev *ldev,
+					unsigned long flags)
+{
+	const struct mv88e6xxx_led_ops *ops;
+	struct mv88e6xxx_led *led;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	ops = led->chip->info->ops->led_ops;
+
+	if (!ops->hw_control_set)
+		return -EOPNOTSUPP;
+
+	return ops->hw_control_set(led, flags);
+}
+
+static int mv88e6xxx_led_hw_control_get(struct led_classdev *ldev,
+					unsigned long *flags)
+{
+	const struct mv88e6xxx_led_ops *ops;
+	struct mv88e6xxx_led *led;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	ops = led->chip->info->ops->led_ops;
+
+	if (!ops->hw_control_get)
+		return -EOPNOTSUPP;
+
+	return ops->hw_control_get(led, flags);
+}
+
+static struct device *mv88e6xxx_led_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct mv88e6xxx_led *led;
+	struct dsa_port *dp;
+
+	led = container_of(ldev, struct mv88e6xxx_led, ldev);
+	dp = dsa_to_port(led->chip->ds, led->port);
+
+	if (dp && dp->user)
+		return &dp->user->dev;
+
+	return NULL;
+}
+
+static int mv88e6xxx_port_setup_led(struct mv88e6xxx_chip *chip, int port,
+				    struct device_node *np)
+{
+	struct led_init_data init_data = {};
+	struct mv88e6xxx_led *led;
+	char *devname;
+	u32 index;
+	int err;
+
+	err = of_property_read_u32(np, "reg", &index);
+	if (err)
+		return err;
+
+	if (index >= 2)
+		return -EINVAL;
+
+	led = devm_kzalloc(chip->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	*led = (struct mv88e6xxx_led) {
+		.chip = chip,
+		.port = port,
+		.index = index,
+
+		.ldev = {
+			.max_brightness = 1,
+			.brightness_set_blocking = mv88e6xxx_led_brightness_set,
+			.blink_set = mv88e6xxx_led_blink_set,
+
+#ifdef CONFIG_LEDS_TRIGGERS
+			.hw_control_trigger = "netdev",
+			.hw_control_get_device = mv88e6xxx_led_hw_control_get_device,
+
+			.hw_control_is_supported = mv88e6xxx_led_hw_control_is_supported,
+			.hw_control_set = mv88e6xxx_led_hw_control_set,
+			.hw_control_get = mv88e6xxx_led_hw_control_get,
+#endif
+		},
+	};
+
+	devname = devm_kasprintf(chip->dev, GFP_KERNEL, "%s.%d",
+				 dev_name(chip->dev), port);
+	if (!devname)
+		return -ENOMEM;
+
+	init_data = (struct led_init_data) {
+		.fwnode = of_fwnode_handle(np),
+		.devname_mandatory = true,
+		.devicename = devname,
+	};
+
+	return devm_led_classdev_register_ext(chip->dev, &led->ldev, &init_data);
+}
+
+int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct device_node *pnp, *np;
+	int err;
+
+	if (!chip->info->ops->led_ops)
+		return 0;
+
+	if (!dp->dn)
+		return 0;
+
+	pnp = of_get_child_by_name(dp->dn, "leds");
+	if (!pnp)
+		return 0;
+
+	for_each_available_child_of_node(pnp, np) {
+		err = mv88e6xxx_port_setup_led(chip, port, np);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/leds.h b/drivers/net/dsa/mv88e6xxx/leds.h
new file mode 100644
index 000000000000..a99d7a5ebc6d
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/leds.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Marvell 88E6xxx Switch LED support. */
+
+#ifndef _MV88E6XXX_LEDS_H
+#define _MV88E6XXX_LEDS_H
+
+#include "chip.h"
+
+int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port);
+
+#endif /* _MV88E6XXX_LEDS_H */
-- 
2.34.1


