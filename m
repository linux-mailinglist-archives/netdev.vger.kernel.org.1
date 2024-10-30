Return-Path: <netdev+bounces-140355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7F9B627E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02ACB22DD7
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75471E884B;
	Wed, 30 Oct 2024 12:03:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928571E7C11
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289808; cv=none; b=uB4vmXV7aoJRQ5yU58x9mWpLckN/ZXVBa2DTciU1SUfqg4V9017GvwI9vPE0RuMAtY3eLc+85xTjZeT/xPTRvDQcq6Kja/QHvwsrAekrZ5KmR0sEcH/pNZFh00B9ki9FuYeJqfSEVEzFoCvz7RPTgOKq2WOtgeylZCyZo5Wlzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289808; c=relaxed/simple;
	bh=xSkkHlXsyqGqSC79QmOXIv8+ofKsCEPAmcmScmN/YZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p59alcK57Xz9mxwi/JHJ4ZjqB7nMv4Yj4LJ/4kuUQLqpFIIzgrYoxIRMu9MnV+kACExrZfisRy7u4vmJx2pPBACaS7rUVtyJ9sGLZI5Cktu3sXGWA7/pUxTXlzOFjV/he8l5W5w+9Iqsqt3WX6OdPH1bjEpnSyM5BXc1NDdVfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1t67Pu-0005ni-PP; Wed, 30 Oct 2024 13:03:14 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 30 Oct 2024 13:02:59 +0100
Subject: [PATCH 1/2] dt-bindings: clk: agilex5: Add Agilex5 clock bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-1-e29e57980398@pengutronix.de>
References: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-0-e29e57980398@pengutronix.de>
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-0-e29e57980398@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Teh Wen Ping <wen.ping.teh@intel.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

Add Intel SoCFPGA Agilex5 clock definition.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 include/dt-bindings/clock/agilex5-clock.h | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/include/dt-bindings/clock/agilex5-clock.h b/include/dt-bindings/clock/agilex5-clock.h
new file mode 100644
index 0000000000000000000000000000000000000000..661bc8b649adfd6c3ae75dcbaff5dea331f0be52
--- /dev/null
+++ b/include/dt-bindings/clock/agilex5-clock.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Intel Corporation
+ */
+
+#ifndef __AGILEX5_CLOCK_H
+#define __AGILEX5_CLOCK_H
+
+/* fixed rate clocks */
+#define AGILEX5_OSC1			0
+#define AGILEX5_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX5_CB_INTOSC_LS_CLK	2
+#define AGILEX5_F2S_FREE_CLK		3
+
+/* PLL clocks */
+#define AGILEX5_MAIN_PLL_CLK		4
+#define AGILEX5_MAIN_PLL_C0_CLK		5
+#define AGILEX5_MAIN_PLL_C1_CLK		6
+#define AGILEX5_MAIN_PLL_C2_CLK		7
+#define AGILEX5_MAIN_PLL_C3_CLK		8
+#define AGILEX5_PERIPH_PLL_CLK		9
+#define AGILEX5_PERIPH_PLL_C0_CLK	10
+#define AGILEX5_PERIPH_PLL_C1_CLK	11
+#define AGILEX5_PERIPH_PLL_C2_CLK	12
+#define AGILEX5_PERIPH_PLL_C3_CLK	13
+#define AGILEX5_CORE0_FREE_CLK		14
+#define AGILEX5_CORE1_FREE_CLK		15
+#define AGILEX5_CORE2_FREE_CLK		16
+#define AGILEX5_CORE3_FREE_CLK		17
+#define AGILEX5_DSU_FREE_CLK		18
+#define AGILEX5_BOOT_CLK		19
+
+/* fixed factor clocks */
+#define AGILEX5_L3_MAIN_FREE_CLK	20
+#define AGILEX5_NOC_FREE_CLK		21
+#define AGILEX5_S2F_USR0_CLK		22
+#define AGILEX5_NOC_CLK			23
+#define AGILEX5_EMAC_A_FREE_CLK		24
+#define AGILEX5_EMAC_B_FREE_CLK		25
+#define AGILEX5_EMAC_PTP_FREE_CLK	26
+#define AGILEX5_GPIO_DB_FREE_CLK	27
+#define AGILEX5_S2F_USER0_FREE_CLK	28
+#define AGILEX5_S2F_USER1_FREE_CLK	29
+#define AGILEX5_PSI_REF_FREE_CLK	30
+#define AGILEX5_USB31_FREE_CLK		31
+
+/* Gate clocks */
+#define AGILEX5_CORE0_CLK		32
+#define AGILEX5_CORE1_CLK		33
+#define AGILEX5_CORE2_CLK		34
+#define AGILEX5_CORE3_CLK		35
+#define AGILEX5_MPU_CLK			36
+#define AGILEX5_MPU_PERIPH_CLK		37
+#define AGILEX5_MPU_CCU_CLK		38
+#define AGILEX5_L4_MAIN_CLK		39
+#define AGILEX5_L4_MP_CLK		40
+#define AGILEX5_L4_SYS_FREE_CLK		41
+#define AGILEX5_L4_SP_CLK		42
+#define AGILEX5_CS_AT_CLK		43
+#define AGILEX5_CS_TRACE_CLK		44
+#define AGILEX5_CS_PDBG_CLK		45
+#define AGILEX5_EMAC1_CLK		47
+#define AGILEX5_EMAC2_CLK		48
+#define AGILEX5_EMAC_PTP_CLK		49
+#define AGILEX5_GPIO_DB_CLK		50
+#define AGILEX5_S2F_USER0_CLK		51
+#define AGILEX5_S2F_USER1_CLK		52
+#define AGILEX5_PSI_REF_CLK		53
+#define AGILEX5_USB31_SUSPEND_CLK	54
+#define AGILEX5_EMAC0_CLK		46
+#define AGILEX5_USB31_BUS_CLK_EARLY	55
+#define AGILEX5_USB2OTG_HCLK		56
+#define AGILEX5_SPIM_0_CLK		57
+#define AGILEX5_SPIM_1_CLK		58
+#define AGILEX5_SPIS_0_CLK		59
+#define AGILEX5_SPIS_1_CLK		60
+#define AGILEX5_DMA_CORE_CLK		61
+#define AGILEX5_DMA_HS_CLK		62
+#define AGILEX5_I3C_0_CORE_CLK		63
+#define AGILEX5_I3C_1_CORE_CLK		64
+#define AGILEX5_I2C_0_PCLK		65
+#define AGILEX5_I2C_1_PCLK		66
+#define AGILEX5_I2C_EMAC0_PCLK		67
+#define AGILEX5_I2C_EMAC1_PCLK		68
+#define AGILEX5_I2C_EMAC2_PCLK		69
+#define AGILEX5_UART_0_PCLK		70
+#define AGILEX5_UART_1_PCLK		71
+#define AGILEX5_SPTIMER_0_PCLK		72
+#define AGILEX5_SPTIMER_1_PCLK		73
+#define AGILEX5_DFI_CLK			74
+#define AGILEX5_NAND_NF_CLK		75
+#define AGILEX5_NAND_BCH_CLK		76
+#define AGILEX5_SDMMC_SDPHY_REG_CLK	77
+#define AGILEX5_SDMCLK			78
+#define AGILEX5_SOFTPHY_REG_PCLK	79
+#define AGILEX5_SOFTPHY_PHY_CLK		80
+#define AGILEX5_SOFTPHY_CTRL_CLK	81
+#define AGILEX5_NUM_CLKS		82
+
+#endif	/* __AGILEX5_CLOCK_H */

-- 
2.46.0


