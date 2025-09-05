Return-Path: <netdev+bounces-220307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE8B455CA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50407A7E08
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311593431EC;
	Fri,  5 Sep 2025 11:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDB34166E;
	Fri,  5 Sep 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070646; cv=none; b=hxcgjtrK+r4GB3QnR0PJJIoKW3ejPKfIY3oMFTPsEfaSTkWTH0i5Hg5P9zCVfDqFlePwFPwgmhELpFSGURthkwtYJeFNr6w20ZVMAgLE9+6Ckw+4s67Hg7n88jO1CNUwXIXFhP3F3puAoeLCE9dgrs8b8YnymFTxUj6e0/RM6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070646; c=relaxed/simple;
	bh=JYwXZ2yQ2DNcBndTAT6ZFh53Jl3ZF9pzbFC7JU7r9Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGe9jlNMzjxywiZrsJppxWyKaboivpZ+a8cJBxXsj5UUBTOei4Rk3IykNvFlfsoJ2NbR78sUKSuXvnS40dibrF1E7MxfvukPAaeP/odCSHVUI9SrXDbwFEB7JVtS/kZAsRCZ+bY3YnQSRK7kul7a6UAi7Gp7megnrittbM8OrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowACnu4X1xLpoFdfLAA--.1807S5;
	Fri, 05 Sep 2025 19:09:44 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 05 Sep 2025 19:09:32 +0800
Subject: [PATCH net-next v9 3/5] riscv: dts: spacemit: Add Ethernet support
 for K1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-net-k1-emac-v9-3-f1649b98a19c@iscas.ac.cn>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
In-Reply-To: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowACnu4X1xLpoFdfLAA--.1807S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7AFy8Wry7XF48Kr18AFb_yoW5KF4Dpa
	yUAFs3Cr4xCw1rCwnavF9rWF4kGa1FkFyrGr9xGFWxGF4rtry7tFn0yry5Xw48Zws8ArW8
	Gr48XrWxKFnrtw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Add nodes for each of the two Ethernet MACs on K1 with generic
properties. Also add "gmac" pins to pinctrl config.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 48 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi         | 22 +++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 3810557374228100be7adab58cd785c72e6d4aed..aff19c86d5ff381881016eaa87fc4809da65b50e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -11,6 +11,54 @@
 #define K1_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
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
+
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
 			pinmux = <K1_PADCONF(68, 2)>,
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..7b2ac3637d6d9fa1929418cc68aa25c57850ac7f 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -805,6 +805,28 @@ network-bus {
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
 
 		pcie-bus {

-- 
2.50.1


