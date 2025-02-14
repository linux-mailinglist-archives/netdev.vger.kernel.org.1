Return-Path: <netdev+bounces-166302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D40A35686
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7C161BA0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C93155743;
	Fri, 14 Feb 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="c5eAHezR"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479262753E8;
	Fri, 14 Feb 2025 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512076; cv=none; b=BNRwiWGyJadGy3LgSlq4Mx5TroWwghPp9y57XeQvNXeszTpQ/cqnH42qol7iCbd2nKlKk4ItN+Rt/1ryvJZsi5ailB/rZx6d+WJZtUyYxRUNk2xZVBemFLEH9TgqvPB8GAVtVRN/wzdi1cDLCI+3KgM0U66GmbXM0Z4C1n2SnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512076; c=relaxed/simple;
	bh=/wt7563NHGlAqJu3t0FV3iCXdeO4tCgxC0RVWecRFiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IX6NTcw3d83Br6e/GHi1E3O0VqQKQF2duhwk2zuas7Ngob8WVNTQIiX6JuJLQ7/tuMIWVdHlbjbtf1I6AxAcbpbFkGBsSvf6zvU72meC8pBa8omjnDWN7aDGuRMgByVWlZxmb9UWSrQi0qbiglALKT0g4fWBW8m/mhrKOKpR7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=c5eAHezR; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uKXVvU+SLU1gf3c8hZ0tw5H4qyBC2U+/dASmSrylnWE=; b=c5eAHezRGpF9PoznWjw7ndEZ5y
	LG4tZ397a1GGuQn+RwBqL4z38aoykMwpkMT6HadUnKmdl941y6AYQztS6CNiee0CD4367YEkQtOkI
	J9k2B3huL6ae6bVwYcmgN7KbKe7W5fHzPGDR59ZOYmardTsiUd2VfUJgyaaibyX5iJI6/BrHRrt+Y
	HzHa6hQLkKy2W8yjk3eg3wAGo0sV4f9+XOf6tGpS8N1OVFAIjN4LZ1HdzCOljhb3ad7RSyFcfIqQg
	Qm+5j2o8cU82ULd2BD7NF2kBFLRCTivLBapAyh2FjMtIjh+v8OwvDCoSq0ZAmOsY7VK5IYCiKc9N1
	5Tlsx9dw==;
Received: from [122.175.9.182] (port=5380 helo=cypher.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.96.2)
	(envelope-from <parvathi@couthit.com>)
	id 1tioYH-0001hH-1Z;
	Fri, 14 Feb 2025 11:17:49 +0530
From: parvathi <parvathi@couthit.com>
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
	richardcochran@gmail.com,
	parvathi@couthit.com,
	basharath@couthit.com,
	schnelle@linux.ibm.com,
	diogo.ivo@siemens.com,
	m-karicheri2@ti.com,
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
Subject: [PATCH net-next v3 01/10] dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx SOCs
Date: Fri, 14 Feb 2025 11:16:53 +0530
Message-Id: <20250214054702.1073139-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214054702.1073139-1-parvathi@couthit.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
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

From: Parvathi Pudi <parvathi@couthit.com>

Documentation update for the newly added "pruss2_eth" device tree
node and its dependencies along with compatibility for PRU-ICSS
Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
(eCAP) peripheral and using YAML binding document for AM57xx SoCs.

Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
---
 .../devicetree/bindings/net/ti,icss-iep.yaml  |   4 +-
 .../bindings/net/ti,icssm-prueth.yaml         | 147 ++++++++++++++++++
 .../bindings/net/ti,pruss-ecap.yaml           |  32 ++++
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 ++
 4 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
index e36e3a622904..858d74638167 100644
--- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
 
 maintainers:
   - Md Danish Anwar <danishanwar@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
 
 properties:
   compatible:
@@ -19,7 +21,7 @@ properties:
           - const: ti,am654-icss-iep
 
       - const: ti,am654-icss-iep
-
+      - const: ti,am5728-icss-iep
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
new file mode 100644
index 000000000000..1dffa6bd7a88
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
@@ -0,0 +1,147 @@
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


