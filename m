Return-Path: <netdev+bounces-19413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5575A987
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A6E281CA3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF217FFE;
	Thu, 20 Jul 2023 08:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1718C0B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35967C4E666;
	Thu, 20 Jul 2023 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841799;
	bh=tQpRwOI9qd6EISdIVOISFvSg8C78HBc9uOA039m8NQg=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=GYbSz1ZoNassX5VMn5FpD+ybpDhMRbSkdezpYilMz21rr4TFD09A9QUxVOM9EU2d1
	 fRKnKL9EiKTjs0Gl+QB274vqlfyg+r1TU0YPhE4sRo9jft2Y8NNqZHujaY0O4hmIsq
	 7WiCrHq+nr0MmiebQ31LJjbYmioDU5CZDMsrVhf0gM7h5SHFJW/N00dZWHc946j3ny
	 0N59EfKsyRy+GStQ4K01OVWWS+xHmousoWq/ygeJpSGWyFFedv7UmgniZvyR56sJmn
	 v8V0CDlpogmUrQkVak1dTx/qsdJaj91pfL2Z2eo3143FXcUowXPimeEh0/UFx5Nwab
	 MhSeLnODLnygQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E6C25B74;
	Thu, 20 Jul 2023 08:29:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:41 +0300
Subject: [PATCH v3 41/42] ARM: dts: ep93xx: Add EDB9302 DT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-41-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
List-Id: <soc.lore.kernel.org>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lennert Buytenhek <kernel@wantstofly.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, soc@kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>, 
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852591; l=4512;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=5A/29Z9MEsZn34YHAjSZrcVyC80yiuUqer7DzC/dFHU=; =?utf-8?q?b=3DQQcWlnw/kBKF?=
 =?utf-8?q?Rps3KM+YKWtLXhoIshjWyk2O7eP9CGncWEaSJERWuOZCZZyVcCUKfMYJqTqP2u64?=
 COrsnPXNAU5aP+LE3xWErGGy0JDSJA+HL3C6+HFsQ35RKBIDKxBW
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Add device tree for Cirrus EDB9302.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/Makefile           |   1 +
 arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts | 178 ++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
index 211a7e2f2115..e6015983e464 100644
--- a/arch/arm/boot/dts/cirrus/Makefile
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -4,5 +4,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_EP93XX) += \
+	ep93xx-edb9302.dtb \
 	ep93xx-bk3.dtb \
 	ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
new file mode 100644
index 000000000000..b048fd131aa5
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/*
+ * Device Tree file for Cirrus Logic EDB9302 board based on EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+#include <dt-bindings/dma/cirrus,ep93xx-dma.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "cirrus,edb9302", "cirrus,ep9301";
+	model = "cirrus,edb9302";
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x0000000 0x800000>,
+		      <0x1000000 0x800000>,
+		      <0x4000000 0x800000>,
+		      <0x5000000 0x800000>;
+	};
+
+	flash@60000000 {
+		compatible = "cfi-flash";
+		reg = <0x60000000 0x1000000>;
+		bank-width = <2>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "EDB93XX";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,convert-channels = <2>;
+		simple-audio-card,convert-sample-format = "s32_le";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s>;
+			system-clock-direction-out;
+			frame-master;
+			bitclock-master;
+			dai-sample-format = "s32_le";
+			dai-channels = <2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&cs4271>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&gpio0 {
+	gpio-ranges = <&pinctrl 0 153 1>,
+		      <&pinctrl 1 152 1>,
+		      <&pinctrl 2 151 1>,
+		      <&pinctrl 3 148 1>,
+		      <&pinctrl 4 147 1>,
+		      <&pinctrl 5 146 1>,
+		      <&pinctrl 6 145 1>,
+		      <&pinctrl 7 144 1>;
+};
+
+&gpio1 {
+	gpio-ranges = <&pinctrl 0 143 1>,
+		      <&pinctrl 1 142 1>,
+		      <&pinctrl 2 141 1>,
+		      <&pinctrl 3 140 1>,
+		      <&pinctrl 4 165 1>,
+		      <&pinctrl 5 164 1>,
+		      <&pinctrl 6 163 1>,
+		      <&pinctrl 7 160 1>;
+};
+
+&gpio2 {
+	gpio-ranges = <&pinctrl 0 115 1>;
+	status = "okay";
+};
+
+&gpio4 {
+	gpio-ranges = <&pinctrl 0 97 2>;
+	status = "okay";
+};
+
+&gpio5 {
+	gpio-ranges = <&pinctrl 1 170 1>,
+		      <&pinctrl 2 169 1>,
+		      <&pinctrl 3 168 1>;
+};
+
+&gpio6 {
+	gpio-ranges = <&pinctrl 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&pinctrl 2 199 4>;
+	status = "okay";
+};
+
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&spi0 {
+	cs-gpios = <&gpio0 6 GPIO_ACTIVE_LOW
+		    &gpio0 7 GPIO_ACTIVE_LOW>;
+	dmas = <&dma1 EP93XX_DMA_SSP>;
+	status = "okay";
+
+	cs4271: codec@0 {
+		compatible = "cirrus,cs4271";
+		reg = <0>;
+		#sound-dai-cells = <0>;
+		spi-max-frequency = <6000000>;
+		spi-cpol;
+		spi-cpha;
+		reset-gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	at25f1024: eeprom@1 {
+		compatible = "atmel,at25";
+		reg = <1>;
+		address-width = <8>;
+		size = <0x20000>;
+		pagesize = <256>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+

-- 
2.39.2


