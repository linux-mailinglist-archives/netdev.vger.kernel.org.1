Return-Path: <netdev+bounces-218370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9479B3C3C2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F427561E9E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575032C33B;
	Fri, 29 Aug 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+xd/nwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904D4A11;
	Fri, 29 Aug 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499301; cv=none; b=hBLUWW9LYqQurDUO+uZl3GU85qYDk4/DEYrePHTzS6rx26OdVrY6Nzq8ufqox90vFfCyU4aT05mrs7Mny66vER3eSEbkW7DP3+1bKxzlOgHxYBcGa526nFnSN+2n0W+v8MQTwtPuIie8vCmANRY1DoJ6ad7TVSV0ZFXg/lkS8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499301; c=relaxed/simple;
	bh=d0JZekqZcXgo1/gtBUM1OWdMh6c9JrNq5aDoMU8c6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7uBInZ5azgIXfFUBpJBreAM3kEw9VTn+h5E1KlrdMEeeK3Cnlt12CxL6DiGWoif8zTuLqgDwrjV17Frd9lYen1biboLjeLBFxMTQyX5x7lSpYmOU+/7O400LraZTA+8v2q3fVdsj8ilnhRYOb84ju8gvRPI4b8ACSJpH5hOpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+xd/nwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03ACC4CEF0;
	Fri, 29 Aug 2025 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499301;
	bh=d0JZekqZcXgo1/gtBUM1OWdMh6c9JrNq5aDoMU8c6gA=;
	h=From:To:Cc:Subject:Date:From;
	b=g+xd/nwV7JxIjYm4FLh5FG6QFwUC3ix6/5Sr6jruYMi3hA3gT0nUx01sYbc1kd2Km
	 L8SRwr+5WNvlC6SSzN8G5C359MH0TYIkSbWFlb+53V5FZTRzfXBiObjCTmdQDjT8lp
	 iNIhNfK2OW9q/1bqyi/dkpYsm6C3t7UqVZ7W6b5+5zkEbNM4awNexQlp3kS6ktcYhs
	 KzVwhtSMsalH0sGJooWHQAvrJiVBP64eQUgqFFofGQvmHaKu3vWJOvKc2gRq8Rw7zE
	 oxRNC2Jsn0iifbk9E0w9KKuZxV5mlgGeOqAV2lODacT+zGSGbpYg2Yrf0HfFswoTaT
	 8x2RDeJS3GfLg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: Convert apm,xgene-enet to DT schema
Date: Fri, 29 Aug 2025 15:28:14 -0500
Message-ID: <20250829202817.1271907-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the APM XGene Ethernet binding to DT schema format.

Add the missing apm,xgene2-sgenet and apm,xgene2-xgenet compatibles.
Drop "reg-names" as required. Add support for up to 16 interrupts.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/apm,xgene-enet.yaml          | 114 ++++++++++++++++++
 .../bindings/net/apm-xgene-enet.txt           |  91 --------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 115 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt

diff --git a/Documentation/devicetree/bindings/net/apm,xgene-enet.yaml b/Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
new file mode 100644
index 000000000000..307126852df4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/apm,xgene-enet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC Ethernet
+
+maintainers:
+  - Iyappan Subramanian <iyappan@os.amperecomputing.com>
+  - Keyur Chudgar <keyur@os.amperecomputing.com>
+  - Quan Nguyen <quan@os.amperecomputing.com>
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - apm,xgene-enet
+      - apm,xgene1-sgenet
+      - apm,xgene1-xgenet
+      - apm,xgene2-sgenet
+      - apm,xgene2-xgenet
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: enet_csr
+      - const: ring_csr
+      - const: ring_cmd
+
+  clocks:
+    maxItems: 1
+
+  dma-coherent: true
+
+  interrupts:
+    description: An rx and tx completion interrupt pair per queue
+    minItems: 1
+    maxItems: 16
+
+  channel:
+    description: Ethernet to CPU start channel number
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  port-id:
+    description: Port number
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1
+
+  tx-delay:
+    description: Delay value for RGMII bridge TX clock
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 4
+
+  rx-delay:
+    description: Delay value for RGMII bridge RX clock
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 2
+
+  rxlos-gpios:
+    description: Input GPIO from SFP+ module indicating incoming signal
+    maxItems: 1
+
+  mdio:
+    description: MDIO bus subnode
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: apm,xgene-mdio
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@17020000 {
+        compatible = "apm,xgene-enet";
+        reg = <0x17020000 0xd100>,
+              <0x17030000 0x400>,
+              <0x10000000 0x200>;
+        reg-names = "enet_csr", "ring_csr", "ring_cmd";
+        interrupts = <0x0 0x3c 0x4>;
+        channel = <0>;
+        port-id = <0>;
+        clocks = <&menetclk 0>;
+        local-mac-address = [00 01 73 00 00 01];
+        phy-connection-type = "rgmii";
+        phy-handle = <&menetphy>;
+
+        mdio {
+            compatible = "apm,xgene-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            menetphy: ethernet-phy-id001c.c915@3 {
+                compatible = "ethernet-phy-id001c.c915";
+                reg = <3>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
deleted file mode 100644
index f591ab782dbc..000000000000
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-APM X-Gene SoC Ethernet nodes
-
-Ethernet nodes are defined to describe on-chip ethernet interfaces in
-APM X-Gene SoC.
-
-Required properties for all the ethernet interfaces:
-- compatible: Should state binding information from the following list,
-  - "apm,xgene-enet":    RGMII based 1G interface
-  - "apm,xgene1-sgenet": SGMII based 1G interface
-  - "apm,xgene1-xgenet": XFI based 10G interface
-- reg: Address and length of the register set for the device. It contains the
-  information of registers in the same order as described by reg-names
-- reg-names: Should contain the register set names
-  - "enet_csr": Ethernet control and status register address space
-  - "ring_csr": Descriptor ring control and status register address space
-  - "ring_cmd": Descriptor ring command register address space
-- interrupts: Two interrupt specifiers can be specified.
-  - First is the Rx interrupt.  This irq is mandatory.
-  - Second is the Tx completion interrupt.
-    This is supported only on SGMII based 1GbE and 10GbE interfaces.
-- channel: Ethernet to CPU, start channel (prefetch buffer) number
-  - Must map to the first irq and irqs must be sequential
-- port-id: Port number (0 or 1)
-- clocks: Reference to the clock entry.
-- local-mac-address: MAC address assigned to this device
-- phy-connection-type: Interface type between ethernet device and PHY device
-
-Required properties for ethernet interfaces that have external PHY:
-- phy-handle: Reference to a PHY node connected to this device
-
-- mdio: Device tree subnode with the following required properties:
-  - compatible: Must be "apm,xgene-mdio".
-  - #address-cells: Must be <1>.
-  - #size-cells: Must be <0>.
-
-  For the phy on the mdio bus, there must be a node with the following fields:
-  - compatible: PHY identifier.  Please refer ./phy.txt for the format.
-  - reg: The ID number for the phy.
-
-Optional properties:
-- status: Should be "ok" or "disabled" for enabled/disabled. Default is "ok".
-- tx-delay: Delay value for RGMII bridge TX clock.
-	    Valid values are between 0 to 7, that maps to
-	    417, 717, 1020, 1321, 1611, 1913, 2215, 2514 ps
-	    Default value is 4, which corresponds to 1611 ps
-- rx-delay: Delay value for RGMII bridge RX clock.
-	    Valid values are between 0 to 7, that maps to
-	    273, 589, 899, 1222, 1480, 1806, 2147, 2464 ps
-	    Default value is 2, which corresponds to 899 ps
-- rxlos-gpios: Input gpio from SFP+ module to indicate availability of
-	       incoming signal.
-
-
-Example:
-	menetclk: menetclk {
-		compatible = "apm,xgene-device-clock";
-		clock-output-names = "menetclk";
-		status = "ok";
-	};
-
-	menet: ethernet@17020000 {
-		compatible = "apm,xgene-enet";
-		status = "disabled";
-		reg = <0x0 0x17020000 0x0 0xd100>,
-		      <0x0 0x17030000 0x0 0x400>,
-		      <0x0 0x10000000 0x0 0x200>;
-		reg-names = "enet_csr", "ring_csr", "ring_cmd";
-		interrupts = <0x0 0x3c 0x4>;
-		port-id = <0>;
-		clocks = <&menetclk 0>;
-		local-mac-address = [00 01 73 00 00 01];
-		phy-connection-type = "rgmii";
-		phy-handle = <&menetphy>;
-		mdio {
-			compatible = "apm,xgene-mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			menetphy: menetphy@3 {
-				compatible = "ethernet-phy-id001c.c915";
-				reg = <0x3>;
-			};
-
-		};
-	};
-
-/* Board-specific peripheral configurations */
-&menet {
-	tx-delay = <4>;
-	rx-delay = <2>;
-        status = "ok";
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf1beb34e51..206ff023f5b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1892,7 +1892,7 @@ M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
 M:	Keyur Chudgar <keyur@os.amperecomputing.com>
 M:	Quan Nguyen <quan@os.amperecomputing.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+F:	Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 F:	drivers/net/ethernet/apm/xgene/
 F:	drivers/net/mdio/mdio-xgene.c
-- 
2.50.1


