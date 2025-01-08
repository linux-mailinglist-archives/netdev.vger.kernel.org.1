Return-Path: <netdev+bounces-156114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC34A04FED
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0117A20EB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE713C82E;
	Wed,  8 Jan 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6J1zFSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA51EB36;
	Wed,  8 Jan 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301740; cv=none; b=oBwnL8U23h0LP56XiSrBLbrhNUio0cDj4FkfE03a8bZQ/BSLMxdDR8uBRwYpB3HVOktyY6T4yI+rn4FfX6ltA+fPBMNGHDXIzahyuD6A9V9WmpSTv0D+9OQ7SXqHsLiMFzedrlt12boWo5xbDFq7hriVI6OhI/ePH9zY5hxr8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301740; c=relaxed/simple;
	bh=oOdJutS4sIxAU8lwWOhQeM5+8TdbPeObSInMi0lPYNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8oQCEYqwUprbNEB989r7E8w6kv6cSNWkEAV2zKrKQE48Jy5a3RkQq+0Y0T7HpBpml8TJJzfTxpYs9UPRzq0pUm/TCHY0VcAL72MWxmm7L/H9FdCEf3wTkS31gUZwMJAdl6HJ0T5AqcUY7FMtgon6qaZEiu//7gHR1cCHEi9Ay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6J1zFSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E7CC4CED6;
	Wed,  8 Jan 2025 02:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736301738;
	bh=oOdJutS4sIxAU8lwWOhQeM5+8TdbPeObSInMi0lPYNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6J1zFSkvZYoJG/A1L/j4o2mxdDfxcu8Gd6V4QE264c5POIYI3J1FWDyb/iBJsus7
	 CeR+uzA+OXOfCOljCXwuPxqMRafCk8vzD3F1p01aFMioJaQVNFaj7gScsMqw6WW6LP
	 NxLS3NHh1wRYbyg7qW09nvqXmaehoTJZR93T3VHcyFtbg/ucsxvbx6lNJgYVNFDQxf
	 KFdF60Q0qjsW+cZLtenSo0iYQfglLR/BYnowHhTZDCqeQVYWrrh80nK+j4U1BvyTxy
	 V9M/l9k1X1rswyk856T2x8x+vqjK8BaytrwGeQ5cLky+cS8+ggHej5ULipsb5DgJI6
	 enUyTsq/2fr8Q==
Date: Tue, 7 Jan 2025 18:02:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250107180216.5802e941@kernel.org>
In-Reply-To: <20250106083301.1039850-3-o.rempel@pengutronix.de>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
	<20250106083301.1039850-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 09:32:55 +0100 Oleksij Rempel wrote:
> +	/**
> +	 * @get_link_stats: Retrieve link statistics.
> +	 * @dev: The PHY device for which the statistics are retrieved.
> +	 * @link_stats: structure where link-specific stats will be stored.
> +	 *
> +	 * Retrieves link-related statistics for the given PHY device. The input
> +	 * structure is pre-initialized with `ETHTOOL_STAT_NOT_SET`, and the
> +	 * driver must only modify members corresponding to supported
> +	 * statistics. Unmodified members will remain set to
> +	 * `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
> +	 *
> +	 * Return: 0 on success or a negative error code on failure.

These get callbacks return void

> +	 */
> +	void (*get_link_stats)(struct phy_device *dev,
> +			       struct ethtool_link_ext_stats *link_stats);
>  	/** @get_sset_count: Number of statistic counters */
>  	int (*get_sset_count)(struct phy_device *dev);
>  	/** @get_strings: Names of the statistic counters */
> @@ -1777,6 +1810,49 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>  	return phydev->is_pseudo_fixed_link;
>  }
>  
> +/**
> + * phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
> + * @phydev: Pointer to the PHY device
> + * @phy_stats: Pointer to ethtool_eth_phy_stats structure
> + * @phydev_stats: Pointer to ethtool_phy_stats structure
> + *
> + * Fetches PHY statistics using a kernel-defined interface for consistent
> + * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
> + * this function enforces a standardized format for better interoperability.
> + */
> +static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
> +					struct ethtool_eth_phy_stats *phy_stats,
> +					struct ethtool_phy_stats *phydev_stats)
> +{
> +	if (!phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
> +/**
> + * phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
> + * @phydev: Pointer to the PHY device
> + * @link_stats: Pointer to the structure to store extended link statistics
> + *
> + * Populates the ethtool_link_ext_stats structure with link down event counts
> + * and additional driver-specific link statistics, if available.
> + */
> +static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
> +				    struct ethtool_link_ext_stats *link_stats)
> +{
> +	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
> +
> +	if (!phydev->drv || !phydev->drv->get_link_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_link_stats(phydev, link_stats);
> +	mutex_unlock(&phydev->lock);
> +}

Do these have to be static inlines?

Seemds like it will just bloat the header, and make alignment more
painful.

