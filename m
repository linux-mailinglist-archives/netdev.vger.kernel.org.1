Return-Path: <netdev+bounces-270905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODIbEbg+wmmCagQAu9opvQ
	(envelope-from <netdev+bounces-270905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:35:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBCB3040D6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31916301DD2B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75C331202;
	Tue, 24 Mar 2026 07:34:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55973358C2;
	Tue, 24 Mar 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337689; cv=none; b=nHphsrVAx1ZrWDgEhe6Jb67hy2XnZVeyf6qYSy/icYo3rc5o0un9eQH7sL5Y2c06LybrWifK3fSrBuWmRULVgGT3SrtF+lEPuzeWlKyDWL4CdMikDFqwKBnxzvJLHsXsnQAxtk/+HTo4N63bBIjG/x5I58IJ7rtwsTCTYtP6Frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337689; c=relaxed/simple;
	bh=9NqFRadax7AtkssXZXghsvWQ2TMnz7wfVN+4Myf13hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJh9Q0hc5aHcxJXSDIjzHyLvDdju4rF6XBJcmHJhIpC7Eg6a8ecx3HyjQt24QbBsF2T8vVeSFMKlTWN7vzcDgvxIcKkOj2W0jDVrJ/sAD7XcTqf0pdJtl/w6qda9FdmfkrIqvPY2agY0H4OElfRhOx6q3H+o6EUPo/o7AXGdK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgDX7J91PsJp6jYLAA--.23271S2;
	Tue, 24 Mar 2026 15:34:14 +0800 (CST)
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
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v5 3/3] riscv: dts: eswin: eic7700-hifive-premier-p550: enable Ethernet controller
Date: Tue, 24 Mar 2026 15:34:08 +0800
Message-ID: <20260324073408.439-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260324073017.376-1-lizhi2@eswincomputing.com>
References: <20260324073017.376-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgDX7J91PsJp6jYLAA--.23271S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWxtw1DWr1xtFy8WFWDCFg_yoWrGw45pF
	47urZ5XrWrWr1xA34YvFy09FZxJws7GF95Krn7tFyDGF4q9FWYvr4jy3WfJF17ArWUX3y5
	WFs3t34FkF4vy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRdWrXUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email,3.19.90.128:email,3.9.72.96:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,3.1.11.0:email,eswincomputing.com:email,eswincomputing.com:mid,3.1.50.16:email]
X-Rspamd-Queue-Id: 2DBCB3040D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhi Li <lizhi2@eswincomputing.com>

Enable the on-board Gigabit Ethernet controller on the
HiFive Premier P550 development board.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 42 ++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 66 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 131ed1fc6b2e..5a40be1d2a25 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -13,6 +13,8 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
@@ -20,6 +22,46 @@ chosen {
 	};
 };
 
+&gmac0 {
+	phy-handle = <&gmac0_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio106_pins>;
+	rx-internal-delay-ps = <20>;
+	tx-internal-delay-ps = <100>;
+	status = "okay";
+
+	mdio {
+		gmac0_phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <0>;
+			reset-gpios = <&gpioD 10 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
+&gmac1 {
+	phy-handle = <&gmac1_phy0>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio111_pins>;
+	rx-internal-delay-ps = <200>;
+	tx-internal-delay-ps = <200>;
+	status = "okay";
+
+	mdio {
+		gmac1_phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <0>;
+			reset-gpios = <&gpioD 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c3ed93008bca..f1a01d5736a1 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -295,6 +297,70 @@ uart4: serial@50940000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@50400000 {
+			compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
+			reg = <0x0 0x50400000 0x0 0x10000>;
+			interrupts = <61>;
+			interrupt-names = "macirq";
+			clocks = <&clk 186>,
+				 <&clk 171>,
+				 <&clk 40>,
+				 <&clk 193>;
+			clock-names = "axi", "cfg", "stmmaceth", "tx";
+			resets = <&reset 95>;
+			reset-names = "stmmaceth";
+			eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
+			snps,aal;
+			snps,fixed-burst;
+			snps,tso;
+			snps,axi-config = <&stmmac_axi_setup_gmac0>;
+			status = "disabled";
+
+			stmmac_axi_setup_gmac0: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <2>;
+				snps,wr_osr_lmt = <2>;
+			};
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		gmac1: ethernet@50410000 {
+			compatible = "eswin,eic7700-qos-eth-clk-inversion", "snps,dwmac-5.20";
+			reg = <0x0 0x50410000 0x0 0x10000>;
+			interrupts = <70>;
+			interrupt-names = "macirq";
+			clocks = <&clk 186>,
+				 <&clk 171>,
+				 <&clk 40>,
+				 <&clk 194>;
+			clock-names = "axi", "cfg", "stmmaceth", "tx";
+			resets = <&reset 94>;
+			reset-names = "stmmaceth";
+			eswin,hsp-sp-csr = <&hsp_sp_csr 0x200 0x208 0x218 0x214 0x21c>;
+			snps,aal;
+			snps,fixed-burst;
+			snps,tso;
+			snps,axi-config = <&stmmac_axi_setup_gmac1>;
+			status = "disabled";
+
+			stmmac_axi_setup_gmac1: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <2>;
+				snps,wr_osr_lmt = <2>;
+			};
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gpio@51600000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x0 0x51600000 0x0 0x80>;
-- 
2.25.1


