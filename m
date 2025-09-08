Return-Path: <netdev+bounces-220935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FFB497F7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63464440E80
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB4319840;
	Mon,  8 Sep 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ7y1IxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352B3191B4;
	Mon,  8 Sep 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355074; cv=none; b=SKYUUjABGfqncUGRrnchJpJ7Odh7Dbwu4mJpSPe3qHZfFj1UkwBkvpfAYP7LH/ZPZ91zNnABE0/Q6LewOyJXfb85yeGUpzU9cp7nM3z4Up3qY8xkJlFhDCnhuQTvf4FxjRzySX2AYb4hNQqc7m8P/yq+D3KKcCwMaFT2aIgJRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355074; c=relaxed/simple;
	bh=zJ4rq1A7rDmdHeQfB8ynFE9503F7ovKFxfivFN/5hPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTdBgKXtpS9zOVRtuaRBxVuqWwZRJaJXd5UQB4Blp86rWkwFQ/6LDcLNpgMt4QXjwkVqi/cyl/Z+Mg2TWkn5EFPiIhY669oDytsIxU14tMH/GXXPOAgF9WwTYITPLVjULfK67PoD/21g6CQ0zpvV6PSjOYy7wPiNztS4uRlT/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ7y1IxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5601C4CEFC;
	Mon,  8 Sep 2025 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355073;
	bh=zJ4rq1A7rDmdHeQfB8ynFE9503F7ovKFxfivFN/5hPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQ7y1IxUPVquvYgy5yUlyXqwhJc6iLQCwcSIFcqEjolAZNOyLB6+v3SRR2bxwaYTP
	 dn0GnEftM+3JCtzI28l+z6EtBy2t2V6M8qGgtDu2XsnUSIndOr5LBM5CrRiHyydBaa
	 TIg6n5G33v5pQ3tM7uVIf5GiGEXvIbGmX/+3Ece2SGgRMdinljCU6As5Kipc/H9xL7
	 1/dxb+RAntzX9qc8L12Z5ARFPiZvngI4B9DbAd6h+8DdXN7peM19tvbGyUens0F9KP
	 21lN9HzQQNf4b6c52XDkRRmKGzgGQpDPabLAx5UYqUM9TZJSga7yj07X5355fSPi98
	 x8R6mDUh6svYQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 68C9B5FFA1; Tue, 09 Sep 2025 02:11:09 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net-next v4 10/10] arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port
Date: Tue,  9 Sep 2025 02:10:59 +0800
Message-Id: <20250908181059.1785605-11-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908181059.1785605-1-wens@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On the Orangepi 4A board, the second Ethernet controller, aka the GMAC200,
is connected to an external Motorcomm YT8531 PHY. The PHY uses an external
25MHz crystal, has the SoC's PI15 pin connected to its reset pin, and
the PI16 pin for its interrupt pin.

Enable it.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
---
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index 38cd8c7e92da..7afd6e57fe86 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -15,6 +15,7 @@ / {
 	compatible = "xunlong,orangepi-4a", "allwinner,sun55i-t527";
 
 	aliases {
+		ethernet0 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -95,11 +96,33 @@ &ehci1 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_cldo4>;
+
+	tx-internal-delay-ps = <0>;
+	rx-internal-delay-ps = <300>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
+&mdio1 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		interrupts-extended = <&pio 8 16 IRQ_TYPE_LEVEL_LOW>; /* PI16 */
+		reset-gpios = <&pio 8 15 GPIO_ACTIVE_LOW>; /* PI15 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.39.5


