Return-Path: <netdev+bounces-178641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B502A78045
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C883AD358
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818572253E8;
	Tue,  1 Apr 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WrJMMAkM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB65214A80;
	Tue,  1 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524013; cv=none; b=lavQPDz0tNpF4hip2NOP3gX0X33I3o56GcMY3GxUjMn387UaqFLvtO4jTkvMRZN1D8piht9qOyuMlHkrxPQsOyD5qc1FZqL03zNot/I7TJhC9KBWPvwWPH3qKsIXfmz9TFb0o6YFJMXQSabD2QtfYoj/9dKrd2aEw7dySM/e4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524013; c=relaxed/simple;
	bh=yIQlV+xSWp6m0A0vkyE28xWvYegA9yXQmu6qD2GvGss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QifFcOZ6fHCuiBlX6WX4YtOB0XI10YkfrV6Z2gnXR3zEA79oBbqUIuj6WtSKUbQwzJQRBomnxrB6Axy8COMpy5tZQi7+Wn06zc8LnIrhvw6DmIv4lfqiZpm8SFNM0nRtHRP/vvMRWc4u0XRmSkdXdmXH8wq6/h94T70FLUjbrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WrJMMAkM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743524011; x=1775060011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIQlV+xSWp6m0A0vkyE28xWvYegA9yXQmu6qD2GvGss=;
  b=WrJMMAkMMj3BnRGSmbw4hQH2YpZckssG6N3Ln84ylN3HqiQILkvb8HCB
   BeaVagxgRYr/6g3rsC3vJmbettupWf/dYQTP9bX1R2ZqIypdxdblOaaiF
   5oF0W4v47dymgtt4ytRfiClEUQXrP3ABxfxXmdq/suu8bpOx5u1AjxLTz
   vn/VCiEH1PKO9FiO4wxrfV9q3VRngu+xe+gBHRI1fjNw0O21HI3CkbrNn
   I4NB/zTPBpHgnrjflvNNJXSDQkD1jSdjcY7d0JxSfW8fcoKC2PAB8Dcnc
   oFv+2ZQAp+E71KFBC/O7RY7OLc/E7Fo8gJ61qcQyFgmqlpPqLzZvzr7w0
   w==;
X-CSE-ConnectionGUID: ggLzNIpETriZ0zPViMY9HA==
X-CSE-MsgGUID: 2gYnf6TSRa2gsktm+Ip4hg==
X-IronPort-AV: E=Sophos;i="6.14,293,1736838000"; 
   d="scan'208";a="39512780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 09:13:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 09:13:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 09:13:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <onor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 4/6] ARM: dts: microchip: sama7d65: Enable GMAC interface
Date: Tue, 1 Apr 2025 09:13:20 -0700
Message-ID: <fca0c1deb74006cdedbdd71061dec9dabf1e9b9a.1743523114.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743523114.git.Ryan.Wanner@microchip.com>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Enable GMAC0 interface for sama7d65_curiosity board.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 30fdc4f55a3b..441370dbb4c2 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -105,7 +105,58 @@ &main_xtal {
 	clock-frequency = <24000000>;
 };
 
+&gmac0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gmac0_default
+		     &pinctrl_gmac0_mdio_default
+		     &pinctrl_gmac0_txck_default
+		     &pinctrl_gmac0_phy_irq>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	ethernet-phy@7 {
+		reg = <0x7>;
+		interrupt-parent = <&pioa>;
+		interrupts = <PIN_PC1 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
 &pioa {
+	pinctrl_gmac0_default: gmac0-default {
+		pinmux = <PIN_PA26__G0_TX0>,
+			 <PIN_PA27__G0_TX1>,
+			 <PIN_PB4__G0_TX2>,
+			 <PIN_PB5__G0_TX3>,
+			 <PIN_PA29__G0_RX0>,
+			 <PIN_PA30__G0_RX1>,
+			 <PIN_PB2__G0_RX2>,
+			 <PIN_PB6__G0_RX3>,
+			 <PIN_PA25__G0_TXCTL>,
+			 <PIN_PB3__G0_RXCK>,
+			 <PIN_PA28__G0_RXCTL>;
+		slew-rate = <0>;
+		bias-disable;
+	};
+
+	pinctrl_gmac0_mdio_default: gmac0-mdio-default {
+		pinmux = <PIN_PA31__G0_MDC>,
+			 <PIN_PB0__G0_MDIO>;
+		bias-disable;
+	};
+
+	pinctrl_gmac0_phy_irq: gmac0-phy-irq {
+		pinmux = <PIN_PC1__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_gmac0_txck_default: gmac0-txck-default {
+		pinmux = <PIN_PB1__G0_REFCK>;
+		slew-rate = <0>;
+		bias-pull-up;
+	};
+
 	pinctrl_i2c10_default: i2c10-default{
 		pinmux = <PIN_PB19__FLEXCOM10_IO1>,
 			 <PIN_PB20__FLEXCOM10_IO0>;
-- 
2.43.0


