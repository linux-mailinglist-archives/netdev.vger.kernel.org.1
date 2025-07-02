Return-Path: <netdev+bounces-203537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147BAF6530
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CD4486EC9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2326B960;
	Wed,  2 Jul 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR+3u2IO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15324E01F;
	Wed,  2 Jul 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495200; cv=none; b=P32a7eUNNe2odY4ivqzn0veg2SaVFYu7rF5VxzosURlDIUXHiXLdENTgrWQ5Txy7atb0rKzZfsM+uxkfHDC1XN4YOvyf4BHjgA7PVGSeqNfyi1C3rWMSIcZvE1/nTHd9BiV/hsGuso8UXWspNYmZvZZIzVOfq4548tDMWpD97MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495200; c=relaxed/simple;
	bh=qycsZr+lcd6kILxhf/Lt8ju90j4/nzR6AMhAdaCKaqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJg4OhzZfNRbBg2LcTqVeXUzdm53sMrFaTEEZiiZG1tzZQ3rxuoTkPmSbYP7ClrAoTIU2gXm0NZKS+eSO7WXs0NkR2MDMmb8HXFIONiQ8wObzY3nuJnjJsHoeBvlhuaJTAOqU+tbeA0at5436stNNLUxTankfLRs0JNRkh5vnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR+3u2IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2527C4CEF0;
	Wed,  2 Jul 2025 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495199;
	bh=qycsZr+lcd6kILxhf/Lt8ju90j4/nzR6AMhAdaCKaqI=;
	h=From:To:Cc:Subject:Date:From;
	b=eR+3u2IODuxJzvOeghOYQ4bDvhLLZIqeRVCkqj3Rlcc3sBmBzet0EQppAzkWUNmOI
	 LtGtQ9SE+0IZhFaZTor+32Xic/Esz4XANfod+gTZA1Mvq30131pTW6vDtnPOZMTfq7
	 uddo+Oq3SSO62PfPixsJ3Ip7lmkS12Hk78K3555I0BxJOhT6tnBgiQeggKO6bTkGPM
	 AlQfix15KlTCeLuVRBVhGzOMj/r3oXHCZck1CvkHq9uBiEkkDIB7Opvh0n3TkU2gHy
	 S3U1zwiIo5h4ePEQZyNHMUBfopML/vOT9yQF8HYTOBtJFGCnzEKwCTCRSWUFayZkDo
	 uxQtMkGrdfRNQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: Convert Marvell Armada NETA and BM to DT schema
Date: Wed,  2 Jul 2025 17:26:24 -0500
Message-ID: <20250702222626.2761199-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Marvell Armada NETA Ethernet Controller and Buffer Manager
bindings to schema. It is a straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/marvell,armada-370-neta.yaml | 79 +++++++++++++++++++
 .../net/marvell,armada-380-neta-bm.yaml       | 60 ++++++++++++++
 .../bindings/net/marvell-armada-370-neta.txt  | 50 ------------
 .../bindings/net/marvell-neta-bm.txt          | 47 -----------
 .../devicetree/bindings/vendor-prefixes.yaml  |  1 +
 5 files changed, 140 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml
 create mode 100644 Documentation/devicetree/bindings/net/marvell,armada-380-neta-bm.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-neta-bm.txt

diff --git a/Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml b/Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml
new file mode 100644
index 000000000000..8814977da024
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell,armada-370-neta.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 370/XP/3700/AC5 Ethernet Controller (NETA)
+
+maintainers:
+  - Marcin Wojtas <marcin.s.wojtas@gmail.com>
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-370-neta
+      - marvell,armada-xp-neta
+      - marvell,armada-3700-neta
+      - marvell,armada-ac5-neta
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: bus
+
+  phys:
+    maxItems: 1
+
+  tx-csum-limit:
+    description: Maximum MTU in bytes for Tx checksum offload; default is 1600 for
+      armada-370-neta and 9800 for others.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  buffer-manager:
+    description: Phandle to hardware buffer manager.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  bm,pool-long:
+    description: Pool ID for packets larger than the short threshold.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  bm,pool-short:
+    description: Pool ID for packets smaller than the long threshold.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@70000 {
+        compatible = "marvell,armada-370-neta";
+        reg = <0x70000 0x2500>;
+        interrupts = <8>;
+        clocks = <&gate_clk 4>;
+        tx-csum-limit = <9800>;
+        phy = <&phy0>;
+        phy-mode = "rgmii-id";
+        buffer-manager = <&bm>;
+        bm,pool-long = <0>;
+        bm,pool-short = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/net/marvell,armada-380-neta-bm.yaml b/Documentation/devicetree/bindings/net/marvell,armada-380-neta-bm.yaml
new file mode 100644
index 000000000000..9392e7126e3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,armada-380-neta-bm.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell,armada-380-neta-bm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 380/XP Buffer Manager (BM)
+
+maintainers:
+  - Marcin Wojtas <marcin.s.wojtas@gmail.com>
+
+description:
+  In order to see how to hook the BM to a given ethernet port, please refer to
+  Documentation/devicetree/bindings/net/marvell,armada-370-neta.yaml.
+
+properties:
+  compatible:
+    const: marvell,armada-380-neta-bm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  internal-mem:
+    description: Phandle to internal SRAM region
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  "^pool[0-3],capacity$":
+    description:
+      size of external buffer pointers' ring maintained in DRAM for pool 0-3
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 128
+    maximum: 16352
+
+  "^pool[0-3],pkt-size$":
+    description:
+      maximum packet size for a short buffer pool entry (pool 0-3)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - internal-mem
+
+additionalProperties: false
+
+examples:
+  - |
+    bm@c8000 {
+        compatible = "marvell,armada-380-neta-bm";
+        reg = <0xc8000 0xac>;
+        clocks = <&gateclk 13>;
+        internal-mem = <&bm_bppi>;
+        pool2,capacity = <4096>;
+        pool1,pkt-size = <512>;
+    };
diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
deleted file mode 100644
index 2bf31572b08d..000000000000
--- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Marvell Armada 370 / Armada XP / Armada 3700 Ethernet Controller (NETA)
-
-Required properties:
-- compatible: could be one of the following:
-	"marvell,armada-370-neta"
-	"marvell,armada-xp-neta"
-	"marvell,armada-3700-neta"
-	"marvell,armada-ac5-neta"
-- reg: address and length of the register set for the device.
-- interrupts: interrupt for the device
-- phy: See ethernet.txt file in the same directory.
-- phy-mode: See ethernet.txt file in the same directory
-- clocks: List of clocks for this device. At least one clock is
-  mandatory for the core clock. If several clocks are given, then the
-  clock-names property must be used to identify them.
-
-Optional properties:
-- tx-csum-limit: maximum mtu supported by port that allow TX checksum.
-  Value is presented in bytes. If not used, by default 1600B is set for
-  "marvell,armada-370-neta" and 9800B for others.
-- clock-names: List of names corresponding to clocks property; shall be
-  "core" for core clock and "bus" for the optional bus clock.
-- phys: comphy for the ethernet port, see ../phy/phy-bindings.txt
-
-Optional properties (valid only for Armada XP/38x):
-
-- buffer-manager: a phandle to a buffer manager node. Please refer to
-  Documentation/devicetree/bindings/net/marvell-neta-bm.txt
-- bm,pool-long: ID of a pool, that will accept all packets of a size
-  higher than 'short' pool's threshold (if set) and up to MTU value.
-  Obligatory, when the port is supposed to use hardware
-  buffer management.
-- bm,pool-short: ID of a pool, that will be used for accepting
-  packets of a size lower than given threshold. If not set, the port
-  will use a single 'long' pool for all packets, as defined above.
-
-Example:
-
-ethernet@70000 {
-	compatible = "marvell,armada-370-neta";
-	reg = <0x70000 0x2500>;
-	interrupts = <8>;
-	clocks = <&gate_clk 4>;
-	tx-csum-limit = <9800>
-	phy = <&phy0>;
-	phy-mode = "rgmii-id";
-	buffer-manager = <&bm>;
-	bm,pool-long = <0>;
-	bm,pool-short = <1>;
-};
diff --git a/Documentation/devicetree/bindings/net/marvell-neta-bm.txt b/Documentation/devicetree/bindings/net/marvell-neta-bm.txt
deleted file mode 100644
index 07b31050dbe5..000000000000
--- a/Documentation/devicetree/bindings/net/marvell-neta-bm.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Marvell Armada 380/XP Buffer Manager driver (BM)
-
-Required properties:
-
-- compatible: should be "marvell,armada-380-neta-bm".
-- reg: address and length of the register set for the device.
-- clocks: a pointer to the reference clock for this device.
-- internal-mem: a phandle to BM internal SRAM definition.
-
-Optional properties (port):
-
-- pool<0 : 3>,capacity: size of external buffer pointers' ring maintained
-  in DRAM. Can be set for each pool (id 0 : 3) separately. The value has
-  to be chosen between 128 and 16352 and it also has to be aligned to 32.
-  Otherwise the driver would adjust a given number or choose default if
-  not set.
-- pool<0 : 3>,pkt-size: maximum size of a packet accepted by a given buffer
-  pointers' pool (id 0 : 3). It will be taken into consideration only when pool
-  type is 'short'. For 'long' ones it would be overridden by port's MTU.
-  If not set a driver will choose a default value.
-
-In order to see how to hook the BM to a given ethernet port, please
-refer to Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt.
-
-Example:
-
-- main node:
-
-bm: bm@c8000 {
-	compatible = "marvell,armada-380-neta-bm";
-	reg = <0xc8000 0xac>;
-	clocks = <&gateclk 13>;
-	internal-mem = <&bm_bppi>;
-	pool2,capacity = <4096>;
-	pool1,pkt-size = <512>;
-};
-
-- internal SRAM node:
-
-bm_bppi: bm-bppi {
-	compatible = "mmio-sram";
-	reg = <MBUS_ID(0x0c, 0x04) 0 0x100000>;
-	ranges = <0 MBUS_ID(0x0c, 0x04) 0 0x100000>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	clocks = <&gateclk 13>;
-};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..741b545e3ab0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -21,6 +21,7 @@ patternProperties:
   "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
   "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
+  "^pool[0-3],.*": true
 
   # Keep list in alphabetical order.
   "^100ask,.*":
-- 
2.47.2


