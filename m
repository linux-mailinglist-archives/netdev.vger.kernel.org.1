Return-Path: <netdev+bounces-213871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57552B272CF
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DE3188B1C6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075E288503;
	Thu, 14 Aug 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qb75p/oo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9012882BC;
	Thu, 14 Aug 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212987; cv=none; b=j+prE7K+JdDcoV+s00R0GKRTIdcF3o8AlwxLCM+rTJ/DghU+Q8f7PHypqdJz0/eW24lNxB9Onpqn/Mgbi2x24OW9XXBKp9sn6f8cT5d2wScZKWKzbtroXLy/dFTUjkKFpGNnUMdAT9DZN5z69pLIf4WKQ1+lrKi+s0ckP8SqIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212987; c=relaxed/simple;
	bh=mKoae9MecbXNFCvFS646eLVMVdadneD5NIJTRY7VQzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxPoZu7+vlUpXuYDhi9aJo2o93DRAeePGnbjXlryjQONb3xzUaJmCwRkpt40GtjFC1Q73bTMIzlZHXkdxOKFf2Lmos5vQR9Q0fXxxWuoBe3LRRnS8JspWoXnE/X6sMUFKxianQm8Oqmc1W523/pEXibdCW+LAo/19TDFiZX9Hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qb75p/oo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DTCz0hGBofhdVx2iiYQG59mbPXFd0G/0V1YI5EH/HnY=; b=qb75p/ooganBGScylMakCyEKE3
	UJqcQFio0tRaQn9LEgPbPgZdgLngcJ12CfXXLFyr1dmXvzEH6H/VvWgOfFBlz7ASKQnIcyzjO60u0
	s0MeUYqyEK8eWBCP28GtCgTBnMo4V/nROYOJ1xkVO9FPCI5Yg0NDEbjV40wB+mPl0Os8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umh4j-004l3a-GY; Fri, 15 Aug 2025 01:09:37 +0200
Date: Fri, 15 Aug 2025 01:09:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <0c94e763-8963-4a04-8157-87725e80075c@lunn.ch>
References: <20250814065032.3766988-1-mmyangfl@gmail.com>
 <20250814065032.3766988-2-mmyangfl@gmail.com>
 <ef95652d-eafd-45e1-9603-16c4edcb8e9e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef95652d-eafd-45e1-9603-16c4edcb8e9e@kernel.org>

> > +  motorcomm,switch-id:
> > +    description: |
> > +      When managed via mdio, hard-configured switch id to distinguish between
> > +      multiple devices.
> 
> IDs are not allowed.

Please describe in more detail what this is used for.

When the switch is hanging off an MDIO bus, there is a reg
property. Maybe that is what you mean here? Take a look at mv88e6xxx,
and other DSA devices which are on MDIO busses.

> > +    enum: [0, 1, 2, 3]
> > +    default: 0
> > +
> > +  mdio:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description: MDIO bus for the internal GbE PHYs.
> > +
> > +  mdio-external:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description: External MDIO bus.
> > +
> > +    properties:
> > +      compatible:
> > +        const: motorcomm,yt921x-mdio-external
> 
> Incomplete compatible... but also not needed in the first place.

So this device has two MDIO busses. You need to somehow describe each
in DT, so you can PHYs off them. And you need to know which is
which. For mv88e6xxx, which i know is maybe not the best example
because a lot of best practices have changed since then, some variants
also have two MDIO busses, and we give the second one a compatible so
we can tell it part from the other which is common to all mv88e6xxx
devices.

	Andrew

