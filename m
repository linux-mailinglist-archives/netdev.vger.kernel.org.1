Return-Path: <netdev+bounces-252126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDi+KLp7cWm0HwAAu9opvQ
	(envelope-from <netdev+bounces-252126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:22:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88060467
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7E3F4FA253
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2A34EEF7;
	Thu, 22 Jan 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBvcFxso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84534E776;
	Thu, 22 Jan 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044917; cv=none; b=GAbXNkcTlSK/UOYCvd02hnzoJ2WRYlfs80pzpBuITQQzUus7jG0KVW1r1pARTEvZ7Zo/VSFfLqUk4gy4zRto0yldOol4FmyV1pxDKqXCMAwJQoIGea+8jdMlXPpn1v6XlkwKCi0ZcSyzZvzhBD8O709GE0xxo/29KOl6A+/nk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044917; c=relaxed/simple;
	bh=3C6FBJ4kp4YPfxUWfUW/PvqzmGNNhtUofo1kYMHkO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZIYNFhBPSsrnv7BqOo1f/7Az8mCJGxf+ZVnerFzma7Ts2RZAdQJt9nuSXxNNIzdCfXo1Gqr4e70AOnUzLwbwVlI5AHBEQUol37EPn/rsvJap7RzwCW76K323y2DbaMwEhJ/p4//JtFgvGLs3XagKaIltbeFEwAe0d4rHvJGfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBvcFxso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFE4C4CEF1;
	Thu, 22 Jan 2026 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769044917;
	bh=3C6FBJ4kp4YPfxUWfUW/PvqzmGNNhtUofo1kYMHkO5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBvcFxsoRtid3X9ypvJqUbTH5erk9c6fFaiLPg5mOa8jnRHYgd/LqSQ4EQNbGJljm
	 XBuDtOyAv49ZynaBovbQelPM1nDm7l25B2X+JA5Wrkh2CmxPfxjhG5OoHXz13JiV4+
	 tECpMoujxe98aW7E8I6uXhdScNh9Jb+WHKKOJsnXepkYRl2Sy+kAJWKl2+M7LQm3FO
	 I+kaSSGsatA9p3LXvPlsFBIXuomyqqY79FlZ26jqQ/UctMHrGjRQz31zqh/lmbudiY
	 sA3N4YrP9jwPw5joF3QQymEPROkfywPFJ8pebnLXsZbK9XfMsDt5bgncue2PUHKdhk
	 B4rjSrn6pIsLw==
Date: Wed, 21 Jan 2026 17:21:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, carges@cloudflare.com, kernel-team@cloudflare.com, Yan Zhai
 <yan@cloudflare.com>
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
Message-ID: <20260121172155.6ec96ef8@kernel.org>
In-Reply-To: <412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
	<1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
	<20260120162616.463c8af1@kernel.org>
	<412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-252126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E88060467
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 20:13:31 +0100 Jesper Dangaard Brouer wrote:
> >> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three
> >> drop_reason") (Author: Eric Dumazet).
> >>
> >>    SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
> >>    SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
> >>    SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
> >>
> >> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
> >> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?  
> > 
> > FWIW FLOW_LIMIT is more intuitive to me, but I'm mostly dealing with
> > fq so probably because that's the param name there.
> > 
> > I'd prefer the reuse (just MAXDEPTH, I don't see equivalent of
> > MAXFLOWS?). We assign multiple names the same values in the enum to
> > avoid breaking FQ users.  
> 
> I've taken a detailed look at how we consume this in production and what
> Prometheus metrics that we generate. My conclusion is that, we want to
> keep the Eric's approach of having qdisc specific drop-reason (that
> relates to qdisc tunables), but extend this with a prefix
> "SKB_DROP_REASON_QDISC_xxx". This is what I implemented in [v2] like
> "SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS".  The QDISC_ prefix enables pattern
> matching for qdisc-related drops allowing monitoring tools to match this
> for categorizing new/future drop reasons into same qdisc category.
> 
> For Prometheus drop_reason metrics the decision was to omit the
> net_device label to keep the metric counts manageable and avoid
> exploding the number of time series (lower cardinality, less storage).
> Without qdisc-specific names in the enum, we'd be forced to add back the
> net_device label, which would explode our time series count.
> 
> The FQ flow_limit and SFQ depth parameters have different semantics: FQ
> uses exact flow classification while SFQ uses stochastic hashing. They
> also have different defaults (FQ: 100 packets, SFQ: 127 packets). Having
> the same drop_reason for both would obscure which qdisc's tunable needs
> adjustment when analyzing production drops.
> 
> Having more enum numbers for drop reasons is essentially free, while
> keeping metrics per net_device is expensive in terms of storage and
> query performance.

I'm not familiar with Prometheus is there some off-the-shelf plugin
which exports the drops? The kfree_skb tracepoint does not have netdev,
so if you're saying you have the ability to see the netdev then
presumably there's some BPF in the mix BTF'ing the netdev info out.
And if you can read the netdev info, you can as well read 
netdev->qdisc->ops->id and/or netdev->_tx[0]->qdisc->ops->id

It kinda reads to me like you're trying to encode otherwise-reachable
metadata into the drop reason.

