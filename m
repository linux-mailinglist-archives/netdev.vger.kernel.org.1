Return-Path: <netdev+bounces-160054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A5A17F7B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED57B188BA25
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84731F37CA;
	Tue, 21 Jan 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk131RJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BB1F37BE;
	Tue, 21 Jan 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468862; cv=none; b=MLmNlyief/sAhcbRYIix8F/FnUCJ5n8ZUoDxYka6DCYG7PSoGF0zpn4plqfIkDG/JKtjnQduEgjmb4kcawSbpq4exZrxAbNYAK/qv7G2Z7QifjBh/n5Q9RkH8fx4fxRXkNPiU8MELTu3HW/dROI4R27iqdwj/5yQHxFaL97N6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468862; c=relaxed/simple;
	bh=FHoIyD5h8UELHGOcuWQAqIu3vCDHYj8wOGNm8Y2JtxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4Tpp5tzUJfU68rRR02T6LQCfyv2kG34SoBq6cqlhWvnIqYMoxKVe0NIB6ShW3cEmxmnCuZYgbnx80GtLR86u0LLQflU3msDErF5N2k8YTBzifd6/zmDHEVRRD14aq2I8N9t0iz1XYKnXzWz9Eq1lkDThYrSkQTB+4FXoswlyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk131RJ7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737468861; x=1769004861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FHoIyD5h8UELHGOcuWQAqIu3vCDHYj8wOGNm8Y2JtxI=;
  b=dk131RJ7gve6dd4oeu3O/FHgnzV6E9nL8AMpsphEvwZrz3W/8kwmCOkC
   C67lt8b4HyhFpyg2aI6Tl17OSIA6aTAmibeXjCCMwJ79gbJL086dh0i2O
   FcF4tv38r+Db8ABPWN2x03rA5CCnTdkGUJrq4/DMYQ0wo8pKrUbl8TfbF
   Eit974QENldss1eJRhV/bAfJ4O6RhwDWA5KqaLoJtbcJh/mX6YIjvjSzi
   gkHilyySYz4GQ/ttTKp1l1dUxXNhEsD+eVAh00uYsKVyqd9r/QwtWeCKL
   vbh6zcGQ7UaUfCiPgF43gmWTXeqTG/cMi3XMWvn3rLyiyTk8dpF/kK1R1
   g==;
X-CSE-ConnectionGUID: gP2USCIFTkm0yW7kfLAvOg==
X-CSE-MsgGUID: ctAb9QueTAaegmTOPsbusA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="25483657"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="25483657"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:14:20 -0800
X-CSE-ConnectionGUID: OSaQhjstTjW7AbaDjjC4cg==
X-CSE-MsgGUID: XpadcvqhTemBkQlrfFGBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111435419"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:14:00 -0800
Date: Tue, 21 Jan 2025 15:10:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Laurent Badel <laurentbadel@eaton.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <Z4+q28pPnFcrMC/K@mev-dev.igk.intel.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>

On Tue, Jan 21, 2025 at 11:38:58AM +0100, Csókás, Bence wrote:
> The core is reset both in `fec_restart()`
> (called on link-up) and `fec_stop()`
> (going to sleep, driver remove etc.).
> These two functions had their separate
> implementations, which was at first only
> a register write and a `udelay()` (and
> the accompanying block comment).
> However, since then we got soft-reset
> (MAC disable) and Wake-on-LAN support,
> which meant that these implementations
> diverged, often causing bugs. For instance,
> as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`. To eliminate
> this bug-source, refactor implementation
> to a common function.
> 
> Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Recommended options for this patch:
>     `--color-moved --color-moved-ws=allow-indentation-change`
> 
>  drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..850ef3de74ec 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1064,6 +1064,27 @@ static void fec_enet_enable_ring(struct net_device *ndev)
>  	}
>  }
>  
> +/* Whack a reset.  We should wait for this.
> + * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> + * instead of reset MAC itself.
> + */
> +static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
> +{
> +	if (!wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> +		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> +		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> +			writel(0, fep->hwp + FEC_ECNTRL);
> +		} else {
> +			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> +			udelay(10);
> +		}
> +	} else {
> +		val = readl(fep->hwp + FEC_ECNTRL);
> +		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> +		writel(val, fep->hwp + FEC_ECNTRL);
> +	}
> +}
> +
>  /*
>   * This function is called to start or restart the FEC during a link
>   * change, transmit timeout, or to reconfigure the FEC.  The network
> @@ -1080,17 +1101,7 @@ fec_restart(struct net_device *ndev)
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>  
> -	/* Whack a reset.  We should wait for this.
> -	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> -	 * instead of reset MAC itself.
> -	 */
> -	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
> -	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
> -		writel(0, fep->hwp + FEC_ECNTRL);
> -	} else {
> -		writel(1, fep->hwp + FEC_ECNTRL);
Nit, in case of a need for v2 you can mark in commit message that
FEC_ECR_RESET == 1, so define can be use instead of 1.

> -		udelay(10);
> -	}
> +	fec_ctrl_reset(fep, false);
>  
>  	/*
>  	 * enet-mac reset will reset mac address registers too,
> @@ -1344,22 +1355,7 @@ fec_stop(struct net_device *ndev)
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>  
> -	/* Whack a reset.  We should wait for this.
> -	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> -	 * instead of reset MAC itself.
> -	 */
> -	if (!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
> -		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
> -			writel(0, fep->hwp + FEC_ECNTRL);
> -		} else {
> -			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
> -			udelay(10);
> -		}
> -	} else {
> -		val = readl(fep->hwp + FEC_ECNTRL);
> -		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
> -		writel(val, fep->hwp + FEC_ECNTRL);
> -	}
> +	fec_ctrl_reset(fep, true);
>  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
>  	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
>  

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.48.1

