Return-Path: <netdev+bounces-304988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JBd7NryVS2rxVwEAu9opvQ
	(envelope-from <netdev+bounces-304988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4857C7100A1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kEyKAChE;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304988-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304988-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7E4130473C8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0025641F7C8;
	Mon,  6 Jul 2026 11:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142F3CF952
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:24:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337090; cv=none; b=nrNP4ujTwckGMzkv351T2yU+NCsielEMRCtkuUlVu8v+1DsEoJHEKmnAPESuGVo7lVhF2MEV7Dmj7bVtIUfbKEYjfnce3teDnf6hBpqUyZOOL6aYDzU0ZxTe61zcK27cOv1Mj3Y12wYVtMpBOs8Aayu8iVmuvVGHmJprPRrzIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337090; c=relaxed/simple;
	bh=R73JWlbvt/o8be+7aB83UPkmpzCydb3Q2yvCsDPQTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C31J7xHTjFhAfu8m+uxNX0aXxlg/DPrzXQx5t3tpRgAdbSHSeJ/KcOP34PNOHi7zT13FjnzYekuaPyo5DAXt8j9h/fGPhb6aTFFF/jDbTI4hwvasNzJl61EPvpWPBNBu0qcQaJa+I7HhLPzXv9hoRAKvSZOv+u7DOvYJGrBh6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEyKAChE; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c59f740cso20042085e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337083; x=1783941883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tduwEFvF8WnHNsnxC1voxiPUyog/5ZqD7CGNh8J6L3g=;
        b=kEyKAChEAzPIcnbABR6CdD9MIGgRXZTH1VqNujGeGULY8vFJZ8S6Z7qOMzXR5lAdHv
         mGKJhtOeRF15MIf0Jan3yPHDCOdjfKUG6sV4xhGz5RbJevhIOG20GPFqjWLqiYofYrj/
         XseWdY3rvG9yGEuDY3tveiXYI0BCjkZQxuV0PWmmXDOwpe65xbl47AXtd1FxxfRwkYGK
         B4viYNt2BnQe1x0Uko69/2PEuOEDQXAiqEd3mlB0gbn8gxR2rO4YMhNBfk1UjFWXzg/f
         VGya3oYdQPOFuMqcMuRTnT3VnV4Rh8Jh4pnj6GTuLy4U5CIqqGo1HwGPk/iMV4+WPK2A
         5ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337083; x=1783941883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tduwEFvF8WnHNsnxC1voxiPUyog/5ZqD7CGNh8J6L3g=;
        b=OWzOxZaylnVq6TxfCiBfVDj9BZxhRdUdyTSMQuFhotOom6k1cJouNfXsPpEvGwoviu
         9EXcabyS22CMGuJMH1fwajE6wGgbR3ysYsBW0tZpHIcdzVgSTVA59JDVP0P+0H2C7Adn
         QJEhPPE72PFGdqMXklV7WM+N5gwXavZKe2e/8RgT+ghoVRntLeSAIKSlx0VBczVg+pXr
         ilLQzVohLi85mp0lpMKEhpuQbW5qucX6S+kSGL2ygtvQ0obmu3lNC+Sfbq9M+6oDw0TP
         wKgFTLoLx0UwOeOH1oP74ErRdQXE2cizaXhVT8Nlg9SQz+8Py1qHstosaqnw6U/gxBoW
         VNWg==
X-Gm-Message-State: AOJu0YxxHSEXegBO9DA6eFeBiccof2qs9FScNmHJUODpy2xzrs8Qt95u
	84RPBYS2CQvoxnuL3MWwcbBAOEJdzAwJSejGJoSeJGxDJoJz52JW/0qBYNbA9g==
X-Gm-Gg: AfdE7clicZmj1ZFkHbSEAaN4npFMGmp5gOEyAOXg12q4b0uGNCRbkPHtJ4uVDEHmT9Y
	ScX2dfm/rFyHJ1lpjPxHcGMGhNIr0/0B9OEZZnGfTn5YtrdMTzSvPP8ZNHQrW22C219LmzWqLqG
	Be9Aec32V8RToWFVIkUsz7uzV97Qj14C2LQThQ3I3q8qJHo+SYebqRXTabK2twfLuTU6uI/LG2s
	WJOe7FpAtAZvjffpZUiN+cATJhZvRSoShv02LJn0YUP5HZNXg2cvbJ3R3/zEbM2oW0Xv1mkEjPQ
	gOvg98Zu6jq8o5sAFC5/DMRZbvvX6zxJ8fqG3IJZMRUNa7fakVkQsXaf89R7e/GrzwUtV018jqQ
	At9xaSxX1Dd5+gKf8tfW9sfptDt8FwndASnD03D5Gyr81CpVB7dpADgqUw3EXHG3+5LH469anBS
	QaN5jukjBRsZF51oE=
X-Received: by 2002:a05:600c:c16f:b0:492:4668:27b5 with SMTP id 5b1f17b1804b1-493d52ac422mr86565215e9.6.1783337082926;
        Mon, 06 Jul 2026 04:24:42 -0700 (PDT)
Received: from builder ([2001:9e8:f13c:d516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab27dsm258903245e9.4.2026.07.06.04.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:24:42 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v5 2/4] net: pse-pd: add Realtek/Broadcom PSE MCU core
Date: Mon,  6 Jul 2026 11:24:22 +0000
Message-ID: <20260706112425.3149226-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304988-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,svanheule.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4857C7100A1

A range of PoE switches use a small microcontroller on the PCB to front
the actual PSE silicon. The host CPU talks to that MCU over I2C/SMBus or
UART using a fixed 12-byte request/response protocol with a trailing
checksum; the PSE chips are managed by the MCU and are not accessed
directly. The same protocol family is spoken by Realtek and Broadcom PSE
MCUs, diverging in opcode numbering and a few response layouts; the driver
handles this with a per-dialect opcode table and parser hooks for the
responses that differ, selected by the compatible. The specific PSE chip
behind the MCU is detected at runtime and only influences per-chip
constants (power scaling and the per-port cap).

This core module implements the protocol, message framing, the dialect
machinery and the pse_controller_ops glue, and exports a registration
helper for transport modules. The I2C and UART transports that drive it
follow in the next patches; the core (PSE_REALTEK_MCU) is selected
automatically by those transports and is not user-selectable on its own.

The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
realtek,pse-mcu-rtk / realtek,pse-mcu-brcm compatibles: all name the
Realtek PSE-MCU front-end, not the MCU silicon or the PSE chip behind
it (see the binding for the prefix rationale). Broadcom PSE MCUs speak
the same protocol family and are handled by the same shared core
through the dialect abstraction selected by the '-brcm' compatible.

Power budgeting is left to the MCU firmware; the driver advertises
PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 MAINTAINERS                               |    7 +
 drivers/net/pse-pd/Kconfig                |    6 +
 drivers/net/pse-pd/Makefile               |    1 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c | 1006 +++++++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu.h      |   87 ++
 5 files changed, 1107 insertions(+)
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f1a55eca99..e3f426a3b201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22716,6 +22716,13 @@ S:	Maintained
 F:	include/sound/rt*.h
 F:	sound/soc/codecs/rt*
 
+REALTEK/BROADCOM PSE MCU DRIVER
+M:	Jonas Jelonek <jelonek.jonas@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
+F:	drivers/net/pse-pd/realtek-pse-mcu*
+
 REALTEK OTTO WATCHDOG
 M:	Sander Vanheule <sander@svanheule.net>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 7ef29657ee5d..626f47b8acd7 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -13,6 +13,12 @@ menuconfig PSE_CONTROLLER
 
 if PSE_CONTROLLER
 
+config PSE_REALTEK_MCU
+	tristate
+	help
+	  Shared core for the Realtek/Broadcom PSE MCU driver. This is
+	  selected automatically by the transport options below.
+
 config PSE_REGULATOR
 	tristate "Regulator based PSE controller"
 	help
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index cc78f7ea7f5f..bf35e2a5b110 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -3,6 +3,7 @@
 
 obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
 
+obj-$(CONFIG_PSE_REALTEK_MCU) += realtek-pse-mcu-core.o
 obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
 obj-$(CONFIG_PSE_SI3474) += si3474.o
diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
new file mode 100644
index 000000000000..961ac9e9ee9c
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
@@ -0,0 +1,1006 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for the microcontroller (MCU) fronting Realtek or Broadcom PSE
+ * chips. Both vendors' MCUs speak a closely related 12-byte fixed-frame
+ * management protocol; this driver covers both via a per-dialect opcode
+ * table and response parsers.
+ *
+ * Many PoE switch designs put a dedicated microcontroller in front of the
+ * actual PSE silicon: the host CPU talks to the MCU over I2C/SMBus or
+ * UART, and the MCU in turn manages the PSE chips on the board. The MCU
+ * speaks a small message-based protocol (12-byte fixed-size frames; opcode
+ * + arg + 9 payload bytes + checksum). The PSE chips themselves are not
+ * accessed directly; everything goes through MCU commands.
+ *
+ * This driver targets that architecture for the Realtek-family protocol.
+ * Two dialects are supported: Realtek MCUs managing RTL823x/RTL8239* PSE
+ * chips, and Broadcom MCUs managing BCM590xx PSE chips. The two share
+ * frame format and a sum-mod-256 checksum but diverge on opcode numbers
+ * and on a few response layouts; this is handled by the per-dialect
+ * opcode table and parser hooks.
+ *
+ * Out of scope: PSE chips that are interfaced directly from the host
+ * without a management MCU, MCU designs that speak an unrelated protocol
+ * family, and "dumb PSE" modes where no host control is wired up at all.
+ * Those, if and when they show up in the kernel, belong in separate
+ * drivers under drivers/net/pse-pd/.
+ *
+ * This core module implements the protocol, decoding/encoding of MCU
+ * responses, and the pse_controller_ops integration. Transport modules
+ * (realtek-pse-i2c, realtek-pse-uart) provide the send/recv callbacks.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/unaligned.h>
+
+#include "realtek-pse-mcu.h"
+
+#define RTPSE_MCU_DEVICE_ID_RTL8238B		0x0138
+#define RTPSE_MCU_DEVICE_ID_RTL8239		0x0039
+#define RTPSE_MCU_DEVICE_ID_RTL8239C		0x0139
+#define RTPSE_MCU_DEVICE_ID_BCM59111		0xe111
+#define RTPSE_MCU_DEVICE_ID_BCM59121		0xe121
+
+#define RTPSE_MCU_PORT_STS_DISABLED		0x00
+#define RTPSE_MCU_PORT_STS_SEARCHING		0x01
+#define RTPSE_MCU_PORT_STS_DELIVERING		0x02
+#define RTPSE_MCU_PORT_STS_TEST			0x03	/* Broadcom; reserved on Realtek */
+#define RTPSE_MCU_PORT_STS_FAULT		0x04
+#define RTPSE_MCU_PORT_STS_OTHER_FAULT		0x05	/* Broadcom; reserved on Realtek */
+#define RTPSE_MCU_PORT_STS_REQUESTING		0x06
+
+/* RTPSE_MCU_PORT_SET_POWER_LIMIT_TYPE values */
+#define RTPSE_MCU_PORT_PW_LIMIT_TYPE_USER	0x02
+
+#define RTPSE_MCU_MAX_PORTS			48
+#define RTPSE_MCU_PORT_MAX_PRIORITY		3
+
+enum rtpse_mcu_cmd {
+	RTPSE_MCU_CMD_SET_GLOBAL_STATE,
+	RTPSE_MCU_CMD_GET_SYSTEM_INFO,
+	RTPSE_MCU_CMD_GET_EXT_CONFIG,
+
+	RTPSE_MCU_CMD_PORT_ENABLE,
+	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE,
+	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT,
+	RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_EXT,
+	RTPSE_MCU_CMD_PORT_SET_PRIORITY,
+	RTPSE_MCU_CMD_PORT_GET_STATUS,
+	RTPSE_MCU_CMD_PORT_GET_POWER_STATS,
+	RTPSE_MCU_CMD_PORT_GET_CONFIG,
+	RTPSE_MCU_CMD_PORT_GET_EXT_CONFIG,
+
+	RTPSE_MCU_NUM_CMDS,
+};
+
+struct rtpse_mcu_opcode {
+	u8 op;
+	bool valid;
+};
+
+/* Shorthand for the designated-initializer entries in dialect opcode tables. */
+#define RTPSE_MCU_OP(opc)	{ .op = (opc), .valid = true }
+
+/* Parsed MCU response structures (decoded from rtpse_mcu_msg replies) */
+
+struct rtpse_mcu_info {
+	u8 max_ports;
+	bool system_enable;
+	u16 device_id;
+	u8 sw_ver;
+	u8 mcu_type;
+	u8 config_status;
+	u8 ext_ver;
+};
+
+struct rtpse_mcu_ext_config {
+	u8 uvlo;
+	u8 ovlo;
+	bool prealloc_enable;
+	u8 num_of_pses;
+};
+
+struct rtpse_mcu_port_status {
+	u8 sts1;
+	u8 sts2;
+	u8 sts3;
+};
+
+struct rtpse_mcu_port_measurement {
+	u16 voltage_raw;	/* 64.45mV/LSB */
+	u16 current_raw;	/* 1mA/LSB */
+	u16 temperature_raw;	/* T(mC) = 1250 * (220 - raw) */
+	u16 power_raw;		/* 100mW/LSB */
+};
+
+struct rtpse_mcu_port_config {
+	bool enable;
+};
+
+struct rtpse_mcu_port_ext_config {
+	u8 max_power;
+	u8 priority;
+};
+
+struct rtpse_mcu_dialect {
+	struct rtpse_mcu_opcode opcode[RTPSE_MCU_NUM_CMDS];
+
+	/*
+	 * Response parsers for the fields that differ between dialects; each
+	 * dialect supplies its own. Other responses share one layout and are
+	 * decoded directly - a dialect that diverges there must add a hook,
+	 * as a mismatched layout cannot be detected (the checksum still passes).
+	 */
+	void (*parse_system_info)(const u8 *payload, struct rtpse_mcu_info *info);
+	int (*parse_port_class)(const struct rtpse_mcu_port_status *status);
+	const char *(*mcu_type_str)(unsigned int mcu_type);
+};
+
+/*
+ * Per-compatible match data: selected by the DT/I2C compatible, it bundles
+ * the protocol dialect with attachment quirks that the exact MCU silicon
+ * does not determine (only its firmware protocol and the host bus do).
+ */
+struct rtpse_mcu_match_data {
+	const struct rtpse_mcu_dialect *dialect;
+	/* I2C framing must come from DT (realtek,i2c-protocol); else SMBus. */
+	bool i2c_proto_dt_required;
+};
+
+struct rtpse_mcu_chip_info {
+	const char *name;
+	u16 device_id;
+	u32 max_mW_per_port;
+	enum rtpse_mcu_cmd pw_set_cmd;	/* command used by set_pw_limit */
+	u32 pw_set_lsb_mW;		/* LSB of pw_set_cmd value, in mW */
+	u32 pw_read_lsb_mW;		/* LSB of ext_config.max_power read-back, in mW */
+};
+
+static const struct rtpse_mcu_chip_info rtl8238b_info = {
+	.device_id = RTPSE_MCU_DEVICE_ID_RTL8238B,
+	.max_mW_per_port = 30000,
+	.name = "RTL8238B",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+static const struct rtpse_mcu_chip_info rtl8239_info = {
+	.device_id = RTPSE_MCU_DEVICE_ID_RTL8239,
+	.max_mW_per_port = 90000,
+	.name = "RTL8239",
+	.pw_read_lsb_mW = 400,
+	.pw_set_cmd = RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_EXT,
+	.pw_set_lsb_mW = 400,
+};
+
+static const struct rtpse_mcu_chip_info rtl8239c_info = {
+	.device_id = RTPSE_MCU_DEVICE_ID_RTL8239C,
+	.max_mW_per_port = 90000,
+	.name = "RTL8239C",
+	.pw_read_lsb_mW = 400,
+	.pw_set_cmd = RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_EXT,
+	.pw_set_lsb_mW = 400,
+};
+
+static const struct rtpse_mcu_chip_info bcm59111_info = {
+	.device_id = RTPSE_MCU_DEVICE_ID_BCM59111,
+	.max_mW_per_port = 30000,
+	.name = "BCM59111",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+static const struct rtpse_mcu_chip_info bcm59121_info = {
+	.device_id = RTPSE_MCU_DEVICE_ID_BCM59121,
+	/*
+	 * BCM59121 is a 60W Type-3 part, but known boards run it at 802.3at
+	 * and the BCM dialect has only the 8-bit/0.2W set command (<=51W);
+	 * cap at the 30W the hardware actually offers.
+	 */
+	.max_mW_per_port = 30000,
+	.name = "BCM59121",
+	.pw_read_lsb_mW = 200,
+	.pw_set_cmd = RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT,
+	.pw_set_lsb_mW = 200,
+};
+
+/* Helpers and basic functions */
+
+static struct rtpse_mcu_ctrl *to_rtpse_mcu_ctrl(struct pse_controller_dev *pcdev)
+{
+	return container_of(pcdev, struct rtpse_mcu_ctrl, pcdev);
+}
+
+bool rtpse_mcu_needs_i2c_proto(const struct rtpse_mcu_match_data *match)
+{
+	return match->i2c_proto_dt_required;
+}
+EXPORT_SYMBOL_GPL(rtpse_mcu_needs_i2c_proto);
+
+static void rtpse_mcu_msg_init(struct rtpse_mcu_msg *msg, u8 opcode)
+{
+	memset(msg, 0xff, sizeof(*msg));
+	msg->opcode = opcode;
+}
+
+static u8 rtpse_mcu_checksum(const u8 *buf, size_t len)
+{
+	u8 sum = 0;
+
+	while (len--)
+		sum += *buf++;
+	return sum;
+}
+
+static int rtpse_mcu_do_xfer(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_msg *req,
+			     struct rtpse_mcu_msg *resp)
+{
+	int ret;
+
+	req->checksum = rtpse_mcu_checksum((u8 *)req, RTPSE_MCU_MSG_SIZE - 1);
+
+	scoped_guard(mutex, &pse->mutex) {
+		ret = pse->transport->send(pse, req);
+		if (ret)
+			return ret;
+
+		/*
+		 * The MCU needs a fixed amount of time between receiving a request
+		 * and having the response ready, regardless of how the bytes get to
+		 * us. Pace the transaction here so each transport can keep its recv
+		 * path simple: a single bounded wait rather than a generic retry.
+		 */
+		msleep(RTPSE_MCU_RESPONSE_MS);
+
+		memset(resp, 0, sizeof(*resp));
+		ret = pse->transport->recv(pse, req, resp);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Explicit MCU error opcodes (observed on the BCM dialect; harmless
+	 * to check for RTL too). Catch these before the generic opcode/CRC
+	 * mismatch path so callers see a meaningful errno.
+	 */
+	switch (resp->opcode) {
+	case RTPSE_MCU_OPCODE_INCOMPLETE:
+		return -EBADE;
+	case RTPSE_MCU_OPCODE_BAD_CSUM:
+		return -EBADMSG;
+	case RTPSE_MCU_OPCODE_NOT_READY:
+		return -EAGAIN;
+	}
+
+	if (resp->opcode != req->opcode ||
+	    resp->seq_num != req->seq_num ||
+	    resp->checksum != rtpse_mcu_checksum((u8 *)resp, RTPSE_MCU_MSG_SIZE - 1))
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int rtpse_mcu_port_query(struct rtpse_mcu_ctrl *pse, unsigned int port, u8 opcode,
+				struct rtpse_mcu_msg *resp)
+{
+	struct rtpse_mcu_msg req;
+	int ret;
+
+	rtpse_mcu_msg_init(&req, opcode);
+	req.payload[0] = port;
+
+	ret = rtpse_mcu_do_xfer(pse, &req, resp);
+	if (ret)
+		return ret;
+
+	if (resp->payload[0] != port)
+		return -EIO;
+
+	return 0;
+}
+
+static int rtpse_mcu_port_cmd(struct rtpse_mcu_ctrl *pse, unsigned int port, u8 opcode, u8 arg)
+{
+	struct rtpse_mcu_msg req, resp;
+	int ret;
+
+	rtpse_mcu_msg_init(&req, opcode);
+	req.payload[0] = port;
+	req.payload[1] = arg;
+
+	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	if (resp.payload[0] != port || resp.payload[1] != 0)
+		return -EIO;
+
+	return 0;
+}
+
+/* Global operations */
+
+static int rtpse_mcu_get_info(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_info *info)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_mcu_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_GET_SYSTEM_INFO];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	pse->dialect->parse_system_info(resp.payload, info);
+	return 0;
+}
+
+static int rtpse_mcu_get_ext_config(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_ext_config *config)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_mcu_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_GET_EXT_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	config->uvlo = resp.payload[0];
+	config->ovlo = resp.payload[5];
+	config->prealloc_enable = (resp.payload[1] == 0x1);
+	config->num_of_pses = resp.payload[6];
+
+	return 0;
+}
+
+static int rtpse_mcu_set_global_state(struct rtpse_mcu_ctrl *pse, bool enable)
+{
+	struct rtpse_mcu_msg req, resp;
+	const struct rtpse_mcu_opcode *opc;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_SET_GLOBAL_STATE];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	rtpse_mcu_msg_init(&req, opc->op);
+	req.payload[0] = enable ? 0x1 : 0x0;
+
+	ret = rtpse_mcu_do_xfer(pse, &req, &resp);
+	if (ret)
+		return ret;
+
+	return (resp.payload[0] == 0x0) ? 0 : -EIO;
+}
+
+/* Port operations */
+
+static int rtpse_mcu_port_get_status(struct rtpse_mcu_ctrl *pse, unsigned int port,
+				     struct rtpse_mcu_port_status *status)
+{
+	const struct rtpse_mcu_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_GET_STATUS];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_mcu_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	status->sts1 = resp.payload[1];
+	status->sts2 = resp.payload[2];
+	status->sts3 = resp.payload[3];
+
+	return 0;
+}
+
+static int rtpse_mcu_port_get_measurement(struct rtpse_mcu_ctrl *pse, unsigned int port,
+					  struct rtpse_mcu_port_measurement *measurement)
+{
+	const struct rtpse_mcu_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_GET_POWER_STATS];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_mcu_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	measurement->voltage_raw = get_unaligned_be16(&resp.payload[1]);
+	measurement->current_raw = get_unaligned_be16(&resp.payload[3]);
+	measurement->temperature_raw = get_unaligned_be16(&resp.payload[5]);
+	measurement->power_raw = get_unaligned_be16(&resp.payload[7]);
+
+	return 0;
+}
+
+static int rtpse_mcu_port_get_config(struct rtpse_mcu_ctrl *pse, unsigned int port,
+				     struct rtpse_mcu_port_config *config)
+{
+	const struct rtpse_mcu_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_GET_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_mcu_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	config->enable = (resp.payload[1] == 1);
+
+	return 0;
+}
+
+static int rtpse_mcu_port_get_ext_config(struct rtpse_mcu_ctrl *pse, unsigned int port,
+					 struct rtpse_mcu_port_ext_config *config)
+{
+	const struct rtpse_mcu_opcode *opc;
+	struct rtpse_mcu_msg resp;
+	int ret;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_GET_EXT_CONFIG];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	ret = rtpse_mcu_port_query(pse, port, opc->op, &resp);
+	if (ret)
+		return ret;
+
+	config->max_power = resp.payload[3];
+	config->priority = resp.payload[4];
+
+	return 0;
+}
+
+static int rtpse_mcu_port_set_state(struct rtpse_mcu_ctrl *pse, unsigned int port, bool enable)
+{
+	const struct rtpse_mcu_opcode *opc;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_ENABLE];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	return rtpse_mcu_port_cmd(pse, port, opc->op, enable ? 0x1 : 0x0);
+}
+
+/* PSE controller ops */
+
+static int rtpse_mcu_port_get_admin_state(struct pse_controller_dev *pcdev, int id,
+					  struct pse_admin_state *admin_state)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_config config;
+	int ret;
+
+	ret = rtpse_mcu_port_get_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	admin_state->c33_admin_state = config.enable ? ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED :
+						       ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+	return 0;
+}
+
+static int rtpse_mcu_port_get_pw_status(struct pse_controller_dev *pcdev, int id,
+					struct pse_pw_status *pw_status)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_status status;
+	int ret;
+
+	ret = rtpse_mcu_port_get_status(pse, id, &status);
+	if (ret)
+		return ret;
+
+	switch (status.sts1) {
+	case RTPSE_MCU_PORT_STS_DISABLED:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
+		break;
+	case RTPSE_MCU_PORT_STS_SEARCHING:
+	case RTPSE_MCU_PORT_STS_REQUESTING:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
+		break;
+	case RTPSE_MCU_PORT_STS_DELIVERING:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+		break;
+	case RTPSE_MCU_PORT_STS_TEST:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_TEST;
+		break;
+	case RTPSE_MCU_PORT_STS_FAULT:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
+		break;
+	case RTPSE_MCU_PORT_STS_OTHER_FAULT:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT;
+		break;
+	default:
+		pw_status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int rtpse_mcu_port_get_pw_class(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_status status;
+	int ret;
+
+	ret = rtpse_mcu_port_get_status(pse, id, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * sts2 holds the class only in the operational states below. In a
+	 * fault/test state (or a code reserved on the current dialect) it
+	 * does not, so there is no class to report and we return 0. That is
+	 * indistinguishable from a real class-0 PD; userspace disambiguates
+	 * via the power status.
+	 */
+	switch (status.sts1) {
+	case RTPSE_MCU_PORT_STS_DISABLED:
+	case RTPSE_MCU_PORT_STS_SEARCHING:
+	case RTPSE_MCU_PORT_STS_DELIVERING:
+	case RTPSE_MCU_PORT_STS_REQUESTING:
+		return pse->dialect->parse_port_class(&status);
+	default:
+		return 0;
+	}
+}
+
+static int rtpse_mcu_port_get_actual_pw(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_measurement measurement;
+	int ret;
+
+	ret = rtpse_mcu_port_get_measurement(pse, id, &measurement);
+	if (ret)
+		return ret;
+
+	/* 100mW per LSB */
+	return measurement.power_raw * 100U;
+}
+
+static int rtpse_mcu_port_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_measurement measurement;
+	int ret;
+	u32 uV;
+
+	ret = rtpse_mcu_port_get_measurement(pse, id, &measurement);
+	if (ret)
+		return ret;
+
+	/* 64.45mV per LSB */
+	uV = measurement.voltage_raw * 64450U;
+	return min_t(u32, uV, INT_MAX);
+}
+
+static int rtpse_mcu_port_enable(struct pse_controller_dev *pcdev, int id)
+{
+	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, true);
+}
+
+static int rtpse_mcu_port_disable(struct pse_controller_dev *pcdev, int id)
+{
+	return rtpse_mcu_port_set_state(to_rtpse_mcu_ctrl(pcdev), id, false);
+}
+
+static int rtpse_mcu_port_get_pw_limit(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_ext_config config;
+	int ret;
+
+	ret = rtpse_mcu_port_get_ext_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	return config.max_power * pse->chip->pw_read_lsb_mW;
+}
+
+static int rtpse_mcu_port_set_pw_limit(struct pse_controller_dev *pcdev, int id, int max_mW)
+{
+	const struct rtpse_mcu_opcode *type_opc, *val_opc;
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	const struct rtpse_mcu_chip_info *chip = pse->chip;
+	u8 prg_val;
+	int ret;
+
+	if (max_mW < 0 || max_mW > chip->max_mW_per_port)
+		return -ERANGE;
+
+	type_opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE];
+	val_opc = &pse->dialect->opcode[chip->pw_set_cmd];
+	/* pw_set_lsb_mW is the divisor below; reject a chip that lacks it. */
+	if (!type_opc->valid || !val_opc->valid || !chip->pw_set_lsb_mW)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Switch the port to user-defined limit mode first, then program the
+	 * limit value. If the second cmd fails, the port is left in
+	 * user-defined mode but with the previous limit value; the next
+	 * successful set_pw_limit call recovers it.
+	 */
+	ret = rtpse_mcu_port_cmd(pse, id, type_opc->op, RTPSE_MCU_PORT_PW_LIMIT_TYPE_USER);
+	if (ret)
+		return ret;
+
+	prg_val = min_t(unsigned int, max_mW / chip->pw_set_lsb_mW, U8_MAX);
+
+	return rtpse_mcu_port_cmd(pse, id, val_opc->op, prg_val);
+}
+
+static int rtpse_mcu_port_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
+					      struct pse_pw_limit_ranges *out)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct ethtool_c33_pse_pw_limit_range *range;
+
+	range = kzalloc_obj(*range);
+	if (!range)
+		return -ENOMEM;
+
+	range[0].min = 0;
+	range[0].max = pse->chip->max_mW_per_port;
+
+	out->c33_pw_limit_ranges = range;
+	return 1;
+}
+
+static int rtpse_mcu_port_get_prio(struct pse_controller_dev *pcdev, int id)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	struct rtpse_mcu_port_ext_config config;
+	int ret;
+
+	ret = rtpse_mcu_port_get_ext_config(pse, id, &config);
+	if (ret)
+		return ret;
+
+	return config.priority;
+}
+
+static int rtpse_mcu_port_set_prio(struct pse_controller_dev *pcdev, int id, unsigned int prio)
+{
+	struct rtpse_mcu_ctrl *pse = to_rtpse_mcu_ctrl(pcdev);
+	const struct rtpse_mcu_opcode *opc;
+
+	if (prio > RTPSE_MCU_PORT_MAX_PRIORITY)
+		return -ERANGE;
+
+	opc = &pse->dialect->opcode[RTPSE_MCU_CMD_PORT_SET_PRIORITY];
+	if (!opc->valid)
+		return -EOPNOTSUPP;
+
+	return rtpse_mcu_port_cmd(pse, id, opc->op, prio);
+}
+
+static const struct pse_controller_ops rtpse_mcu_ops = {
+	.pi_get_admin_state = rtpse_mcu_port_get_admin_state,
+	.pi_get_pw_status = rtpse_mcu_port_get_pw_status,
+	.pi_get_pw_class = rtpse_mcu_port_get_pw_class,
+	.pi_get_actual_pw = rtpse_mcu_port_get_actual_pw,
+	.pi_enable = rtpse_mcu_port_enable,
+	.pi_disable = rtpse_mcu_port_disable,
+	.pi_get_voltage = rtpse_mcu_port_get_voltage,
+	.pi_get_pw_limit = rtpse_mcu_port_get_pw_limit,
+	.pi_set_pw_limit = rtpse_mcu_port_set_pw_limit,
+	.pi_get_pw_limit_ranges = rtpse_mcu_port_get_pw_limit_ranges,
+	.pi_get_prio = rtpse_mcu_port_get_prio,
+	.pi_set_prio = rtpse_mcu_port_set_prio,
+};
+
+static int rtpse_mcu_discover(struct rtpse_mcu_ctrl *pse, struct rtpse_mcu_info *info)
+{
+	struct rtpse_mcu_ext_config ext_config;
+	unsigned long deadline;
+	int ret;
+
+	/*
+	 * A booting MCU may stay silent (-ETIMEDOUT), not ACK its address
+	 * (-ENXIO / -EREMOTEIO), report not-ready (-EAGAIN), or emit a
+	 * corrupt/partial frame (-EBADMSG / -EBADE). Retry those within a
+	 * bounded window; other errors (e.g. -EOPNOTSUPP) are fatal and fail
+	 * immediately.
+	 */
+	deadline = jiffies + msecs_to_jiffies(RTPSE_MCU_BOOT_TIMEOUT_MS);
+	do {
+		ret = rtpse_mcu_get_info(pse, info);
+		if (ret != -ETIMEDOUT && ret != -ENXIO && ret != -EREMOTEIO &&
+		    ret != -EAGAIN && ret != -EBADMSG && ret != -EBADE)
+			break;
+		msleep(RTPSE_MCU_BOOT_RETRY_MS);
+	} while (time_before(jiffies, deadline));
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to read MCU info\n");
+
+	switch (info->device_id) {
+	case RTPSE_MCU_DEVICE_ID_RTL8238B:
+		pse->chip = &rtl8238b_info;
+		break;
+	case RTPSE_MCU_DEVICE_ID_RTL8239:
+		pse->chip = &rtl8239_info;
+		break;
+	case RTPSE_MCU_DEVICE_ID_RTL8239C:
+		pse->chip = &rtl8239c_info;
+		break;
+	case RTPSE_MCU_DEVICE_ID_BCM59111:
+		pse->chip = &bcm59111_info;
+		break;
+	case RTPSE_MCU_DEVICE_ID_BCM59121:
+		pse->chip = &bcm59121_info;
+		break;
+	default:
+		return dev_err_probe(pse->dev, -EINVAL, "unknown PSE id 0x%x\n",
+				     info->device_id);
+	}
+
+	if (!info->max_ports || info->max_ports > RTPSE_MCU_MAX_PORTS)
+		return dev_err_probe(pse->dev, -EINVAL,
+				     "MCU reports invalid port count %u\n", info->max_ports);
+
+	ret = rtpse_mcu_get_ext_config(pse, &ext_config);
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to read MCU ext config\n");
+
+	dev_info(pse->dev, "%s MCU, %s (id 0x%04x), %u ports across %u PSE chip(s)\n",
+		 pse->dialect->mcu_type_str(info->mcu_type), pse->chip->name,
+		 info->device_id, info->max_ports, ext_config.num_of_pses);
+	return 0;
+}
+
+static void rtpse_mcu_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void rtpse_mcu_global_disable(void *data)
+{
+	struct rtpse_mcu_ctrl *pse = data;
+
+	rtpse_mcu_set_global_state(pse, false);
+}
+
+int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse)
+{
+	const struct rtpse_mcu_match_data *match;
+	struct gpio_desc *enable_gpio;
+	struct rtpse_mcu_info info;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct rtpse_mcu_msg) != RTPSE_MCU_MSG_SIZE);
+
+	ret = devm_mutex_init(pse->dev, &pse->mutex);
+	if (ret)
+		return ret;
+
+	match = device_get_match_data(pse->dev);
+	if (!match)
+		return dev_err_probe(pse->dev, -ENODEV, "missing match data\n");
+	pse->dialect = match->dialect;
+
+	/*
+	 * Catch a dialect that forgot to set one of the required hooks at
+	 * probe time, rather than NULL-deref'ing later from a fast path.
+	 */
+	if (!pse->dialect ||
+	    !pse->dialect->parse_system_info ||
+	    !pse->dialect->parse_port_class ||
+	    !pse->dialect->mcu_type_str)
+		return dev_err_probe(pse->dev, -EINVAL,
+				     "dialect for chip is incomplete\n");
+
+	pse->poe_supply = devm_regulator_get(pse->dev, "power");
+	if (IS_ERR(pse->poe_supply))
+		return dev_err_probe(pse->dev, PTR_ERR(pse->poe_supply),
+				     "failed to get PoE supply\n");
+
+	enable_gpio = devm_gpiod_get_optional(pse->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(pse->dev, PTR_ERR(enable_gpio),
+				     "failed to get enable gpio\n");
+
+	ret = rtpse_mcu_discover(pse, &info);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(pse->poe_supply);
+	if (ret)
+		return dev_err_probe(pse->dev, ret, "failed to enable PoE supply\n");
+
+	ret = devm_add_action_or_reset(pse->dev, rtpse_mcu_regulator_disable, pse->poe_supply);
+	if (ret)
+		return ret;
+
+	if (!info.system_enable) {
+		ret = rtpse_mcu_set_global_state(pse, true);
+		/* Dialects without a global-state concept (e.g. BCM) return
+		 * -EOPNOTSUPP; treat that as "no separate enable required".
+		 */
+		if (ret && ret != -EOPNOTSUPP)
+			return dev_err_probe(pse->dev, ret,
+					     "failed to enable PSE system\n");
+		if (!ret) {
+			ret = devm_add_action_or_reset(pse->dev,
+						       rtpse_mcu_global_disable, pse);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/*
+	 * Depending on the MCU firmware configuration (which might be different
+	 * for every board), it isn't known whether the PoE subsystem is active or
+	 * inactive by default. At this stage, the PSE chips might already deliver
+	 * power to PDs without any explicit enable.
+	 */
+
+	/* pcdev.owner is set by the transport, so the registered controller
+	 * pins the transport module that owns the live device, not the core.
+	 */
+	pse->pcdev.ops      = &rtpse_mcu_ops;
+	pse->pcdev.dev      = pse->dev;
+	pse->pcdev.types    = ETHTOOL_PSE_C33;
+	pse->pcdev.nr_lines = info.max_ports;
+	pse->pcdev.pis_prio_max = RTPSE_MCU_PORT_MAX_PRIORITY;
+	pse->pcdev.supp_budget_eval_strategies = PSE_BUDGET_EVAL_STRAT_DYNAMIC;
+
+	return devm_pse_controller_register(pse->dev, &pse->pcdev);
+}
+EXPORT_SYMBOL_GPL(rtpse_mcu_register);
+
+static void rtpse_mcu_rtl_parse_system_info(const u8 *payload, struct rtpse_mcu_info *info)
+{
+	info->max_ports = payload[1];
+	info->system_enable = (payload[2] == 0x1);
+	info->device_id = get_unaligned_be16(&payload[3]);
+	info->sw_ver = payload[5];
+	info->mcu_type = payload[6];
+	info->config_status = payload[7];
+	info->ext_ver = payload[8];
+}
+
+static int rtpse_mcu_rtl_parse_port_class(const struct rtpse_mcu_port_status *status)
+{
+	/* Class lives in the upper nibble of sts2. */
+	return FIELD_GET(GENMASK(7, 4), status->sts2);
+}
+
+static const char *rtpse_mcu_rtl_mcu_type_str(unsigned int mcu_type)
+{
+	switch (mcu_type) {
+	case 0x00:	return "GigaDevice GD32F310";
+	case 0x01:	return "GigaDevice GD32F230";
+	case 0x02:	return "GigaDevice GD32F303";
+	case 0x03:	return "GigaDevice GD32F103";
+	case 0x04:	return "GigaDevice GD32E103";
+	case 0x10:	return "Nuvoton M0516";
+	case 0x11:	return "Nuvoton M0564";
+	case 0x12:	return "Nuvoton NUC029";
+	default:	return "unknown";
+	}
+}
+
+static void rtpse_mcu_brcm_parse_system_info(const u8 *payload, struct rtpse_mcu_info *info)
+{
+	info->max_ports = payload[1];
+	/* BCM has no explicit system_enable byte; the closest analog is the
+	 * "remote enable" bit in the system-status flags at payload[7].
+	 */
+	info->system_enable = !!(payload[7] & BIT(2));
+	info->device_id = get_unaligned_be16(&payload[3]);
+	info->sw_ver = payload[5];
+	info->mcu_type = payload[6];
+	info->config_status = payload[7];
+	info->ext_ver = payload[8];
+}
+
+static int rtpse_mcu_brcm_parse_port_class(const struct rtpse_mcu_port_status *status)
+{
+	/* BCM puts the detected class in payload[3] (== sts3) directly.
+	 * Mask to the low nibble; class is 0..8 and any high bits would be
+	 * noise.
+	 */
+	return status->sts3 & 0x0f;
+}
+
+static const char *rtpse_mcu_brcm_mcu_type_str(unsigned int mcu_type)
+{
+	switch (mcu_type) {
+	case 0x00:	return "ST Micro ST32F100";
+	case 0x01:	return "Nuvoton M05xx LAN";
+	case 0x02:	return "ST Micro STF030C8";
+	case 0x03:	return "Nuvoton M058SAN";
+	case 0x04:	return "Nuvoton NUC122";
+	default:	return "unknown";
+	}
+}
+
+/* Map each logical command the core issues to its per-dialect opcode. */
+static const struct rtpse_mcu_dialect rtpse_mcu_dialect_rtk = {
+	.parse_system_info = rtpse_mcu_rtl_parse_system_info,
+	.parse_port_class  = rtpse_mcu_rtl_parse_port_class,
+	.mcu_type_str      = rtpse_mcu_rtl_mcu_type_str,
+	.opcode = {
+		[RTPSE_MCU_CMD_SET_GLOBAL_STATE]	= RTPSE_MCU_OP(0x00),
+		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		= RTPSE_MCU_OP(0x40),
+		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		= RTPSE_MCU_OP(0x4a),
+
+		[RTPSE_MCU_CMD_PORT_ENABLE]		= RTPSE_MCU_OP(0x01),
+		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] = RTPSE_MCU_OP(0x12),
+		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT]	= RTPSE_MCU_OP(0x13),
+		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_EXT] = RTPSE_MCU_OP(0x14),
+		[RTPSE_MCU_CMD_PORT_SET_PRIORITY]	= RTPSE_MCU_OP(0x15),
+		[RTPSE_MCU_CMD_PORT_GET_STATUS]		= RTPSE_MCU_OP(0x42),
+		[RTPSE_MCU_CMD_PORT_GET_POWER_STATS]	= RTPSE_MCU_OP(0x44),
+		[RTPSE_MCU_CMD_PORT_GET_CONFIG]		= RTPSE_MCU_OP(0x48),
+		[RTPSE_MCU_CMD_PORT_GET_EXT_CONFIG]	= RTPSE_MCU_OP(0x49),
+	},
+};
+
+static const struct rtpse_mcu_dialect rtpse_mcu_dialect_brcm = {
+	.parse_system_info = rtpse_mcu_brcm_parse_system_info,
+	.parse_port_class  = rtpse_mcu_brcm_parse_port_class,
+	.mcu_type_str      = rtpse_mcu_brcm_mcu_type_str,
+	.opcode = {
+		[RTPSE_MCU_CMD_GET_SYSTEM_INFO]		= RTPSE_MCU_OP(0x20),
+		[RTPSE_MCU_CMD_GET_EXT_CONFIG]		= RTPSE_MCU_OP(0x2b),
+
+		[RTPSE_MCU_CMD_PORT_ENABLE]		= RTPSE_MCU_OP(0x00),
+		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT_TYPE] = RTPSE_MCU_OP(0x15),
+		[RTPSE_MCU_CMD_PORT_SET_POWER_LIMIT]	= RTPSE_MCU_OP(0x16),
+		[RTPSE_MCU_CMD_PORT_SET_PRIORITY]	= RTPSE_MCU_OP(0x1a),
+		[RTPSE_MCU_CMD_PORT_GET_STATUS]		= RTPSE_MCU_OP(0x21),
+		[RTPSE_MCU_CMD_PORT_GET_POWER_STATS]	= RTPSE_MCU_OP(0x30),
+		[RTPSE_MCU_CMD_PORT_GET_CONFIG]		= RTPSE_MCU_OP(0x25),
+		[RTPSE_MCU_CMD_PORT_GET_EXT_CONFIG]	= RTPSE_MCU_OP(0x26),
+	},
+};
+
+const struct rtpse_mcu_match_data rtpse_mcu_rtk_data = {
+	.dialect = &rtpse_mcu_dialect_rtk,
+	.i2c_proto_dt_required = true,
+};
+EXPORT_SYMBOL_GPL(rtpse_mcu_rtk_data);
+
+const struct rtpse_mcu_match_data rtpse_mcu_brcm_data = {
+	.dialect = &rtpse_mcu_dialect_brcm,
+};
+EXPORT_SYMBOL_GPL(rtpse_mcu_brcm_data);
+
+MODULE_DESCRIPTION("Realtek/Broadcom PSE MCU driver (core)");
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/pse-pd/realtek-pse-mcu.h b/drivers/net/pse-pd/realtek-pse-mcu.h
new file mode 100644
index 000000000000..b9bf3b2dde08
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-mcu.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _REALTEK_PSE_MCU_H
+#define _REALTEK_PSE_MCU_H
+
+#include <linux/mutex.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/types.h>
+
+/*
+ * Time the MCU itself needs between accepting a request and having a
+ * response ready. These are properties of the MCU firmware, not of the
+ * underlying transport: the core paces transactions by RTPSE_MCU_RESPONSE_MS
+ * and both transports size their per-transaction recv ceiling from
+ * RTPSE_MCU_RESPONSE_MAX_MS, since some commands are documented as
+ * needing up to ~1s to produce a reply.
+ */
+#define RTPSE_MCU_RESPONSE_MS			25
+#define RTPSE_MCU_RESPONSE_MAX_MS		1000
+
+/*
+ * Total time to keep retrying the first MCU read at probe, and the pause
+ * between attempts. Right after enable-gpios is asserted the MCU may not
+ * answer on the bus yet; give it a bounded window to come up before
+ * declaring the probe failed.
+ */
+#define RTPSE_MCU_BOOT_TIMEOUT_MS		3000
+#define RTPSE_MCU_BOOT_RETRY_MS			100
+
+#define RTPSE_MCU_MSG_SIZE			12
+
+struct rtpse_mcu_msg {
+	u8 opcode;
+	u8 seq_num;
+	u8 payload[9];
+	u8 checksum;
+} __packed;
+
+/*
+ * MCU status opcodes (seen on the BCM dialect; RTL never emits them).
+ * INCOMPLETE/BAD_CSUM are terminal; NOT_READY is transient.
+ */
+#define RTPSE_MCU_OPCODE_INCOMPLETE		0xfd	/* -EBADE   */
+#define RTPSE_MCU_OPCODE_BAD_CSUM		0xfe	/* -EBADMSG */
+#define RTPSE_MCU_OPCODE_NOT_READY		0xff	/* -EAGAIN  */
+
+/* A polling transport can stop here: the matching reply, or a terminal error. */
+static inline bool rtpse_mcu_resp_is_final(const struct rtpse_mcu_msg *req,
+					   const struct rtpse_mcu_msg *resp)
+{
+	return resp->opcode == req->opcode ||
+	       resp->opcode == RTPSE_MCU_OPCODE_INCOMPLETE ||
+	       resp->opcode == RTPSE_MCU_OPCODE_BAD_CSUM;
+}
+
+/* Opaque to transports; defined in realtek-pse-core.c. */
+struct rtpse_mcu_dialect;
+struct rtpse_mcu_match_data;
+struct rtpse_mcu_chip_info;
+struct rtpse_mcu_ctrl;
+
+struct rtpse_mcu_transport_ops {
+	int (*send)(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req);
+	int (*recv)(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
+		    struct rtpse_mcu_msg *resp);
+};
+
+struct rtpse_mcu_ctrl {
+	struct device *dev;
+	struct pse_controller_dev pcdev;
+	struct mutex mutex; /* serializes MCU request/response transactions */
+	const struct rtpse_mcu_dialect *dialect;
+	const struct rtpse_mcu_chip_info *chip;
+	const struct rtpse_mcu_transport_ops *transport;
+
+	struct regulator *poe_supply;
+};
+
+int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse);
+
+/* Whether the I2C transport must read "realtek,i2c-protocol" from DT. */
+bool rtpse_mcu_needs_i2c_proto(const struct rtpse_mcu_match_data *match);
+
+extern const struct rtpse_mcu_match_data rtpse_mcu_rtk_data;
+extern const struct rtpse_mcu_match_data rtpse_mcu_brcm_data;
+
+#endif
-- 
2.51.0


