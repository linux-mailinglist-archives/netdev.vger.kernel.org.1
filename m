Return-Path: <netdev+bounces-172040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD60A50067
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CA3BBAF7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184524CEC2;
	Wed,  5 Mar 2025 13:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309C24C073
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180489; cv=none; b=ZKA6ZE/N3E9BqwoVEmV2GUM2CQOGoGeT0hz0jWZqzRvJekNoKqvBY+pRXfvMrE9h2pL11K9IUicHP7S4/R42GaaoVcbP5h7MKI9K76RUCOXWuQrehF1kdGR30hH1Fg0zGPQdWXV3/lVb2RN+Beb9J9KU93NNQNq4EpxFD2EjeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180489; c=relaxed/simple;
	bh=BbTAWagfnSyWjzM+4l1VuDEtviOwLQ71Y89ec1iIv/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CITzh5roMy53A7Kf8/nLnQSVkon7t0PjqxvHBtXC55O7L5psGjhLVYUzkk9v8SRYlKlhxn64nDBLmezPV0z48jd8yyeYLB1l2T09+mLgz+RLxDKMAXmzbPYm11Pm6ohdtoD2zvxMdwi9Z9B/c2CpPTiv9C/itbbCIUjDy8eiBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZw-0000xd-A1; Wed, 05 Mar 2025 14:14:28 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZv-0049PA-1e;
	Wed, 05 Mar 2025 14:14:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpoZv-006G5t-1O;
	Wed, 05 Mar 2025 14:14:27 +0100
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
Subject: [PATCH v5 3/4] ARM: dts: stm32: Add pinmux groups for Plymovent AQM board
Date: Wed,  5 Mar 2025 14:14:24 +0100
Message-Id: <20250305131425.1491769-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305131425.1491769-1-o.rempel@pengutronix.de>
References: <20250305131425.1491769-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add pinmux groups required for the Plymovent AQM board.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 292 ++++++++++++++++++++
 1 file changed, 292 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 95fafc51a1c8..40605ea85ee1 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -25,6 +25,13 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	adc1_in10_pins_a: adc1-in10-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>;
+		};
+	};
+
 	/omit-if-no-ref/
 	adc12_ain_pins_a: adc12-ain-0 {
 		pins {
@@ -584,6 +591,43 @@ pins1 {
 		};
 	};
 
+	/omit-if-no-ref/
+	ethernet0_rmii_pins_d: rmii-3 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 12, AF11)>, /* ETH1_RMII_TXD0 */
+				 <STM32_PINMUX('B', 13, AF11)>, /* ETH1_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, AF11)>, /* ETH1_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, AF11)>, /* ETH1_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 2, AF11)>, /* ETH1_MDIO */
+				 <STM32_PINMUX('C', 1, AF11)>; /* ETH1_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH1_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>, /* ETH1_RMII_RXD1 */
+				 <STM32_PINMUX('A', 7, AF11)>; /* ETH1_RMII_CRS_DV */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	ethernet0_rmii_sleep_pins_d: rmii-sleep-3 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 12, ANALOG)>, /* ETH1_RMII_TXD0 */
+				 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH1_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
+				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH1_MDIO */
+				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH1_MDC */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH1_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH1_RMII_RXD1 */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH1_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH1_RMII_CRS_DV */
+		};
+	};
+
 	/omit-if-no-ref/
 	fmc_pins_a: fmc-0 {
 		pins1 {
@@ -725,6 +769,25 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	i2c1_pins_c: i2c1-2 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
+				 <STM32_PINMUX('D', 13, AF5)>; /* I2C1_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	i2c1_sleep_pins_c: i2c1-sleep-2 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
+				 <STM32_PINMUX('D', 13, ANALOG)>; /* I2C1_SDA */
+		};
+	};
+
 	/omit-if-no-ref/
 	i2c2_pins_a: i2c2-0 {
 		pins {
@@ -819,6 +882,27 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	i2s1_pins_a: i2s1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 6, AF5)>, /* I2S2_SDI */
+				 <STM32_PINMUX('A', 4, AF5)>, /* I2S2_WS */
+				 <STM32_PINMUX('A', 5, AF5)>; /* I2S2_CK */
+			slew-rate = <0>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	i2s1_sleep_pins_a: i2s1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 6, ANALOG)>, /* I2S2_SDI */
+				 <STM32_PINMUX('A', 4, ANALOG)>, /* I2S2_WS */
+				 <STM32_PINMUX('A', 5, ANALOG)>; /* I2S2_CK */
+		};
+	};
+
 	/omit-if-no-ref/
 	i2s2_pins_a: i2s2-0 {
 		pins {
@@ -1418,6 +1502,23 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm1_pins_d: pwm1-3 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, AF2)>; /* TIM5_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm1_sleep_pins_d: pwm1-sleep-3 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 0, ANALOG)>;
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm2_pins_a: pwm2-0 {
 		pins {
@@ -2160,6 +2261,66 @@ pins3 {
 		};
 	};
 
+	/omit-if-no-ref/
+	sdmmc2_b4_pins_c: sdmmc2-b4-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_od_pins_c: sdmmc2-b4-od-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 3, AF9)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins3 {
+			pinmux = <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-open-drain;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_sleep_pins_c: sdmmc2-b4-sleep-2 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('B', 7, ANALOG)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
+				 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
+		};
+	};
+
 	/omit-if-no-ref/
 	sdmmc2_d47_pins_a: sdmmc2-d47-0 {
 		pins {
@@ -2389,6 +2550,66 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	sdmmc3_b4_pins_c: sdmmc3-b4-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+				 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+				 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+				 <STM32_PINMUX('D', 7, AF10)>, /* SDMMC3_D3 */
+				 <STM32_PINMUX('D', 0, AF10)>; /* SDMMC3_CMD */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 15, AF10)>; /* SDMMC3_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc3_b4_od_pins_c: sdmmc3-b4-od-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+				 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+				 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+				 <STM32_PINMUX('D', 7, AF10)>; /* SDMMC3_D3 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 15, AF10)>; /* SDMMC3_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+
+		pins3 {
+			pinmux = <STM32_PINMUX('D', 0, AF10)>; /* SDMMC3_CMD */
+			slew-rate = <1>;
+			drive-open-drain;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc3_b4_sleep_pins_c: sdmmc3-b4-sleep-2 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* SDMMC3_D0 */
+				 <STM32_PINMUX('D', 4, ANALOG)>, /* SDMMC3_D1 */
+				 <STM32_PINMUX('D', 5, ANALOG)>, /* SDMMC3_D2 */
+				 <STM32_PINMUX('D', 7, ANALOG)>, /* SDMMC3_D3 */
+				 <STM32_PINMUX('G', 15, ANALOG)>, /* SDMMC3_CK */
+				 <STM32_PINMUX('D', 0, ANALOG)>; /* SDMMC3_CMD */
+		};
+	};
+
 	/omit-if-no-ref/
 	spdifrx_pins_a: spdifrx-0 {
 		pins {
@@ -2600,6 +2821,41 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	uart4_pins_e: uart4-4 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 8, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_idle_pins_e: uart4-idle-4 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 11, ANALOG)>; /* UART4_TX */
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 8, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_sleep_pins_e: uart4-sleep-4 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 11, ANALOG)>, /* UART4_TX */
+				 <STM32_PINMUX('B', 8, ANALOG)>; /* UART4_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	uart5_pins_a: uart5-0 {
 		pins1 {
@@ -2677,6 +2933,23 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	uart7_pins_d: uart7-3 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF7)>, /* UART7_TX */
+				 <STM32_PINMUX('F', 8, AF7)>; /* UART7_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 7, AF7)>, /* UART7_RX */
+				 <STM32_PINMUX('F', 9, AF7)>; /* UART7_CTS */
+			bias-disable;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart8_pins_a: uart8-0 {
 		pins1 {
@@ -3118,6 +3391,25 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	i2c6_pins_b: i2c6-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 11, AF2)>, /* I2C6_SCL */
+				 <STM32_PINMUX('A', 12, AF2)>; /* I2C6_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	i2c6_sleep_pins_b: i2c6-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 11, ANALOG)>, /* I2C6_SCL */
+				 <STM32_PINMUX('A', 12, ANALOG)>; /* I2C6_SDA */
+		};
+	};
+
 	/omit-if-no-ref/
 	spi1_pins_a: spi1-0 {
 		pins1 {
-- 
2.39.5


