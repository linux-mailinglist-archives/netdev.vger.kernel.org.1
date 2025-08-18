Return-Path: <netdev+bounces-214702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6321B2AF21
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B12C7A5F86
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CA18871F;
	Mon, 18 Aug 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6GycV2YI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1C32C315;
	Mon, 18 Aug 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537376; cv=none; b=g9ac7KH8aIgPd5QaDcc03PTzbadL5E+LL3ZmTlkq+8G1nIX+c/bGXEVhKYa1wwbcLgPxP1GiFBqm+a/jK5pdNxClQ/amWNpQZTBZl1fd8JaJB/6K4JB+n06/r8XvFTtj3F+VeX6weA2XuWqgBoOxkuUyn2PN9U3Bnmj2m+6pTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537376; c=relaxed/simple;
	bh=yP4Yuj7Z+g7MYpEm26hzQQjwcI9DiuGCs0Bsz/vi958=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibVDr0z4RztfdBkKaMUeeGePqZwZTHgyJiS7Xo+N/vT2/6AYVPlPXcFzHbr8zuA99JFizEuXQuegKEuYAcdAdu9vQ0T+rdtV01LAXQFv69Q0/6U0EP2dN4KZg/1RpnBCy9AHIsag6CGz5UONz4fTz56aFVu8dSsBxvBZ6pxlxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6GycV2YI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LJN+kb/6ymN/RUd8A8NIlH7TTJTdlak3jUaitUEk39k=; b=6G
	ycV2YIRV/Y1dZK5aflMoVTMOvSfW1VAlq52pDeWNK+4ScyLSUhec6EAtHGs3GTSCEB7sZZi6zSfkn
	Ur0JFa9qTMa9ZR5gwd3LfqeZDpIF/dahmi07fLpEhApcVgGQWQC04j0KQRpB56nBhCOWjnT/BFUXk
	c90qrJvao1mIIE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo3So-0055IU-J2; Mon, 18 Aug 2025 19:16:06 +0200
Date: Mon, 18 Aug 2025 19:16:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <a1474d9a-f12c-48cb-881d-bce5fe7c646f@lunn.ch>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
 <20250818162445.1317670-2-mmyangfl@gmail.com>
 <7c4bc4cc-61d5-40ce-b0d5-c47072ee2f16@lunn.ch>
 <CAAXyoMP9aoSbDkSJhSDJ68-F6qubeVmV08YgvQS1cTKJYS-spw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMP9aoSbDkSJhSDJ68-F6qubeVmV08YgvQS1cTKJYS-spw@mail.gmail.com>

On Tue, Aug 19, 2025 at 01:06:00AM +0800, Yangfl wrote:
> On Tue, Aug 19, 2025 at 12:55 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +  motorcomm,switch-id:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Value selected by Pin SWITCH_ID_1 / SWITCH_ID_0.
> > > +
> > > +      Up to 4 chips can share the same MII port ('reg' in DT) by giving
> > > +      different SWITCH_ID values. The default value should work if only one chip
> > > +      is present.
> > > +    enum: [0, 1, 2, 3]
> > > +    default: 0
> >
> > It is like getting blood from a stone.
> >
> > So what you are saying is that you have:
> >
> >     mdio {
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >
> >         switch@1d {
> >             compatible = "motorcomm,yt9215";
> >             /* default 0x1d, alternate 0x0 */
> >             reg = <0x1d>;
> >             motorcomm,switch-id = <0>;
> >             reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> > ...
> >         }
> >
> >         switch@1d {
> >             compatible = "motorcomm,yt9215";
> >             reg = <0x1d>;
> >             motorcomm,switch-id = <1>;
> >             reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> > ...
> >         }
> >
> >         switch@1d {
> >             compatible = "motorcomm,yt9215";
> >             reg = <0x1d>;
> >             motorcomm,switch-id = <2>;
> >             reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> > ...
> >         }
> >     }
> >
> > Have you tested this? My _guess_ is, it does not work.
> >
> > I'm not even sure DT allows you to have the same reg multiple times on
> > one bus.
> >
> > I'm pretty sure the MDIO core does not allow multiple devices on one
> > MDIO address. Each device is represented by a struct
> > mdio_device. struct mii_bus has an array of 32 of these, one per
> > address on the bus. You cannot have 4 of them for one address.
> >
> >     Andrew
> >
> > ---
> > pw-bot: cr
> 
> Of course I cannot test this, since I only have a stock device, as
> mentioned in patch 3.

You could create such a DT and see if it compiles and passes the
binding tests. You could boot such a DT. You should get -ENODEV for
the other two devices. But if it crashes, that tells you
something... Looking at the stack trace might confirm this is never
going to work with the current MDIO core code.

> If this is not acceptable anyway, I might as well remove switch-id
> completely since I doubt if anyone would concat more than one switch
> together in real world.

I have a board with 4 Marvell switches. It does happen, especially in
industrial systems. But they have individual addresses on the MDIO
bus. I also have a SOHO black box switch, using two qualcomm switches
in order to support 16 ports.

But i do agree you are unlikely to see a WiFi AP, or a cable modem use
two switches.

	Andrew

