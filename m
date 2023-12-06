Return-Path: <netdev+bounces-54363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55B806C42
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFBFB20D67
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFC2D7AB;
	Wed,  6 Dec 2023 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R/jsCb+c"
X-Original-To: netdev@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E41730;
	Wed,  6 Dec 2023 02:38:42 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id CB93B660732A;
	Wed,  6 Dec 2023 10:38:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701859121;
	bh=j6FSYq/wllVqa38fLBlpKeDl1PwQcbOvVLOoOX0UBbM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=R/jsCb+crLicefguBjhSXx1mhP2GI7hlj0zO2u/FMxuvkISVnxmBdvV1vanKSwmhm
	 59aoYyl27HkFPeGTNKgXHf7LrPDGcLh6Y8KacgOAylkVSoqc2GqLGpeIQKl539mum2
	 GZZ1RxkZAiCZmKJne1SwuC26ccLZur4h1PkA+4uLCCaeq6TmfEj8bBD3ht77kvm/Px
	 RlPKBrKQX0eQLbulorYkQXgRter30Y4vHZ7qVJzP9852TVcal0cIP2Q3kPsmoQ/J3I
	 tizI9NHjpxn5J4TW3+4ccUfYPZBTMiCJYGAmh/Raj9bAqD071KohK8GHAh+wCNIlHY
	 JxSbyd157tTyQ==
Message-ID: <0ebce75d-0074-4128-b35e-e86ee3ee546b@collabora.com>
Date: Wed, 6 Dec 2023 11:38:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] clk: mediatek: Add pcw_chg_shift control
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jianhui Zhao <zhaojh329@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, "Garmin.Chang"
 <Garmin.Chang@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <40981d0bb722eb509628bcf82c31f632e4cf747a.1701823757.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/12/23 01:57, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Introduce pcw_chg_shfit control to optionally use that instead of the
> hardcoded PCW_CHG_MASK macro.
> This will needed for clocks on the MT7988 SoC.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use git --from ...
> v2: no changes
> 
>   drivers/clk/mediatek/clk-pll.c | 5 ++++-
>   drivers/clk/mediatek/clk-pll.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 513ab6b1b3229..9f08bc5d2a8a2 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -114,7 +114,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>   			pll->data->pcw_shift);
>   	val |= pcw << pll->data->pcw_shift;
>   	writel(val, pll->pcw_addr);
> -	chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
> +	if (pll->data->pcw_chg_shift)
> +		chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);
> +	else
> +		chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
>   	writel(chg, pll->pcw_chg_addr);
>   	if (pll->tuner_addr)
>   		writel(val + 1, pll->tuner_addr);
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index f17278ff15d78..d28d317e84377 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -44,6 +44,7 @@ struct mtk_pll_data {
>   	u32 pcw_reg;
>   	int pcw_shift;
>   	u32 pcw_chg_reg;
> +	int pcw_chg_shift;
>   	const struct mtk_pll_div_table *div_table;
>   	const char *parent_name;
>   	u32 en_reg;

Hmm... no, this is not the best at all and can be improved.

Okay, so, the situation here is that one or some PLL(s) on MT7988 have a different
PCW_CHG_MASK as far as I understand.

Situation here is:
  - Each PLL must be registered to clk-pll
  - Each driver declaring a PLL does exactly so
    - There's a function to register the PLL

You definitely don't want to add a conditional in pll_set_rate(): even though
this is technically not a performance path on the current SoCs (and will probably
never be), it's simply useless to have this (very small) overhead there.

The solution is to:
  - Change that pcw_chg_shift to an unsigned short int type (or u8, your call):
    you don't need 32 bits for this number, as the expected range of this member
    is [0-31], and this can be expressed in just 4 bits (u8 is the smallest though)
  - Add that to function mtk_clk_register_pll_ops()
  - Change mtk_pll_set_rate_regs() to always do
    chg = readl(pll->pcw_chg_addr) | BIT(pll->data->pcw_chg_shift);

Cheers,
Angelo

