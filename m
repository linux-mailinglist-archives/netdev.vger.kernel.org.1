Return-Path: <netdev+bounces-162015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE30A25528
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125F93A612C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68E207E13;
	Mon,  3 Feb 2025 08:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11382063D0
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573135; cv=none; b=fwFsTsxKSis3N9DFpbJC1jUtLGaEyeg0uWKXDpFMTWohO8PaQga5abrSiLsJwZLkTdByFGWQ4qyXHApnTnyxpPnX9rexDbzu9mugp/hLtdSFsIibm71iImqwq26Jk2Mbxm0qDcNGTQWGAp5cy1nzYJOs3C6ZqYoQTRZMezoNvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573135; c=relaxed/simple;
	bh=u5hHotMfnfJezgdZjrGpcV6bEbtmyoRIusrOyONghN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQIzQZNt2zXTNjpLIEknPHG0oTo/XUhY3mA1MFSjLMvsFamO1AtuIhRJdJG2UDwKRfIYxuxLXB3k/xHUkVdyNj54UYzm7BDiRmcRcGkaXbuxGOIljVWvY+nlLCxeagj99Ntbm9Djlbn9x73Wk7HCsNFK1CthT3IkNuV80J/qjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHf-0006KI-I4; Mon, 03 Feb 2025 09:58:23 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHd-003GNq-36;
	Mon, 03 Feb 2025 09:58:21 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tesHd-002YZN-2m;
	Mon, 03 Feb 2025 09:58:21 +0100
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
Cc: Roan van Dijk <roan@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 4/4] arm: dts: stm32: Add Priva E-Measuringbox devicetree
Date: Mon,  3 Feb 2025 09:58:20 +0100
Message-Id: <20250203085820.609176-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203085820.609176-1-o.rempel@pengutronix.de>
References: <20250203085820.609176-1-o.rempel@pengutronix.de>
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

From: Roan van Dijk <roan@protonic.nl>

Introduce the devicetree for the Priva E-Measuringbox board
(stm32mp133c-prihmb), based on the STM32MP133 SoC.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/Makefile               |   1 +
 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts | 496 ++++++++++++++++++++
 2 files changed, 497 insertions(+)
 create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index b7d5d305cbbe..d8f297035812 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32h743i-eval.dtb \
 	stm32h743i-disco.dtb \
 	stm32h750i-art-pi.dtb \
+	stm32mp133c-prihmb.dtb \
 	stm32mp135f-dhcor-dhsbc.dtb \
 	stm32mp135f-dk.dtb \
 	stm32mp151a-prtt1a.dtb \
diff --git a/arch/arm/boot/dts/st/stm32mp133c-prihmb.dts b/arch/arm/boot/dts/st/stm32mp133c-prihmb.dts
new file mode 100644
index 000000000000..663b6de1b814
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp133c-prihmb.dts
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/regulator/st,stm32mp13-regulator.h>
+#include "stm32mp133.dtsi"
+#include "stm32mp13xc.dtsi"
+#include "stm32mp13-pinctrl.dtsi"
+
+/ {
+	model = "Priva E-Measuringbox board";
+	compatible = "pri,prihmb", "st,stm32mp133";
+
+	aliases {
+		ethernet0 = &ethernet1;
+		mdio-gpio0 = &mdio0;
+		mmc0 = &sdmmc1;
+		mmc1 = &sdmmc2;
+		serial0 = &uart4;
+		serial1 = &usart6;
+		serial2 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	counter-0 {
+		compatible = "interrupt-counter";
+		gpios = <&gpioa 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		button-reset {
+			label = "reset-button";
+			linux,code = <BTN_1>;
+			gpios = <&gpioi 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
+
+	led-controller-0 {
+		compatible = "pwm-leds-multicolor";
+
+		multi-led {
+			color = <LED_COLOR_ID_RGB>;
+			function = LED_FUNCTION_STATUS;
+			max-brightness = <255>;
+
+			led-red {
+				active-low;
+				color = <LED_COLOR_ID_RED>;
+				pwms = <&pwm2 2 1000000 1>;
+			};
+
+			led-green {
+				active-low;
+				color = <LED_COLOR_ID_GREEN>;
+				pwms = <&pwm1 1 1000000 1>;
+			};
+
+			led-blue {
+				active-low;
+				color = <LED_COLOR_ID_BLUE>;
+				pwms = <&pwm1 2 1000000 1>;
+			};
+		};
+	};
+
+	led-controller-1 {
+		compatible = "pwm-leds-multicolor";
+
+		multi-led {
+			color = <LED_COLOR_ID_RGB>;
+			function = LED_FUNCTION_STATUS;
+			max-brightness = <255>;
+
+			led-red {
+				active-low;
+				color = <LED_COLOR_ID_RED>;
+				pwms = <&pwm1 0 1000000 1>;
+			};
+
+			led-green {
+				active-low;
+				color = <LED_COLOR_ID_GREEN>;
+				pwms = <&pwm2 0 1000000 1>;
+			};
+
+			led-blue {
+				active-low;
+				color = <LED_COLOR_ID_BLUE>;
+				pwms = <&pwm2 1 1000000 1>;
+			};
+		};
+	};
+
+	/* DP83TD510E PHYs have max MDC rate of 1.75MHz. Since we can't reduce
+	 * stmmac MDC clock without reducing system bus rate, we need to use
+	 * gpio based MDIO bus.
+	 */
+	mdio0: mdio {
+		compatible = "virtual,mdio-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpiog 2 GPIO_ACTIVE_HIGH
+			 &gpioa 2 GPIO_ACTIVE_HIGH>;
+
+		/* TI DP83TD510E */
+		phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-id2000.0181";
+			reg = <0>;
+			interrupts-extended = <&gpioa 4 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpioa 3 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10>;
+			reset-deassert-us = <35>;
+		};
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x10000000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		optee@ce000000 {
+			reg = <0xce000000 0x02000000>;
+			no-map;
+		};
+	};
+};
+
+&adc_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc_1_pins_a>;
+	vdda-supply = <&reg_3v3>;
+	vref-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+
+	channel@0 { /* Fan current PC0*/
+		reg = <0>;
+		st,min-sample-time-ns = <10000>;  /* 10µs sampling time */
+	};
+	channel@11 { /* Fan voltage */
+		reg = <11>;
+		st,min-sample-time-ns = <10000>;  /* 10µs sampling time */
+	};
+	channel@15 { /* Supply voltage */
+		reg = <15>;
+		st,min-sample-time-ns = <10000>;  /* 10µs sampling time */
+	};
+};
+
+&dts {
+	status = "okay";
+};
+
+&ethernet1 {
+	status = "okay";
+	pinctrl-0 = <&ethernet1_rmii_pins_a>;
+	pinctrl-1 = <&ethernet1_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	clock-frequency = <100000>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+
+	board-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+		vs-supply = <&reg_3v3>;
+	};
+};
+
+&{i2c1_pins_a/pins} {
+	pinmux = <STM32_PINMUX('D', 3, AF5)>, /* I2C1_SCL */
+		 <STM32_PINMUX('B', 8, AF4)>; /* I2C1_SDA */
+	bias-disable;
+	drive-open-drain;
+	slew-rate = <0>;
+};
+
+&{i2c1_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('D', 3, ANALOG)>, /* I2C1_SCL */
+		 <STM32_PINMUX('B', 8, ANALOG)>; /* I2C1_SDA */
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+/* SD card without Card-detect */
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_clk_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_clk_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	no-sdio;
+	no-1-8-v;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+/* EMMC */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a &sdmmc2_clk_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a &sdmmc2_clk_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	no-1-8-v;
+	st,neg-edge;
+	mmc-ddr-3_3v;
+	bus-width = <8>;
+	vmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&timers1 {
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pwm1: pwm {
+		pinctrl-0 = <&pwm1_pins_a>;
+		pinctrl-1 = <&pwm1_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&timers4 {
+	status = "okay";
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	pwm2: pwm {
+		pinctrl-0 = <&pwm4_pins_a>;
+		pinctrl-1 = <&pwm4_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+/* Fan PWM */
+&timers5 {
+	status = "okay";
+
+	pwm3: pwm {
+		pinctrl-0 = <&pwm5_pins_a>;
+		pinctrl-1 = <&pwm5_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&timers2 {
+	status = "okay";
+
+	timer@1 {
+		status = "okay";
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-1 = <&uart7_sleep_pins_a>;
+	pinctrl-2 = <&uart7_idle_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&usart6 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&usart6_pins_a>;
+	pinctrl-1 = <&usart6_sleep_pins_a>;
+	pinctrl-2 = <&usart6_idle_pins_a>;
+	linux,rs485-enabled-at-boot-time;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+};
+
+&pinctrl {
+	adc_1_pins_a: adc1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>, /* ADC1 in0 */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* ADC1 in15 */
+				 <STM32_PINMUX('F', 13, ANALOG)>; /* ADC1 in11 */
+		};
+	};
+
+	ethernet1_rmii_pins_a: rmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, AF11)>, /* ETH1_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, AF11)>, /* ETH1_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, AF11)>;   /* ETH1_RMII_REF_CLK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>,  /* ETH1_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>,  /* ETH1_RMII_RXD1 */
+				 <STM32_PINMUX('A', 7, AF11)>;  /* ETH1_RMII_CRS_DV */
+			bias-disable;
+		};
+	};
+
+	ethernet1_rmii_sleep_pins_a: rmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH1_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
+				 <STM32_PINMUX('C', 4, ANALOG)>,  /* ETH1_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>,  /* ETH1_RMII_RXD1 */
+				 <STM32_PINMUX('A', 1, ANALOG)>,  /* ETH1_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 7, ANALOG)>;  /* ETH1_RMII_CRS_DV */
+		};
+	};
+
+	pwm1_pins_a: pwm1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 9, AF1)>, /* TIM1_CH1 */
+				 <STM32_PINMUX('E', 11, AF1)>, /* TIM1_CH2 */
+				 <STM32_PINMUX('E', 13, AF1)>; /* TIM1_CH3 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_sleep_pins_a: pwm1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 9, ANALOG)>, /* TIM1_CH1 */
+				 <STM32_PINMUX('E', 11, ANALOG)>, /* TIM1_CH2 */
+				 <STM32_PINMUX('E', 13, ANALOG)>; /* TIM1_CH3 */
+		};
+	};
+
+	pwm4_pins_a: pwm4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, AF2)>, /* TIM4_CH1 */
+				 <STM32_PINMUX('B', 7, AF2)>, /* TIM4_CH2 */
+				 <STM32_PINMUX('D', 14, AF2)>; /* TIM4_CH3 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm4_sleep_pins_a: pwm4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* TIM4_CH1 */
+				 <STM32_PINMUX('B', 7, ANALOG)>, /* TIM4_CH2 */
+				 <STM32_PINMUX('D', 14, ANALOG)>; /* TIM4_CH3 */
+		};
+	};
+	pwm5_pins_a: pwm5-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, AF2)>; /* TIM5_CH1 */
+		};
+	};
+
+	pwm5_sleep_pins_a: pwm5-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* TIM5_CH1 */
+		};
+	};
+
+	uart7_pins_a: uart7-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 8, AF7)>; /* UART_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 10, AF7)>; /* UART7_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart7_idle_pins_a: uart7-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 8, ANALOG)>; /* UART7_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 10, AF7)>; /* UART7_RX */
+			bias-pull-up;
+		};
+	};
+
+	uart7_sleep_pins_a: uart7-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 8, ANALOG)>, /* UART7_TX */
+				 <STM32_PINMUX('E', 10, ANALOG)>; /* UART7_RX */
+		};
+	};
+
+	usart6_pins_a: usart6-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 8, AF7)>, /* USART6_TX */
+				 <STM32_PINMUX('F', 10, AF7)>; /* USART6_DE */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('H', 11, AF7)>; /* USART6_RX */
+			bias-disable;
+		};
+	};
+
+	usart6_idle_pins_a: usart6-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 8, ANALOG)>; /* USART6_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 10, AF7)>; /* USART6_DE */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('H', 11, AF7)>; /* USART6_RX */
+			bias-disable;
+		};
+	};
+
+	usart6_sleep_pins_a: usart6-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* USART6_TX */
+				 <STM32_PINMUX('F', 10, ANALOG)>, /* USART6_DE */
+				 <STM32_PINMUX('H', 11, ANALOG)>; /* USART6_RX */
+		};
+	};
+};
-- 
2.39.5


