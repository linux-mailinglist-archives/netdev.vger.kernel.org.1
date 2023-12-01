Return-Path: <netdev+bounces-53003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBD8010DD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8F01F20F8D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0224EB3C;
	Fri,  1 Dec 2023 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PcRuZpaD"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536910D;
	Fri,  1 Dec 2023 09:11:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE268240008;
	Fri,  1 Dec 2023 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701450702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgST0hNKe0qhK9lhbpBpeQds2KVouuGglu1+ZMwu2Pg=;
	b=PcRuZpaDBqQ/uKhC8W6E3uhr+qrHjuhhKJFAbrdLiLxicIqA7r0Mle5lps7vXD7+mgVBsE
	778xp+Zdc8gGMff6Qm+WkyDVD7FXJ4yn0DhxpTb568r/V27aeesQLxq0Cp5U5IhnahW4QU
	2swnmysuVvmE93wYHD76AmseuVWGilMLuO7Hr8vqvUwmcdSQKooORIYN70Y9Lncl7/Whj2
	6S9zvoBw8i/NWsR8+p/Ok50i8QMh4hmKgAiV18ZuyVTqRUmy9RBf3wgja8UlomyLaETuei
	FnYU0bp/kAvtUtoy/mO4+lTu9273t1h2bvKQpxbHLQgZYXj5qjnX793NlOZZ3w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 01 Dec 2023 18:10:29 +0100
Subject: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings for
 PD692x0 PSE controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
In-Reply-To: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Add the PD692x0 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Enhance ports-matrix description.
- Replace additionalProperties by unevaluatedProperties.
- Drop i2c suffix.
---
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
new file mode 100644
index 000000000000..3ce81cf99215
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PD692x0 Power Sourcing Equipment controller
+
+maintainers:
+  - Kory Maincent <kory.maincent@bootlin.com>
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - microchip,pd69200
+      - microchip,pd69210
+      - microchip,pd69220
+
+  reg:
+    maxItems: 1
+
+  '#pse-cells':
+    const: 1
+
+  ports-matrix:
+    description: each set of 48 logical ports can be assigned to one or two
+      physical ports. Each physical port is wired to a PD69204/8 PoE
+      manager. Using two different PoE managers for one RJ45 port
+      (logical port) is interesting for temperature dissipation.
+      This parameter describes the configuration of the port conversion
+      matrix that establishes the relationship between the 48 logical ports
+      and the available 96 physical ports. Unspecified logical ports will
+      be deactivated.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 48
+    items:
+      items:
+        - description: Logical port number
+          minimum: 0
+          maximum: 47
+        - description: Physical port number A (0xff for undefined)
+          oneOf:
+            - minimum: 0
+              maximum: 95
+            - const: 0xff
+        - description: Physical port number B (0xff for undefined)
+          oneOf:
+            - minimum: 0
+              maximum: 95
+            - const: 0xff
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-pse@3c {
+          compatible = "microchip,pd69200";
+          reg = <0x3c>;
+          #pse-cells = <1>;
+          ports-matrix = <0 2 5
+                          1 3 6
+                          2 0 0xff
+                          3 1 0xff>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e3fd148d462e..b746684f3fd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14235,6 +14235,12 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/8250/8250_pci1xxxx.c
 
+MICROCHIP PD692X0 PSE DRIVER
+M:	Kory Maincent <kory.maincent@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
 R:	Vladimir Georgiev <v.georgiev@metrotek.ru>

-- 
2.25.1


