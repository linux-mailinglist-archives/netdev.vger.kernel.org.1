Return-Path: <netdev+bounces-43881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7072B7D516A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0845B21017
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2492B5E6;
	Tue, 24 Oct 2023 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSmUCMqm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FC2B5C9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:20:42 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355AC1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:20:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso64930821fa.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698153635; x=1698758435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRBNUBWDvC8PjaXpudIsup23k/J35U9YbvcI1paPU+Q=;
        b=jSmUCMqm3veBhVrlICesax5twZiS8m0M8rd9372IsIzq58FJsowVpH9NdPbvGgMqPZ
         j8ooQJU9b6xuhRG2GGWbR2cggRC3nMNKxSxBPxIFrFo9grCgWVkwSDJFxxQ7UnoOxH4T
         BYdQjQ5akHCWbrWTQTPYY0WuX3D0faN/TUM2L8gtHJWoJf7UvqpBK56tdpgJVXv0/ksJ
         NN0vSK6hKadiI96+bCMJcu7N9h9rKEAy1P2Lc+byqmu68amLXmC1uqpfwWGmEGuDioA9
         uqRDAIZaNYqFc0hcb5hjcmDzeEddSTyVi5A4bpPaCc7znMsGdZOQRVYElMxTjVk3IFKw
         dewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698153635; x=1698758435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRBNUBWDvC8PjaXpudIsup23k/J35U9YbvcI1paPU+Q=;
        b=YPzpIAhhNCY/HKUBEdsYwAfbPDh11PDpolCmaKhyTcJs3J/Nx84f3AwUV1LmjjTo/Q
         ZlVjizi3gLvsYWBl58DoHcjPe39ztBujDF1t3ntTkt1ZjfQMwVAaKVzRZftTmtIbFPiU
         iOG5PvUt8jY2eAYjhjFwhDBseibFiQBpHt6/VJ5M3YeQOB/X10urW4VghBwAzCL1Aq58
         g2ej+6kr0SQN2ZvPFnmhu0hldywW1q5bTo/F9nR+Jos+okLx9HTqKmNCM0zvo5AW/7Xw
         RVcFzhqhlrDb3ZSfQv8UUZTI4Efnegu51w0ra4pEjGZzuK/qqxVKExcUwAtLa49RJbhx
         gVbw==
X-Gm-Message-State: AOJu0YyVjfUwYtQpdLHl0VsS2O5hNbAIr59+frDSDVVWTTRrcbdtR0E5
	ilvqXjXfDk2FeuGabIbmXk3Y8Q==
X-Google-Smtp-Source: AGHT+IF34VdJzUvD80/vmz2LmmtZnAD2Qoeq/kCU6BmvwMnOT9ScyelRzvMFVtlzKBmcaHj13li+Sg==
X-Received: by 2002:a05:6512:318f:b0:502:d743:8a6c with SMTP id i15-20020a056512318f00b00502d7438a6cmr11688990lfe.9.1698153635374;
        Tue, 24 Oct 2023 06:20:35 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d5-20020a193845000000b00507ab956ab9sm2147365lfj.147.2023.10.24.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:20:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Oct 2023 15:20:30 +0200
Subject: [PATCH net-next v7 4/7] ARM: dts: nxp: Fix some common switch
 mistakes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v7-4-2869347697d1@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- switch0@0 is not OK, should be ethernet-switch@0
- ports should be ethernet-ports
- port should be ethernet-port
- phy should be ethernet-phy

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts      | 14 ++---
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts  | 70 ++++++++++++------------
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts      | 18 +++---
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts  | 20 +++----
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts | 18 +++---
 5 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
index 1a19aec8957b..7e72f860c3c5 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts
@@ -162,7 +162,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: ethernet-switch@0 {
 			compatible = "marvell,mv88e6085";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_switch>;
@@ -173,26 +173,26 @@ switch0: switch0@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			ports {
+			ethernet-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
+				ethernet-port@0 {
 					reg = <0>;
 					label = "eth_cu_1000_1";
 				};
 
-				port@1 {
+				ethernet-port@1 {
 					reg = <1>;
 					label = "eth_cu_1000_2";
 				};
 
-				port@2 {
+				ethernet-port@2 {
 					reg = <2>;
 					label = "eth_cu_1000_3";
 				};
 
-				port@5 {
+				ethernet-port@5 {
 					reg = <5>;
 					label = "eth_fc_1000_1";
 					phy-mode = "1000base-x";
@@ -200,7 +200,7 @@ port@5 {
 					sfp = <&sff>;
 				};
 
-				port@6 {
+				ethernet-port@6 {
 					reg = <6>;
 					phy-mode = "rmii";
 					ethernet = <&fec1>;
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
index df1335492a19..77492eeea450 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts
@@ -47,17 +47,17 @@ mdio_mux_1: mdio@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0: switch0@0 {
+			switch0: ethernet-switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 0>;
 				eeprom-length = <65536>;
 
-				ports {
+				ethernet-ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@0 {
+					ethernet-port@0 {
 						reg = <0>;
 						phy-mode = "rmii";
 						ethernet = <&fec1>;
@@ -68,37 +68,37 @@ fixed-link {
 						};
 					};
 
-					port@1 {
+					ethernet-port@1 {
 						reg = <1>;
 						label = "aib2main_1";
 					};
 
-					port@2 {
+					ethernet-port@2 {
 						reg = <2>;
 						label = "aib2main_2";
 					};
 
-					port@3 {
+					ethernet-port@3 {
 						reg = <3>;
 						label = "eth_cu_1000_5";
 					};
 
-					port@4 {
+					ethernet-port@4 {
 						reg = <4>;
 						label = "eth_cu_1000_6";
 					};
 
-					port@5 {
+					ethernet-port@5 {
 						reg = <5>;
 						label = "eth_cu_1000_4";
 					};
 
-					port@6 {
+					ethernet-port@6 {
 						reg = <6>;
 						label = "eth_cu_1000_7";
 					};
 
-					port@7 {
+					ethernet-port@7 {
 						reg = <7>;
 						label = "modem_pic";
 
@@ -108,7 +108,7 @@ fixed-link {
 						};
 					};
 
-					switch0port10: port@10 {
+					switch0port10: ethernet-port@10 {
 						reg = <10>;
 						label = "dsa";
 						phy-mode = "xgmii";
@@ -130,32 +130,32 @@ mdio_mux_2: mdio@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1: switch1@0 {
+			switch1: ethernet-switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 1>;
 				eeprom-length = <65536>;
 
-				ports {
+				ethernet-ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@1 {
+					ethernet-port@1 {
 						reg = <1>;
 						label = "eth_cu_1000_3";
 					};
 
-					port@2 {
+					ethernet-port@2 {
 						reg = <2>;
 						label = "eth_cu_100_2";
 					};
 
-					port@3 {
+					ethernet-port@3 {
 						reg = <3>;
 						label = "eth_cu_100_3";
 					};
 
-					switch1port9: port@9 {
+					switch1port9: ethernet-port@9 {
 						reg = <9>;
 						label = "dsa";
 						phy-mode = "xgmii";
@@ -168,7 +168,7 @@ fixed-link {
 						};
 					};
 
-					switch1port10: port@10 {
+					switch1port10: ethernet-port@10 {
 						reg = <10>;
 						label = "dsa";
 						phy-mode = "xgmii";
@@ -188,17 +188,17 @@ mdio_mux_4: mdio@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2: switch2@0 {
+			switch2: ethernet-switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 2>;
 				eeprom-length = <65536>;
 
-				ports {
+				ethernet-ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@2 {
+					ethernet-port@2 {
 						reg = <2>;
 						label = "eth_fc_1000_2";
 						phy-mode = "1000base-x";
@@ -206,7 +206,7 @@ port@2 {
 						sfp = <&sff1>;
 					};
 
-					port@3 {
+					ethernet-port@3 {
 						reg = <3>;
 						label = "eth_fc_1000_3";
 						phy-mode = "1000base-x";
@@ -214,7 +214,7 @@ port@3 {
 						sfp = <&sff2>;
 					};
 
-					port@4 {
+					ethernet-port@4 {
 						reg = <4>;
 						label = "eth_fc_1000_4";
 						phy-mode = "1000base-x";
@@ -222,7 +222,7 @@ port@4 {
 						sfp = <&sff3>;
 					};
 
-					port@5 {
+					ethernet-port@5 {
 						reg = <5>;
 						label = "eth_fc_1000_5";
 						phy-mode = "1000base-x";
@@ -230,7 +230,7 @@ port@5 {
 						sfp = <&sff4>;
 					};
 
-					port@6 {
+					ethernet-port@6 {
 						reg = <6>;
 						label = "eth_fc_1000_6";
 						phy-mode = "1000base-x";
@@ -238,7 +238,7 @@ port@6 {
 						sfp = <&sff5>;
 					};
 
-					port@7 {
+					ethernet-port@7 {
 						reg = <7>;
 						label = "eth_fc_1000_7";
 						phy-mode = "1000base-x";
@@ -246,7 +246,7 @@ port@7 {
 						sfp = <&sff6>;
 					};
 
-					port@9 {
+					ethernet-port@9 {
 						reg = <9>;
 						label = "eth_fc_1000_1";
 						phy-mode = "1000base-x";
@@ -254,7 +254,7 @@ port@9 {
 						sfp = <&sff0>;
 					};
 
-					switch2port10: port@10 {
+					switch2port10: ethernet-port@10 {
 						reg = <10>;
 						label = "dsa";
 						phy-mode = "2500base-x";
@@ -276,17 +276,17 @@ mdio_mux_8: mdio@8 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch3: switch3@0 {
+			switch3: ethernet-switch@0 {
 				compatible = "marvell,mv88e6190";
 				reg = <0>;
 				dsa,member = <0 3>;
 				eeprom-length = <65536>;
 
-				ports {
+				ethernet-ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@2 {
+					ethernet-port@2 {
 						reg = <2>;
 						label = "eth_fc_1000_8";
 						phy-mode = "1000base-x";
@@ -294,7 +294,7 @@ port@2 {
 						sfp = <&sff7>;
 					};
 
-					port@3 {
+					ethernet-port@3 {
 						reg = <3>;
 						label = "eth_fc_1000_9";
 						phy-mode = "1000base-x";
@@ -302,7 +302,7 @@ port@3 {
 						sfp = <&sff8>;
 					};
 
-					port@4 {
+					ethernet-port@4 {
 						reg = <4>;
 						label = "eth_fc_1000_10";
 						phy-mode = "1000base-x";
@@ -310,7 +310,7 @@ port@4 {
 						sfp = <&sff9>;
 					};
 
-					switch3port9: port@9 {
+					switch3port9: ethernet-port@9 {
 						reg = <9>;
 						label = "dsa";
 						phy-mode = "2500base-x";
@@ -322,7 +322,7 @@ fixed-link {
 						};
 					};
 
-					switch3port10: port@10 {
+					switch3port10: ethernet-port@10 {
 						reg = <10>;
 						label = "dsa";
 						phy-mode = "xgmii";
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
index 1461804ecaea..2a490464660c 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts
@@ -123,7 +123,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: ethernet-switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
@@ -134,11 +134,11 @@ switch0: switch0@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			ports {
+			ethernet-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
+				ethernet-port@0 {
 					reg = <0>;
 					phy-mode = "rmii";
 					ethernet = <&fec1>;
@@ -149,32 +149,32 @@ fixed-link {
 					};
 				};
 
-				port@1 {
+				ethernet-port@1 {
 					reg = <1>;
 					label = "eth_cu_1000_1";
 				};
 
-				port@2 {
+				ethernet-port@2 {
 					reg = <2>;
 					label = "eth_cu_1000_2";
 				};
 
-				port@3 {
+				ethernet-port@3 {
 					reg = <3>;
 					label = "eth_cu_1000_3";
 				};
 
-				port@4 {
+				ethernet-port@4 {
 					reg = <4>;
 					label = "eth_cu_1000_4";
 				};
 
-				port@5 {
+				ethernet-port@5 {
 					reg = <5>;
 					label = "eth_cu_1000_5";
 				};
 
-				port@6 {
+				ethernet-port@6 {
 					reg = <6>;
 					label = "eth_cu_1000_6";
 				};
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
index 463c2452b9b7..078d8699e16d 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
@@ -112,7 +112,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: ethernet-switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
@@ -123,11 +123,11 @@ switch0: switch0@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			ports {
+			ethernet-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
+				ethernet-port@0 {
 					reg = <0>;
 					phy-mode = "rmii";
 					ethernet = <&fec1>;
@@ -138,27 +138,27 @@ fixed-link {
 					};
 				};
 
-				port@1 {
+				ethernet-port@1 {
 					reg = <1>;
 					label = "eth_cu_100_3";
 				};
 
-				port@5 {
+				ethernet-port@5 {
 					reg = <5>;
 					label = "eth_cu_1000_4";
 				};
 
-				port@6 {
+				ethernet-port@6 {
 					reg = <6>;
 					label = "eth_cu_1000_5";
 				};
 
-				port@8 {
+				ethernet-port@8 {
 					reg = <8>;
 					label = "eth_cu_1000_1";
 				};
 
-				port@9 {
+				ethernet-port@9 {
 					reg = <9>;
 					label = "eth_cu_1000_2";
 					phy-handle = <&phy9>;
@@ -167,12 +167,12 @@ port@9 {
 				};
 			};
 
-			mdio1 {
+			mdio-external {
 				compatible = "marvell,mv88e6xxx-mdio-external";
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				phy9: phy9@0 {
+				phy9: ethernet-phy@0 {
 					compatible = "ethernet-phy-ieee802.3-c45";
 					pinctrl-0 = <&pinctrl_gpio_phy9>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
index f5ae0d5de315..22c8f44390a9 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts
@@ -137,7 +137,7 @@ mdio1: mdio {
 		suppress-preamble;
 		status = "okay";
 
-		switch0: switch0@0 {
+		switch0: ethernet-switch@0 {
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
@@ -148,11 +148,11 @@ switch0: switch0@0 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			ports {
+			ethernet-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
+				ethernet-port@0 {
 					reg = <0>;
 					phy-mode = "rmii";
 					ethernet = <&fec1>;
@@ -163,32 +163,32 @@ fixed-link {
 					};
 				};
 
-				port@1 {
+				ethernet-port@1 {
 					reg = <1>;
 					label = "eth_cu_1000_1";
 				};
 
-				port@2 {
+				ethernet-port@2 {
 					reg = <2>;
 					label = "eth_cu_1000_2";
 				};
 
-				port@3 {
+				ethernet-port@3 {
 					reg = <3>;
 					label = "eth_cu_1000_3";
 				};
 
-				port@4 {
+				ethernet-port@4 {
 					reg = <4>;
 					label = "eth_cu_1000_4";
 				};
 
-				port@5 {
+				ethernet-port@5 {
 					reg = <5>;
 					label = "eth_cu_1000_5";
 				};
 
-				port@6 {
+				ethernet-port@6 {
 					reg = <6>;
 					label = "eth_cu_1000_6";
 				};

-- 
2.34.1


