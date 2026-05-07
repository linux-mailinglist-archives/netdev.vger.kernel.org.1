Return-Path: <netdev+bounces-285189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OpTGRVO/GlOOAAAu9opvQ
	(envelope-from <netdev+bounces-285189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB34E4DF7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09CDB3003614
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3C38947C;
	Thu,  7 May 2026 08:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A225386555;
	Thu,  7 May 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142738; cv=none; b=ULuaH5kPJGSzxSEY8r87Pndj2R6dY8anSV0yTDDG9h5zlR3ALwuvu6isjQX2IGqm5cl/eqmGFzjZvNEeZ4chrxz0CPMPeokNY/7G30tm1mPIwyd0StV/NimYx24Dev2ZEzw45oTbo5exYEIvp0e/3QJEMBSSVHPM6CeItH8V9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142738; c=relaxed/simple;
	bh=kZNz8D4IGT+eFY2JcP2OOApgEMNiuDGxKcaZxPVSL3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn4RV1OYQu5z0H6AQnWoKDfbRyRImKbRK1RM0HgbYzMIuHnc6EFGfve6MI7BC547SFsHkq//1cMqmPFCCz+4J+ZW9ZQDWxN2ZRb0Ts4sigfIzyNNAiftpkZ256YvXjV1jZYyku0mcWfnaFgngAyooIZoX56ofOmLMUgXBnUtDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgC3THH6TfxpQ34XAA--.24500S2;
	Thu, 07 May 2026 16:31:55 +0800 (CST)
From: lizhi2@eswincomputing.com
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
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine delay model and HSP register description
Date: Thu,  7 May 2026 16:31:36 +0800
Message-ID: <20260507083136.175-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260507083037.152-1-lizhi2@eswincomputing.com>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3THH6TfxpQ34XAA--.24500S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1DAryxXw48KFyUGry5twb_yoW7ury7pa
	y5CrW5Grn8Xr4fWanrtw109ryaqan3WF43Cr18Jr97Xan09F9Yqr13tFy5Xa4UCrWxZFyU
	urZ0ga1rZ34qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 29EB34E4DF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-285189-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Zhi Li <lizhi2@eswincomputing.com>

Refine the EIC7700 Ethernet dt-binding based on observed hardware behavior
and clarify the original delay model for eth0.

The previous binding used an enum-based definition for
rx-internal-delay-ps and tx-internal-delay-ps. Replace it with a
range-based model using:

  - minimum: 0
  - maximum: 2540
  - multipleOf: 20

This better reflects the actual hardware implementation, which
supports 20ps granularity delay steps in the MAC RGMII interface.

The tx/rx internal delay values are clarified as MAC-side programmable
delay components applied on the RGMII clock/data path, representing
the effective delay seen at the MAC interface.

This does not change the intended hardware semantics, but aligns the
binding with the actual hardware implementation.

These properties are optional and only required when MAC-side fine
tuning is needed; otherwise delay alignment is provided by PHY or
board design.

Depending on the selected RGMII timing mode, delay alignment may be
provided by the PHY (e.g. rgmii-id) or by board/MAC-side configuration.
When PHY or board design already provides the required delay, these
MAC-side properties may be omitted. When MAC-side fine tuning is
required, they should be provided to describe the internal RGMII
timing adjustment.

Additionally, extend the description of the HSP subsystem register
layout used by the MAC glue logic. This includes explicit TXD and RXD
delay control registers to ensure deterministic initialization and
to override any residual configuration potentially left by bootloaders.

Add reference to the EIC7700X SoC Technical Reference Manual,
Chapter 10 ("High-Speed Interface"), Part 4 for background of the
HSP CSR block:
https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases

There are no in-tree users of this binding, so no ABI impact is
expected.

Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 91e8cd1db67b..fab95603bd82 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -63,16 +63,39 @@ properties:
       - const: stmmaceth
 
   rx-internal-delay-ps:
-    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+    minimum: 0
+    maximum: 2540
+    multipleOf: 20
+    description:
+      RX internal delay in picoseconds applied on the RGMII clock at the MAC
+      side. The hardware supports 20 ps steps.
+      This property is optional and only needed when MAC-side delay tuning
+      is required.
 
   tx-internal-delay-ps:
-    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+    minimum: 0
+    maximum: 2540
+    multipleOf: 20
+    description:
+      TX internal delay in picoseconds applied on the RGMII clock at the MAC
+      side. The hardware supports 20 ps steps.
+      This property is optional and only needed when MAC-side delay tuning
+      is required.
 
   eswin,hsp-sp-csr:
     description:
       HSP CSR is to control and get status of different high-speed peripherals
       (such as Ethernet, USB, SATA, etc.) via register, which can tune
       board-level's parameters of PHY, etc.
+
+      Additional background information about the High-Speed Subsystem
+      and the HSP CSR block is available in Chapter 10 ("High-Speed Interface")
+      of the EIC7700X SoC Technical Reference Manual, Part 4
+      (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf). The manual is
+      publicly available at
+      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases
+
+      This reference is provided for background information only.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
@@ -82,6 +105,8 @@ properties:
           - description: Offset of AXI clock controller Low-Power request
                          register
           - description: Offset of register controlling TX/RX clock delay
+          - description: Offset of register controlling TXD delay
+          - description: Offset of register controlling RXD delay
 
 required:
   - compatible
@@ -93,8 +118,6 @@ required:
   - phy-mode
   - resets
   - reset-names
-  - rx-internal-delay-ps
-  - tx-internal-delay-ps
   - eswin,hsp-sp-csr
 
 unevaluatedProperties: false
@@ -104,24 +127,23 @@ examples:
     ethernet@50400000 {
         compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
         reg = <0x50400000 0x10000>;
-        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
-                <&d0_clock 193>;
-        clock-names = "axi", "cfg", "stmmaceth", "tx";
         interrupt-parent = <&plic>;
         interrupts = <61>;
         interrupt-names = "macirq";
-        phy-mode = "rgmii-id";
-        phy-handle = <&phy0>;
+        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
+                <&d0_clock 193>;
+        clock-names = "axi", "cfg", "stmmaceth", "tx";
         resets = <&reset 95>;
         reset-names = "stmmaceth";
-        rx-internal-delay-ps = <200>;
-        tx-internal-delay-ps = <200>;
-        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
-        snps,axi-config = <&stmmac_axi_setup>;
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
+        phy-handle = <&phy0>;
+        phy-mode = "rgmii-id";
         snps,aal;
         snps,fixed-burst;
         snps,tso;
-        stmmac_axi_setup: stmmac-axi-config {
+        snps,axi-config = <&stmmac_axi_setup_gmac0>;
+
+        stmmac_axi_setup_gmac0: stmmac-axi-config {
             snps,blen = <0 0 0 0 16 8 4>;
             snps,rd_osr_lmt = <2>;
             snps,wr_osr_lmt = <2>;
-- 
2.25.1


