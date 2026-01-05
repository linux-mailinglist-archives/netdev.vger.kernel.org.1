Return-Path: <netdev+bounces-247006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95748CF36D6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C592330069B0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40733396EE;
	Mon,  5 Jan 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIKmTCtA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465B338F5E;
	Mon,  5 Jan 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614925; cv=none; b=H9x4N9Ikvcwhdy3VY1LZJnsuHZvxVWV+nrrMlRM0er8dCB1Su7vsNcQ9d91apCM7fRbW+Uy9idepi44CboeHk1/i7kO6TpSxZ4i7l2truYZ4XR4jortLzeOrbWkAgNh9Zd/3+K+OIaHPapCTQjjvKCre6QNVjmJdTUxEAjOUnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614925; c=relaxed/simple;
	bh=d2TRHYORZXsy2A1NvCNofvbS7eDma5sCMXLSKryxZ+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkNi8lq851dutnBy27RBNdtqpX4BBPUBnvltBmERHTEntfPOSPAuMlgFLJP7vrhZnHLElUCgi/OglAYjf4NDSaShkvgJqO77I488a+SrdSPpR4/wCMNHYLf5lBCra1nhonZ7Dv/13+YG8ZZPj5sqWw7mMTsKn+oDkZsrTyXZSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIKmTCtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377E6C116D0;
	Mon,  5 Jan 2026 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767614925;
	bh=d2TRHYORZXsy2A1NvCNofvbS7eDma5sCMXLSKryxZ+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VIKmTCtAL0IUVFWQJodtnLn+t4Zu8BYI9xmeNhu8XhLQ4Z+y+c7v+n4MBDMajRbcU
	 wxpPwAbg/A97wvgN1KBF6ziopo8e/HVRXoeqTlmBGLZb5ijerm9Tazm8FsQpvTjqtN
	 uFH5t8ZT3eFB2TR1AwgJLVGLQam3ArzhhZ3xd18G/f/cfmh/kBiqkDd54VxjdllZm5
	 nPdD+mIzm0blK+y23m+gPuXuoAUO1oU2K4qauIFdQRkE5c8QLmOWdhyt3BPslrRhaq
	 OSZH+SwKN2ygxt9FyQHgYUOeMUeaMnSMJvQgcjkPTeL2fqGPoCav+jiRM/OpC/9ZPz
	 XH9Nzo9VFJyJQ==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Mon, 05 Jan 2026 06:08:21 -0600
Subject: [PATCH v2 2/3] Revert "arm: dts: socfpga: use reset-name
 "stmmaceth-ocp" instead of "ahb""
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-remove_ocp-v2-2-4fa2bda09521@kernel.org>
References: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
In-Reply-To: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=d2TRHYORZXsy2A1NvCNofvbS7eDma5sCMXLSKryxZ+A=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpW6nEWd7mbEQX7sf3uR0NJjUGW8Tiyng8CFOE8
 ZjjyH4efpCJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaVupxAAKCRAZlAQLgaMo
 9GjxD/9c1SPrLDQhnKon7tu1O65dvg8pnvfeRmI0oeQWVUQMiEkCmXIaWsiMHJ+9rPk69TzKs91
 kfZkzziMVUZzwfpYk6xsqxi3fF8XxT+0e2Z9u4Hlj68G/5iNOGuYxFc+LHZNtDpO5MvsJGq/W+l
 33RQFbio8aJDrJ13P8fmJxr8CYgntwBNh/IDFawkcSIAjyX5FXOk4VHDuvcWWYDjIpNwK9miAou
 08Igff5AItrGsXSnSYizElqGr37FkLYUCBOsPJ+ygszn4oKTcpn2m+XYymq/TYsIFrmvUAwy5/J
 hEXroGMuZ5Vnqh6w9btIsvQ0OZTU1rpJgYx08VpPLRN488/MSPlxcspmKlgi0W8j2q8v0jiEbzq
 ZbhrfUblLeavGuqWwIoMsqIyDVlelVxN+pydFq/XXOJvMaWS3w91NUceSbLACSFeIz0fpCgU0L1
 S2JsIsVlwGaloixM6O++rlSPham/HAA1wMmk9Lh4XwX8cjJDeDyIQ/r3Z7sIOfKYoDpiuZOm5WG
 KkyRwOOCELmY0ZdNzyl6AUWJ/S2nJr8dNd8NWS0U9cApfwaRNJfswY/Zy1a5el0IIhkfTrHcIeg
 NhiuLokskbbyCW5S11LQ3rUs8GEEwMeQQMGKtgmBi2dJrQ/ZyUjabvFGfkviJFSwgVcE5GlNhYP
 5EYo09axGhIFhVA==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

This reverts commit 62a40a0d5634834790f7166ab592be247390d857.

With the patch "add call to assert/deassert ahb reset line" in place, we can
safely remove the "stmmaceth-ocp" reset name and just use the standard
"ahb" reset name.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index b108265e9bde..6b6e77596ffa 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -440,7 +440,7 @@ gmac0: ethernet@ff800000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -460,7 +460,7 @@ gmac1: ethernet@ff802000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -480,7 +480,7 @@ gmac2: ethernet@ff804000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "stmmaceth-ocp";
+			reset-names = "stmmaceth", "ahb";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};

-- 
2.42.0.411.g813d9a9188


