Return-Path: <netdev+bounces-262018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI1SLt81omnR0wQAu9opvQ
	(envelope-from <netdev+bounces-262018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 262191BF67F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A0A3081062
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB09239562;
	Sat, 28 Feb 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hou5AiKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C231217F31;
	Sat, 28 Feb 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238297; cv=none; b=nMs3Nmmma1FyAHuLUQGfg1jurVlZ+H6+xPert37fi7TVZWQnDl/iq/yierZ3Y7WKfYKka+pTDwydJ5b/iJLJ6SIFtJZ7jaRKIZ2YMABBgP0bbqyFctFqSjrfJaioMWGQWdwmFlWnrzqhUKpmiYbgAA5K/YLIe0Z7I/DG86rp6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238297; c=relaxed/simple;
	bh=NRLEQogbdfMsW/1W581hPUAygif/9fq5x4hpso8U3bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4OU8hEMpg2wZolQiwIRFmWyvdLe1rBLsuGY+vpbo+HXomhkV84uqLVGXB0iI7CdAt6lkSKjxZJ8hvJfPBThjp6luuGM8uSyHtvbmfrqMOtRm9QX/mj+5+IPtf4RI2Jqm2NyVsZAI1LbOENN9HdhZaecRgnIG3HG/tWxdzcHymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hou5AiKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390D5C116C6;
	Sat, 28 Feb 2026 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772238296;
	bh=NRLEQogbdfMsW/1W581hPUAygif/9fq5x4hpso8U3bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hou5AiKfFwR/PPaHk73nZmnePlvIzv65arTZ4gwVJDQhNttR1rM8bsxiFPbfsJuZT
	 cKGi6p5+ofabg9dKQELP0e4CEL2mJAAXUoWErEje2kTIUIhG/S9R5h5GHn0UktP+wK
	 pQGHF2U5V4RVKtkyrY5l2Qb80hsxjeS5ENEF0yU6pEI6gefUHmf6SNLQzR6fmxFSe+
	 +F7prqkC0rqvBMudx/vaBSpTyg7S/IYczYOrE/Sdk6B/7UetSdcfV7fNkWLv5l/4a8
	 9Xan6BFfq8FWs1vdmEZW6Rln4j/Fy8o3o8Ahq8evusGC0IEWAudrZ/ZouelDFT91c5
	 MN8atYr8TmXdQ==
Date: Fri, 27 Feb 2026 16:24:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260227162455.6272f87a@kernel.org>
In-Reply-To: <ef25c2c2-b50b-4288-8b09-00f7dfc88e63@lunn.ch>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
	<20260225150648.1542206-6-ioana.ciornei@nxp.com>
	<77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
	<osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
	<ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
	<031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
	<vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
	<20260226182511.0d33f9d1@kernel.org>
	<a6qhvs4vaxk33iryntrvybaesbr23v7hcrfn37p53viydd3zhs@6zquhlssfthz>
	<ef25c2c2-b50b-4288-8b09-00f7dfc88e63@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262018-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 262191BF67F
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:17:02 +0100 Andrew Lunn wrote:
> On Fri, Feb 27, 2026 at 09:34:28AM +0200, Ioana Ciornei wrote:
> > On Thu, Feb 26, 2026 at 06:25:11PM -0800, Jakub Kicinski wrote:  
> > > FWIW the expectation is that the test should be able to run even on
> > > systems / boards with a single interface. So the control traffic
> > > (communicating with the traffic generator) will run over the same
> > > interface as the test. 1% error is unachievable. I'd only check the
> > > lower bound, and use some sanity value for the upper bound (2^30 ?)
> > > if at all  
> > 
> > Really? I didn't know of that expectation at all.
> > 
> > I did take ethtool_rmon.sh as an example and that selftest as well
> > takes NUM_NETIFS=2 and does check for both a lower bound and upper bound
> > that takes into account a 1% deviance from the target.
> > 
> > How would the test even work with only a single interface?  
> 
> Just to add to this, for the 1% i was referring to counters for
> collisions. If the control traffic is causing collisions the system it
> just as wrongly configured as generated traffic causing collisions.
> 
> For 'everyday' systems, i doubt Half Duplex is ever used, but
> automotive with a T1 PHY might. So we might need to review this 1%
> once somebody runs this test on such a system.

Right, right, errors and exceptions are probably fine.
I was referring to checking overall byte / packet counters with 1%
tolerance. Sorry if I misread the discussion or the patch.

