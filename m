Return-Path: <netdev+bounces-85464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305089ACD4
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542C81C2163B
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22D4EB36;
	Sat,  6 Apr 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BTD90+o1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7554F898
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434462; cv=none; b=OhufT7leDmAkomUZY59rjN6T/CPMPKCgFvamq8ZURKa9gQGZcSqwQhKoWRJZCkmtsGTDM255cKwBKuZ4imF+WYTm362wHCy6PXOCN9ANiRZHcEds0798FyrCrP5SQaiYIKlLnpcYv1KWFQBfxZpjHPDEV4enuLRnanxZALNIQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434462; c=relaxed/simple;
	bh=mWoe6XecMAQFp0MvO0h2Kv+BG0hzV24l7Cv7PCawBDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHFxaoaWntVnjku+vBGsHh7ZMhks84+Wgsq1znveCY3oMNoyf6/9Dtx78eFUeebUVBpxv+OhC0F9GFZYoI77LHDWWh1uqvwBvgDjdEwdjGaGfuLKzaQquqGqHrDzuM68mXnaQi4xlz88XTf4M16tXOEgYhLdE9J1E+RDQBbcE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BTD90+o1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+a3f0+ge0K0FerbA4ZdfzhGLOqls39mHI6MZCyekdvY=; b=BT
	D90+o1NAZ6pz3dS0ZWHxZng5TFwvQGiCbgaK9Qj3m1WkfDvE8//OTZySWkOgqv+hqOMWN4MkR+vcS
	RCfAxMUnfP71JDBoIQFpaZUdY+5jiAmz3hDNP3DMSIXTXhQZ/X70T0xaHkzvBdCj66ylymsy1aVoZ
	eG2hZJpd21WEj/U=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQc-00COA7-Bc; Sat, 06 Apr 2024 22:14:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:35 -0500
Subject: [PATCH net-next v4 8/8] arm: boot: dts: mvebu: linksys-mamba: Add
 Ethernet LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-8-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=mWoe6XecMAQFp0MvO0h2Kv+BG0hzV24l7Cv7PCawBDw=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa0BY7t1ylkc0ukcAP2Nd1fjQRCuPtUS4NgsH
 M2bNaI1mFqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtAQAKCRDmvw3LpmlM
 hGfMEACa/tKsEF4Ph0F7OuNfkHsqnko8VRE6TinKAeHWYIHJJVrkQmwKbi0q8kxgMsKuHGfKgFP
 A70Vk2roZ3HghftM/zf1qpbgDZD9bwSU8ml1o/1Y7BICFAzrwcGWY+oUcEgbbnJQ6ittSHE9M6n
 KU0d9/jj8Wca44mNpSA1J6+IPbp6ffDyBXkr+qewxqMCiY9QL37zxlpqwzh1NiNSOqLW3QFKNMO
 37uDbNxdo8xUW5vl9ziscciwB2y1Pi5CDkGu2vuViFe0ouHv2xx5QRLdTeI0+ACrj71tyZwaEEb
 7TLUnGLQna+8avGUqBJ2JiRtsD92Nmgu79CKLowoj97yZmzgu9nc4/Jmk0RMHEqCsO2sjf9wZm+
 8TLmbsvuMLid/rWsUuZr6LjkpGOQ05r3kjawzG4/hGTLCi9Bj8ggUdtFKfcomFhNk2pEaMHLp6N
 rygBeR+m/oFzv4PNwPYgdZWRzSn/sVaZ73T5aa/wSvS05Yem5IJ+Jqp5GfuqwOsm8m7/sxwqlrA
 jq3rVbE9dgHX4C32bS4/HGe/162H5h2Lu6JChCwX9tqvLVhyb0PBI/u5JPGRQNUqTnWq38cU/OG
 zpswf4zVu3TMgLV8BI5kqJaG0lQ307hjxTS93KljNVpISoB9BAHgM/X5ihbI3lOay8JBgBA2aef
 nrh2StcanesoFTQ==
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
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
index ea859f7ea042..34ea2338bf3c 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts
@@ -19,6 +19,7 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "armada-xp-mv78230.dtsi"
 
 / {
@@ -276,21 +277,73 @@ ethernet-ports {
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

-- 
2.43.0


