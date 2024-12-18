Return-Path: <netdev+bounces-153086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3319F6C17
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223DA1880576
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFA1F892F;
	Wed, 18 Dec 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jXOd8w3r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C201F868D;
	Wed, 18 Dec 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542002; cv=none; b=cx+PIWTOcKpaGMEjTA57fv090OohTgYCeT4xYsUi2RtC9LJsa4OSmW5jB8f5yMDjGpH2AdJkZEesiKlHqN4nAVjckoC2q3am87Z/jEspvsWHuECapqQBwphOFcUdVLlCVDWNiDKnyGI/IpSm9vGQzkh+YBQ4CISDB6DstCa6uCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542002; c=relaxed/simple;
	bh=cgGYUe2HEyyFOdoDYkKOljPAISybYKwqCt9T3843Rck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7TyGq5smp902KttqXZI/l9u0nH6ySZ5hV6ehntYH0RRAjBczalnm7tvXVNmF3gHTY+a8G6+l4FMPj5CSkCw4YlLFGUjYuGCLly2NPLN06cyuhXwLhNVilrGhu39rCK/fuHSG4rrIR0K/+pscy3Xhlx86heS2EtnOtvsVhZJY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jXOd8w3r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PaKqry1ARgp3YomJ3RZYJk7i9ILRCrNYrvEfCol2+Cw=; b=jXOd8w3rUjEKZymf5aiN89aAUk
	cc+4WKK8n6PgCNEPlRBcSCBbQYVxaOI1voMBu8KeFuXTcgvysN/5lgQjtkm40hjQscFqk+iS2svr+
	tzx9QseTuzybutAEd9lGDzc+zvLe4S/oT5bK9s+IbDLIpcD5jQPmYWl+ucevxngZRTIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNxbg-001LMw-PF; Wed, 18 Dec 2024 18:13:08 +0100
Date: Wed, 18 Dec 2024 18:13:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <1627e8c1-e9f9-438e-9ca2-6a931c814e70@lunn.ch>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
 <20241217175906.GB716460@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217175906.GB716460@debian>

> > index is taken direct from DT. Somebody might have:
> > 
> >            leds {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > 
> >                 led@42 {
> >                     reg = <42>;
> >                     color = <LED_COLOR_ID_WHITE>;
> >                     function = LED_FUNCTION_LAN;
> >                     default-state = "keep";
> >                 };
> >             };
> > 
> > so you should not assume if it is not 0, 1 or 2, then it must be
> > 3. Please always validate index.
> >
> dp83822_of_init_leds does a check that index is 0, 1, 2 or 3. Is this
> sufficient ? Otherwise I would validate the index.

Ah, i missed that. I'm just used to the usual pattern that every PHY
driver has a check for the MAX LEDs in their callback.

	Andrew

