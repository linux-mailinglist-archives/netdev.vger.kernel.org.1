Return-Path: <netdev+bounces-144642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8E9C8022
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20261F24680
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EA1E3799;
	Thu, 14 Nov 2024 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fqCvG48T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB31C1AA9;
	Thu, 14 Nov 2024 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548662; cv=none; b=gP6dpBciRkaJeaspm9WtS8cgQACAdMEsF/QID35y4v8MxFcQeXb8OsDMmdd9vAZcKWqEXSW5ZLf48HhSGEHm9LRErZCzMRwwiesarFlgW7vwgN0Kg6ouRggk0913wP/a0axgcPiFv72G2Pm7c+Rdc4VFR5sXmfd8bSkgyoHuqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548662; c=relaxed/simple;
	bh=IrVRJg3WLhTz8lAzrA6Li6rKoq9acM6m6RQtWvY5vEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEZMIP3dGgJCn/OFJtfA0wJ+UlyoDP+Zi436Mpbx29x+Rnga6IC5AE9eBZ5BszOvACoDlDa3AeODcdevOFIwHXaNSzvy4R182LeXQNnPq3hNqWJkbaNYuMCAWtFfyi51eXzgyq5bNX4tY6kgJLU1yzgMxuVW7A4C4zBwYYzj75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fqCvG48T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8iXMgS+nqM8nHclZ1ysTcXy7y7OSuJIYtAZoKROY0EE=; b=fqCvG48TOaP5r3usPPYs1U4FnX
	4PRWbhBktP2oO4czKwOuv8DK6Pmcvp0O22DoOwQ4erlsmHJTNxhlPfmuuBJvzLQXWOke1JtkTHt0O
	DaUjhOx7et262E6YNMO/I1KscznzjF5upm4uP/pJhhYEUNPYr4giOtdigRAgQYdUqUJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBOtq-00DEPq-Gk; Thu, 14 Nov 2024 02:43:58 +0100
Date: Thu, 14 Nov 2024 02:43:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, olteanv@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <1fcb11da-e660-497b-a098-c00f94c737f5@lunn.ch>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>

> When the SFP EEPROM says it does not support 1000Base-T then the SFP bus
> code does not consider the SFP has a PHY and skips creating a MDIO bus
> for it and phylink_sfp_config_optical() is called to create the phylink.

There are many SFPs out there with broken EEPROM contents. Do the SFPs
you have say they are not 1000Base-T but actually are? If so, they are
broken, and need a quirk adding.

Russell King keeps a database of SFP EEPROM contents. Send him the
output of `ethtool -m eth42 raw on hex on` 

> Now back to the discussion of the different modes used by the SGMII
> module.  I think a better term like SerDes can be used to help
> understanding the operation, although I still cannot narrow down the
> precise definitions from looking at the internet.  SGMII mode is
> said to support 10/100/1000Mbit.  This is the default setting, so
> plugging such SFP allows the port to communicate without any register
> programming.  The other mode is SerDes, which is fixed at 1000Mbit.  This
> is typically used by SFP using fiber optics.  This requires changing a
> register to make the port works.  It seems those 1000Base-T SFPs all run
> in SerDes mode, at least from all SFPs I tried.

There is a comment in the code:

/* Probe a SFP for a PHY device if the module supports copper - the PHY
 * normally sits at I2C bus address 0x56, and may either be a clause 22
 * or clause 45 PHY.
 *
 * Clause 22 copper SFP modules normally operate in Cisco SGMII mode with
 * negotiation enabled, but some may be in 1000base-X - which is for the
 * PHY driver to determine.

So the default is SGMII for copper SFPs, but there are a few oddballs
using 1000BaseX. The Marvell PHY driver should figure this out, and
the phylink will tell you want mode to use.


> The issue is then phylink assigns SGMII phy mode to such SFP as its
> EEPROM just says 1000Base-T support and not 1000BASEX phy mode so that
> the DSA driver can program the register correspondingly.  Because of that
> the driver still needs to rely on its own detection to find out which
> mode to use.
>  
> > Have you set pcs.poll? phylink will then poll the PCS every
> > second. You can report PCS status any time.
> 
> I know about PCS polling.  The SFP cage driver can provide link_up and
> link_down indications to the phylink driver.

The SPF cage provides LOS, Loss of Signal. This basically means there
is light coming into the SFP, but not much more. It is not a
trustworthy signal on its own. Phylink combines this with the PCS
status, does the PCS also have link. You need the combination.

> One more issue is if a SFP is not plugged in eventually the SFP driver
> says "please wait, module slow to respond."

Something is wrong with your GPIOs. Phylink thinks there is a module
inserted, when in fact there is not. Add #define DEBUG 1 to the very
top of sfp.c, so you can see the state transitions. I guess there is
something wrong with the MODDEF0 GPIO.

	Andrew


