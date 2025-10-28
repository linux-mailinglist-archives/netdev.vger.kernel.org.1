Return-Path: <netdev+bounces-233678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBCC173F3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13A7C4FB302
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3B369997;
	Tue, 28 Oct 2025 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="heVv1CNy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E0368F2A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692196; cv=none; b=EqLI3Ommpe58DfQGYMq+utDH7W6dTrAB0dnDNzGCiDWg8yM3P4Th6bEOdmwcpRX0t7DhC+tRn2ZJZWceshYpEjyObPxMQhengIAqR/VKC02nVo+H+kvJrmFQnGsTBt0M0Qu8A+DE6x1NSb7yVr7HkSPAyYK4p/pSCyUpn+D7lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692196; c=relaxed/simple;
	bh=gzMyNe3bYkOUhw79LF+xYL5EvdebU7mf2v9T40MCS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miXR48fR1xJk2rKiRSlp+oikFBE8BuvxQpKbJZDfUYmdp+PZhNRkX3LReSmdq2DqwS+cFKrHIdVWvA5Lldt6NgmSCwyxJbDuYwLsW86715Wg+R7YBgvoy4GUN6PY1vbNzEbACFm+tnhF4rGitvUNYQfpsibG4Po3jOWlezTuBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=heVv1CNy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kovtO3jpsFBAOlD0JU7rGvDonyEjNTvLsJSB8rr789Y=; b=heVv1CNytQ+EMhWg+itzf3hMLf
	z7TlYYlr7jVkez/qnFXcXubDrHdR8Y4BUlcg+rmxdADigr+FNjN+GJBrnApej5gXJbGYKKyuJhjVa
	KdqJUnu8BYAd2F+UOSkzt/Rp8rnpJLQ8CHVGNIDPX6przlrEiKApCQFshOLMKSvYhhlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDscA-00CL3p-LX; Tue, 28 Oct 2025 23:56:30 +0100
Date: Tue, 28 Oct 2025 23:56:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 8/8] fbnic: Add phydev representing PMD to
 phylink setup
Message-ID: <fa8c2fe1-23a3-4fd0-94a7-50446631c287@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>
 <6ca8f12d-9413-400d-bfc4-9a6c4a2d8896@lunn.ch>
 <CAKgT0UdqH0swVcQFypY8tbDpL58ZDNLpkmQMPNzQep1=eb1hQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdqH0swVcQFypY8tbDpL58ZDNLpkmQMPNzQep1=eb1hQQ@mail.gmail.com>

> > > +     phylink_resume(fbn->phylink);
> >
> > When was is suspended?
> 
> We don't use the start/stop calls. Instead we use the resume/suspend
> calls in order to deal with the fact that we normally aren't fully
> resetting the link. The first call automatically gets converted to a
> phylink_start because the bit isn't set for the MAC_WOL, however all
> subsequent setups it becomes a resume so that we aren't tearing the
> link down fully in order to avoid blocking the BMC which is sharing
> the link similar to how a WOL connection would.

/**
 * phylink_resume() - handle a network device resume event
 * @pl: a pointer to a &struct phylink returned from phylink_create()
 *
 * Undo the effects of phylink_suspend(), returning the link to an
 * operational state.
 */

There needs to be a call to phylink_suspend() before you call
phylink_resume(). If there is a prior call to phylink_suspend() all is
O.K.

Russell gets unhappy if you don't follow the documentation. The
documentation is part of the API, part of the contract. If you break
the contract, don't be surprised is your driver breaks sometime in the
future.

	Andrew

