Return-Path: <netdev+bounces-149293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF69E50C1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09FB289DB7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672481F8EF1;
	Thu,  5 Dec 2024 09:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFD1F4276
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389589; cv=none; b=Ou2EvDkGRAvNl7ZOwcZJXFdDGC6gX/iuGm1KFhwbYY+gYqRlXTHN+1P2U412yMLj3DAb7u7YLM8hHQAo4cpJl6bpv51NVVX+o01Nn8gP+bYd0Apl7hvL0YxH8wJRHWuIIHyU0k7tophTTbAU+e6rYj00zb+U4ISzBtSk8PH1JAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389589; c=relaxed/simple;
	bh=at8DXr0K9qhUNjjdPNc/kRN0tQX2gXsyOQUWEX2md6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMfrAnLB/L2TQ+xV262kflhNu7LB7sbvr7AHirXbT35DwYmVgqLSAiktncLHJSs5zgocvM+GjMU67vYQ+INs7Z4BsON45Qd4K4WbBzUBPxYq3eF572+nslVVUxN3RGfPLnFU84+k23qMG07eNav3nP24+Gz11QeYInR72Ps9S5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tJ7oU-0004Ks-NS; Thu, 05 Dec 2024 10:06:22 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 05 Dec 2024 10:06:04 +0100
Subject: [PATCH v3 4/6] arm64: dts: agilex5: add gpio0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-v6-12-topic-socfpga-agilex5-v3-4-2a8cdf73f50a@pengutronix.de>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-clk@vger.kernel.org, kernel@pengutronix.de, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

gpio0 is the same as gpio1 with a different base address.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 0035caef5af2774083885cf2d0d8a38ee8be9627..47f49d1e1442f66d97a323cd382f3f42d34ab835 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -312,6 +312,25 @@ i3c1: i3c@10da1000 {
 			status = "disabled";
 		};
 
+		gpio0: gpio@10c03200 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x10c03200 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&rst GPIO0_RESET>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		gpio1: gpio@10c03300 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x10c03300 0x100>;

-- 
2.46.0


