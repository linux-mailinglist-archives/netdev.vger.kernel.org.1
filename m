Return-Path: <netdev+bounces-220252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751EB45130
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0268A1887D1E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B42749D9;
	Fri,  5 Sep 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bSV46Omb"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FA1E7C03;
	Fri,  5 Sep 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060436; cv=none; b=jEYChWuZ//IAEOPa85Wis5ZrlbV205cWJgpRuP3Ss/fC0Yw1RI40T0Hqd1ndpSHvgKaxqS43gLs6l6GdSHS8WmGqM0z8ufFVMTmnaqwLJ7qFQ/kblcgjFawJlblkJW3zfr1fu10P2FJXRWpSJj1FTs4azFZJwxBIHAjaZWkR/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060436; c=relaxed/simple;
	bh=fvvYld9Sx9cpIAFh8bm7RCs6V/pbPldioba2BeMv12M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FO3pawujmLZyz2QExvKVtfBdRrgj8jaqEZSbhFb/jsk8T8qcFEiovHKoxR/5CxrY4keI+v99vnyCDqlAxI7L9EHjDnVSN7vbqJr0Z7j20jzWS3hy88Yed+gQ3U4FNbUw2DfRi3nQ4aqiS3+BnBa1m4fkIKNwaJzjjMXP2fH2BL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bSV46Omb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757060432;
	bh=fvvYld9Sx9cpIAFh8bm7RCs6V/pbPldioba2BeMv12M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bSV46OmbR79MUBmJf7WLPrjpuI4dxMHMZCck6lkSMnpZs5Hu1Z16X4HFBJwK0GUed
	 yhOP5nFISWI6gijaY44mBWj/0p9l/O3DGrYPyBg5AG1YWdkl7RTxmRGJ5BRBvhPHQy
	 Y8qS12VxhJel6zXWINhu9qE0TVhHO7PbLis80o2jjW6AtnnU671TYKKjyOzpqQmPrJ
	 Prod7n+vw0l/LLFh+VqEF4UHncN6Md4cspu1ybuJ4lhIf1Hlq1IViDJOmnAQMatHpP
	 nqU51czJpWNtrsQx8rD1HTwcAqqLBFoP9Y6AhZqKCXSp92H0Lv2MSleg6SzY3Egcvh
	 tZS1+8sULb3iQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF44917E0A29;
	Fri,  5 Sep 2025 10:20:31 +0200 (CEST)
Message-ID: <4a37f32e-2f30-468b-98f4-b68bcf8e85f1@collabora.com>
Date: Fri, 5 Sep 2025 10:20:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/27] clk: mediatek: Add MT8196 vlpckgen clock support
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-14-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829091913.131528-14-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:18, Laura Nao ha scritto:
> Add support for the MT8196 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/clk/mediatek/Makefile              |   2 +-
>   drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 729 +++++++++++++++++++++
>   2 files changed, 730 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index c415453e02fd..031e7ac38804 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -151,7 +151,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) += clk-mt8195-venc.o
>   obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) += clk-mt8195-vpp0.o clk-mt8195-vpp1.o
>   obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) += clk-mt8195-wpe.o
>   obj-$(CONFIG_COMMON_CLK_MT8196) += clk-mt8196-apmixedsys.o clk-mt8196-topckgen.o \
> -				   clk-mt8196-topckgen2.o
> +				   clk-mt8196-topckgen2.o clk-mt8196-vlpckgen.o
>   obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365-apmixedsys.o clk-mt8365.o
>   obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
>   obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> new file mode 100644
> index 000000000000..c38d1e80a5ba
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
> @@ -0,0 +1,729 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    Guangjie Song <guangjie.song@mediatek.com>
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    Laura Nao <laura.nao@collabora.com>
> + */

..snip..

> +
> +static const char * const vlp_noc_vlp_parents[] = {
> +	"clk26m",
> +	"osc_d20",
> +	"mainpll_d9"
> +};
> +
> +static const char * const vlp_audio_h_parents[] = {
> +	"clk26m",

Please remove clk26m from this list (and from engen1/2/intbus).
We shall either use vlp_clk26m or clk26m directly - and I suspect that the VLP
specific 26m one is there for a reason.

What I'm not sure of is whether vlp_clk26m is really parented to clk26m or if it
is an additional internal crystal, but let's be cautious for now and keep the
parenting.

> +	"vlp_clk26m",
> +	"vlp_apll1",
> +	"vlp_apll2"
> +};
> +
> +static const char * const vlp_aud_engen1_parents[] = {
> +	"clk26m",
> +	"vlp_clk26m",
> +	"apll1_d8",
> +	"apll1_d4"
> +};
> +
> +static const char * const vlp_aud_engen2_parents[] = {
> +	"clk26m",
> +	"vlp_clk26m",
> +	"apll2_d8",
> +	"apll2_d4"
> +};
> +
> +static const char * const vlp_aud_intbus_parents[] = {
> +	"clk26m",
> +	"vlp_clk26m",
> +	"mainpll_d7_d4",
> +	"mainpll_d4_d4"
> +};
> +
> +static const u8 vlp_aud_parent_index[] = { 1, 2, 3 };

... of course, this index list doesn't match the parents list, so this will
break all of the clocks above because you're selecting wrong index in HW and
ignoring the last entry as well, producing a clock rate mismatch.

Once the clk26m is dropped from the names list, though, this index list becomes
valid.

After fixing:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



