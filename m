Return-Path: <netdev+bounces-193301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E7AC37C2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 03:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF9170A7C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 01:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ACE86337;
	Mon, 26 May 2025 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SRmnfHNI"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394A1DDD1
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223545; cv=none; b=HfZFQtNNfZWnlLJR9UnGX8/ct4aF1RVCywK7gS7u8uAHzx6UdoB6ppqqCp8FK3Lpf+qaJM/0tKlkmJ5vGmtueh3oCLIdIqOW6LYgNUQ/1NxDfxnEke7Fm3c2mrYkSxeEIK6lgZgaFt2DwYBX+du8MqMDS2wE2nK8YZW7w5Au7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223545; c=relaxed/simple;
	bh=VIW94w16yOpBMokEAjRnl0da6S/B+huTLDB0mXI095c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtgnnoUMZXT3yfbtGlKtlEkTr0BBFcxb2w2QJPUN/HMCJSNZhhck8FBfATzMwZ5eb+wi+CYX2zliIEPw2aF/0locW4NXTiNG0o1bvQN3gg5sZJCWFbAagMcyT5shReXUSrmKCKm6gBW+ntipbwhD3DQ/uobG/pc6WKzNyP5r6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SRmnfHNI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a42e9d1-93ce-4666-b7e7-3c0b4e2c0c99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748223531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hFUsN/K02BBP5aa1d+e+JjhSauhkH1OuFe7JHH5P4E=;
	b=SRmnfHNINkkKfSn8W6N3pK4Z32Bvd80Uh08Q+VdxonIAirvRyyHDvIwm8ANYNOvux0/JLO
	0U2c1dWTONVN/nJbFvjAgwMBItF9uxzGpG/L5ch0SkuohWyu1lMmpHsVjDjvtxMxO1S6Z2
	TyB5xx15aOYf1UA8YhwNyYLwFBVbGo0=
Date: Mon, 26 May 2025 09:38:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
To: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Feiyang Chen <chenfeiyang@loongson.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Paul Kocialkowski <paulk@sys-base.io>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
 <20250526002924.2567843-2-james.hilliard1@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250526002924.2567843-2-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 5/26/25 8:29 AM, James Hilliard 写道:
> The Allwinner H616 ships with two different on-die phy variants, in
> order to determine the phy being used we need to read an efuse and
> then select the appropriate PHY based on the AC300 bit.
>
> By defining an emac node without a phy-handle we can override the
> default PHY selection logic in stmmac by passing a specific phy_node
> selected based on the ac200 and ac300 names in a phys list.
>
> This allows us to have a device tree that defines both PHY variants
> even though only one will actually end up being used at runtime
> based on the ac300 nvmem efuse bit.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 6c7e8655a7eb..e275f4caa684 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -11,6 +11,7 @@
>   #include <linux/mdio-mux.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_mdio.h>
>   #include <linux/of_net.h>
> @@ -280,6 +281,8 @@ static const struct emac_variant emac_variant_h6 = {
>   #define SYSCON_ETCS_EXT_GMII	0x1
>   #define SYSCON_ETCS_INT_GMII	0x2
>   

> +#define AC300_KEY		BIT(8)
> +

I have observed all the BIT macros in this file, and they all

have a line of comments. I think a comment is also needed here.

>   /* sun8i_dwmac_dma_reset() - reset the EMAC
>    * Called from stmmac via stmmac_dma_ops->reset
>    */
> @@ -1159,6 +1162,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>   	struct net_device *ndev;
>   	struct regmap *regmap;
>   	int ret;
> +	u16 val;
>   
>   	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
>   	if (ret)
> @@ -1222,6 +1226,21 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>   	if (IS_ERR(plat_dat))
>   		return PTR_ERR(plat_dat);
>   
> +	if (!nvmem_cell_read_u16(dev, "ac300", &val)) {
> +		const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
> +		int index = of_property_match_string(dev->of_node, "phy-names", phy_name);
> +		if (index < 0) {
> +			dev_err(dev, "PHY name not found in device tree\n");
> +			return -EINVAL;
> +		}
> +
> +		plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
> +		if (!plat_dat->phy_node) {
> +			dev_err(dev, "Failed to get PHY node from phys property\n");
> +			return -EINVAL;
> +		}
> +	}
> +
How about preparing a separate function for it?  Then call it in probe().

If you are willing to do so, remember to write a code comment.


Thanks,

Yanteng



