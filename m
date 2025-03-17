Return-Path: <netdev+bounces-175213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9EBA6463E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5613A5D11
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53221D3F2;
	Mon, 17 Mar 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJqS0qEl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802538B;
	Mon, 17 Mar 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201496; cv=none; b=BX5dL9y3ODaILJHmGOTOWu6il557GDFhqilf+edqsrMWG9Ri4wnL8cY/vaSV6H8rgoiSQ1aKxvmK2jVC1AtDlIpp6P22fusjXrHy6ZXmMbd8HWzfOts7yvIxX+OL0jQsjTUzplyJu5pEL967itnK27Gt5CTlRUyjdLIar2gai0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201496; c=relaxed/simple;
	bh=XAV/2ePd8TT1yYLCVLS0BEy0i2/ksaThFsFZ8vjP0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXMMOf0BuYhS7PSs++95I4GqatbHgFBijS+lN26ByKn3tyiGRS4Q1Ch1ROjzqnw+0F35tlA5+wrBtJpUVAkAYsw9NuNERMqaTTJJ7uZAc9WMh3BPiS4nD+3Dpno84yr7xgcPMJptTcljCDO/zFeSvjEyV5PgJXPHGeKzGnyizhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJqS0qEl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742201495; x=1773737495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XAV/2ePd8TT1yYLCVLS0BEy0i2/ksaThFsFZ8vjP0Qc=;
  b=nJqS0qElIiei9AAk+ywimrTdT63jTt6PKZiybEfPBgpPNoWicaH2PNWa
   kCR3G7Phksnj3fnWQW158HJAw3f1jAH3OMufo/3TCEX5A5+dgBU/WZkfu
   Z7UUYnAnbKsHlBqhA/5BJfe5WqimulGT9X9GcqID44zJxUR1eZPZ2iV2Y
   7WcX75e/g42swPtikFBAuvrMCoh/1AqBBT7iscP0JSCEaqB6N4PWto9cy
   ICxSF45IKZNPv3qOj5rkV1GKAYAuzBiFMXc1WQLZoVouxkmoA6UIeI27i
   +DPD7UDexQDZdyygP89ugKx7znAu/CB3Icliwf00lUogRwpteS8KrhXUj
   A==;
X-CSE-ConnectionGUID: 1RAbgRCWQo6aqPuTuH3aFQ==
X-CSE-MsgGUID: jq5835vXSZamejXvFG0sow==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42460925"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="42460925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:51:34 -0700
X-CSE-ConnectionGUID: aYrg09uWT+6jW+GrtJt9Zg==
X-CSE-MsgGUID: 2yix0FGtSaOi8AJbQdJLLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126736513"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:51:30 -0700
Date: Mon, 17 Mar 2025 09:47:37 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: broadcom: Correct BCM5221 PHY model
 detection failure
Message-ID: <Z9fhqbfoQGSm1Njx@mev-dev.igk.intel.com>
References: <20250317035005.3064083-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317035005.3064083-1-JJLIU0@nuvoton.com>

On Mon, Mar 17, 2025 at 11:50:05AM +0800, Jim Liu wrote:
> Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
> 
> Fixes: 3abbd0699b67 (net: phy: broadcom: add support for BCM5221 phy)
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  drivers/net/phy/broadcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 22edb7e4c1a1..3529289e9d13 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -859,7 +859,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>  		return reg;
>  
>  	/* Unmask events we are interested in and mask interrupts globally. */
> -	if (phydev->phy_id == PHY_ID_BCM5221)
> +	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
>  		reg = MII_BRCM_FET_IR_ENABLE |
>  		      MII_BRCM_FET_IR_MASK;
>  	else
> @@ -888,7 +888,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
>  		return err;
>  	}
>  
> -	if (phydev->phy_id != PHY_ID_BCM5221) {
> +	if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM5221) {
>  		/* Set the LED mode */
>  		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
>  		if (reg < 0) {
> @@ -1009,7 +1009,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
>  		return err;
>  	}
>  
> -	if (phydev->phy_id == PHY_ID_BCM5221)
> +	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
>  		/* Force Low Power Mode with clock enabled */
>  		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
>  	else
> -- 
> 2.34.1

It will be nice to have wider explanation what it is fixing in commit
message. Is phydev->phy_id different than phydev->driver->phy_id? Looks
like masking isn't crucial as phydev->driver->phy_id is initialized by
PHY_ID_BCM5221 which is already masked.

Anyway, looks fine, thanks.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

