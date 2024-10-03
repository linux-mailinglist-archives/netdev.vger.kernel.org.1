Return-Path: <netdev+bounces-131637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3398F18C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09237282642
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717B19F403;
	Thu,  3 Oct 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKrn8L84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5891E515;
	Thu,  3 Oct 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966142; cv=none; b=ryWbG0Dv2ZCfZPfB3ZNyk6JU4FEz2YmBL/uw07aTjmEbdxOQHLA8QDQj2p2iBhU0SpWs8n1M1iSo42LErjkjbOEF2+EKgNT/IYBkM+PqaNCBi/fpPu524G8lz8jX3UJRLxxHjy8u8fldTpj/ISmTyAgFOqquytiUPgqaGOlTIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966142; c=relaxed/simple;
	bh=U8icIK3BE1bI7+nO+YidN+i9hjIvX2G+tPxNCsSRFd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSCxvfaxNOVy62EdnWDJBfgBfhdmWbuA475L4+E5fD62ifxwxPr7v7Vbp2BONSSF5/otfYZx4FcInWujklYZ809f6QZFG2gkYhPmPz3i/0/1C7BduKa7PUHOIwJ2tzyPP8HaVMoNIaNizOXQqIysk502wfAtaC1rMF0W+kf88XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKrn8L84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB0DC4CEC5;
	Thu,  3 Oct 2024 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966142;
	bh=U8icIK3BE1bI7+nO+YidN+i9hjIvX2G+tPxNCsSRFd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKrn8L84tWxFREL5btCJr75fz4lqrxEjGiFna35gdvpWSAHQuM5hWrX9aHKPUrJry
	 LhM0FzuDCbK8K3osrJqxj4eQJ961r9Y4/eS6Ut7RagUr/XJraPcylGkoqjuUdKlELK
	 m5cPQtK8qUkaA/jO4o+VtHutDtpZJtJV/89KKb2JXeLwDC6z5MUe2uzXKPv2WoK5wm
	 ief+mLnhy28/d/5g7LVL3N5B7uAAyPpHcLAhckuxGTdH39NV55Q7OgQt+RdDU45eUy
	 EvY1vQu7qx6GiTUcwoVC26oBlrmFVjT+hgl4od2//YapTFAZm4zPV4IQIO5HVWvt8N
	 9LJ+OHW/WvlNQ==
Date: Thu, 3 Oct 2024 15:35:37 +0100
From: Simon Horman <horms@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] stmmac: dwmac-intel-plat: fix call balance of tx_clk
 handling routines
Message-ID: <20241003143537.GQ1310185@kernel.org>
References: <20240930183715.2112075-1-mordan@ispras.ru>
 <20241003111811.GJ1310185@kernel.org>
 <20241003-31f0aab72f4bccce9337303f-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-31f0aab72f4bccce9337303f-pchelkin@ispras.ru>

+ Andrew Lunn

On Thu, Oct 03, 2024 at 03:55:35PM +0300, Fedor Pchelkin wrote:
> Hello,
> 
> On Thu, 03. Oct 12:18, Simon Horman wrote:
> > On Mon, Sep 30, 2024 at 09:37:15PM +0300, Vitalii Mordan wrote:
> > > If the clock dwmac->tx_clk was not enabled in intel_eth_plat_probe,
> > > it should not be disabled in any path.
> > > 
> > > Conversely, if it was enabled in intel_eth_plat_probe, it must be disabled
> > > in all error paths to ensure proper cleanup.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with Klever.
> > > 
> > > Fixes: 9efc9b2b04c7 ("net: stmmac: Add dwmac-intel-plat for GBE driver")
> > > Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> > > ---
> > >  .../ethernet/stmicro/stmmac/dwmac-intel-plat.c   | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > > index d68f0c4e7835..2a2893f2f2a8 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
> > > @@ -108,7 +108,12 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> > >  			if (IS_ERR(dwmac->tx_clk))
> > >  				return PTR_ERR(dwmac->tx_clk);
> > >  
> > > -			clk_prepare_enable(dwmac->tx_clk);
> > > +			ret = clk_prepare_enable(dwmac->tx_clk);
> > > +			if (ret) {
> > > +				dev_err(&pdev->dev,
> > > +					"Failed to enable tx_clk\n");
> > > +				return ret;
> > > +			}
> > >  
> > >  			/* Check and configure TX clock rate */
> > >  			rate = clk_get_rate(dwmac->tx_clk);
> > > @@ -117,6 +122,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> > >  				rate = dwmac->data->tx_clk_rate;
> > >  				ret = clk_set_rate(dwmac->tx_clk, rate);
> > >  				if (ret) {
> > > +					clk_disable_unprepare(dwmac->tx_clk);
> > >  					dev_err(&pdev->dev,
> > >  						"Failed to set tx_clk\n");
> > >  					return ret;
> > 
> > Hi Vitalii,
> > 
> > I think that unwinding using a goto label would be more idiomatic here
> > and in the following changes to intel_eth_plat_probe().
> > 
> > > @@ -131,6 +137,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> > >  			rate = dwmac->data->ptp_ref_clk_rate;
> > >  			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
> > >  			if (ret) {
> > > +				if (dwmac->data->tx_clk_en)
> > > +					clk_disable_unprepare(dwmac->tx_clk);
> > >  				dev_err(&pdev->dev,
> > >  					"Failed to set clk_ptp_ref\n");
> > >  				return ret;
> > > @@ -150,7 +158,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
> > >  
> > >  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> > >  	if (ret) {
> > > -		clk_disable_unprepare(dwmac->tx_clk);
> > > +		if (dwmac->data->tx_clk_en)
> > > +			clk_disable_unprepare(dwmac->tx_clk);
> > 
> > Smatch warns that dwmac->data may be NULL here.
> 
> FWIW, there is a patch [1] targeted at net-next which removes the seemingly
> redundant check for dwmac->data.
> 
> [1]: https://lore.kernel.org/netdev/20240930183926.2112546-1-mordan@ispras.ru/
> 
> At the moment device_get_match_data() can't return NULL in probe function
> of this driver - it gets the data from static const intel_eth_plat_match[]
> table where every entry has defined non-NULL .data.
> 
> It's not expected (at least currently) that there would be any code changes
> to the driver match table so it looks worthwhile to remove the check in
> order to reduce additional complexity in error paths and
> intel_eth_plat_remove().

Thanks, I hadn't correlated that patch with this one.
I agree that it address my comment about needing
to check wmac->data here and below.

> That said, maybe it would be more safe now to rearrange the check to fail
> at probe stage in case dwmac->data is NULL. Just not to confuse the static
> analysis tools :)

I see that Andrew Lunn responded that a comment is appropriate,
rather than writing code to please the checkers. And, FWIIW,
I agree with his suggestion.

> 
> Thanks!
> 
> > 
> > >  		return ret;
> > >  	}
> > >  
> > > @@ -162,7 +171,8 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
> > >  	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
> > >  
> > >  	stmmac_pltfr_remove(pdev);
> > > -	clk_disable_unprepare(dwmac->tx_clk);
> > > +	if (dwmac->data->tx_clk_en)
> > 
> > And I wonder if it can be NULL here too.
> > 
> > > +		clk_disable_unprepare(dwmac->tx_clk);
> > >  }
> > >  
> > >  static struct platform_driver intel_eth_plat_driver = {
> > > -- 
> > > 2.25.1
> > > 
> > > 
> 

