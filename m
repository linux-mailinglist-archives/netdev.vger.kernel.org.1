Return-Path: <netdev+bounces-232508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA18C06200
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434FC3B678F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E5314A94;
	Fri, 24 Oct 2025 11:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1652D3A69
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306626; cv=none; b=X05VPp+0/oBhk61CoZfTWigugcF0hFZkdsv1AU0mt7E9ZlweRcZ08L1VnLyqx8DE2hLk22ZU8GvKUyxxO+6dCW9Q4O67hRrnB2bEyVSHPdIR1Pwn/WnRuoPoGboB13w+C46YkYOR5P78bMdrh+EcjZzcaFxgWTzmYWJuyROM4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306626; c=relaxed/simple;
	bh=bvjxnCpbgRWS5dB0A4fk7xC8f8vcVUPm7QTjunvl35c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS4u4OLYlPcB1Ut+Hacj1BGbQr2C5w7GlteQfHuBCBEBes4scKVMic4knVXnedVrYB7GGaEo0Xe5yVOyiDK8C/bbnXKmdYkKwEZ2yZA3pH0e+OTNBYWvbFD86732l7zrgYlNQ4rZFcrfgMaE5Xsc7gsMqEjVwxM/j4jyNnBBw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGJ7-0002FG-Id; Fri, 24 Oct 2025 13:50:09 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 24 Oct 2025 13:49:58 +0200
Subject: [PATCH v5 06/10] arm64: dts: socfpga: agilex5: add dwxgmac
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-v6-12-topic-socfpga-agilex5-v5-6-4c4a51159eeb@pengutronix.de>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The gmac0/1/2 are also compatible to the more generic "snps,dwxgmac"
compatible. The platform code checks this to decide if it is a GMAC or
GMAC4 compatible IP core.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 4ccfebfd9d322..d0c139f03541e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -536,7 +536,8 @@ qspi: spi@108d2000 {
 
 		gmac0: ethernet@10810000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10810000 0x3500>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -649,7 +650,8 @@ queue7 {
 
 		gmac1: ethernet@10820000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10820000 0x3500>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -762,7 +764,8 @@ queue7 {
 
 		gmac2: ethernet@10830000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10830000 0x3500>;
 			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";

-- 
2.51.0


