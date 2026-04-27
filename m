Return-Path: <netdev+bounces-281247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K5mI50R72mU5QAAu9opvQ
	(envelope-from <netdev+bounces-281247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4F46E6AF
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DBE0300251F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC1391831;
	Mon, 27 Apr 2026 07:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9837BE63;
	Mon, 27 Apr 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274787; cv=none; b=SBKPjzqDKF1ZdxoDzpwvOyZmCxFQ5rMy8sZgN6DirSrHgJQe4Lk4FbFbxAUxkjlNil+eHOpZZ6GTgSzt8a0A15HcbmcG0afKrkNua9CzoO/b30vKVVB3Ig3UKA2kLQNLBFnXIvKbReN8YVnLRzpXyIht4469PEXkz/GUpsVFXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274787; c=relaxed/simple;
	bh=AV/4WIjIpB/fkATMpQxXWyLqtUTFaO4TFi06X5//AS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs7J1yffMO8zwlsvdCy6VbDB0r0v8YhyBiuoZVvZCT0NeVOnfNpM1tSmTveUkRSPD/rZgvk49AKrey8OMksBjRNdwK+ZDu6543917q0qWxNhYkwN65lHVc4uC2mDln1XfhpmXF2R/0d3EWWsfsV/CfMYk8OwicTf67fRu4u7M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgD3DKCOD+9pcQkVAA--.24679S2;
	Mon, 27 Apr 2026 15:26:07 +0800 (CST)
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
Subject: [PATCH net-next v7 4/4] riscv: dts: eswin: eic7700-hifive-premier-p550: enable Ethernet controller
Date: Mon, 27 Apr 2026 15:26:03 +0800
Message-ID: <20260427072603.1191-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260427072353.1114-1-lizhi2@eswincomputing.com>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgD3DKCOD+9pcQkVAA--.24679S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF45GryxJr1fXr1DGFWkXrb_yoW3tw18pa
	13urWfJw4kuF4Svw4jvF40kFZrGan7KFykurnrtFy8Jw1v9FnYk34jqFy5XF1DZrWrXw13
	JFnrJ34xtF1xA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRQ6p9UUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 94D4F46E6AF
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281247-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Spam: Yes

From: Zhi Li <lizhi2@eswincomputing.com>

Enable the on-board Gigabit Ethernet controller on the
HiFive Premier P550 development board.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 239 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 105 ++++++++
 2 files changed, 344 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 131ed1fc6b2e..4e09ad738d3d 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -13,11 +13,250 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vcc_1v8: vcc1v8 {
+		 compatible = "regulator-fixed";
+		 regulator-name = "vcc1v8";
+		 regulator-always-on;
+		 regulator-boot-on;
+		 regulator-min-microvolt = <1800000>;
+		 regulator-max-microvolt = <1800000>;
+	 };
+};
+
+&xtal24m {
+	clock-frequency = <24000000>;
+	clock-output-names = "xtal24m";
+};
+
+&pinctrl {
+	status = "okay";
+	vrgmii-supply = <&vcc_1v8>;
+
+	pinctrl_gpio0: gpio0-grp {
+		gpio0-pins {
+			pins = "gpio0";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio5: gpio5-grp {
+		gpio5-pins {
+			pins = "gpio5";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio11: gpio11-grp {
+		gpio11-pins {
+			pins = "gpio11";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio14: gpio14-grp {
+		gpio14-pins {
+			pins = "mode_set1";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio15: gpio15-grp {
+		gpio15-pins {
+			pins = "mode_set2";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio28: gpio28-grp {
+		gpio28-pins {
+			pins = "gpio28";
+			function = "gpio";
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio43: gpio43-grp {
+		gpio43-pins {
+			pins = "usb1_pwren";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio71: gpio71-grp {
+		gpio71-pins {
+			pins = "mipi_csi0_xhs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio74: gpio74-grp {
+		gpio74-pins {
+			pins = "mipi_csi1_xhs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio76: gpio76-grp {
+		gpio76-pins {
+			pins = "mipi_csi2_xvs";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio77: gpio77-grp {
+		gpio77-pins {
+			pins = "mipi_csi2_xhs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio79: gpio79-grp {
+		gpio79-pins {
+			pins = "mipi_csi3_xvs";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio80: gpio80-grp {
+		gpio80-pins {
+			pins = "mipi_csi3_xhs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio82: gpio82-grp {
+		gpio82-pins {
+			pins = "mipi_csi4_xvs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio84: gpio84-grp {
+		gpio84-pins {
+			pins = "mipi_csi4_mclk";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio85: gpio85-grp {
+		gpio85-pins {
+			pins = "mipi_csi5_xvs";
+			function = "gpio";
+			input-disable;
+			bias-pull-up;
+		};
+	};
+
+	pinctrl_gpio94: gpio94-grp {
+		gpio94-pins {
+			pins = "s_mode";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio106: gpio106-grp {
+		gpio106-pins {
+			pins = "gpio106";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio111: gpio111-grp {
+		gpio111-pins {
+			pins = "gpio111";
+			function = "gpio";
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&gmac0 {
+	phy-handle = <&gmac0_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio106>;
+	rx-internal-delay-ps = <20>;
+	tx-internal-delay-ps = <100>;
+	status = "okay";
+};
+
+&gmac0_mdio {
+	gmac0_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0>;
+		reset-gpios = <&gpioD 10 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+	};
+};
+
+&gmac1 {
+	phy-handle = <&gmac1_phy0>;
+	/*
+	 * For the TX path of gmac1, there is a skew between the TX clock
+	 * and data on the MAC controller inside the silicon. This skew happens
+	 * to be approximately 2 ns. Therefore, it can be considered that the
+	 * 2 ns delay of TX is provided by the MAC.
+	 * No delay configuration for tx is needed in software via PHY driver.
+	 */
+	phy-mode = "rgmii-rxid";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio111>;
+	rx-internal-delay-ps = <200>;
+	tx-internal-delay-ps = <200>;
+	status = "okay";
+};
+
+&gmac1_mdio {
+	gmac1_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0>;
+		reset-gpios = <&gpioD 15 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+	};
 };
 
 &uart0 {
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c3ed93008bca..c77bc8b1b7bc 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -5,6 +5,9 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/reset/eswin,eic7700-reset.h>
+
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -202,6 +205,11 @@ pmu {
 				<0x00000000 0x0000000f 0xfffffffc 0x000000ff 0x00000078>;
 	};
 
+	xtal24m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
@@ -245,6 +253,85 @@ plic: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
 		};
 
+		hsp_power_domain: bus@50400000 {
+			compatible = "simple-pm-bus";
+			ranges;
+			clocks = <&clk 171>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			hsp_sp_csr: hsp-sp-top-csr@50440000 {
+				compatible = "eswin,eic7700-syscfg", "syscon";
+				reg = <0x0 0x50440000 0x0 0x2000>;
+			};
+
+			gmac0: ethernet@50400000 {
+				compatible = "eswin,eic7700-qos-eth",
+					     "snps,dwmac-5.20";
+				reg = <0x0 0x50400000 0x0 0x10000>;
+				interrupts = <61>;
+				interrupt-names = "macirq";
+				clocks = <&clk 186>,
+					 <&clk 171>,
+					 <&clk 40>,
+					 <&clk 193>;
+				clock-names = "axi", "cfg", "stmmaceth", "tx";
+				resets = <&reset EIC7700_RESET_HSP_ETH0_ARST>;
+				reset-names = "stmmaceth";
+				eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
+				snps,aal;
+				snps,fixed-burst;
+				snps,tso;
+				snps,axi-config = <&stmmac_axi_setup_gmac0>;
+				status = "disabled";
+
+				gmac0_mdio: mdio {
+					compatible = "snps,dwmac-mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				stmmac_axi_setup_gmac0: stmmac-axi-config {
+					snps,blen = <0 0 0 0 16 8 4>;
+					snps,rd_osr_lmt = <2>;
+					snps,wr_osr_lmt = <2>;
+				};
+			};
+
+			gmac1: ethernet@50410000 {
+				compatible = "eswin,eic7700-qos-eth-clk-inversion",
+					     "snps,dwmac-5.20";
+				reg = <0x0 0x50410000 0x0 0x10000>;
+				interrupts = <70>;
+				interrupt-names = "macirq";
+				clocks = <&clk 186>,
+					 <&clk 171>,
+					 <&clk 40>,
+					 <&clk 194>;
+				clock-names = "axi", "cfg", "stmmaceth", "tx";
+				resets = <&reset EIC7700_RESET_HSP_ETH1_ARST>;
+				reset-names = "stmmaceth";
+				eswin,hsp-sp-csr = <&hsp_sp_csr 0x200 0x208 0x218 0x214 0x21c>;
+				snps,aal;
+				snps,fixed-burst;
+				snps,tso;
+				snps,axi-config = <&stmmac_axi_setup_gmac1>;
+				status = "disabled";
+
+				gmac1_mdio: mdio {
+					compatible = "snps,dwmac-mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				stmmac_axi_setup_gmac1: stmmac-axi-config {
+					snps,blen = <0 0 0 0 16 8 4>;
+					snps,rd_osr_lmt = <2>;
+					snps,wr_osr_lmt = <2>;
+				};
+			};
+		};
+
 		uart0: serial@50900000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x50900000 0x0 0x10000>;
@@ -341,5 +428,23 @@ gpioD: gpio-port@3 {
 				#gpio-cells = <2>;
 			};
 		};
+
+		pinctrl: pinctrl@51600080 {
+			compatible = "eswin,eic7700-pinctrl";
+			reg = <0x0 0x51600080 0x0 0x1fff80>;
+		};
+
+		clk: clock-controller@51828000 {
+			compatible = "eswin,eic7700-clock";
+			reg = <0x0 0x51828000 0x0 0x300>;
+			clocks = <&xtal24m>;
+			#clock-cells = <1>;
+		};
+
+		reset: reset-controller@51828300 {
+			compatible = "eswin,eic7700-reset";
+			reg = <0x0 0x51828300 0x0 0x200>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.25.1


