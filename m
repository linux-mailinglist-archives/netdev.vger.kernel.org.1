Return-Path: <netdev+bounces-156770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B0A07CED
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CD91660F5
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C17221D8E;
	Thu,  9 Jan 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f113q9TL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13E22069F;
	Thu,  9 Jan 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438880; cv=none; b=Cer4yNKI6CyYCWRJ1om0R5Kpa6I8urhcG1+DBNH1IyWoAWxqMobQKFQgIyxxx7QoG60kfAUVQh4YOcLmeuY5rg2n4WyF1sL5znBdRNmF7USIX0rWPW8WytwH19rzKx0B8IpIAjd8nu2ryH3axXn6MJmdr3W89UNo+YpDkQ0T4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438880; c=relaxed/simple;
	bh=iBoaj9bYbmgQxE1WvvdhaJe28thJnAzysiJuU4+yWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdRywMYGIUZr6+FUKx0ixLwWO098ouMQ13+9P5zYpvk8123C2u+y1k/e3RYvI7xSwXiL5TXQpzZlEIxK5Ph5N3YNQBUzMKravHjH3JAvHc0uuPGRJFql1Dh5XlUQOp0vMpn6a2V+NO+MTLWwy73PUFQOTujMEucQ0bKHDBIKc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f113q9TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A2FC4CED6;
	Thu,  9 Jan 2025 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438880;
	bh=iBoaj9bYbmgQxE1WvvdhaJe28thJnAzysiJuU4+yWQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f113q9TLnFp00kdSAWYKvSG0eK05ayjpJUDDGC+1PWCs75YDxyZsup/bVEbmyr30d
	 9UfafiH1Lf+BL42s6foVXKTXUZEfs+22a8OS1V0kAQIeNZcmrE7ONI3AmbLCQg0Xp+
	 qbj/TlB4xwgw0+gxPX6JfZh0zuQJMEAzoaVj2LUDfcX1r1cRsNL5fc4kN8OpZtDrrY
	 F/oSu0glpGU8ux0NgixPLfuM/giacNGBCb7PmLNFY60juhz0nvufmn7G+Oo6ejTVQT
	 t5Jo/ZAsoHLkAy0+wTdunoGRVIBkjOlpof16sDQc5nNgihPLezeNlfKYebk3mwa71k
	 +WX89SnmfLvxQ==
Date: Thu, 9 Jan 2025 08:07:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250109080758.608e6e1a@kernel.org>
In-Reply-To: <20250109094457.97466-3-o.rempel@pengutronix.de>
References: <20250109094457.97466-1-o.rempel@pengutronix.de>
	<20250109094457.97466-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 10:44:52 +0100 Oleksij Rempel wrote:
> +static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
> +					struct ethtool_eth_phy_stats *phy_stats,
> +					struct ethtool_phy_stats *phydev_stats)
> +{
> +	ASSERT_RTNL();
> +
> +	if (!phylib_stubs)
> +		return;
> +
> +	phylib_stubs->get_phy_stats(phydev, phy_stats, phydev_stats);
> +}
> +
> +static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
> +				    struct ethtool_link_ext_stats *link_stats)
> +{
> +	ASSERT_RTNL();
> +
> +	if (!phylib_stubs)
> +		return;
> +
> +	phylib_stubs->get_link_ext_stats(phydev, link_stats);
> +}

So we traded on set of static inlines for another?
What's wrong with adding a C source which is always built in?
Like drivers/net/phy/stubs.c, maybe call it drivers/net/phy/accessors.c
or drivers/net/phy/helpers.c

