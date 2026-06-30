Return-Path: <netdev+bounces-303085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7+DZGDWkQ2p/eAoAu9opvQ
	(envelope-from <netdev+bounces-303085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:10:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9859A6E3645
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W1ccIXKJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303085-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303085-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8190C3066CCE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FCB409137;
	Tue, 30 Jun 2026 10:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D230403156
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817023; cv=none; b=eTCenFUFcl1UWdoHCVdp+iTshYsA7BPky5JXQ4dS0zEeYl/TWs+OJQ7aA2zoBHj0Uy6IYJZc6Z+7MElXJm/Du5Z5mS88AjvG0S54/Jq5Eftp7Ye0DNjBtEhtrJ8Xvus5L4r0Ejt4QDU0S/lNLXzreNx6tphjjwKY6Gb6s69uK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817023; c=relaxed/simple;
	bh=MIeXi+Qy8hk6Ot1stqH5yVrx5+17ld2T9dztOgNqqp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cztSZzqUCuHso2t2DP/dfiq82WvuObk/sXMo1XoFN0pCoivwMKHf3ON+7t3AF9OmiA8IO8tEN0PFwSFHX9gy+h+XuomJ1AmvY144kRTIIBqC8hDtPX1hvpygOi03Y+QMKasBg2NXke03s0lP1xDXiZwLOZ0S7Ax815COGuLTDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1ccIXKJ; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475417f010dso560757f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817020; x=1783421820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnAUH0IyVjWohICJQD2sZTC1KkDcmw0Frs3noihd5E0=;
        b=W1ccIXKJYtjnUjkKPpwFWHqFXQ0bzL8wrVdP6x9H0YOaemHRZy7suQmZxuP7Ssyk5A
         fysJ/CsR9cUTFUekGYJ3dKcTqilZPTy5jH06NtOthGiSySUEnvzo31qKMSbeU750+FEj
         kBqmNJVYUHTtgnQofUaAb4/jp0vyRvt2ZGyUJnbArl8BGpP9v4uGcP/4A+C7/Y0+7q7s
         NkuuJTbP/TVXgkJmrHYxUmYtmaveFrPBGfmgRFWoqCQave/TKNvEb3MhjqWrKW/hT4t0
         OiHy0NQR0tPgpGZCpVKY8o8KQwEw1rS5icODudpx0q15gCcNby+1/S0GGL+5Nc1IWruU
         7HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817020; x=1783421820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnAUH0IyVjWohICJQD2sZTC1KkDcmw0Frs3noihd5E0=;
        b=tBkeG2wo0y/hi4r3Q/iGYhJxL4sWw5OqO5uTxm5L8fO8BL+rM+L7N0RepZaQiXNIF/
         dNKh/yviW5KB2GupGLNNGZsVu6lxZ/fH9/PLVuaCGB3zF7dNV7/xY/aqsq+N1TNmiFl5
         JXm4jZn9ahdJTYE60hvYdLch4cPH44uAe5cXGNMWXZaM1fjcNddpOrYr/bWtYg+KXG5+
         5CBiVnz3dc+BSSyjxvXPxe3cZ6KYodg7R9TuPLsjpAnX8+gTiHsiRAG2BGczfgksKUbf
         us7Xtql9fFQGjToc4lZ2toB9wP9xclns8h/l5r7HPwD5pjauWMTaytilMXh8rV99iatQ
         vPFQ==
X-Gm-Message-State: AOJu0YyvjD7UdBo18g9PKRi1AeeqJZNKg0T52bgSu2P1/PlSuFUJ+49x
	gX9tM1lJlecrhOkjup37PSFp7HTdHf5aRCQ9RRY7rfmS27SVXHrHgVq+
X-Gm-Gg: AfdE7clh6Y5uR1du/LvnkWBirq/DbuNspNKF6gFlu5tCITvkYsejImo594NMRGrUGiB
	i+pU88/h80bgLNfRHt8EyQ2PZB+K6jtzgN+t9qmNQq6YHo0huxldXiTEYw6f57vkhOKowkmIgEo
	re6w0GHZF61wwT8nVDnUbhDhQimJy3Qv8Pe6NM0bd2LSbBIC2hqztmlhhdLXtBeZD8N98XbtByO
	XdLgxKfyUkisjFegLJbK3BE2WBhI8eTNlNI437GMiJBUdlLk73UOhB56uafagpAOs8qvuuo1cP9
	lO1bE/3Ak9V3bpQVEKhSoTcEnZZ6PRbQkfAgAi8ZjoVX1akRuCbcpTPJ4VtUUavIIhEQGIoclat
	ME6l5C/rUTndcmz1OW0t6d5uEoMgzMtgJ2SvdlxvQYVsQGOXonxOhM5vceJ4OjKduomIs0FBK5O
	ErNATLeR73FJxbRw==
X-Received: by 2002:a05:600c:5250:b0:493:b771:de06 with SMTP id 5b1f17b1804b1-493bda3863fmr1280945e9.5.1782817019802;
        Tue, 30 Jun 2026 03:56:59 -0700 (PDT)
Received: from builder ([2001:9e8:f11a:416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0bbbcsm70701085e9.13.2026.06.30.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:56:59 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
Date: Tue, 30 Jun 2026 10:56:49 +0000
Message-ID: <20260630105651.756058-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630105651.756058-1-jelonek.jonas@gmail.com>
References: <20260630105651.756058-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303085-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonek.jonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,mork.no,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devicetree.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9859A6E3645

Add a binding for the microcontroller (MCU) that fronts the PSE silicon
on a range of managed switches. The host talks only to the MCU, over
I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
behind it never appear on the bus.

The compatible names the MCU front-end, not a specific part. These
boards front the PSE silicon with an MCU that presents a stable
message protocol Realtek documents. The PSE chip behind it varies
- Broadcom on older boards, Realtek on newer - and is detected at
runtime; the arrangement appears to be a Realtek MCU-based PoE design
carried across those PSE-chip generations. So the 'realtek' prefix
names that front-end (Realtek's protocol and firmware), not the
general-purpose MCU silicon or the PSE chip - the google,cros-ec-*
model. The '-rtk'/'-brcm' suffix selects the Realtek or Broadcom dialect.

A single compatible per dialect covers both the I2C/SMBus and UART
attachments: the wire protocol is identical across them and the transport
is expressed by the node's parent bus, so it is not encoded in the
compatible.

Both dialects share one protocol family and one device tree contract, so
they are documented in a single binding under the one 'realtek' prefix,
with the '-rtk'/'-brcm' suffix distinguishing the dialect.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
new file mode 100644
index 000000000000..3a414ef38922
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek/Broadcom PSE MCU
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description: |
+  Microcontroller (MCU) that fronts the PSE hardware on switches using
+  Realtek (RTL8238B, RTL8239, RTL8239C) or Broadcom (BCM59111, BCM59121)
+  PSE chips. The MCU exposes a small message-based protocol over either
+  I2C/SMBus or UART; the actual PSE silicon is not accessed directly. The
+  Realtek and Broadcom variants share this device tree contract but use
+  different protocol opcodes, selected by the compatible.
+
+  The compatible identifies the PSE-MCU protocol dialect, not a specific
+  part. The device here is the MCU: it presents a stable message protocol
+  documented by Realtek, with the PSE silicon behind it - Broadcom on
+  older boards, Realtek on newer - detected at runtime and not described
+  here. The MCU's own silicon is general-purpose and varies across
+  boards, so the 'realtek' vendor prefix names the protocol front-end
+  (following the google,cros-ec pattern); the '-rtk'/'-bcm' suffix
+  selects the Realtek or Broadcom dialect.
+
+  A single compatible per dialect covers both the I2C/SMBus and UART
+  attachments: the wire protocol is identical across them and the
+  transport is already expressed by the node's parent bus, so it is not
+  encoded in the compatible. Transport-specific properties differ
+  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
+  'realtek,i2c-protocol'), while the UART attachment carries the serial
+  peripheral properties such as 'current-speed'.
+
+properties:
+  compatible:
+    enum:
+      - realtek,pse-mcu-rtk
+      - realtek,pse-mcu-brcm
+
+  reg:
+    maxItems: 1
+
+  power-supply:
+    description: Regulator supplying the PoE power rail.
+
+  enable-gpios:
+    maxItems: 1
+
+  realtek,i2c-protocol:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ i2c, smbus ]
+    description: |
+      Wire framing the MCU firmware expects on the I2C bus. "smbus" means
+      reads carry a leading command byte (0x00) and a repeated start; "i2c"
+      means bare 12-byte writes and reads with no command prefix. Only
+      applies to the Realtek I2C attachment.
+
+required:
+  - compatible
+
+allOf:
+  - $ref: pse-controller.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+  # The I2C attachment (identified by 'reg') cannot carry serial bus props.
+  - if:
+      required: [reg]
+    then:
+      properties:
+        current-speed: false
+        max-speed: false
+  # 'realtek,i2c-protocol' is meaningful only for the Realtek I2C attachment;
+  # the Broadcom variant and any UART attachment must not carry it.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,pse-mcu-rtk
+      required: [reg]
+    then:
+      required:
+        - realtek,i2c-protocol
+    else:
+      properties:
+        "realtek,i2c-protocol": false
+
+unevaluatedProperties: false
+
+examples:
+  # Realtek PSE chip, I2C attachment (SMBus framing).
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "realtek,pse-mcu-rtk";
+            reg = <0x20>;
+            realtek,i2c-protocol = "smbus";
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # Broadcom PSE chip, I2C attachment.
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@20 {
+            compatible = "realtek,pse-mcu-brcm";
+            reg = <0x20>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
+
+  # Realtek PSE chip, UART attachment.
+  - |
+    serial {
+        ethernet-pse {
+            compatible = "realtek,pse-mcu-rtk";
+            current-speed = <115200>;
+
+            pse-pis {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                pse-pi@0 {
+                    reg = <0>;
+                    #pse-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.51.0


