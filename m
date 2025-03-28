Return-Path: <netdev+bounces-178106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5FEA74B8B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D2F17DF66
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E111B3927;
	Fri, 28 Mar 2025 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZAbbcHvs"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37C1531C5;
	Fri, 28 Mar 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168976; cv=none; b=PeYAtp3zuWlJYn4jwEeW49N/9CtW4g2bsawlbSOuxsTKkpZrmB427wwDPiYhirhkM1WSwJ8+YzXYvlhBgfAWgwL0Fr4FiYrbQ3LrwFDTDh8ypF76oa6wrqqX77ebK5e6U0zzujVjSRXt3a7f9mzypA3o4NojzNlpyegIThpCLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168976; c=relaxed/simple;
	bh=DCUexFhbN7ivgcQYV/g2H0red4+RRpwP+jSnEKv5YPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/MKWNtQ0rBOrjOx238G2FhT67ODdTfgfonoHcKiR6J5wJKsqvHlxPphcXNf1i8FeQ4SaDOcLUcTeLMQI3w1vp8A7jhKUZbejcw32TUZ2Y+yD9LsMuSxfzKSRSPZEejC/zukkbHraRUqoIdD5oMsvuG4zFaMk4U5OW7JrZ1i6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZAbbcHvs; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC6A410269950;
	Fri, 28 Mar 2025 14:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743168972; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cJ3W5JisVkbAiPCC2XiqtflmsmYcbA34dMvHMgMfpkA=;
	b=ZAbbcHvs1OaQEzZAkuUy+yJMkrUU0vp07maxHX6FAYQxhknpWNTO+cuNarA6Ks77z7L4TQ
	CorZRGe4dlREdV5SVfRA0YSOkYdCm0+oqzOqlmH5tf2GloLSlQ2HgcE8fJkDqTkQpzqme9
	HETUtvp/XJda6fWWkbgjbQjRwkbRig/yw+cJs+R+LMRgYYbqIXR3dC5qe5n+XGXG3dsZlM
	dxu1yTs2S0qi5eT+n1qLeiaM5B9Ii1ZO5IDpmzjNvSMRm6DM1IBJCQaNftTLJKMablWjjj
	mLraxnVg73F9NpAhhUdKkK81avPVc0rbJvC9hKzUEHkzipBqC3om6YzGcA5r8w==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Date: Fri, 28 Mar 2025 14:35:41 +0100
Message-Id: <20250328133544.4149716-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250328133544.4149716-1-lukma@denx.de>
References: <20250328133544.4149716-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch provides description of the MTIP L2 switch available in some
NXP's SOCs - e.g. imx287.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Rename the file to match exactly the compatible
  (nxp,imx287-mtip-switch)
---
 .../bindings/net/nxp,imx287-mtip-switch.yaml  | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
new file mode 100644
index 000000000000..a3e0fe7783ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,imx287-mtip-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+description:
+  The 2-port switch ethernet subsystem provides ethernet packet (L2)
+  communication and can be configured as an ethernet switch. It provides the
+  reduced media independent interface (RMII), the management data input
+  output (MDIO) for physical layer device (PHY) management.
+
+properties:
+  compatible:
+    const: nxp,imx287-mtip--switch
+
+  reg:
+    maxItems: 1
+    description:
+      The physical base address and size of the MTIP L2 SW module IO range
+
+  phy-supply:
+    description:
+      Regulator that powers Ethernet PHYs.
+
+  clocks:
+    items:
+      - description: Register accessing clock
+      - description: Bus access clock
+      - description: Output clock for external device - e.g. PHY source clock
+      - description: IEEE1588 timer clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+      - const: enet_out
+      - const: ptp
+
+  interrupts:
+    items:
+      - description: Switch interrupt
+      - description: ENET0 interrupt
+      - description: ENET1 interrupt
+
+  pinctrl-names: true
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-9]+$":
+        type: object
+        description: MTIP L2 switch external ports
+
+        $ref: ethernet-controller.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            items:
+              - enum: [1, 2]
+            description: MTIP L2 switch port number
+
+          label:
+            description: Label associated with this port
+
+        required:
+          - reg
+          - label
+          - phy-mode
+          - phy-handle
+
+  mdio:
+    type: object
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Specifies the mdio bus in the switch, used as a container for phy nodes.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - mdio
+  - ethernet-ports
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include<dt-bindings/interrupt-controller/irq.h>
+    switch@800f0000 {
+        compatible = "nxp,imx287-mtip-switch";
+        reg = <0x800f0000 0x20000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+        phy-supply = <&reg_fec_3v3>;
+        interrupts = <100>, <101>, <102>;
+        clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+        clock-names = "ipg", "ahb", "enet_out", "ptp";
+        status = "okay";
+
+        ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mtip_port1: port@1 {
+                        reg = <1>;
+                        label = "lan0";
+                        local-mac-address = [ 00 00 00 00 00 00 ];
+                        phy-mode = "rmii";
+                        phy-handle = <&ethphy0>;
+                };
+
+                mtip_port2: port@2 {
+                        reg = <2>;
+                        label = "lan1";
+                        local-mac-address = [ 00 00 00 00 00 00 ];
+                        phy-mode = "rmii";
+                        phy-handle = <&ethphy1>;
+                };
+        };
+
+        mdio_sw: mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reset-gpios = <&gpio2 13 0>;
+                reset-delay-us = <25000>;
+                reset-post-delay-us = <10000>;
+
+                ethphy0: ethernet-phy@0 {
+                        reg = <0>;
+                        smsc,disable-energy-detect;
+                        /* Both PHYs (i.e. 0,1) have the same, single GPIO, */
+                        /* line to handle both, their interrupts (AND'ed) */
+                        interrupt-parent = <&gpio4>;
+                        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+                };
+
+                ethphy1: ethernet-phy@1 {
+                        reg = <1>;
+                        smsc,disable-energy-detect;
+                        interrupt-parent = <&gpio4>;
+                        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+                };
+        };
+    };
-- 
2.39.5


