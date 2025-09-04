Return-Path: <netdev+bounces-219843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B2B43675
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621127C3488
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994032BE65C;
	Thu,  4 Sep 2025 09:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F32BDC09;
	Thu,  4 Sep 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976488; cv=none; b=A/7u8GF7GY9sR0QehOyWjxJf9XDhZLD+8oBzVdNi/9N+bWOWYoGVPnHANO7igW2u/cRFd9I9M9iia+f6cLiiKgEOY/w78GTiarRoW9uIiZaU4qGnRCuxRWSFXyxrL2M4wwLVfTeV9DW4C/t4NO++YqQzyYCNOjQ5WfC9dCzcBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976488; c=relaxed/simple;
	bh=/bqpS8Q6zKJe1QRdSTpgfyrRwX4Se1MPaEiV4K7DawQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qexX6WlR5NBaEc0rbt6PxYjaYoPvrJDi4jqxVSxSQ4BLww+HQyPoI7aGJcQxvigPHsqkTtAFe9qh5CyvfvlhGRsEC4bo6s5LEmxo/L5mHufiUFa4GPm/ILr0EGxop/k2SxxdXrOPJaFUgXLLrvIALynyqQCYrbP+mJ3LstjmnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgAXLg9LVbloAGXIAA--.31039S2;
	Thu, 04 Sep 2025 17:01:01 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	jszhang@kernel.org,
	p.zabel@pengutronix.de,
	boon.khai.ng@altera.com,
	0x1207@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	emil.renner.berthing@canonical.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v5 1/2] dt-bindings: ethernet: eswin: Document for EIC7700 SoC
Date: Thu,  4 Sep 2025 17:00:55 +0800
Message-Id: <20250904090055.2546-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
References: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXLg9LVbloAGXIAA--.31039S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kJF18CFWUAr43GFyDKFg_yoWrGr1kpF
	WkCrW5Jr4fXr1fXa1UtF10kFn3ta1DCr1Ykrn7J3Waq3s0qa90qw4ayFy5Ga43Cr47ZFy5
	WFWYqayxAw12k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiWrW5UUUUU==
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add ESWIN EIC7700 Ethernet controller, supporting clock
configuration, delay adjustment and speed adaptive functions.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
new file mode 100644
index 000000000000..9771fed9604e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SOC Eth Controller
+
+maintainers:
+  - Shuang Liang <liangshuang@eswincomputing.com>
+  - Zhi Li <lizhi2@eswincomputing.com>
+  - Shangjuan Wei <weishangjuan@eswincomputing.com>
+
+description:
+  The eth controller registers are part of the syscrg block on
+  the EIC7700 SoC.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - eswin,eic7700-qos-eth
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: eswin,eic7700-qos-eth
+      - const: snps,dwmac-5.20
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
+  clocks:
+    items:
+      - description: AXI clock
+      - description: Configuration clock
+      - description: GMAC main clock
+      - description: Tx clock
+
+  clock-names:
+    items:
+      - const: axi
+      - const: cfg
+      - const: stmmaceth
+      - const: tx
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  rx-internal-delay-ps:
+    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+
+  tx-internal-delay-ps:
+    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+
+  eswin,hsp-sp-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to HSP(High-Speed Peripheral) device
+      - description: Offset of phy control register for internal
+                     or external clock selection
+      - description: Offset of AXI clock controller Low-Power request
+                     register
+      - description: Offset of register controlling TX/RX clock delay
+    description: |
+      High-Speed Peripheral device needed to configure clock selection,
+      clock low-power mode and clock delay.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
+  - resets
+  - reset-names
+  - rx-internal-delay-ps
+  - tx-internal-delay-ps
+  - eswin,hsp-sp-csr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@50400000 {
+        compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
+        reg = <0x50400000 0x10000>;
+        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
+                <&d0_clock 193>;
+        clock-names = "axi", "cfg", "stmmaceth", "tx";
+        interrupt-parent = <&plic>;
+        interrupts = <61>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        phy-handle = <&phy0>;
+        resets = <&reset 95>;
+        reset-names = "stmmaceth";
+        rx-internal-delay-ps = <200>;
+        tx-internal-delay-ps = <200>;
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,aal;
+        snps,fixed-burst;
+        snps,tso;
+        stmmac_axi_setup: stmmac-axi-config {
+            snps,blen = <0 0 0 0 16 8 4>;
+            snps,rd_osr_lmt = <2>;
+            snps,wr_osr_lmt = <2>;
+        };
+    };
-- 
2.17.1


