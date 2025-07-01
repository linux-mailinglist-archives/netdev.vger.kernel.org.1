Return-Path: <netdev+bounces-203007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3577CAF0117
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30423B6B20
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D7283689;
	Tue,  1 Jul 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZbqGJ1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15073283130;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389091; cv=none; b=hSuqQk2www7v1NWStG/5lpwVn6CcDLB5/pWCw7g/+lSlZezVCQDy99ZofYSddE+TPazirjL8moV7k0tGprcXwnMfq2QIA8RRww3QcgoRWTpEIbRPo3LYJ1C+KMku6J3JSzNHh7iFW2SCK8c027JLzo/WVLyusahYMBJOrOUbAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389091; c=relaxed/simple;
	bh=dAv9swBTXYpTgm3Qv9LPGFYo4DAoeOgGawWIkj4FOhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxZTslpHTklWvU0GiYn58OQ2NDSu/XZqiHz2je9qgs/EbwHiVTVp1Xj3ibJODUKydei8QeIj+KHul86CcEzPBXg6yvkJw5O4BUKbuaRajHRD5CXPxCllGCLkEFUNT9/ClY1d+vYV1dTT9q00c9edEPZJcNt3epG70gbzBsZL4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZbqGJ1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56D4C4AF09;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389090;
	bh=dAv9swBTXYpTgm3Qv9LPGFYo4DAoeOgGawWIkj4FOhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZbqGJ1mEesj+ZV6HEbQsK0OPAOaoCE53MwQR0juTCpT3NyAnFKm7mlThMpt2g9tN
	 Eh+PE7/z8C5gUHmpMMO5B+O3sDjus0WqmXHwOu+pie5gaFSl0wZ3A+W5H/Jp+fkCzE
	 R9kc/A0eD2nzxgaIYjrwzxLxd0G/Q1N1mhvKbCG8KDc04rLtMQxtbIYBZ+ZUafnRyb
	 XyzQ/FAVMFXn+GbBWwDB0G1C7yzbdaAlXEentmiAsyLUX2LlfHscO7XWB6PcAuFfYr
	 jpULkLxHLUVv+XozwqNoP4+tmkTF7JsIxTy8y/XctzbO2FOHycZnwYBGIao6+/Z4ta
	 hkTO4/mIWk4gw==
Received: by wens.tw (Postfix, from userid 1000)
	id 0C7125FFF8; Wed,  2 Jul 2025 00:58:06 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH RFT net-next 07/10] arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
Date: Wed,  2 Jul 2025 00:57:53 +0800
Message-Id: <20250701165756.258356-8-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On the Radxa Cubie A5E board, the second Ethernet controller, aka the
GMAC200, is connected to a second external Maxio MAE0621A PHY. The PHY
uses an external 25MHz crystal, and has the SoC's PJ16 pin connected to
its reset pin.

Enable the second Ethernet port. Also fix up the label for the existing
external PHY connected to the first Ethernet port.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index c57ecc420aed..4b510a460123 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -57,7 +58,7 @@ &ehci1 {
 
 &gmac0 {
 	phy-mode = "rgmii-id";
-	phy-handle = <&ext_rgmii_phy>;
+	phy-handle = <&ext_rgmii0_phy>;
 	phy-supply = <&reg_cldo3>;
 
 	allwinner,tx-delay-ps = <300>;
@@ -66,8 +67,19 @@ &gmac0 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii1_phy>;
+	phy-supply = <&reg_cldo4>;
+
+	allwinner,tx-delay-ps = <300>;
+	allwinner,rx-delay-ps = <400>;
+
+	status = "okay";
+};
+
 &mdio0 {
-	ext_rgmii_phy: ethernet-phy@1 {
+	ext_rgmii0_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
@@ -76,6 +88,16 @@ ext_rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&mdio1 {
+	ext_rgmii1_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		reset-gpios = <&pio 9 16 GPIO_ACTIVE_LOW>; /* PJ16 */
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


