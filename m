Return-Path: <netdev+bounces-170814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E543A4A078
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3193B7080
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D126B0A1;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMiuDfHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3361A8F9E;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763973; cv=none; b=Wp0ZnWc4JxAmLRB48p2bdYEAlrk2CYis+lQKavXk7g2o7291SStxOTtofGEi9wz93UEOEnkNCaPM8Q+eVDd5tavD0rgO5gZK7Nydr7RfFdR08IM7RqzReKQRoR6uaQOcBQFSMgjpd/v9Uvw2JY7EjPefZFTLIB9XVsxpS4k1Uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763973; c=relaxed/simple;
	bh=ReYk6jJVsIMYTOIoTQKPS1h5Xno1Ot4VEYyDgi6Urow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tc84SRtddOLdgVtt21K06imeZpGF1iEV7bRsLGSV2C6VSYeJWssNV/UElDecv8nXkNEMLiGUQ72BGT9ROopjD5NwXZgUaMBR464WY0GH830GmiXMsMrbqnKaMk217BX6mquS06yM3QSpc2NVIMK6E5ZYlqvy6HGskPawgx8lLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMiuDfHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26895C4CEEB;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763973;
	bh=ReYk6jJVsIMYTOIoTQKPS1h5Xno1Ot4VEYyDgi6Urow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WMiuDfHrsOTOiT9fkYgQcZe6NWwgSscn2LOTGDEhybHKG6aQfvaeyuFa1B//u6JAk
	 y5V20oVeInfRPcosZEE2Fhz5wbJsM72uQPVtawaq7iL7iaXkp/EvZuv/t/EhomPjt3
	 MadxB2L9fZSkj3uJuEEHoiWS9JuMXT+Lhm/sK5kTZ5T2kWtKEMAoRN6cGM9kFFd75p
	 sojJmNnkt90L6gon/Bu5x92YCm6lIKZrbmGSsBB45hLPXDS70iv6eV97+UjSVUnuJA
	 x6KexAn3TVmtybmXGhTCrgq8vo4JL1u+UPgqUYrigLQN7bRL8eSYJbE6YVdXQO1YrN
	 171FdClvzYKyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0EC282D0;
	Fri, 28 Feb 2025 17:32:53 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 18:32:52 +0100
Subject: [PATCH v2 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-gianfar-yaml-v2-3-6beeefbd4818@posteo.net>
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
In-Reply-To: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740763971; l=10323;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=PHFK6ij47fbj4JmpPy2/3CUOBG49DJDpgjnVIZVn6QQ=;
 b=/VCBlPdyWnO80kkJilZJV3r7UrvAJMz/C62Cpa6Havos22nHsYpxfX9+n0fs3K7MvWyWRg7bB
 4lX/n31JzqxDaPlu/qLMfY6ZqyymJoP+2sELoQ1YS5WqAvKhIeh+0aS
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Add a binding for the "Gianfar" ethernet controller, also known as
TSEC/eTSEC.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- change MAC address in example to 00:00:00:00:00:00 instead of a real
  Motorola MAC address (suggested by Andrew Lunn)
- add constraints to #address/size-cells, fsl,num_tr/rx_queues
- remove unnecessary type from dma-coherent
- add minItems to interrupts
- remove unnecessary #address/size-cells from queue-group@.*
- describe interrupts of queue-group@.*
- remove unnecessary bus in example
- consistently use "type: boolean" for fsl,magic-packet,
  instead of "$ref: /schemas/types.yaml#/definitions/flag"
- fix name of rx-stash-idx property
- fix type of rx-stash-len/idx properties
- actually reference fsl,gianfar-mdio schema for mdio@.* subnodes
- disambiguate compatible = "gianfar" schemas by using a "select:" schema
---
 .../devicetree/bindings/net/fsl,gianfar.yaml       | 248 +++++++++++++++++++++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
 2 files changed, 249 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f92f284aa05b0ee34e331661308b7258cbda43c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
@@ -0,0 +1,248 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Three-Speed Ethernet Controller (TSEC), "Gianfar"
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+# This is needed to distinguish gianfar.yaml and gianfar-mdio.yaml, because
+# both use compatible = "gianfar" (with different device_type values)
+select:
+  oneOf:
+    - properties:
+        compatible:
+          contains:
+            const: gianfar
+        device_type:
+          const: network
+      required:
+        - device_type
+
+    - properties:
+        compatible:
+          const: fsl,etsec2
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    enum:
+      - gianfar
+      - fsl,etsec2
+
+  device_type:
+    const: network
+
+  model:
+    enum:
+      - FEC
+      - TSEC
+      - eTSEC
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Transmit interrupt or single combined interrupt
+      - description: Receive interrupt
+      - description: Error interrupt
+
+  dma-coherent: true
+
+  fsl,magic-packet:
+    type: boolean
+    description:
+      If present, indicates that the hardware supports waking up via magic packet.
+
+  fsl,wake-on-filer:
+    type: boolean
+    description:
+      If present, indicates that the hardware supports waking up by Filer
+      General Purpose Interrupt (FGPI) asserted on the Rx int line. This is
+      an advanced power management capability allowing certain packet types
+      (user) defined by filer rules to wake up the system.
+
+  bd-stash:
+    type: boolean
+    description:
+      If present, indicates that the hardware supports stashing buffer
+      descriptors in the L2.
+
+  rx-stash-len:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Denotes the number of bytes of a received buffer to stash in the L2.
+
+  rx-stash-idx:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Denotes the index of the first byte from the received buffer to stash in
+      the L2.
+
+  fsl,num_rx_queues:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of receive queues
+    const: 8
+
+  fsl,num_tx_queues:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of transmit queues
+    const: 8
+
+  tbi-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference (phandle) to the TBI node
+
+required:
+  - compatible
+  - model
+
+patternProperties:
+  "^mdio@[0-9a-f]+$":
+    $ref: /schemas/net/fsl,gianfar-mdio.yaml#
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+  # eTSEC2 controller nodes have "queue group" subnodes and don't need a "reg"
+  # property.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,etsec2
+    then:
+      patternProperties:
+        "^queue-group@[0-9a-f]+$":
+          type: object
+
+          properties:
+            reg:
+              maxItems: 1
+
+            interrupts:
+              items:
+                - description: Transmit interrupt
+                - description: Receive interrupt
+                - description: Error interrupt
+
+          required:
+            - reg
+            - interrupts
+
+          additionalProperties: false
+    else:
+      required:
+        - reg
+
+  # TSEC and eTSEC devices require three interrupts
+  - if:
+      properties:
+        model:
+          contains:
+            enum: [ TSEC, eTSEC ]
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Transmit interrupt
+            - description: Receive interrupt
+            - description: Error interrupt
+
+
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@24000 {
+        device_type = "network";
+        model = "TSEC";
+        compatible = "gianfar";
+        reg = <0x24000 0x1000>;
+        local-mac-address = [ 00 00 00 00 00 00 ];
+        interrupts = <29 2>, <30 2>, <34 2>;
+        interrupt-parent = <&mpic>;
+        phy-handle = <&phy0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@24000 {
+        compatible = "gianfar";
+        reg = <0x24000 0x1000>;
+        ranges = <0x0 0x24000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        cell-index = <0>;
+        device_type = "network";
+        model = "eTSEC";
+        local-mac-address = [ 00 00 00 00 00 00 ];
+        interrupts = <32 IRQ_TYPE_LEVEL_LOW>,
+                     <33 IRQ_TYPE_LEVEL_LOW>,
+                     <34 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+
+        mdio@520 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "fsl,gianfar-mdio";
+            reg = <0x520 0x20>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ethernet {
+            compatible = "fsl,etsec2";
+            ranges;
+            device_type = "network";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            interrupt-parent = <&gic>;
+            model = "eTSEC";
+            fsl,magic-packet;
+            dma-coherent;
+
+            queue-group@2d10000 {
+                reg = <0x0 0x2d10000 0x0 0x1000>;
+                interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+            };
+
+            queue-group@2d14000  {
+                reg = <0x0 0x2d14000 0x0 0x1000>;
+                interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 0e55e0af7d6f59cfb571dd3fcff704b7f4c140d2..b18bb4c997ea3a221e599f694d9a28692cbcaa7c 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -8,44 +8,7 @@ Refer to Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
 
 * Gianfar-compatible ethernet nodes
 
-Properties:
-
-  - device_type : Should be "network"
-  - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
-  - compatible : Should be "gianfar"
-  - reg : Offset and length of the register set for the device
-  - interrupts : For FEC devices, the first interrupt is the device's
-    interrupt.  For TSEC and eTSEC devices, the first interrupt is
-    transmit, the second is receive, and the third is error.
-  - phy-handle : See ethernet.txt file in the same directory.
-  - fixed-link : See fixed-link.txt in the same directory.
-  - phy-connection-type : See ethernet.txt file in the same directory.
-    This property is only really needed if the connection is of type
-    "rgmii-id", as all other connection types are detected by hardware.
-  - fsl,magic-packet : If present, indicates that the hardware supports
-    waking up via magic packet.
-  - fsl,wake-on-filer : If present, indicates that the hardware supports
-    waking up by Filer General Purpose Interrupt (FGPI) asserted on the
-    Rx int line.  This is an advanced power management capability allowing
-    certain packet types (user) defined by filer rules to wake up the system.
-  - bd-stash : If present, indicates that the hardware supports stashing
-    buffer descriptors in the L2.
-  - rx-stash-len : Denotes the number of bytes of a received buffer to stash
-    in the L2.
-  - rx-stash-idx : Denotes the index of the first byte from the received
-    buffer to stash in the L2.
-
-Example:
-	ethernet@24000 {
-		device_type = "network";
-		model = "TSEC";
-		compatible = "gianfar";
-		reg = <0x24000 0x1000>;
-		local-mac-address = [ 00 E0 0C 00 73 00 ];
-		interrupts = <29 2 30 2 34 2>;
-		interrupt-parent = <&mpic>;
-		phy-handle = <&phy0>
-	};
+Refer to Documentation/devicetree/bindings/net/fsl,gianfar.yaml
 
 * Gianfar PTP clock nodes
 

-- 
2.48.0.rc1.219.gb6b6757d772



