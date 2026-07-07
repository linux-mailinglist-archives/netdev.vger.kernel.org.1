Return-Path: <netdev+bounces-305299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X01bARugTGoBnQEAu9opvQ
	(envelope-from <netdev+bounces-305299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:43:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825AD718140
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:43:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305299-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305299-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37784304BD39
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D23AA1BD;
	Tue,  7 Jul 2026 06:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27D3AA1A8;
	Tue,  7 Jul 2026 06:42:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406525; cv=none; b=l3XWtEnGmLsNVmlFoHxheCAbuOjxtQlwnM/Gz8ATPzM9Of99F5ELfHbOZKQNyx0KGtPvfbw3TjyqLA/0nyeecdINmNtQjo5VGLSR8sXADSjNPyJr0aAR8q7eOdoVnKYPmdpYocu9CGuFzgrgkNYpToWoZ4XhPWVeZj3FCtomxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406525; c=relaxed/simple;
	bh=4oc1+YLDliORMGAF/lnsCgjV2kz9yTwJ5M/xgHxgbYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaRyVmghNOftF3Mh83iZ6hxAFGVPgMzg+ZF6Nmj0Xol5C6dvdRs+gIDgzFkP7fxVWgnvyW0/xx2w1y0SgRIlrkr+YwdgTxw80z3E0Zl19vCXLaMEt0cPoxs9RCh6iLMFAum010HXDfXo3i8lCfboy0YQl4XsirX6TII4myhlZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgB3GXOen0xqcA0yAA--.33966S2;
	Tue, 07 Jul 2026 14:41:35 +0800 (CST)
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
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v10 1/4] dt-bindings: ethernet: eswin: relax internal delay model to range-based constraints
Date: Tue,  7 Jul 2026 14:41:30 +0800
Message-ID: <20260707064131.1282-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260707064033.1265-1-lizhi2@eswincomputing.com>
References: <20260707064033.1265-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3GXOen0xqcA0yAA--.33966S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWxJw13tw4rGr4UWFW7Arb_yoW5Xw1UpF
	ZxCryrGr48Xr1xZanrt3W0kr9xXw4kWFy3Gr1xJ3Z7Xa1qvFs0qr13tFy8G3WUCrs7ZFy5
	XFW3KFWUC34jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lizhi2@eswincomputing.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305299-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 825AD718140

From: Zhi Li <lizhi2@eswincomputing.com>

Relax internal delay constraints for EIC7700 Ethernet binding.

Replace fixed enumeration of rx-internal-delay-ps and tx-internal-delay-ps
with a range-based definition (0-2540 ps, 20 ps steps) to reflect actual
hardware capability.

Mark rx/tx internal delay properties as optional, as they are board-
specific tuning parameters rather than mandatory configuration.

Update the device tree example to align with the relaxed constraint model
and remove delay properties from the example to avoid implying they are
required.

No functional change to existing DT users.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 65882ff79d8d..4e02fedae5c6 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -63,10 +63,14 @@ properties:
       - const: stmmaceth
 
   rx-internal-delay-ps:
-    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+    minimum: 0
+    maximum: 2540
+    multipleOf: 20
 
   tx-internal-delay-ps:
-    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
+    minimum: 0
+    maximum: 2540
+    multipleOf: 20
 
   eswin,hsp-sp-csr:
     description:
@@ -105,8 +109,6 @@ required:
   - phy-mode
   - resets
   - reset-names
-  - rx-internal-delay-ps
-  - tx-internal-delay-ps
   - eswin,hsp-sp-csr
 
 unevaluatedProperties: false
@@ -116,23 +118,22 @@ examples:
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
         eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
-        snps,axi-config = <&stmmac_axi_setup>;
+        phy-handle = <&phy0>;
+        phy-mode = "rgmii-id";
         snps,aal;
         snps,fixed-burst;
         snps,tso;
+        snps,axi-config = <&stmmac_axi_setup>;
+
         stmmac_axi_setup: stmmac-axi-config {
             snps,blen = <0 0 0 0 16 8 4>;
             snps,rd_osr_lmt = <2>;
-- 
2.25.1


