Return-Path: <netdev+bounces-230634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A8BEC130
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD534E2312
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1E1397;
	Sat, 18 Oct 2025 00:06:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A49354AF8;
	Sat, 18 Oct 2025 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745961; cv=none; b=dFKANRRzbhjtX+pd9Sydr1TJf8ZpDtxhcuHoh2eqXpMHCNGul+ixxs4lopmdSTH6SykDlCeChBaQzTEc/nYCx69jhAtHuR319qo9hW1/g/AmUiwHBbbQLRyC18laO1kgsQSOs+OOxF7VmpmUgmqHMBavo8RPnF7mNaeFm0NX5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745961; c=relaxed/simple;
	bh=cvYny5yQsHJFubeXGJElbL68TJTK+OiH5rxfRGrAUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k12Erfzxrw+Ub314sdm3cPp6VmV34JPeUkDaltW5pjhl6SFRAxZdWKlKhEjgHJcZgSQQ0uUXMv2Jnm1DDTk3o9ifyIYyRH/2u6A8K1i4dphtTaaWewCygi2ItU58FUuVxqAUyAEBg0zHrsUxTCWdM3Dfb+2Cuy3AT1X+qKSDWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C82DD341FD5;
	Sat, 18 Oct 2025 00:05:58 +0000 (UTC)
Date: Sat, 18 Oct 2025 08:05:48 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <20251018000548-GYA1481334@gentoo.org>
References: <20251017011802.523140-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017011802.523140-1-inochiama@gmail.com>

Hi Inochi,

On 09:18 Fri 17 Oct     , Inochi Amaoto wrote:
> As the SG2042 has an internal rx delay, the delay should be remove
                                                     s/remove/removed/
> when init the mac, otherwise the phy will be misconfigurated.
s/init/initialize/
> 
> Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> index 3b7947a7a7ba..b2dee1399eb0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> @@ -7,6 +7,7 @@
> 
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> 
> @@ -29,8 +30,23 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
>  	return 0;
>  }
> 
> +static int sophgo_sg2042_set_mode(struct plat_stmmacenet_data *plat_dat)
> +{
> +	switch (plat_dat->phy_interface) {
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
> +		return 0;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int sophgo_dwmac_probe(struct platform_device *pdev)
>  {
> +	int (*plat_set_mode)(struct plat_stmmacenet_data *plat_dat);
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
> @@ -50,11 +66,18 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> +	plat_set_mode = device_get_match_data(&pdev->dev);
> +	if (plat_set_mode) {
> +		ret = plat_set_mode(plat_dat);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
>  }
> 
>  static const struct of_device_id sophgo_dwmac_match[] = {
> -	{ .compatible = "sophgo,sg2042-dwmac" },
> +	{ .compatible = "sophgo,sg2042-dwmac", .data = sophgo_sg2042_set_mode },
I'd personally prefer to introduce a flag for this, it would be more readable and
maintainable, something like
struct sophgo_dwmac_compitable_data {
	bool has_internal_rx_delay;
}

then.
	if (data->has_internal_rx_delay)
		sophgo_sg2042_set_mode(..)


>  	{ .compatible = "sophgo,sg2044-dwmac" },
>  	{ /* sentinel */ }
>  };
> --
> 2.51.0
> 

-- 
Yixun Lan (dlan)

