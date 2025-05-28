Return-Path: <netdev+bounces-193853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C0AC60AA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC33F7A5E30
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82721F151C;
	Wed, 28 May 2025 04:18:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1C1F1311;
	Wed, 28 May 2025 04:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405924; cv=none; b=SIF11A5LHFQeHzm6v/jUbKMig4hUEnjO3+qB9qJYdTwnkKvjgrOJ/G3g6YD2lMpnEoehgansBZJY/484OKT/DCINfDTCQlXzi1VwVtliWsAuyqAHdUn119JISi2Fz50xw4GjxGzhTs8x6QKIF58dAFjGVSEe/UHRYECmpdsIbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405924; c=relaxed/simple;
	bh=2GspJ+bdfd7LNh3QxZy4kWKM/ckvFnpizuzn9Z579yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2+oCvNCDWcnGuO3pGgSjlQ43XL4clNLnhjwPfkrF9jXzhAqfxrKWzZAZOr0NkqZnOC0+wb05k41d1AtpbSvjEwnN1zmkO4CJ4qI4zcm7UQSzByf3zW2pw8KK7nf5TwuK0A7ioXrfdeNaCHOK0tU2ITfF7Qh8tFT/jw7GTIOf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182DT.eswin.cn (unknown [10.12.97.162])
	by app2 (Coremail) with SMTP id TQJkCgAHppQCjjZobBGVAA--.51322S2;
	Wed, 28 May 2025 12:16:04 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	jszhang@kernel.org,
	p.zabel@pengutronix.de,
	0x1207@gmail.com,
	boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v2 1/2] dt-bindings: ethernet: eswin: Document for EIC7700 SoC
Date: Wed, 28 May 2025 12:15:58 +0800
Message-ID: <20250528041558.895-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250528041455.878-1-weishangjuan@eswincomputing.com>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHppQCjjZobBGVAA--.51322S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtry5Gw17Gr17Kw17KF15Jwb_yoW7uFy8pF
	W8C347JF1Sqr43Xa1xKF10kF1aqan7Grn0krnFq343ta9Iqa4Yqr4akF15Ga4UAr1xZa45
	WFy5A34Iya17Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRimiiDUUUU
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add ESWIN EIC7700 Ethernet controller, supporting
multi-rate (10M/100M/1G) auto-negotiation, clock/reset control,
and AXI bus parameter optimization.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
new file mode 100644
index 000000000000..c76d2fbf0ebd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -0,0 +1,200 @@
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
+      - const: snps,dwmac
+
+  reg:
+    description: Base address and size of the Ethernet controller registers
+    items:
+      - description: Register base address
+      - description: Register size
+
+  interrupt-names:
+    const: macirq
+
+  interrupts:
+    maxItems: 1
+
+  phy-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - rgmii
+      - rgmii-rxid
+      - rgmii-txid
+      - rgmii-id
+
+  phy-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the PHY device
+
+  clocks:
+    minItems: 3
+    maxItems: 7
+
+  clock-names:
+    minItems: 3
+    contains:
+      enum:
+        - app
+        - stmmaceth
+        - tx
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  dma-noncoherent: true
+
+  # Custom properties
+  eswin,hsp_sp_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: HSP peripheral control register area
+          - description: Control registers (such as used to select TX clock
+                         source, PHY interface mode)
+          - description: AXI bus low-power control related registers
+          - description: Status register
+    description:
+      Configure TX clock source selection, set PHY interface mode,
+      and control low-power bus behavior
+
+  eswin,syscrg_csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: CRG's device tree node handle
+          - description: Enable and divide HSP ACLK control
+          - description: Behavior of configuring HSP controller
+    description:
+      Register that accesses the system clock controller.
+      Used to configure HSP clocks for Ethernet subsystems
+
+  eswin,dly_hsp_reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: TX delay control register offset
+          - description: RX delay control register offset
+          - description: Switch for controlling delay function
+    description:
+      Register for configuring delay compensation between MAC/PHY
+
+  snps,axi-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: AXI bus configuration
+
+  stmmac-axi-config:
+    type: object
+    unevaluatedProperties: false
+    properties:
+      snps,blen:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Set the burst transmission length of AXI bus
+      snps,rd_osr_lmt:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Set OSR restrictions for read operations
+      snps,wr_osr_lmt:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Set OSR restrictions for write operations
+      snps,lpi_en:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: Low Power Interface enable flag (true/false)
+    required:
+      - snps,blen
+      - snps,rd_osr_lmt
+      - snps,wr_osr_lmt
+      - snps,lpi_en
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - phy-mode
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - eswin,hsp_sp_csr
+  - eswin,syscrg_csr
+  - eswin,dly_hsp_reg
+  - snps,axi-config
+
+additionalProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@50400000 {
+        compatible = "eswin,eic7700-qos-eth", "snps,dwmac";
+        reg = <0x0 0x50400000 0x0 0x10000>;
+        interrupt-parent = <&plic>;
+        interrupt-names = "macirq";
+        interrupts = <61>;
+        phy-mode = "rgmii-txid";
+        phy-handle = <&phy0>;
+        status = "okay";
+        clocks = <&clock 550>,
+                 <&clock 551>,
+                 <&clock 552>;
+        clock-names = "app", "stmmaceth", "tx";
+        resets = <&reset 0x07 (1 << 26)>;
+        reset-names = "stmmaceth";
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
+        /* mdio {
+          compatible = "snps,dwmac-mdio";
+          status = "okay";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          phy0: ethernet-phy@0 {
+            device_type = "ethernet-phy";
+            reg = <0>;
+            compatible = "ethernet-phy-id001c.c916", "realtek,rtl8211f";
+          };
+        }; */
+    };
-- 
2.17.1


