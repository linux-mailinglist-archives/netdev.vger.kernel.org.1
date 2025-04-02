Return-Path: <netdev+bounces-178860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41394A79391
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C623ADA60
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56BD199FA2;
	Wed,  2 Apr 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NYef/jus"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BB19A28D
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613340; cv=none; b=innjV7Lj/ETGFqZoR6VgpG+/U/wAETZ+f+yNnMIH3gt4a2fUgMVAFDZ05JFxfuWF/zchhg7rGzBwJQI2In5SadhZDI1ft6IDQOHEQVIvdj4+q88FKZ/8ntspJNWs5g1FRN0FBFBvQA5NGVpAoCHHqQHVBIFdl1pTjqnrzG4Taaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613340; c=relaxed/simple;
	bh=U7nGPWhznSJJshLcgPP3rxrOguZGpWuN7J34i3nO9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqmA9PcP110RYdsn2i7bfaCO4QK3uz/HLxiprL1ZioXXTpKFGHHh8EJ6oAIt/9+k8a3bhOC1Vv4lo8cMMrR42cKEEqX/AIllLhFmkjxoCxZf6pSXAwtHuwTOZBNkSAztnVJ30D3JZN4HWDbajjiOz/jcLIVFPPk/Nl8t22u4WxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NYef/jus; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0pw8Fy8YqVSg6jRY5P9k4xRL+vea0CWDVg+v/OcYwcc=; b=NYef/jusGDxLoCWon9jx4Zgslg
	GLzp9wsLH+7qFGkTk3FJWwE86BzNEhQ0Vcq6jJWBUbAIeLRNDO5ng1DbgkScrofhR8FkrTQj2dbtp
	5XwyvSjS8NUVzuvfB56VKrscv6SEwxrEAhL87WIthCxWGQd47cvCAL2uqS45BB6UZVHObVN2pwgYN
	4Vm4JLZvkuT5BR6Djny+w2Tjp0zxIe0FKGcTzzx8invefIf0n/FsIyGDir94WSuNbSFf2kuhoeU8+
	bsj8oW840wbDKraUSc9Nld7L6pFcDbPrMVdVCkZ0/NDz5zxfVg8ne4JOEd4usBQPLoZJ1UMrzXSzJ
	bdIJj3+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41948)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u01TZ-0007vT-2z;
	Wed, 02 Apr 2025 18:02:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u01TV-0003rm-2i;
	Wed, 02 Apr 2025 18:02:01 +0100
Date: Wed, 2 Apr 2025 18:02:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH v2 net 2/2] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
Message-ID: <Z-1tiW9zjcoFkhwc@shell.armlinux.org.uk>
References: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
 <20250402150859.1365568-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402150859.1365568-2-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 02, 2025 at 06:08:59PM +0300, Vladimir Oltean wrote:
> DSA has 2 kinds of drivers:
> 
> 1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
>    their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
> 2. Those who don't: all others. The above methods should be optional.
> 
> For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
> and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
> These seem good candidates for setting mac_managed_pm = true because
> that is essentially its definition, but that does not seem to be the
> biggest problem for now, and is not what this change focuses on.
> 
> Talking strictly about the 2nd category of drivers here, I have noticed
> that these also trigger the
> 
> 	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
> 		phydev->state != PHY_UP);
> 
> from mdio_bus_phy_resume(), because the PHY state machine is running.
> 
> It's running as a result of a previous dsa_user_open() -> ... ->
> phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
> supposed to have called phy_stop_machine(), but it didn't. So this is
> why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
> runs.
> 
> mdio_bus_phy_suspend() did not call phy_stop_machine() because for
> phylink, the phydev->adjust_link function pointer is NULL. This seems a
> technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
> machine restart on resume"). That commit was written before phylink
> existed, and was intended to avoid crashing with consumer drivers which
> don't use the PHY state machine - phylink does.

I think this is a historical bug (as I believe I previously mentioned,
suspend/resume support wasn't tested with phylink as none of the
platforms it was developed against had suspend/resume support.)

phylink should be no differnet from a MAC that uses phylib and supplies
an adjust_link function. The exception is when mac_managed_pm has been
set.

Reading commit fba863b81604 ("net: phy: make PHY PM ops a no-op if MAC
driver manages PHY PM") which introduced mac_managed_pm, this flag
should be set whenever a MAC driver causes phy_start() to be called
via its resume path. That means for a phylink using MAC driver calling
either phylink_start() or phylink_resume() from its resume method.

Setting that flag will have the effect that, in those cases,
mdio_bus_phy_suspend() and mdio_bus_phy_resume() become no-ops.

Now, if the MAC driver does not call either of those two phylink
functions, then mac_managed_pm should not be set, and the mdio bus
PHY suspend/resume should happen in full - because a phylink driver
should be no different from a phylib driver that's supplied an
adjust_link callback.

So yes, I think the principle of your patch is correct, and I agree
that this is needed (just coming to the same conclusion from a
different direction.)

> +static bool phy_uses_state_machine(struct phy_device *phydev)
> +{
> +	if (phydev->phy_link_change == phy_link_change)
> +		return phydev->attached_dev && phydev->adjust_link;
> +
> +	return phydev->phy_link_change;

I think this can be simplified to:

	return phydev->phy_link_change != phy_link_change ||
	       (phydev->attached_dev && phydev->adjust_link);

since phydev->phy_link_change should never be NULL (the hook exists
specifically for phylink's usage, and is either set to phy_link_change
or phylink_phy_change.)

If it were to be NULL, then anything which calls phy_link_(up|down)
will oops the kernel - not just the state machine, but cable testing,
loopback, and changing EEE settings.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

