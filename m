Return-Path: <netdev+bounces-200058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C2AE2F1D
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174C11893A31
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1D1DE4E3;
	Sun, 22 Jun 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZshZTKZq"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AB1D61BB;
	Sun, 22 Jun 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585112; cv=none; b=Pd3Kvl74WO08rW2i+61juZrel4hAMp1Ooi2INzFv7m3b97YfQIWjVT6JTPNTVWEACAIqTml8GCUIYhWwK7vVFi1wkl+kF1qbru2JMepGy6UpMcXEUG+TiA+ij/PRsLl78QX7dSgCmcOibBO34CkDKXTPlwL175srS6Tv4PJ3wP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585112; c=relaxed/simple;
	bh=MpAyHTdrgYy/2jD2r0+265SPUZmnXwkeDfyaRbQtz/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAfi0JsT+yoZs8ylKMAnIYAlZ0MzUu6RIZ2Lkhelq6NI6yvDGiHRKOPhPbDvC7JcAeu6zgxvtDOniSfd9IzpU/z5nWfhAbJaLydNUVLQgG4qkGOg2SvmVwTbtMIAr90MTBXKxBPEO9zx8y/unyKplz93HN6OIKWzGlpIjem5vX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZshZTKZq; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B74E10240F7D;
	Sun, 22 Jun 2025 11:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750585108; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LtbI+3Xio7zK4FegeBMsmvxVcoAIwoUshRFHHKCfQ/M=;
	b=ZshZTKZqW0Ae89602ObOWhAOtd4VX48hTRnIlUkFG1u9hDSfSO/gw8gT0+f//6+wQh1nEl
	bbCg+c6bjgW7mL6l+3TAoXP6XhFY1ZCTQXrHFt1mGdNojADx6eQoMhvxmeFOB0hoXSMBw4
	nMBwys+VXjBOF89FPCuuG/5F8G5zO7pgtXqY8xBvtgG709lif2UXUbHJNWQriwlqIJr4pm
	2/9LPBO4jLFXduq6ZKLuIUkr80nWZlJyQML8J3HZF/Djn/9NfTzMMmfaaeEB6BNLcHMlUx
	eTrYYmdQSbs8uU4lywaHrbvFhVjGwUT961TigoO45MStt1/kwCM0Rfk1pQzGUA==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next v13 03/11] ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
Date: Sun, 22 Jun 2025 11:37:48 +0200
Message-Id: <20250622093756.2895000-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622093756.2895000-1-lukma@denx.de>
References: <20250622093756.2895000-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The description is similar to the one used with the new CPSW driver.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v2:
- Remove properties which are common for the imx28(7) SoC
- Use mdio properties to perform L2 switch reset (avoid using
  deprecated properties)

Changes for v3:
- Replace IRQ_TYPE_EDGE_FALLING with IRQ_TYPE_LEVEL_LOW
- Update comment regarding PHY interrupts s/AND/OR/g

Changes for v4:
- Use GPIO_ACTIVE_LOW instead of 0 in 'reset-gpios'
- Replace port@[12] with ethernet-port@[12]

Changes for v5:
- Add proper multiline comment for IRQs description

Changes for v6:
- None

Changes for v7:
- None

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- None

Changes for v13:
- None
---
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
index 6c5e6856648a..69032b29d767 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include<dt-bindings/interrupt-controller/irq.h>
 #include "imx28-lwe.dtsi"
 
 / {
@@ -90,6 +91,61 @@ &reg_usb_5v {
 	gpio = <&gpio0 2 0>;
 };
 
+&eth_switch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mtip_port1: ethernet-port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: ethernet-port@2 {
+			reg = <2>;
+			label = "lan1";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy1>;
+		};
+	};
+
+	mdio_sw: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <25000>;
+		reset-post-delay-us = <10000>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/*
+			 * Both PHYs (i.e. 0,1) have the same, single GPIO,
+			 * line to handle both, their interrupts (OR'ed)
+			 */
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			smsc,disable-energy-detect;
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
 &spi2_pins_a {
 	fsl,pinmux-ids = <
 		MX28_PAD_SSP2_SCK__SSP2_SCK
-- 
2.39.5


