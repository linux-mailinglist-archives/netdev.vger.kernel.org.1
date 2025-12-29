Return-Path: <netdev+bounces-246279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84353CE8097
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F063041563
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE602C11ED;
	Mon, 29 Dec 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbAzqKEZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95832C0F7B;
	Mon, 29 Dec 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035873; cv=none; b=QEsQ0yOGqYAyTGYjBgHGMNEvnM6sZ4kVmXof/9z3DmQkEU4EqEIt3G0dAddgCvnrKGkL9G5aAQoK7aiWLFRrFQmG4rsOwlqQGu2Ymb5wGEnNYB7r5OMHk/cO1MXMldlLAGEGtIFQx4Wx4ZklwCF1mDeiUyaSUtyDJ6FM7+qltMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035873; c=relaxed/simple;
	bh=d2TRHYORZXsy2A1NvCNofvbS7eDma5sCMXLSKryxZ+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZumIZ9IqGK6F5+n9BuF4bC9L9R2M5R2fhIrW0aIGFpM4aM+9YQwl2JV/S5IRN4nhI0Usdew8rjGrB1h6mePWkFTKt3uxCSEPWDUAjuA3pewwFM/hRGJFCG30VlWyp2wNewPXErn9nBZvzSSCkeWNJtcxoJuUFiWbYbH/2YfTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbAzqKEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F1C4CEF7;
	Mon, 29 Dec 2025 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035873;
	bh=d2TRHYORZXsy2A1NvCNofvbS7eDma5sCMXLSKryxZ+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbAzqKEZmOT4OAvGjay6ZbKxfEn89vFk6+M+/mrBS95qYTDFYK6teKSpepbtbDVhB
	 zVXaWcqu8M/VicJWW81BU0DhomB4O89rfl91yekn8Sd4aHeZLh1lAqdIXm3W4czws6
	 bKs11DMTutMn5CWlVIk2rYic1zabSCi4UVuhtROByqkED1kK9jdCYbjbgflZTKzeRE
	 5REfAeRWGXVrAriI6asDhF59r/DM1zwjOyAbOEtqtWEsmKkivYmBW2eLrSMSvT+GTM
	 W1IlAnfSamIwk9sqANNok68HO6uzO/lVgGLgLPKspXX7NCfsu752o5Q/tP4l62R66y
	 F8+j0fB+S84Ng==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Mon, 29 Dec 2025 13:17:19 -0600
Subject: [PATCH 2/2] Revert "arm: dts: socfpga: use reset-name
 "stmmaceth-ocp" instead of "ahb""
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-remove_ocp-v1-2-594294e04bd4@kernel.org>
References: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
In-Reply-To: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
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
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpUtPcHIcFizytq0dGZkNW22rpAEY2qpU74OH1O
 vbi6hJ2X7eJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaVLT3AAKCRAZlAQLgaMo
 9FG2D/9jgiEwhyxfOr5Mo/+NnTLWSreSDld5RyR7AHNijUW/gR6BWUBKC1AHObHTYPrGVx4EIFf
 CJUPAZAzCSbL7Q9WViMlHQH4JQcyHA6kEOdiPMlFbqjuppjhr449jsqofenGJFm/gC3JT30vYPy
 8LyhPX1b7P4mMX7ySrXDVJx4B5RGB9Sy7Cv2175rjrgLV1CRpvzxdTVE+bU9/IpFa6sBMhBf0sB
 7qDwsSmc2vYHBWecOjM1CfQ0RGTecYFrnXzleh8jrZM3xJqDkr5o3wqG1SmYadsiukMQX6tRfTG
 eagGt829RmEzvNIO1mu2CQdsx34EdwcAclUW+h+AUUShShSlpbtlotxxjziaikFRHeQ/szfeLlW
 Z3d9IFkMSOcy3Yom13452NSZajaL1gV85ijQk+3yu7dznepFMvyso4iIkYB/zj9lq9dH1S3KK3x
 MURAtDLL+o1zvT/gwOusDI49QcziwRWaxjkabzuNxMujPGVHi9slExTjdOhL58gmBiPrGvk7Vmj
 yxzo7dmotSivdQ0KQnFKRlEFMBN8N+Gs1ASuYmFwTFSwpC6I/jzxxTy6JvXj/zvSP7pXb8pzxvp
 cZ3Ej7YqYzzecHH+lBIHAuS3+No+VvQP7UpBXdV4V7paWM4XpTMODhqmYppkELZVWfqatiIG9GU
 MWd8Sx8Kg4lRuHQ==
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


