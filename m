Return-Path: <netdev+bounces-232513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE36C061D6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AA775085B0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5C314A83;
	Fri, 24 Oct 2025 11:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C52D46D1
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306629; cv=none; b=RHXrAwA2zA2R8fzmCIuKh4MKS24hATvVtfJWXwyeFnqWfbpXZuyg/h0YZueZiXexsWUT7z59ix2iC91sGy7xn3cJgXNGcB7Jws0a62PvpC50pSAZMUyQ0lhmbXqd5KgKopV9bIuBJ3/EGc1IFpvH6a4MlKxOKbFudalu4krdqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306629; c=relaxed/simple;
	bh=QgkBnM9xfqbsYlvy/dOII/9/euxbzsHAI0HqqgHuV7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpZjefIaDNbFF/wv71/QMQIUx9BayhxWQ0BjmLUF+BTJZmjsxGOZ1csA5+C5xdvfYHRyCXipSEasI73eq8T56FybdokT26gwSR123ahzQYCvHvol1vrVxhpOdRqGZ+8wW0yTUjxXFmQJVraXXqlNzPnSD6PrbigJCbKfx1bsWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGJA-0002FG-0S; Fri, 24 Oct 2025 13:50:12 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 24 Oct 2025 13:50:00 +0200
Subject: [PATCH v5 08/10] arm64: dts: socfpga: agilex5: dma coherent
 enablement for XGMACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-v6-12-topic-socfpga-agilex5-v5-8-4c4a51159eeb@pengutronix.de>
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
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Tham, Mun Yew" <mun.yew.tham@intel.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: "Tham, Mun Yew" <mun.yew.tham@intel.com>

Add dma-coherent property to device tree for XGMACs to resolve kernel
panic error on dcache_inval_poc for XGMACs.

Signed-off-by: Tham, Mun Yew <mun.yew.tham@intel.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index d0c139f03541e..63c0aa8550313 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -558,6 +558,7 @@ gmac0: ethernet@10810000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
 			snps,clk-csr = <0>;
+			dma-coherent;
 			iommus = <&smmu 1>;
 			status = "disabled";
 
@@ -672,6 +673,7 @@ gmac1: ethernet@10820000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 			snps,clk-csr = <0>;
+			dma-coherent;
 			iommus = <&smmu 2>;
 			status = "disabled";
 
@@ -786,6 +788,7 @@ gmac2: ethernet@10830000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 			snps,clk-csr = <0>;
+			dma-coherent;
 			iommus = <&smmu 3>;
 			status = "disabled";
 

-- 
2.51.0


