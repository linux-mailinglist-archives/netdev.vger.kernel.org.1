Return-Path: <netdev+bounces-301515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9vfFJigKO2qBPAgAu9opvQ
	(envelope-from <netdev+bounces-301515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6A6BA6FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=G5flbO5J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301515-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301515-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3277A300DDF9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D271388E59;
	Tue, 23 Jun 2026 22:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB43371D11;
	Tue, 23 Jun 2026 22:35:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254116; cv=none; b=lHwd2H3OzYHcwexhBOOpcu/mdx9660Wfxm2okjoKUZDbXzNHuEhYKGchJA6DTFtVhKErL4CQfg6X7Iu3y5HM7ePNol3j+9EJuqcq1fHSsxJG6sGPs9nIEFE3cJ0vhV13Omyuy7cTT2VAh6cDVHtG7tE323j4qy8yNRzf9aYgP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254116; c=relaxed/simple;
	bh=SRPt/Z1N9zfS5tVZtHc1Ym/DJpa09C6NIWLnEJarli8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/qxonJ7W5O8R0pMS+u3td0044Ai2mM1pWRi5PVYvX1bCLfzcoBvevMOggYdOjV2DAtdCbHL/qocuOIKVeMPzVOdqJkQwswlxmkgp+ZuZZ4yHkHttNEVHSsv+nqdOf3Nj4cUdd5i0vOCDci5pGgzRoaSzAXQWUiPs+PwI86Vtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G5flbO5J; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3EC1713;
	Tue, 23 Jun 2026 15:35:07 -0700 (PDT)
Received: from [10.43.8.246] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3D423F632;
	Tue, 23 Jun 2026 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782254112; bh=SRPt/Z1N9zfS5tVZtHc1Ym/DJpa09C6NIWLnEJarli8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G5flbO5JtjY2PHGG2ojKGXX8SqI+2MRfa+r6LYez6kIYWrMO5mYm3Z02byPITyVx5
	 yIv7eGXrRte6UNWeKzB1Oryv66h5vXQEk1IcivwwfWgcjoIuMI/XRYk4euGrcbvraI
	 pTYpub3JKKI8VTcq9p5Y59S2sQJTxCa6efj4jEfE=
Message-ID: <138b5b54-7e2a-45fd-9c3f-eb4b4e04d954@arm.com>
Date: Tue, 23 Jun 2026 23:35:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/8] clk: sunxi-ng: a733: Add bus clocks support
To: Junhui Liu <junhui.liu@pigmoral.tech>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
 <20260310-a733-clk-v1-5-36b4e9b24457@pigmoral.tech>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260310-a733-clk-v1-5-36b4e9b24457@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[pigmoral.tech,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andre.przywara@arm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.przywara@arm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pigmoral.tech:email,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CD6A6BA6FB

Hi,

On 3/10/26 08:33, Junhui Liu wrote:
> Add the essential bus clocks in the Allwinner A733 CCU, including AHB,
> APB0, APB1, APB_UART, NSI, and MBUS. These buses are necessary for many
> other functional modules. Additionally clocks such as trace, gic and
> cpu_peri are also added as they fall within the register address range
> of the bus clocks, even though they are not strictly bus clocks.
> 
> The MBUS clock is marked as critical to ensure the memory bus remains
> operational at all times. For the NSI and MBUS clocks, the hardware
> requires an update bit (bit 27) to be set so that the configuration
> takes effect and the updated parameters can be correctly read back.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>   drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 131 +++++++++++++++++++++++++++++++++
>   1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> index cf819504c51f..68457813dbbb 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> @@ -19,6 +19,7 @@
>   #include "ccu_common.h"
>   
>   #include "ccu_div.h"
> +#include "ccu_mp.h"
>   #include "ccu_mult.h"
>   #include "ccu_nkmp.h"
>   #include "ccu_nm.h"
> @@ -65,6 +66,16 @@ static const struct clk_hw *pll_ref_hws[] = {
>   	&pll_ref_clk.common.hw
>   };
>   
> +/*
> + * There is a non-software-configurable mux selecting between the DCXO and the
> + * PLL_REF in hardware, whose output is fed to the sys-24M clock. Although both
> + * sys-24M and pll-ref are fixed at 24 MHz, define a 1:1 fixed factor clock to
> + * provide logical separation:
> + * - pll-ref is dedicated to feeding other PLLs
> + * - sys-24M serves as reference clock for downstream functional modules
> + */
> +static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
> +
>   #define SUN60I_A733_PLL_DDR_REG		0x020
>   static struct ccu_nkmp pll_ddr_clk = {
>   	.enable		= BIT(27),
> @@ -371,6 +382,107 @@ static SUNXI_CCU_M_HWS(pll_de_4x_clk, "pll-de-4x", pll_de_hws,
>   static SUNXI_CCU_M_HWS(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
>   		       SUN60I_A733_PLL_DE_REG, 16, 3, 0);
>   
> +/**************************************************************************
> + *                           bus clocks                                   *
> + **************************************************************************/
> +
> +static const struct clk_parent_data ahb_apb_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
> +				 0, 5,		/* M */
> +				 24, 2,		/* mux */
> +				 0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
> +				 0, 5,		/* M */
> +				 24, 2,		/* mux */
> +				 0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
> +				 0, 5,		/* M */
> +				 24, 2,		/* mux */
> +				 0);
> +
> +static const struct clk_parent_data apb_uart_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x538,
> +				 0, 5,		/* M */
> +				 24, 3,		/* mux */
> +				 0);
> +
> +static const struct clk_parent_data trace_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .hw = &pll_periph0_300M_clk.hw },
> +	{ .hw = &pll_periph0_400M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(trace_clk, "trace", trace_parents, 0x540,
> +				 0, 5,		/* M */
> +				 24, 3,		/* mux */
> +				 BIT(31),	/* gate */
> +				 0);
> +
> +static const struct clk_parent_data gic_cpu_peri_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .fw_name = "losc" },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .hw = &pll_periph0_400M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gic_clk, "gic", gic_cpu_peri_parents, 0x560,

Do we really want to model the GIC clock? The A523 has one as well, as 
we don't describe it there. And while the GICv3 binding describes a 
clock property, the Linux driver completely ignores that.
So if I see this correctly, this clock would become unused, and would be 
turned off, killing the GIC? So we would at least need a CLK_IS_CRITICAL 
flag?

But it's a good reminder to lift this clock to something PLL based, in 
U-Boot's SPL, because I guess the 24MHz are rather slow.

> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(cpu_peri_clk, "cpu-peri", gic_cpu_peri_parents, 0x568,

What is this clock about? I don't see it referenced by any peripheral in 
the manual.

> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data nsi_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_ddr_clk.common.hw },
> +	{ .hw = &pll_periph0_800M_clk.common.hw },
> +	{ .hw = &pll_periph0_600M_clk.hw },
> +	{ .hw = &pll_periph0_480M_clk.common.hw },
> +	{ .hw = &pll_de_3x_clk.common.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(nsi_clk, "nsi", nsi_parents, 0x580,

Similar question like for the GIC: do we need this in the kernel, and do 
we need to prevent this from being turned off?

> +					    0, 5,	/* M */
> +					    0, 0,	/* no P */
> +					    24, 3,	/* mux */
> +					    BIT(31),	/* gate */
> +					    0, CCU_FEATURE_UPDATE_BIT);
> +
> +static const struct clk_parent_data mbus_parents[] = {
> +	{ .hw = &sys_24M_clk.hw },
> +	{ .hw = &pll_periph1_600M_clk.hw },
> +	{ .hw = &pll_ddr_clk.common.hw },
> +	{ .hw = &pll_periph1_480M_clk.common.hw },
> +	{ .hw = &pll_periph1_400M_clk.hw },
> +	{ .hw = &pll_npu_clk.common.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588,
> +					    0, 5,	/* M */
> +					    0, 0,	/* no P */
> +					    24, 3,	/* mux */
> +					    BIT(31),	/* gate */
> +					    CLK_IS_CRITICAL,
> +					    CCU_FEATURE_UPDATE_BIT);
> +
>   /*
>    * Contains all clocks that are controlled by a hardware register. They
>    * have a (sunxi) .common member, which needs to be initialised by the common
> @@ -407,11 +519,21 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
>   	&pll_de_clk.common,
>   	&pll_de_4x_clk.common,
>   	&pll_de_3x_clk.common,
> +	&ahb_clk.common,
> +	&apb0_clk.common,
> +	&apb1_clk.common,
> +	&apb_uart_clk.common,
> +	&trace_clk.common,
> +	&gic_clk.common,
> +	&cpu_peri_clk.common,
> +	&nsi_clk.common,
> +	&mbus_clk.common,
>   };
>   
>   static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   	.hws	= {
>   		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
> +		[CLK_SYS_24M]		= &sys_24M_clk.hw,
>   		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
>   		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
>   		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
> @@ -453,6 +575,15 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
>   		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
>   		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
>   		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
> +		[CLK_AHB]		= &ahb_clk.common.hw,
> +		[CLK_APB0]		= &apb0_clk.common.hw,
> +		[CLK_APB1]		= &apb1_clk.common.hw,
> +		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
> +		[CLK_TRACE]		= &trace_clk.common.hw,
> +		[CLK_GIC]		= &gic_clk.common.hw,
> +		[CLK_CPU_PERI]		= &cpu_peri_clk.common.hw,
> +		[CLK_NSI]		= &nsi_clk.common.hw,
> +		[CLK_MBUS]		= &mbus_clk.common.hw,
>   	},
>   	.num	= CLK_FANOUT3 + 1,
>   };
> 


