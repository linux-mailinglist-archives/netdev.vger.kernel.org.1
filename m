Return-Path: <netdev+bounces-83758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0E893B89
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E719C28229E
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252240870;
	Mon,  1 Apr 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K9szebRD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456A4085E
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978588; cv=none; b=EUA2UfOYErzAnK33z12tponyVPS4rdDUC3zoOb/fpcw59s2vofXaKfDVMLUF5f5rEdJarbANA/Y/WpqW3qHLKRDnbZuG1z7++gbVoRCGUQwqr+EnoYEduH7vPyGkrsP9Et8DZS6FznkEwj4OUBHogNoq1InxDarXA9S932XauoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978588; c=relaxed/simple;
	bh=T4hHSCqSyUP8uN3eUppXBTMJHEC7jNr+/N/npfR2Ba4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwzvSnyaH51ekAkgVnuCwVTtenA95ful2ieal+wQJ94zr79/Hqv/FL4fKRj7/ftyBffYnEwD1SR0Cz5uP/KjW5adyUWEBo2sZlPW8Q8w99VEJb40h77QHPqqmyeGlZditaymbY77yD/qmMSm7FX1aI/s9nFMQHUAoJaMKv8Dpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K9szebRD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3YRt0gr+yx7yiv5+KJ+D1BgjqflOQhh375/OUfItcZA=; b=K9
	szebRDVPARXusir2d9lpp/4EmgcYJ0NwjiNcM7XCd3RyJ+duqhtCdYtAN38/Hjvdvlb6371QeXK8j
	LPBs8cJf0SjH7DGH3idBt26Rf3Ye1QHhEHyN5nCQCkYCktTEmvdi1eH3KXWdpHXxMyZL6DfbJ57k8
	28mPwHPtJ13MSFE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpo-00BrFx-0z; Mon, 01 Apr 2024 15:36:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:52 -0500
Subject: [PATCH net-next v3 7/7] arm: boot: dts: mvebu: linksys-mamba: Add
 Ethernet LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-7-221b3fa55f78@lunn.ch>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=T4hHSCqSyUP8uN3eUppXBTMJHEC7jNr+/N/npfR2Ba4=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhCFqWZwVStP3xVRQLj3X3L+3pptgOf2vBmw
 cuWB49G5myJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QgAKCRDmvw3LpmlM
 hMeyD/0VlIf2O/pDJsF+4o5KWIZkKhsQCVlvyv2IyvdWB/EjupeMTSYYYEVz2O8b5anZ+qlK4mC
 M6OSksVG8NmHQHODa/E5tUyfkVlbASqMsw2CkBkRze/Jrs6m/ob2doF45DukQVDIehlX47dUcIU
 Y0Rp4bzEggHAvNcvuCLiXyDYMpjABzpzHOt5TaiyXcL2g+OX9BMG2BZeeZOr6InOkd9t+uz+cpC
 H6Gnn3S98o2ZGjY4lJkFHuu2P7wwoNHINAZkSlK6KPSoaI2xrAM31osF0NnMbMRBfWgvxR8rcwB
 7p1Btcy8qaHg3iNemae+z81dcseUgCkS/jldZy4gd0X6Q4SlDOT8ux2TQFCmvbwmTOC+3WOQTzK
 4jAaZF09l89MKzKH4EEyC59Ln/JlVT307xFW77KBnbJMclzG00Br4zACVHHc3WPpDL3aiMWx+9k
 RvsgYdO0CXNFsh6u9lRdh0IOK9y5/NRA/gJmHdpNBdTcSu+G+0EmX/+UJcshtjTR7Lig4YLw529
 MHKHLoxA4LqrZpt2j3BpyTDd9MFCgMIV3Qo4awB0f2b6yPIUJU3yr/bP1GAR0/rChIH4yy8yz/f
 18W8gN9RE1TStJMkswPfUVh4QGp/63H+ulwUNleIhiFRzjLWJ8OR2e5UeLIEhZiIc2IU7o9gq99
 pUtHEr/Mri7RtGw==
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
index ea859f7ea042..0784fd0355b2 100644
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
+						function = LED_FUNCTION_WAN;
+						label = "front";
+						default-state = "keep";
+					};
+				};
 			};
 
 			ethernet-port@5 {

-- 
2.43.0


