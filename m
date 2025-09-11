Return-Path: <netdev+bounces-222119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A5B53301
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5955A523F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45E322C8B;
	Thu, 11 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6uZhzIh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B5322A1F;
	Thu, 11 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595637; cv=none; b=bB7pPd0yGo+mIZ374WqQqjItaF4jNLHw+iaBvbsnq1K7CqbWExvaMEKr3KP9drLk00IQvXX/utvOnGq79j1ckvCh5cFMlLgxHzYsZ+zefmp0iL3/eJ/bmeL5abLHIdjIrIWKkG32cMBuq3e60XLnLeknD8G+n3bhDZ1G/ALEnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595637; c=relaxed/simple;
	bh=20hYR/z4hQNo67yZwQFfVBbtlNcUyhGMZ8XwF7gLqO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l37rIXvd5mi308qKCsjAWIQ3cxFG8u2eHv0+Kl3VK9Gip9vq/2l6HqPPuT1K7S94yW4Srx78SVMg4FvzUaD9IQiSFBvuoMP6dBGFNboPenzqWR9wQm92LI8yVvtwnyAxRIQ7AHsaqrpskxy5bj6W3XNHytFrxR5sdxoASmhNGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6uZhzIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB246C4CEF7;
	Thu, 11 Sep 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595637;
	bh=20hYR/z4hQNo67yZwQFfVBbtlNcUyhGMZ8XwF7gLqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6uZhzIh3qXl+e5vZIpeR3sxlWzuKJetAhbeZQvGAj4+tJwBegrI3X1qCMhHlndJc
	 QMVGgsnY89GhEkOBbnhkuhuvdgzJEVHx90OCLzTBZRFOyfhau5SHZHyGi+DTBFwpA7
	 6/e4Sg6O7/TPgdgqxErOIH3kThQKJYgA3CXVoUU2+FKBdCv+31tAgkhvQDL5Ztya1K
	 OWksbtSFfR4Th8IUwfKE1mqnQB2JnQYdGb8LgkbvHcTNswchkaynYOiz47OQPr6HsS
	 PEJJ9yDiNOUS2zQMqbc/3ivJZPAglzvfLbNCmuzfS1/qNpJdQeqkyeljplRGFl5MMJ
	 UJdq9EQNw9oUQ==
Date: Thu, 11 Sep 2025 14:00:32 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: introduce phy_id_compare_model()
 PHY ID helper
Message-ID: <20250911130032.GL30363@horms.kernel.org>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909202818.26479-1-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 10:28:10PM +0200, Christian Marangi wrote:
> Similar to phy_id_compare_vendor(), introduce the equivalent
> phy_id_compare_model() helper for the generic PHY ID Model mask.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/linux/phy.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 04553419adc3..6adf7c5a91c2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1308,6 +1308,19 @@ static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
>  	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
>  }
>  
> +/**
> + * phy_id_compare_model - compare @id with @model mask
> + * @id: PHY ID
> + * @vendor_mask: PHY Model mask

@model_mask

> + *
> + * Return: true if the bits from @id match @model using the
> + *	   generic PHY Model mask.
> + */
> +static inline bool phy_id_compare_model(u32 id, u32 model_mask)
> +{
> +	return phy_id_compare(id, model_mask, PHY_ID_MATCH_MODEL_MASK);
> +}
> +
>  /**
>   * phydev_id_compare - compare @id with the PHY's Clause 22 ID
>   * @phydev: the PHY device
> -- 
> 2.51.0
> 
> 

