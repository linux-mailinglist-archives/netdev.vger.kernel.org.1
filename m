Return-Path: <netdev+bounces-173555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F9AA5972B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F47B16A758
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA322AE5D;
	Mon, 10 Mar 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q7fGuGPD"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BA22157A;
	Mon, 10 Mar 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615946; cv=none; b=sCyZvoNqcVtrj0LMRspSGXpsiUkSaC4QEvN6FQf4KkkDf1nO6/i7LMDav+qArcZJpQMwoHt7hqfbja293Ll3j2GErl86Vr19Jrvy48/zKgfX1CzO/yrWq7Xok9a6+vuvy8gJLCLP6Fe9JQTuARk4oD2UeawiZKw9zxsciogRbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615946; c=relaxed/simple;
	bh=VvTbrukqJECgVTvGE9CueOWKZHry7TuKRTj4dDd5LMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV9Onvplbnk9Sp1t4vwj2hk/5IVIX3kUDcE1WtfE7n3Q5Q5Q+Oz3F9QLdyGDkOWGu3iUlsJJCrRDFcpo7PW2CvfcOiFGNirZPDsnM+9FDM5Vcpk6Hv/rHj9TOAeEJA/X09CDxwjVorNZTG7/2ysccUrKkYYIOtxl5/Vqv8ySSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q7fGuGPD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741615940;
	bh=VvTbrukqJECgVTvGE9CueOWKZHry7TuKRTj4dDd5LMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q7fGuGPDPQQJuuvqwAmmG3YOMdB37C0ASjXgb30wy90gx7lXAsc5rwAnHkoB66KUt
	 ez18FMdGSvq2oA1gYWklHwyoO4/Egrjat7yUr3NBwkLgh7oPvfzGzSZoGIsdr2IwgD
	 GeYyjdFXgsk8X9J34l+eXs9DJnFyxCx9JCR0niYPBZZmEDRqIEkSdo99Q3ZxEareA0
	 8z/bhoA7xanekNn4DVkbLtoyjzYmwGhr3pDw9Oy32aiOCbI5HcMMLzC+qa7AXSB314
	 rq6/ia07V1BV0upd1PLbPiRk3Jhl0p5elG5jpyxm7KZ+XlnQLrLpyEtkRrNd2vKGM2
	 BYy25HPKHu/0A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16B1F17E0649;
	Mon, 10 Mar 2025 15:12:20 +0100 (CET)
Message-ID: <cd8bd504-8d91-4420-8053-10ee814417bf@collabora.com>
Date: Mon, 10 Mar 2025 15:12:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] clk: mediatek: Support voting for mux
To: Guangjie Song <guangjie.song@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
 <20250307032942.10447-4-guangjie.song@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250307032942.10447-4-guangjie.song@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/25 04:26, Guangjie Song ha scritto:
> Add data fields, defines and ops to support voting for mux.
> 

The main thing that is missing here is an answer to an obvious question....

...what are the advantages of hardware voting, and why do we need to use
HW voting instead of the refcount that is already kept by the common clock
framework?

As far as I can see here, the only difference is that the enable/disable
is more complex, losing more time for polling after writes and nothing else?

Is this to synchronize the clock voting between SCP and AP or what?!
If this is the answer, I don't see why we should use this HW voter for all
clocks, since it's simply more expensive (so the clock drivers are wrong as
they enable the voter for all clocks).


> Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mux.c | 198 ++++++++++++++++++++++++++++++++-
>   drivers/clk/mediatek/clk-mux.h |  79 +++++++++++++
>   2 files changed, 275 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index 60990296450b..8a2c89cb3cd5 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -15,11 +15,13 @@
>   #include <linux/spinlock.h>
>   #include <linux/slab.h>
>   
> +#include "clk-mtk.h"
>   #include "clk-mux.h"
>   
>   struct mtk_clk_mux {
>   	struct clk_hw hw;
>   	struct regmap *regmap;
> +	struct regmap *vote_regmap;
>   	const struct mtk_mux *data;
>   	spinlock_t *lock;
>   	bool reparent;
> @@ -30,6 +32,46 @@ static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
>   	return container_of(hw, struct mtk_clk_mux, hw);
>   }
>   
> +static int mtk_clk_mux_fenc_enable_setclr(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	unsigned long flags = 0;
> +	u32 val = 0;
> +	int i = 0;
> +	int ret = 0;
> +
> +	if (mux->lock)
> +		spin_lock_irqsave(mux->lock, flags);
> +	else
> +		__acquire(mux->lock);
> +
> +	regmap_write(mux->regmap, mux->data->clr_ofs, BIT(mux->data->gate_shift));
> +
> +	while (1) {
> +		regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val);

Why are you reinventing the wheel instead of just using regmap_read_poll_timeout()?

> +
> +		if ((val & BIT(mux->data->fenc_shift)) != 0)
> +			break;
> +
> +		if (i < MTK_WAIT_FENC_DONE_CNT) {
> +			udelay(MTK_WAIT_FENC_DONE_US);
> +		} else {
> +			pr_err("%s wait fenc done timeout\n", clk_hw_get_name(hw));
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		i++;
> +	}
> +
> +	if (mux->lock)
> +		spin_unlock_irqrestore(mux->lock, flags);
> +	else
> +		__release(mux->lock);
> +
> +	return ret;
> +}
> +
>   static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
>   {
>   	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> @@ -70,6 +112,16 @@ static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
>   			BIT(mux->data->gate_shift));
>   }
>   
> +static int mtk_clk_mux_fenc_is_enabled(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	u32 val = 0;
> +
> +	regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val);
> +
> +	return (val & BIT(mux->data->fenc_shift)) != 0;

That's just `return val & BIT(mux->data->fenc_shift);` ...

> +}
> +
>   static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
>   {
>   	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> @@ -80,6 +132,106 @@ static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
>   	return (val & BIT(mux->data->gate_shift)) == 0;
>   }
>   
> +static int mtk_clk_vote_mux_is_enabled(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	u32 val = 0;
> +
> +	regmap_read(mux->vote_regmap, mux->data->vote_set_ofs, &val);
> +
> +	return (val & BIT(mux->data->gate_shift)) != 0;

same

> +}
> +
> +static int mtk_clk_vote_mux_is_done(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	u32 val = 0;
> +
> +	regmap_read(mux->vote_regmap, mux->data->vote_sta_ofs, &val);
> +
> +	return (val & BIT(mux->data->gate_shift)) != 0;

ditto

> +}
> +
> +static int mtk_clk_mux_vote_fenc_enable(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	u32 val = 0, val2 = 0;
> +	bool is_done = false;
> +	int i = 0;
> +
> +	regmap_write(mux->vote_regmap, mux->data->vote_set_ofs, BIT(mux->data->gate_shift));
> +
> +	while (!mtk_clk_vote_mux_is_enabled(hw)) {
> +		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
> +			udelay(MTK_WAIT_VOTE_PREPARE_US);

regmap_readl_poll_timeout().....

> +		} else {
> +			pr_err("%s mux prepare timeout(%x)\n", clk_hw_get_name(hw), val);
> +			return -EBUSY;
> +		}
> +
> +		i++;
> +	}
> +
> +	i = 0;
> +
> +	while (1) {
> +		if (!is_done)
> +			regmap_read(mux->vote_regmap, mux->data->vote_sta_ofs, &val);
> +
> +		if (((val & BIT(mux->data->gate_shift)) != 0))
> +			is_done = true;
> +

and again - twice.

> +		if (is_done) {
> +			regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val2);
> +			if ((val2 & BIT(mux->data->fenc_shift)) != 0)
> +				break;
> +		}
> +
> +		if (i < MTK_WAIT_VOTE_DONE_CNT) {
> +			udelay(MTK_WAIT_VOTE_DONE_US);
> +		} else {
> +			pr_err("%s mux enable timeout(%x %x)\n", clk_hw_get_name(hw), val, val2);
> +			return -EBUSY;
> +		}
> +
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_clk_mux_vote_disable(struct clk_hw *hw)
> +{
> +	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +	int i = 0;
> +
> +	regmap_write(mux->vote_regmap, mux->data->vote_clr_ofs, BIT(mux->data->gate_shift));
> +
> +	while (mtk_clk_vote_mux_is_enabled(hw)) {
> +		if (i < MTK_WAIT_VOTE_PREPARE_CNT) {
> +			udelay(MTK_WAIT_VOTE_PREPARE_US);
> +		} else {
> +			pr_err("%s mux unprepare timeout\n", clk_hw_get_name(hw));
> +			return;
> +		}
> +

....and again....

> +		i++;
> +	}
> +
> +	i = 0;
> +
> +	while (!mtk_clk_vote_mux_is_done(hw)) {
> +		if (i < MTK_WAIT_VOTE_DONE_CNT) {
> +			udelay(MTK_WAIT_VOTE_DONE_US);
> +		} else {
> +			pr_err("%s mux disable timeout\n", clk_hw_get_name(hw));
> +			return;
> +		}
> +
> +		i++;
> +	}
> +}
> +
>   static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
>   {
>   	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> @@ -151,6 +303,12 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
>   	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
>   }
>   
> +static void mtk_clk_mux_vote_fenc_disable_unused(struct clk_hw *hw)
> +{
> +	mtk_clk_mux_vote_fenc_enable(hw);
> +	mtk_clk_mux_vote_disable(hw);

Why would you need to enable and disable?

If this is not a mistake... this definitely needs a comment in the code.

> +}
> +
>   const struct clk_ops mtk_mux_clr_set_upd_ops = {
>   	.get_parent = mtk_clk_mux_get_parent,
>   	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
> @@ -168,9 +326,31 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
>   };
>   EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
>   
> +const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
> +	.enable = mtk_clk_mux_fenc_enable_setclr,
> +	.disable = mtk_clk_mux_disable_setclr,
> +	.is_enabled = mtk_clk_mux_fenc_is_enabled,
> +	.get_parent = mtk_clk_mux_get_parent,
> +	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +	.determine_rate = mtk_clk_mux_determine_rate,
> +};
> +EXPORT_SYMBOL_GPL(mtk_mux_gate_fenc_clr_set_upd_ops);
> +
> +const struct clk_ops mtk_mux_vote_fenc_ops = {
> +	.enable = mtk_clk_mux_vote_fenc_enable,
> +	.disable = mtk_clk_mux_vote_disable,
> +	.is_enabled = mtk_clk_mux_fenc_is_enabled,
> +	.get_parent = mtk_clk_mux_get_parent,
> +	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +	.determine_rate = mtk_clk_mux_determine_rate,
> +	.disable_unused = mtk_clk_mux_vote_fenc_disable_unused,
> +};
> +EXPORT_SYMBOL_GPL(mtk_mux_vote_fenc_ops);
> +
>   static struct clk_hw *mtk_clk_register_mux(struct device *dev,
>   					   const struct mtk_mux *mux,
>   					   struct regmap *regmap,
> +					   struct regmap *vote_regmap,
>   					   spinlock_t *lock)
>   {
>   	struct mtk_clk_mux *clk_mux;
> @@ -185,9 +365,17 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
>   	init.flags = mux->flags;
>   	init.parent_names = mux->parent_names;
>   	init.num_parents = mux->num_parents;
> -	init.ops = mux->ops;
> +	if (mux->flags & CLK_USE_VOTE) {
> +		if (vote_regmap)
> +			init.ops = mux->ops;
> +		else
> +			init.ops = mux->dma_ops;

Sorry why is this called dma_ops?!
That's at least confusing, if not simply wrong.... please explain.

> +	} else {
> +		init.ops = mux->ops;
> +	}
>   
>   	clk_mux->regmap = regmap;
> +	clk_mux->vote_regmap = vote_regmap;
>   	clk_mux->data = mux;
>   	clk_mux->lock = lock;
>   	clk_mux->hw.init = &init;
> @@ -220,6 +408,7 @@ int mtk_clk_register_muxes(struct device *dev,
>   			   struct clk_hw_onecell_data *clk_data)
>   {
>   	struct regmap *regmap;
> +	struct regmap *vote_regmap = NULL;
>   	struct clk_hw *hw;
>   	int i;
>   
> @@ -238,8 +427,13 @@ int mtk_clk_register_muxes(struct device *dev,
>   			continue;
>   		}
>   
> -		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
> +		if (mux->vote_comp) {
> +			vote_regmap = syscon_regmap_lookup_by_phandle(node, mux->vote_comp);
> +			if (IS_ERR(vote_regmap))
> +				vote_regmap = NULL;
> +		}
>   
> +		hw = mtk_clk_register_mux(dev, mux, regmap, vote_regmap, lock);

...and this change just breaks each and every MediaTek SoC that is currently
supported upstream.

Please test your changes on older platforms before submitting upstream.

Regards,
Angelo


