Return-Path: <netdev+bounces-41040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED27C965B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997D6B20BA6
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CAB266DF;
	Sat, 14 Oct 2023 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toOR32us"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1D25104
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 20:51:43 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD62E3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a62d4788so739972e87.0
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316699; x=1697921499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhgTFSg7xZQFKqQUdPj7mdXINHwkkUMiMJQ/LwbGzwg=;
        b=toOR32usVFgC3K5bD0wz39xZPKdtLnIUH/AAam7OSM/Bppg+L9mZZn9QfFtKofQkgN
         qTn3Xl+kIJ1gHrNwMq+yNR0dHlw3GriQBa7fGEgCUrZn/x5i+GZBSvKjV2nEwSH2urX6
         dZAFj9NWrMFoo/uyN4DWQ9f4x5vX3Dh+one8tJCYMy3Xe+T64pswb1p7f0K785io8mHu
         LmOmM++n0a2QTv9UHPnMdZGo1YGVtmBBZhYqbdLG2YQz9KU2QJ/ftbu4qjt64+wjxo4M
         vzKgE1aEKXX17ExmBYfK2pigD28qahtmliS9QNJD9Zm3jSSe+Isvwv9hXR3fFZO5DV4/
         z3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316699; x=1697921499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhgTFSg7xZQFKqQUdPj7mdXINHwkkUMiMJQ/LwbGzwg=;
        b=ZChGksBie5mIPqKM5WEXl/4yfeYQuIhsY2niWGneweox3sgZGAFQGHAciSXGWoeJ/N
         qFZ71PCZHDLap2zcbaTPwJtWuaM2HwHj/1cyhc7XHImlH0MyYrjPnRk+0qjNy5Xgl6pf
         N2cGcnsQ6aFZgn876LvQsYPEe7V478TuucKcMf4dBEElZOF9z3Wqz9Z4AVHrwppD9k3M
         NrzL2yQtw2UFplra9dP0QA767OZkvPYgfShWe7v1Rw8IWen4FSg332LPA2SHhRIMDnLH
         4g3c6WKl3LBaeWT3dYsV/4rWLO1JgzJ/5w/qt06Alm3WV/DWzMyZiLArOvMsqBEHA3MT
         0RGQ==
X-Gm-Message-State: AOJu0Yz2xHDF1uZGkJ7SGGgdy9tC/eSY01lJIZIfS43Wx1o0gYtA4h/p
	g8SNfwg6GH6wiIFuf0AZ+wOA+w==
X-Google-Smtp-Source: AGHT+IEma29vzsOEeaj3rANcQHH/FRA4IGToApFC9dzK/t1Uswcy9seJrul25z/pKhuvPvfeBMu/sA==
X-Received: by 2002:a05:6512:b9f:b0:507:a12a:7753 with SMTP id b31-20020a0565120b9f00b00507a12a7753mr2584708lfv.22.1697316699386;
        Sat, 14 Oct 2023 13:51:39 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 14 Oct 2023 22:51:34 +0200
Subject: [PATCH net-next v2 3/5] ARM: dts: marvell: Fix some common switch
 mistakes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231014-marvell-88e6152-wan-led-v2-3-7fca08b68849@linaro.org>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix some errors in the Marvell MV88E6xxx switch descriptions:
- The top node had no address size or cells.
- switch0@0 is not OK, should be switch@0.
- port@a is not normal port naming, use decimal port@10.
- The ports node should have port@0 etc children, no
  plural "ports".

This serves as an example of fixes needed for introducing a
schema for the bindings, but the patch can simply be applied.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/marvell/armada-370-rd.dts              |  2 --
 .../arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts |  6 ++----
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts |  2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi        |  2 --
 arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts    | 16 +++++++---------
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts        |  2 --
 arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts    |  2 --
 8 files changed, 11 insertions(+), 23 deletions(-)

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
index f4c4b213ef4e..cf37f53ec070 100644
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
@@ -214,12 +212,12 @@ port@9 {
 				reg = <9>;
 			};
 
-			port@a {
+			port@10 {
 				/* 88X3310P external phy */
 				label = "lan10";
 				phy-handle = <&phy2>;
 				phy-mode = "xaui";
-				reg = <0xa>;
+				reg = <10>;
 			};
 		};
 	};
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


