Return-Path: <netdev+bounces-190352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6951AB66B4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FD19E61C5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DBA2222B0;
	Wed, 14 May 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVCfMa21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0B1E5B71;
	Wed, 14 May 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213271; cv=none; b=MCxtl82uLHxB3CycPp22bpe5ZGaIofXfHNkT2p7NL2GeDRH0CnEsPFWF82DL0LUk+Z7JO7Pdc+oDg7sq3BoGd7Ca8u/Ur5dO5m7EVDX0XvYAK+4qRmRBdJZFqwL8UnS/EEUb4x6WSjIRyAN/rOYiilVCaGMw4QQexrb8k4SPdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213271; c=relaxed/simple;
	bh=q7UIx9glY/O25EIww1o47tmTN8EiBr4g784HHsHRWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdpy3CHeh0oiwDwewKHFjFYOaEGaPOQXlKXkIbGG3ma4kEO3KStcsvvXunFRZ08HgKi6jp4LBKT5iOQcan0SXr/QFG7eMrGY28t8E2YpMy3L4uVImh66uKa5qFaBasm4mjseNeDwDMQvPGbRy7XFliWbfW5CTG8b05Hiucq2ggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVCfMa21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F13C4CEE9;
	Wed, 14 May 2025 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747213271;
	bh=q7UIx9glY/O25EIww1o47tmTN8EiBr4g784HHsHRWco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVCfMa211CYixHzXoYzxr1yLuZiKdTNhYo8y0wV/K/QeRbkN/48BPn1rEIU93zTzZ
	 A4tbif/Hl088+MdSP19gPkLtqZInD96Z0bSlcsPO3UZ/Zo9uW/FvO3nKtwmlxbKeIz
	 ho2rr2aJzcEiunGlKdYTkAzarlE52JxKWBvDSu0MKUrcytzNZJHf3WjyJan1RQvSSf
	 q70kPTgI3OMaeEMOb20Js57GNrp9h4K8OM1Lz+POsremM36FnDv/TDn6OKN4p7XcVT
	 wdIPe+A2KcClhhMwIROOegQIzGWH/B5K9lcZXRNtq5tZLlQvpCQyzJIE+A/Lv9SC/X
	 3dx1H2JWXtiMQ==
Date: Wed, 14 May 2025 11:01:07 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
 modules
Message-ID: <3iyvm6curoco35xuyos5llxvnvopvphl5cnndaacg2v5jiu3l7@aaic3jfqhjaz>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>

On Wed, May 14, 2025 at 09:49:59AM +0200, Romain Gantois wrote:
>  
> +static int dp83869_port_configure_serdes(struct phy_port *port, bool enable,
> +					 phy_interface_t interface)
> +{
> +	struct phy_device *phydev = port_phydev(port);
> +	struct dp83869_private *dp83869;
> +	int ret;
> +
> +	if (!enable)
> +		return 0;
> +
> +	dp83869 = phydev->priv;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		dp83869->mode = DP83869_RGMII_1000_BASE;
> +		break;
> +	default:
> +		phydev_err(phydev, "Incompatible SFP module inserted\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = dp83869_configure_mode(phydev, dp83869);
> +	if (ret)
> +		return ret;
> +
> +	/* Update advertisement */
> +	if (mutex_trylock(&phydev->lock)) {
> +		ret = dp83869_config_aneg(phydev);
> +		mutex_unlock(&phydev->lock);
> +	}

Just skimmed through this quickly and it's not clear to me why aneg is
restarted only if there was no contention on the global phydev lock;
it's not guaranteed a concurrent holder would do the same. If this is
intended, a comment would be welcomed.

Thanks!

