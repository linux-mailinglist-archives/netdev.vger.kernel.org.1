Return-Path: <netdev+bounces-262017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE1GNqo1omnR0wQAu9opvQ
	(envelope-from <netdev+bounces-262017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:24:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 835071BF661
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1088E30A1E1A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16323ABB0;
	Sat, 28 Feb 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5UMkxGr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D3368978;
	Sat, 28 Feb 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238222; cv=none; b=PZCVe8xbd3Yl7H5KWOcGlxVoNnAUR8+7rf4fyqZ15v/162HNJBo93ojkzE2cWleNvX4//wFxjUVHaVF8k1Fg5LvJ2OgA+wS/yElFSBgnExeAB4oYOSoHcGHwSFC8TOUG7dzxv+vJ4vR007ixMlB+Ag/CKinQRbr0/T6hn+ImgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238222; c=relaxed/simple;
	bh=xY9TM+CCy8Kd9PVvEASGuE0lYodI/nasizjdzDWCuIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3RVzfu3OmveM+CRunfttKu9JhCZQWuUnRhYmrDOOU3Kng/z3Ea6TYFlOCyV7nO96DQ4uunypcvheqmlKj892Jk/klX4O1vpmXsqZEuRaaCXtlm1s+AyWfKH6ya6SnNQuN8GrJIWcvwm/fuSSZp43LmmKp+MFU2dJYTfa0yuZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5UMkxGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1CCC116C6;
	Sat, 28 Feb 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772238222;
	bh=xY9TM+CCy8Kd9PVvEASGuE0lYodI/nasizjdzDWCuIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5UMkxGrRunHXPy2Bh+b32fvht5LIB1Ppcwv/BXgtzdgP0h57ru6qJhCAPk6ntY1G
	 kejOcbu9qhP8LULA9VE5OrSQZXvAoZ6WHDrEIipGRkUO8ubJwRxdYLeJNChGB1kbG8
	 fo4A7/vgrUqWGSDLtXydFVhjFLb1bDP6v9LCRT+kGAjP8UqtjVnsI0+IOnPR87yxXy
	 nTfGfkfMPFhJlx6TvPrfRU3nQFBVQzY1I5UzSmFlIXb1PTYyYhz/bkQS1kCUyChBkY
	 v4pZcB5cgnWieXpDdrM48qYRDGdxbgKOzXPDo2aaO+CdSGAK/Uxh2tUwzuf4kiXphe
	 miC3YhkpOnbgQ==
Date: Fri, 27 Feb 2026 16:23:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260227162340.4675e766@kernel.org>
In-Reply-To: <a6qhvs4vaxk33iryntrvybaesbr23v7hcrfn37p53viydd3zhs@6zquhlssfthz>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262017-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 835071BF661
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 09:34:28 +0200 Ioana Ciornei wrote:
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

I called out in the other thread that the bash scripts in this dir
pre-date any serious CI use. They are only there to get them out of 
the way of SW-only CI testing.

> How would the test even work with only a single interface?

Hopefully the readme mentioned in my other reply clarifies.

