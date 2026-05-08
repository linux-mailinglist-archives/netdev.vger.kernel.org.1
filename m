Return-Path: <netdev+bounces-285732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEHIDrqs/WlOhgAAu9opvQ
	(envelope-from <netdev+bounces-285732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 922714F4415
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661EF305774F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92463A4F33;
	Fri,  8 May 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kYnlBotb"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7C39023B;
	Fri,  8 May 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232382; cv=none; b=fczTgATurD0aKzDkzpYfDRyWPQPfEACftx9p4OuG8Zhjx+NFTvXU6E+1Mb4oe2dN/rLa6CWNjg1lItFjqKoBRIO1SeqGw/SWDU9JKpb+1e6iuifIiZgcbATLEI47wY81NmBBMWmezLdYOs9LzN0Ol5cgt7GPveAq43P4gH4qakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232382; c=relaxed/simple;
	bh=G8UeJIyzdcyAbgA6O/501Mc6zLmJzQnSY8FWJMyfRa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7ivJO4KpcbPwpl89LsvZUDPoeRDx7AuyCn/RpxC1XWAgIeHWgTGKjJLBLq75rzuO5GxJchm59m/OswV/ZhImFPhxHQwelQk3IVO/WvGBw/yhQrrRnqQNKODTtRf8aS+rpuw4L6gIj5XmNyId+vazQd1SGc8bhoBEeaVGrv+UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kYnlBotb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b69+c68PcW/gVrva7FyMBgJhuQad+cLwrzLjihZl4E4=; b=kYnlBotbAg1PgYwUyJjWrudB9E
	WGshMxV1dlX+vWqSO+MUlgpzqd7x/G3xg47kXHBXndBhdx6rY2oPpxipI1694vX3yA5vH7j+NVRUT
	piQXqVBm5UbHgpNfyzokqDdPFqd50u1QJprhoeZuMs++RFXWh2b+UVPjCiMDv08cQB6W3uOCpoUra
	m3145EvmEn2xjjTyZDwUWtRJ/efDqRncs3mydvpLZ+An0WlFxlzGIkSid3xkauyobdIWzvibkcHjp
	RmHIQdlErPEHv8cdLRuS6AX6YWhiXmXyan6AJBZ68TLNYcCefH4hZymNLf+/8v6daTzOmGwU+z9nj
	OmsbdChw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLHTM-0052w9-2X;
	Fri, 08 May 2026 09:26:17 +0000
Date: Fri, 8 May 2026 02:26:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/sched: sch_dualpi2: annotate lockless
 stats reads in dump path
Message-ID: <af2rSnp-8Bhw-GHI@gmail.com>
References: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 922714F4415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 12:59:18PM +0530, Vineet Agarwal wrote:
> No WRITE_ONCE() annotations are added because these statistics are
> maintained as best-effort counters

Adding READ_ONCE() on the dumper side without matching WRITE_ONCE() on
the writer side does prevent torn stores, and also not actually silence
KCSAN, last time I checked.

> , and the update paths already use simple non-synchronized increments
> consistent with existing qdisc statistics patterns. The intent of this
> change is only to make the lockless read semantics explicit.

I am not sure READ_ONCE() does that. Usually data_race is best used for
this.

> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c index
> 241e6a46bd00..40035f70db80 100644 --- a/net/sched/sch_dualpi2.c +++
> b/net/sched/sch_dualpi2.c @@ -1046,14 +1046,14 @@ static int
> dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d) struct
> dualpi2_sched_data *q = qdisc_priv(sch); struct tc_dualpi2_xstats st
> = { .prob			= READ_ONCE(q->pi2_prob),
...
> +		.credit                 = q->c_protection_credit,

Why this is unnanotated. isn't it uupdated locklessly in
dualpi2_qdisc_dequeue()?

Also, you have spaces other than tab for this instance.

