Return-Path: <netdev+bounces-118488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D5951C34
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A7B23275
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC11B0126;
	Wed, 14 Aug 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aBpOHnEz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1651DA4C;
	Wed, 14 Aug 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643438; cv=none; b=PFxN5/HMd7uVpS+lbNENRSDRKeIGfsYLypfAsimjIwb8e3zr+zr08eeiTsGRkvhpKSmj46pOplxGUqRG/ih8f2EU/HM6zrvlTASC8dBxYzF+Hd7VVXJYq049GNxtxg8YVwAkH+qSGX1r+Acl2uatFF8FzoDL5BxG2KhYIaQ46rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643438; c=relaxed/simple;
	bh=L77S3EQ47II05J3Jqp4pq7LaCKMh2mMq1bPcetyBe6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/rxf6iJK3luGUmHWvrmhqHOtTmuGPm9jD8cLc6NF1W3Z0MBzvlXL7FAgl1WPZC7ShVQPXQyk3IwwjZo0XDj+cPoKrNAD0ajSHBQflolFqsI7RkabPXBWpSSTe3p/7eJ2GsWtHYVIGiAo2MALFhxyrYrpVkwUqFgAgEopFSgCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aBpOHnEz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k2gPQomNmMNNm1/ovY9l8pCGvwEeBiuMBoC6iMko/88=; b=aBpOHnEzqmgwtCozBCSdtc2mIh
	WPkwexFP17B9iiAQLYwD1Cx396dCzWbwA6Fu6KNqARGzd36mO0jLxKQKH717SLrBwzRtOURGeZP0L
	extJlMK0nch4iSDuaKzKikINbbjrqpHUmfVQYUC6/bfQWqNvyBdW0FbMUPeeljCAwx6k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seEOM-004lg6-HL; Wed, 14 Aug 2024 15:50:22 +0200
Date: Wed, 14 Aug 2024 15:50:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marex@denx.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Message-ID: <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
 <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>

On Tue, Aug 13, 2024 at 10:17:03PM +0000, Tristram.Ha@microchip.com wrote:
> > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > >
> > > > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > > > > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> > > > >
> > > > > SFP is typically used so the default is 1.  The driver can detect
> > > > > 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> > > > > has to be explicitly set to 0 as driver cannot detect that
> > > > > configuration.
> > > >
> > > > Could you explain this in more detail. Other SGMII blocks don't need
> > > > this. Why is this block special?
> > > >
> > > > Has this anything to do with in-band signalling?
> > >
> > > There are 2 ways to program the hardware registers so that the SGMII
> > > module can communicate with either 1000Base-T/LX/SX SFP or
> > > 10/100/1000Base-T SFP.  When a SFP is plugged in the driver can try to
> > > detect which type and if it thinks 10/100/1000Base-T SFP is used it
> > > changes the mode to 2 and program appropriately.
> > 
> > What should happen here is that phylink will read the SFP EEPROM and
> > determine what mode should be used. It will then tell the MAC or PCS
> > how to configure itself, 1000BaseX, or SGMII. Look at the
> > mac_link_up() callback, parameter interface.
>  
> I am not sure the module can retrieve SFP EEPROM information.

The board should be designed such that the I2C bus pins of the SFP
cage are connected to an I2C controller. There are also a few pins
which ideally should be connected to GPIOs, LOS, Tx disable etc. You
can then put a node in DT describing the SFP cage:

Documentation/devicetree/bindings/net/sff,sfp.yaml

    sfp2: sfp {
      compatible = "sff,sfp";
      i2c-bus = <&sfp_i2c>;
      los-gpios = <&cps_gpio1 28 GPIO_ACTIVE_HIGH>;
      mod-def0-gpios = <&cps_gpio1 27 GPIO_ACTIVE_LOW>;
      pinctrl-names = "default";
      pinctrl-0 = <&cps_sfpp0_pins>;
      tx-disable-gpios = <&cps_gpio1 29 GPIO_ACTIVE_HIGH>;
      tx-fault-gpios = <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
    };

and then the ethernet node has a link to it:

    ethernet {
      phy-names = "comphy";
      phys = <&cps_comphy5 0>;
      sfp = <&sfp1>;
    };

Phylink will then driver the SFP and tell the MAC what to do.

	Andrew

