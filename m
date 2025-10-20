Return-Path: <netdev+bounces-230862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFABF0B59
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E1C3B300F
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED753259CA7;
	Mon, 20 Oct 2025 11:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE22156236;
	Mon, 20 Oct 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958147; cv=none; b=DXbwWFfDpjuiLJl+rSS0a01vGLf14ydiXcQduw+frykdKEHSGV/S79QWAO0e+7G6iVgK10+p2GKAwDr+Xgo/QpnH942FnfkdVajZjEaCfuYWQAeDMQbwKPhTVyfsOxhF8lojFTMNOTy12bbPf6lzREO14SwnjqjQf2uLTqKsA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958147; c=relaxed/simple;
	bh=97MHgTGoIdfNRsIhMVNAs3S+pxC+Qx4D00c17a5Yzfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRmbMX/QEtMx2kxf4cMvSVRG3nzWM9BhuJBPWGpYTcofhDe16hnamdhq1VA0T3SDHJhWG54zqxE2TqxeHxZNAmavW+XrpSgBFYklP4OgixDT0hQAix8A57prI2QvexAiVqapDh+ZFLiHIzZMjoBBemlBY1fGetaEHAXTU7UKPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id EF5D9341EEB;
	Mon, 20 Oct 2025 11:02:23 +0000 (UTC)
Date: Mon, 20 Oct 2025 19:02:19 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <20251020110219-GYH1506524@gentoo.org>
References: <20251020095500.1330057-1-inochiama@gmail.com>
 <20251020095500.1330057-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020095500.1330057-4-inochiama@gmail.com>

Hi Inochi,

On 17:54 Mon 20 Oct     , Inochi Amaoto wrote:
> As the SG2042 has an internal rx delay, the delay should be remove
missed my comment in v1?

> when init the mac, otherwise the phy will be misconfigurated.
> 
> Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-sophgo.c  | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> index 3b7947a7a7ba..960357d6e282 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> @@ -7,11 +7,16 @@
> 
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> 
>  #include "stmmac_platform.h"
> 
> +struct sophgo_dwmac_data {
> +	bool has_internal_rx_delay;
> +};
> +
>  static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
>  				    struct plat_stmmacenet_data *plat_dat,
>  				    struct stmmac_resources *stmmac_res)
> @@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
>  static int sophgo_dwmac_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat_dat;
> +	const struct sophgo_dwmac_data *data;
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
>  	int ret;
> @@ -50,11 +56,20 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> +	data = device_get_match_data(&pdev->dev);
> +	if (data && data->has_internal_rx_delay)
> +		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> +									  false, true);
> +
>  	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
>  }
> 
> +static struct sophgo_dwmac_data sg2042_dwmac_data = {
static const?
> +	.has_internal_rx_delay = true,
> +};
> +
>  static const struct of_device_id sophgo_dwmac_match[] = {
> -	{ .compatible = "sophgo,sg2042-dwmac" },
> +	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
>  	{ .compatible = "sophgo,sg2044-dwmac" },
>  	{ /* sentinel */ }
>  };
> --
> 2.51.1.dirty
> 

-- 
Yixun Lan (dlan)

