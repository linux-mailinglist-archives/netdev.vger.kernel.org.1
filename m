Return-Path: <netdev+bounces-165507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85DA3266C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA62B1880799
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03220D516;
	Wed, 12 Feb 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mhwoy63m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F92080F9;
	Wed, 12 Feb 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365160; cv=none; b=s/eqJqECoyq1V3Jk4rCzYRGUNisljYaAZO3A98W5Pc2rIi7YIpH41TEIJcN4i/jS/HEiC9bvMdtV2ZGgh4YB0qkLqwib3OE7SNMWf4fXqj9xkPmBxeR/t1nJXkgT0v27LfIUbVJcusMXVfVhOxJDAch4gb4q4GEh0YTg4IO7dUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365160; c=relaxed/simple;
	bh=INNdk73tt5KZwVnkb/EbeN+grvLXD+L0A75MdDaM6i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBbtqMMwndRNvuaD1pjfvCMJ+0cZhqohDN6gSxlNWxoPmB0vLZOlHjE3rQpgQCnOfoCYvjKZUG6uNeh+Lzitbibj13wKnHanuU9NuuIuh76ZoF39A6rd8XZwV0psM/tqpwvSGVPFUPrFN1CuFfZPceN5IJwuvhledNjFdo9i6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mhwoy63m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V0dhtfuDMhyaOzCKj2LA/b865CHvuu3FURUtctL4FEE=; b=mhwoy63mn6iHrx6gmilA20aa0j
	jsaZYTd93fYDSePQnFeHek0xu8GHAxSg+SzCj7DpaG4xBa/N8WdRNzk/XH1oqa7QedcLEFK3XT5YX
	oRQttGnIlMK86maJaOz0nN9Z1fNF1S1jQrBFZqaO+OGS2kRxET7KjCPynQ+iWjF/dHrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCKX-00DOWk-2L; Wed, 12 Feb 2025 13:59:05 +0100
Date: Wed, 12 Feb 2025 13:59:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: phy: Add support for
 driver-specific next update time
Message-ID: <1ffe26ac-c2f2-4947-a570-3dc7e5d05813@lunn.ch>
References: <20250210082358.200751-1-o.rempel@pengutronix.de>
 <20250210082358.200751-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210082358.200751-2-o.rempel@pengutronix.de>

On Mon, Feb 10, 2025 at 09:23:57AM +0100, Oleksij Rempel wrote:
> Introduce the `phy_get_next_update_time` function to allow PHY drivers
> to dynamically determine the time (in jiffies) until the next state
> update event. This enables more flexible and adaptive polling intervals
> based on the link state or other conditions.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

