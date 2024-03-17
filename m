Return-Path: <netdev+bounces-80281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE287E07E
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F89281EF8
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F820DE8;
	Sun, 17 Mar 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JnSPOK1+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC6224D4
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711966; cv=none; b=oIjHLfZ3BsKyb9xFE/2YH+4cmN7j3Ps4A2YGWvJ5z6koa1AD518LdlfTbi9XzFfx8urnairuzg/mxOIafYR8pkZiB04avAyu+/jrfnRZQVu5GXiXgHkVYIu+IByE0mo/4wEvgnl6G09NL1LrYVmghQHdjzlenGPuTGl5k37Yhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711966; c=relaxed/simple;
	bh=yTfli1M0AMfSR1gB5bI22VymrpH3etWUONf9w8DZc6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxAfw2opyB8NrGx8wSHUYiwXo+BoXRtKeProVyT98wrZcK9mLLsQpMvvZX5ealJQLfrJcVL7Q7Omow14+YL76+zOenatrbCQya6cRDaM2kHGEODn3OiNfdbWagqFR0w6slR73HUoZVA8B8J80CINTaorKOXoW8+yLaKeIrKxxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JnSPOK1+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=apIgSlhCAxiG55shOJ0+uD1MWRlLJtHsFq2q5r/ZI3g=; b=Jn
	SPOK1+l6VDr0xpuGsBXURZCfLhAbzkSOADf4x5nTSg51e3u/XbYCkXqC1FUVzLIW01WdNV143E0t1
	n0VddoAGv0xQoD7OS+lKODOdhLQwMRXJthWF0KiOlcZprlhSvt422slcmkdS+LQKOHaClwDWHlTS0
	Zchl8QdVDdgqP1w=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyKO-00AYv5-FT; Sun, 17 Mar 2024 22:46:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 Mar 2024 16:45:20 -0500
Subject: [PATCH RFC 7/7] arm: boot: dts: mvebu: linksys-mamba: Add Ethernet
 LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-7-80a4e6c6293e@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
In-Reply-To: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92SDcDQLplujHwflOaVAZjG+7IqwJilpLEYBg
 p25QLMAD82JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkgwAKCRDmvw3LpmlM
 hGQrEACweRpb/cdraWoia3VwRxbP39lEZ6/1m2YrXiFZx7ay+6Hu0s+5qH4o9ZJdp255Cv1oCIf
 B6c/nZ9J6ENy6JZ5yPCOxK/47H82ZVM9MzD7hbeaqPz9VGy+Qp+SLfOWd4Lh5UaeT9GDsKZt15y
 h19jLz9xZSJlC0m1FXFcdWHPTN2Ldu98j7XHdF2rDg80rZDBn1KE0D72zLDW1NmyuaGP8zvz7JM
 kqr8d01om8HPXc1/mEN0ttnh3vj3Bgf6s3wmmycwPnPU6iMDu9k31nrEQ/AaQp7mhz786eFKCW1
 mx1Vo2Vo6dhYdeXW33gW7B/HQ0WySqE+4ugWZooFcjB5vQruVbTl8IkVkk961y3xWJQnNnGZCy4
 HhJ624MY0zhOCX5QBJSlOcV/bAqlrdKsNzVeW/G8SxaDzkO+MC/wo55LSwdI7qdeRJaCFv8GdDS
 8Tl11izZOtpUeg32VUWBatfHKJCXDnnKb3XfgGkIGOYE7LW1mhWwZG6aeRClfhojuptdOxgJMt5
 3mo3YkbSyEo5xAxASpWtnczxXLzsveRGd3N0gnSVYWPHH374S0kd4iAPIAnCVAyQ1f9BSLD6pKe
 BLtJI5Sq/jQ2/8IepW+KQckpxb2JcqoNegKShEDGJhUyRF6tbIOTnRzD+VfFvA43BX+6ecF11yB
 +x2leCd9KE71TRg==
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


