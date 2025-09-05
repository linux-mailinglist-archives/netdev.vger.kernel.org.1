Return-Path: <netdev+bounces-220270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B49B451B7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D378A630AB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66E27703A;
	Fri,  5 Sep 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cU8OmHth"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF71A9FB3;
	Fri,  5 Sep 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061594; cv=none; b=GNEBpA5nYqkY01luei5brHZhqamXpC1a9P0+cSpqnaxikniTgFvAi2OrH0bOO+XI6hFkB6TTMi2AD7DabpiAouIzw7b6GSaBfYax4p2z25QBBJq/QqRfqJfDaupw+D0yqmCkinAb2elYAZA62AONMQ5ASF/uZVjrVKOjEh5i1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061594; c=relaxed/simple;
	bh=i8Fqq1+YDvq6ltSnkYjxfh2RSJGrjvrk0LThUF973iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LblqDx6n0z+dY+gM2xFdwNNthNxhOrY2Br/TfMCYw0vp705ZDykHo/G/IB2iKjFUpMqelWfhhwBPlC8CuLFwix19fFtZFanJe7fUcxwfU1UYvvwBOvUY5bVqFpzmphqGO1xGCv/72ogcoYHwmJENbJtLrH0AztBBMkEN0sEgt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cU8OmHth; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757061590;
	bh=i8Fqq1+YDvq6ltSnkYjxfh2RSJGrjvrk0LThUF973iI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cU8OmHth28mrcjuLguyHAJPef4lQL1E9y4lP0VHmKNYGAq0w9CT/57UWJI/m9RmKs
	 Cus4X1hEg5M6VhZzPj8NeWVjCh/yPE1FZqFUOEIWk90K03czt29TVUdzFTfW4vX6DE
	 i1qY8F5nfaebJsVDW7qALDJNLE6YtmBvQP0geECUy5VhEjzy0Xx6BVwaklHqFE8OYl
	 6MGrn3j6f4G7pmrff+4zjHJw6HZqQya4ZuI4EwRL1R9udri661xZ7ERdn4tO55+izB
	 25TDJzEh0fNJiDfXnqNXtu0oxziN7fqOeFlAUWw4iZ7SUls/l79PkJ3HQXNESayhCJ
	 OyVA+SLnQlwrA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF09517E0E20;
	Fri,  5 Sep 2025 10:39:49 +0200 (CEST)
Message-ID: <0e6592b7-6f6d-4291-992c-ff321c920381@collabora.com>
Date: Fri, 5 Sep 2025 10:39:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/27] clk: mediatek: Add MT8196 mdpsys clock support
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-20-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829091913.131528-20-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:19, Laura Nao ha scritto:
> Add support for the MT8196 mdpsys clock controller, which provides clock
> gate control for MDP.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/clk/mediatek/Kconfig             |   7 +
>   drivers/clk/mediatek/Makefile            |   1 +
>   drivers/clk/mediatek/clk-mt8196-mdpsys.c | 186 +++++++++++++++++++++++
>   3 files changed, 194 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 8e5cdae80748..68ac08cf8e82 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1024,6 +1024,13 @@ config COMMON_CLK_MT8196_MCUSYS
>   	help
>   	  This driver supports MediaTek MT8196 mcusys clocks.
>   
> +config COMMON_CLK_MT8196_MDPSYS
> +	tristate "Clock driver for MediaTek MT8196 mdpsys"
> +	depends on COMMON_CLK_MT8196
> +	default COMMON_CLK_MT8196
> +	help
> +	  This driver supports MediaTek MT8196 mdpsys clocks.
> +
>   config COMMON_CLK_MT8196_PEXTPSYS
>   	tristate "Clock driver for MediaTek MT8196 pextpsys"
>   	depends on COMMON_CLK_MT8196
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 46358623c3e5..d2d8bc43e45b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -155,6 +155,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
>   				   clk-mt8196-peri_ao.o
>   obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
>   obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
> +obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
>   obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
>   obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
>   obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-mdpsys.c b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
> new file mode 100644
> index 000000000000..a46b1627f1f3
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    Guangjie Song <guangjie.song@mediatek.com>
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    Laura Nao <laura.nao@collabora.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +static const struct mtk_gate_regs mdp0_cg_regs = {
> +	.set_ofs = 0x104,
> +	.clr_ofs = 0x108,
> +	.sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs mdp1_cg_regs = {
> +	.set_ofs = 0x114,
> +	.clr_ofs = 0x118,
> +	.sta_ofs = 0x110,
> +};
> +
> +static const struct mtk_gate_regs mdp2_cg_regs = {
> +	.set_ofs = 0x124,
> +	.clr_ofs = 0x128,
> +	.sta_ofs = 0x120,
> +};
> +
> +#define GATE_MDP0(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mdp0_cg_regs,			\
> +		.shift = _shift,			\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\

Why would MDP0 and MDP2 be different, as in why would MDP1 be so special to not
need CLK_OPS_PARENT_ENABLE while the others do?

Either they all do, or they all don't.

I guess they all don't, but I'm not sure how you tested that at all, since the
only way to test this is downstream (and upstream will very likely be different
from that).

Even though I think they don't need that - please add back CLK_OPS_PARENT_ENABLE
to GATE_MDP1 to be safe, as in (all) MediaTek SoCs the multimedia subsystem is
kinda separate from the rest.

Once MT8196 MDP support is upstreamed, we will be able to run a number of tests
to evaluate whether this flag is really needed or not.

After all, if it turns out we can remove it, it's going to be a 3 lines patch,
not a big deal.

> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +	}
> +
> +#define GATE_MDP1(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mdp1_cg_regs,			\
> +		.shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +	}
> +
> +#define GATE_MDP2(_id, _name, _parent, _shift) {	\
> +		.id = _id,				\
> +		.name = _name,				\
> +		.parent_name = _parent,			\
> +		.regs = &mdp2_cg_regs,			\
> +		.shift = _shift,			\
> +		.flags = CLK_OPS_PARENT_ENABLE,		\
> +		.ops = &mtk_clk_gate_ops_setclr,	\
> +	}
> +

..snip..

> +
> +static const struct mtk_clk_desc mdp_mcd = {
> +	.clks = mdp_clks,
> +	.num_clks = ARRAY_SIZE(mdp_clks),
> +	.need_runtime_pm = true,
> +};
> +
> +static const struct of_device_id of_match_clk_mt8196_mdpsys[] = {
> +	{ .compatible = "mediatek,mt8196-mdpsys1", .data = &mdp1_mcd },
> +	{ .compatible = "mediatek,mt8196-mdpsys0", .data = &mdp_mcd },

0 comes before 1, swap those entries please.

After applying the proposed fixes

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_mdpsys);
> +
> +static struct platform_driver clk_mt8196_mdpsys_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt8196-mdpsys",
> +		.of_match_table = of_match_clk_mt8196_mdpsys,
> +	},
> +};
> +module_platform_driver(clk_mt8196_mdpsys_drv);
> +
> +MODULE_DESCRIPTION("MediaTek MT8196 Multimedia Data Path clocks driver");
> +MODULE_LICENSE("GPL");


