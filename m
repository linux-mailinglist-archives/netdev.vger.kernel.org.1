Return-Path: <netdev+bounces-118656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3119525E0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32B22828E8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2614AD0A;
	Wed, 14 Aug 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VVMsdcVa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074714900E;
	Wed, 14 Aug 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675258; cv=none; b=l3GzIV30B9xr03I4jRxR2Dow4EoSUorM62kEQycEnrocUK3xbiddRbHBTMOekz9ULVVXevRUBd33vHAwHiAjlxXsVfheei0Ve3PHx22HniN4sNrUUQULuSVuHTnPD3VMXl6GoiFOV9hI2aWdVuHh5kNqklgbmJWu3urPaqv1dT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675258; c=relaxed/simple;
	bh=012qWjFcXHvJxGFI3ewDgtFYGDwmYmUSmtkoQc4FfBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWRHbFjsyh3jXe+4gNo+7Wna7KrW9rU7EIrZ/D8ECq7nNCAi9pyXr7ZMGSqLZ+inKy5/nK/2Eq1AEG+NaDb+s3JVDAvtMN9A0Eoa7FAK/ys88ruqF14+z5wYAqzKd9b83X1oapQVghg+DggcMFPFqDL3QGmgWPWaJp+ss8b4p4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VVMsdcVa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TEl/SlxA1xVlzUpkGUWQyXMGv73dhmpW6HQm+tKJpkU=; b=VVMsdcVaSP3wXqKYIpq4Bdj/7w
	xpDXP61QW0a6VjEk+AT+2E0sDJcweEv17SxFfZhhh6p92qpiENB+jPkTAB7+BD1EwFuBY2WhM+62O
	9jiNewpfsnqAa1J6i0f25A8ZMWw4BLGDXrBCHEdPFqfeLr8zNdNbd4Fy6WkEzgl1hTto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seMfR-004o5X-9Z; Thu, 15 Aug 2024 00:40:33 +0200
Date: Thu, 15 Aug 2024 00:40:33 +0200
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
Message-ID: <4d4d06e9-c0b4-4b49-a892-11efd07faf9a@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
 <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
 <MN2PR11MB3566A463C897A7967F4FCB09EC872@MN2PR11MB3566.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB3566A463C897A7967F4FCB09EC872@MN2PR11MB3566.namprd11.prod.outlook.com>

> > The board should be designed such that the I2C bus pins of the SFP
> > cage are connected to an I2C controller. There are also a few pins
> > which ideally should be connected to GPIOs, LOS, Tx disable etc. You
> > can then put a node in DT describing the SFP cage:
> > 
> > Documentation/devicetree/bindings/net/sff,sfp.yaml
> > 
> >     sfp2: sfp {
> >       compatible = "sff,sfp";
> >       i2c-bus = <&sfp_i2c>;
> >       los-gpios = <&cps_gpio1 28 GPIO_ACTIVE_HIGH>;
> >       mod-def0-gpios = <&cps_gpio1 27 GPIO_ACTIVE_LOW>;
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&cps_sfpp0_pins>;
> >       tx-disable-gpios = <&cps_gpio1 29 GPIO_ACTIVE_HIGH>;
> >       tx-fault-gpios = <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
> >     };
> > 
> > and then the ethernet node has a link to it:
> > 
> >     ethernet {
> >       phy-names = "comphy";
> >       phys = <&cps_comphy5 0>;
> >       sfp = <&sfp1>;
> >     };
> > 
> > Phylink will then driver the SFP and tell the MAC what to do.
> 
> I do not think the KSZ9477 switch design allows I2C access to the SFP
> EEPROM.

This is not a switch design issue, it is a board design issue. Plenty
of Marvell switches have a PCR which do SGMII and 1000BaseX. Only the
SFP SERDES data lines are connected to the switch. The I2C bus and
other lines are connected to the SoC, not the switch.

Do you have the schematics for the board you are testing on? Is it
open? Can you give us a link?

	Andrew

