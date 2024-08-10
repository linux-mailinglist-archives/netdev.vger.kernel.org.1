Return-Path: <netdev+bounces-117420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97094DD86
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25EEB20F81
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62EF15A85F;
	Sat, 10 Aug 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lsqb9BEa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279C1370;
	Sat, 10 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304787; cv=none; b=b1DOLm0q7HPdiN1rABndQM0fw9bssNccVZDmvw1WGnBHVAnXnFBnzMsb40LAbVDL5AsTd/25E0sEVnLZWAjmF4BDGmtxMw8C2riOHHg+QiGUvuxqOkt2DJ+rE080jPz8p555fC3RZDDAgd0lpDmPqEPpxdQINZr3qr0N1NI5JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304787; c=relaxed/simple;
	bh=fDGxWNeudzKslYaqB/3a4AK6+HDKJ4uiOLk6j8a6S14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT9WEWvDAp9QnyWZrSybbUk9n6+KRfl7NABlPeLy1YuZEC8Az8CoWwRcXO8kMOVpMkBOSetYJtTcJ6hJk6+meLApH3B4zE93uqYyizjX6QQtg/uYjgC42aqRhu3jvaolspbGX79FXcCicQjAIOUesmvcIbDZCBro8i3sypMzTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lsqb9BEa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uWRtL27hYr9f36wwlIahQ4vUrOoeB5FAkwCKK1VuAJ8=; b=lsqb9BEaq7sZUlB3Bgc2Je4KMS
	Tou3ZrSx5XRFcBTEEGNzyf8m+Jj7uIEVaYCf+9kqBo8SCSuwYD3F+UA3Zx1yiP/jGtf4ajYQRdEp4
	M6lriAo3SeHi29BUXxD+1GsWMH+5Dllc8frxVtjRvpgVWYHKx8MiOh6XrHNJQUHmiIDY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scoII-004SDf-8H; Sat, 10 Aug 2024 17:46:14 +0200
Date: Sat, 10 Aug 2024 17:46:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <bb73ca0f-145c-4900-b077-e4d654dc1a0c@lunn.ch>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
 <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
 <ZrWmfqtYICzaj-HY@pengutronix.de>
 <5d62cf99-c025-42f1-99db-f1f872d1650a@lunn.ch>
 <ZrcLpXS5dd_rZq6F@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrcLpXS5dd_rZq6F@pengutronix.de>

> > > 6.4 Polarity Detection and Correction (POL)
> > > 6.4.1 Polarity Detection (DET)
> > > 6.4.2 Polarity Correction (COR)
> > 
> > Could these be mapped to ETH_TP_MDI* ? 
> 
> Yes, but it will look confusing in the user space. To make better
> representation in ethtool we will probably need a new port type. For
> example instead of PORT_TP it will be PORT_STP (single twiste pair) or
> PORT_SPE (single pair ethernet). What do you think?

Thinking about this some more....

The Marvell PHYs can indicate per pair if the polarity is wrong and
has been corrected, for 10BaseT and 1000BaseT. The datasheet indicates
that for 100BaseTX polarity does not matter.

So i agree, MDI crossover is the wrong way to indicate this. We should
add polarity indication, for up to 4 pairs.

	Andrew

