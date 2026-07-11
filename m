Return-Path: <netdev+bounces-306764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8tTO7r7UWpPLAMAu9opvQ
	(envelope-from <netdev+bounces-306764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:15:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130F740E1B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b="mbxRCJ0/";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306764-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306764-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDDE13030295
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D1381EAC;
	Sat, 11 Jul 2026 08:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886437F73C;
	Sat, 11 Jul 2026 08:12:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757559; cv=pass; b=bz70S8deXY5kx7BFOxja7Ky/yPgEmImo3F4b9GJZIhIiyf4gfdVM8D4uXdEvha2KSOH3YypiGoRc22RhxWCMslr9Lut33zRRZvusJ5YGiJzetPjBDtYlfcl1JBERrcvc4/r11BeLtCk+RMWI0Z/4rkQRnPbOC7DP+inve3zdQsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757559; c=relaxed/simple;
	bh=xDs7aF09JCqJozBlgtbT0W5cDZq0QIw8b2Kh8/rGLqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMNRFYGILBunGma6NwNGCdXQZbvVKGT2Gn4pXwX5ZAituH3VhkyHr7pTgHWlLyCRDW581YhNMboWV7LvH5kF3IyCr4a+Tg4zLkDIUF9MsHvx4etBR/564vJlX0IQVuQPkjXiiCxPuUGGSsBbY0Gs/jyx4W1jZQTVUzoGukHa/Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=mbxRCJ0/; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal: i=1; a=rsa-sha256; t=1783757534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NRQXplQxGJRCexRiGskuflstW0LMAIHsQKR72zQ2reOrpuTO3RaC8gu/z7sdf4/5onygzgvw22NM+qFSEuCf7/U0Wxn9bQg9b+e8p5WwlqMcA5ZUCIztYRZkszwlFi9vMecVp1ed1CjA61QZq6xVRrIG8+rGMug81ITkmV1Indk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783757534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=49zjnnPxInf4/Lb8wJPC2uCok/znNnOVrhQy99e/PWA=; 
	b=dqCFEPXCOpCbbUrtLqsMUwKadblUY1YAdTsZyQR0j6WvmaRP+t9/LmOyEe3ziDgmAlMmOWYiEf0wRSzjaUDntuYCdMPeNQ2IETxx75G4A6yscaRwtIXHvpHlQJHGBWVKnhgZ7tHyr+qEGpybGRH2xJlYiydwK0r85FdIRx+G/JY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783757534;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=49zjnnPxInf4/Lb8wJPC2uCok/znNnOVrhQy99e/PWA=;
	b=mbxRCJ0/czbRVya9urq3ZWJhZoi1lHfsHj5oY8U2JtJiZsDrUfiEnKSNlmG4jfy1
	B5RY8Cwa+opPT9N96zHh6Y6mhAbwqWXRjKQvSmaz3oaGhPyRdNPZmiFlpW/pCbXCBOb
	9mP25XA+4eX7RRsP5pIncC2zVcMk3OEthS/npwmA=
Received: by mx.zohomail.com with SMTPS id 1783757530976962.246295364046;
	Sat, 11 Jul 2026 01:12:10 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 11 Jul 2026 16:10:31 +0800
Subject: [PATCH v2 5/8] clk: sunxi-ng: a733: Add bus clocks support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-a733-clk-v2-5-974d188cbe0c@pigmoral.tech>
References: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
In-Reply-To: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783757449; l=5562;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=xDs7aF09JCqJozBlgtbT0W5cDZq0QIw8b2Kh8/rGLqI=;
 b=yxYd36PY5qLgs/Cl7U4Wg0U2a3E3tlSKnXa4NKtxME69UQP7pW4rT3+ZJoltndtsOVp0V0yu9
 8/1aI3pqKtyAnCr33jVo9z4PmbQ1iPtYmVJRtQ9XibTj0DrwVXb12Qy
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:junhui.liu@pigmoral.tech,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pigmoral.tech];
	FORGED_SENDER(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306764-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,pigmoral.tech:from_mime,pigmoral.tech:email,pigmoral.tech:mid,pigmoral.tech:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9130F740E1B

Add the essential bus clocks in the Allwinner A733 CCU, including AHB,
APB0, APB1, APB_UART, and MBUS. These buses are necessary for many other
functional modules. An additional trace clock is also added as it fall
within the register address range of the bus clocks, even though it is
not strictly bus clocks.

The MBUS clock is marked as critical to ensure the memory bus remains
operational at all times. And the hardware requires an update bit
(bit 27) to be set so that the configuration takes effect and the
updated parameters can be correctly read back for the MBUS clock.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 91 ++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index f80db6ab1a98..c42619afb52e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -19,6 +19,7 @@
 #include "ccu_common.h"
 
 #include "ccu_div.h"
+#include "ccu_mp.h"
 #include "ccu_mult.h"
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
@@ -69,6 +70,16 @@ static const struct clk_hw *pll_ref_hws[] = {
 	&pll_ref_clk.common.hw
 };
 
+/*
+ * There is a non-software-configurable mux selecting between the DCXO and the
+ * PLL_REF in hardware, whose output is fed to the sys-24M clock. Although both
+ * sys-24M and pll-ref are fixed at 24 MHz, define a 1:1 fixed factor clock to
+ * provide logical separation:
+ * - pll-ref is dedicated to feeding other PLLs
+ * - sys-24M serves as reference clock for downstream functional modules
+ */
+static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
+
 #define SUN60I_A733_PLL_DDR_REG		0x020
 static struct ccu_nkmp pll_ddr_clk = {
 	.enable		= BIT(27),
@@ -375,6 +386,73 @@ static SUNXI_CCU_M_HWS(pll_de_4x_clk, "pll-de-4x", pll_de_hws,
 static SUNXI_CCU_M_HWS(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
 		       SUN60I_A733_PLL_DE_REG, 16, 3, 0);
 
+/**************************************************************************
+ *                           bus clocks                                   *
+ **************************************************************************/
+
+static const struct clk_parent_data ahb_apb_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static const struct clk_parent_data apb_uart_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x538,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 0);
+
+static const struct clk_parent_data trace_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(trace_clk, "trace", trace_parents, 0x540,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 BIT(31),	/* gate */
+				 0);
+
+static const struct clk_parent_data mbus_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_npu_clk.common.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588,
+					    0, 5,	/* M */
+					    0, 0,	/* no P */
+					    24, 3,	/* mux */
+					    BIT(31),	/* gate */
+					    CLK_IS_CRITICAL,
+					    CCU_FEATURE_UPDATE_BIT);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -411,11 +489,18 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&pll_de_12x_clk.common,
 	&pll_de_4x_clk.common,
 	&pll_de_3x_clk.common,
+	&ahb_clk.common,
+	&apb0_clk.common,
+	&apb1_clk.common,
+	&apb_uart_clk.common,
+	&trace_clk.common,
+	&mbus_clk.common,
 };
 
 static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 	.hws	= {
 		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
+		[CLK_SYS_24M]		= &sys_24M_clk.hw,
 		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
 		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
 		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
@@ -457,6 +542,12 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_PLL_DE_12X]	= &pll_de_12x_clk.common.hw,
 		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
 		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
+		[CLK_TRACE]		= &trace_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
 	},
 	.num	= CLK_FANOUT3 + 1,
 };

-- 
2.54.0


