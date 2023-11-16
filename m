Return-Path: <netdev+bounces-48356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EAF7EE23C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0A281652
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCE341AD;
	Thu, 16 Nov 2023 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ODw5g4sL"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94C126;
	Thu, 16 Nov 2023 06:02:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A748920014;
	Thu, 16 Nov 2023 14:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700143322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDLL8bwTXVC8EKzN/n6gJhzYK7ZlNBXdKe0SkjNtub4=;
	b=ODw5g4sLNn3Mqn2p/NesO2b4AEXn/DH50z9zdbOgsCrCX480Vv0ZLBgdgl+QHH+c6ERGKR
	rZcsdluHzWcmmkdCgE1Ey60peVVmgoFJIeb8rDt84/Zp6XJhZFRq90rMM7sc0UIdt3ojP5
	m9bmoRr4WMFHZNncxn9H/TBdVcU3kbOd6NeHeHLDjL7vzYz16CFOi09Mm5U/tnU3hoebxH
	ohJdJCQSeMorWvh9v08aCpRzPFCULBkQ6Bxu1pdGHFdIgVJkqyqQ+p4WpZjLhS8qsQMl3M
	iAwzIwzcagwvaNHIDhhTz3ZI6o/hzJO06wSWp0tFU7VAwsUYfOwUVT/O+qmMJA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 16 Nov 2023 15:01:40 +0100
Subject: [PATCH net-next 8/9] dt-bindings: net: pse-pd: Add bindings for
 PD692x0 PSE controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-feature_poe-v1-8-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Add the PD692x0 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 .../bindings/net/pse-pd/microchip,pd692x0_i2c.yaml | 70 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml
new file mode 100644
index 000000000000..c42bbc427988
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0_i2c.yaml#
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
+    description: Port conversion matrix configuration
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
+additionalProperties: false
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
index 350d00657f6b..1e154dacef67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14248,6 +14248,12 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/8250/8250_pci1xxxx.c
 
+MICROCHIP PD692X0 PSE DRIVER
+M:	Kory Maincent <kory.maincent@bootlin.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0_i2c.yaml
+
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
 R:	Vladimir Georgiev <v.georgiev@metrotek.ru>

-- 
2.25.1


