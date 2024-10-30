Return-Path: <netdev+bounces-140420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F39B661E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6130E281F80
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1A1F80B6;
	Wed, 30 Oct 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r41tJhqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0491F80AC;
	Wed, 30 Oct 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298896; cv=none; b=Xvay2cqnInV0bRAMaiNnFMlKmklLFj/MmSZ7YJrBTKGhfn6P+ANC08hhmqq6JYCxSsFOrtXEC6G+ogLroSeKJVOufxrJ9zndCvKxjvgCrRxZ60QxyKofKzlVrdOoFTa+5+uKFCZDyMNGHW+F+4mJFGT8UXsfBCCILaYeA5Q0+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298896; c=relaxed/simple;
	bh=0voffoZR/9yLaMs/QSdN1vbgkVtNAlW/4s6JXHFS/kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ5k8HCrdMd1YklSl7F53x3F1mY3bEXnUzIMMIy8bZ5hk7dJACmFQDrZRj74E/T0yYp/MEX+q8x+MnqjINaMaqz7RwnM5aUPxO5VRdUZx2Ja/WpLeUcna92VTr6XWbDlDxRZQqDR+Zrwr06Ga5dnhhMwqpwuGHMfX60M6RqSlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r41tJhqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1590C4CED4;
	Wed, 30 Oct 2024 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730298896;
	bh=0voffoZR/9yLaMs/QSdN1vbgkVtNAlW/4s6JXHFS/kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r41tJhqUW6DD96Wl0aBg/zf4q11RRPUGIFS4KCQuZ5GvgcbkB1legnQCZR7CmQivt
	 kpdeAgWL1AwhZHnt81AQSlkQKIVw9fudU8NwiAgyxU64TP+bkuuJg9hO2WafrP0FqE
	 by+WYOn+TpXNBQfEiJImlxVJIIHUJxasGett6MUf+3WaI/Wo+dh+kfxgY1nA2SlbmK
	 OrT0/Jl4+thA5gLxH8lakeWYmWrLKyY0tHRzp3RRifeB4qSuqwIDg3az/kI5VNTz1f
	 TZkeRhUrzP5GouNG17FBLwpE6hgK9dVrE/MXZwKB+rVgwHu87wsXsDw3lnoyZ2aCY5
	 CAO/F2pwm5/xg==
Message-ID: <299bd27b-b5bd-492a-9873-447329e60b67@kernel.org>
Date: Wed, 30 Oct 2024 15:34:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clk: agilex5: Add Agilex5 clock bindings
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-0-e29e57980398@pengutronix.de>
 <20241030-v6-12-topic-socfpga-agilex5-clk-v1-1-e29e57980398@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-1-e29e57980398@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 13:02, Steffen Trumtrar wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add Intel SoCFPGA Agilex5 clock definition.

Where is the binding? I see only clock IDs. Your commit msg should
explain such unusual cases.

> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  include/dt-bindings/clock/agilex5-clock.h | 100 ++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/agilex5-clock.h b/include/dt-bindings/clock/agilex5-clock.h

Filename must match compatible.

> new file mode 100644
> index 0000000000000000000000000000000000000000..661bc8b649adfd6c3ae75dcbaff5dea331f0be52
> --- /dev/null
> +++ b/include/dt-bindings/clock/agilex5-clock.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

> +/*
> + * Copyright (C) 2022, Intel Corporation

Or if you cannot relicense just create your own binding header.

> + */
> +
> +#ifndef __AGILEX5_CLOCK_H
> +#define __AGILEX5_CLOCK_H
> +
> +/* fixed rate clocks */
> +#define AGILEX5_OSC1			0
> +#define AGILEX5_CB_INTOSC_HS_DIV2_CLK	1
> +#define AGILEX5_CB_INTOSC_LS_CLK	2
> +#define AGILEX5_F2S_FREE_CLK		3
> +
> +/* PLL clocks */
> +#define AGILEX5_MAIN_PLL_CLK		4
> +#define AGILEX5_MAIN_PLL_C0_CLK		5
> +#define AGILEX5_MAIN_PLL_C1_CLK		6
> +#define AGILEX5_MAIN_PLL_C2_CLK		7
> +#define AGILEX5_MAIN_PLL_C3_CLK		8
> +#define AGILEX5_PERIPH_PLL_CLK		9
> +#define AGILEX5_PERIPH_PLL_C0_CLK	10
> +#define AGILEX5_PERIPH_PLL_C1_CLK	11
> +#define AGILEX5_PERIPH_PLL_C2_CLK	12
> +#define AGILEX5_PERIPH_PLL_C3_CLK	13
> +#define AGILEX5_CORE0_FREE_CLK		14
> +#define AGILEX5_CORE1_FREE_CLK		15
> +#define AGILEX5_CORE2_FREE_CLK		16
> +#define AGILEX5_CORE3_FREE_CLK		17
> +#define AGILEX5_DSU_FREE_CLK		18
> +#define AGILEX5_BOOT_CLK		19
> +
> +/* fixed factor clocks */
> +#define AGILEX5_L3_MAIN_FREE_CLK	20
> +#define AGILEX5_NOC_FREE_CLK		21
> +#define AGILEX5_S2F_USR0_CLK		22
> +#define AGILEX5_NOC_CLK			23
> +#define AGILEX5_EMAC_A_FREE_CLK		24
> +#define AGILEX5_EMAC_B_FREE_CLK		25
> +#define AGILEX5_EMAC_PTP_FREE_CLK	26
> +#define AGILEX5_GPIO_DB_FREE_CLK	27
> +#define AGILEX5_S2F_USER0_FREE_CLK	28
> +#define AGILEX5_S2F_USER1_FREE_CLK	29
> +#define AGILEX5_PSI_REF_FREE_CLK	30
> +#define AGILEX5_USB31_FREE_CLK		31
> +
> +/* Gate clocks */
> +#define AGILEX5_CORE0_CLK		32
> +#define AGILEX5_CORE1_CLK		33
> +#define AGILEX5_CORE2_CLK		34
> +#define AGILEX5_CORE3_CLK		35
> +#define AGILEX5_MPU_CLK			36
> +#define AGILEX5_MPU_PERIPH_CLK		37
> +#define AGILEX5_MPU_CCU_CLK		38
> +#define AGILEX5_L4_MAIN_CLK		39
> +#define AGILEX5_L4_MP_CLK		40
> +#define AGILEX5_L4_SYS_FREE_CLK		41
> +#define AGILEX5_L4_SP_CLK		42
> +#define AGILEX5_CS_AT_CLK		43
> +#define AGILEX5_CS_TRACE_CLK		44
> +#define AGILEX5_CS_PDBG_CLK		45
> +#define AGILEX5_EMAC1_CLK		47
> +#define AGILEX5_EMAC2_CLK		48
> +#define AGILEX5_EMAC_PTP_CLK		49
> +#define AGILEX5_GPIO_DB_CLK		50
> +#define AGILEX5_S2F_USER0_CLK		51
> +#define AGILEX5_S2F_USER1_CLK		52
> +#define AGILEX5_PSI_REF_CLK		53
> +#define AGILEX5_USB31_SUSPEND_CLK	54
> +#define AGILEX5_EMAC0_CLK		46
> +#define AGILEX5_USB31_BUS_CLK_EARLY	55
> +#define AGILEX5_USB2OTG_HCLK		56
> +#define AGILEX5_SPIM_0_CLK		57
> +#define AGILEX5_SPIM_1_CLK		58
> +#define AGILEX5_SPIS_0_CLK		59
> +#define AGILEX5_SPIS_1_CLK		60
> +#define AGILEX5_DMA_CORE_CLK		61
> +#define AGILEX5_DMA_HS_CLK		62
> +#define AGILEX5_I3C_0_CORE_CLK		63
> +#define AGILEX5_I3C_1_CORE_CLK		64
> +#define AGILEX5_I2C_0_PCLK		65
> +#define AGILEX5_I2C_1_PCLK		66
> +#define AGILEX5_I2C_EMAC0_PCLK		67
> +#define AGILEX5_I2C_EMAC1_PCLK		68
> +#define AGILEX5_I2C_EMAC2_PCLK		69
> +#define AGILEX5_UART_0_PCLK		70
> +#define AGILEX5_UART_1_PCLK		71
> +#define AGILEX5_SPTIMER_0_PCLK		72
> +#define AGILEX5_SPTIMER_1_PCLK		73
> +#define AGILEX5_DFI_CLK			74
> +#define AGILEX5_NAND_NF_CLK		75
> +#define AGILEX5_NAND_BCH_CLK		76
> +#define AGILEX5_SDMMC_SDPHY_REG_CLK	77
> +#define AGILEX5_SDMCLK			78
> +#define AGILEX5_SOFTPHY_REG_PCLK	79
> +#define AGILEX5_SOFTPHY_PHY_CLK		80
> +#define AGILEX5_SOFTPHY_CTRL_CLK	81
> +#define AGILEX5_NUM_CLKS		82

Drop, not a binding.

> +
> +#endif	/* __AGILEX5_CLOCK_H */
> 

Best regards,
Krzysztof


