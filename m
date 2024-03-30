Return-Path: <netdev+bounces-83528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42B892C8E
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FABB21E08
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D8219E9;
	Sat, 30 Mar 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u0a5oyrX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326A2207A
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823567; cv=none; b=pffrqdm0iopLhJOjYYnC29Nm8WfADRW7mNVzF8rsu3v1EQOLw8wLpDAhCVEnphNtwg24vjb0qQK0Vbe124uZNwnCOu6TH8WZVIELKgICjVF01/ptyJeLEDOFlHrG/Q6EV/EhcdQzmd25rFDEeaXx1wiPeXZvn+WdY5QJH+r4F6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823567; c=relaxed/simple;
	bh=yTfli1M0AMfSR1gB5bI22VymrpH3etWUONf9w8DZc6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leg6bXtlqksHmoaWM4mcdZCuL1Ecq6+YvKqapTeLWJwV1kpKiebthn+iGhbYJCYyity28iuuIOLiNEydzQUmzK/W6Tfqc4c1tWNYyFHWig1+S+DM2pRpvtwzsAay1ZUwAEw8kLSiEahrzdZO17sQhddw8ESNxTvTyyJ/fk5Qy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u0a5oyrX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=apIgSlhCAxiG55shOJ0+uD1MWRlLJtHsFq2q5r/ZI3g=; b=u0
	a5oyrX44SexLNY0Ar2fP8IMp+ib5iNV8Z3QoY3YwKFWl7FH9mrXi4i44voYoLZIR4ZJrqr2aTfAps
	Hh7S6tDLn9lBgWN1ayVpXQEPeQiCVvECXe+zsQC4P15yCH/xhWmG897LWHV42vkVMbRC9XHVkdQhs
	60FQ38mN84D6WPE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVT-00Bjfq-7X; Sat, 30 Mar 2024 19:32:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Mar 2024 13:32:04 -0500
Subject: [PATCH net-next v2 7/7] arm: boot: dts: mvebu: linksys-mamba: Add
 Ethernet LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-7-fc5beb9febc5@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=yTfli1M0AMfSR1gB5bI22VymrpH3etWUONf9w8DZc6o=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq3/dFaLVv/SCHBZNEJgg5upTs9XPPNfDP2y
 x6VoncTAyaJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatwAKCRDmvw3LpmlM
 hCVpD/wMNQVYs6I5IesGY9SxuYHoCA9/MrD1YwOnkwVdfrBoJ6TFOyq9qV/XHq5cabtlmieDKlD
 nkiFLVh8/K/gz9WE6wibd7jhZzpWqgkolqX5GLVp7FllWW2yfsqHMkp5UVCx9PJCf+PZNtEXw+a
 z6AvuoKZO7cJUGnBO2lU5LfyOnD/4DhVQSWjsFqhwfwYmS2Ox72yD8YzGbUdut2wJIvz7W8+24j
 w85FH13iVGFVLnId5YkGApu7dFnNg177pXWNB9j69y6HTqeWQMV6HxmBxpw2qBMiuhIiCGAXtSW
 BHOaFv/AgirhR0h8cadazC/7Qm2se5Y8VnacXSFWgX1k+wpOfT9vf2yKV8YvmLHUkIQ81pwGtIG
 7HKMFaVxwV8IlW9t8eFHBvkL3M2Jq9dgO5PBH/a3mvpcmH3pNOeJaV/OKfOwKwu2U8ySciEopcq
 yeDvXFYkHEIsYLMn6lwYCsu1MBLxxm7Vpr6Rc4T/pJMhehVojTWbpdqcdcg/C2UjDq0jATpWOTd
 dzBtRRnQbom4uOJ0lamQIy0wZBikNbSFKkAAR3oP4XUd5rG7QL7pVu4KNdXnFYd+1hPip9Do+Yl
 /sUEJCWI4Kg5zryPtfgqCBHrz27IFfyLnBV/JpWSP4SllWbDkdMyjd9AJxJCviC+thJuqyY6Gx6
 UVjnHjM3/RcwunA==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

List the front panel Ethernet LEDs in the switch section of the
device tree. They can then be controlled via /sys/class/led/

The node contains a label property to influence the name of the LED.
Without it, all the LEDs get the name lan:white, which classes, and so
some get a number appended. lan:white_1, lan:white_2, etc. Using the
label the LEDs are named lan1:front, lan2:front, lan3:front, where
lanX indicates the interface name, and front indicates they are on the
front of the box.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index ea859f7ea042..90d5a47a608e 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -19,6 +19,7 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "armada-xp-mv78230.dtsi"
 
 / {
@@ -276,26 +277,91 @@ ethernet-ports {
 			ethernet-port@0 {
 				reg = <0>;
 				label = "lan4";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@1 {
 				reg = <1>;
 				label = "lan3";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@2 {
 				reg = <2>;
 				label = "lan2";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@4 {
 				reg = <4>;
 				label = "internet";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_WHITE>;
+						function = LED_FUNCTION_LAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@5 {

-- 
2.43.0


