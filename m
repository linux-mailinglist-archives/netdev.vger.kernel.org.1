Return-Path: <netdev+bounces-140361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4309B62A1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865BF1F215A1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B41EF08B;
	Wed, 30 Oct 2024 12:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D251EABB1
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290229; cv=none; b=uBZjorRBqbH9g9WRpfqW1SIjM4y7QL6i+DDnIr+CeyJNfuK/xfuzA3uOFzQ3VM1uE/3HH05vuqJAnWlVXeLSYGeTTXxJju5YJBbXIUWsKfaERAfmsHeaoS6nzSc90bh7Yx9FJ+3bcv1NbnDCGzrUd6S/51LMpnqKLc6Pd9RA5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290229; c=relaxed/simple;
	bh=s722pgkDTlnM7gfii6RdJq/Bs5rZKJoE9xRzLi3V97w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thlLUE0fo3l6HoHbRTgD0t123o22LT4HqpIwzRCSBEvh026aFd/lANsj4zEdkokGhmI4F2tVuu5TUiWico1CNvzzldzR5FOmvU7jiMl4qBX2/h0O3MBW2ZNXacfP7qscutUlED8ePgPaqkn3LXs3qJ7l48XT85uqVrwCWtqnz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1t67Wo-0006os-8G; Wed, 30 Oct 2024 13:10:22 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 30 Oct 2024 13:10:15 +0100
Subject: [PATCH 4/4] arm64: dts: agilex5: initial support for Arrow
 AXE5-Eagle
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-v6-12-topic-socfpga-agilex5-v1-4-b2b67780e60e@pengutronix.de>
References: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-v1-0-b2b67780e60e@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-clk@vger.kernel.org, kernel@pengutronix.de, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The Arrow AXE5-Eagle is an Intel Agilex5 SoCFPGA based board with:

   - 1x PCIe Gen4.0 edge connector
   - 4-port USB HUB
   - 2x 1Gb Ethernet
   - microSD
   - HDMI output
   - 2x 10Gb SFP+ cages

As most devices aren't supported mainline yet, this is only the initial
support for the board.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm64/boot/dts/intel/Makefile                 |   1 +
 .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 146 +++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index d39cfb723f5b6674a821dfdafb21b12668bb1e0e..3e87d548c532b1a9e38f4489c037c5c4db3a50b8 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex5_socdk.dtb \
+				socfpga_agilex5_axe5_eagle.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dts
new file mode 100644
index 0000000000000000000000000000000000000000..bd5bd8f680c9ade49ac174108beed6828c5a925d
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_axe5_eagle.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024, Arrow Electronics, Inc.
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Arrow AXE5-Eagle";
+	compatible = "arrow,socfpga-agilex5-axe5-eagle", "intel,socfpga-agilex";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		hps0 {
+			label = "hps_led0";
+			gpios = <&porta 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&porta 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		hps_sw0 {
+			label = "hps_sw0";
+			gpios = <&porta 10 0>;
+			linux,input-type = <5>;	/* EV_SW */
+			linux,code = <0x0>;
+		};
+
+		hps_sw1 {
+			label = "hps_sw1";
+			gpios = <&porta 1 0>;
+			linux,input-type = <5>;	/* EV_SW */
+			linux,code = <0x0>;
+		};
+
+		hps_pb0 {
+			label = "hps_pb0";
+			gpios = <&porta 8 1>;
+			linux,code = <187>;		/* KEY_F17 */
+		};
+
+		hps_pb1 {
+			label = "hps_pb1";
+			gpios = <&porta 9 1>;
+			linux,code = <188>;		/* KEY_F18 */
+		};
+	};
+
+	vdd: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vdd_3_3: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		emac2_phy0: ethernet-phy@1 {
+			reg = <0x1>;
+			adi,rx-internal-delay-ps = <2000>;
+			adi,tx-internal-delay-ps = <2000>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	tca9544@70 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		status = "okay";
+	};
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,mt25qu02g", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.46.0


