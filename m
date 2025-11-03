Return-Path: <netdev+bounces-234988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69AFC2AB6D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F301890372
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCB2E8B73;
	Mon,  3 Nov 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/R3kv25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FD1A8F84;
	Mon,  3 Nov 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161852; cv=none; b=PPoXiHdvx4QIxoUOyCXLJzO2H/2uCzHWhd/zIr4s8T/AiLogr9wdPf9jXmHRoIPF0pwOZYkhsZqJoR5ypHxp6aIaBFiDc0KMPLkma5fEI7PKoGpOgbVYeCTQshfMIclNh1GShKJZn+NIif+oc4xtiWWbn15RY7hPRAFhS6Pqx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161852; c=relaxed/simple;
	bh=Iv1UHyn9z0KTC/aKtkDuLNggMhiMp5MUe84RvmuDC0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sPQmBbsgXKatMNuUJqYHtJpRbp/KbhaUSkzzmU0ooIsbCwQ0m4iX1tPaeXG1kz+NtpIYUWk/ogRL6svWQCupR5J5qnj1E7bwuSfcuTZpXpbBoXbUmmz27+nFmgqATvHVE/DwfmjRecy8Xd3y7ZRaiCZ/QTfD0JP7J5MUIll8oU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/R3kv25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAA02C4CEE7;
	Mon,  3 Nov 2025 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762161851;
	bh=Iv1UHyn9z0KTC/aKtkDuLNggMhiMp5MUe84RvmuDC0M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=o/R3kv250XYLYXugeI4In64pFNyrF7xfhx1alIAwZKYuqJuodmKfxDfxq0S0jJTxM
	 yERTN7RNS23F1IMbZtxaPxvloo1v16VEhaqfBu00jQaDZHI94+NKTQPm2YnqMbcjTJ
	 xAOyK+eUSzpwUy/WYgcFVf+9H8NNuawkOovmj2KAfitWcQjLnKzxp/ENKEYpJiRjOa
	 zlN+nVUXhE88TGRTuuK8ii47D9iZNmvIf82S/SrkvPHyZ3RpXiDM24ENolctmbYO4q
	 hsfDhihtsm33vu6OFsVZEdyDCPt0wJWyuG1sA2ljfYwmn6Y6SfMRl6c0JUhJ1RcqIY
	 qBEvXik4NUD+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3DCCF9F8;
	Mon,  3 Nov 2025 09:24:11 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Mon, 03 Nov 2025 10:24:01 +0100
Subject: [PATCH v3] arm64: dts: freescale: Add GMAC Ethernet for S32G2 EVB
 and RDB2 and S32G3 RDB3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-nxp-s32g-boards-v3-1-b51db0b8b3ff@oss.nxp.com>
X-B4-Tracking: v=1; b=H4sIALB0CGkC/3XNzQ6CMAzA8VchO1uyFsbQk+9hPPCxwQ4yspoFQ
 3h3ByeN8fhv2l9XwSY4w+KSrSKY6Nj5KUVxykQ3NtNgwPWpBUlSKGUF0zIDFzRA65vQM1CPqiK
 lWnUmka7mYKxbDvF2Tz06fvrwOh5E3Kf/rYiAYLVslG5rWWt79cx52so7/xC7FulDKPBXoCRUh
 rC0VGpbmm9h27Y3bneKWfIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762161850; l=7554;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=DK5VZJZF7Vbw11r1n/9G6cmdxTjk1B3EYH+R4E80448=;
 b=HRZuPICxx85rF8EeeytZJbzyjVf6gz/jkQ+AKuRjPQDTKco/lraChauLmgRpffvJiWOG1PFa4
 OO8roWLfNtHCuldVfWk++48LPGD6oo19Ah6PrIuZcruvWUCaSXtdext
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
Changes in v3:
 - moved compatible to the head of mdio node
 - removed redundant cell size declaration
 - Link to v2: https://lore.kernel.org/r/20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com

Changes in v2:
 - fixed correct instance orders, include blank lines
 - Link to v1: https://lore.kernel.org/r/20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 58 ++++++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 18 +++++++-
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 16 +++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi        | 58 ++++++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 18 +++++++-
 5 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index d167624d1f0c..51d00dac12de 100644
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
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index c4a195dd67bf..aa40a52f8e53 100644
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
 
@@ -43,3 +44,18 @@ &usdhc0 {
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
+	/* KSZ 9031 on RGMII */
+	rgmiiaphy4: ethernet-phy@4 {
+		reg = <4>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index 4f58be68c818..ee3121b192e5 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "nxp,s32g274a-rdb2", "nxp,s32g2";
 
 	aliases {
+		ethernet0 = &gmac0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -77,3 +78,18 @@ &usdhc0 {
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
+	/* KSZ 9031 on RGMII */
+	rgmiiaphy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index be3a582ebc1b..eff7673e7f34 100644
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
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		swt8: watchdog@40500000 {
 			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
 			reg = <40500000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index e94f70ad82d9..326322b62192 100644
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
@@ -93,3 +94,18 @@ &usdhc0 {
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



