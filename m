Return-Path: <netdev+bounces-289602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHNBNufEDGpOlwUAu9opvQ
	(envelope-from <netdev+bounces-289602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4858491C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722F13008D15
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB44A3B4E98;
	Tue, 19 May 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GU1Mptpu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9936D9E7
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221686; cv=none; b=jmoc5/jJ+vApFzqbDR8qFxDW3iq6Qa29SAKFo4HcVUXP/M65SZi5sTonir8TTqDfqZ43cVKyu3riq9kFCvBGrqzyJKYPnJJqrQTgAwBQdNYLUj7KVA0NdB8AaVuMJlFJYv5cAAWgE/0HaRNVYwgyCgZHrUwldmgYYo2We9cLSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221686; c=relaxed/simple;
	bh=hl34thQMM8XMNdYFfZ3nf/c4aTcRjISpynpnL1xwgFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvKHBM+b3LYzkHJmyomTQABeIe/3TauIRlNcuhiA5ldOKMXTjxsBvsJbrN9k+PtEDXPNbntp+ZRePFpBTWIrO+7f5m4TbsZzjRAJavamqGBBvhRnWhtVj+JxnRW78YTgngZ2CFOB50foW4HsSkTygorKMr0+iH3qYXUh9l5a9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GU1Mptpu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gq3xkGt0n03mR/0kB9zk4M3Nw+lmn2D5ztlo3INSc8M=; b=GU1MptpuVpcw9c7mRYEbMAiy0f
	XCZ8ma+ijsxYPl6s7Te5vFs9JjsKYMgxTU6LAUNSvxF98LAamk1QLmRIqA7h+/RWcGxdsKlB3Arfc
	l1RZKAtaw+jhxmGl1kKRAF8hGsZoWa0IkiYa0rugJSGDtap0pmWaqBT5BqQ/aX2FSV+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPQpc-003jCj-US; Tue, 19 May 2026 22:14:24 +0200
Date: Tue, 19 May 2026 22:14:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: 'Daniel Golle' <daniel@makrotopia.org>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
 <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
 <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289602-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[makrotopia.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 44B4858491C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Hi Markus
> >
> > It would be good to take a step back and explain the concepts here in
> > the commit message. An MDIO bus as 32 addresses, as defined by
> > 802.3. Why do we need the concept of a port when we have addresses?
> >
> > Once you explain the concept, we can maybe suggest a better name. Or
> > throw the whole concept out because it is not needed.
> 
> I'm just trying to give the properties in the info structure the right 
> name that resembles its function. The driver already builds upon
> the "port" naming.
> 
> Where does this come from?
> 
> - The hardware has 1-4 SMI busses
> - Each bus serves up to 32 addresses
> - A switch has X physical ports
> - The mdio controller can only be fed with "physical port"

So in general, the MDIO API uses an address in the range 0-31, as
defined in C22/C45. I would try to do any sort of mapping of ports to
MDIO addresses in a layer above MDIO. Maybe that is not possible, i
only partially remember the discussion about this hardware. But if it
is going to get more complex, i really would suggest pulling it out
into a layer above, and let the MDIO driver simply do MDIO.

	Andrew

