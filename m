Return-Path: <netdev+bounces-218563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4DB3D42A
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3911B3BF175
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4C92580D1;
	Sun, 31 Aug 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x73FB68d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220D1F4CBB
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654574; cv=none; b=Icx4yUr/eQx0SOGWgxQ4u9OfUHgZg02IUVF96AhjaJsxV0FrGDN26pfu2SzNbwVggyi3+lIWJK++sjgBDW9TQr0z+L/T8ggZetsvI1K+KGE01XSwSbT5QdsMdeUDMU5CZ9CD5XwitrxroLQL4NZxTS1onIvFL+nIYw5fjgEaP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654574; c=relaxed/simple;
	bh=ioF7I4x+C5a+mmR7ncUyxQZSd6YJB/62Wb2Dox6wbVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezuGW7ISRDBgnc1vokbFkvgdUgTl3Xx5h3K9mykIJYhWgq2FR+WLBWl71T2BgqsQM8RiNnnFweWpXdaNXE2omUGTZb9lJlcXjTFM+ETRu6iQu7n8iSQp+a/VncsGKjFudT2jRrpm7TBVTAIv4TOBcDoFH/rCCqHJE6CwZNT8dGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x73FB68d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E7AtFVtMENg3LrmKgd+QzT8fWFYgEcdTPtZHdnpdu90=; b=x73FB68dCGv94PbFODLUc0Oqqz
	kBIoFVI8fz0+b/FFkszGkIu5Oif3ovx4NWjW0JwoGKaJZQBfkkulTxKUfpANEbcdSziqTfYhFmP7e
	xE6UNELrxOemQJA4Z16iWZO9lw5xaFNN0FoGTmV7TNpxRvvVAH/BrIUsw9jvfKTd6dJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usk5y-006en8-FD; Sun, 31 Aug 2025 17:35:54 +0200
Date: Sun, 31 Aug 2025 17:35:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: markus.stockhausen@gmx.de, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, jan@3e8.eu,
	'Chris Packham' <chris.packham@alliedtelesis.co.nz>
Subject: Re: C22/C45 decision in phy_restart_aneg()
Message-ID: <a78381ed-cee6-4a1f-b352-886d6e92f7cf@lunn.ch>
References: <009a01dc1a4b$45452120$cfcf6360$@gmx.de>
 <aLQfGgYfTdcCFHtC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLQfGgYfTdcCFHtC@shell.armlinux.org.uk>

> > In our case, this function fails for C45 PHYs because the bus and PHY are 
> > locked down to this single mode. It's stupid, of course, but that's how 
> > it is. I see two options for fixing the issue:
> > 
> > 1) Mask the C22 presence in the bus for all PHYs when running in C45.
> > 2) Drop the C22 condition check in the above function.
> 
> I guess we also need to make these kinds of tests conditional on
> whether the bus supports C45 or not.
> 
> static bool mdiobus_supports_c22(struct mii_bus *bus)
> {
> 	return bus->read && bus->write;
> }
> 
> static bool mdiobus_supports_c45(struct mii_bus *bus)
> {
> 	return bus->read_c45 && bus->write_c45;
> }

Something i've said in the past is that we have a mess regarding what
does phydev->is_c45 mean? And really, this is an extension of that
mess.

There are two separate C45 concepts which get mixed up in is_c45.

One concept is, does the PHY have the C45 register address space?  The
second concept is, how do you access the C45 address space? Via C45
bus transactions, or C45 over C22 bus transactions.

The extension here is, does the PHY have the C22 address space, and
what sort of bus transactions do you use to access the C22 address
space. It is however simplified, there is no C22 over C45 as far as i
know. So it is actually, can you do C22 bus transactions or not?

I've tried in the past to get developers to sort out this mess, but it
never got very far. Maybe we can use this as an opportunity to address
a little bit of the problem?

> This should be fine, because we already require MII bus drivers to only
> populate these methods only when they're supported (see commit
> fbfe97597c77 ("net: phy: Decide on C45 capabilities based on presence
> of method").
> 
> 	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0))
> 
> can then become:
> 
> 	if (phydev->is_c45 &&
> 	    !(mdiobus_supports_c22(phydev->mdio.bus) &&
> 	      phydev->c45_ids.devices_in_package & MDIO_DEVS_C22PRESENT))

So what we are asking here is, can we do C22 bus transfers, and does
the PHY have the C22 address space? And looking in the code, there are
at least three places this is needed:

int phy_restart_aneg(struct phy_device *phydev)
{
        int ret;

        if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
                ret = genphy_c45_restart_aneg(phydev);
        else
                ret = genphy_restart_aneg(phydev);

        return ret;
}

int phy_aneg_done(struct phy_device *phydev)
{
        if (phydev->drv && phydev->drv->aneg_done)
                return phydev->drv->aneg_done(phydev);
        else if (phydev->is_c45)
                return genphy_c45_aneg_done(phydev);
        else
                return genphy_aneg_done(phydev);
}

This i _think_ is currently broken, i would expect the same condition
to apply.

int phy_config_aneg(struct phy_device *phydev)
{
        if (phydev->drv->config_aneg)
                return phydev->drv->config_aneg(phydev);

        /* Clause 45 PHYs that don't implement Clause 22 registers are not
         * allowed to call genphy_config_aneg()
         */
        if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
                return genphy_c45_config_aneg(phydev);

        return genphy_config_aneg(phydev);
}

So maybe we should add new members to phydev?

@bus_has_c22: The bus can perform C22 transactions
@phy_has_c22_regs: The PHY has the C22 register address space.

During probe, we set bus_has_c22 based on Russells
mdiobus_supports_c22() above. phy_has_c22_regs should be set if we
discover the PHY by C22 ID registers, or
phydev->c45_ids.devices_in_package indicates the PHY has C22
registers. We also need to handle the PHY is instantiated via ID
values in DT. After the PHY has probed, we can read C22 registers 2
and 3, and see if the ID look valid, i.e. mostly not F, same as we do
in get_phy_c22_id().

The condition then becomes:

        if (phydev->is_c45 && !(phydev->bus_has_c22 && phydev->phy_has_c22_regs))

Then maybe some time in the future, the is_c45 will get replaced with
something similar?

	Andrew


