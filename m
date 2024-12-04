Return-Path: <netdev+bounces-148762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788229E314B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E90B264CB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BE17BCA;
	Wed,  4 Dec 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aYbgezf7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EC5674E;
	Wed,  4 Dec 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278559; cv=none; b=UacZqutip0+lIToiRbcN9ElBgsKussbVNwbwk0zo2h28Su/j5OlraJZ1Zqty0NzL89tSHexAaYinnhBRjuQRt/p1S4B9/qM5Mxc69toLBMANSIucN4T/zJnt5Fb4RqHWYNfD0CkytxtHvS9rkOWchWIIYUB8WsRaycsOvZDAWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278559; c=relaxed/simple;
	bh=l10Apr66QCLwZwue9Wtgypu3GvQspBp+nwwYtOwZ7gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEklZZRHGm3II/wmdWsak1m4WaMfuT+yBzohWM+HK+hZ0RmLcrp7nUpphD7WTbA/O6rMo5trl8O4zGb6LWJ4GbSaYTAMy3g6O3mwqL9h6J0iy8rsiozxL2VKS7KW7redJ+vqftcb5viCGao7qnqJGdRKrF/6xItdBIBkFCFIvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aYbgezf7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NoKIQzGC9lTfjHsqJVhywf18TYP1wUsxi/w7f9E14ng=; b=aYbgezf75Ce3d+ZwwsU1DyFV6y
	ir5rUDyaTIyP+Zn5+XodO1yyP1rTPCw+NULoJu+p+sxgvcx4cYEv6BBzwF21mb/qw8nLlWi3hZ35N
	Srs7wQYZP5HERCHPfrvg05Ov6onQ9z59E3/kb0SJstam2TFYaHMrv6h2dwPrIN9rsuIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIevg-00F9ho-Fz; Wed, 04 Dec 2024 03:15:52 +0100
Date: Wed, 4 Dec 2024 03:15:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 09/10] net: freescale: ucc_geth: Introduce a
 helper to check Reduced modes
Message-ID: <ce002489-2a88-47e3-ba9a-926c3a71dea9@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203124323.155866-10-maxime.chevallier@bootlin.com>

> +static bool phy_interface_mode_is_reduced(phy_interface_t interface)
> +{
> +	return phy_interface_mode_is_rgmii(interface) ||
> +	       interface == PHY_INTERFACE_MODE_RMII ||
> +	       interface == PHY_INTERFACE_MODE_RTBI;
> +}

I wounder if this is useful anywhere else? Did you take a look around
other MAC drivers? Maybe this should be in phy.h?

	Andrew

