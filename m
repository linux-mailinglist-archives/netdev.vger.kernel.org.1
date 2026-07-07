Return-Path: <netdev+bounces-305300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iVxlA9ugTGonnQEAu9opvQ
	(envelope-from <netdev+bounces-305300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:46:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188C7181AC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305300-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305300-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF2CD3005748
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904F3AA4E1;
	Tue,  7 Jul 2026 06:42:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE03A9DAE;
	Tue,  7 Jul 2026 06:42:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406548; cv=none; b=ik/yJ4nZF4hTWh2FxGwVEBSrEJeO/BxhWuMsITYCKcxgbxl7cCE/t+3jkGwcWhAxl2B/ZXZjpcXLw4b1OLFRyBtHWUmMKEa5d8r23pa4Tf8PvhQqX+p8vanLCxxE2kcKi57wBJXQ0hUEoxLrMOTjVaHPC5Q8K4q5X85YXTdBA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406548; c=relaxed/simple;
	bh=pkz8pON50iV9qvoUpI4YvtZll8XmiT0AcpM+tQAAM5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmweRoBnxN6FLW6QJaTPqOGatBGHAM6RgGargCSHy6/WqfL0KmGxoyqlZFpO1FKAU88hIhL3YnqHCDDTT2m4yava3Slqmc5zJetoTQIgj3Vu5D4K7yYNWkle7WJNpbMSkzA2WB7aWYJ/dUZHR3CaLwl6V7gDVikHW+JSz9yRWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgDn_aC6n0xqmAAyAA--.40284S2;
	Tue, 07 Jul 2026 14:42:04 +0800 (CST)
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
	Zhi Li <lizhi2@eswincomputing.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v10 2/4] dt-bindings: ethernet: eswin: add EIC7700 eth1 RX clock inversion variant
Date: Tue,  7 Jul 2026 14:41:59 +0800
Message-ID: <20260707064159.1299-1-lizhi2@eswincomputing.com>
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
X-CM-TRANSID:TQJkCgDn_aC6n0xqmAAyAA--.40284S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43Ww1DuF4rJryxJF18Krg_yoWrWryUpF
	WDury8GF18Xr4xJw4xJF10k3W3t397ury3Kr4kJF12g3Z8tFn8XrWI9Fy5Ga4xur4UZFy3
	WayYqF1Ykayqk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lizhi2@eswincomputing.com,m:conor.dooley@microchip.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305300-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6188C7181AC

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

To reflect this, model the TX internal delay as a base 0-4540 ps range,
and constrain valid values per compatible using conditional schema rules.

Update the binding schema as follows:

  - Define tx-internal-delay-ps as a base range: 0-4540 ps
  - Add compatible-specific constraints using if/then rules:
    * eswin,eic7700-qos-eth:
        max 2540 ps
    * eswin,eic7700-qos-eth-clk-inversion:
        minimum 2000 ps (effective range 2000-4540 ps)

No functional change for existing "eswin,eic7700-qos-eth" users.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../bindings/net/eswin,eic7700-eth.yaml       | 51 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index 4e02fedae5c6..ba49fd6a086c 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -20,16 +20,37 @@ select:
       contains:
         enum:
           - eswin,eic7700-qos-eth
+          - eswin,eic7700-qos-eth-clk-inversion
   required:
     - compatible
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-qos-eth
+    then:
+      properties:
+        tx-internal-delay-ps:
+          maximum: 2540
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-qos-eth-clk-inversion
+    then:
+      properties:
+        tx-internal-delay-ps:
+          minimum: 2000
 
 properties:
   compatible:
     items:
-      - const: eswin,eic7700-qos-eth
+      - enum:
+          - eswin,eic7700-qos-eth
+          - eswin,eic7700-qos-eth-clk-inversion
       - const: snps,dwmac-5.20
 
   reg:
@@ -69,7 +90,7 @@ properties:
 
   tx-internal-delay-ps:
     minimum: 0
-    maximum: 2540
+    maximum: 4540
     multipleOf: 20
 
   eswin,hsp-sp-csr:
@@ -140,3 +161,29 @@ examples:
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


