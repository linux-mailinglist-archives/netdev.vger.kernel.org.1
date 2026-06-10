Return-Path: <netdev+bounces-297384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PozGIP29KGqnIwMAu9opvQ
	(envelope-from <netdev+bounces-297384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:29:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35F665365
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297384-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297384-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C1EB301AFD6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EE25B0AF;
	Wed, 10 Jun 2026 01:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA57233936;
	Wed, 10 Jun 2026 01:29:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054971; cv=none; b=GfaRncctQ8x3z54lYL4jtKv17KI3n5G72Xbu64YiIoBDdBXm+Cc2XSoKYmdqoF5SOcEidNeMKSDXF563fPO756POdo5cUZKUbvKZB30IYlAaDluzg0/rU+ceSfugWYrubOojwjqgv68rQnfNBHJz9M42uYBcmKAHVQp+55NXNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054971; c=relaxed/simple;
	bh=hphxgFp+JJLvwTFTK6aPyf4RMzYgA95NUSpqUJk/XaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOWykCe4MYyxIqD1b6t+pFqUCePLAyIFOxyPUALshDy4hBneO5DbZd7ldZF6ELNN7pfpjsTTBcE9l/rJNr9yzunkjRU7DaazDNERS9Jn6ZQef5+T7xIlUY8CUgsv53UEEI/qG6aSkvuryOqo++H00NE5/JVEqCQ5dz64GawlSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgCHKXPlvShq75MlAA--.2691S2;
	Wed, 10 Jun 2026 09:29:11 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	lee@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v8 2/6] dt-bindings: ethernet: eswin: add EIC7700 eth1 RX clock inversion variant
Date: Wed, 10 Jun 2026 09:29:07 +0800
Message-ID: <20260610012907.894-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260610012727.848-1-lizhi2@eswincomputing.com>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCHKXPlvShq75MlAA--.2691S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43Ww1DuF4rJrW3Gw1rJFb_yoWrGFykpF
	WDury8Gr18Xr4xAw4xJF10k3W3t397Wry3Kr4kAF1xXw1Dt3Z8XrW29a45Ca48Cr4DZFW3
	Wa45tF1Fya9Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiWrW5UUUUU==
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lee@kernel.org,m:lizhi2@eswincomputing.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297384-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,eswincomputing.com:email,eswincomputing.com:mid,eswincomputing.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A35F665365

From: Zhi Li <lizhi2@eswincomputing.com>

The EIC7700 SoC integrates two GMAC instances. The eth1 MAC exhibits
different RX clock sampling characteristics due to silicon-inherent
timing behavior.

The eth1 MAC has a fixed, non-configurable RX clock-to-data skew at the
MAC input in the order of 4-5 ns. This cannot be compensated solely by
the standard MAC internal delay configuration and PHY delay, and RX clock
inversion is required at 1000Mbps for correct sampling.

The eth1 TX path also includes a fixed silicon-inherent delay of
approximately 2 ns. This delay is always present and cannot be disabled.
It is therefore part of the effective transmit timing observed on the
wire.

For the eth1 variant, the valid tx-internal-delay-ps values include
this fixed delay component. Consequently, the effective range becomes
2000-4540 ps (approximately 2000 ps fixed delay plus 0-2540 ps
programmable delay).

Introduce a dedicated compatible string
"eswin,eic7700-qos-eth-clk-inversion" to represent the eth1 variant,
allowing the driver to apply RX clock inversion only when required by
hardware variant selection.

This keeps SoC-level differentiation without exposing silicon-fixed skew
as configurable device tree parameters.

Add per-compatible tx-internal-delay-ps constraints using a oneOf
schema partition:
- eswin,eic7700-qos-eth: 0-2540 ps
- eswin,eic7700-qos-eth-clk-inversion: 2000-4540 ps

No functional change for existing "eswin,eic7700-qos-eth" users.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 55 +++++++++++++++++--
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 4e02fedae5c6..8cb7545c56e8 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -20,16 +20,38 @@ select:
       contains:
         enum:
           - eswin,eic7700-qos-eth
+          - eswin,eic7700-qos-eth-clk-inversion
   required:
     - compatible
 
 allOf:
   - $ref: snps,dwmac.yaml#
 
+oneOf:
+  - properties:
+      compatible:
+        contains:
+          const: eswin,eic7700-qos-eth
+      tx-internal-delay-ps:
+        minimum: 0
+        maximum: 2540
+        multipleOf: 20
+
+  - properties:
+      compatible:
+        contains:
+          const: eswin,eic7700-qos-eth-clk-inversion
+      tx-internal-delay-ps:
+        minimum: 2000
+        maximum: 4540
+        multipleOf: 20
+
 properties:
   compatible:
     items:
-      - const: eswin,eic7700-qos-eth
+      - enum:
+          - eswin,eic7700-qos-eth
+          - eswin,eic7700-qos-eth-clk-inversion
       - const: snps,dwmac-5.20
 
   reg:
@@ -67,11 +89,6 @@ properties:
     maximum: 2540
     multipleOf: 20
 
-  tx-internal-delay-ps:
-    minimum: 0
-    maximum: 2540
-    multipleOf: 20
-
   eswin,hsp-sp-csr:
     description:
       HSP CSR is to control and get status of different high-speed peripherals
@@ -140,3 +157,29 @@ examples:
             snps,wr_osr_lmt = <2>;
         };
     };
+
+    ethernet@50410000 {
+        compatible = "eswin,eic7700-qos-eth-clk-inversion", "snps,dwmac-5.20";
+        reg = <0x50410000 0x10000>;
+        interrupt-parent = <&plic>;
+        interrupts = <70>;
+        interrupt-names = "macirq";
+        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
+                <&d0_clock 194>;
+        clock-names = "axi", "cfg", "stmmaceth", "tx";
+        resets = <&reset 94>;
+        reset-names = "stmmaceth";
+        eswin,hsp-sp-csr = <&hsp_sp_csr 0x200 0x208 0x218 0x214 0x21c>;
+        phy-handle = <&gmac1_phy0>;
+        phy-mode = "rgmii-id";
+        snps,aal;
+        snps,fixed-burst;
+        snps,tso;
+        snps,axi-config = <&stmmac_axi_setup_gmac1>;
+
+        stmmac_axi_setup_gmac1: stmmac-axi-config {
+            snps,blen = <0 0 0 0 16 8 4>;
+            snps,rd_osr_lmt = <2>;
+            snps,wr_osr_lmt = <2>;
+        };
+    };
-- 
2.25.1


