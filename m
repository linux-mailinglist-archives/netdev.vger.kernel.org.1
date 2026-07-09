Return-Path: <netdev+bounces-306026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VfLoCqP+TmqFYgIAu9opvQ
	(envelope-from <netdev+bounces-306026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2D72BC4A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YSyh6Txm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306026-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306026-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B41830A7797
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700452773CA;
	Thu,  9 Jul 2026 01:48:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B929993D
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:48:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561720; cv=none; b=XDjVxCcKm+Dwc0N376QNPWuHdZZInS1tJb0/s4lLGZFRCzCv0UpfcRELTT3B0VqCkT9OAa0DXYY0QOYdkM+wOyEAmDnjZSJ5yc+DAoHvH0UGB/RwzZmkPbyKWFruu57fSJ1vyA71vOWxVH9s49tDCR0xMeXGUBtdi0k0d60lYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561720; c=relaxed/simple;
	bh=77ET45/u+tGpzXLJTEjRqziP+9h4f5+VeoeoAOs4t7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoZgbnkptClTbnRsX4uPVuOlJEcUfpB4ffrV2PP/zEEwsdoNEzkRtmxKEMILVpRoMQTg0UJOS4Gdkq6xb2xFt/DK5SOlzKHPeIky70G7tyagYhDBgTk9e4N1kCBEiTPEnO4EdcNjPp+gdNysG+GTXcWEOocjRAHB4yQ130N1zYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSyh6Txm; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8454160043aso1305661b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783561717; x=1784166517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1okkwpJKXqhws1QsnXbRv18ICG+i2iq6WuO119x050=;
        b=YSyh6Txmoj85EsicBow4Z3WuEnzp/2dazGAxx6avUknTLTPh9fYFK4j3PNE8qB8LO7
         rb8iSi4Z/YkZuKrqeOpkhjT9TpAdnn9kyQPwb6x1O0S2UmhmXTpPSBS2hL1gxQAkBKJR
         1oDZYRNxvD4+hnvewPCb6U2q8+wJx1Bxj8EHrHUzgsBqNvn0RtzKZLrYpfRWSLCfDiAR
         2pb9mfuWAGrljpVwRKd0K9yxefFIf3zgu4k/C5/iKue7qpApY1eym+e2urJvoddTKR1h
         hrTLlj//NQexsRp/L61YxwVZLLq+EUSCDVxOE5PpLjfDretlSBpDaw/y/O+4UJyu+N1E
         Phiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561717; x=1784166517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m1okkwpJKXqhws1QsnXbRv18ICG+i2iq6WuO119x050=;
        b=ieMJzk508x+I0RdssjFRSY4Cy7WU0UXWeqJI7G3CHGxyhl8rW2fRFG81tk066mNE8c
         1lifYJg+7RKwfQFzEUtS4v0thKeTTedO5gxIAHyVriQrfmx3kKNExndNXO4ZKbFrnb7q
         uXDSrZ6w8FzFeuL8YCkiSCn+Qm7lG4ZIh/7BaLPXWpeQn/OEvqCYwxLEn2BWmF2cF7Kj
         PeoVJGGwGELz7ME+dWVgZ5lWReBzxhUFLUs/e7H+JvGn9hnerxxx7+/VfjQkY63iVrdo
         MUUnFyfeIbL2zTw/B/MwE78rMU3YCf4p2MbFQGepwsh0E/fdUqa8sPeBKU/yFi7FgO1K
         fusg==
X-Gm-Message-State: AOJu0YxGDyT48X/3bZXw+GMWDOWhdSWun4FxySJzy68YEEO5InTWgNqg
	GkNlCVEjPCWrZTgu5YK1AR+QqSJdmU7t8LTAZxKq/8O2Whdo3gV7i2v6S1jRQG2H
X-Gm-Gg: AfdE7cnYkUKb67HquvXQoljvm5wbQtYDRHBJfqVSfdrLswDrFSCrurQhib3Rwd7Dz/h
	fEYqvX92VdEM2o6lH2ow5/zXkOGa4ucyhctAkB16ZPcWNNJfkphfBkgKLpCXxGi3l2vsRF8kDnt
	N9egLZHtOmw+IwFRpOST8wFwlecEdW1grOhW9WgY+Hjfzz9VMyoqxLWiY2v7lbPKI0DsYj6Mh+0
	QGJXoxJ1jA3nBkzURxNGjvOw1eBbtRcgMbWv1maYgw0IZE9bYOIUXFn/vlP2u5jntLCoEArBcu1
	Qnlu2WvCeb5L4e1pflbxlyI10h7yY8Gg/oPRLKOpIDlnee655lmHmx9y1aUV8mlgrHVpfUl0wmb
	MmkGfGMELQWyk72L4UF4qF0/v8n6oostDwGFQhBzbMP3Q9xV5ZGoEQjK0GGKfvfkiNs8zIqI+js
	Ghf3U2QodHPaA6tfjORAKBLaggasJs4QsWjdfiW6c=
X-Received: by 2002:a05:6a00:4405:b0:845:ebe2:c656 with SMTP id d2e1a72fcca58-84842fec34cmr5100571b3a.47.1783561717077;
        Wed, 08 Jul 2026 18:48:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm8072434b3a.17.2026.07.08.18.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:48:36 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/3] net: dsa: motorcomm: Add LED support
Date: Thu,  9 Jul 2026 09:47:47 +0800
Message-ID: <20260709014812.1158178-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709014812.1158178-1-mmyangfl@gmail.com>
References: <20260709014812.1158178-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306026-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EB2D72BC4A

LEDs can be described in the device tree using the same format as qca8k.
Each port can configure up to 3 LEDs.

Currently, only parallel mode and strict 1:1 mapping are supported.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Kconfig  |   9 +
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   |  13 +-
 drivers/net/dsa/motorcomm/chip.h   |  14 +-
 drivers/net/dsa/motorcomm/leds.c   | 630 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h   | 121 ++++++
 6 files changed, 785 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 1fddd386f866..3438e0b14361 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -6,3 +6,12 @@ config NET_DSA_YT921X
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
+
+config NET_DSA_YT921X_LEDS
+	bool "LED support for Motorcomm YT9215"
+	default y
+	depends on NET_DSA_YT921X
+	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X
+	help
+	  This enables support for controlling the LEDs attached to the
+	  Motorcomm YT9215 switch chips.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 6cea5313a444..5a63db0029ff 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: ISC
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
+yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 6dee25b6754a..553efacd4f5e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/pkt_cls.h>
 
 #include "chip.h"
+#include "leds.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -151,8 +152,6 @@ static const struct yt921x_info yt921x_infos[] = {
 	{}
 };
 
-#define YT921X_NAME	"yt921x"
-
 #define YT921X_VID_UNWARE	4095
 
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
@@ -4581,6 +4580,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	res = yt921x_leds_setup(priv);
+	if (res)
+		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
+#endif
+
 	return 0;
 }
 
@@ -4681,6 +4686,10 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	yt921x_leds_remove(priv);
+#endif
+
 	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
 		struct yt921x_port *pp = &priv->ports[i];
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 555046526669..6570ae5902ad 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -850,8 +850,13 @@ enum yt921x_fdb_entry_status {
 #define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
 #define YT921X_UDF_NUM		8
 
+#define YT921X_LED_GROUP_NUM	3
+
 /* 8 internal + 2 external + 1 mcu */
-#define YT921X_PORT_NUM			11
+#define YT921X_PORT_NUM		11
+#define YT921X_PORT_MCU		10
+
+#define YT921X_NAME	"yt921x"
 
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
@@ -938,6 +943,13 @@ struct yt921x_port {
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	unsigned char led_duty;
+	unsigned short led_cycle;
+
+	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
+#endif
 };
 
 struct yt921x_reg_ops {
diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
new file mode 100644
index 000000000000..46749b57fee3
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -0,0 +1,630 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/uleds.h>
+
+#include "chip.h"
+#include "leds.h"
+#include "smi.h"
+
+#define to_yt921x_led(led_cdev) \
+	container_of_const((led_cdev), struct yt921x_led, cdev)
+#define to_yt921x_port(led) ((led)->port)
+#define to_yt921x_priv(pp) \
+	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
+#define to_device(priv) ((priv)->ds.dev)
+
+static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
+{
+	switch (group) {
+	case 0:
+	default:
+		return YT921X_LED0_PORTn(port);
+	case 1:
+		return YT921X_LED1_PORTn(port);
+	case 2:
+		return YT921X_LED2_PORTn(port);
+	}
+}
+
+static int
+yt921x_led_force_get(struct yt921x_priv *priv, int port, int group, bool *onp)
+{
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	*onp = (val & YT921X_LED2_PORT_FORCEn_M(group)) ==
+	       YT921X_LED2_PORT_FORCEn_ON(group);
+	return 0;
+}
+
+static int
+yt921x_led_force_set(struct yt921x_priv *priv, int port, int group, bool on)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_led *led = pp->leds[group];
+	u32 ctrl;
+	u32 mask;
+
+	led->use_cycle = false;
+	led->use_duty = false;
+
+	mask = YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
+	       YT921X_LED2_PORT_FORCEn_OFF(group);
+	return yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port), mask,
+				      ctrl);
+}
+
+static int
+yt921x_led_blink_select(const struct yt921x_priv *priv, unsigned long on,
+			unsigned long off, unsigned short *cyclep,
+			unsigned char *dutyp)
+{
+	static const unsigned char dutys[] = {
+		YT921X_LED_DUTY(1, 6),
+		YT921X_LED_DUTY(1, 4),
+		YT921X_LED_DUTY(1, 3),
+		YT921X_LED_DUTY(1, 2),
+	};
+	unsigned int cycle_upper;
+	unsigned int cycle_req;
+	unsigned int duty_req;
+	unsigned int cycle;
+	unsigned int duty;
+
+	cycle = YT921X_LED_BLINK_MAX;
+	cycle_upper = cycle * 11585 / 8192 + 1;  /* M_SQRT2 * cycle */
+	if (check_add_overflow(on, off, &cycle_req) || cycle_req >= cycle_upper)
+		return -EOPNOTSUPP;
+
+	for (; cycle > YT921X_LED_BLINK_MIN; cycle_upper >>= 1, cycle >>= 1)
+		if (cycle_req >= cycle_upper >> 1)
+			break;
+	*cyclep = cycle;
+
+	duty_req = DIV_ROUND_CLOSEST(YT921X_LED_DUTY_DENOM *
+				     (on > off ? off : on), cycle_req);
+	for (unsigned int i = ARRAY_SIZE(dutys) - 1;; i--)
+		if (i == 0 || duty_req >= (dutys[i - 1] + dutys[i]) / 2) {
+			duty = dutys[i];
+			break;
+		}
+	if (on > off)
+		duty = YT921X_LED_DUTY_DENOM - duty;
+	*dutyp = duty;
+
+	return 0;
+}
+
+static int
+yt921x_led_blink_set(struct yt921x_priv *priv, int port, int group,
+		     unsigned long *onp, unsigned long *offp)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_led *led = pp->leds[group];
+	unsigned short cycle;
+	unsigned char duty;
+	bool use_cycle;
+	u32 ctrl;
+	u32 mask;
+	u32 val;
+	int res;
+
+	if (!*onp && !*offp) {
+		cycle = YT921X_LED_BLINK_DEF;
+		duty = YT921X_LED_DUTY(1, 2);
+		for (unsigned int i = 0; i < YT921X_LED_GROUP_NUM; i++)
+			if (i != group && pp->leds[i] &&
+			    pp->leds[i]->use_duty) {
+				duty = pp->led_duty;
+				break;
+			}
+
+		use_cycle = false;
+	} else {
+		bool change_cycle;
+		bool change_duty;
+
+		res = yt921x_led_blink_select(priv, *onp, *offp, &cycle, &duty);
+		if (res)
+			return res;
+
+		use_cycle = cycle < YT921X_LED_BLINK_DEF;
+		change_cycle = use_cycle && cycle != pp->led_cycle;
+		change_duty = duty != pp->led_duty;
+		if (change_cycle || change_duty)
+			for (unsigned int i = 0; i < YT921X_LED_GROUP_NUM;
+			     i++) {
+				if (i == group || !pp->leds[i])
+					continue;
+				if ((change_cycle && pp->leds[i]->use_cycle) ||
+				    (change_duty && pp->leds[i]->use_duty))
+					return -EOPNOTSUPP;
+			}
+	}
+
+	/* The chip seems to jam a while if changing duty directly */
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	ctrl = val & ~YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl |= YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+	if (val != ctrl) {
+		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+		if (res)
+			return res;
+	}
+
+	mask = YT921X_LED1_PORT_BLINK_DUTY_M | YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	switch (duty >= YT921X_LED_DUTY(1, 2) ? duty :
+		YT921X_LED_DUTY_DENOM - duty) {
+	default:
+		duty = YT921X_LED_DUTY(1, 2);
+		fallthrough;
+	case YT921X_LED_DUTY(1, 2):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_1_2;
+		break;
+	case YT921X_LED_DUTY(2, 3):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_2_3;
+		break;
+	case YT921X_LED_DUTY(3, 4):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_3_4;
+		break;
+	case YT921X_LED_DUTY(5, 6):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_5_6;
+		break;
+	}
+	if (duty < YT921X_LED_DUTY(1, 2))
+		ctrl |= YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	if (use_cycle) {
+		mask |= YT921X_LED1_PORT_OTHER_BLINK_M;
+		ctrl |= YT921X_LED1_PORT_OTHER_BLINK(9 - __fls(cycle));
+	}
+	res = yt921x_reg_update_bits(priv, YT921X_LED1_PORTn(port), mask, ctrl);
+	if (res)
+		return res;
+
+	ctrl = val & ~(YT921X_LED2_PORT_FORCEn_M(group) |
+		       YT921X_LED2_PORT_FORCE_BLINKn_M(group));
+	ctrl |= YT921X_LED2_PORT_FORCEn_BLINK(group);
+	if (use_cycle)
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn_OTHER(group);
+	else
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn(group, __fls(cycle) - 9);
+	res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+	if (res)
+		return res;
+
+	led->use_cycle = use_cycle;
+	if (use_cycle)
+		pp->led_cycle = cycle;
+	led->use_duty = true;
+	pp->led_duty = duty;
+
+	*onp = DIV_ROUND_CLOSEST(duty * cycle, YT921X_LED_DUTY_DENOM);
+	*offp = cycle - *onp;
+	return 0;
+}
+
+struct yt921x_led_trigger_map {
+	unsigned long flags;
+	u32 mask;
+};
+
+static const struct yt921x_led_trigger_map yt921x_led_trigger_maps[] = {
+	{BIT(TRIGGER_NETDEV_LINK),
+	 YT921X_LEDx_PORT_ACT_DUPLEX_HALF | YT921X_LEDx_PORT_ACT_DUPLEX_FULL},
+	{BIT(TRIGGER_NETDEV_LINK_10), YT921X_LEDx_PORT_ACT_10M},
+	{BIT(TRIGGER_NETDEV_LINK_100), YT921X_LEDx_PORT_ACT_100M},
+	{BIT(TRIGGER_NETDEV_LINK_1000), YT921X_LEDx_PORT_ACT_1000M},
+	{BIT(TRIGGER_NETDEV_HALF_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_HALF},
+	{BIT(TRIGGER_NETDEV_FULL_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_FULL},
+	{BIT(TRIGGER_NETDEV_TX), YT921X_LEDx_PORT_ACT_TX_BLINK},
+	{BIT(TRIGGER_NETDEV_RX), YT921X_LEDx_PORT_ACT_RX_BLINK},
+	{BIT(TRIGGER_NETDEV_TX_ERR) | BIT(TRIGGER_NETDEV_RX_ERR),
+	 YT921X_LEDx_PORT_ACT_COLLISION_BLINK},
+};
+
+static bool
+yt921x_led_trigger_is_supported(const struct yt921x_priv *priv, int port,
+				int group, unsigned long flags)
+{
+	if (!flags)
+		return true;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((flags & map->flags) == map->flags) {
+			flags &= ~map->flags;
+			if (!flags)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int
+yt921x_led_trigger_get(struct yt921x_priv *priv, int port, int group,
+		       unsigned long *flagsp)
+{
+	u32 addr;
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	if ((val & YT921X_LED2_PORT_FORCEn_M(group)) !=
+	    YT921X_LED2_PORT_FORCEn_DONTCARE(group)) {
+		*flagsp = 0;
+		return 0;
+	}
+
+	if (group != 2) {
+		addr = yt921x_led_regaddr(priv, port, group);
+		res = yt921x_reg_read(priv, addr, &val);
+		if (res)
+			return res;
+	}
+
+	*flagsp = 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((val & map->mask) == map->mask)
+			*flagsp |= map->flags;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_led_trigger_set(struct yt921x_priv *priv, int port, int group,
+		       unsigned long flags)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_led *led = pp->leds[group];
+	u32 addr;
+	u32 ctrl;
+	u32 mask;
+	int res;
+
+	ctrl = 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((flags & map->flags) == map->flags) {
+			flags &= ~map->flags;
+			ctrl |= map->mask;
+			if (!flags)
+				break;
+		}
+	}
+	if (flags)
+		return -EOPNOTSUPP;
+
+	led->use_cycle = false;
+	led->use_duty = false;
+
+	mask = !group ? YT921X_LED0_PORT_ACT_M : YT921X_LEDx_PORT_ACT_M;
+	if (group == 2) {
+		mask |= YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl |= YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+	}
+	addr = yt921x_led_regaddr(priv, port, group);
+	res = yt921x_reg_update_bits(priv, addr, mask, ctrl);
+	if (res)
+		return res;
+
+	if (group != 2) {
+		mask = YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl = YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+		res = yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_cled_brightness_set_blocking(struct led_classdev *led_cdev,
+				    enum led_brightness brightness)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_force_set(priv, pp->index, led->group, brightness);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_cled_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
+		      unsigned long *delay_off)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_blink_set(priv, pp->index, led->group, delay_on,
+				   delay_off);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static struct device * __maybe_unused
+yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(&priv->ds, pp->index);
+	if (!dp || !dp->user)
+		return NULL;
+	return &dp->user->dev;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_is_supported(struct led_classdev *led_cdev,
+				    unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+
+	if (yt921x_led_trigger_is_supported(priv, pp->index, led->group, flags))
+		return 0;
+	return -EOPNOTSUPP;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_get(struct led_classdev *led_cdev, unsigned long *flagsp)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_get(priv, pp->index, led->group, flagsp);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_set(struct led_classdev *led_cdev, unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_set(priv, pp->index, led->group, flags);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_led_setup(struct yt921x_priv *priv, int port,
+		 struct fwnode_handle *fwnode, u32 *inv_maskp, u32 *inv_ctrlp)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct led_init_data init_data;
+	struct led_classdev *led_cdev;
+	char name[LED_MAX_NAME_SIZE];
+	enum led_default_state state;
+	struct yt921x_led *led;
+	bool force_high;
+	bool force_low;
+	int polarity;
+	u32 group;
+	bool on;
+	int res;
+
+	if (port == YT921X_PORT_MCU) {
+		dev_err(dev, "No LEDs for port %d\n", port);
+		return -ENODEV;
+	}
+
+	res = fwnode_property_read_u32(fwnode, "reg", &group);
+	if (res)
+		return res;
+	if (group >= YT921X_LED_GROUP_NUM) {
+		dev_err(dev, "Invalid LED reg %u for port %d\n", group, port);
+		return -EINVAL;
+	}
+	if (pp->leds[group])
+		return -EEXIST;
+
+	force_high = fwnode_property_read_bool(fwnode, "active-high");
+	force_low = fwnode_property_read_bool(fwnode, "active-low");
+	if (force_high && force_low) {
+		dev_err(dev, "Duplicate polarities for LED %02d:%02u\n",
+			port, group);
+		return -EINVAL;
+	}
+	polarity = force_high ? 1 : force_low ? -1 : 0;
+
+	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+	led->port = pp;
+	led->group = group;
+
+	state = led_init_default_state_get(fwnode);
+
+	mutex_lock(&priv->reg_lock);
+	pp->leds[group] = led;
+	switch (state) {
+	case LEDS_DEFSTATE_OFF:
+	case LEDS_DEFSTATE_ON:
+	default:
+		on = state == LEDS_DEFSTATE_ON;
+		res = yt921x_led_force_set(priv, port, group, on);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		res = yt921x_led_force_get(priv, port, group, &on);
+		break;
+	}
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		goto err;
+
+	led_cdev = &led->cdev;
+	led_cdev->brightness = on;
+	led_cdev->max_brightness = 1;
+	led_cdev->flags = LED_RETAIN_AT_SHUTDOWN;
+	led_cdev->brightness_set_blocking = yt921x_cled_brightness_set_blocking;
+	led_cdev->blink_set = yt921x_cled_blink_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_cdev->hw_control_trigger = "netdev";
+	led_cdev->hw_control_get_device = yt921x_cled_hw_control_get_device;
+	led_cdev->hw_control_is_supported = yt921x_cled_hw_control_is_supported;
+	led_cdev->hw_control_get = yt921x_cled_hw_control_get;
+	led_cdev->hw_control_set = yt921x_cled_hw_control_set;
+#endif
+
+	snprintf(name, sizeof(name), YT921X_NAME "-%u:%02d:%02u",
+		 priv->ds.index, port, group);
+	init_data = (typeof(init_data)){
+		.fwnode = fwnode,
+		.devicename = name,
+		.devname_mandatory = true,
+	};
+	res = devm_led_classdev_register_ext(dev, led_cdev, &init_data);
+	if (res)
+		goto err;
+
+	if (polarity) {
+		u32 bit = YT921X_LED_PAR_INV_INVnm(group, port);
+
+		*inv_maskp |= bit;
+		if (polarity > 0)
+			*inv_ctrlp |= bit;
+	}
+	return 0;
+
+err:
+	mutex_lock(&priv->reg_lock);
+	pp->leds[group] = NULL;
+	mutex_unlock(&priv->reg_lock);
+
+	devm_kfree(dev, led);
+	return res;
+}
+
+void yt921x_leds_remove(struct yt921x_priv *priv)
+{
+	struct device *dev = to_device(priv);
+
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		for (int group = 0; group < YT921X_LED_GROUP_NUM; group++) {
+			struct yt921x_led *led = pp->leds[group];
+
+			if (led)
+				devm_led_classdev_unregister(dev, &led->cdev);
+		}
+
+		for (int group = 0; group < YT921X_LED_GROUP_NUM; group++) {
+			struct yt921x_led *led = pp->leds[group];
+
+			if (led) {
+				pp->leds[group] = NULL;
+				devm_kfree(dev, led);
+			}
+		}
+	}
+}
+
+int yt921x_leds_setup(struct yt921x_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	u32 inv_ctrl = 0;
+	u32 inv_mask = 0;
+	u32 ctrl;
+	u32 mask;
+	int res;
+
+	dsa_switch_for_each_port(dp, ds) {
+		struct device_node *leds_np;
+		int port = dp->index;
+
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np)
+			continue;
+
+		for_each_child_of_node_scoped(leds_np, led_np) {
+			res = yt921x_led_setup(priv, port,
+					       of_fwnode_handle(led_np),
+					       &inv_mask, &inv_ctrl);
+			if (res) {
+				of_node_put(leds_np);
+				goto err;
+			}
+		}
+
+		of_node_put(leds_np);
+	}
+
+	mutex_lock(&priv->reg_lock);
+
+	mask = YT921X_LED_CTRL_MODE_M | YT921X_LED_CTRL_PORT_NUM_M |
+	       YT921X_LED_CTRL_EN;
+	ctrl = YT921X_LED_CTRL_MODE_PARALLEL |
+	       YT921X_LED_CTRL_PORT_NUM(YT921X_PORT_NUM - 1) |
+	       YT921X_LED_CTRL_EN;
+	res = yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl);
+	if (res)
+		goto end;
+
+	/* Inversion is internal - force on will give low logic.
+	 * In the rest of the file, treat LEDs as if active-low.
+	 */
+	if (inv_mask)
+		res = yt921x_reg_update_bits(priv, YT921X_LED_PAR_INV, inv_mask,
+					     inv_ctrl);
+
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		goto err;
+
+	return 0;
+
+err:
+	yt921x_leds_remove(priv);
+	return res;
+}
diff --git a/drivers/net/dsa/motorcomm/leds.h b/drivers/net/dsa/motorcomm/leds.h
new file mode 100644
index 000000000000..67373a190c8f
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_LEDS_H
+#define _YT_LEDS_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/kconfig.h>
+#include <linux/leds.h>
+
+#define YT921X_LED_CTRL			0xd0000
+#define  YT921X_LED_CTRL_EN			BIT(21)
+#define  YT921X_LED_CTRL_LOOPDETECT_BLINK_M	GENMASK(20, 19)	/* cycle = 512 * x ms */
+#define   YT921X_LED_CTRL_LOOPDETECT_BLINK(x)		FIELD_PREP(YT921X_LED_CTRL_LOOPDETECT_BLINK_M, (x))
+#define  YT921X_LED_CTRL_PORT_NUM_M		GENMASK(16, 13)
+#define   YT921X_LED_CTRL_PORT_NUM(x)			FIELD_PREP(YT921X_LED_CTRL_PORT_NUM_M, (x))
+#define  YT921X_LED_CTRL_MODE_M			GENMASK(1, 0)
+#define   YT921X_LED_CTRL_MODE(x)			FIELD_PREP(YT921X_LED_CTRL_MODE_M, (x))
+#define   YT921X_LED_CTRL_MODE_PARALLEL			YT921X_LED_CTRL_MODE(0)
+#define   YT921X_LED_CTRL_MODE_SERIAL			YT921X_LED_CTRL_MODE(2)
+#define YT921X_LED0_PORTn(port)		(0xd0004 + 4 * (port))
+#define  YT921X_LED0_PORT_ACT_M			GENMASK(17, 0)
+#define  YT921X_LED0_PORT_ACT_LINK_TRY_DIS	BIT(17)
+#define  YT921X_LED0_PORT_ACT_COLLISION_BLINK_INDI	BIT(16)
+#define YT921X_LED1_PORTn(port)		(0xd0040 + 4 * (port))
+#define  YT921X_LED1_PORT_OTHER_BLINK_M		GENMASK(31, 30)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_OTHER_BLINK(x)		FIELD_PREP(YT921X_LED1_PORT_OTHER_BLINK_M, (x))
+#define  YT921X_LED1_PORT_EEE_BLINK_M		GENMASK(29, 28)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_EEE_BLINK(x)			FIELD_PREP(YT921X_LED1_PORT_EEE_BLINK_M, (x))
+#define  YT921X_LED1_PORT_BLINK_DUTY_COMP	BIT(27)
+#define  YT921X_LED1_PORT_BLINK_DUTY_M		GENMASK(26, 25)
+#define   YT921X_LED1_PORT_BLINK_DUTY(x)		FIELD_PREP(YT921X_LED1_PORT_BLINK_DUTY_M, (x))
+#define   YT921X_LED1_PORT_BLINK_DUTY_1_2		YT921X_LED1_PORT_BLINK_DUTY(0)
+#define   YT921X_LED1_PORT_BLINK_DUTY_2_3		YT921X_LED1_PORT_BLINK_DUTY(1)
+#define   YT921X_LED1_PORT_BLINK_DUTY_3_4		YT921X_LED1_PORT_BLINK_DUTY(2)
+#define   YT921X_LED1_PORT_BLINK_DUTY_5_6		YT921X_LED1_PORT_BLINK_DUTY(3)
+#define YT921X_LED2_PORTn(port)		(0xd0080 + 4 * (port))
+#define  YT921X_LED2_PORT_FORCEn_M(grp)		GENMASK(4 * (grp) + 19, 4 * (grp) + 18)
+#define   YT921X_LED2_PORT_FORCEn(grp, x)		((x) << (4 * (grp) + 18))
+#define   YT921X_LED2_PORT_FORCEn_DONTCARE(grp)		YT921X_LED2_PORT_FORCEn(grp, 0)
+#define   YT921X_LED2_PORT_FORCEn_BLINK(grp)		YT921X_LED2_PORT_FORCEn(grp, 1)
+#define   YT921X_LED2_PORT_FORCEn_ON(grp)		YT921X_LED2_PORT_FORCEn(grp, 2)
+#define   YT921X_LED2_PORT_FORCEn_OFF(grp)		YT921X_LED2_PORT_FORCEn(grp, 3)
+#define  YT921X_LED2_PORT_FORCE_BLINKn_M(grp)	GENMASK(4 * (grp) + 17, 4 * (grp) + 16)	/* cycle = 512 << x ms */
+#define   YT921X_LED2_PORT_FORCE_BLINKn(grp, x)		((x) << (4 * (grp) + 16))
+#define   YT921X_LED2_PORT_FORCE_BLINKn_OTHER(grp)	YT921X_LED2_PORT_FORCE_BLINKn(grp, 3)
+#define  YT921X_LEDx_PORT_ACT_M			GENMASK(15, 0)
+#define  YT921X_LEDx_PORT_ACT_EEE_BLINK		BIT(15)
+#define  YT921X_LEDx_PORT_ACT_LOOPDETECT_BLINK	BIT(14)
+#define  YT921X_LEDx_PORT_ACT_ACTIVE_BLINK	BIT(13)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_FULL	BIT(12)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_HALF	BIT(11)
+#define  YT921X_LEDx_PORT_ACT_TX_BLINK		BIT(10)
+#define  YT921X_LEDx_PORT_ACT_RX_BLINK		BIT(9)
+#define  YT921X_LEDx_PORT_ACT_TX		BIT(8)
+#define  YT921X_LEDx_PORT_ACT_RX		BIT(7)
+#define  YT921X_LEDx_PORT_ACT_1000M		BIT(6)
+#define  YT921X_LEDx_PORT_ACT_100M		BIT(5)
+#define  YT921X_LEDx_PORT_ACT_10M		BIT(4)
+#define  YT921X_LEDx_PORT_ACT_COLLISION_BLINK	BIT(3)
+#define  YT921X_LEDx_PORT_ACT_1000M_BLINK	BIT(2)
+#define  YT921X_LEDx_PORT_ACT_100M_BLINK	BIT(1)
+#define  YT921X_LEDx_PORT_ACT_10M_BLINK		BIT(0)
+#define YT921X_LED_SER_CTRL		0xd0100
+#define  YT921X_LED_SER_CTRL_UNK		GENMASK(25, 24)	/* delay? */
+#define  YT921X_LED_SER_CTRL_ACTIVE_LOW		BIT(4)
+#define  YT921X_LED_SER_CTRL_GRP_NUM_M		GENMASK(1, 0)	/* #grp - 1 */
+#define   YT921X_LED_SER_CTRL_GRP_NUM(x)		FIELD_PREP(YT921X_LED_SER_CTRL_GRP_NUM_M, (x))
+#define YT921X_LED_SER_MAPnm(grp, port)	(0xd0104 + 8 * (2 - (grp)) + 4 * ((port) / 5))
+#define  YT921X_LED_SER_MAP_DSTn_PORT_M(port)	GENMASK(6 * ((port) % 5) + 5, 6 * ((port) % 5) + 2)
+#define   YT921X_LED_SER_MAP_DSTn_PORT(port, x)		((x) << (6 * ((port) % 5) + 2))
+#define  YT921X_LED_SER_MAP_DSTn_LED_M(port)	GENMASK(6 * ((port) % 5) + 1, 6 * ((port) % 5))
+#define   YT921X_LED_SER_MAP_DSTn_LED(port, x)		((x) << (6 * ((port) % 5)))
+#define YT921X_LED_PAR_PORTS		0xd01c4
+#define YT921X_LED_PAR_INV		0xd01c8
+#define  YT921X_LED_PAR_INV_INVnm(grp, port)	BIT(10 * (grp) + (port))
+#define YT921X_LED_PAR_MAPn(port)	(0xd01d0 + 4 * (port))
+#define  YT921X_LED_PAR_MAP_DSTn_PORT_M(grp)	GENMASK(6 * (grp) + 5, 6 * (grp) + 2)
+#define   YT921X_LED_PAR_MAP_DSTn_PORT(grp, x)		((x) << (6 * (grp) + 2))
+#define  YT921X_LED_PAR_MAP_DSTn_LED_M(grp)	GENMASK(6 * (grp) + 1, 6 * (grp))
+#define   YT921X_LED_PAR_MAP_DSTn_LED(grp, x)		((x) << (6 * (grp)))
+
+#define YT921X_LED_BLINK_MIN	64
+#define YT921X_LED_BLINK_DEF	512
+#define YT921X_LED_BLINK_MAX	2048
+
+/* 2 * lcm(2, 3, 4, 6) */
+#define YT921X_LED_DUTY_DENOM		24
+#define YT921X_LED_DUTY(nom, denom)	(YT921X_LED_DUTY_DENOM * (nom) / (denom))
+
+struct yt921x_priv;
+
+struct yt921x_led {
+	struct led_classdev cdev;
+	struct yt921x_port *port;
+	unsigned char group;
+
+	bool use_cycle:1;
+	bool use_duty:1;
+};
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+
+void yt921x_leds_remove(struct yt921x_priv *priv);
+int yt921x_leds_setup(struct yt921x_priv *priv);
+
+#else
+
+static inline void yt921x_leds_remove(struct yt921x_priv *priv) {}
+
+static inline int yt921x_leds_setup(struct yt921x_priv *priv)
+{
+	return 0;
+}
+
+#endif
+
+#endif
-- 
2.53.0


