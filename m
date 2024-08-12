Return-Path: <netdev+bounces-117661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ABA94EB61
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D632833B0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E12170A27;
	Mon, 12 Aug 2024 10:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA5170A0C
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459326; cv=none; b=k3HulZPGLDyiRJvnDQzeaMgyhMdNBBdIU6gbzFLOOPAdGJ79Ll+vwzuGmoXcoUMPuLr5O5eL5SakW3wa3Ei+3au/zE7VH1g2m1KQi7x15KkjDsNfafXRXrTt+r0DIbz2T+P9/B80uJG88PcVthoXJ5QgZA3ocH1i0Nb0EBUBiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459326; c=relaxed/simple;
	bh=tVrDrgyOXhxRiOnQsxuSu1+SC606CRB8oIPtaHj8v58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RcLX11B5Dw/48jJxGZ0ikfSJh3JWXDkmW4YxaoCceCLHmyhj9xs9/WtKZlT56J6lyYMthBbTAKBtcMWE1ZHmNC9YxGKChPwlb6WnTP1TtbEoT66OjAZSs1I/jLh0qgPGUvoyM8kDw3MbBe9+8UuNR3I66qTcCN1HNTTz59a4PSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sdSUj-0004e9-97; Mon, 12 Aug 2024 12:41:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sdSUh-006L0u-NE; Mon, 12 Aug 2024 12:41:43 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sdSUh-008uYs-25;
	Mon, 12 Aug 2024 12:41:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI configuration
Date: Mon, 12 Aug 2024 12:41:42 +0200
Message-Id: <20240812104142.2123970-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
subnode name. The incorrect name caused the configuration to be
applied to the wrong subnode, resulting in QSPI not working properly.

Some additional changes was made:
- To avoid this kind of regression, all references to pin configuration
  nodes are now referenced directly using the format &{label/subnode}.
- /delete-property/ bias-disable; was added everywhere where bias-pull-up
  is used
- redundant properties like driver-push-pull are removed

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
changes v3:
- extend comment message
---
 arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts  |  12 +-
 arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts  | 108 +++++++---------
 arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 126 +++++++++----------
 arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts  |  16 +--
 4 files changed, 116 insertions(+), 146 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
index 75874eafde11e..8e1dd84e0c0a4 100644
--- a/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
+++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1a.dts
@@ -28,16 +28,12 @@ phy0: ethernet-phy@0 {
 	};
 };

-&pwm5_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('A', 0, AF2)>; /* TIM5_CH1 */
-	};
+&{pwm5_pins_a/pins} {
+	pinmux = <STM32_PINMUX('A', 0, AF2)>; /* TIM5_CH1 */
 };

-&pwm5_sleep_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* TIM5_CH1 */
-	};
+&{pwm5_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* TIM5_CH1 */
 };

 &timers5 {
diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts
index c90d815f906b8..3b33b7093b686 100644
--- a/arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts
+++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1c.dts
@@ -168,52 +168,42 @@ &sdmmc2 {
 	status = "okay";
 };

-&sdmmc2_b4_od_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
-			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
-			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
-			 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
-	};
+&{sdmmc2_b4_od_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+		 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+		 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+		 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
 };

-&sdmmc2_b4_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
-			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
-			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
-			 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
-			 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
-	};
+&{sdmmc2_b4_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+		 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+		 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+		 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+		 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
 };

-&sdmmc2_b4_sleep_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
-			 <STM32_PINMUX('B', 7, ANALOG)>, /* SDMMC2_D1 */
-			 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
-			 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
-			 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
-			 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
-	};
+&{sdmmc2_b4_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
+		 <STM32_PINMUX('B', 7, ANALOG)>, /* SDMMC2_D1 */
+		 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
+		 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
+		 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
+		 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
 };

-&sdmmc2_d47_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
-			 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
-			 <STM32_PINMUX('C', 6, AF10)>, /* SDMMC2_D6 */
-			 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
-	};
+&{sdmmc2_d47_pins_a/pins} {
+	pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
+		 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
+		 <STM32_PINMUX('C', 6, AF10)>, /* SDMMC2_D6 */
+		 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
 };

-&sdmmc2_d47_sleep_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
-			 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
-			 <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC2_D6 */
-			 <STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
-	};
+&{sdmmc2_d47_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
+		 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
+		 <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC2_D6 */
+		 <STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
 };

 &sdmmc3 {
@@ -238,34 +228,28 @@ mmc@1 {
 	};
 };

-&sdmmc3_b4_od_pins_b {
-	pins1 {
-		pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
-			 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
-			 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
-			 <STM32_PINMUX('D', 7, AF10)>; /* SDMMC3_D3 */
-	};
+&{sdmmc3_b4_od_pins_b/pins1} {
+	pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+		 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+		 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+		 <STM32_PINMUX('D', 7, AF10)>; /* SDMMC3_D3 */
 };

-&sdmmc3_b4_pins_b {
-	pins1 {
-		pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
-			 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
-			 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
-			 <STM32_PINMUX('D', 7, AF10)>, /* SDMMC3_D3 */
-			 <STM32_PINMUX('D', 0, AF10)>; /* SDMMC3_CMD */
-	};
+&{sdmmc3_b4_pins_b/pins1} {
+	pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+		 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+		 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+		 <STM32_PINMUX('D', 7, AF10)>, /* SDMMC3_D3 */
+		 <STM32_PINMUX('D', 0, AF10)>; /* SDMMC3_CMD */
 };

-&sdmmc3_b4_sleep_pins_b {
-	pins {
-		pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* SDMMC3_D0 */
-			 <STM32_PINMUX('D', 4, ANALOG)>, /* SDMMC3_D1 */
-			 <STM32_PINMUX('D', 5, ANALOG)>, /* SDMMC3_D2 */
-			 <STM32_PINMUX('D', 7, ANALOG)>, /* SDMMC3_D3 */
-			 <STM32_PINMUX('G', 15, ANALOG)>, /* SDMMC3_CK */
-			 <STM32_PINMUX('D', 0, ANALOG)>; /* SDMMC3_CMD */
-	};
+&{sdmmc3_b4_sleep_pins_b/pins} {
+	pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* SDMMC3_D0 */
+		 <STM32_PINMUX('D', 4, ANALOG)>, /* SDMMC3_D1 */
+		 <STM32_PINMUX('D', 5, ANALOG)>, /* SDMMC3_D2 */
+		 <STM32_PINMUX('D', 7, ANALOG)>, /* SDMMC3_D3 */
+		 <STM32_PINMUX('G', 15, ANALOG)>, /* SDMMC3_CK */
+		 <STM32_PINMUX('D', 0, ANALOG)>; /* SDMMC3_CMD */
 };

 &spi1 {
diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
index 3938d357e198f..98a31c2b5d456 100644
--- a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
@@ -69,30 +69,27 @@ &ethernet0 {
 	status = "okay";
 };

-&ethernet0_rmii_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 12, AF11)>, /* ETH1_RMII_TXD0 */
-			 <STM32_PINMUX('B', 13, AF11)>, /* ETH1_RMII_TXD1 */
-			 <STM32_PINMUX('B', 11, AF11)>; /* ETH1_RMII_TX_EN */
-	};
-	pins2 {
-		pinmux = <STM32_PINMUX('C', 4, AF11)>,  /* ETH1_RMII_RXD0 */
-			 <STM32_PINMUX('C', 5, AF11)>,  /* ETH1_RMII_RXD1 */
-			 <STM32_PINMUX('A', 1, AF11)>,  /* ETH1_RMII_REF_CLK input */
-			 <STM32_PINMUX('A', 7, AF11)>;  /* ETH1_RMII_CRS_DV */
-	};
+&{ethernet0_rmii_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 12, AF11)>, /* ETH1_RMII_TXD0 */
+		 <STM32_PINMUX('B', 13, AF11)>, /* ETH1_RMII_TXD1 */
+		 <STM32_PINMUX('B', 11, AF11)>; /* ETH1_RMII_TX_EN */
 };

-&ethernet0_rmii_sleep_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 12, ANALOG)>, /* ETH1_RMII_TXD0 */
-			 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH1_RMII_TXD1 */
-			 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
-			 <STM32_PINMUX('C', 4, ANALOG)>,  /* ETH1_RMII_RXD0 */
-			 <STM32_PINMUX('C', 5, ANALOG)>,  /* ETH1_RMII_RXD1 */
-			 <STM32_PINMUX('A', 1, ANALOG)>,  /* ETH1_RMII_REF_CLK */
-			 <STM32_PINMUX('A', 7, ANALOG)>;  /* ETH1_RMII_CRS_DV */
-	};
+&{ethernet0_rmii_pins_a/pins2} {
+	pinmux = <STM32_PINMUX('C', 4, AF11)>,  /* ETH1_RMII_RXD0 */
+		 <STM32_PINMUX('C', 5, AF11)>,  /* ETH1_RMII_RXD1 */
+		 <STM32_PINMUX('A', 1, AF11)>,  /* ETH1_RMII_REF_CLK input */
+		 <STM32_PINMUX('A', 7, AF11)>;  /* ETH1_RMII_CRS_DV */
+};
+
+&{ethernet0_rmii_sleep_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 12, ANALOG)>, /* ETH1_RMII_TXD0 */
+		 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH1_RMII_TXD1 */
+		 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
+		 <STM32_PINMUX('C', 4, ANALOG)>,  /* ETH1_RMII_RXD0 */
+		 <STM32_PINMUX('C', 5, ANALOG)>,  /* ETH1_RMII_RXD1 */
+		 <STM32_PINMUX('A', 1, ANALOG)>,  /* ETH1_RMII_REF_CLK */
+		 <STM32_PINMUX('A', 7, ANALOG)>;  /* ETH1_RMII_CRS_DV */
 };

 &iwdg2 {
@@ -122,12 +119,11 @@ flash@0 {
 	};
 };

-&qspi_bk1_pins_a {
-	pins1 {
-		bias-pull-up;
-		drive-push-pull;
-		slew-rate = <1>;
-	};
+&{qspi_bk1_pins_a/pins} {
+	/delete-property/ bias-disable;
+	bias-pull-up;
+	drive-push-pull;
+	slew-rate = <1>;
 };

 &rng1 {
@@ -147,22 +143,24 @@ &sdmmc1 {
 	status = "okay";
 };

-&sdmmc1_b4_od_pins_a {
-	pins1 {
-		bias-pull-up;
-	};
-	pins2 {
-		bias-pull-up;
-	};
+&{sdmmc1_b4_od_pins_a/pins1} {
+	/delete-property/ bias-disable;
+	bias-pull-up;
 };

-&sdmmc1_b4_pins_a {
-	pins1 {
-		bias-pull-up;
-	};
-	pins2 {
-		bias-pull-up;
-	};
+&{sdmmc1_b4_od_pins_a/pins2} {
+	/delete-property/ bias-disable;
+	bias-pull-up;
+};
+
+&{sdmmc1_b4_pins_a/pins1} {
+	/delete-property/ bias-disable;
+	bias-pull-up;
+};
+
+&{sdmmc1_b4_pins_a/pins2} {
+	/delete-property/ bias-disable;
+	bias-pull-up;
 };

 &uart4 {
@@ -175,34 +173,30 @@ &uart4 {
 	status = "okay";
 };

-&uart4_idle_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 9, ANALOG)>; /* UART4_TX */
-	};
-	pins2 {
-		pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
-		bias-pull-up;
-	};
+&{uart4_idle_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 9, ANALOG)>; /* UART4_TX */
 };

-&uart4_pins_a {
-	pins1 {
-		pinmux = <STM32_PINMUX('B', 9, AF8)>; /* UART4_TX */
-		bias-disable;
-		drive-push-pull;
-		slew-rate = <0>;
-	};
-	pins2 {
-		pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
-		bias-pull-up;
-	};
+&{uart4_idle_pins_a/pins2} {
+	pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+	/delete-property/ bias-disable;
+	bias-pull-up;
 };

-&uart4_sleep_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* UART4_TX */
-			<STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
-	};
+&{uart4_pins_a/pins1} {
+	pinmux = <STM32_PINMUX('B', 9, AF8)>; /* UART4_TX */
+	slew-rate = <0>;
+};
+
+&{uart4_pins_a/pins2} {
+	pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+	/delete-property/ bias-disable;
+	bias-pull-up;
+};
+
+&{uart4_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* UART4_TX */
+		<STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
 };

 &usbh_ehci {
diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts b/arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts
index ad25929e64e6e..b6be61b159e72 100644
--- a/arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts
+++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1s.dts
@@ -36,18 +36,14 @@ co2-sensor@62 {
 	};
 };

-&i2c1_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-			 <STM32_PINMUX('D', 13, AF5)>; /* I2C1_SDA */
-	};
+&{i2c1_pins_a/pins} {
+	pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
+		 <STM32_PINMUX('D', 13, AF5)>; /* I2C1_SDA */
 };

-&i2c1_sleep_pins_a {
-	pins {
-		pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
-			 <STM32_PINMUX('D', 13, ANALOG)>; /* I2C1_SDA */
-	};
+&{i2c1_sleep_pins_a/pins} {
+	pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
+		 <STM32_PINMUX('D', 13, ANALOG)>; /* I2C1_SDA */
 };

 &mdio0 {
--
2.39.2


