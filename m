Return-Path: <netdev+bounces-182126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467BA87F22
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC821894536
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1412267701;
	Mon, 14 Apr 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="fU4R3MPs"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D122367C1;
	Mon, 14 Apr 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630555; cv=none; b=klzDxJg9svq1/cH/Rj+/SjmYyz/uwH9+07Fqey6S9epQ8d6zFwP9UGlh7F+z3sCMudczaw59zj/m6mwi4nFI0S8fA3bNsCVaOgBKD9g2eTx0xMFLM+W1jp1KZ3/DQ2Fuk+E2oJJVWxlSZ9FrhEiQKb3xqkD1PmE6Zpdntt9gtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630555; c=relaxed/simple;
	bh=6yuCqj7vE+yLsjiIC188CCbfrhk1kc85dgIXCD68FSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtRFLY9/nsprf/miYliwjB2TmimzJvvlXXa8x3uolQ35fmReGBMqXVwe1B0suuXY+asg5qxHw1ViY+HnUvJ95cj7IFf92wj0vo5sD60xLeaNb+QjvclC1YNT/47NL7cKi8E/uLU4hG2VCvmjr99VogWH912QDAxE/o8SJzjW0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=fU4R3MPs; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pa6ZRB2iis94ff7xVshFDz36bvpwJr8yxhqZCOdb8iA=; b=fU4R3MPs0LHBN5DNsS9ph76UFO
	gxBurEipgOeD4roa1V5R5Fby48VbvU0ebKToBucOQQ+ShCWs2MrBjzie1es9/YeqQqEGGVJ2l2MMe
	F+NL8PQ27bOxJh6K5WLCLiwSU5MR0JuQmGXxaLM4Fnt54OHclYHwN3SHpLQ8duBoAlAznA4SeT4pW
	Veg4vMOr+kk0sTjc6EV3A1RxWLJu3q8q0EkFpp/g0SwqTio4Mdg5ap27fGHk8rwruykjqTTFHL03O
	w0Fm6xwfaqerpWnNEckETegCowKnaH50iDxk0li0Wrro5OdNcQBR7GYWHZDNde9E1t/MQ20JldiXS
	2Ev6UqGw==;
Received: from [122.175.9.182] (port=39821 helo=cypher.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u4I6N-000000000Wp-1H8a;
	Mon, 14 Apr 2025 17:05:47 +0530
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nm@ti.com,
	ssantosh@kernel.org,
	tony@atomide.com,
	richardcochran@gmail.com,
	glaroque@baylibre.com,
	schnelle@linux.ibm.com,
	m-karicheri2@ti.com,
	s.hauer@pengutronix.de,
	rdunlap@infradead.org,
	diogo.ivo@siemens.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com,
	afd@ti.com,
	s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v5 01/11] dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Date: Mon, 14 Apr 2025 17:04:48 +0530
Message-Id: <20250414113458.1913823-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414113458.1913823-1-parvathi@couthit.com>
References: <20250414113458.1913823-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Documentation update for the newly added "pruss2_eth" device tree
node and its dependencies along with compatibility for PRU-ICSS
Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
(eCAP) peripheral and using YAML binding document for AM57xx SoCs.

Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 .../devicetree/bindings/net/ti,icss-iep.yaml  |  10 +-
 .../bindings/net/ti,icssm-prueth.yaml         | 233 ++++++++++++++++++
 .../bindings/net/ti,pruss-ecap.yaml           |  32 +++
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 +
 4 files changed, 281 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
index e36e3a622904..ea2659d90a52 100644
--- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
 
 maintainers:
   - Md Danish Anwar <danishanwar@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
 
 properties:
   compatible:
@@ -17,9 +19,11 @@ properties:
               - ti,am642-icss-iep
               - ti,j721e-icss-iep
           - const: ti,am654-icss-iep
-
-      - const: ti,am654-icss-iep
-
+      - enum:
+          - ti,am654-icss-iep
+          - ti,am5728-icss-iep
+          - ti,am4376-icss-iep
+          - ti,am3356-icss-iep
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
new file mode 100644
index 000000000000..d42aea70eb76
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
@@ -0,0 +1,233 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,icssm-prueth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ICSSM PRUSS Ethernet
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+  - Andrew F. Davis <afd@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
+
+description:
+  Ethernet based on the Programmable Real-Time Unit and Industrial
+  Communication Subsystem.
+
+properties:
+  compatible:
+    enum:
+      - ti,am57-prueth     # for AM57x SoC family
+      - ti,am4376-prueth   # for AM43x SoC family
+      - ti,am3359-prueth   # for AM33x SoC family
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to OCMC SRAM node
+
+  ti,mii-rt:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to MII_RT module's syscon regmap
+
+  ti,iep:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to IEP (Industrial Ethernet Peripheral) for ICSS
+
+  ti,ecap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to Enhanced Capture (eCAP) event for ICSS
+
+  interrupts:
+    items:
+      - description: High priority Rx Interrupt specifier.
+      - description: Low priority Rx Interrupt specifier.
+
+  interrupt-names:
+    items:
+      - const: rx_hp
+      - const: rx_lp
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
+      ^ethernet-port@[0-1]$:
+        type: object
+        description: ICSSM PRUETH external ports
+        $ref: ethernet-controller.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            items:
+              - enum: [0, 1]
+            description: ICSSM PRUETH port number
+
+          interrupts:
+            maxItems: 3
+
+          interrupt-names:
+            items:
+              - const: rx
+              - const: emac_ptp_tx
+              - const: hsr_ptp_tx
+
+        required:
+          - reg
+
+    anyOf:
+      - required:
+          - ethernet-port@0
+      - required:
+          - ethernet-port@1
+
+required:
+  - compatible
+  - sram
+  - ti,mii-rt
+  - ti,iep
+  - ti,ecap
+  - ethernet-ports
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS2 */
+    pruss2_eth: pruss2-eth {
+      compatible = "ti,am57-prueth";
+      ti,prus = <&pru2_0>, <&pru2_1>;
+      sram = <&ocmcram1>;
+      ti,mii-rt = <&pruss2_mii_rt>;
+      ti,iep = <&pruss2_iep>;
+      ti,ecap = <&pruss2_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss2_intc>;
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss2_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss2_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss2_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss2_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS1 */
+    pruss1_eth: pruss1-eth {
+      compatible = "ti,am4376-prueth";
+      ti,prus = <&pru1_0>, <&pru1_1>;
+      sram = <&ocmcram>;
+      ti,mii-rt = <&pruss1_mii_rt>;
+      ti,iep = <&pruss1_iep>;
+      ti,ecap = <&pruss1_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss1_intc>;
+
+      pinctrl-0 = <&pruss1_eth_default>;
+      pinctrl-names = "default";
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss1_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss1_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss1_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss1_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS */
+    pruss_eth: pruss-eth {
+      compatible = "ti,am3359-prueth";
+      ti,prus = <&pru0>, <&pru1>;
+      sram = <&ocmcram>;
+      ti,mii-rt = <&pruss_mii_rt>;
+      ti,iep = <&pruss_iep>;
+      ti,ecap = <&pruss_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss_intc>;
+
+      pinctrl-0 = <&pruss_eth_default>;
+      pinctrl-names = "default";
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
new file mode 100644
index 000000000000..42f217099b2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,pruss-ecap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PRU-ICSS Enhanced Capture (eCAP) event module
+
+maintainers:
+  - Murali Karicheri <m-karicheri2@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
+
+properties:
+  compatible:
+    const: ti,pruss-ecap
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pruss2_ecap: ecap@30000 {
+        compatible = "ti,pruss-ecap";
+        reg = <0x30000 0x60>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 927b3200e29e..594f54264a8c 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -251,6 +251,15 @@ patternProperties:
 
     type: object
 
+  ecap@[a-f0-9]+$:
+    description:
+      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
+      and capture periodic timer based events which will be used for features
+      like RX Pacing to rise interrupt when the timer event has occurred.
+      Each PRU-ICSS instance has one eCAP modeule irrespective of SOCs.
+
+    type: object
+
   mii-rt@[a-f0-9]+$:
     description: |
       Real-Time Ethernet to support multiple industrial communication protocols.
-- 
2.34.1


