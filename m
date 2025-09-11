Return-Path: <netdev+bounces-222238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D4B53A80
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338281BC7A16
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F635FC3C;
	Thu, 11 Sep 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3OAc8qp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A413EFE3;
	Thu, 11 Sep 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612436; cv=none; b=okfDXK1w8E4rmcJJ5aJ/BxXPGqBU8eibkiavakb14/vtFJeF4BQX8wCgJVCduuOsLesoeRcIl44MTYEYlpFphrBb3Sfuk65aXsWTm+dapl8o/YKQnZzH1ORZ3/R1zf27Xjh/ebQiw3y7sd+Vxxt9NpyyNTSakEEB2+vctBGL68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612436; c=relaxed/simple;
	bh=1u87rs46+m5wL1Xw7aZOQ0O0nwgjPdStsou5RO+mPyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWiuciWvb+Y4pWcw/+v1+2bapcyixiO6qmGLWHkStMFCD8kE8GbJVRPQYw6EVBbKJ9QiFbuJOzAs2/1GzPr2UjbA+3/Ovn+RimfZzpnrgPgaYuC5d8271AT0F047dfk/WAU5EwLACWgZHIgapRZwqNpo8DYNwRXkuiULCILj1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3OAc8qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEE2C4CEF0;
	Thu, 11 Sep 2025 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612435;
	bh=1u87rs46+m5wL1Xw7aZOQ0O0nwgjPdStsou5RO+mPyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3OAc8qp1KiA1CZHIl/mxpQmfaf0LBkm05l6rgra71v40rJFpYh4yTAUOfkhldGgh
	 9tpbsteyyE0tEPylyozQ9BTW2RM33xhGUWgJGopW0iBSZYi4fywTtYXcYKglBKMKKl
	 /Ydmaedu4JcXjnxszRmE/5yu96eTdDQ0AJ8AUVjN4qb+GAixwMocQKBEcMthA3GL9D
	 1AAon2O4bBGTEiLvYxftkKxJToxIqueHhK/0F5VMOhqyF6S7F0q2X8KQEiFPSMPUWI
	 kxCkgPLQR0mJto9O3bcIzy2OupspxJkX/UA/FTmfCy8lcoBH0jDmGlAJd+cLXiMYxC
	 BZeQbxayJmtVg==
Received: by wens.tw (Postfix, from userid 1000)
	id 3A20D5FEE9; Fri, 12 Sep 2025 01:40:33 +0800 (CST)
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
Subject: [PATCH net-next v5 4/6] arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
Date: Fri, 12 Sep 2025 01:40:30 +0800
Message-Id: <20250911174032.3147192-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174032.3147192-1-wens@kernel.org>
References: <20250911174032.3147192-1-wens@kernel.org>
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
external PHY connected to the first Ethernet port. An enable delay for the
PHY supply regulator is added to make sure the PHY's internal regulators
are fully powered and the PHY is operational.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
- Add PHY regulator delay
---
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index d4cee2222104..e96a419faf21 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -14,6 +14,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		serial0 = &uart0;
 	};
 
@@ -76,7 +77,7 @@ &ehci1 {
 
 &gmac0 {
 	phy-mode = "rgmii-id";
-	phy-handle = <&ext_rgmii_phy>;
+	phy-handle = <&ext_rgmii0_phy>;
 	phy-supply = <&reg_cldo3>;
 
 	allwinner,tx-delay-ps = <300>;
@@ -85,13 +86,24 @@ &gmac0 {
 	status = "okay";
 };
 
+&gmac1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii1_phy>;
+	phy-supply = <&reg_cldo4>;
+
+	tx-internal-delay-ps = <300>;
+	rx-internal-delay-ps = <400>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
 &mdio0 {
-	ext_rgmii_phy: ethernet-phy@1 {
+	ext_rgmii0_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
 		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
@@ -100,6 +112,16 @@ ext_rgmii_phy: ethernet-phy@1 {
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
@@ -240,6 +262,8 @@ reg_cldo4: cldo4 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc-pj-phy";
+				/* enough time for the PHY to fully power on */
+				regulator-enable-ramp-delay = <150000>;
 			};
 
 			reg_cpusldo: cpusldo {
-- 
2.39.5


