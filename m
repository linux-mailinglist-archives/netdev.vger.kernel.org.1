Return-Path: <netdev+bounces-158914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A5A13BDA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59276188C61C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928322B5B8;
	Thu, 16 Jan 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiTTJ52D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BB22B5A3;
	Thu, 16 Jan 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036604; cv=none; b=XmOPBmjvAlDQbmSkhglzkSkQod4W7cnhfRoSQEIptLkAeoUmOsolb6UkpjCO5PZGYbvsQ0PaLlUAqFMIJV9ekA3VYe3ZQM/DXLaeQxsHdsmC+lwTrNCui31/HZwi5DCZu+/LPZE5m4esU0MjfOFXgrN7z4VkvRzZYLUXB5LFuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036604; c=relaxed/simple;
	bh=vQpCD+s9y2/3FMZPZMkdmu4cJpvjF97PHf8SLhHeGFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoTbCKP32g4rpYjwQDKTyBg23y/n8XtR0zj/wke8gJGgnBDn3F+iVzETF11VM0pKA7ga/AQ1dQD5jd2GDeQ7mZ26O73/+FLo3oGeaIE2/xhJx2lRYUZXpj7P9tSWmrNaFpTKZLeg4vJP5tlphdikP2jWeAULzHB+z8KweTvGMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiTTJ52D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737036603; x=1768572603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vQpCD+s9y2/3FMZPZMkdmu4cJpvjF97PHf8SLhHeGFE=;
  b=NiTTJ52D3hEMF7UJIVAZWxxdgbbuSA9Ky1TGL+9UmZ7GkfYSAKASb5Wn
   JNUPM3SVp4SBsxJ+QSiq15eXodAuYov5MrfwYW9/vXmZapQ4ZWwzRpbO5
   J7t334e7Nh9QXqtt9gO40pdE0Za432iwP/JTiwYnul1QxGLDcTRDrON0r
   DeaSneVhu44VPIsrTLba1pB2mJFxtVHWbkNXnDZJ2nxIPH7QbpvgU9QVw
   HsOtHVanFeORosHy1hGdJ4ZgmiUlc+FD6YR6dUgqS0klDaOBIhh8jApsC
   MOzrjMsWS81//4gY8tq1s+SFNB9L3AlT/eWbbbP0VgTG0TUFRPcZbMOtX
   w==;
X-CSE-ConnectionGUID: zQYFKTZ5Q1yEPnbO8iF1Vw==
X-CSE-MsgGUID: be5z8XH1S6CuByyeVTBlDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="36632656"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="36632656"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:10:02 -0800
X-CSE-ConnectionGUID: NxG4/B1WQqyOrsh2l3bC2w==
X-CSE-MsgGUID: NWiIkY+QTEWt618ZBnu5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="110485509"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:10:00 -0800
Date: Thu, 16 Jan 2025 15:06:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: phy: realtek: always clear NBase-T lpa
Message-ID: <Z4kSZ2FRV+5T3rd7@mev-dev.igk.intel.com>
References: <cover.1736951652.git.daniel@makrotopia.org>
 <566d4771d68a1e18d2d48860e25891e468e26551.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566d4771d68a1e18d2d48860e25891e468e26551.1736951652.git.daniel@makrotopia.org>

On Wed, Jan 15, 2025 at 02:45:00PM +0000, Daniel Golle wrote:
> Clear NBase-T link partner advertisement before calling
> rtlgen_read_status() to avoid phy_resolve_aneg_linkmode() wrongly
> setting speed and duplex.
> 
> This fixes bogus 2.5G/5G/10G link partner advertisement and thus
> speed and duplex being set by phy_resolve_aneg_linkmode() due to stale
> NBase-T lpa.
> 
> Fixes: 68d5cd09e891 ("net: phy: realtek: change order of calls in C22 read_status()")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 93704abb6787..9cefca1aefa1 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -952,15 +952,15 @@ static int rtl822x_read_status(struct phy_device *phydev)
>  {
>  	int lpadv, ret;
>  
> +	mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +
>  	ret = rtlgen_read_status(phydev);
>  	if (ret < 0)
>  		return ret;
>  
>  	if (phydev->autoneg == AUTONEG_DISABLE ||
> -	    !phydev->autoneg_complete) {
> -		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> +	    !phydev->autoneg_complete)
>  		return 0;
> -	}
>  
>  	lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
>  	if (lpadv < 0)

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.1

