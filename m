Return-Path: <netdev+bounces-221656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576CB51719
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A567B7DA1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388B3203B0;
	Wed, 10 Sep 2025 12:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3331E0E2
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507753; cv=none; b=d1LFlu0hHfByXUah5Z/+yul6B8lQkJDsO/tx6/2s6zOXRa6SXdjsYsCxeeusy6joqutC4AM19QmesoG+QyhynB8PrgNTLLOr/m0K5tUvWlAfu8ADYTw6hUcNSQ2e0db49Q4Df0AzOHciFZiANlQ4l3Jel5PvbUdq+nfiwa7XHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507753; c=relaxed/simple;
	bh=s0M0sAz8h/alBG2cRJTTtEAoSvFkgVQYP22HVYjpIMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBW8E2SyIctpGQN4ShS4dc/9r3mT3o7LrpNNQC7mBQPtZtp0IYYC+jjnDvoo0SmawbWVfh0mgpZL+9OHd8EnHr9LABtjJigJiWKUwyxRk2PPDTtNd8lUvgsM7Rfv+nXQkjlkgTNUd3CdNDU4izunf0nW7/D3VMZ2ZP5DtJ8PI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uwK31-0002Rk-P6; Wed, 10 Sep 2025 14:35:39 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 10 Sep 2025 14:35:24 +0200
Subject: [PATCH 4/4] arm64: dts: add Protonic PRT8ML board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-imx8mp-prt8ml-v1-4-fd04aed15670@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
In-Reply-To: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Jonas Rebmann <jre@pengutronix.de>, 
 Lucas Stach <l.stach@pengutronix.de>, David Jander <david@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=11356; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=dpgo5Cr+imCiuH9s75jY9Aqxgw8Eo/ufiFt62AIsYok=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4WDBL4DC7TgzL4nthZ54Jx09wLnPVDGXob6+NXKKuv
 Lxe4rhcRykLgxgXg6yYIkusmpyCkLH/dbNKu1iYOaxMIEMYuDgFYCJXrRkZznUdOHTryZX1F/mW
 z13Co5ZndH/JxRNC3SkvH2vNspz9SYbhfyCL+b8vGt4vDe5P1JtV/nNVxulVFuImDSd2hh6zqfy
 1jAcA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Add devicetree for the Protonic PRT8ML.

The board is similar to the Protonic PRT8MM but i.MX8MP based.

Some features have been removed as the drivers haven't been mainlined
yet or other issues where encountered:
 - Stepper motors to be controlled using motion control subsystem
 - MIPI/DSI to eDP USB alt-mode
 - Onboard ethernet (10BASE-T1L+PoDL, 100BASE-T1+PoDL, 1000BASE-T,
   1000BASE-T1)

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/Makefile          |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts | 409 ++++++++++++++++++++++++
 2 files changed, 410 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2be724579632..98ab7387726e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -222,6 +222,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-prt8ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts b/arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts
new file mode 100644
index 000000000000..95d5c29b4887
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Protonic Holland
+ * Copyright 2019 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+
+/ {
+	model = "Protonic PRT8ML";
+	compatible = "prt,prt8ml", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	clock_sja1105: clock-sja1105 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	pcie_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pcie_refclk_oe: pcie0-refclk-oe {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie_refclk>;
+		clocks = <&pcie_refclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&fan53555>;
+};
+
+&A53_1 {
+	cpu-supply = <&fan53555>;
+};
+
+&A53_2 {
+	cpu-supply = <&fan53555>;
+};
+
+&A53_3 {
+	cpu-supply = <&fan53555>;
+};
+
+&a53_opp_table {
+	opp-1200000000 {
+		opp-microvolt = <900000>;
+	};
+
+	opp-1600000000 {
+		opp-microvolt = <980000>;
+	};
+
+	/delete-node/ opp-1800000000;
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	ak5558: codec@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio_exp_1 2 GPIO_ACTIVE_LOW>;
+	};
+
+	gpio_exp_1: gpio@25 {
+		compatible = "nxp,pca9571";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	tps65987ddh_0: usb-pd@20 {
+		compatible = "ti,tps6598x";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tps65987ddh_0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	gpio_exp_2: gpio@25 {
+		compatible = "nxp,pca9571";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		c0-hreset-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			line-name = "c0-hreset";
+			output-low;
+		};
+
+		c1-hreset-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			line-name = "c1-hreset";
+			output-low;
+		};
+	};
+
+	fan53555: regulator@60 {
+		compatible = "fcs,fan53555";
+		reg = <0x60>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan53555>;
+		regulator-name = "fan53555";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <980000>;
+		regulator-always-on;
+		regulator-boot-on;
+		fcs,suspend-voltage-selector = <1>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	ak4458: codec@11 {
+		compatible = "asahi-kasei,ak4458";
+		reg = <0x11>;
+		#sound-dai-cells = <0>;
+		reset-gpios = <&gpio_exp_2 5 GPIO_ACTIVE_LOW>;
+	};
+
+	tps65987ddh_1: usb-pd@20 {
+		compatible = "ti,tps6598x";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tps65987ddh_1>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <100000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fan53555: fan53555grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x114
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX		0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX		0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART3_TXD__CAN2_RX		0x154
+			MX8MP_IOMUXC_UART3_RXD__CAN2_TX		0x154
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__I2C1_SCL	0x400000c3
+			MX8MP_IOMUXC_ECSPI1_MOSI__I2C1_SDA	0x400000c3
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400000c3
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400000c3
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400000c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400000c3
+		>;
+	};
+
+	pinctrl_pcie_refclk: pcierefclkgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_TXD__GPIO5_IO23	0xc6
+		>;
+	};
+
+	pinctrl_tps65987ddh_0: tps65987ddh_0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x1d0
+		>;
+	};
+
+	pinctrl_tps65987ddh_1: tps65987ddh_1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15	0x1d0
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x040
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x040
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x0d4
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0x166
+		>;
+	};
+};

-- 
2.51.0.178.g2462961280


