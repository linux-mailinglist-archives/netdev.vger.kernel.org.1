Return-Path: <netdev+bounces-263324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPfrGuUPp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:44:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503C1F4054
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CF4B3028D7B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FE3264FF;
	Tue,  3 Mar 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7dr3y0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052E3264F9;
	Tue,  3 Mar 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556212; cv=none; b=PRonpqG+T2iAIWa4zR6SDssOXtDyRMeqUE3qP2+gNfKJe4l9MR1qPg2A8u0foRL6m3aGHmPxrmt4qrIUHGrjABHsIbVHHgO0h+4MdclBS4PlSohSoUX9BnzVnSqNLvv0FDWf17LPaxWe5rFG3tU4C+nHyqwg0M5oVFKWRLVj06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556212; c=relaxed/simple;
	bh=f3/xDyTStCTpd5zfjXM5yC44eWuflX5gwy9dXVOkezM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg7JpfMf6rNwP1kQdkBtZke+4hKi/EuXsXhksaeDvG3HVgohGGh2y8yTu5vfBv3BnaU53l3xwkRx2BM7FMiHCoczKH9QQqN/97jgHtXvvJsZ/WRfO9B+0eYAMOu6MNR5iN4maLvw/r5gatPRtvUnXHKcKj5K4Ua6uyeCo5p74Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7dr3y0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B0C116C6;
	Tue,  3 Mar 2026 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556211;
	bh=f3/xDyTStCTpd5zfjXM5yC44eWuflX5gwy9dXVOkezM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7dr3y0koGTrCtVt4Geq4vsS56uE2pnRQZVw0xH8RtiOjva3x4SHto4g+def8shGF
	 ZrS1+TkuPOzeuWem7cfhMAVKAO69MGIFjpMH0ejCbr9+jNFp2TO3OL+EOPU3f+M2Tg
	 T86p3uqz9EM5VgYCtVsK8rjQDnO/pSRIkimrf7eDkma8GwsQjPhiTWrU/KmJMCqFBQ
	 SC5uTS56m2oHU2OEqADy59z3n77PBMBCWJdHw3FgplL47fp4FxvvZhFVuJwz86yBDm
	 bacKbjm18iptSWhJ3u4ZYbIgRaFxQzRyJEoN+/YZb5oKlK2BX/7fEMJZZPxYYKq6SR
	 VmkTEOWPjlUNA==
Date: Tue, 3 Mar 2026 08:43:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Petr Machata <me@pmachata.org>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260303084330.340b6459@kernel.org>
In-Reply-To: <qnq4vqznmwbgl6auacr7lkpwpzcwh2w26de22pidxhpy676f73@45s2xdpczvsd>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
	<20260225150648.1542206-6-ioana.ciornei@nxp.com>
	<20260226182223.5eb1b10f@kernel.org>
	<87ms0ufc0p.fsf@nvidia.com>
	<20260227164348.63afcc43@kernel.org>
	<877brxf272.fsf@nvidia.com>
	<7hct7o4rzgygef536al6if2jl45p32ad3tdswyqf25uu5wy5re@2ltu2ems47q7>
	<20260302160743.124531f8@kernel.org>
	<qnq4vqznmwbgl6auacr7lkpwpzcwh2w26de22pidxhpy676f73@45s2xdpczvsd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6503C1F4054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 15:53:41 +0200 Ioana Ciornei wrote:
> > > I would add here even ethtool_rmon.sh and this new test that I  
> > 
> > I think I already told you that ethool_rmon predates the NIC tests
> > and bringing it up in this discussion is irrelevant.
> >   
> > > submitted. If you are running with a traffic generator on another board
> > > then you can no longer check that the counter's value is as expected
> > > (with a 1% tolerance), you can only check the lower bound.  
> > 
> > 1% tolerance is impractical for any CI with high test count.
> > The test will be flaky. And I really doubt that the 1% tolerance
> > is really necessary to catch most bugs. We're not trying to validate
> > silicon here.
> >   
> > > Additionally, if you are using the same single port also for control
> > > traffic towards the remote traffic generator, then you surely cannot
> > > reliably check that counters that should not be incremented are indeed
> > > not incremented.  
> > 
> > I both told you in this conversation how to check the counters,
> > and written some existing tests for counters.  
> 
> Judging by your response it's clear to me that you wanted to transmit
> something that didn't actually get to me. I am afraid that it's not
> clear to me what exactly is your feedback and what do you expect as a
> next step.
> 
> What I did get:
> - The new test should work with a single netdevice (and a remote
>   endpoint for traffic generation).

yes

> - The test should not check for any upper bound for the ethtool counter
>   value.

more or less.. you can check for crazy values (bitflips etc).
Either pick a value too high to be reasonable (100Gbps * time)
or hardcode some high threshold (2^31?)

> - The test is expected to follow drivers/net/README.rst.

yes

> Does this mean that your feedback is to convert the bash variant that I
> submitted into a python one which uses lib.py?

It'd certainly be easier for you, but I'm not against building out 
the necessary support to run traffic from remote in bash.

> If this is your intention, what is the plan for the rmon statistics (or
> any drivers/net/hw/ bash tests that pre-date the README)? Do you see
> those eventually getting converted to lib.py? I am merely asking so that
> I know if I should convert them or they are to be left as is.

Yes, I was planning on doing the conversion once we have some real HW
testing going in NIPA. If you're willing to convert them - that'd be
great!

