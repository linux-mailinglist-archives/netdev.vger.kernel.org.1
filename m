Return-Path: <netdev+bounces-61155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1128822B75
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E872B2300A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBE118C36;
	Wed,  3 Jan 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="IcQeZH0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA318C0A
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso7316783e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1704278075; x=1704882875; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5p4U+CfifRWwnsl6AVEgiVKTyZ0ns/QlnQnlplasOY=;
        b=IcQeZH0slQ65rBPUGbNnkPc+1XpccubHTRYrpRqSqGvGWlQfvNXABQ1IozSe5VOQE2
         x67XaI6h2MyfzKK4sm3CJtUBH0ihb/VK6ZwaF6l3alf22iz3qQIx0OhnoB5qnO6k5HJP
         JPfH9uM4fRsycsN/FMBOnLFnMhpYkn0SRJu4o0lhKpyH32HXPxrAztg0U1MePznJ3tio
         gowpvlYPXH6VbpNBWUjyjAQTediIvSgm6jzY6z8aoQRFmWyNSbbvulHh5BLsFnuNSKU8
         NsjhXzV205/TyM1ZscKtHsn8hRu3sZPWQjq0CJxZoSLFv/ZP1V40Ng0MY0hSZWUyblNl
         C2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278075; x=1704882875;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5p4U+CfifRWwnsl6AVEgiVKTyZ0ns/QlnQnlplasOY=;
        b=dpPDQXbaorUGC+MF0/CbV0Y6IxRZAKvMFz70+hf92ATf8Sg9rRkCwlk1Da7Oa5tKPo
         ZpTUX8gsqcYNFvhi5thq528nVMTFzIr2dUPCKUeDeuaCEzB/JKHEY/GTCu/7x6GTN+h5
         ugtnzer8rUcVzNBKUfqJjPEoIF81L1W+5zBpmxrXy3eT6dA31dUZ8ng3SgUtIxFl1iA5
         EOkEO+xQ67yu01sQdHHvgGq9+VeZBi55qWt8ThsGPwi78tfv0roW8zLyutrOcvWdrszP
         Vjx1die8VZr/lSjdf2yA2w1CXbnm02w4Xb3rXTpKErp6iCxrl10rmwp78+7zM23aEx8V
         yT+w==
X-Gm-Message-State: AOJu0Yxob6GMCCdsu+ifSX6/H5xJfIkwtHgW3TzGky+mpPQzygESyyh9
	ilEcktgUCBzRxkMLST+S9n9ql1+hJhrG5Q==
X-Google-Smtp-Source: AGHT+IGZYrHPQqxdahIC6W5htu7tok4dgldaA28d0im3sdRDCZ6idGAaAGJ/UfEkTXDhORVCKQWFVQ==
X-Received: by 2002:a05:6512:3c98:b0:50e:7615:d34e with SMTP id h24-20020a0565123c9800b0050e7615d34emr7906689lfv.22.1704278075066;
        Wed, 03 Jan 2024 02:34:35 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id p14-20020a05651238ce00b0050e5ae6243dsm3867924lft.295.2024.01.03.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:34:34 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Add LED support for 6393X
Date: Wed,  3 Jan 2024 11:33:51 +0100
Message-Id: <20240103103351.1188835-3-tobias@waldekranz.com>
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

Trigger support:
- "none"
- "timer"
- "netdev"

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   1 +
 drivers/net/dsa/mv88e6xxx/leds.c | 227 +++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/leds.h |   2 +
 drivers/net/dsa/mv88e6xxx/port.c |  33 +++++
 drivers/net/dsa/mv88e6xxx/port.h |   7 +
 5 files changed, 270 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8fab16badc9e..f43dc863999a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5495,6 +5495,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
+	.led_ops = &mv88e6393x_led_ops,
 	.phylink_get_caps = mv88e6393x_phylink_get_caps,
 	.pcs_ops = &mv88e6393x_pcs_ops,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 1f331a632065..f964b3a7a3e7 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -4,6 +4,13 @@
 #include "chip.h"
 #include "port.h"
 
+#define FLAG_ACT      (BIT(TRIGGER_NETDEV_RX) | BIT(TRIGGER_NETDEV_TX))
+#define FLAG_LINK     BIT(TRIGGER_NETDEV_LINK)
+#define FLAG_LINK_10  BIT(TRIGGER_NETDEV_LINK_10)
+#define FLAG_LINK_100 BIT(TRIGGER_NETDEV_LINK_100)
+#define FLAG_LINK_1G  BIT(TRIGGER_NETDEV_LINK_1000)
+#define FLAG_FULL     BIT(TRIGGER_NETDEV_FULL_DUPLEX)
+
 struct mv88e6xxx_led {
 	struct mv88e6xxx_chip *chip;
 	int port;
@@ -23,6 +30,226 @@ struct mv88e6xxx_led_ops {
 	int (*hw_control_get)(struct mv88e6xxx_led *led, unsigned long *flags);
 };
 
+enum mv88e6393x_led_mode {
+	MV88E6393X_LED_MODE_BLINK = 0xd,
+	MV88E6393X_LED_MODE_OFF = 0xe,
+	MV88E6393X_LED_MODE_ON = 0xf,
+
+	MV88E6393X_LED_MODES = 0x10
+};
+
+static const unsigned long mv88e6393x_led_map_p1_p8[2][MV88E6393X_LED_MODES] = {
+	{
+		[0x1] = FLAG_ACT | FLAG_LINK_100 | FLAG_LINK_1G,
+		[0x2] = FLAG_ACT | FLAG_LINK_1G,
+		[0x3] = FLAG_ACT | FLAG_LINK,
+		[0x6] = FLAG_FULL,
+		[0x7] = FLAG_ACT | FLAG_LINK_10 | FLAG_LINK_1G,
+		[0x8] = FLAG_LINK,
+		[0x9] = FLAG_LINK_10,
+		[0xa] = FLAG_ACT | FLAG_LINK_10,
+		[0xb] = FLAG_LINK_100 | FLAG_LINK_1G,
+	},
+	{
+		[0x1] = FLAG_ACT,
+		[0x2] = FLAG_ACT | FLAG_LINK_10 | FLAG_LINK_100,
+		[0x3] = FLAG_LINK_1G,
+		[0x5] = FLAG_ACT | FLAG_LINK,
+		[0x6] = FLAG_ACT | FLAG_LINK_10 | FLAG_LINK_1G,
+		[0x7] = FLAG_LINK_10 | FLAG_LINK_1G,
+		[0x9] = FLAG_LINK_100,
+		[0xa] = FLAG_ACT | FLAG_LINK_100,
+		[0xb] = FLAG_LINK_10 | FLAG_LINK_100,
+	}
+};
+
+static const unsigned long mv88e6393x_led_map_p9_p10[2][MV88E6393X_LED_MODES] = {
+	{
+		[0x1] = FLAG_ACT | FLAG_LINK,
+	},
+	{
+		[0x6] = FLAG_FULL,
+		[0x7] = FLAG_ACT | FLAG_LINK,
+		[0x8] = FLAG_LINK,
+	}
+};
+
+const unsigned long *mv88e6393x_led_map(struct mv88e6xxx_led *led)
+{
+	switch (led->port) {
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+		return mv88e6393x_led_map_p1_p8[led->index];
+	case 9:
+	case 10:
+		return mv88e6393x_led_map_p9_p10[led->index];
+	}
+
+	return NULL;
+}
+
+static int mv88e6393x_led_flags_to_mode(struct mv88e6xxx_led *led, unsigned long flags)
+{
+	const unsigned long *map = mv88e6393x_led_map(led);
+	int i;
+
+	if (!map)
+		return -ENODEV;
+
+	if (!flags)
+		return MV88E6393X_LED_MODE_OFF;
+
+	for (i = 0; i < MV88E6393X_LED_MODES; i++) {
+		if (map[i] == flags)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int mv88e6393x_led_mode_to_flags(struct mv88e6xxx_led *led, u8 mode,
+					unsigned long *flags)
+{
+	const unsigned long *map = mv88e6393x_led_map(led);
+
+	if (!map)
+		return -ENODEV;
+
+	if (mode == MV88E6393X_LED_MODE_OFF) {
+		*flags = 0;
+		return 0;
+	}
+
+	if (map[mode]) {
+		*flags = map[mode];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int mv88e6393x_led_set(struct mv88e6xxx_led *led, int mode)
+{
+	u16 ctrl;
+	int err;
+
+	if (mode < 0)
+		return mode;
+
+	mv88e6xxx_reg_lock(led->chip);
+
+	err = mv88e6393x_port_led_read(led->chip, led->port, 0, &ctrl);
+	if (err)
+		goto out;
+
+	switch (led->index) {
+	case 0:
+		ctrl &= ~0x0f;
+		ctrl |= mode;
+		break;
+	case 1:
+		ctrl &= ~0xf0;
+		ctrl |= mode << 4;
+	}
+
+	err = mv88e6393x_port_led_write(led->chip, led->port, 0, ctrl);
+out:
+	mv88e6xxx_reg_unlock(led->chip);
+	return err;
+}
+
+static int mv88e6393x_led_get(struct mv88e6xxx_led *led)
+{
+	u16 ctrl;
+	int err;
+
+	mv88e6xxx_reg_lock(led->chip);
+	err = mv88e6393x_port_led_read(led->chip, led->port, 0, &ctrl);
+	mv88e6xxx_reg_unlock(led->chip);
+	if (err)
+		return err;
+
+	switch (led->index) {
+	case 0:
+		return ctrl & 0xf;
+	case 1:
+		return (ctrl >> 4) & 0xf;
+	}
+
+	return -EINVAL;
+}
+
+static int mv88e6393x_led_brightness_set(struct mv88e6xxx_led *led,
+					 enum led_brightness brightness)
+{
+	if (brightness == LED_OFF)
+		return mv88e6393x_led_set(led, MV88E6393X_LED_MODE_OFF);
+
+	return mv88e6393x_led_set(led, MV88E6393X_LED_MODE_ON);
+}
+
+static int mv88e6393x_led_blink_set(struct mv88e6xxx_led *led,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	int err;
+
+	/* Defer anything other than 50% duty cycles to software */
+	if (*delay_on != *delay_off)
+		return -EINVAL;
+
+	/* Reject values outside ~20% of our default rate (84ms) */
+	if (*delay_on && ((*delay_on < 30) || (*delay_on > 50)))
+		return -EINVAL;
+
+	err = mv88e6393x_led_set(led, MV88E6393X_LED_MODE_BLINK);
+	if (!err)
+		*delay_on = *delay_off = 42;
+
+	return err;
+}
+
+static int mv88e6393x_led_hw_control_is_supported(struct mv88e6xxx_led *led,
+						  unsigned long flags)
+{
+	int mode = mv88e6393x_led_flags_to_mode(led, flags);
+
+	return (mode < 0) ? mode : 0;
+}
+
+static int mv88e6393x_led_hw_control_set(struct mv88e6xxx_led *led,
+					 unsigned long flags)
+{
+	int mode = mv88e6393x_led_flags_to_mode(led, flags);
+
+	return mv88e6393x_led_set(led, mode);
+}
+
+static int mv88e6393x_led_hw_control_get(struct mv88e6xxx_led *led,
+					 unsigned long *flags)
+{
+	int mode = mv88e6393x_led_get(led);
+
+	if (mode < 0)
+		return mode;
+
+	return mv88e6393x_led_mode_to_flags(led, mode, flags);
+}
+
+const struct mv88e6xxx_led_ops mv88e6393x_led_ops = {
+	.brightness_set = mv88e6393x_led_brightness_set,
+	.blink_set = mv88e6393x_led_blink_set,
+	.hw_control_is_supported = mv88e6393x_led_hw_control_is_supported,
+	.hw_control_set = mv88e6393x_led_hw_control_set,
+	.hw_control_get = mv88e6393x_led_hw_control_get,
+};
+
 static int mv88e6xxx_led_brightness_set(struct led_classdev *ldev,
 					enum led_brightness brightness)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/leds.h b/drivers/net/dsa/mv88e6xxx/leds.h
index a99d7a5ebc6d..c7de16ce4dde 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.h
+++ b/drivers/net/dsa/mv88e6xxx/leds.h
@@ -7,6 +7,8 @@
 
 #include "chip.h"
 
+extern const struct mv88e6xxx_led_ops mv88e6393x_led_ops;
+
 int mv88e6xxx_port_setup_leds(struct dsa_switch *ds, int port);
 
 #endif /* _MV88E6XXX_LEDS_H */
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..66073a1ef260 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1539,6 +1539,39 @@ int mv88e6351_port_set_ether_type(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ETH_TYPE, etype);
 }
 
+/* Offset 0x16: LED Control Register */
+
+int mv88e6393x_port_led_write(struct mv88e6xxx_chip *chip, int port,
+			      unsigned int pointer, u16 data)
+{
+	u16 cmd = BIT(15) | ((pointer & 0x7) << 12) | (data & 0x7ff);
+	int err;
+
+	err = mv88e6xxx_port_write(chip, port, MV88E6393X_PORT_LED_CONTROL, cmd);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_wait_bit(chip, port, MV88E6393X_PORT_LED_CONTROL, 15, 0);
+}
+
+int mv88e6393x_port_led_read(struct mv88e6xxx_chip *chip, int port,
+			     unsigned int pointer, u16 *data)
+{
+	u16 cmd = (pointer & 0x7) << 12;
+	int err;
+
+	err = mv88e6xxx_port_write(chip, port, MV88E6393X_PORT_LED_CONTROL, cmd);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6393X_PORT_LED_CONTROL, &cmd);
+	if (err)
+		return err;
+
+	*data = cmd & 0x7ff;
+	return 0;
+}
+
 /* Offset 0x18: Port IEEE Priority Remapping Registers [0-3]
  * Offset 0x19: Port IEEE Priority Remapping Registers [4-7]
  */
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 86deeb347cbc..3605a59d1399 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -294,6 +294,9 @@
 /* Offset 0x13: OutFiltered Counter */
 #define MV88E6XXX_PORT_OUT_FILTERED	0x13
 
+/* Offset 0x16: LED Control Register */
+#define MV88E6393X_PORT_LED_CONTROL	0x16
+
 /* Offset 0x18: IEEE Priority Mapping Table */
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE			0x18
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_UPDATE		0x8000
@@ -410,6 +413,10 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 			       enum mv88e6xxx_policy_action action);
 int mv88e6351_port_set_ether_type(struct mv88e6xxx_chip *chip, int port,
 				  u16 etype);
+int mv88e6393x_port_led_write(struct mv88e6xxx_chip *chip, int port,
+			      unsigned int pointer, u16 data);
+int mv88e6393x_port_led_read(struct mv88e6xxx_chip *chip, int port,
+			     unsigned int pointer, u16 *data);
 int mv88e6393x_set_egress_port(struct mv88e6xxx_chip *chip,
 			       enum mv88e6xxx_egress_direction direction,
 			       int port);
-- 
2.34.1


