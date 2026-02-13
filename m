Return-Path: <netdev+bounces-258526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KA3FM18jmmJCgEAu9opvQ
	(envelope-from <netdev+bounces-258526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7801323E6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0268C301F327
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DD20A5C4;
	Fri, 13 Feb 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRc74ysD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30D1386DA;
	Fri, 13 Feb 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945737; cv=none; b=uV38LbupvvAP15tNBlh78v+xaWq15l2t0ug3rbin7w8YiKwjvhLlGh3BrqyXecDc/ZdovDTX8VeeRqdaMvmbZlA1jN0aeEqX6tm3ROX/EdpMwwsHYlQNlMGyLWKqozjMtwxuHfuE9gvGSygRIsrXc+7WoJK9pksCVbp2amS3yhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945737; c=relaxed/simple;
	bh=fV90tJ7gdPh2Pj9/Q235En+ABb/bjRugS5dU4Rm+nlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAwoBy9d3UMSNitq/+oC4OeMgyhWhJU0J4PBXB8/GMIYyP3uja5HHvpmXUbrKLrrnYjxazSB+MH6GbWe6hMkuiFU9zvgU498OeiI1KbvzDSvQNmBrSiLFfdYq9iqaBvRDYcR60pXd8Gk0Jkhi1Q47PMX5xirToyebNJO711mHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRc74ysD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25ADC4CEF7;
	Fri, 13 Feb 2026 01:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945737;
	bh=fV90tJ7gdPh2Pj9/Q235En+ABb/bjRugS5dU4Rm+nlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRc74ysDqJYJS9c4iM/b5Nl+k8sfzcilp+eEdPCI9OhPXdqbtm5uDg1V2sva3/CgP
	 b0E0Wal5W0AMw2LgrHdeYibLZr4tiM3zTW2WTzWcLbI/J0RjkEWiKGi/vA0F6/bIZc
	 8bL8SjUakcH4Ax1wGkYw2kduaLp4UgvsJ+XmI/MMy1tpvU3UZJZLe8GX2G9ud0ljwQ
	 P2ZlY7VzRqD0o+ywgAbrFHQcVsrr74NYMOCMe76GbvSg3EFVRzN9kivul1FsHlqeRF
	 gyaWSgsRVFxGCQWUmFL1I2shvvVPKT3sgbyuvbQtbAnDprGhm6fxbvs/tD3pVa8DfU
	 DtZTuUencYW5g==
Date: Thu, 12 Feb 2026 17:22:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Yael Chemla <ychemla@nvidia.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Willem de Bruijn
 <willemb@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 noren@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: rss: validate min
 RSS table size
Message-ID: <20260212172215.0a3295a0@kernel.org>
In-Reply-To: <dbbe9690-996f-4a63-90a0-baec52c27236@gmail.com>
References: <20260131225454.1225151-1-kuba@kernel.org>
	<9f535014-80eb-4f57-b047-3638579bde9a@nvidia.com>
	<20260211134319.39710c1d@kernel.org>
	<dbbe9690-996f-4a63-90a0-baec52c27236@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258526-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC7801323E6
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 11:41:19 +0200 Tariq Toukan wrote:
> On 11/02/2026 23:43, Jakub Kicinski wrote:
> > On Wed, 11 Feb 2026 22:10:56 +0200 Yael Chemla wrote:  
> >> Thanks for the test addition. I wanted to raise a concern regarding the
> >> spread factor requirement that may apply to mlx5 and potentially other
> >> drivers as well.
> >> The real issue arises when the hardware's maximum RQT (indirection
> >> table) size isn't large enough to accommodate both the desired number of
> >> channels and a spread factor of 4. RX queues/channels serve multiple
> >> purposes beyond RSS - they're also used for XDP, AF_XDP, and direct
> >> queue steering via ntuple filters or TC.
> >> Artificially limiting the number of channels based solely on RSS spread
> >> requirements would be overly restrictive for these non-RSS use cases.
> >> In such scenarios, we'd rather have a slightly degraded spread factor
> >> (< 4) than limit channel availability.
> >> We'd appreciate any feedback on this approach.  
> > 
> > That's fine. In fact IIRC ixgbe (infamously) had more queues than
> > it could fit in its RSS table. So none of this is new. At the same
> > time if user _does_ want to use a lot of queues in the main context
> > fewer than 4x entries in the indir table is inadequate.
> > 
> > The test is based on production experience, and provides valuable
> > guidance to device developers.
> > 
> > I'm not sure what you want me to say here.
> 
> No doubt that larger factors help overcome imbalance issues, and it's 
> fine to recommend using 4x (or even larger) factors.
> 
> The point is, when this comes with a selftest, it's less of a 
> recommendation/guidance anymore, it becomes kind of a requirement, an 
> expected behavior. Otherwise the test fails.
> 
> This ignores multiple other considerations:
> 
> 1. Existing behavior: In general, mlx5e today implies 2x factor, so it 
> would fail this new test.
> 
> 2. Device resources: In large scale (high num of channels, or high num 
> of netdevs on the same chip, or both), it is not obvious that increasing 
> the indirection table size is still desirable, or even possible. To pass 
> the selftest, you'll have to limit the max number of channels.
> 
> 3. ch_max should win: Related to point #2. Driver should not enforce 
> limitations on supported ch_max just to fulfill the recommendation and 
> pass the test. I prefer flexibility, give the admin the control. That 
> means, driver would use 4x factor (or larger) whenever possible, but 
> would not block configurations in which the 4x factor cannot be satisfied.

Oh I see.. I wasn't aware the CX7 has a limitation of the indirection
table size. I wrote the test because of a similar limitation in a
different NIC, but that one has been fixed.. I have limited access to
CX7 NICs, the one I tested on maxed out at 63 queues so the test has
passed.

Is it not possible to create an indirection table larger than 256
entries? 256 is not a lot, AMD Venice (to pick one) will have up 
to 256 CPU cores (not threads) in a single CPU package.

