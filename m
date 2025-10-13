Return-Path: <netdev+bounces-228953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616BCBD65C0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1583C3E5485
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439F725EF87;
	Mon, 13 Oct 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7zRxW/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C171EFFB7;
	Mon, 13 Oct 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391068; cv=none; b=nWzyMNFI6eQNxY0sIpxxP0EBSHSjaoWfg60l+p5+DvmKZpZlGKW6C36idm5G2HGUffZZdHU2ZdtUliC1wjnidiZKrq3/FCgzUdr+/wZjUfHYPjybTIAcJCS3k++NbRjaBcwnQw7ZxR5fNUaU/3QdyY6BSLDHUhoCJimy131riZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391068; c=relaxed/simple;
	bh=tm3f9QBVDbCyS+aclYeJleqzPEQAMHHJG+uDCCqQgJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oy+SGROprWg2gnI2kJxprD6Hr83NlLG9JKN/epdx6UA3RTa7/KSVLXv51YoEc94e2V8qBheSedUjJ7JDk+b/SEuZRaY0fsI+dBjYNl19i38PcVRJ1htt3rDqKYDTgRYaPkF1f2hXUuqC0NRRJCzYFo1BhcDCh7mAV3JHCi7S+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7zRxW/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E89C4CEE7;
	Mon, 13 Oct 2025 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391067;
	bh=tm3f9QBVDbCyS+aclYeJleqzPEQAMHHJG+uDCCqQgJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=C7zRxW/OldpGB6bsfD/E8QfMMDozWGbpvrhvggrI6c16pX5nJxTeKG/l7I5jLnZ5A
	 J7no10m9WIldGd2Nitpbb1L5TL9qRSiZK6+rLLJjmvN7nq9nlfhyiYrr50BOBrFPRM
	 2SHf34MK8GLsHDtdMl/eVRyn6lSS7EOWHBd0/k0boegKSounp7DkKjQjR7Xz16bm29
	 r8aChWUYAZKewzh7z2gb1yclPeiGFZsu3mLjftS5if+ERrktC88amEGljfI48nd+Re
	 2gMkK1K2l6yzKWB8VByTV/Eps7ncrC619KJusYKsE6F3XsPdBizexLgd7R0y/UAMlv
	 XzGVvNEELTFPA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: Convert amd,xgbe-seattle-v1a to DT schema
Date: Mon, 13 Oct 2025 16:30:49 -0500
Message-ID: <20251013213049.686797-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert amd,xgbe-seattle-v1a binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/amd,xgbe-seattle-v1a.yaml    | 147 ++++++++++++++++++
 .../devicetree/bindings/net/amd-xgbe.txt      |  76 ---------
 2 files changed, 147 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/amd-xgbe.txt

diff --git a/Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml b/Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml
new file mode 100644
index 000000000000..006add8b6410
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/amd,xgbe-seattle-v1a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD XGBE Seattle v1a
+
+maintainers:
+  - Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: amd,xgbe-seattle-v1a
+
+  reg:
+    items:
+      - description: MAC registers
+      - description: PCS registers
+      - description: SerDes Rx/Tx registers
+      - description: SerDes integration registers (1/2)
+      - description: SerDes integration registers (2/2)
+
+  interrupts:
+    description: Device interrupts. The first entry is the general device
+      interrupt. If amd,per-channel-interrupt is specified, each DMA channel
+      interrupt must be specified. The last entry is the PCS auto-negotiation
+      interrupt.
+    minItems: 2
+    maxItems: 6
+
+  clocks:
+    items:
+      - description: DMA clock for the device
+      - description: PTP clock for the device
+
+  clock-names:
+    items:
+      - const: dma_clk
+      - const: ptp_clk
+
+  iommus:
+    maxItems: 1
+
+  phy-mode: true
+
+  dma-coherent: true
+
+  amd,per-channel-interrupt:
+    description: Indicates that Rx and Tx complete will generate a unique
+      interrupt for each DMA channel.
+    type: boolean
+
+  amd,speed-set:
+    description: >
+      Speed capabilities of the device.
+        0 = 1GbE and 10GbE
+        1 = 2.5GbE and 10GbE
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  amd,serdes-blwc:
+    description: Baseline wandering correction enablement for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+    items:
+      enum: [0, 1]
+
+  amd,serdes-cdr-rate:
+    description: CDR rate speed selection for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: CDR rate for 1GbE
+      - description: CDR rate for 2.5GbE
+      - description: CDR rate for 10GbE
+
+  amd,serdes-pq-skew:
+    description: PQ data sampling skew for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: PQ skew for 1GbE
+      - description: PQ skew for 2.5GbE
+      - description: PQ skew for 10GbE
+
+  amd,serdes-tx-amp:
+    description: TX amplitude boost for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: TX amplitude for 1GbE
+      - description: TX amplitude for 2.5GbE
+      - description: TX amplitude for 10GbE
+
+  amd,serdes-dfe-tap-config:
+    description: DFE taps available to run for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: DFE taps available for 1GbE
+      - description: DFE taps available for 2.5GbE
+      - description: DFE taps available for 10GbE
+
+  amd,serdes-dfe-tap-enable:
+    description: DFE taps to enable for each speed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: DFE taps to enable for 1GbE
+      - description: DFE taps to enable for 2.5GbE
+      - description: DFE taps to enable for 10GbE
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@e0700000 {
+        compatible = "amd,xgbe-seattle-v1a";
+        reg = <0xe0700000 0x80000>,
+              <0xe0780000 0x80000>,
+              <0xe1240800 0x00400>,
+              <0xe1250000 0x00060>,
+              <0xe1250080 0x00004>;
+        interrupts = <0 325 4>,
+                     <0 326 1>, <0 327 1>, <0 328 1>, <0 329 1>,
+                     <0 323 4>;
+        amd,per-channel-interrupt;
+        clocks = <&xgbe_dma_clk>, <&xgbe_ptp_clk>;
+        clock-names = "dma_clk", "ptp_clk";
+        phy-mode = "xgmii";
+        mac-address = [ 02 a1 a2 a3 a4 a5 ];
+        amd,speed-set = <0>;
+        amd,serdes-blwc = <1>, <1>, <0>;
+        amd,serdes-cdr-rate = <2>, <2>, <7>;
+        amd,serdes-pq-skew = <10>, <10>, <30>;
+        amd,serdes-tx-amp = <15>, <15>, <10>;
+        amd,serdes-dfe-tap-config = <3>, <3>, <1>;
+        amd,serdes-dfe-tap-enable = <0>, <0>, <127>;
+    };
diff --git a/Documentation/devicetree/bindings/net/amd-xgbe.txt b/Documentation/devicetree/bindings/net/amd-xgbe.txt
deleted file mode 100644
index 9c27dfcd1133..000000000000
--- a/Documentation/devicetree/bindings/net/amd-xgbe.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-* AMD 10GbE driver (amd-xgbe)
-
-Required properties:
-- compatible: Should be "amd,xgbe-seattle-v1a"
-- reg: Address and length of the register sets for the device
-   - MAC registers
-   - PCS registers
-   - SerDes Rx/Tx registers
-   - SerDes integration registers (1/2)
-   - SerDes integration registers (2/2)
-- interrupts: Should contain the amd-xgbe interrupt(s). The first interrupt
-  listed is required and is the general device interrupt. If the optional
-  amd,per-channel-interrupt property is specified, then one additional
-  interrupt for each DMA channel supported by the device should be specified.
-  The last interrupt listed should be the PCS auto-negotiation interrupt.
-- clocks:
-   - DMA clock for the amd-xgbe device (used for calculating the
-     correct Rx interrupt watchdog timer value on a DMA channel
-     for coalescing)
-   - PTP clock for the amd-xgbe device
-- clock-names: Should be the names of the clocks
-   - "dma_clk" for the DMA clock
-   - "ptp_clk" for the PTP clock
-- phy-mode: See ethernet.txt file in the same directory
-
-Optional properties:
-- dma-coherent: Present if dma operations are coherent
-- amd,per-channel-interrupt: Indicates that Rx and Tx complete will generate
-  a unique interrupt for each DMA channel - this requires an additional
-  interrupt be configured for each DMA channel
-- amd,speed-set: Speed capabilities of the device
-    0 - 1GbE and 10GbE (default)
-    1 - 2.5GbE and 10GbE
-
-The MAC address will be determined using the optional properties defined in
-ethernet.txt.
-
-The following optional properties are represented by an array with each
-value corresponding to a particular speed. The first array value represents
-the setting for the 1GbE speed, the second value for the 2.5GbE speed and
-the third value for the 10GbE speed.  All three values are required if the
-property is used.
-- amd,serdes-blwc: Baseline wandering correction enablement
-    0 - Off
-    1 - On
-- amd,serdes-cdr-rate: CDR rate speed selection
-- amd,serdes-pq-skew: PQ (data sampling) skew
-- amd,serdes-tx-amp: TX amplitude boost
-- amd,serdes-dfe-tap-config: DFE taps available to run
-- amd,serdes-dfe-tap-enable: DFE taps to enable
-
-Example:
-	xgbe@e0700000 {
-		compatible = "amd,xgbe-seattle-v1a";
-		reg = <0 0xe0700000 0 0x80000>,
-		      <0 0xe0780000 0 0x80000>,
-		      <0 0xe1240800 0 0x00400>,
-		      <0 0xe1250000 0 0x00060>,
-		      <0 0xe1250080 0 0x00004>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 325 4>,
-			     <0 326 1>, <0 327 1>, <0 328 1>, <0 329 1>,
-			     <0 323 4>;
-		amd,per-channel-interrupt;
-		clocks = <&xgbe_dma_clk>, <&xgbe_ptp_clk>;
-		clock-names = "dma_clk", "ptp_clk";
-		phy-mode = "xgmii";
-		mac-address = [ 02 a1 a2 a3 a4 a5 ];
-		amd,speed-set = <0>;
-		amd,serdes-blwc = <1>, <1>, <0>;
-		amd,serdes-cdr-rate = <2>, <2>, <7>;
-		amd,serdes-pq-skew = <10>, <10>, <30>;
-		amd,serdes-tx-amp = <15>, <15>, <10>;
-		amd,serdes-dfe-tap-config = <3>, <3>, <1>;
-		amd,serdes-dfe-tap-enable = <0>, <0>, <127>;
-	};
-- 
2.51.0


