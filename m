Return-Path: <netdev+bounces-144105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6499C5B06
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7C8B320AC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE871FBF6C;
	Tue, 12 Nov 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WzN4faAC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A51FBF69;
	Tue, 12 Nov 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419426; cv=none; b=Ztqhl7lHd+S1X6By3w/KyQp6Hdp8Ybx+Z/HXxNaCsLoczEk/Osu3vk5MAf0wynNspb3okNuYi2ZjpX69r0ln3JiAb+7xbs3ZtFW/Ui304Nf44y7K/HXuex91bfyr5ABHAAcYKxiIvASW/5cT8YJZrza/LUps7rhnlA0Pmu36HMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419426; c=relaxed/simple;
	bh=23YyCjbwBAijNPWYmfJkXL8K/4xOrP3oeVxaL7oa0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8bcbq1T1bsa0PPXpjObyklcpB3Gg8xoNxN8GuZrZDqQjOPbq6VFHoYw7Q0R+26OSaPWkVHzpspdQ7e2C5/EdXphETCRbi/gy0d2mb0j3HxXWxL6SzvBjagY7paN/IfOO3M2nc8gJo8UnMTUxWV8oo14KGafTvlLNaUrKtOyyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WzN4faAC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PAZREJW+aSaaTf3gacNdlLm+fyoS5JjUlA9TaeZpbJo=; b=WzN4faACh1+ZeQEAPhIDEd2kKO
	+D7ac4hJXXnYXfIrXYdmt1q4gRdtAnqZB4nBBahEz77b7OAN0Louzr1tPPi+1X90pEbjBl5F0juTW
	H0+0dqlxJpxmJefJBjcnJ+ZW71Ptfr3/pv/kfd9YyY4yImvpxrvob7eAy+/irThr0CKs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tArHc-00D2BH-BR; Tue, 12 Nov 2024 14:50:16 +0100
Date: Tue, 12 Nov 2024 14:50:16 +0100
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
Message-ID: <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>

On Tue, Nov 12, 2024 at 02:55:29AM +0000, Tristram.Ha@microchip.com wrote:
> > On Fri, Nov 08, 2024 at 05:56:33PM -0800, Tristram.Ha@microchip.com wrote:
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > > connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT SFP.
> > 
> > This naming is rather odd. First off, i would drop 'SFP'. It does not
> > have to be an SFP on the other end, it could be another switch for
> > example. 1 is PHY_INTERFACE_MODE_1000BASEX and 2 is
> > PHY_INTERFACE_MODE_SGMII.
> > 
> > > SFP is typically used so the default is 1.  The driver can detect
> > > 10/100/1000BaseT SFP and change the mode to 2.
> > 
> > phylink will tell you want mode to use. I would ignore what the
> > hardware detects, so this driver is just the same as every other
> > driver, making it easier to maintain.
> 
> There are some issues I found that will need your advises.
> 
> The phylink SFP code categorizes SFP using fiber cable as
> PHY_INTERFACE_MODE_1000BASEX and SFP using a regular RJ45 connector as 
> PHY_INTERFACE_MODE_SGMII, which has a PHY that can be accessed through
> I2C connection with a PHY driver.

Not quite correct, i think. If MDIO over I2C does not work, it will
still decide on 1000BaseX vs SGMII from the SFP eeprom contents. There
are some SFPs where the PHY is not accessible, and we have to live
with however it is configured.

> Now when SGMII SFP is used the phylink
> cannot be created because it fails the validation in
> phylink_sfp_config_phy().

Please stop using 'SGMII SFP'. It should just be SGMII. The MAC should
not care what is on the other end, it could be a PHY, and SFP, or a
switch, all using Cisco SGMII.

> The reason is the phydev has empty supported
> and advertising data fields as it is just created.

Do you mean the phydev for the PHY in the SFP? Or do you have a second
phydev here? I'm confused.

> I mentioned the SGMII module operates differently for two types of SFP:
> SGMII and 1000BASEX.  The 1000Base-T SFP operates the same as 1000Base-SX
> fiber SFP, and the driver would like it to be assigned
> PHY_INTERFACE_MODE_1000BASEX, but it is always assigned
> PHY_INTERFACE_MODE_SGMII in sfp_select_interface because 1000baseT_Full
> is compared before 1000baseX_Full.
> 
> Now I am not sure if those SFPs I tested have correct EEPROM.  Some
> no-brand ones return 0xff value when the PHY driver reads the link status
> from them and so that driver cannot tell when the link is down.  Other
> than that those SFPs operate correctly in forwarding traffic.

There is no standardisation of how you access the PHY in an SFP. So
each manufacture can do their own thing. However, there are a small
number of PHYs actually used inside SFPs, and we have support for
those common ones.

> It seems there is no way to assign an interupt to that PHY and so polling
> is always used.

Correct, the interface between the SFP and the SFP cage does not have
an interrupt pin the PHY can use.

> The SFP using fiber cable does not have the above issues but has its own
> issue.  The SFP cage can detect the cable is being plugged in as the
> light is detected.  The PCS driver is then consulted to confirm the link.
> However as the cable is not completely plugged in the driver can report
> the link is not up.  After two calls are done the port can be left into
> unconnected state forever even after the cable is plugged in.  The driver
> can detect there is something different about the link value and can try
> to read it later to get a firm reading.  This just means the driver needs
> to poll anyway.  But if interrupt is used and the driver uses it to
> report link this issue is moot.

Have you set pcs.poll? phylink will then poll the PCS every
second. You can report PCS status any time.

> I just feel the SFP code offered in the phylink model does not help to
> operate SFP well in the KSZ9477 switch, and it does not need that code to
> provide basic SGMII port connection.

We need to understand what is different about the KSZ9477 switch that
phylink does not work for it, yet phylink does work for mv88e6xxx,
sja1105, rzn1, qca, ocelot, and other MAC drivers.

	Andrew

