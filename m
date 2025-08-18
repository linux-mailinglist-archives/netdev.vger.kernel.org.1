Return-Path: <netdev+bounces-214735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E71B2B1ED
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DC87A9750
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4ED274FF5;
	Mon, 18 Aug 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4gJpZKY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EA274B47;
	Mon, 18 Aug 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546897; cv=none; b=IuxV7R/gDidppMYebNzs3PiOoZmwOf54X5Id5lhIyf8eMgyu01+S9BU41v6IEX3nWJ5uDYRmejHPNxr9UImu4mIKvKyjep1CEr5cdJaFql0DJkcKAG6WCo4XpOiCqbtetwqR50plecwQ3JHC5kBej7c8FSC8XKQNi3hh9g8q2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546897; c=relaxed/simple;
	bh=JY0f/59TcSEp6ctgBYfEIeRgIB+YF6NHvlds+J9UD3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKZyD+32kOFeMPJGnv+Uz1hqWANk5GugKqMlRVagYWG5kPS2CnjtTriyspfiztHbsFB4nqNvM6MaylHsa9KL06IaRnKGPxBNkypwNteH/MUKtDTfgWJUtOBJH/KJ59WgSP9Z6hQytqf1Kv7BXK2AgYK3aY/nuHxPfz5hU/M8XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W4gJpZKY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uYAXBZJUQoDLrh/Y3XCdfOtCCq008S7HptW2nNaF5hA=; b=W4gJpZKYT/u7IQOwUHx1XYEdFW
	BKUeUAt5LSCYGtdRj378AU+Mg+h4e0qtOoSwQ0XCvwqwRnKXAEjrd9zqqCGXSKZSgsQcoFb4CeCiZ
	m9ZMh9xCrjRarCMxtL537QrBXninNVonk8nu1EooBNM+AFwoBPtUFx6rmLPYAHhcyQBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo5wK-0056NU-E7; Mon, 18 Aug 2025 21:54:44 +0200
Date: Mon, 18 Aug 2025 21:54:44 +0200
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
Subject: Re: [net-next v4 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <e591888a-30c3-4482-9ef1-9f7060e85867@lunn.ch>
References: <20250818162445.1317670-1-mmyangfl@gmail.com>
 <20250818162445.1317670-3-mmyangfl@gmail.com>
 <2ac97f29-bfc2-4674-9569-278bb4492676@lunn.ch>
 <CAAXyoMNjukd-=cMDLiupNDYv1NLreWkCQufhAu_1y3N0udUrQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMNjukd-=cMDLiupNDYv1NLreWkCQufhAu_1y3N0udUrQw@mail.gmail.com>

> > > +static struct sk_buff *
> > > +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> > > +{
> > > +     unsigned int port;
> > > +     __be16 *tag;
> > > +     u16 rx;
> > > +
> > > +     if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> > > +             return NULL;
> > > +
> > > +     tag = (__be16 *)skb->data;
> > > +
> > > +     /* Locate which port this is coming from */
> > > +     rx = ntohs(tag[1]);
> > > +     if (unlikely((rx & YT921X_TAG_PORT_EN) == 0)) {
> > > +             netdev_err(netdev, "Unexpected rx tag 0x%04x\n", rx);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     port = FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> > > +     skb->dev = dsa_conduit_find_user(netdev, 0, port);
> > > +     if (unlikely(!skb->dev)) {
> > > +             netdev_err(netdev, "Cannot locate rx port %u\n", port);
> > > +             return NULL;
> > > +     }
> >
> > O.K. Stop. Think.
> >
> > You changed the rate limiting to an unlimiting netdev_err().
> >
> > What is the difference? Under what conditions would you want to use
> > rate limiting? When would you not use rate limiting?
> >
> > Please reply and explain why you made this change.
> >
> >         Andrew
> 
> I copied the limited version from tag_vsc73xx_8021q.
> 
> Under no conditions I expect either of them to appear: it is the case
> when I did my own tests; unless something really bad happens, like
> pouring a cup of coffee over your device.
> 
> I know rate limiting is a way to prevent flooding the same message
> over dmesg, but if an event never happens, I would consider two
> methods are exchangeable. Theoretically if an event never happens, no
> warnings would ever be needed, but I placed one here in case you
> destroy your device accidentally.
> 
> Thus if you think rate limiting is not appropriate here, I would fix
> it with another.

My thinking is, every single packet come through here. That could be
100,000 packets per second. We have no control over these packets,
they are from other hosts, they can contain anything, included
specially crafted packets, ping of death packets, etc. If there is a
way to trigger these prints, and they print 100,000 times per second,
it makes a good DoS. The box is completely useless. With rate
limiting, the box keeps working, there is no DoS, but you get to see
the error messages.

The basic networking philosophy is that anything per packet related
which could cause a print should be rate limited.

      Andrew

