Return-Path: <netdev+bounces-261854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD+5NresoWk3vgQAu9opvQ
	(envelope-from <netdev+bounces-261854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:39:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C621B91F5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F18CF304D49B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33526461F;
	Fri, 27 Feb 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GUyuFa6T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68B265623;
	Fri, 27 Feb 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201832; cv=none; b=LZlUFeHJbqa2Yfb4I4o9822nTELKmMoVJu8d9wCNNkNL9+LkBRtWeJhJef1Oj+yn3vnZN2jPUBJ17+1i302KC79bc/TEzlE9iJZ4mMNpFFFd24VUJ4RHKT/YNJJWPoCakUBxPyr/MVMH4WmLNyjCJpHgUCqO9bajzvOFRZAOCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201832; c=relaxed/simple;
	bh=l4iTRL0B1/6NXgplljCXFTOsoRttrq9bH3OZlZif2UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT0IzbM9fjI3aXaRixVO+O3Pi+LprK80hRPAyQK/81tIpKv5GKMwROO90bc+//KiNJw0kQZ9DVVPeo0q9OrC3cJ0HAk4GZFmPeeiGfSYxVIm0VYYYm9/4sprq534D7stPk7ItGt/La/tWxrNRSC/Rvd7kR9PjRzDGVXBflV//TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GUyuFa6T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+VXHYlpTEJaJKmEUYBOB/ugE90OvhmmhEimVZCgztBQ=; b=GUyuFa6T9x8R8R++iMYyskPPbK
	avmfBm3A6AIQBz2mk8hQ5xDVi7tpZOlGYAWN2T7K188ugL/It3vo26zU7qL98dtUuNJE17udwFBf3
	RXAz2Sx1E3jYOeRD+/AGbGpHbpwrhtuPbmAkOusO8lytulnl16FsTCKZ9GTEFowuIqcY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvyeM-0094iP-P5; Fri, 27 Feb 2026 15:17:02 +0100
Date: Fri, 27 Feb 2026 15:17:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <ef25c2c2-b50b-4288-8b09-00f7dfc88e63@lunn.ch>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
 <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
 <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
 <031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
 <vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
 <20260226182511.0d33f9d1@kernel.org>
 <a6qhvs4vaxk33iryntrvybaesbr23v7hcrfn37p53viydd3zhs@6zquhlssfthz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6qhvs4vaxk33iryntrvybaesbr23v7hcrfn37p53viydd3zhs@6zquhlssfthz>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261854-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01C621B91F5
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:34:28AM +0200, Ioana Ciornei wrote:
> On Thu, Feb 26, 2026 at 06:25:11PM -0800, Jakub Kicinski wrote:
> > On Thu, 26 Feb 2026 16:18:21 +0200 Ioana Ciornei wrote:
> > > > How about, fail the test if any are greater than 1% of the number of
> > > > packets transmitted/received? My _guess_ is, if you have 1% packet
> > > > loss, networking is not going to be happy anyway. It probably means
> > > > you have one end doing Half duplex and the other Full. That is a
> > > > typical configuration error you see causing collisions. Not that i've
> > > > actually seen this for maybe a decade!
> > > > 
> > > > Failing the test, with a comment about checking duplex configuration,
> > > > seems sensible.  
> > > 
> > > Seems reasonable. Thanks for the help!
> > 
> > FWIW the expectation is that the test should be able to run even on
> > systems / boards with a single interface. So the control traffic
> > (communicating with the traffic generator) will run over the same
> > interface as the test. 1% error is unachievable. I'd only check the
> > lower bound, and use some sanity value for the upper bound (2^30 ?)
> > if at all
> 
> Really? I didn't know of that expectation at all.
> 
> I did take ethtool_rmon.sh as an example and that selftest as well
> takes NUM_NETIFS=2 and does check for both a lower bound and upper bound
> that takes into account a 1% deviance from the target.
> 
> How would the test even work with only a single interface?

Just to add to this, for the 1% i was referring to counters for
collisions. If the control traffic is causing collisions the system it
just as wrongly configured as generated traffic causing collisions.

For 'everyday' systems, i doubt Half Duplex is ever used, but
automotive with a T1 PHY might. So we might need to review this 1%
once somebody runs this test on such a system.

     Andrew

