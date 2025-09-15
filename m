Return-Path: <netdev+bounces-222978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8AB5766B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA28163DF3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE12FC86B;
	Mon, 15 Sep 2025 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OjMAQCK/"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A32FC03B;
	Mon, 15 Sep 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932387; cv=none; b=bybrXpZJsGk3z3Q8PjM4Z6ymrG+hmPKzV9k14p2XMPkDhDh8oQjDADl9RgtmJZMBmNJxJAWaCBiya4k0Cwxcu2DgahKQe6pqmn9fvVsxMFzukaEGmGByMTssO2q5IkZXZO6aHu6Bzg6Jb5/nrvGabY4LxeVnO1W5buK4P+SXf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932387; c=relaxed/simple;
	bh=jBrXosrEm0ufxE9d6vgC0d6AOZqOTBjfpGs+BYCBuG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JubSvzZhp/em8Py3obeCEZ2uNm2X1JFSXMsk7L++j8lZ0ois5uZ5n0CzVkVMozX+VqjJ6VYMw2ppIkK8/EjgptkGQLfpz1aNkZcxoqmjSY+NyESvFA6GO3fauyFrOP+liDStI7MLrSe2y0VvNZRQZW9hDdP4xCTUf3GojY8rfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OjMAQCK/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757932384;
	bh=jBrXosrEm0ufxE9d6vgC0d6AOZqOTBjfpGs+BYCBuG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OjMAQCK/+gG+8jCO5AoowfuI++dUaRvWFld0urxeYgovi0jkDMe5Hkvib9GMsAoKB
	 so1ns4TynJKzquBxFeLk+lGtZ/wj5YqsJMDLQlzbAw4n8Ksu5tAEBmnwghPdTHZ2OP
	 OFp8Kpmgf3UaRNETufLr6u9k91pQVvvCCxiju/lEFiSae9B1TKBQsBAsKTlKaviL65
	 24Rtmz0d9GAcsrMZDj6sCieAaQnU8nBf670lpSR2bo4itx3HxxyXhhV6e0xwMgxILt
	 0AeHNx8nfeBGj9hpaLXRdM+xVX8TT6Hm3bR990osPafCN/VHxc997xHTHb02oADDZV
	 whNUksv/BgHgA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E3AD17E107A;
	Mon, 15 Sep 2025 12:33:03 +0200 (CEST)
Message-ID: <db803bd3-4e7d-4aa2-bdd1-6e0b14812c03@collabora.com>
Date: Mon, 15 Sep 2025 12:33:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/27] clk: mediatek: Add MT8196 mdpsys clock support
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com,
 guangjie.song@mediatek.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-20-laura.nao@collabora.com>
 <0e6592b7-6f6d-4291-992c-ff321c920381@collabora.com>
 <CAGXv+5GFaudGqm4C9CY-_spiXcyWk7OvWHTdkehsyrV4sO1Ndw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5GFaudGqm4C9CY-_spiXcyWk7OvWHTdkehsyrV4sO1Ndw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/09/25 10:53, Chen-Yu Tsai ha scritto:
> On Fri, Sep 5, 2025 at 4:39 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 29/08/25 11:19, Laura Nao ha scritto:
>>> Add support for the MT8196 mdpsys clock controller, which provides clock
>>> gate control for MDP.
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>>    drivers/clk/mediatek/Kconfig             |   7 +
>>>    drivers/clk/mediatek/Makefile            |   1 +
>>>    drivers/clk/mediatek/clk-mt8196-mdpsys.c | 186 +++++++++++++++++++++++
>>>    3 files changed, 194 insertions(+)
>>>    create mode 100644 drivers/clk/mediatek/clk-mt8196-mdpsys.c
>>>
>>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>>> index 8e5cdae80748..68ac08cf8e82 100644
>>> --- a/drivers/clk/mediatek/Kconfig
>>> +++ b/drivers/clk/mediatek/Kconfig
>>> @@ -1024,6 +1024,13 @@ config COMMON_CLK_MT8196_MCUSYS
>>>        help
>>>          This driver supports MediaTek MT8196 mcusys clocks.
>>>
>>> +config COMMON_CLK_MT8196_MDPSYS
>>> +     tristate "Clock driver for MediaTek MT8196 mdpsys"
>>> +     depends on COMMON_CLK_MT8196
>>> +     default COMMON_CLK_MT8196
>>> +     help
>>> +       This driver supports MediaTek MT8196 mdpsys clocks.
>>> +
>>>    config COMMON_CLK_MT8196_PEXTPSYS
>>>        tristate "Clock driver for MediaTek MT8196 pextpsys"
>>>        depends on COMMON_CLK_MT8196
>>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>>> index 46358623c3e5..d2d8bc43e45b 100644
>>> --- a/drivers/clk/mediatek/Makefile
>>> +++ b/drivers/clk/mediatek/Makefile
>>> @@ -155,6 +155,7 @@ obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o
>>>                                   clk-mt8196-peri_ao.o
>>>    obj-$(CONFIG_COMMON_CLK_MT8196_IMP_IIC_WRAP) += clk-mt8196-imp_iic_wrap.o
>>>    obj-$(CONFIG_COMMON_CLK_MT8196_MCUSYS) += clk-mt8196-mcu.o
>>> +obj-$(CONFIG_COMMON_CLK_MT8196_MDPSYS) += clk-mt8196-mdpsys.o
>>>    obj-$(CONFIG_COMMON_CLK_MT8196_PEXTPSYS) += clk-mt8196-pextp.o
>>>    obj-$(CONFIG_COMMON_CLK_MT8196_UFSSYS) += clk-mt8196-ufs_ao.o
>>>    obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
>>> diff --git a/drivers/clk/mediatek/clk-mt8196-mdpsys.c b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
>>> new file mode 100644
>>> index 000000000000..a46b1627f1f3
>>> --- /dev/null
>>> +++ b/drivers/clk/mediatek/clk-mt8196-mdpsys.c
>>> @@ -0,0 +1,186 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2025 MediaTek Inc.
>>> + *                    Guangjie Song <guangjie.song@mediatek.com>
>>> + * Copyright (c) 2025 Collabora Ltd.
>>> + *                    Laura Nao <laura.nao@collabora.com>
>>> + */
>>> +#include <dt-bindings/clock/mediatek,mt8196-clock.h>
>>> +
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#include "clk-gate.h"
>>> +#include "clk-mtk.h"
>>> +
>>> +static const struct mtk_gate_regs mdp0_cg_regs = {
>>> +     .set_ofs = 0x104,
>>> +     .clr_ofs = 0x108,
>>> +     .sta_ofs = 0x100,
>>> +};
>>> +
>>> +static const struct mtk_gate_regs mdp1_cg_regs = {
>>> +     .set_ofs = 0x114,
>>> +     .clr_ofs = 0x118,
>>> +     .sta_ofs = 0x110,
>>> +};
>>> +
>>> +static const struct mtk_gate_regs mdp2_cg_regs = {
>>> +     .set_ofs = 0x124,
>>> +     .clr_ofs = 0x128,
>>> +     .sta_ofs = 0x120,
>>> +};
>>> +
>>> +#define GATE_MDP0(_id, _name, _parent, _shift) {     \
>>> +             .id = _id,                              \
>>> +             .name = _name,                          \
>>> +             .parent_name = _parent,                 \
>>> +             .regs = &mdp0_cg_regs,                  \
>>> +             .shift = _shift,                        \
>>> +             .flags = CLK_OPS_PARENT_ENABLE,         \
>>
>> Why would MDP0 and MDP2 be different, as in why would MDP1 be so special to not
>> need CLK_OPS_PARENT_ENABLE while the others do?
>>
>> Either they all do, or they all don't.
>>
>> I guess they all don't, but I'm not sure how you tested that at all, since the
>> only way to test this is downstream (and upstream will very likely be different
>> from that).
>>
>> Even though I think they don't need that - please add back CLK_OPS_PARENT_ENABLE
>> to GATE_MDP1 to be safe, as in (all) MediaTek SoCs the multimedia subsystem is
>> kinda separate from the rest.
> 
> That kind of doesn't fly since the parent of mdp_f26m is clk26m, not the
> mdp clock. So either this block doesn't need a clock for register access
> or this clock is going to be broken.
> 
> This is why I raised the question about the validity of the flag in the
> first place.
> 
>> +       GATE_MDP1(CLK_MDP_F26M, "mdp_f26m", "clk26m", 27),
> 
>> Once MT8196 MDP support is upstreamed, we will be able to run a number of tests
>> to evaluate whether this flag is really needed or not.
>>
>> After all, if it turns out we can remove it, it's going to be a 3 lines patch,
>> not a big deal.
> 
> That also works. Though IMO it makes the error harder to notice.
> 

Okay, I understand your point.

Let's keep CLK_OPS_PARENT_ENABLE out of MDP1.

Cheers,
Angelo



