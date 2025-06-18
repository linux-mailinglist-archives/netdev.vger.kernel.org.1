Return-Path: <netdev+bounces-198879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D634CADE1CE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 05:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CC73BCAAF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247431DC9A3;
	Wed, 18 Jun 2025 03:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AA20101D;
	Wed, 18 Jun 2025 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750218123; cv=none; b=lHZxIVRoCINtLuXHvcdYdp1ifk8Y0+EvMpdYnGCjewrdqX4SLeDcQL1FeIGS6iEDOmKstNiwP8mwB0jqGQYIK/I9Jqoftd8u7Ay8GydyrdpKWp/mDxCaIXI89nv1aydgslUX+vSWzOFPUMotE45BIAq6PJnyIXS91AoVBMf0CGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750218123; c=relaxed/simple;
	bh=Z9hdqahs2Rbblv01YhByI69TeKnDwVGAeUoJCjCuv90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaxXW54DIQtWfFAhD95tXin/lA0zeQZf+s/O5Fer39KtA2ayNhdfg+CdGbB1UpL0hWqmWZNqnz8QBWWZAm7+9chK71y1zMRWFdDGJQq+fac07TDLD+ytaU6tZtSmadP3ey9TJiGUwf6Wang7z/8LoyB4hjXERWLRlvzX9SLj35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABnFtVpNVJoV95NBw--.6548S6;
	Wed, 18 Jun 2025 11:41:31 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 18 Jun 2025 11:40:49 +0800
Subject: [PATCH net-next v2 4/6] riscv: dts: spacemit: Add Ethernet support
 for K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-net-k1-emac-v2-4-94f5f07227a8@iscas.ac.cn>
References: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
In-Reply-To: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABnFtVpNVJoV95NBw--.6548S6
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7tw43KF47XFW7GFWrAFb_yoW5tF47pa
	yUAFs3Cr4xCw1rCwnayF9rWFs5Ga1FkFyrGr9rGFWxGF4rtry7tFn0yry3Xw48Zws8A3y8
	Gr48XrWxKFnrtw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
	6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRrsqJUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Add nodes for each of the two Ethernet MACs on K1 with generic
properties. Also add "gmac" pins to pinctrl config.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 48 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi         | 22 +++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 283663647a86ff137917ced8bfe79a129c86342a..4a7fbb40858dc1e7d2a55d4bb8547d5472ec4fc3 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -20,4 +20,52 @@ uart0-2-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	gmac0_cfg: gmac0-cfg {
+		gmac0-pins {
+			pinmux = <K1_PADCONF(0, 1)>,	/* gmac0_rxdv */
+				 <K1_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
+				 <K1_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
+				 <K1_PADCONF(3, 1)>,	/* gmac0_rx_clk */
+				 <K1_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
+				 <K1_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
+				 <K1_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
+				 <K1_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
+				 <K1_PADCONF(8, 1)>,	/* gmac0_tx */
+				 <K1_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
+				 <K1_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
+				 <K1_PADCONF(11, 1)>,	/* gmac0_tx_en */
+				 <K1_PADCONF(12, 1)>,	/* gmac0_mdc */
+				 <K1_PADCONF(13, 1)>,	/* gmac0_mdio */
+				 <K1_PADCONF(14, 1)>,	/* gmac0_int_n */
+				 <K1_PADCONF(45, 1)>;	/* gmac0_clk_ref */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
+	gmac1_cfg: gmac1-cfg {
+		gmac1-pins {
+			pinmux = <K1_PADCONF(29, 1)>,	/* gmac1_rxdv */
+				 <K1_PADCONF(30, 1)>,	/* gmac1_rx_d0 */
+				 <K1_PADCONF(31, 1)>,	/* gmac1_rx_d1 */
+				 <K1_PADCONF(32, 1)>,	/* gmac1_rx_clk */
+				 <K1_PADCONF(33, 1)>,	/* gmac1_rx_d2 */
+				 <K1_PADCONF(34, 1)>,	/* gmac1_rx_d3 */
+				 <K1_PADCONF(35, 1)>,	/* gmac1_tx_d0 */
+				 <K1_PADCONF(36, 1)>,	/* gmac1_tx_d1 */
+				 <K1_PADCONF(37, 1)>,	/* gmac1_tx */
+				 <K1_PADCONF(38, 1)>,	/* gmac1_tx_d2 */
+				 <K1_PADCONF(39, 1)>,	/* gmac1_tx_d3 */
+				 <K1_PADCONF(40, 1)>,	/* gmac1_tx_en */
+				 <K1_PADCONF(41, 1)>,	/* gmac1_mdc */
+				 <K1_PADCONF(42, 1)>,	/* gmac1_mdio */
+				 <K1_PADCONF(43, 1)>,	/* gmac1_int_n */
+				 <K1_PADCONF(46, 1)>;	/* gmac1_clk_ref */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index b1b87ce1ab70faa8fb61fb27bc1845fe40b35561..819d3bf18a103c083f17ad494fb3470c9eebd8bc 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -588,6 +588,28 @@ network-bus {
 			#size-cells = <2>;
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x0 0x80000000 0x1 0x00000000 0x0 0x80000000>;
+
+			eth0: ethernet@cac80000 {
+				compatible = "spacemit,k1-emac";
+				reg = <0x0 0xcac80000 0x0 0x420>;
+				clocks = <&syscon_apmu CLK_EMAC0_BUS>;
+				interrupts = <131>;
+				mac-address = [ 00 00 00 00 00 00 ];
+				resets = <&syscon_apmu RESET_EMAC0>;
+				spacemit,apmu = <&syscon_apmu 0x3e4>;
+				status = "disabled";
+			};
+
+			eth1: ethernet@cac81000 {
+				compatible = "spacemit,k1-emac";
+				reg = <0x0 0xcac81000 0x0 0x420>;
+				clocks = <&syscon_apmu CLK_EMAC1_BUS>;
+				interrupts = <133>;
+				mac-address = [ 00 00 00 00 00 00 ];
+				resets = <&syscon_apmu RESET_EMAC1>;
+				spacemit,apmu = <&syscon_apmu 0x3ec>;
+				status = "disabled";
+			};
 		};
 	};
 };

-- 
2.49.0


