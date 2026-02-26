Return-Path: <netdev+bounces-261347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJnkDKNLoGnvhwQAu9opvQ
	(envelope-from <netdev+bounces-261347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:33:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C381A69DB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCE0302E902
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13F3559E1;
	Thu, 26 Feb 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRXka2MC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C3356A09;
	Thu, 26 Feb 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112699; cv=none; b=CIHyFeLxS+iwW0eIr5Dfrtrc0tL1h3N1ukhDWqQqqDdIOAGuvLcFfZxO+1ZAWE1MpFceoKd+3RaiQydvcB+DXO2PJmzQY+QLUDZ1AVl/QDfp0oxNJ6WuVZzb9O2i1SlTwnCHEWmqm+lDBDrD1mXRJZxOCHCmVtwYB11Fm++HNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112699; c=relaxed/simple;
	bh=lpaHEgFZCQQnSmm8lOYbYNpUhu/oWdj5v7MfFolijw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewMZ5X+Be4ICxdTjoW4j21DzqkqQc/KESb5R2UAJNukwENMJUEkyC0pOXUcxf7PyqCbimXR8CEZbN7MRDHHWbw98xtF6kY7zygvGFk+6rjhmFEYNcUU1beP7GHChWIQDq4Kw3cy2Lym9yTTRug4Hl2+Ov9SokDe4+ab/1a5C2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kRXka2MC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=swuA3TDEKA9Vj1lWKiwbHpayo+/rkT8Lwoj/1cEFnog=; b=kRXka2MCkwdEQzDDvCSkmbN4GN
	0Clrzkrvz/M+cl2ZZODDHpA8y8SSlKEy0ULBXFslS+F0KkFqWRvUrOp74mFcqMSpqSTUzgKyAF96D
	yYn31USX0OUsySsd3twnJlrq5jUKNztniRkNNa8/W9n0o7MVZ0+nHOwLEr0F+NpOgNo4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvbSg-008t33-5l; Thu, 26 Feb 2026 14:31:26 +0100
Date: Thu, 26 Feb 2026 14:31:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
 <osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
 <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79C381A69DB
X-Rspamd-Action: no action

> I am back with a bit more information. The counters which were not
> checked in this version can be grouped in two categories:
> 
> - Error counters such as:
> 
> 	u64 FrameCheckSequenceErrors;
> 	u64 AlignmentErrors;
> 	u64 FramesLostDueToIntMACXmitError;
> 	u64 CarrierSenseErrors;
> 	u64 FramesLostDueToIntMACRcvError;
> 	u64 InRangeLengthErrors;
> 	u64 OutOfRangeLengthField;
> 	u64 FrameTooLongErrors;
> 	u64 FramesAbortedDueToXSColls;
> 
>   I did extend the selftest with these ones so that we check them
>   against zero. I ran the test hundreds of times and I did not see any
>   problems.

Great.

> 
> - Collision related counters (not really errors):
> 
> 	u64 SingleCollisionFrames;
> 	u64 MultipleCollisionFrames;
> 	u64 FramesWithDeferredXmissions;
> 	u64 LateCollisions;
> 	u64 FramesWithExcessiveDeferral;
> 
>   With these I don't know what to do. Theoretically, they could be
>   non-zero in half-duplex circumstances which means that checking for
>   zero would not be entirely accurate.

How about, fail the test if any are greater than 1% of the number of
packets transmitted/received? My _guess_ is, if you have 1% packet
loss, networking is not going to be happy anyway. It probably means
you have one end doing Half duplex and the other Full. That is a
typical configuration error you see causing collisions. Not that i've
actually seen this for maybe a decade!

Failing the test, with a comment about checking duplex configuration,
seems sensible.

     Andrew

