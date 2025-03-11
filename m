Return-Path: <netdev+bounces-174000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1671A5CF3D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8D87A9DCA
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28A263F3A;
	Tue, 11 Mar 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZe93aO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410D2AF06;
	Tue, 11 Mar 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721018; cv=none; b=t6OIcXavrxqXWIlZHRIZpiZtsOMNQSkzPPUcchfKE9rJkHPJwAw/L5cIgIpN3NF7sm3xAC52zXx5b13bLnupav3cvF8RI+7ThKn+3DCzecRxFVRH5PSHMu0w8sKoApZtoaGdXaAMHQmV70dQTqkVrraz7A90xW5pQaLqdz39WzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721018; c=relaxed/simple;
	bh=GNadl/hPij0aA2QQUPKghyK8uOIrk1I4OwxNZYiyEU8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IsCCjaQl/IF4MVOplb9QO1Wyq9TRDZVeoNOy+5Dyfk574vHiBX5x5gWEdoMCkFh3QNmfEyNMx3t6sp9zIhRwp4gTzs6pklQTgohgITXhLWDWwA/FZ0gNkHIhdMG/jEw7Ewm1xtabDwTHKwxvLVma3onzx6HWFurGFL3n0jSaDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZe93aO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBEC4CEE9;
	Tue, 11 Mar 2025 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721018;
	bh=GNadl/hPij0aA2QQUPKghyK8uOIrk1I4OwxNZYiyEU8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZZe93aO3px81A3zcWIAr9eQ/W/oGWvboCTlgMGyA11yqsiGCxM6e/QdNcQauFuCjE
	 0t95ubXuZ2qBPGkXZ5d8JDoTXXf3jbLs4ktgkinsHqew15tkc6xUl0OOk5OojxG4eM
	 ibIZLw62nYje7lRrzrYEmKmrwsO5DGNsE71y4vtig3IfrscCTAEUi+64FxW98hmCVv
	 FhMlYQCysaMY7kLIIggHo6TgcrwnJNsQ/pksB3BCGfcCO5erTT9qBzPengn7UB1pQF
	 ZnN1OZqbmRZzJcopQRSn8E5l5a326izMt1zwXquJ8CHg+D2Wc+8DYOxX81gGQBpUuR
	 Md7gJ+90KcMzA==
Message-ID: <aab786e8c168a6cb22886e28c5805e7d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250226232320.93791-3-inochiama@gmail.com>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-3-inochiama@gmail.com>
Subject: Re: [PATCH v3 2/2] clk: sophgo: Add clock controller support for SG2044 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Tue, 11 Mar 2025 12:23:35 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-02-26 15:23:19)
> diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk-sg2=
044.c
> new file mode 100644
> index 000000000000..b4c15746de77
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sg2044.c

Thanks for sticking with it. Some minor nits below but otherwise this
looks good to go.

> @@ -0,0 +1,2271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 clock controller Driver
> + *
> + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "clk-sg2044.h"
> +
> +#include <dt-bindings/clock/sophgo,sg2044-clk.h>
> +
[...]
> +
> +static unsigned long sg2044_pll_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct sg2044_pll *pll =3D hw_to_sg2044_pll(hw);
> +       u32 value;
> +       int ret;
> +
> +       ret =3D regmap_read(pll->top_syscon,
> +                         pll->syscon_offset + pll->pll.ctrl_offset + PLL=
_HIGH_CTRL_OFFSET,
> +                         &value);
> +       if (ret < 0)
> +               return 0;
> +
> +       return sg2044_pll_calc_rate(parent_rate,
> +                                   FIELD_GET(PLL_REFDIV_MASK, value),
> +                                   FIELD_GET(PLL_FBDIV_MASK, value),
> +                                   FIELD_GET(PLL_POSTDIV1_MASK, value),
> +                                   FIELD_GET(PLL_POSTDIV2_MASK, value));
> +}
> +
> +static bool pll_is_better_rate(unsigned long target, unsigned long now,
> +                              unsigned long best)
> +{
> +       return (target - now) < (target - best);

Is this more like abs_diff(target, now) < abs_diff(target, best)?

> +}
> +
> +
> +static int sg2044_pll_enable(struct sg2044_pll *pll, bool en)
> +{
> +       if (en) {
> +               if (sg2044_pll_poll_update(pll) < 0)
> +                       pr_warn("%s: fail to lock pll\n", clk_hw_get_name=
(&pll->common.hw));
> +
> +               return regmap_set_bits(pll->top_syscon,
> +                                      pll->syscon_offset + pll->pll.enab=
le_offset,
> +                                      BIT(pll->pll.enable_bit));
> +       } else {

Drop the else please.

> +               return regmap_clear_bits(pll->top_syscon,
> +                                        pll->syscon_offset + pll->pll.en=
able_offset,
> +                                        BIT(pll->pll.enable_bit));
> +       }
> +}
> +
[...]
> +
> +static u32 sg2044_div_get_reg_div(u32 reg, struct sg2044_div_internal *d=
iv)
> +{
> +       if ((reg & DIV_FACTOR_REG_SOURCE))
> +               return (reg >> div->shift) & clk_div_mask(div->width);
> +       else

Drop the else please.

> +               return div->initval =3D=3D 0 ? 1 : div->initval;
> +}
> +
> +
> +
[...]
> +
> +static const struct clk_parent_data clk_fpll0_parent[] =3D {
> +       { .hw =3D &clk_fpll0.common.hw },
> +};

If the only parent is a clk_hw pointer it's preferred to use struct
clk_init_data::parent_hws directly instead of clk_parent_data.

> +
> +static const struct clk_parent_data clk_fpll1_parent[] =3D {
> +       { .hw =3D &clk_fpll1.common.hw },
> +};
> +
[...]
> +                        CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> +                        80);
> +
> +static DEFINE_SG2044_DIV(CLK_DIV_PKA, clk_div_pka,
> +                        clk_fpll0_parent, 0,
> +                        0x0f0, 16, 8,
> +                        CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> +                        2);
> +
> +static const struct clk_parent_data clk_mux_ddr0_parents[] =3D {
> +       { .hw =3D &clk_div_ddr0_fixed.common.hw },
> +       { .hw =3D &clk_div_ddr0_main.common.hw },

Similarly, if the only parents are clk_hw pointers we should be using
struct clk_init_data::parent_hws.

> +};
> +
> +static DEFINE_SG2044_MUX(CLK_MUX_DDR0, clk_mux_ddr0,
> +
> +static struct sg2044_clk_common *sg2044_pll_commons[] =3D {
> +       &clk_fpll0.common,
[...]
> +       &clk_mpll5.common,
> +};
> +
> +static struct sg2044_clk_common *sg2044_div_commons[] =3D {
> +       &clk_div_ap_sys_fixed.common,
> +       &clk_div_ap_sys_main.common,
[...]
> +       &clk_div_pka.common,
> +};
> +
> +static struct sg2044_clk_common *sg2044_mux_commons[] =3D {
> +       &clk_mux_ddr0.common,
[..]
> +};
> +
> +static struct sg2044_clk_common *sg2044_gate_commons[] =3D {

Can these arrays be const?

> +       &clk_gate_ap_sys.common,
> diff --git a/drivers/clk/sophgo/clk-sg2044.h b/drivers/clk/sophgo/clk-sg2=
044.h
> new file mode 100644
> index 000000000000..bb69532fdf4f
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sg2044.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#ifndef _CLK_SOPHGO_SG2044_H_
> +#define _CLK_SOPHGO_SG2044_H_
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +

Please inline the contents of this file in the one C file that uses the
header.

> +#define PLL_LIMIT_FOUTVCO      0
> +#define PLL_LIMIT_FOUT         1
> +#define PLL_LIMIT_REFDIV       2
> +#define PLL_LIMIT_FBDIV                3
> +#define PLL_LIMIT_POSTDIV1     4
> +#define PLL_LIMIT_POSTDIV2     5
> +
> +#define for_each_pll_limit_range(_var, _limit) \
> +       for (_var =3D (_limit)->min; _var <=3D (_limit)->max; _var++)
> +
> +struct sg2044_clk_limit {
> +       u64 min;
> +       u64 max;
> +};
> +

