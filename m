Return-Path: <netdev+bounces-179105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68463A7A95F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A381896804
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9422517B5;
	Thu,  3 Apr 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8UEX75y"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406131F5825
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704952; cv=none; b=QaU90A4pdeCqyMxXS98aI/TrIRxGL87lFkZwaoUx7nKNzVBm8slNQkkq07gEAkcswxG6en7sM5kdbdkDTD2eX8G6VTUgdxSw+pUhEw6A7IiLvndNR110KtH+gXlTJkb2gtpRdtPj9VqkxtP9pPezsvCqZdMHzaD4P4l8AhDFkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704952; c=relaxed/simple;
	bh=HN+XU8zxOY9v+u7xi1yyfNDtRZMv+NsuI/w5Pm9w0+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMYdkeiCCrUKrTawv38uUasef9bCCOUrP0X+xcIZ72Eoqka8KoSG3sofbVHLhnIJQSGnJ4lY+J4s+ejpcsIVK4N7+t5FDnT6or1B3J4vdeloaeSOBE5WBTLGk/59fsUp0lBuyPWBJ58TEJJhiuczpUKJP+kzFAzv6mGA6YHkMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8UEX75y; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXdo8X1aVFus8jE/gRSOm5/KUGBwL/O5S+xQKTEpQaY=;
	b=B8UEX75yftNaMWqMjuzVMQ8ZtlkozjWueZndzzk4X6TgFgpCsRRqZqctcf0qXjOp7XPKGP
	KH49HUHtCsx1vc6XrFCr02LYJNg/I3gULLOMAsI5HKMquOONmuBp/fNLMisW1XfnwuXBey
	ZGlpAJQqWZqGlawBSrmO0BGHpBY0+Ic=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC net-next PATCH 12/13] arm64: dts: Add compatible strings for Lynx PCSs
Date: Thu,  3 Apr 2025 14:28:55 -0400
Message-Id: <20250403182855.1948615-1-sean.anderson@linux.dev>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds appropriate compatible strings for Lynx PCSs on arm64 QorIQ
platforms. This also changes the node name to avoid warnings from
ethernet-phy.yaml.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 48 +++++++++++------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 54 ++++++++++++-------
 .../dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  3 +-
 .../dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  3 +-
 .../dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  3 +-
 10 files changed, 84 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 9421fdd7e30e..90c1631c958e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -554,7 +554,8 @@ pcs_mdio1: mdio@8c07000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs1: ethernet-phy@0 {
+			pcs1: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -567,7 +568,8 @@ pcs_mdio2: mdio@8c0b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs2: ethernet-phy@0 {
+			pcs2: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -580,7 +582,8 @@ pcs_mdio3: mdio@8c0f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs3: ethernet-phy@0 {
+			pcs3: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -593,7 +596,8 @@ pcs_mdio4: mdio@8c13000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs4: ethernet-phy@0 {
+			pcs4: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -606,7 +610,8 @@ pcs_mdio5: mdio@8c17000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs5: ethernet-phy@0 {
+			pcs5: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -619,7 +624,8 @@ pcs_mdio6: mdio@8c1b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs6: ethernet-phy@0 {
+			pcs6: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -632,7 +638,8 @@ pcs_mdio7: mdio@8c1f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs7: ethernet-phy@0 {
+			pcs7: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -645,7 +652,8 @@ pcs_mdio8: mdio@8c23000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs8: ethernet-phy@0 {
+			pcs8: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -658,7 +666,8 @@ pcs_mdio9: mdio@8c27000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs9: ethernet-phy@0 {
+			pcs9: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -671,7 +680,8 @@ pcs_mdio10: mdio@8c2b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs10: ethernet-phy@0 {
+			pcs10: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -684,7 +694,8 @@ pcs_mdio11: mdio@8c2f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs11: ethernet-phy@0 {
+			pcs11: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -697,7 +708,8 @@ pcs_mdio12: mdio@8c33000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs12: ethernet-phy@0 {
+			pcs12: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -710,7 +722,8 @@ pcs_mdio13: mdio@8c37000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs13: ethernet-phy@0 {
+			pcs13: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -723,7 +736,8 @@ pcs_mdio14: mdio@8c3b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs14: ethernet-phy@0 {
+			pcs14: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -736,7 +750,8 @@ pcs_mdio15: mdio@8c3f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs15: ethernet-phy@0 {
+			pcs15: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -749,7 +764,8 @@ pcs_mdio16: mdio@8c43000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs16: ethernet-phy@0 {
+			pcs16: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8..f35da67b6e61 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1474,7 +1474,8 @@ pcs_mdio1: mdio@8c07000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs1: ethernet-phy@0 {
+			pcs1: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1487,7 +1488,8 @@ pcs_mdio2: mdio@8c0b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs2: ethernet-phy@0 {
+			pcs2: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1500,7 +1502,8 @@ pcs_mdio3: mdio@8c0f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs3: ethernet-phy@0 {
+			pcs3: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1513,7 +1516,8 @@ pcs_mdio4: mdio@8c13000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs4: ethernet-phy@0 {
+			pcs4: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1526,7 +1530,8 @@ pcs_mdio5: mdio@8c17000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs5: ethernet-phy@0 {
+			pcs5: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1539,7 +1544,8 @@ pcs_mdio6: mdio@8c1b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs6: ethernet-phy@0 {
+			pcs6: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1552,7 +1558,8 @@ pcs_mdio7: mdio@8c1f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs7: ethernet-phy@0 {
+			pcs7: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1565,7 +1572,8 @@ pcs_mdio8: mdio@8c23000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs8: ethernet-phy@0 {
+			pcs8: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1578,7 +1586,8 @@ pcs_mdio9: mdio@8c27000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs9: ethernet-phy@0 {
+			pcs9: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1591,7 +1600,8 @@ pcs_mdio10: mdio@8c2b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs10: ethernet-phy@0 {
+			pcs10: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1604,7 +1614,8 @@ pcs_mdio11: mdio@8c2f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs11: ethernet-phy@0 {
+			pcs11: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1617,7 +1628,8 @@ pcs_mdio12: mdio@8c33000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs12: ethernet-phy@0 {
+			pcs12: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1630,7 +1642,8 @@ pcs_mdio13: mdio@8c37000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs13: ethernet-phy@0 {
+			pcs13: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1643,7 +1656,8 @@ pcs_mdio14: mdio@8c3b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs14: ethernet-phy@0 {
+			pcs14: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1656,7 +1670,8 @@ pcs_mdio15: mdio@8c3f000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs15: ethernet-phy@0 {
+			pcs15: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1669,7 +1684,8 @@ pcs_mdio16: mdio@8c43000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs16: ethernet-phy@0 {
+			pcs16: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1682,7 +1698,8 @@ pcs_mdio17: mdio@8c47000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs17: ethernet-phy@0 {
+			pcs17: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
@@ -1695,7 +1712,8 @@ pcs_mdio18: mdio@8c4b000 {
 			#size-cells = <0>;
 			status = "disabled";
 
-			pcs18: ethernet-phy@0 {
+			pcs18: ethernet-pcs@0 {
+				compatible = "fsl,lynx-pcs";
 				reg = <0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index 1b2b20c6126d..e11c6ddab457 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -36,7 +36,8 @@ mdio@f1000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf1000 0x1000>;
 
-		pcsphy6: ethernet-phy@0 {
+		pcsphy6: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 55d78f6f7c6c..c8b7f2c61a8f 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -36,7 +36,8 @@ mdio@f3000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf3000 0x1000>;
 
-		pcsphy7: ethernet-phy@0 {
+		pcsphy7: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 18916a860c2e..1a4bcb38646e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -35,7 +35,8 @@ mdio@e1000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe1000 0x1000>;
 
-		pcsphy0: ethernet-phy@0 {
+		pcsphy0: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index e90af445a293..6a4d55f9d045 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -35,7 +35,8 @@ mdio@e3000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe3000 0x1000>;
 
-		pcsphy1: ethernet-phy@0 {
+		pcsphy1: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index fec93905bc81..0de30065aa3b 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -35,7 +35,8 @@ mdio@e5000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe5000 0x1000>;
 
-		pcsphy2: ethernet-phy@0 {
+		pcsphy2: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 2aa953faa62b..2f8064b1039f 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -35,7 +35,8 @@ mdio@e7000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe7000 0x1000>;
 
-		pcsphy3: ethernet-phy@0 {
+		pcsphy3: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index 948e39411415..6246f1fdac2d 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -35,7 +35,8 @@ mdio@e9000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe9000 0x1000>;
 
-		pcsphy4: ethernet-phy@0 {
+		pcsphy4: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
index 01b78c0463a7..c205e1e8bfc8 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
@@ -34,7 +34,8 @@ mdio@eb000 {
 		compatible = "fsl,fman-memac-mdio";
 		reg = <0xeb000 0x1000>;
 
-		pcsphy5: ethernet-phy@0 {
+		pcsphy5: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
-- 
2.35.1.1320.gc452695387.dirty


