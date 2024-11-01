Return-Path: <netdev+bounces-141101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564B9B98BB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075121F234C9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971B1D07B2;
	Fri,  1 Nov 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLbv6Uxx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1021CEE94;
	Fri,  1 Nov 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489732; cv=none; b=m9NCsrF+itw2jLkQqT5fdlQbFVG1dxJwtjYg8suGZoNfGMCc+Y8p+tY/lYrGZyUYqJtIV4yXUc9axMPYXTJ8AwBdJxzIlQnMNQbQ4NQxvL7eMQE1PTnt0rvxUp9ffOmAIWiyl+tOVbCGWX4/XzKQMjJVhsqQkvfjlVVt0g55BcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489732; c=relaxed/simple;
	bh=LBcJYTB6WIbJ8DlAwG7hImL3BwFHDAgo02896nLj1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB+GSQ6LfKHZKh/WSj+IqFMf+rrrIyZB324fgxzayoObG2IywZv3zmry5UBHSJU6poKYkT7H/86V6yTwSg5CnLUrY+8VTjdZ//RHvYhqyuGTQZfGa7CfLsd8ITyPrkWDpep2BS7dRqQpQs4Q+SxbTd9KeifhAt6+u2kY0D1dUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLbv6Uxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F887C4CECE;
	Fri,  1 Nov 2024 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489730;
	bh=LBcJYTB6WIbJ8DlAwG7hImL3BwFHDAgo02896nLj1Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLbv6Uxxo8SQJm21791wg19EUL58H9utdxxI+OA95m+CsTNwB6++xU/9/m0/hprGj
	 FtqxO722j/ulpty5c1g+TzF8YdjdDro98e1zAlPeEFWLLAoCn6+7UtlhGuTleLfpso
	 eNscequJtH3HGY/7k19sz42uhTZQvG1XdBRIiJQkwDctN219TGQ688tmK/8/jJDeB6
	 xnNdv9hOxEvaQG6/wx9hM3wkaPEmADMC08UUYZweW3oo+foHodWykfrMiOYhGHEePi
	 AtOY5QHqt93iRsKHseckQw7hxrXvT4v+rFXiusKwK4RQ3t7F4tl9ow6gg6MF6Cun/f
	 Ly6v514duNndA==
Date: Fri, 1 Nov 2024 14:35:28 -0500
From: Rob Herring <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: krzk+dt@kernel.org, a.fatoum@pengutronix.de, conor+dt@kernel.org,
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/23] net: stmmac: add support for dwmac 3.72a
Message-ID: <20241101193528.GA4067749-robh@kernel.org>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
 <20241029202349.69442-12-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029202349.69442-12-l.rubusch@gmail.com>

On Tue, Oct 29, 2024 at 08:23:37PM +0000, Lothar Rubusch wrote:
> The dwmac 3.72a is an ip version that can be found on Intel/Altera Arria10
> SoCs. Going by the hardware features "snps,multicast-filter-bins" and
> "snps,perfect-filter-entries" shall be supported. Thus add a
> compatibility flag, and extend coverage of the driver for the 3.72a.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> index 598eff926..b9218c07e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
> @@ -56,6 +56,7 @@ static const struct of_device_id dwmac_generic_match[] = {
>  	{ .compatible = "snps,dwmac-3.610"},
>  	{ .compatible = "snps,dwmac-3.70a"},
>  	{ .compatible = "snps,dwmac-3.710"},
> +	{ .compatible = "snps,dwmac-3.72a"},
>  	{ .compatible = "snps,dwmac-4.00"},
>  	{ .compatible = "snps,dwmac-4.10a"},
>  	{ .compatible = "snps,dwmac"},
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 54797edc9..e7e2d6c20 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -522,6 +522,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	if (of_device_is_compatible(np, "st,spear600-gmac") ||
>  		of_device_is_compatible(np, "snps,dwmac-3.50a") ||
>  		of_device_is_compatible(np, "snps,dwmac-3.70a") ||
> +		of_device_is_compatible(np, "snps,dwmac-3.72a") ||

All these of_device_is_compatible() checks should really go away and all 
the settings just come from match table data. Then everything is const 
and we're not matching multiple times at run-time. That would be a bit 
of refactoring though...

>  		of_device_is_compatible(np, "snps,dwmac")) {
>  		/* Note that the max-frame-size parameter as defined in the
>  		 * ePAPR v1.1 spec is defined as max-frame-size, it's
> -- 
> 2.25.1
> 

