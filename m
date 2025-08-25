Return-Path: <netdev+bounces-216476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86CB33FC3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5873BC6D1
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4FC1C6FE8;
	Mon, 25 Aug 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XxWTc/E5"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499851B040B;
	Mon, 25 Aug 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125663; cv=none; b=A5C+euO4kNrbyquy2Yw8z0gzV4C5ZyVbT5rzfaSECoYGgoQuYwbU4Yu1UwoiUJYXOJws4tAfZgb/5E4wrAX3g955JDTUqWBtY1Ur+MDgdWZY+i+Lr4Vpcr1+hJjglu/vJLId6JL8lTlJOdhanwaG00j9l26PWu7bRM6rh9P+syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125663; c=relaxed/simple;
	bh=DTT7025o6QZOA9whxQI3H5F2CGpujugULOrA7+jZGEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViVOuSTzgTedamFvTGImvEmDBZ1er6tB/HwFqllYV6KT/yaYRliuua7j9pFGzwow35kqSwoOx6E5k3oU8wSaw+2zLHdYEs5DOeNJdUhmX/IaWkzlVAAsYDVXU3OsgNnnwIs70eZQcOI7XEvXuf/BD+Y0zNAy3CLDnbkp8Gp9/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XxWTc/E5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756125659;
	bh=DTT7025o6QZOA9whxQI3H5F2CGpujugULOrA7+jZGEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxWTc/E5VW0OQ92f92pKw17Q3jfIUceMh07Qfy80KNq0z9U9rRY1PmnQ7RvWJ8QOA
	 k/RLPcz22lYDsI/+tpqx7W4JOpRl6l+svWld0mQk7h8Bi9Cd0C94j7oaHtkW3ISMBg
	 mBF3rYU1axmMRpzsHkyR0+y8vFIQB691g0lBYWEOVS8H0WUjFGmZ9Dvn9vwb1AfqoQ
	 OojGbnLeI1c+s0W7M+8HL2aJKr1rRVxttQILAwcPMJdnnyt9hC1S1JAutElkWWwOXt
	 aKagE4e71XnMYGrxdGDsvIf5M9Ipi3ty3FgTXuviUmeYsQKMqwmb19wsj8R/eM0yaa
	 D+/x4sLR478eA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:b1df:895a:e67b:5cd4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BDEC17E0523;
	Mon, 25 Aug 2025 14:40:58 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v4 02/27] clk: mediatek: clk-pll: Add ops for PLLs using set/clr regs and FENC
Date: Mon, 25 Aug 2025 14:39:52 +0200
Message-Id: <20250825123952.208448-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5Fnaict=9Agixn1vCrP3GkugaR3qEKmEYyYiXCGx8ZZ6w@mail.gmail.com>
References: <CAGXv+5Fnaict=9Agixn1vCrP3GkugaR3qEKmEYyYiXCGx8ZZ6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chen-Yu,

On 8/15/25 05:18, Chen-Yu Tsai wrote:
> On Tue, Aug 5, 2025 at 10:55 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> MT8196 uses a combination of set/clr registers to control the PLL
>> enable state, along with a FENC bit to check the preparation status.
>> Add new set of PLL clock operations with support for set/clr enable and
>> FENC status logic.
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/clk/mediatek/clk-pll.c | 42 +++++++++++++++++++++++++++++++++-
>>  drivers/clk/mediatek/clk-pll.h |  5 ++++
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
>> index 49ca25dd5418..8f46de77f42d 100644
>> --- a/drivers/clk/mediatek/clk-pll.c
>> +++ b/drivers/clk/mediatek/clk-pll.c
>> @@ -37,6 +37,13 @@ int mtk_pll_is_prepared(struct clk_hw *hw)
>>         return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
>>  }
>>
>> +static int mtk_pll_fenc_is_prepared(struct clk_hw *hw)
>> +{
>> +       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>> +
>> +       return readl(pll->fenc_addr) & pll->fenc_mask;
>
> Nits:
>
> I'd do a double-negate (!!) just to indicate that we only care about
> true or false.
>
> Also, why do we need to store fenc_mask instead of just shifting the bit
> here? Same goes for the register address. |pll| has the base address.
> Why do we need to pre-calculate it?
>
> The code is OK; it just seems a bit wasteful on memory.
>

Thanks for the heads up - since these are only used here for now, I
agree they’re not really adding value. I’ll drop fenc_mask and fenc_addr
in the next revision.

Best,

Laura

> Either way, this is
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
>> +}
>> +
>>  static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>>                 u32 pcw, int postdiv)
>>  {
>> @@ -274,6 +281,25 @@ void mtk_pll_unprepare(struct clk_hw *hw)
>>         writel(r, pll->pwr_addr);
>>  }
>>
>> +static int mtk_pll_prepare_setclr(struct clk_hw *hw)
>> +{
>> +       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>> +
>> +       writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
>> +
>> +       /* Wait 20us after enable for the PLL to stabilize */
>> +       udelay(20);
>> +
>> +       return 0;
>> +}
>> +
>> +static void mtk_pll_unprepare_setclr(struct clk_hw *hw)
>> +{
>> +       struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>> +
>> +       writel(BIT(pll->data->pll_en_bit), pll->en_clr_addr);
>> +}
>> +
>>  const struct clk_ops mtk_pll_ops = {
>>         .is_prepared    = mtk_pll_is_prepared,
>>         .prepare        = mtk_pll_prepare,
>> @@ -283,6 +309,16 @@ const struct clk_ops mtk_pll_ops = {
>>         .set_rate       = mtk_pll_set_rate,
>>  };
>>
>> +const struct clk_ops mtk_pll_fenc_clr_set_ops = {
>> +       .is_prepared    = mtk_pll_fenc_is_prepared,
>> +       .prepare        = mtk_pll_prepare_setclr,
>> +       .unprepare      = mtk_pll_unprepare_setclr,
>> +       .recalc_rate    = mtk_pll_recalc_rate,
>> +       .round_rate     = mtk_pll_round_rate,
>> +       .set_rate       = mtk_pll_set_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(mtk_pll_fenc_clr_set_ops);
>> +
>>  struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
>>                                         const struct mtk_pll_data *data,
>>                                         void __iomem *base,
>> @@ -315,6 +351,9 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
>>         pll->hw.init = &init;
>>         pll->data = data;
>>
>> +       pll->fenc_addr = base + data->fenc_sta_ofs;
>> +       pll->fenc_mask = BIT(data->fenc_sta_bit);
>> +
>>         init.name = data->name;
>>         init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
>>         init.ops = pll_ops;
>> @@ -337,12 +376,13 @@ struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
>>  {
>>         struct mtk_clk_pll *pll;
>>         struct clk_hw *hw;
>> +       const struct clk_ops *pll_ops = data->ops ? data->ops : &mtk_pll_ops;
>>
>>         pll = kzalloc(sizeof(*pll), GFP_KERNEL);
>>         if (!pll)
>>                 return ERR_PTR(-ENOMEM);
>>
>> -       hw = mtk_clk_register_pll_ops(pll, data, base, &mtk_pll_ops);
>> +       hw = mtk_clk_register_pll_ops(pll, data, base, pll_ops);
>>         if (IS_ERR(hw))
>>                 kfree(pll);
>>
>> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
>> index c4d06bb11516..7fdc5267a2b5 100644
>> --- a/drivers/clk/mediatek/clk-pll.h
>> +++ b/drivers/clk/mediatek/clk-pll.h
>> @@ -29,6 +29,7 @@ struct mtk_pll_data {
>>         u32 reg;
>>         u32 pwr_reg;
>>         u32 en_mask;
>> +       u32 fenc_sta_ofs;
>>         u32 pd_reg;
>>         u32 tuner_reg;
>>         u32 tuner_en_reg;
>> @@ -51,6 +52,7 @@ struct mtk_pll_data {
>>         u32 en_clr_reg;
>>         u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>>         u8 pcw_chg_bit;
>> +       u8 fenc_sta_bit;
>>  };
>>
>>  /*
>> @@ -72,6 +74,8 @@ struct mtk_clk_pll {
>>         void __iomem    *en_addr;
>>         void __iomem    *en_set_addr;
>>         void __iomem    *en_clr_addr;
>> +       void __iomem    *fenc_addr;
>> +       u32             fenc_mask;
>>         const struct mtk_pll_data *data;
>>  };
>>
>> @@ -82,6 +86,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
>>                              struct clk_hw_onecell_data *clk_data);
>>
>>  extern const struct clk_ops mtk_pll_ops;
>> +extern const struct clk_ops mtk_pll_fenc_clr_set_ops;
>>
>>  static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
>>  {
>> --
>> 2.39.5
>>


