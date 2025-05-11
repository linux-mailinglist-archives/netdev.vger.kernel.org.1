Return-Path: <netdev+bounces-189529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F77AB28F0
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF99175E5B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4302257441;
	Sun, 11 May 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="UkJ9gZ3T"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA82566F2;
	Sun, 11 May 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973201; cv=none; b=uqAtIbyOCtg/gkOsZJolTvDG6eFDmP13fogunjAklcy4NNmvmWMcIdzlrlmkF20RR8eAH6CccTrpIjThDpbdQqww/3vdUcqnn3oDljlDHcUohrhzkqioQ7Lj5v/wuftlTBVfKTGTn0m24HmKuwGGvLmgIgXkWem11Mz7shioM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973201; c=relaxed/simple;
	bh=mWdG/PFdxPaC45mDzD8ma9Dem8YK1Y7OW36uBZGdz+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjagTVLRumd9sUqnBNrclR/4lklfsLNk4CBjnUPQoLueuF+O8Pt8TtFUY9oCEK1qh6V86grKCQ8wkPPOIZlD1X1emwQWQAR7d7zI3ETlXr25ws55E2ru+1mrD/D3BYGN1lcHXJ8N61ctqSKUcjFLHBobBivaA2in9Qsj8VF9ErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=UkJ9gZ3T; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id B834D10001E;
	Sun, 11 May 2025 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1746973197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2n2o30Q/kVq/KYG6vVQ5aU24ZZC3guR83pv90r8Jms=;
	b=UkJ9gZ3TP4mpv73nR6bUQtH7yGllG6/eGkZpNCk35tuvz48EK/69cOkqd6hnAG94NrseXq
	UyfPyK2r5z0SjCtzXWY2KZis+aFtV8wyZ5f34jQS6CojsZLF3/mITkkpCMJTYe2onk9h33
	EBvRNMKhsXLdxdGChzIyNw2fp7FlMPk=
Received: from frank-u24.. (fttx-pool-194.15.84.99.bambit.de [194.15.84.99])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 9F11E100787;
	Sun, 11 May 2025 14:19:56 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 05/14] arm64: dts: mediatek: mt7988: move uart0 and spi1 pins to soc dtsi
Date: Sun, 11 May 2025 16:19:21 +0200
Message-ID: <20250511141942.10284-6-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141942.10284-1-linux@fw-web.de>
References: <20250511141942.10284-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 730e5bd4-362e-4c00-a35e-0ec77e8f4691

From: Frank Wunderlich <frank-w@public-files.de>

In order to use uart0 or spi1 there is only 1 possible pin definition
so move them to soc dtsi to reuse them in other boards and avoiding
conflict if defined twice.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 14 --------------
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi      | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 37e541a98ee1..23b267cd47ac 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -328,13 +328,6 @@ mux {
 		};
 	};
 
-	uart0_pins: uart0-pins {
-		mux {
-			function = "uart";
-			groups =  "uart0";
-		};
-	};
-
 	snfi_pins: snfi-pins {
 		mux {
 			function = "flash";
@@ -356,13 +349,6 @@ mux {
 		};
 	};
 
-	spi1_pins: spi1-pins {
-		mux {
-			function = "spi";
-			groups = "spi1";
-		};
-	};
-
 	spi2_pins: spi2-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 8c31935f4ab0..ab6fc09940b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -209,6 +209,20 @@ mux {
 						 "pcie_wake_n3_0";
 				};
 			};
+
+			spi1_pins: spi1-pins {
+				mux {
+					function = "spi";
+					groups = "spi1";
+				};
+			};
+
+			uart0_pins: uart0-pins {
+				mux {
+					function = "uart";
+					groups =  "uart0";
+				};
+			};
 		};
 
 		pwm: pwm@10048000 {
@@ -244,6 +258,8 @@ serial0: serial@11000000 {
 			clocks = <&topckgen CLK_TOP_UART_SEL>,
 				 <&infracfg CLK_INFRA_52M_UART0_CK>;
 			clock-names = "baud", "bus";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 			status = "disabled";
 		};
 
@@ -338,6 +354,8 @@ spi1: spi@11008000 {
 				      "hclk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
 			status = "disabled";
 		};
 
-- 
2.43.0


