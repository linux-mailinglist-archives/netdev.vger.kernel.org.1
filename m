Return-Path: <netdev+bounces-248077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE014D033F4
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8EE30DBA0E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161633A7DF0;
	Thu,  8 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFqj2r7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C813D4138;
	Thu,  8 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877709; cv=none; b=WtqS8y60bSYk1iC+Zm+pdVCIywiAHWeJlx0XIKPP0ajbPX9cBzd/5+CdXeU7gCSI+49TOZ5DN0j5hWxSTlih/HbLFJA3n3eeP9vYFdS/cmpV+nLbfAwwpI4CiEblBMJ7dUCIlDsKllLUcjC9N1DEuEtSK1f+2035K4dnaVO6WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877709; c=relaxed/simple;
	bh=zzfKZcs3JKUANgBbQm5V67WGSuiqbzhNyOZ+JkUeHv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOwtqcCIItsXe99iBsZBfwaeU4WLwWinsHqqBz9y1vvGo/dcTLXFWxpRDSOQUHkvEYHIeUA/gVhhGgSxzmkaml4qYNdm/4i5MH3PFJ6r+Jgr5rWVWnZ/E2rt31EN5YI/ef4waOad76ulmR0bJR8y/gZ7WPnAP8czZ6Z9aM8Czos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFqj2r7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07276C116C6;
	Thu,  8 Jan 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767877708;
	bh=zzfKZcs3JKUANgBbQm5V67WGSuiqbzhNyOZ+JkUeHv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EFqj2r7h+3BQhj13CjsMQez9jQX02SF95uG1X5t7ID2LqMEwrzqJB1aZrx4fqu061
	 W458UVJC1WDgkijW+H4/sMqKwZ2ic9TWZa3IWxrgftf3JQlGct+oHtK42buxuq/7ZR
	 V19pJqvXovETaDE5T21+oSC9RAIDMIec5UPMQLo3ZN90fT534LY5xsIcGz8K24hObn
	 iBGjyJCgMqATD6kSsD1Q15FWTQMnBQZEyJs6eVrY8Rr8eg4CbqZCOpsWPQ+vSBcLpg
	 +1mF6GdGPxbf0dOjCFC3X427fXbzXX+Qzkx1GSKMDSnL50friBb/IhNCFLi0YNCIFp
	 ARVUuDhfV3lIQ==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 08 Jan 2026 07:08:10 -0600
Subject: [PATCH v3 2/3] Revert "arm: dts: socfpga: use reset-name
 "stmmaceth-ocp" instead of "ahb""
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-remove_ocp-v3-2-ea0190244b4c@kernel.org>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
In-Reply-To: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=zzfKZcs3JKUANgBbQm5V67WGSuiqbzhNyOZ+JkUeHv0=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpX6xGGWdQPpVq8qYm9OlaaTePBrJYKVLBxsdwv
 083GmzhNlyJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaV+sRgAKCRAZlAQLgaMo
 9OuZD/0cEohrZMBiJ9+Hr8v+FNP4SWi2PDnbdjjrrH1XtMNbDYBr4nQRJXrlqGCvRsbj3HI+jBp
 WP2HQkHGaHYmsHXnVt16KNOgqxFsxWKcT6oQt81RvsCDmQ+NUl9iHEqYAWDSaPsKY5fFxqy3gFc
 s1oXUvptc8oac7b1x1nevpzFMpdt/zV/pnJSwiKaDeRvhF219Kh5oihYBOO7xYYCaAmkRbL2FG1
 2KWGHhNSPJ9rxCk+MUVDFMaJX2ILjyfmKoM/suoLKzh4/jo+Om/9H2irhbLXQXekurU7S1FFzkP
 fZ+86SFc7wkSJ8NrpHVBs7PWqzIH0TBkMvqqNv8L2z7y5oIYM4QmNQhnyhoIwrI1uhPK7bQHdx7
 0fokdMs7SGRpAPBwLOsdavcWN+1ndBWfU+P2LzkTWaqYFLr/EL+JQO12K9qqytngujojC2dBbd6
 xVVsaA7vmfu5yjAF7Crn+hVVWFUqajOKqZttrbk+8s3ZgRT7SGXivTP5CsaPGXVwvxtVRxxXlEY
 WJi/ykJYVOFqE5EfkG6GMyBG3vNIK0/noa7g3phua5fzvCfeFsWIkGsbFhLsPr+7tg5wq4PcrV4
 6KCIVkhrFzWpnMZhUOMZ7kTPm4OxyJYNUAJHTvklgfPbPX0eiNtzKNZRim2aGgbzTMNW22j4SUy
 2NFHASTH1iB1sdw==
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
index b108265e9bde4..6b6e77596ffa8 100644
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


