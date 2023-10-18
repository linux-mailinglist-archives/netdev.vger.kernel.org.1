Return-Path: <netdev+bounces-42170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F97CD771
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDAC281DA7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DB179A5;
	Wed, 18 Oct 2023 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wem3ODTc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059321774E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:03:58 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D2FD
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a55302e0so4796214e87.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619833; x=1698224633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiZZKepT0k2abK/K1zJsQbV5nd3Ms209X8e5jPF01b4=;
        b=wem3ODTcAUKUxQ1CPCYN+rCKG33ZrE6uR67qA1RDoAX53DJEEImYQmtO02XOeKWDuY
         peCvpshN4iadxgpIhOmuglDovygabfcB+Pz1ZPCUvf3HzBTJL5ImtCDB6Pz4DV9V6jPI
         yZWzxZJQ5HqJvMuHPKBw8HfOCmtzvXmQoLEq7nbPi6AU9VVE+OKn398hRmucvJnvrQZv
         ZY97Xd9Qj/q0Y6XX0QDbYjm5hv/mv8JxDwYKCA/yEFOn9QtfFSvpxBvl2ezNOMqlCoqF
         REDlIA1df8lg1HO+JIVjM4uvYnAjGtJFeCYn2IvBzhrxROnf35hn5+8vs8mgBuB3uysI
         heGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619833; x=1698224633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiZZKepT0k2abK/K1zJsQbV5nd3Ms209X8e5jPF01b4=;
        b=ukLNB+b669hgi5D1NjjjZIO2REmg9NTZyaQ+UdRtree0pDHIKlIJuyz5aGHdFYEw7C
         kzI5tGI9LOrEx9x4MF9nSwxxOkUqwGwsOT7aVzNByUuOoeqqJ5dkj6o6Q7GW1RMVG2W/
         qVsyKeTanc93gvCJ1Q8n1a4H4CEPxnIsjhPVK6JFhPdAF5fEu8AAWvsvndM4IX2CzhjG
         lq28HeGdsYJ32em51gOViHlB7qBuEv1gO3WJrFcPuHzXR4qlTnmIpH7h7Sz872H3Ctcn
         e3yE/Ap9niPTY1bN3S+4WPZtQYodFSo7mRAE1cQSlf4WzikYcqc2GK0E2lryLs8/xpbk
         xShA==
X-Gm-Message-State: AOJu0YyoeQ9FAD1zcWFm7aeLmlDgqqFcnCvsvUrVkSO5yHLn4cxgSaQz
	M+P2JyMsPAeb52V/HMbW3GaZrNxay5M3OmBW2VE=
X-Google-Smtp-Source: AGHT+IFEm58O7jXHw5PZfYfibmbRgjIl6MChYWqx/YkQb9uhGQ7xj///ZhBu9KVcW8ODCZfkTN9ArA==
X-Received: by 2002:ac2:528b:0:b0:507:a8ed:ee0b with SMTP id q11-20020ac2528b000000b00507a8edee0bmr3034715lfm.65.1697619833514;
        Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b005056fb1d6fbsm616595lfr.238.2023.10.18.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Oct 2023 11:03:42 +0200
Subject: [PATCH net-next v4 3/7] ARM: dts: marvell: Fix some common switch
 mistakes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-marvell-88e6152-wan-led-v4-3-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be switch@0.
- The ports node should have port@0 etc children, no
  plural "ports".

This serves as an example of fixes needed for introducing a
schema for the bindings, but the patch can simply be applied.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/marvell/armada-370-rd.dts              |  2 --
 .../arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts |  2 --
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi        |  2 --
 arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts    | 16 +++++++---------
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts        |  2 --
 arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts    |  2 --
 8 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-rd.dts b/arch/arm/boot/dts/marvell/armada-370-rd.dts
index b459a670f615..e3a1834986ee 100644
--- a/arch/arm/boot/dts/marvell/armada-370-rd.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-rd.dts
@@ -151,8 +151,6 @@ led@0 {
 
 	switch: switch@10 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0x10>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
index f4c4b213ef4e..d4fff4ea9f20 100644
--- a/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
+++ b/arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts
@@ -79,14 +79,12 @@ &mdio {
 
 	switch@0 {
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		interrupt-parent = <&gpio1>;
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&switch_interrupt_pins>;
 		pinctrl-names = "default";
-		#size-cells = <0>;
 		reg = <0>;
 
 		mdio {
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index 1990f7d0cc79..1be0419f8f3e 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -7,7 +7,7 @@ / {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6190";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
index b795ad573891..6ec536222bfb 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts
@@ -11,7 +11,7 @@ &sfp0 {
 };
 
 &mdio {
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
index fc8216fd9f60..63a0bc9455ca 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys.dtsi
@@ -160,8 +160,6 @@ &mdio {
 
 	switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
 		ports {
diff --git a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
index 2d8d319bec83..8c69dbd6a2c7 100644
--- a/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
@@ -439,8 +439,6 @@ switch@10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&swint_pins>;
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		dsa,member = <0 0>;
 		reg = <0x10>;
@@ -452,32 +450,32 @@ ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			ports@0 {
+			port@0 {
 				reg = <0>;
 				label = "lan0";
 			};
 
-			ports@1 {
+			port@1 {
 				reg = <1>;
 				label = "lan1";
 			};
 
-			ports@2 {
+			port@2 {
 				reg = <2>;
 				label = "lan2";
 			};
 
-			ports@3 {
+			port@3 {
 				reg = <3>;
 				label = "lan3";
 			};
 
-			ports@4 {
+			port@4 {
 				reg = <4>;
 				label = "lan4";
 			};
 
-			ports@5 {
+			port@5 {
 				reg = <5>;
 				ethernet = <&eth1>;
 				phy-mode = "rgmii-id";
@@ -488,7 +486,7 @@ fixed-link {
 				};
 			};
 
-			ports@6 {
+			port@6 {
 				reg = <6>;
 				ethernet = <&eth0>;
 				phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 32c569df142f..ab46903580aa 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -94,8 +94,6 @@ &mdio {
 
 	switch@4 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <4>;
 		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index 7a0614fd0c93..2a5518c73bff 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -267,8 +267,6 @@ &mdio {
 
 	switch@0 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <0>;
 
 		ports {

-- 
2.34.1


