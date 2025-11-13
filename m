Return-Path: <netdev+bounces-238354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A56C57A64
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD384E3105
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0242FF14F;
	Thu, 13 Nov 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y3KRyinO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD4351FD4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040509; cv=none; b=mX3NHtbPyfbJgiXLpQTpi4ljpDzylSCdOAva06C9T6st2unxwk45bolJhbh6JHJxfKV/nNN/7UCzZexaNyKKXv4BTQXdbhCX4mm+wiK27VLk0Iqb1WITm9/ASlw/LZ8AaeP4HQbwSm5OEd0BKNItqISEQn+KAinNfgZD8SWGduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040509; c=relaxed/simple;
	bh=ZYWDqVDFFBWAWu4M4cQ2MwMwbx+eoplszaPzeJN8SXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J58GEMdJB/XZF++qNrEIPiZHYHVxIzBVxT0ZnPNvEM2/CoXoVlE9Mq6ybdO9ESPGI0pQRdtsvcV8BgsADwGZsrnF5fkm6oDkLgpnXWGnoOVYprCuDwnA2sIDCJXJtKsb4n+kFXisBkGKVGfQilC1+A6KyHDp54xnlMCRk1qrkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y3KRyinO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ruvoHpWb3Yb1KVyAcxbdZgr/hMHxuURyVujMnwRXLEE=; b=Y3KRyinOS+dtcdfaOgHEcppdY0
	t4UzKYCWmfCDdxUlWtimsROmaahVZLZjakMNc6XCcHosSB3DzVGu3ZnDjNwHv4qaeKaBRSs+B60OO
	VEXoBpDis1woDNqPdPFmXj7oIMTbnGDhvEeIuKwS5F64gKS5gP+hchkgAgDglnKLKOOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXN3-00Drjm-Bi; Thu, 13 Nov 2025 14:28:17 +0100
Date: Thu, 13 Nov 2025 14:28:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
	mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
	Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>

On Thu, Nov 13, 2025 at 12:11:08PM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 13/11/2025 06:12, Susheela Doddagoudar wrote:
> > Hi All/ Michal Kubecek,
> > 
> > To support Advanced PHY Debug operations like
> > PRBS pattern tests,  EHM tests, TX_EQ settings, Various PHY loopback etc.....
> 
> Added a bunch of people in CC:
> 
> I don't have feedback on your current proposition, however people have
> showed interest in what you mention, it may be a good idea to get everyone
> in the loop.
> 
> For the Loopback you're mentionning, there's this effort here [1] that
> Hariprasad is working on, it may be a good idea to sync the effort :)
> 
> [1] : https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
> 
> As for the PRBS, there was a discussion on this at the last Netdevconf,
> see the slides and talk here [2], I've added Lee in CC but I don't
> really know what's the state of that work.
> 
> [2] : https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html

For PRBS pattern tests testing i think there needs to be a framework
around it.

When you enable testing, the netif becomes usable, so its state needs
changing to "under test" as defined in RFC2863. We ideally want it
revert to normal operation after a time period. There are a number of
different PRBS patterns, so you need to be able to select one, and
maybe pass the test duration. It can also be performed in different
places. 802.3 defines a number of registers in the PCS for this. I
would expect to see a library that any standards conforming PCS can
use. There are also PHYs which support this features, but each vendor
implements it differently, so we need some sort of generic API for
PHYs. I expect we will also end up with a set of netlink message,
similar to how cable testing working.

	Andrew

