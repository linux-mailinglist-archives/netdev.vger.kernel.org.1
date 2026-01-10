Return-Path: <netdev+bounces-248717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C096D0DA33
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C72C3017388
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA493260565;
	Sat, 10 Jan 2026 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RHmUymfQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FB42050
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768068196; cv=none; b=ZALl3wRgig9D6ISMf+DlHqoK9TvRJA3iWfl8l/MOgAJPoRDmuqtgZQNVDVjhEuKUe3a0cwZ0vCjVTrt7FanLO9i1sBo+OaDYWqMf82yuu/A8pSKQFkIxPa6xK5tc9rSwdJgWTvYzyKMbvAJjY7HhmE0i0ql+Rh4deSLxr8pokI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768068196; c=relaxed/simple;
	bh=Y3M13yX1GDA4IKyBoWKOb141DqNdP58ED/lYnWUYGmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7RHbOjuHqlBUVjb4QgacRPbWxoZuuC6Zwp1YFvovSgD12O/m6S8120Cw3ZgNigD1hoPId54BGcm3hpQp6PM3n1gJ/7LMJTM2MBCDiQKSdN7UOzgLfLR6jrSaCu2Te8BiHIBoJ48AHZ7DTvlFxvTNkWTsEEpsS6zp7KJktBu3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RHmUymfQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pmjd5+OSPwqV3VnIxNBfOCjzBvR0EJ98Ul3K6QCDcB8=; b=RHmUymfQeaFJYQS4GsAiLREP5O
	Buy0IAFN95kmOWz+MyK4Bgnt4TaIRKbysN9n7LamulFAL654gZn7FEWGPlgvwCuc/7zpKmLhjf3Xf
	74PHUCuqjxEIBCa83kflGakRChCuWcNcdei8EtmDrFyhA/NPlsiVe09b26EfmguARNac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vedIr-002EC7-Pg; Sat, 10 Jan 2026 19:03:09 +0100
Date: Sat, 10 Jan 2026 19:03:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RESEND net-next v2 3/5] net: ethtool: Add define for
 SPEED_80000
Message-ID: <a5ddfc39-57d3-4ac3-8209-86429c4dbe0a@lunn.ch>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-4-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109122606.3586895-4-mika.westerberg@linux.intel.com>

On Fri, Jan 09, 2026 at 01:26:04PM +0100, Mika Westerberg wrote:
> USB4 v2 link used in peer-to-peer networking is symmetric 80 Gbps so in
> order to support reading this link speed, add it to ethtool.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/uapi/linux/ethtool.h | 1 +

Hi Mika

There are a few other places which should be updated when a new speed
is added:

https://elixir.bootlin.com/linux/v6.18.4/source/drivers/net/phy/phy-core.c#L18
https://elixir.bootlin.com/linux/v6.18.4/source/drivers/net/phy/phy_caps.c#L9
https://elixir.bootlin.com/linux/v6.18.4/source/drivers/net/phy/phy_caps.c#L30
https://elixir.bootlin.com/linux/v6.18.4/source/drivers/net/phy/phylink.c#L307

    Andrew

---
pw-bot: cr

