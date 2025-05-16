Return-Path: <netdev+bounces-190905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1105AB9383
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E68D4A26C9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660CD214A66;
	Fri, 16 May 2025 01:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656371D07BA;
	Fri, 16 May 2025 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357875; cv=none; b=Os3BbvoBMz5//5Gie5z5mf8UTvtGrxA8iIq3y12H6FK+f2veZ7MAkVxUxKYAlN3HyQBUjtGhUlUvAYReLGQWhIH5Bx60chDMKusppM4K/X9tb1QUPvUwSxFArHI2h2XKt5lAttyeXu+RV4nU/ahyCm0FwOH8rKR9N90Q71fjjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357875; c=relaxed/simple;
	bh=Uk+ouYBSqfF+sojNd0fpIAc1Xj9+JWYSvuWORoLECmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+fNv2QSPKNZBLlnUfrwfunKLENmuo7Ro5Nen+rJ/+SdNrERbryzpjEYbLXpbiTSaMwUTCX309GEBeleTRqgQqTA6sCC1Xp8HIQIrGn0RRqZbdc3MNqNhVhIH0jxgCI8WF0fOmKmyXk1Af4b6OT/D+NNhAPVNGOBaHF41QHy2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182DT.eswin.cn (unknown [10.12.97.162])
	by app2 (Coremail) with SMTP id TQJkCgBn+ZKVkCZowph8AA--.41039S2;
	Fri, 16 May 2025 09:10:49 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de,
	yong.liang.choong@linux.intel.com,
	rmk+kernel@armlinux.org.uk,
	jszhang@kernel.org,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	dfustini@tenstorrent.com,
	0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v1 1/2] ethernet: eswin: Document for eic7700 SoC
Date: Fri, 16 May 2025 09:10:38 +0800
Message-ID: <20250516011040.801-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250516010849.784-1-weishangjuan@eswincomputing.com>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBn+ZKVkCZowph8AA--.41039S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DKr4rCF4rur17GFy8Xwb_yoWrWFy7pF
	WxC34UJF4SqF13XayxtF10kF13tan7Gr1YkrnFqa43t395Xa4Yqr4ak3W5GFy7Cr1xXa45
	WayYy34xA3WUArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6xkF7I0En7xvr7AKxVWUJVW8JwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CE
	Vc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2
	AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRVyxiUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add ESWIN EIC7700 Ethernet controller, supporting
multi-rate (10M/100M/1G) auto-negotiation, PHY LED configuration,
clock/reset control, and AXI bus parameter optimization.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
new file mode 100644
index 000000000000..6cb9c109c036
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -0,0 +1,142 @@
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
+description: |
+  The eth controller registers are part of the syscrg block on
+  the EIC7700 SoC.
+
+properties:
+  compatible:
+    const: eswin,eic7700-qos-eth
+
+  reg:
+    minItems: 1
+    items:
+      - description: Base address and size
+      - description: Extension region (optional)
+
+  interrupt-names:
+    const: macirq
+
+  interrupts:
+    maxItems: 1
+
+  phy-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [mii, gmii, rgmii, rmii, sgmii]
+
+  id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Controller instance ID
+
+  clocks:
+    minItems: 3
+    maxItems: 7
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: app
+      - const: stmmaceth
+      - const: tx
+      - const: slave_bus
+      - const: master_bus
+      - const: ptp_ref
+      - const: phy_ref_clk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: ethrst
+
+  dma-noncoherent: true
+
+  # Custom properties
+  eswin,hsp_sp_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: HSP SP control registers
+
+  eswin,syscrg_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: System clock registers
+
+  eswin,dly_hsp_reg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: HSP delay control registers
+
+  snps,axi-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: AXI bus configuration
+
+  stmmac-axi-config:
+    type: object
+    unevaluatedProperties: false
+    properties:
+      snps,lpi_en:
+        type: boolean
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: Low Power Interface enable flag (true/false)
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - phy-mode
+  - id
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - eswin,hsp_sp_csr
+  - eswin,syscrg_csr
+  - eswin,dly_hsp_reg
+  - snps,axi-config
+  - snps,blen
+  - snps,rd_osr_lmt
+  - snps,wr_osr_lmt
+  - snps,lpi_en
+
+additionalProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@50400000 {
+        compatible = "eswin,eic7700-qos-eth";
+        reg = <0x0 0x50400000 0x0 0x10000>;
+        interrupt-parent = <&plic>;
+        interrupt-names = "macirq";
+        interrupts = <61>;
+        phy-mode = "rgmii";
+        id = <0>;
+        status = "disabled";
+        clocks = <&clock 550>,
+                 <&clock 551>,
+                 <&clock 552>;
+        clock-names = "app", "stmmaceth", "tx";
+        resets = <&reset 0x07 (1 << 26)>;
+        reset-names = "ethrst";
+        dma-noncoherent;
+        eswin,hsp_sp_csr = <&hsp_sp_csr 0x1030 0x100 0x108>;
+        eswin,syscrg_csr = <&sys_crg 0x148 0x14c>;
+        eswin,dly_hsp_reg = <0x114 0x118 0x11c>;
+        snps,axi-config = <&stmmac_axi_setup>;
+        stmmac_axi_setup: stmmac-axi-config {
+            snps,blen = <0 0 0 0 16 8 4>;
+            snps,rd_osr_lmt = <2>;
+            snps,wr_osr_lmt = <2>;
+            snps,lpi_en;
+        };
+    };
-- 
2.17.1


