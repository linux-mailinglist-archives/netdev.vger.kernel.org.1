Return-Path: <netdev+bounces-239639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF26C6AB46
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 127DD2C6B0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B438322774;
	Tue, 18 Nov 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sBUzD4BP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDB35A156;
	Tue, 18 Nov 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484277; cv=none; b=cXCEXAIvYC0QnJq0KwLoPo1mGDocYJ3bMoz+TpQj+9RU7Qz1vtWtnAvuOkBZDb3oU0JDACYn8CXyMS60I3Y7rKMvwqCbE8yERoKiSjDjD83GviCrWfebK/N4UXQYVQbgHusoIf+rOqceOyLsHQtrbwrNF0Ebmt2cXiwCdCbjN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484277; c=relaxed/simple;
	bh=bdsi9M1edZCDxjuS0bVp20dq4/KjBLBLWq6l9Ua5oGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1EXU+P0wSvcRQwkxjqS06MxA+e0SMcQudBpcCreHJ2ukujgEeljY4KwMb3jP5+x8T2lIzn/Z4j3q186YznwZZF/luq8lePItKpCoKbVV9ANr1EdvgNe3ELOPSz5pvlSVr8ODBxMr+lkBivldGE5XuZQjVeTtDqysuoPnYiNhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sBUzD4BP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dw4+iFGXAw/jrn/5nBHTrCrh75Cn9RYhpkXZnZCeozg=; b=sBUzD4BPSC56xcWazU0rp0Hf3I
	1Ub6Lo5xBnsEMEEyC/0y+n1VXiJ2G+MCfJpIkPi4UN/HtBu04xRvdTfunfdTFJf4bTPsiK5g/SCkL
	jlJvCTlKxfshqoyg6XW+nkluzp5gJSLjJp+Yv4EjrtyAeH0iXEagK6myJNXGICBlPLgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLOoT-00ENID-V8; Tue, 18 Nov 2025 17:44:17 +0100
Date: Tue, 18 Nov 2025 17:44:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-gpy: add MxL862xx support
Message-ID: <5ba651a4-4d66-4ab9-b253-95995e8a42bd@lunn.ch>
References: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
 <5e61cac4897c8deec35a4032b5be8f85a5e45650.1762813829.git.daniel@makrotopia.org>
 <e064f831-1fe9-42d2-96fc-d901c5be66a4@lunn.ch>
 <aRvdaxBjIOzspkCa@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRvdaxBjIOzspkCa@makrotopia.org>

On Tue, Nov 18, 2025 at 02:43:55AM +0000, Daniel Golle wrote:
> On Tue, Nov 11, 2025 at 02:32:38AM +0100, Andrew Lunn wrote:
> > On Mon, Nov 10, 2025 at 10:35:00PM +0000, Daniel Golle wrote:
> > > Add PHY driver support for Maxlinear 86252 and 86282 switches.
> > > The PHYs built-into those switches are just like any other GPY 2.5G PHYs
> > > with the exception of the temperature sensor data being encoded in a
> > > different way.
> > 
> > Is there a temperature sensor per PHY, or just one for the whole
> > package?
> > 
> > Marvell did something similar for there SoHo switches. The temperature
> > sensor is mapped to each of internal PHYs register space, but in fact
> > there is a single sensor, not one per PHY.
> 
> It very much looks like it is also done in the way your are describing.
> The temperature reading on all 8 PHYs is almost exactly the same, even
> if eg. port 1 and 2 are connected to 2.5G link partners and doing some
> traffic and all other ports are disconnected the temperature stays the
> same value for all of them.
> 
> Should this hence be implemented as a single sensor of the phy package?

If you have a PHY packages, why not.

For the Marvell PHYs, so such thing existed. All we see is individual
PHYs. And the registers are the same for discrete devices. So it was
simpler to just export what is effectively the same senor multiple
times.

	Andrew

