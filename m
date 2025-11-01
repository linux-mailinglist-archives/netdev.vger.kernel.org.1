Return-Path: <netdev+bounces-234853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC4C27FBB
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 473B934A2CC
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFE2FD674;
	Sat,  1 Nov 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l0fhBZXx"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522C2FB610;
	Sat,  1 Nov 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003986; cv=none; b=ULQQZblhWD8EcDQrzveLwbOdvvc+inNTbZGbpvmSh9Pc2jQN06gqL27PcBMRTEH1TvdzsqpV5gtcUan5rVegyk1clM8ksuwmd4dMqUC8fZJhOe9ZOz8eZ80CbKtFY7vph1+5yr1HvnRPwQ+YdBbD7VJIWOCmAs58LWJqVOL5rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003986; c=relaxed/simple;
	bh=YUkMxhc36lfDFQq88M5/ukQps2eWc5BNpPfONN/wkTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJK7wjoA8S3k6/p13LA72yPqr2KDtIn7mRJTjcQGmKz/voopbTzrWG1L5/qOMiit1lAO/1buev8LMXHWCyKjNmvmFECeJAU3xgjUcKkU4FBmnz4rkBrrqlF6xAuRXOejaaQ+mmKK/cjefIL0d8AGTjhRdtY7H1KI7uBZat24O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l0fhBZXx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=YUkMxhc36lfDFQq88M5/ukQps2eWc5BNpPfONN/wkTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l0fhBZXxbT5HKIykr8Fk3qKkjo31VGI8L72JfSpzHqeBi4RmwcTYVZ9qT9eqT9vKP
	 47Z9ZTZAc4WQmdlmrnm5SbrNzjB4I+sOuKf7K4Dj1YvnHre3lZ3ccBIXLsY7dR8/LP
	 Xr1xI6M3e97yGGrfAsaM1s7CZPl26mWFOB986EZC0mOnw/KPeUpjnFZETvpcWZMjZv
	 vTZWfzE68I0GYM+3S8thQFOikv5EDEJjoO99dXaaast1sl41rRdfW1lTo8ZjIdVtKh
	 /cf59dS3alql+eEWEePZgCuSbm73WBffOmaWq/uSx/dKtYxOZQwQ1xXvHXgUtRVKq3
	 icKuL/Tg8ynUQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C2DB17E1423;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id BBBAB10E9D03C; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:55 +0100
Subject: [PATCH v2 10/15] arm64: dts: mediatek: mt7981b-openwrt-one: Enable
 SPI NOR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-10-2a162b9eea91@collabora.com>
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

The openwrt one has a SPI NOR flash which from factory is used for:
* Recovery system
* WiFi eeprom data
* ethernet Mac addresses

Describe this following the same partitions as the openwrt configuration
uses.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2:
  - Use numeric drive-strength values rather then defines
  - Make nvmem cell labers more meaningfull
  - Only define nvmem cells used in later patches by devicetree
---
 .../boot/dts/mediatek/mt7981b-openwrt-one.dts      | 77 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  2 +-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
index 5834273839c17..183e48d985ed7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include "mt7981b.dtsi"
+#include "dt-bindings/pinctrl/mt65xx.h"
 
 / {
 	compatible = "openwrt,one", "mediatek,mt7981b";
@@ -53,6 +54,82 @@ mux {
 			groups = "pcie_pereset";
 		};
 	};
+
+	spi2_flash_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2";
+		};
+
+		conf-pu {
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <8>;
+			pins = "SPI2_CS", "SPI2_WP";
+		};
+
+		conf-pd {
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+			drive-strength = <8>;
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+		};
+	};
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x00000 0x40000>;
+				label = "bl2-nor";
+			};
+
+			partition@40000 {
+				reg = <0x40000 0xc0000>;
+				label = "factory";
+				read-only;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					wifi_factory_calibration: eeprom@0 {
+						reg = <0x0 0x1000>;
+					};
+
+					wan_factory_mac: macaddr@24 {
+						reg = <0x24 0x6>;
+						compatible = "mac-base";
+						#nvmem-cell-cells = <1>;
+					};
+				};
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x80000>;
+				label = "fip-nor";
+			};
+
+			partition@180000 {
+				reg = <0x180000 0xc80000>;
+				label = "recovery";
+			};
+		};
+	};
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 3510a26cb5112..2c9819f28fdc2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -195,7 +195,7 @@ i2c@11007000 {
 			status = "disabled";
 		};
 
-		spi@11009000 {
+		spi2: spi@11009000 {
 			compatible = "mediatek,mt7981-spi-ipm", "mediatek,spi-ipm";
 			reg = <0 0x11009000 0 0x1000>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.51.0


