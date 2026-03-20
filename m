Return-Path: <netdev+bounces-269981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL59Cm19vWmt9wIAu9opvQ
	(envelope-from <netdev+bounces-269981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:01:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150B2DE2C3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30025305D6F9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762083D524D;
	Fri, 20 Mar 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RkM0STdZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333B3D9DCB;
	Fri, 20 Mar 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025266; cv=none; b=TA1jRZsvkM7gESPL/IJBPC0orAGZLW7jXSxJZYrKQjazajcSaqJKnR+917VyGtvDRt8gm6nlBcR+IQzprZrQB0xV52xzSnO2mkzhCUWeRUe4/WQZvJP0xjkdLpD1Ls0L21IsbM+2ebXTKpK1DKJWknUFrLdiscXiJMS5TsMgpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025266; c=relaxed/simple;
	bh=ClXFORe1tbeEqJI6uE3O2hedh4dHtvsaCEkC8qDaqh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s5RuLsKEAhP5IUNWaCSjrpOl1pbMc1Xff0YS8mwn8O1B0qw9/R2dqQFNnIGfFYtMbY9JWSfm/qMLhycbdZ/As86AO7UsH/LrmaA0J2W52H6N3dFt/GsL6eKyOkPdmHyhRSYePh0BHLlX+LeRcsGY45kW428EROOVOwC3iLG1P1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RkM0STdZ; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fcpQ645tGz40rF;
	Fri, 20 Mar 2026 17:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774025246;
	bh=ClXFORe1tbeEqJI6uE3O2hedh4dHtvsaCEkC8qDaqh4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=RkM0STdZxuYEfUeQOQhm2543QDa9+YNizOGUwfzkcF8PRN+SVMdfUn40r2rRKeLXH
	 R3T3nGopG+71WfupcxUX270STFuG4IU8JIgaTRomZ8OEYKrwlllw5/T3TRoQdfwguY
	 uABpgOlfGPodK7pt1QaSM5VhBVUoE+ACx7klB7Skt7RZ9Fv4g1JPwr5tBxW8Prd5/O
	 bslwvo/OREtRFZw7j1uEfx9NhOrs9Z6qUVZtBlFIXvUauL6bD4N3/hJR+6E7HotQaW
	 vzL6NNHVnZ/ePglvRu6LXFBLPo3/oXN5sRQ2teod2KQAPy9n+Heiu+3wsO3XSENcpM
	 TAU/jOjLQ8wkw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fcpPr1tCXz41WF;
	Fri, 20 Mar 2026 17:47:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fcpPq2DRyz8tXF;
	Fri, 20 Mar 2026 17:47:10 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 20730633B8;
	Fri, 20 Mar 2026 17:47:10 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
Date: Fri, 20 Mar 2026 17:47:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: kuba@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bluetooth@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
 <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
Content-Language: de-DE, en-US
In-Reply-To: 
 <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177402523050.2839845.12260014653636484966@mxe9fb.netcup.net>
X-NC-CID: t/YbKNgoo2xkZyanfMXXQt1cJm1pAYu87OeSSDM9R+TdRSRBG3Q=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269981-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	RSPAMD_URIBL_FAIL(0.00)[leemhuis.info:query timed out];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1150B2DE2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 01:00, patchwork-bot+netdevbpf@kernel.org wrote:
> This pull request was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
>> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:
>>
>>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19
>>
>> [...]
> 
> Here is the summary with links:
>   - [GIT,PULL] bluetooth 2026-03-19
>     https://git.kernel.org/netdev/net/c/57ce3b2e9cda

[preface: sorry for being a pest again and making life of maintainers
harder with mails like this; but I think Linus (CCed) wants me to bring
up situations like this; Linus, if I'm wrong, please do not hesitate to
tell me]

The quoted bluetooth pull to net afaics came a tiny bit too late for
this week's net PR to mainline. I assume there won't be another this
week, as that would be unusual from a look at the history (and well, if
I'm wrong I'm happy!). That is kind of unfortunate, as those bluetooth
changes contained a fix[1] for a regression that at least three people
reported (and I know of at least one other person that was affected)[2].
A regression that is known for nearly a month now and thus already took
way longer than the "fix within a week, preferably before the next rc."
rule of thumb Linus recently mentioned[3].

We had a similar situation last week already with the netfilter PR to
net[4], which came on a Friday -- and missed last week's net PR to
mainline, so those netfilter changes were only mainlined yesterday. Due
to this a revert[5] that fixes a regression multiple people reported[6]
missed -rc4 and will only be in -rc5.

These two examples make me wonder if we might want to optimize something
here. Have a second net PR to mainline in some weeks? Or should the net
PR to mainline maybe be sent later during the week whenever possible
(say on a Friday)? That would have avoided the problem. And yes, I know,
Linus at some point due to last-minute problems asked to send net
mainline PRs mid-week. But he iirc (not totally sure, hence correct me
if I'm wrong) recently mentioned that things have improved. That's why
I'm wondering if we should forget about the mid-week thing again and
shift things a little.

Ciao, Thorsten

P.S. Once again I wonder if we should have a dedicated tree to collect
and quickly mainline regression fixes subsystem maintainers ACKed -- but
at the same time I think strongly that it's a totally stupid idea, as
bypassing subsystem has many downsides (like bypassing subsystem
specific CIs, the need for backmerges [or duplicated commits] and things
like that).

[1]
https://lore.kernel.org/all/20260319152247.13225-1-luiz.dentz@gmail.com/
-- in next as 761fb8ec8778f0
[2]
https://lore.kernel.org/all/20260301233619.1807980-1-joanbrugueram@gmail.com/
and links to bugzilla in that thread
[3]
https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2BLsMyJmcuMSA@mail.gmail.com/
[4] https://lore.kernel.org/all/20260313150614.21177-1-fw@strlen.de/
[5] https://lore.kernel.org/all/20260313150614.21177-5-fw@strlen.de/
[6] https://bugzilla.kernel.org/show_bug.cgi?id=221152,
https://bugzilla.kernel.org/show_bug.cgi?id=221158 , and
https://lore.kernel.org/all/143e1a402ad78dd7076516a6ceb637f378310b16.camel@sapience.com/
(some of those are with stable kernels, where the culprit was backported
and reverted earlier already due to the regression)

