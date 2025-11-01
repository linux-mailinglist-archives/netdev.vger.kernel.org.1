Return-Path: <netdev+bounces-234851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C6AC27FD8
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92154047DF
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CAA2FC896;
	Sat,  1 Nov 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lAE3KTjS"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C512FB0BC;
	Sat,  1 Nov 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003986; cv=none; b=XDEt2i2zOO634PgwH1FQWHxqUJJKixi2wGIDWtjU+fIixalmPrxz6BPk1viVAsFSFYbSxfdQMqRDcnNRzweo9Iu9io1nkg9YmjuIDj7pWEkaDmCagwLRaQIdmNhAiZK39I9lTsEzc6fwgWt5sI8uFlzL+yChSh3j/dq2RA4XP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003986; c=relaxed/simple;
	bh=ehoK8fZf94EyPJ6NwKMPoY3AbvxsvMfKSeRs4gLjd6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2iDdozKrxiuBvwtfKSM2ZnhVeRFUZ9UXE1xKqWTJqyC/ROBjR9Foyr30E3BbXT0Cf5DSlhAaovzW0QJ1cI2Q14tg6LNaapjdCyWT6lQ1yBqEFBE6Ee+ngLP653YbmiVTh77ZjKoRARkebDkK/K5tpR8iqg0QQbehsBzlFaZL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lAE3KTjS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=ehoK8fZf94EyPJ6NwKMPoY3AbvxsvMfKSeRs4gLjd6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lAE3KTjSfaomBP7o+9LEwq+KhmWbVGytQUHuaD7HoDbk3bDOBaICBvGt3xHS3Vuf7
	 cQ9yWHdjXDlDq5Noltbb9rbC1bJClo1xYjVsxMNGjAZxJvUOvWCw4KwrdarFe0N78L
	 KhTGHYTJ5HgjYEwaMtQCRrDKNKLB7eTaWKrkF9BNvAFwvID0HBVaAtQ1u/ehqdhfYp
	 FM0a/IrvMerFf5cyB5gYfjxTI5YdqmmFsiovAJaL/N4TO4bY4wV2VZM7Vo3Fp35Cwo
	 4Ej4Vqi7e2VsoYa/qx87Q5fW/T21eFWab70u2QwxpA/hWhyHy0pGciwsFT5v7xRdZM
	 3Qz0sATeHSf0g==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 78A7F17E142F;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id B5E0C10E9D03A; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:54 +0100
Subject: [PATCH v2 09/15] arm64: dts: mediatek: mt7981b: Add Ethernet and
 WiFi offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-9-2a162b9eea91@collabora.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

Add device tree nodes for the Ethernet subsystem on MT7981B SoC,
including:
- Ethernet MAC controller with dual GMAC support
- Wireless Ethernet Dispatch (WED)
- SGMII PHY controllers for high-speed Ethernet interfaces
- Reserved memory regions for WiFi offload processor

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Don't add unneeded interrupt-parent
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 133 +++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index fab22cbbece47..3510a26cb5112 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/clock/mediatek,mt7981-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 
@@ -47,11 +48,36 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		wo_boot: wo-boot@15194000 {
+			reg = <0 0x15194000 0 0x1000>;
+			no-map;
+		};
+
+		wo_ilm0: wo-ilm@151e0000 {
+			reg = <0 0x151e0000 0 0x8000>;
+			no-map;
+		};
+
+		wo_dlm0: wo-dlm@151e8000 {
+			reg = <0 0x151e8000 0 0x2000>;
+			no-map;
+		};
+
 		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
 		secmon_reserved: secmon@43000000 {
 			reg = <0 0x43000000 0 0x30000>;
 			no-map;
 		};
+
+		wo_emi0: wo-emi@47d80000 {
+			reg = <0 0x47d80000 0 0x40000>;
+			no-map;
+		};
+
+		wo_data: wo-data@47dc0000 {
+			reg = <0 0x47dc0000 0 0x240000>;
+			no-map;
+		};
 	};
 
 	soc {
@@ -107,6 +133,18 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
+		sgmiisys0: syscon@10060000 {
+			compatible = "mediatek,mt7981-sgmiisys_0", "syscon";
+			reg = <0 0x10060000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys1: syscon@10070000 {
+			compatible = "mediatek,mt7981-sgmiisys_1", "syscon";
+			reg = <0 0x10070000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
@@ -345,15 +383,108 @@ soc-uuid@140 {
 			thermal_calibration: thermal-calib@274 {
 				reg = <0x274 0xc>;
 			};
+
+			phy_calibration: phy-calib@8dc {
+				reg = <0x8dc 0x10>;
+			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7981-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
+		wed: wed@15010000 {
+			compatible = "mediatek,mt7981-wed",
+				     "syscon";
+			reg = <0 0x15010000 0 0x1000>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+			memory-region = <&wo_emi0>, <&wo_ilm0>, <&wo_dlm0>,
+					<&wo_data>, <&wo_boot>;
+			memory-region-names = "wo-emi", "wo-ilm", "wo-dlm",
+					      "wo-data", "wo-boot";
+			mediatek,wo-ccif = <&wo_ccif0>;
+		};
+
+		eth: ethernet@15100000 {
+			compatible = "mediatek,mt7981-eth";
+			reg = <0 0x15100000 0 0x40000>;
+			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+					  <&topckgen CLK_TOP_SGM_325M_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_NET2_800M>,
+						 <&topckgen CLK_TOP_CB_SGM_325M>;
+			clocks = <&ethsys CLK_ETH_FE_EN>,
+				 <&ethsys CLK_ETH_GP2_EN>,
+				 <&ethsys CLK_ETH_GP1_EN>,
+				 <&ethsys CLK_ETH_WOCPU0_EN>,
+				 <&topckgen CLK_TOP_SGM_REG>,
+				 <&sgmiisys0 CLK_SGM0_TX_EN>,
+				 <&sgmiisys0 CLK_SGM0_RX_EN>,
+				 <&sgmiisys0 CLK_SGM0_CK0_EN>,
+				 <&sgmiisys0 CLK_SGM0_CDR_CK0_EN>,
+				 <&sgmiisys1 CLK_SGM1_TX_EN>,
+				 <&sgmiisys1 CLK_SGM1_RX_EN>,
+				 <&sgmiisys1 CLK_SGM1_CK1_EN>,
+				 <&sgmiisys1 CLK_SGM1_CDR_CK1_EN>,
+				 <&topckgen CLK_TOP_NETSYS_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_500M_SEL>;
+			clock-names = "fe", "gp2", "gp1", "wocpu0",
+				      "sgmii_ck",
+				      "sgmii_tx250m", "sgmii_rx250m",
+				      "sgmii_cdr_ref", "sgmii_cdr_fb",
+				      "sgmii2_tx250m", "sgmii2_rx250m",
+				      "sgmii2_cdr_ref", "sgmii2_cdr_fb",
+				      "netsys0", "netsys1";
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fe0", "fe1", "fe2", "fe3", "pdma0",
+					  "pdma1", "pdma2", "pdma3";
+			sram = <&eth_sram>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,ethsys = <&ethsys>;
+			mediatek,sgmiisys = <&sgmiisys0>, <&sgmiisys1>;
+			mediatek,infracfg = <&topmisc>;
+			mediatek,wed = <&wed>;
+			status = "disabled";
+
+			mdio_bus: mdio-bus {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				int_gbe_phy: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+					phy-mode = "gmii";
+					phy-is-integrated;
+					nvmem-cells = <&phy_calibration>;
+					nvmem-cell-names = "phy-cal-data";
+				};
+			};
+		};
+
+		eth_sram: sram@15140000 {
+			compatible = "mmio-sram";
+			reg = <0 0x15140000 0 0x40000>;
+			ranges = <0 0x15140000 0 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		wo_ccif0: syscon@151a5000 {
+			compatible = "mediatek,mt7986-wo-ccif", "syscon";
+			reg = <0 0x151a5000 0 0x1000>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		wifi@18000000 {
 			compatible = "mediatek,mt7981-wmac";
 			reg = <0 0x18000000 0 0x1000000>,

-- 
2.51.0


