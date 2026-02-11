Return-Path: <netdev+bounces-258246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOu2Jr9TjGnblAAAu9opvQ
	(envelope-from <netdev+bounces-258246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:02:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC512318C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB3A30238ED
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207835CBDE;
	Wed, 11 Feb 2026 10:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E26F47D;
	Wed, 11 Feb 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804124; cv=none; b=Ddqa3eJkE97/5VvZx9IxhM647OoscPEIi7D74gHuPUq+hRS/2/VDILrV1vQaIqzWFAz8c+5H1s4f/k0n4yGKBq0UK1y+R0+fcgsU5JDgPvpJYHGBaHvpMLGqEuCs9VUgViP3XGnYbFf3rFjULSF3eO7PyYC4CxQAMZYTd5Z+/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804124; c=relaxed/simple;
	bh=n6ZWJki2G8x8zxyk31c4BgGZuaPyu2KLP2w1uhw2X+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG4et1+ZeLOXAN7WQF/f8MJG8uRFz51JBzjL93m9N7v1jfNRsQMhBHufwPpDUr0foipPIP0E5/fo5iqD96DkQWk0WbkK+BNRB/zC5Q9+svcH64+fV6sHPA3114aoEMRMTOElTOp1H2jsEaYoxjl1jMIszjT/k8qXtiEbcFrc6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vq72Z-000000001Cx-3IgB;
	Wed, 11 Feb 2026 10:01:47 +0000
Date: Wed, 11 Feb 2026 10:01:44 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v14 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <aYxTiJW03q1DN9XF@makrotopia.org>
References: <cover.1770433307.git.daniel@makrotopia.org>
 <20260207214733.m2zvh6ozo7vsc5hj@skbuf>
 <d6393a14-fe50-426d-9dd8-5a33b2af0a0d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6393a14-fe50-426d-9dd8-5a33b2af0a0d@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 45BC512318C
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:49:56AM +0100, Paolo Abeni wrote:
> On 2/7/26 10:47 PM, Vladimir Oltean wrote:
> > On Sat, Feb 07, 2026 at 03:06:48AM +0000, Daniel Golle wrote:
> >> This series adds very basic DSA support for the MaxLinear MxL86252
> >> (5x 2500Base-T PHYs) and MxL86282 (8x 2500Base-T PHYs) switches.
> >> In addition to the 2.5G TP ports both switches also come with two
> >> SerDes interfaces which can be used either to connect external PHYs
> >> or SFP cages, or as CPU port when using the switch with this DSA driver.
> > 
> > For the entire set:
> > 
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> > with some minor comments I'll leave in individual patches, which I'd
> > like you to address.
> > 
> > I don't want to put anybody in a bad spot, but given what time it is,
> > this set should get at least _some_ time in net-next before the upcoming
> > net-next PR, to allow for some reaction time in case of some unexpected
> > reports like from static analysis or similar. 
> 
> As I'm wrapping-up the PR right now, and the series is not applied yet,
> I fear the above is not going to happen.
> 
> Since a driver is involved (as opposed to the core stack) and there will
> be the usual release cycle to address issues before the code lands in an
> official release, I tend to think this series should still be merged -
> unless someone voices strong and valid concerns _very soon_.
> 
> Thanks,
> 
> Paolo
> 
> So it would be good,
> > because of that, for the fixups as a result of my comments to be
> > separate patches rather than a new version.

Meaning I should send them *now*, despite net-next being closed already?

