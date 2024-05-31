Return-Path: <netdev+bounces-99704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95928D5F89
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB811F2237E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEE1514C9;
	Fri, 31 May 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+q7X4fP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2F1509AF;
	Fri, 31 May 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150959; cv=none; b=KhFQ8zPd5Tsgd/X0lvB60S0HWQ+x6OQBXItmivqh9sDA8UALlSebJVfzf9zHPmxFghmjhKyp9a3d9oHnpcfBLmr/36Zg5TXRq4c2nbQGuqeb4pXxPiMrqYsTtzCarxXTArMB/vEXUI+KozIW3cQ/t/ZE8bPvgsnqqQzImGNpcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150959; c=relaxed/simple;
	bh=imEposczTWqKNpSJQYha6fRewZweVy4/OhJdJUTel/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoUdHKE5tO28Lmos0gvuLThDQq7lGZgNcUx1n0lye1Xv1OcimbetrebwMEEUhB6rwauEnQxNroA8m3dWJD49NX5PWFKtKJ8nmKlHmW8UwAjRnnNeqPcFv0Omg5LfjQhYnRgnCjU2owOtc0E5FsdlxvI0Q6JJJa9rKkn/I69NSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+q7X4fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01883C116B1;
	Fri, 31 May 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150959;
	bh=imEposczTWqKNpSJQYha6fRewZweVy4/OhJdJUTel/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+q7X4fPmbKviwEs2yrV55fdUWD2HQgcipV5WHaWeOYt/wQGOcKc4dtta+2jwvU/T
	 Gnoq4g4YpitNULMweSaiCrmDFhnPnDKWeRE2bjrjJpaVgi7WtILsWlQcTWzxjePSWh
	 aLTY2k6rR/d4cxfbuimmtu9Wpcvpyw/B2TxKbpIEIk5HndvP9T7ANx7RfEc0uSapo/
	 Zij4QjLpLsZq8Pd3TRTOb7d7QplaS7ry0JVUl4cpPMSgsjAgm6zmSCinULg0feRoOT
	 zyOGHnAf2i8wreXqi/2W0TB7g/oTHLvhqoHuJnRrxHpOw8/e3iGOo/d/AGVEzXpXUH
	 A9+o7UcAEKLvA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: [PATCH net-next 2/3] arm64: dts: airoha: Add EN7581 ethernet node
Date: Fri, 31 May 2024 12:22:19 +0200
Message-ID: <0f4194ef6243ae0767887f25a4e661092c10fbbd.1717150593.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717150593.git.lorenzo@kernel.org>
References: <cover.1717150593.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the Airoha EN7581 ethernet node in Airoha EN7581 dtsi

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 arch/arm64/boot/dts/airoha/en7581-evb.dts |  4 +++
 arch/arm64/boot/dts/airoha/en7581.dtsi    | 31 +++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581-evb.dts b/arch/arm64/boot/dts/airoha/en7581-evb.dts
index cf58e43dd5b2..82da86ae00b0 100644
--- a/arch/arm64/boot/dts/airoha/en7581-evb.dts
+++ b/arch/arm64/boot/dts/airoha/en7581-evb.dts
@@ -24,3 +24,7 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
 };
+
+&eth0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index eec29cd6539a..c9363b5f19c3 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -263,5 +263,36 @@ pcie_intc1: interrupt-controller {
 				#interrupt-cells = <1>;
 			};
 		};
+
+		eth0: ethernet@1fb50000 {
+			compatible = "airoha,en7581-eth";
+			reg = <0 0x1fb50000 0 0x2600>,
+			      <0 0x1fb54000 0 0x2000>,
+			      <0 0x1fb56000 0 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk EN7581_FE_RST>,
+				 <&scuclk EN7581_FE_PDMA_RST>,
+				 <&scuclk EN7581_FE_QDMA_RST>,
+				 <&scuclk EN7581_XSI_MAC_RST>,
+				 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
+				 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
+				 <&scuclk EN7581_HSI_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma", "xsi-mac",
+				      "hsi0-mac", "hsi1-mac", "hsi-mac";
+
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.45.1


