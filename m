Return-Path: <netdev+bounces-210394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A28B13111
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E2C16F3BE
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2B1865FA;
	Sun, 27 Jul 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HgXkUUb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E39610D
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639417; cv=none; b=BZ9HgCDvczu2LUVvlijUeWJgRt6LzqMMAw2LpFfFAiXkiedSJyj1WIWOYJerc8q2wJmVVlrjNegkZ6MB1DLWwdZyQ6znKtk2o8n4HnUy7T3A0YE4xg92DDEtH6UKR3GH1DXwGxnsApwOKaDInotqeRdvYpofWeXYsKFgIYm7kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639417; c=relaxed/simple;
	bh=WIxZnDfBjy3+MWbIUs96xiEYfrzW7OIdSfiwwszp1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NORpYhmSVQiUh10F17mQ3w0xpPy6CCHxhAXLf9HMM5h49RGUY56BRSjQFVHOqKsOAzqTB3qsV9FSxfjmU0rscdf0dxVMrsjSptkPHrkmW+WW7dNo0nVCuGJenmkJ6fqLvJk1JHQZ6zFITJ56OhgHTGpc4iNMXW0Hx9saS/N6qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HgXkUUb4; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753639414; bh=EeTBhSz8vgF+IOB9tNLiutH2dTp1nA31ocl9xEGhTRc=;
 b=HgXkUUb4+0a+LWZa9Flb7opsQbnNHvA3LrY0DAOMIQgE/VbrOwip0azPItGlJvZcpUUdikF0M
 gpPanPlf4G3snXvVVu5O/tS+Sp1Mqkt9C6dBtRyWpSW55RU9aBqwYiLxh0Or+XCA8PG4WnxQsLi
 CTCmc3Bc9llTO61M/z2BiPdk1scxXPKvvhW3Figj0CKUVdypLhZwgCZW+3ZeQmsj4LqtdiLpcwt
 bf9TaA4K4Qs8dJHWrWHCGAgYYmJ4F5nTmy3vbfVX3mWZTZCnhfd2Uf5nU23D2LtiVCi0/jE1d0g
 P+8dH/2sktrHKri/aBtY1JXOy2Eok9hpAV2UnFw4835A==
X-Forward-Email-ID: 688669eec509b9ee169cf33b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to Radxa E24C
Date: Sun, 27 Jul 2025 18:03:00 +0000
Message-ID: <20250727180305.381483-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727180305.381483-1-jonas@kwiboo.se>
References: <20250727180305.381483-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
and is connected using a fixed-link to GMAC1 on the RK3528 SoC.

Add an ethernet-switch node to describe the RTL8367RB-VB switch.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
and only around ~1-2 Mbits/sec in the other direction.

The RK3528 hardware design guide recommends that timing between TXCLK
and data is controlled by MAC, and timing between RXCLK and data is
controlled by PHY.

Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
seem to resolve this speed issue, however dropping snps,tso seems to fix
that issue.

Unsure what is best here, should MAC or switch add the delays? Here I
just followed DT from vendor downstream tree and added rx/tx internal
delay to switch.

Vendor downstream DT also adds 'pause' to the fixed-link nodes, and this
may be something that should be added here. However, during testing flow
control always ended up being disabled so I skipped 'pause' here.

Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schematic.pdf
---
 .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
index 225f2b0c5339..26754ff7f4ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
@@ -196,6 +196,7 @@ &cpu3 {
 };
 
 &gmac1 {
+	/delete-property/ snps,tso;
 	clock_in_out = "output";
 	phy-mode = "rgmii-id";
 	phy-supply = <&avdd_rtl8367rb>;
@@ -368,6 +369,60 @@ &mdio1 {
 	reset-delay-us = <25000>;
 	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
 	reset-post-delay-us = <100000>;
+
+	ethernet-switch@1d {
+		compatible = "realtek,rtl8365mb";
+		reg = <0x1d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8367rb_eint>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "wan";
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan1";
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan2";
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan3";
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				ethernet = <&gmac1>;
+				label = "cpu";
+				phy-mode = "rgmii-id";
+				rx-internal-delay-ps = <2000>;
+				tx-internal-delay-ps = <2000>;
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		interrupt-controller {
+			interrupt-parent = <&gpio1>;
+			interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
 };
 
 &pinctrl {
-- 
2.50.1


