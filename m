Return-Path: <netdev+bounces-109322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4B927E76
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB5281972
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBC139597;
	Thu,  4 Jul 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EGhoQSVd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE01755B;
	Thu,  4 Jul 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127518; cv=none; b=izH5Dv6RqGci9+BfviWauX+maWgIBWHvL0UWA+i+Bi295F6NKYQh8kDycuKtHEjEwe1S7jApHFJmpkdTdgn/aihf/c60dES/IbcUwpLzabtcJtX2p2DO9qAfBw7k31lHu0CWislciCBNSvjqTNKDhnDtJoplIWaE/ezgk/ay5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127518; c=relaxed/simple;
	bh=1HtV605rr1/Y3GdSz1tJZ3XhiXaiq/FJwY3hYlYAuq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0YwVyn2Mq37kO0fwry7CAuUERDkDomNlsA9x4XjGkiccURbDdRRH9rUdllcEm5KRxVxYJmgjruFe7p5sGKw0o3MaQHRmJlmSG4Kvq1cuJlwlRGMIsKt2gFvheSXZZUC1WSU1mDguieRkTBvSzeXvBmgnoIxSu4qGbvD1t71/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EGhoQSVd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iS4Ki0FfgKFDGFlTkcQJD+T+q8NKxHbuR15GMQm4etM=; b=EGhoQSVdSKOnHDaL16nn+ug5Si
	zukYO68rDkOFds4nGPLCNHEQqOgCqOEQWCETTUMe2dUduxmH08c11Mx7BWZTwuBcYBZJjiTDAoU58
	CZLQgJ4qJ3Z6pdKLWJSm8tPF6s0tWy6vsPer5mn6jwS7/LUUYca1Yv2i+cCKMlD5f/4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPTjx-001qMx-7h; Thu, 04 Jul 2024 23:11:41 +0200
Date: Thu, 4 Jul 2024 23:11:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <35d571bd-251d-45b5-9e4f-93c83d1a43c8@lunn.ch>
References: <20240704140413.2797199-1-kamilh@axis.com>
 <20240704140413.2797199-4-kamilh@axis.com>
 <20240704-snitch-national-0ac33afdfb68@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-snitch-national-0ac33afdfb68@spud>

> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 8fb2a6ee7e5b..349ae72ebf42 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -93,6 +93,14 @@ properties:
> >        the turn around line low at end of the control phase of the
> >        MDIO transaction.
> >  
> > +  brr-mode:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If set, indicates the network cable interface is alternative one as
> > +      defined in the BroadR-Reach link mode specification under 1BR-100 and
> > +      1BR-10 names. The driver needs to configure the PHY to operate in
> > +      BroadR-Reach mode.
> 
> I find this second sentence unclear. Does the driver need to do
> configure the phy because this mode is not enabled by default or because
> the device will not work outside of this mode.

BroadR-Reach uses one pair. Standard 10/100Mbps ethernet needs 2 pair,
and 1G needs 4 pair. So any attempt to use standard 10/100/1G is going
to fail, the socket/plug and cable just don't work for anything other
than BroadR-Reach.

As far as i understand it, the PHY could be strapped into BroadR-Reach
mode, but there is no guarantee it is, so we should also program it to
BroadR-Reach mode if this property is present.

	Andrew

