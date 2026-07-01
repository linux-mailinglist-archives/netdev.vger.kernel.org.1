Return-Path: <netdev+bounces-303719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id igGqBr8vRWqO8QoAu9opvQ
	(envelope-from <netdev+bounces-303719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:18:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADD6EF2F0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:18:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="ZX5/2tA6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6210305288D
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA84426ED3;
	Wed,  1 Jul 2026 15:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF018FC97;
	Wed,  1 Jul 2026 15:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918544; cv=none; b=YXuOdHcdB5GI5h2I3uAM7jjGw6/4N6rSNIKW6AV07FucZijcMXSN0Kq6hUV9OSOz8Uk6+h1I7bc62sdy5hP34+lIDen6EaKoKNKgleT0Npr7K2ph9XpEJNBd6Dp/D0zYIr6t6KTwuOIZlubGgx1sE4h5gArPtFX3N0lajm3DbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918544; c=relaxed/simple;
	bh=dVEvulQ72WCVFoqa6gPcVhv7eBp/Ml+x+rS9+5SK+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAJaQ6KXHutf5VPC3cgbaf9XXuJJz4bfPzaqw74YLWRAidlr6l3ooOBYRVq079Y+q+12GGlsj7delRsqivpVLjS5noJSM8w2ghBSyxISNdopAjBlCp3EEaPechCZMUAe6i4WQSlEqkD1C90xh3tNiDcPbORyIJpDK2ewF1LZnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZX5/2tA6; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oIMlAFaCIS+fMDslYay9YWXGdoQdS3epU4RzYxH5XmE=; b=ZX5/2tA6zwGCHAZk3T2j6auwA8
	Ac4Z08b6ZRhT9g9eI7cq+Cc6d3U4RAkV8cDYqNpy7N+SqRNelHIDaCfW6B/gA5nBDLpqWwyaamyTP
	HbUk3PUoWd7Cr2NQrL1r7FZwvwOY5cNzjtGBopVqDwNkiVbQGuE/6GMODBWo4GBxwC/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewYY-00ABg4-Sg; Wed, 01 Jul 2026 17:08:54 +0200
Date: Wed, 1 Jul 2026 17:08:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause
 parameter configuration
Message-ID: <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303719-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DADD6EF2F0

> > +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> > +{
> > +	struct usbnet *dev = netdev_priv(net);
> > +	struct ax88179_data *data;
> > +	u16 bmcr, lcladv, rmtadv;
> > +	u8 cap;
> > +
> > +	data = dev->driver_priv;
> > +
> > +	if (data->chip_version < AX_VERSION_AX88179A)
> > +		return;
> > +
> > +	bmcr = ax88179_mdio_read(net, dev->mii.phy_id, MII_BMCR);
> > +	lcladv = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
> > +	rmtadv = ax88179_mdio_read(net, dev->mii.phy_id, MII_LPA);
> > +
> > +	if (!(bmcr & BMCR_ANENABLE)) {
> > +		pause->autoneg = 0;
> > +		pause->rx_pause = 0;
> > +		pause->tx_pause = 0;
> The best way to have this correct is to use phylink, but for that you'd need to
> have a proper PHY driver instead of using the mii_ API here.

I said the some to one of the other patches.

Do we know what PHYs are being used? Can register 2 and 3 be read to
get the PHY IDs?

	Andrew

