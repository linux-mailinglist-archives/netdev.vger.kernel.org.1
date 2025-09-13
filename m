Return-Path: <netdev+bounces-222783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2156B56015
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9C33BCD67
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DC2ECEA2;
	Sat, 13 Sep 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQQ5FjgV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1202ECE8F;
	Sat, 13 Sep 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758438; cv=none; b=QrlZwXVvI0S2JXX8O0K4cPxyLG9p8SY0FTMbg8o75Pp6KMc127MKAM6TYYoROEP7qUf6s7sYmZGXZ+JxsxSWsvwimx+ND/lelJPRP2G40AWzloSmnIVkt6B+nxW9b6FXhLIvpcgWJNzzRfe7+nJe81eH50fLFZHk7hXHENtojec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758438; c=relaxed/simple;
	bh=F1DxGedyVmvL5QMILi5W2tfKDMHyreDrXh2WSu7hfs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9iiM6sZ03grKWDh0ohC5gC1aRmDcH4LdMAxubiJh8AMDUg68vCk++lRzRzLw5R5J/pCkROebeBoN015pQ8mDIHtfU3t/52AyUJDRUJhz2yPN2dEvG6JleUzu/BpOLVri2sd5aFqmF37fvDT1Fm2GoAJ4Hq97ypPIGmCvm3sW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQQ5FjgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68E3C4CEF4;
	Sat, 13 Sep 2025 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758438;
	bh=F1DxGedyVmvL5QMILi5W2tfKDMHyreDrXh2WSu7hfs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQQ5FjgVKd3Jpu23xcfWXAhyXGmYcyzoFAZ+vaXeFiCObqH03QIqLWEJLX4kwXetO
	 XgJMv+W3YKyMwzR4iZypPS3mB9dto9gvVv9PP1C8un23/RbK21uz1Xoz9RWWjJHQ68
	 0qRDYCyWe9t3XhiPGms5XWTTEZxy7unKMjMqjUFqP0jvY26gPnuYrloC0QWmWdJODS
	 fmalaxwWs7ZnfLOMs3sbMnZw43aLEutXHGL4eiuzg8j3qQYOVGu9EioqJl7aBxpcwj
	 Zw41g5e8Wil/BxBSSDOAEp6qrvC7VYvMMR+UqXqYs9F8FSQqBgdhGp/uylS5SpnF0y
	 hTtcl54R22zgw==
Received: by wens.tw (Postfix, from userid 1000)
	id 6E0175FE52; Sat, 13 Sep 2025 18:13:53 +0800 (CST)
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
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v6 6/6] arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port
Date: Sat, 13 Sep 2025 18:13:49 +0800
Message-Id: <20250913101349.3932677-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250913101349.3932677-1-wens@kernel.org>
References: <20250913101349.3932677-1-wens@kernel.org>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


