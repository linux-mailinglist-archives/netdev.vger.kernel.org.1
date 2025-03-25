Return-Path: <netdev+bounces-177339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712AA6FA9F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AD6189C4D8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3A258CCA;
	Tue, 25 Mar 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DHfs+3dK"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78222580F4;
	Tue, 25 Mar 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903906; cv=none; b=oAtc9lbqxfGRODyIMe5PJ0aT896P2yd3T8x5sJoUfHeq7mu9rb3x1gpNickBKvYCsRCUqbejES6C2oqLSjei5Ot0tFhTIqNOo2AAM2Uan0BPaGav9NzxHmkLs5P9FmYthaCsmxSTXnMv6j94l3d1+s9k0wuRBn5AdswBt8/awvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903906; c=relaxed/simple;
	bh=oV8KMkqcTTwF2/O6EYV3GOphHvMdpOw8+FosPHGn5F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzngGdtQiRpio41LsmjESZMEchUDFZ0irQD94HsKuf5bakdYdB9691vNq+jJ2Zc38gNLFT04XbmU6bsXntOBwEKuMAj3a4JoWMB/EX3KeK5VgGgppyXG9bBfs0xVp7296oAAZuJNF9JEnhlJuMekBGyw0KQ639NfaMmgStSU+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DHfs+3dK; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5304C102E64C4;
	Tue, 25 Mar 2025 12:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742903902; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PvnjP1KZvNHykTcRfl9qD1j5GE4bTQS8Z3I6LLaUEwQ=;
	b=DHfs+3dK6bKFwwpkizkeqhOSPyaZyj6ZOLzH4VIMXX5CgnIA0WrlPzdOFVUdR9rJVbChC2
	HIJY0YLP/M+k+78/uaG43pZHPpcL8d6eGOZIfhiEazLKD2Nm7+7Ywj9zj42PEp9GDa6bMG
	j8CK35jWW+WqZk+SZhZwwYEGWBfhkSHC0Gd9gWSV3egr+AexVDoDtNtvkTnIpupcuDF32E
	firURP4b7LHre60bJtATXNAuUf3d1/UEq2TUn9MtFWqV5gTTiBWN+dl+/p9doq44PXe7uL
	OUlzEGWiRijHptWq0KjvkXbUlcj82oZhhKTq3wwAgPy4nHEOJVu2fULh6MwHfQ==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 4/5] arm: dts: imx287: Provide description for MTIP L2 switch
Date: Tue, 25 Mar 2025 12:57:35 +0100
Message-Id: <20250325115736.1732721-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325115736.1732721-1-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This description is similar to one supprted with the cpsw_new.c
driver.

It has separated ports and PHYs (connected to mdio bus).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
index 6c5e6856648a..e645b086574d 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include<dt-bindings/interrupt-controller/irq.h>
 #include "imx28-lwe.dtsi"
 
 / {
@@ -18,6 +19,61 @@ &can0 {
 	status = "okay";
 };
 
+&eth_switch {
+	compatible = "fsl,imx287-mtip-switch";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+	phy-supply = <&reg_fec_3v3>;
+	phy-reset-duration = <25>;
+	phy-reset-post-delay = <10>;
+	interrupts = <100>, <101>, <102>;
+	clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+	clock-names = "ipg", "ahb", "enet_out", "ptp";
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mtip_port1: port@1 {
+			reg = <1>;
+			label = "lan0";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy0>;
+		};
+
+		mtip_port2: port@2 {
+			reg = <2>;
+			label = "lan1";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-mode = "rmii";
+			phy-handle = <&ethphy1>;
+		};
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+			smsc,disable-energy-detect;
+			/* Both PHYs (i.e. 0,1) have the same, single GPIO, */
+			/* line to handle both, their interrupts (AND'ed) */
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			smsc,disable-energy-detect;
+			interrupt-parent = <&gpio4>;
+			interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_b>;
-- 
2.39.5


