Return-Path: <netdev+bounces-41041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746B47C965D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DE0B20C86
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E406266BA;
	Sat, 14 Oct 2023 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgcT2xmz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DF2374F
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 20:51:46 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D050D6
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50305abe5f0so4216530e87.2
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316701; x=1697921501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1L3K+Ebs1IkB2w2DJrMtsRdnXrx4C52cUF/HzYsLH8=;
        b=hgcT2xmzTa2ohiYfPvBgzJfM95hZwp9YcR0f64odrMk4/FOXw6mQrQl4/PszvgTLjl
         v1XB43QvH5psCS/tdEPbAkiZVM0MFjwnbynU+fnufV5GlvpSA45369Wiu9MQBgE5PimC
         2QQkjrdm0ozN6KLNzGRHL1A4OVJSmx7v2ND8vQ4kgP27IN9Mfn9+aNYOW+2jfnS0Naxm
         IUaA7ioovaTRxSEJHECdaLNHhkh8tZaORZDWqDyAb2PTZnJgSL/pZV14UcY6LUJ052xo
         8DoqRJ2CWGZoKFBkSSsk5M5ieVxQ0l1MjWJGKWQt/b356VmbNROqstobR5Ztww2LZZfE
         Hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316701; x=1697921501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1L3K+Ebs1IkB2w2DJrMtsRdnXrx4C52cUF/HzYsLH8=;
        b=Df6/1vm4k1vF1dQUuAJjstrCQZTykYqHBvjaanDsWA6QGRJa0QKk9ng5Kh91Lu5OD2
         7F2lfX06Y5zR7tMhQZujNEFNFHta338ML3AP+U9AIi6WRLemKmLduP09INdNynkctFwZ
         tbY49XEQd0UIut6p0dB1v0KERuiz/U2Llo3gEVuKGQEUL8X3SUlvm/oMqymN0sXh9P/e
         7kzcCI4ZUGPtua7vNfpZdZuzI/g307e2q3LeuLcFMfBKzIMOp4Yf83fgoeF6EXd2iz9S
         C0QYrA6NPNd/Qzj7Z8ZiZLkh7pmo1ZLwfwEiXgBk+srWxPSEmzaAJ15/ChAjVJ1hKLJn
         Nf3g==
X-Gm-Message-State: AOJu0YwiJT2Ub3aAy+r1sJtu+pjgJzgtFkMhQLTqcFpVtPJxRLNFL5XJ
	uUhW23EdmOiC8/OGQVmMVPxOpg==
X-Google-Smtp-Source: AGHT+IHtQpWgOHFYKb5Kidy8nqsBhBLPrhhxehpUXmo1r7QzUOnSNYAcKW4qHHgvbKZzfo+tqHM7mg==
X-Received: by 2002:a05:6512:b01:b0:503:19d9:4b6f with SMTP id w1-20020a0565120b0100b0050319d94b6fmr29910390lfu.0.1697316701548;
        Sat, 14 Oct 2023 13:51:41 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:41 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 14 Oct 2023 22:51:36 +0200
Subject: [PATCH net-next v2 5/5] ARM64: dts: marvell: Fix some common
 switch mistakes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231014-marvell-88e6152-wan-led-v2-5-7fca08b68849@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |  4 +--
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |  4 +--
 .../boot/dts/marvell/armada-3720-turris-mox.dts    | 32 +++++++++++-----------
 .../boot/dts/marvell/armada-7040-mochabin.dts      |  2 --
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |  6 ++--
 6 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..b526efeee293 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -145,10 +145,8 @@ &usb2 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
index b1b45b4fa9d4..5de4417f929c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
@@ -152,10 +152,8 @@ &uart0 {
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 9eab2bb22134..ea66ba5a9762 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -305,7 +305,7 @@ phy1: ethernet-phy@1 {
 	};
 
 	/* switch nodes are enabled by U-Boot if modules are present */
-	switch0@10 {
+	switch@10 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x10>;
 		dsa,member = <0 0>;
@@ -410,8 +410,8 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			switch0port10: port@a {
-				reg = <0xa>;
+			switch0port10: port@10 {
+				reg = <10>;
 				label = "dsa";
 				phy-mode = "2500base-x";
 				managed = "in-band-status";
@@ -419,8 +419,8 @@ switch0port10: port@a {
 				status = "disabled";
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -430,7 +430,7 @@ port-sfp@a {
 		};
 	};
 
-	switch0@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 0>;
@@ -497,7 +497,7 @@ port@5 {
 		};
 	};
 
-	switch1@11 {
+	switch@11 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x11>;
 		dsa,member = <0 1>;
@@ -602,8 +602,8 @@ switch1port9: port@9 {
 				link = <&switch0port10>;
 			};
 
-			switch1port10: port@a {
-				reg = <0xa>;
+			switch1port10: port@10 {
+				reg = <10>;
 				label = "dsa";
 				phy-mode = "2500base-x";
 				managed = "in-band-status";
@@ -611,8 +611,8 @@ switch1port10: port@a {
 				status = "disabled";
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -622,7 +622,7 @@ port-sfp@a {
 		};
 	};
 
-	switch1@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 1>;
@@ -689,7 +689,7 @@ port@5 {
 		};
 	};
 
-	switch2@12 {
+	switch@12 {
 		compatible = "marvell,mv88e6190";
 		reg = <0x12>;
 		dsa,member = <0 2>;
@@ -794,8 +794,8 @@ switch2port9: port@9 {
 				link = <&switch1port10 &switch0port10>;
 			};
 
-			port-sfp@a {
-				reg = <0xa>;
+			port-sfp@10 {
+				reg = <10>;
 				label = "sfp";
 				sfp = <&sfp>;
 				phy-mode = "sgmii";
@@ -805,7 +805,7 @@ port-sfp@a {
 		};
 	};
 
-	switch2@2 {
+	switch@2 {
 		compatible = "marvell,mv88e6085";
 		reg = <0x2>;
 		dsa,member = <0 2>;
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 48202810bf78..3cc794fcf12e 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -303,8 +303,6 @@ eth2phy: ethernet-phy@1 {
 	/* 88E6141 Topaz switch */
 	switch: switch@3 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <3>;
 
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 4125202028c8..7a25ea36b565 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -497,7 +497,7 @@ ge_phy: ethernet-phy@0 {
 		reset-deassert-us = <10000>;
 	};
 
-	switch0: switch0@4 {
+	switch0: switch@4 {
 		compatible = "marvell,mv88e6085";
 		reg = <4>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 32cfb3e2efc3..2f6281b66467 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -207,11 +207,9 @@ phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 
-	switch6: switch0@6 {
+	switch6: switch@6 {
 		/* Actual device is MV88E6393X */
 		compatible = "marvell,mv88e6190";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <6>;
 		interrupt-parent = <&cp0_gpio1>;
 		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
@@ -280,7 +278,7 @@ port@9 {
 				managed = "in-band-status";
 			};
 
-			port@a {
+			port@10 {
 				reg = <10>;
 				ethernet = <&cp0_eth0>;
 				phy-mode = "10gbase-r";

-- 
2.34.1


