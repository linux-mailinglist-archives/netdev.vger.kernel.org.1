Return-Path: <netdev+bounces-220824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E6B48E77
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B372F341653
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B630748A;
	Mon,  8 Sep 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aQR7pTjC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148F3054C7;
	Mon,  8 Sep 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336426; cv=none; b=R+Po2J7L2FgWvWQ+ztV5PAHj8E4M5DJOPN5PfOztDBLxxsYm7dHPvudrEI9E5ZexeRv88LsrVhZPE5SqjdfRwECBX9JBi3twQuUoe1BHgU9efwQoVaHCCzjE4tvwBfQ5jAYOeIgHxOvafH1MOoKJNigyMxU2lgYQb5i1lcuUpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336426; c=relaxed/simple;
	bh=E6KhlwWdAxfXv9SHNqxZBUsW0wsgGmPXP81XxSEheGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpJ7MdI6DahvTTuticCOkwHJMOOGM6ChT1QZBNojWeN6tUm1fHWb5MddAsduNZYb8b26R8foZdsJdJdBto8WV4UaVcf5pR8XMuk95smeHzxUYLRIu+Sic8jnBNiuSxAKba95G7iR+uEtBDKJ8Hy9lXDfT+k02DmQyE3VMfSRqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aQR7pTjC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BvgI7NHtoU/IojYtDK7G/TlNNUny5OqeQ60fseaQGWI=; b=aQR7pTjCA4Nj5UfM08dSZMJQvx
	NP5Gm1tlvO8tYQGZhHC5CT3vNOb3/nx5uBsuyKo8t6w10cwyfKNXoRbYCil1p7qK/BLsgkhobXMGa
	TjS204eyij953JmvzKVXjhnj12qaUbWAYAUkFyPCoiVqDABTmXIiweE5FPnhr94R1HgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvbTj-007fqo-9q; Mon, 08 Sep 2025 15:00:15 +0200
Date: Mon, 8 Sep 2025 15:00:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <4ef60411-a3f8-4bb6-b1d9-ab61576f0baf@lunn.ch>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
 <20250905181728.3169479-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181728.3169479-4-mmyangfl@gmail.com>

> +/* Prepare for read/write operations. Not a lock primitive despite underlying
> + * implementations may perform a lock (could be a no-op if the bus supports
> + * native atomic operations on internal ASIC registers).

It is more than atomic operations. Look at how long you hold the
lock. It is not a simple read/modify/write, you hold it over multiple
reads and writes. If the ASIC provided some sort of locking, it would
be available for MDIO, I2C, and SPI, and probably mean additional bus
transactions.

> + *
> + * To serialize register operations, use yt921x_lock() instead.
> + */
> +static void yt921x_reg_acquire(struct yt921x_priv *priv)
> +{
> +	if (priv->smi_ops->acquire)
> +		priv->smi_ops->acquire(priv->smi_ctx);
> +}

So, as i said in my review to previous versions, skip the if and just
take the mutex. KISS. I would not even call mutex_lock(priv->lock);
Don't over engineer the solution, this will probably work for I2C and
SPI as well.

> +/* You should manage the bus ownership yourself and use yt921x_reg_read()
> + * directly, except for register polling with read_poll_timeout(); see examples
> + * below.
> + */
> +static int yt921x_reg_read_managed(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	int res;
> +
> +	yt921x_reg_acquire(priv);
> +	res = yt921x_reg_read(priv, reg, valp);
> +	yt921x_reg_release(priv);
> +
> +	return res;
> +}

Sorry, i missed your reply to my comment to the previous version. You
said:

> The driver itself does not need an explicit lock (so long as dsa
> framework does not call two conflicting methods on the same port),

The DSA framework makes no such guarantees. The DSA framework is also
not the only entry point into the driver, phylink will directly call
into the driver, and if you implement things like LEDs, they will have
direct access to the driver.

So i suggest only having a high level lock, acquired on entry,
released on exit, e.g. as mv88e6xxx does. KISS.

    Andrew

---
pw-bot: cr

