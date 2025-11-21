Return-Path: <netdev+bounces-240772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9AC79C5A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2723C2F25E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1E34FF42;
	Fri, 21 Nov 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z4ZZxd8r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6A3242B0;
	Fri, 21 Nov 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732994; cv=none; b=JSobePOwmTHIkXPMXLIPGaXDEly7IiD22aZ0JEKPP1jR7bK3HbnynNurcX/wkehr7g/iXT6rpSL3uLCd1oq3zYH/qJkcOJNpLxIR2IBoLnK94svaD9nQBevYfxNgKC3o7HrObYkoCcpCcV3cP9uQJHhNF6l8BnQgOh3fzC/82AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732994; c=relaxed/simple;
	bh=QmkNw+lui6eQ4hjUROLo+jeuKO6ffm/m+JR0/j7ewkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVwFyhTozA5kb3Wvf3GjKhx4Q7tI+bKtcfbIfYv5EPCowb97aAes+bmW3odwbOaft1UI6Kj1s8lXihIkflD2bLjm73hzt5/mXy7NSEVUdmwq5NZkafj9apBZ4Q4MTQdD1HyWituSN5BL/Wgcyl2MVlsdMX4NEVPAt2fV8Ez98zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z4ZZxd8r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ojEjdCjByEtRAyY2XHxAhRGYC0BgnRG/RIl16AmKynw=; b=z4ZZxd8rFNn0gwXgzZ1L4Lr2N2
	Oa5e6yMVCLXSB9T+NGShgGnWdgzAG/Ba/eKrHeYhp4iZqq/AIqFMJKwLzI3Wq4cpHveCMGk9C99Lb
	FPpAvExax+zo4fCphIZciwlzGc6cqrARdNS5XSCCynbbZfaWb0lbTOhOzLgWXigUicjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vMRW6-00EjjM-3e; Fri, 21 Nov 2025 14:49:38 +0100
Date: Fri, 21 Nov 2025 14:49:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: mdio: eliminate kdoc warnings in
 mdio_device.c and mdio_bus.c
Message-ID: <7d16f840-40d0-4eff-91f5-c977404ca6fc@lunn.ch>
References: <b0313adbbb1232b6fd8d44c7eb8601aaac61818f.1763711078.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0313adbbb1232b6fd8d44c7eb8601aaac61818f.1763711078.git.buday.csaba@prolan.hu>

On Fri, Nov 21, 2025 at 08:45:42AM +0100, Buday Csaba wrote:
> Fix all warnings reported by scripts/kernel-doc in
> mdio_device.c and mdio_bus.c
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
>  drivers/net/phy/mdio_bus.c    | 56 ++++++++++++++++++++++++++++++-----
>  drivers/net/phy/mdio_device.c |  6 ++++
>  2 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index ef041ad66..a00dc7451 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -339,7 +339,7 @@ EXPORT_SYMBOL_GPL(mdio_bus_class);
>   * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
>   * @mdio_name: The name of a mdiobus.
>   *
> - * Returns a reference to the mii_bus, or NULL if none found.  The
> + * Returns: a reference to the mii_bus, or NULL if none found. The
>   * embedded struct device will have its reference count incremented,
>   * and this must be put_deviced'ed once the bus is finished with.
>   */
> @@ -357,7 +357,7 @@ EXPORT_SYMBOL(mdio_find_bus);
>   * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
>   * @mdio_bus_np: Pointer to the mii_bus.
>   *
> - * Returns a reference to the mii_bus, or NULL if none found.  The
> + * Returns: a reference to the mii_bus, or NULL if none found. The

In these two cases you use "Returns:"

>   * embedded struct device will have its reference count incremented,
>   * and this must be put once the bus is finished with.
>   *
> @@ -405,6 +405,8 @@ static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
>   * @addr: the phy address
>   * @regnum: register number to read
>   *
> + * Return: The register value if successful, negative error code on failure


And everywhere else "Return:".

It would be nice if it was consistent.

	Andrew

