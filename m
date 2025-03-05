Return-Path: <netdev+bounces-171975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD74A4FBBC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1976C16C30C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48689207663;
	Wed,  5 Mar 2025 10:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD252066FF
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170085; cv=none; b=onbqh2CfXZG79SAn+40VHyLvyhddWqSgeXjN2Dc/Nyfe4IUrn9OeeimXKa+MddOcRI1rZ5WjX2Zfbq/dxX+fInvzrurgf9+1dnEX7RxMPU9UHNg+ednWkd7qMuOzZkj4PJeYYD4cRfx9z9UHSSsdsdw00XoTQujrmJWo4Ct3xAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170085; c=relaxed/simple;
	bh=qu3dMnrB/+ZKvw1h6CFmaump0y4uo0s27FlaBehBgbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEL/E3qMfNI9McBgqsix8zrS1tOSydfy3yW7lJngRlBToaGpNLPD6BGCz4b/bOwI8r6dr25NCw5i0/3RVeTM/gZrEGxqZj59LvYWxK0qjBRfEpvDElrSlDv39B0RsfENRNwyPFYGLIGIVN9wR14D+OrPtkcz0Ly38+80PIDaxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tplsA-0001n5-K3; Wed, 05 Mar 2025 11:21:06 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpls8-0047xm-2A;
	Wed, 05 Mar 2025 11:21:04 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpls8-0050hm-1p;
	Wed, 05 Mar 2025 11:21:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 4/4] arm: dts: stm32: Add Plymovent AQM devicetree
Date: Wed,  5 Mar 2025 11:21:03 +0100
Message-Id: <20250305102103.1194277-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305102103.1194277-1-o.rempel@pengutronix.de>
References: <20250305102103.1194277-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce the devicetree for the Plymovent AQM board
(stm32mp151c-plyaqm), based on the STM32MP151 SoC.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- move all pinctrls to stm32mp15-pinctrl.dtsi
- remove some of comments
changes v2:
- remove spidev
---
 arch/arm/boot/dts/st/Makefile               |   1 +
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts | 376 ++++++++++++++++++++
 2 files changed, 377 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index d8f297035812..561819ef7a32 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp151a-dhcor-testbench.dtb \
 	stm32mp151c-mecio1r0.dtb \
 	stm32mp151c-mect1s.dtb \
+	stm32mp151c-plyaqm.dtb \
 	stm32mp153c-dhcom-drc02.dtb \
 	stm32mp153c-dhcor-drc-compact.dtb \
 	stm32mp153c-lxa-tac-gen3.dtb \
diff --git a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
new file mode 100644
index 000000000000..39a3211c6133
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/dts-v1/;
+
+#include <arm/st/stm32mp151.dtsi>
+#include <arm/st/stm32mp15xc.dtsi>
+#include <arm/st/stm32mp15-pinctrl.dtsi>
+#include <arm/st/stm32mp15xxad-pinctrl.dtsi>
+#include <arm/st/stm32mp15-scmi.dtsi>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Plymovent AQM board";
+	compatible = "ply,plyaqm", "st,stm32mp151";
+
+	aliases {
+		ethernet0 = &ethernet0;
+		serial0 = &uart4;
+		serial1 = &uart7;
+	};
+
+	codec {
+		compatible = "invensense,ics43432";
+
+		port {
+			codec_endpoint: endpoint {
+				remote-endpoint = <&i2s1_endpoint>;
+				dai-format = "i2s";
+			};
+		};
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpioa 3 GPIO_ACTIVE_HIGH>; /* WHITE_EN */
+			color = <LED_COLOR_ID_WHITE>;
+			default-state = "on";
+		};
+	};
+
+	v3v3: fixed-regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	v5v_sw: fixed-regulator-v5sw {
+		compatible = "regulator-fixed";
+		regulator-name = "5v-switched";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpioe 10 GPIO_ACTIVE_HIGH>; /* 5V_SWITCHED_EN */
+		startup-delay-us = <100000>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		optee@cfd00000 {
+			reg = <0xcfd00000 0x300000>;
+			no-map;
+		};
+	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "STM32MP15";
+		dais = <&i2s1_port>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpioe 12 GPIO_ACTIVE_LOW>; /* WLAN_REG_ON */
+	};
+};
+
+&adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc1_in10_pins_a>;
+	vdda-supply = <&v3v3>;
+	vref-supply = <&v3v3>;
+	status = "okay";
+
+	adc@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		channel@10 { /* NTC */
+			reg = <10>;
+			st,min-sample-time-ns = <10000>;  /* 10µs sampling time */
+		};
+	};
+};
+
+&cpu0 {
+	clocks = <&scmi_clk CK_SCMI_MPU>;
+};
+
+&cryp1 {
+	clocks = <&scmi_clk CK_SCMI_CRYP1>;
+	resets = <&scmi_reset RST_SCMI_CRYP1>;
+	status = "okay";
+};
+
+&ethernet0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ethernet0_rmii_pins_d>;
+	pinctrl-1 = <&ethernet0_rmii_sleep_pins_d>;
+	phy-mode = "rmii";
+	max-speed = <100>;
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		/* KSZ8081RNA PHY */
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			interrupts-extended = <&gpiob 0 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpiob 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+		};
+	};
+};
+
+&gpioa {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "HWID_PL_N", "HWID_CP", "";
+};
+
+&gpiob {
+	gpio-line-names =
+		"", "", "", "", "", "", "LED_LATCH", "",
+		"", "RELAY1_EN", "", "", "", "", "", "";
+};
+
+&gpioc {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "HWID_Q7", "", "";
+};
+
+&gpioe {
+	gpio-line-names =
+		"", "", "", "", "RELAY2_EN", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpiog {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "SW1",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpioz {
+	clocks = <&scmi_clk CK_SCMI_GPIOZ>;
+};
+
+&hash1 {
+	clocks = <&scmi_clk CK_SCMI_HASH1>;
+	resets = <&scmi_reset RST_SCMI_HASH1>;
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_c>;
+	pinctrl-1 = <&i2c1_sleep_pins_c>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&i2c4 {
+	clocks = <&scmi_clk CK_SCMI_I2C4>;
+	resets = <&scmi_reset RST_SCMI_I2C4>;
+};
+
+&i2c6 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c6_pins_b>;
+	pinctrl-1 = <&i2c6_sleep_pins_b>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	clocks = <&scmi_clk CK_SCMI_I2C6>;
+	resets = <&scmi_reset RST_SCMI_I2C6>;
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pressure-sensor@47 {
+		compatible = "bosch,bmp580";
+		reg = <0x47>;
+		vdda-supply = <&v5v_sw>;
+		vddd-supply = <&v5v_sw>;
+	};
+
+	co2-sensor@62 {
+		compatible = "sensirion,scd41";
+		reg = <0x62>;
+		vdd-supply = <&v5v_sw>;
+	};
+
+	pm-sensor@69 {
+		compatible = "sensirion,sps30";
+		reg = <0x69>;
+	};
+};
+
+&i2s1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2s1_pins_a>;
+	pinctrl-1 = <&i2s1_sleep_pins_a>;
+	clocks = <&rcc SPI1>, <&rcc SPI1_K>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
+	clock-names = "pclk", "i2sclk", "x8k", "x11k";
+	#clock-cells = <0>; /* Set I2S2 as master clock provider */
+	status = "okay";
+
+	i2s1_port: port {
+		i2s1_endpoint: endpoint {
+			format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&codec_endpoint>;
+		};
+	};
+};
+
+&iwdg2 {
+	clocks = <&rcc IWDG2>, <&scmi_clk CK_SCMI_LSI>;
+	status = "okay";
+};
+
+&m4_rproc {
+	/delete-property/ st,syscfg-holdboot;
+	resets = <&scmi_reset RST_SCMI_MCU>,
+		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
+	reset-names =  "mcu_rst", "hold_boot";
+};
+
+&mdma1 {
+	resets = <&scmi_reset RST_SCMI_MDMA>;
+};
+
+&rcc {
+	compatible = "st,stm32mp1-rcc-secure", "syscon";
+	clock-names = "hse", "hsi", "csi", "lse", "lsi";
+	clocks = <&scmi_clk CK_SCMI_HSE>,
+		 <&scmi_clk CK_SCMI_HSI>,
+		 <&scmi_clk CK_SCMI_CSI>,
+		 <&scmi_clk CK_SCMI_LSE>,
+		 <&scmi_clk CK_SCMI_LSI>;
+};
+
+&rng1 {
+	clocks = <&scmi_clk CK_SCMI_RNG1>;
+	resets = <&scmi_reset RST_SCMI_RNG1>;
+	status = "okay";
+};
+
+&rtc {
+	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
+};
+
+/* SD card without Card-detect */
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	no-sdio;
+	no-1-8-v;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+/* EMMC */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_c &sdmmc2_d47_pins_b>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_c &sdmmc2_d47_pins_b>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_c &sdmmc2_d47_sleep_pins_b>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	no-1-8-v;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+/* Wifi */
+&sdmmc3 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc3_b4_pins_c>;
+	pinctrl-1 = <&sdmmc3_b4_od_pins_c>;
+	pinctrl-2 = <&sdmmc3_b4_sleep_pins_c>;
+	non-removable;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&timers5 {
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pwm {
+		pinctrl-0 = <&pwm1_pins_d>;
+		pinctrl-1 = <&pwm1_sleep_pins_d>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_e>;
+	pinctrl-1 = <&uart4_idle_pins_e>;
+	pinctrl-2 = <&uart4_sleep_pins_e>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7_pins_d>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpioe 11 GPIO_ACTIVE_HIGH>; /* BT_REG_ON */
+		max-speed = <4000000>;
+		vbat-supply = <&v3v3>;
+		vddio-supply = <&v3v3>;
+		interrupt-parent = <&gpiog>;
+		interrupts = <12 IRQ_TYPE_EDGE_RISING>; /* BT_HOST_WAKE */
+		interrupt-names = "host-wakeup";
+	};
+};
-- 
2.39.5


