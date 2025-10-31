Return-Path: <netdev+bounces-234662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E5C257E7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B12F54F80AD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C834C13C;
	Fri, 31 Oct 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZNuayPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44534C135;
	Fri, 31 Oct 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919610; cv=none; b=IRMFRij6jPLfsusZcEG5+O5rYakoUeu1H6XT/LKsEnjUGxH8LyLcvGnZ9JzNfBtcZtMDk3Y9DZvUqQA52rE8H4L0Gflo+AOwHmnRAgftuBul0rN8PgjlzTdxRlR9J50mjqKWr8lX30+j9v9J2b/ROs9mdN4BrzFZWGkt7WooRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919610; c=relaxed/simple;
	bh=Srakam9afkBWsyM8ZSqlUr6TdJbYj/XFwaqGL0k1kLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QtzGkoDrMs3R3VYDr7C5yDRKXlF39PhjGVojnSmROD9Amj5txFl8pSrNCNvNyYlNEvfImy39zDMcl5hUc+Il+DyYGLTNZwa4OzTjWyxWF6M6/DQjXgxAXnR4A97RR35B7K2Q6ItA4oeiPtk1oJIcC8bY/5AVPFgMLz0Clnn8cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZNuayPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9B22C4CEE7;
	Fri, 31 Oct 2025 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919609;
	bh=Srakam9afkBWsyM8ZSqlUr6TdJbYj/XFwaqGL0k1kLw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aZNuayPNNc3EUH2c4rxIClMgiiTUolg1OYi9q04y0LqzfLAeR1qGj1dICWgLdLOQf
	 xmLZZ7QY5F+YzY+HIWV/DMpjsRFJlQx+zYgzkrmZG7qJY0bMm+Rtd48a6LVgX2jrLZ
	 ToDJoB7/SixlOHIQeJnQA2ifVvL7CoY++UVLSFX3frO5rgW78EFlYzD0C+OiU3NxJk
	 /FinbcCfQF+MVFmnz99vbo9S5/Kz/g6bUQ1j9L+q4YCbpVQ6j9qifzgjC/C1eqkvYZ
	 dG/6MncngVE5MZe9qPzJ3u4v+2Qz5upK8fLNm09EWR/6+ktJ0Cm+Y3RhHyFSRd3C9+
	 pPXrw/7Q/G2Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C993ACCF9FE;
	Fri, 31 Oct 2025 14:06:49 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Fri, 31 Oct 2025 15:06:17 +0100
Subject: [PATCH v2] arm64: dts: freescale: Add GMAC Ethernet for S32G2 EVB
 and RDB2 and S32G3 RDB3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com>
X-B4-Tracking: v=1; b=H4sIAFjCBGkC/3WNwQ6DIBBEf8XsuWtgG8T21P9oPKCAcigYtjE2h
 n8v9d7jm8y8OYBdDo7h3hyQ3RY4pFiBLg1Mi4mzw2ArAwlSUogO474iX2nGMZlsGclK1ZFSo7o
 R1NWanQ/7aXwOlZfA75Q/58Emf+l/1yZRotfCKD32otf+kZjb2mqn9IKhlPIFhRSidrAAAAA=
To: Chester Lin <chester62515@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Enric Balletbo i Serra <eballetb@redhat.com>, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761919608; l=7502;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=Su3BAxA6SBNR4XfbrIKIFNt01TOwYKZFUS6VmQVlP1U=;
 b=i3rydhtY1bWZ9jK1kaeVX90I4TK0PoPRydjO74xv6L9E+8tKUzx7wXKuU/AmDteIv2jnv0hC9
 ip0irIpy+MWCB5GbjNgoRGyXDJ4jXenMIIQ6EYfvwIfB37Aps4SUTOi
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add support for the Ethernet connection over GMAC controller connected to
the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.

The mentioned GMAC controller is one of two network controllers
embedded on the NXP Automotive SoCs S32G2 and S32G3.

The supported boards:
 * EVB:  S32G-VNP-EVB with S32G2 SoC
 * RDB2: S32G-VNP-RDB2
 * RDB3: S32G-VNP-RDB3

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
Changes in v2:
 - fixed correct instance orders, include blank lines
 - Link to v1: https://lore.kernel.org/r/20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 58 ++++++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 21 ++++++++-
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 19 ++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi        | 58 ++++++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 21 ++++++++-
 5 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index d167624d1f0c..6f0a307fbab1 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -3,7 +3,7 @@
  * NXP S32G2 SoC family
  *
  * Copyright (c) 2021 SUSE LLC
- * Copyright 2017-2021, 2024 NXP
+ * Copyright 2017-2021, 2024-2025 NXP
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -727,6 +727,62 @@ usdhc0: mmc@402f0000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@4033c000 {
+			compatible = "nxp,s32g2-dwmac";
+			reg = <0x4033c000 0x2000>, /* gmac IP */
+			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			status = "disabled";
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <5>;
+
+				queue0 {
+				};
+
+				queue1 {
+				};
+
+				queue2 {
+				};
+
+				queue3 {
+				};
+
+				queue4 {
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <5>;
+
+				queue0 {
+				};
+
+				queue1 {
+				};
+
+				queue2 {
+				};
+
+				queue3 {
+				};
+
+				queue4 {
+				};
+			};
+
+			gmac0mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index c4a195dd67bf..fb4002a2aa67 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (c) 2021 SUSE LLC
- * Copyright 2019-2021, 2024 NXP
+ * Copyright 2019-2021, 2024-2025 NXP
  */
 
 /dts-v1/;
@@ -14,6 +14,7 @@ / {
 	compatible = "nxp,s32g274a-evb", "nxp,s32g2";
 
 	aliases {
+		ethernet0 = &gmac0;
 		serial0 = &uart0;
 	};
 
@@ -43,3 +44,21 @@ &usdhc0 {
 	no-1-8-v;
 	status = "okay";
 };
+
+&gmac0 {
+	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
+	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmiiaphy4>;
+	status = "okay";
+};
+
+&gmac0mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* KSZ 9031 on RGMII */
+	rgmiiaphy4: ethernet-phy@4 {
+		reg = <4>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index 4f58be68c818..b632b0ffd6a8 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "nxp,s32g274a-rdb2", "nxp,s32g2";
 
 	aliases {
+		ethernet0 = &gmac0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -77,3 +78,21 @@ &usdhc0 {
 	no-1-8-v;
 	status = "okay";
 };
+
+&gmac0 {
+	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
+	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmiiaphy1>;
+	status = "okay";
+};
+
+&gmac0mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* KSZ 9031 on RGMII */
+	rgmiiaphy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index be3a582ebc1b..ccb761137273 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2024 NXP
+ * Copyright 2021-2025 NXP
  *
  * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
  *          Ciprian Costea <ciprianmarian.costea@nxp.com>
@@ -804,6 +804,62 @@ usdhc0: mmc@402f0000 {
 			status = "disabled";
 		};
 
+		gmac0: ethernet@4033c000 {
+			compatible = "nxp,s32g2-dwmac";
+			reg = <0x4033c000 0x2000>, /* gmac IP */
+			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			status = "disabled";
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <5>;
+
+				queue0 {
+				};
+
+				queue1 {
+				};
+
+				queue2 {
+				};
+
+				queue3 {
+				};
+
+				queue4 {
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <5>;
+
+				queue0 {
+				};
+
+				queue1 {
+				};
+
+				queue2 {
+				};
+
+				queue3 {
+				};
+
+				queue4 {
+				};
+			};
+
+			gmac0mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
+
 		swt8: watchdog@40500000 {
 			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
 			reg = <40500000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index e94f70ad82d9..d7213d2872a4 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2024 NXP
+ * Copyright 2021-2025 NXP
  *
  * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
  */
@@ -15,6 +15,7 @@ / {
 	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";
 
 	aliases {
+		ethernet0 = &gmac0;
 		mmc0 = &usdhc0;
 		serial0 = &uart0;
 		serial1 = &uart1;
@@ -93,3 +94,21 @@ &usdhc0 {
 	disable-wp;
 	status = "okay";
 };
+
+&gmac0 {
+	clocks = <&clks 24>, <&clks 19>, <&clks 18>, <&clks 15>;
+	clock-names = "stmmaceth", "tx", "rx", "ptp_ref";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmiiaphy1>;
+	status = "okay";
+};
+
+&gmac0mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* KSZ 9031 on RGMII */
+	rgmiiaphy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251006-nxp-s32g-boards-2d156255b592

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



