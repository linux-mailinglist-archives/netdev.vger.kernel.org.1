Return-Path: <netdev+bounces-289090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPQ7O3cjC2pJDwUAu9opvQ
	(envelope-from <netdev+bounces-289090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:34:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337256EE59
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EFB3035177
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A4480DF7;
	Mon, 18 May 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1dr2xy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7B3F54AD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114382; cv=none; b=iyTHm+Pw+K2OiSIT1MP0UYMc+N1CsVJkgJkVmRsS/b/TWOjmXUr7My2uKqnmFxRRm0bqfgeVign6yhr2IYl7gc4kDEtmAiWELjDC4qyUBzIj/tGOm+r3+a2Pqkzlp7ws5Zh8vL6O31Fd3m8M61v1oSc+pL8V0GWOzgidrBKquKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114382; c=relaxed/simple;
	bh=89I3dsEQmgvGzJ6RM/nLpu3C1uHMvEPGKm+69HVlElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/I1oLze84tMconWTWj1BWM1zdpiQdqJV85FwhfipV0e8NOy5nodGtis1c1v22lonI1XySQrrbcZQQmmNfKm2qqcdW2zF6y8H421fdffbC+2gIz0BF3hA/PSVdk+MHLbTRDy4LnuY4764QQCgJPL0Me+NNXQrZfX58tO+O6HYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1dr2xy9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso27012955e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114375; x=1779719175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUmc/2eFwDyPu288j7GDElCwP6ZQHTGou0nPfUDNu+s=;
        b=U1dr2xy92aSTrdsYmr2TFg4pVx/efpAlwGG+i0zi5cFK/HlJeQWtEet9mJKTzdnL1g
         21w2oo8rTau6NH21XXbMUxTge5HQPsEBwb7DmFnRqWyIiSdPJgHuPm/6c4coqyvWa1i9
         QhSKQUhBmHRZintfdmAZa9s9R0cnVyzxZ/Hea3YWjOjSbAGDncy9cYsKtlyk/aj17z5L
         96czrSppm8nZxvpNc2y3lVNXnq4adNSZH1W0BTY26M2nmDNzOLWbjcp4vxVtrXXie7gg
         PVVEhQviT+ul71hiQJqaRZvBK9Z9FvERWOOhCRjDccnaBd/PEPeLtPMIa4pRY7HSNgob
         xekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114375; x=1779719175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUmc/2eFwDyPu288j7GDElCwP6ZQHTGou0nPfUDNu+s=;
        b=ZE/M218mdW9iqXrhpjA6e3B8G0a1srl5WUixX59eHg4DGgyvL1e1/ElGfub6RBRGjK
         yQI6tOVZDVRgbxbDJ/Qrstbwt5aSca2jmykj0njaEMcIqrEIK9T9WCayfd5l2vsXit+S
         eH5qL/XgUPSrjgChS41YwcKtxUSTp07HoQxXSdqsZRcpw7ivBd9vjnbVq9RrxDrjAWBn
         +Kd5q7G+AP9WUSsoXl9F2i94dXO0ftjwSSSf8KTfAYkFIT0K5V/ZHGRErIOS1yM6r6+2
         /ZtiY/OIMwQMnJOX5wvLKQFv+jwRVrxfNWK9ZKkddM4cXuEEVZ9ExvDAwR8xKOV2umcg
         mogA==
X-Forwarded-Encrypted: i=1; AFNElJ+UQzn+6OEjQYzMFAkGCngzY+IxOHu/aJuu4NtHYM4jOXGKnwADesBGvLUgugJlLTJz0OQPFPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuRMrAyWv3xDF9mOJv70rO+0SgKaGIXlRU9YuTEkLpQLH+o/7
	7nNdiZYJQpIEdieTowpxXTnWKxCtfykwDNC4enPfqKJ7yC8wq2SNzPj1/NoKPwGCcYa/ww==
X-Gm-Gg: Acq92OFQBsPZirdUO9dDNvQnr+OOgcWewI+7BrA3+T4ffuUCl2u5Q9SMnPzCTQaAOfq
	Vc4Ai4Luw/mO6coiaAPwTpCKj1UFXELdbdzGJeZTpRkNQv18ADm9bZi8lH9PBhugZJUNpnT0Omj
	AbUl+Yhs77xI9MufgI+YOpmxC10j22lRTc1TI1pOJKVqqFRPTUZpM0DExCtwrQ6xWJstfPya/+3
	znwMI0cvpZKirpogBhVtG+Hco1WBxzqgGv7gndQ/DSgwQveBM07ThXkkALvQ9K79bK7wgx20Kcs
	f61lB2tpgWBmhbmEWSZ4+gOiCMBUe0Y/A/0/6Tiprprl/Ke5pqbsa2B7foMzUhoIMYZqEe95Gos
	wsD+hqpyqJuKDhdYelIZrvdVcd1TDfrfXkkyCK/08N5JyrH3lEGPD7FXgcxquXlpCDYUk8BuMIf
	o4nh8T1gx8/2L5Fd6EcIIoj+/kROJravMfhj1edsnhuOwkJsJEpifGzU8=
X-Received: by 2002:a05:600c:c087:b0:48a:7b55:12a6 with SMTP id 5b1f17b1804b1-48fe5cb36aamr188849425e9.0.1779114375254;
        Mon, 18 May 2026 07:26:15 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm259037795e9.2.2026.05.18.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:26:14 -0700 (PDT)
Date: Mon, 18 May 2026 16:26:12 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <agshhAKrNWKG8cpa@gmail.com>
References: <20260518122842.218522-4-mahe.tardy@gmail.com>
 <dc63930101e50f36995ef7b487096c6580e7eaa75594ab083ff6e0bc28eeb046@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc63930101e50f36995ef7b487096c6580e7eaa75594ab083ff6e0bc28eeb046@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	TAGGED_FROM(0.00)[bounces-289090-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6337256EE59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:34:48PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714..843fa775596b 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> 
> [ ... ]
> 
> > @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> >  	return 0;
> >  }
> >
> > +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> > +
> > +/**
> > + * bpf_icmp_send - Send an ICMP control message
> > + * @skb_ctx: Packet that triggered the control message
> > + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> > + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> > + *
> > + * Sends an ICMP control message in response to the packet. The original packet
> > + * is cloned before sending the ICMP message, so the BPF program can still let
> > + * the packet pass if desired.
> > + *
> > + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> > + * supported.
> > + *
> > + * Recursion protection: If called from a context that would trigger recursion
> > + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> > + * re-entry.
> > + *
> > + * Return: 0 on success, negative error code on failure:
> > + *         -EINVAL: Invalid code parameter
> > + *         -EBADMSG: Packet too short or malformed
> > + *         -ENOMEM: Memory allocation failed
> > + *         -EBUSY: Recursion detected
> > + *         -EHOSTUNREACH: Routing failed
> > + *         -EPROTONOSUPPORT: Non-IP protocol
> > + *         -EOPNOTSUPP: Unsupported ICMP type
> > + */
> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > +	struct sk_buff *nskb;
> > +	bool *in_progress;
> > +
> > +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> > +	if (*in_progress)
> > +		return -EBUSY;
> 
> Is the per-CPU recursion protection flag safe without disabling
> preemption or bottom-halves?
> 
> Since cgroup_skb egress programs execute in process context, they can be
> interrupted by network RX softirqs on the same CPU. If a task sets
> *in_progress to true and is immediately preempted by a softirq that runs a
> TC ingress program calling bpf_icmp_send(), it will read the same per-CPU
> flag and spuriously fail with -EBUSY.
> 
> This was raised in v5 by the Sashiko AI bot:
> 
>     Since cgroup_skb egress programs execute in process context, they can be
>     interrupted by network RX softirqs on the same CPU.
> 
>     If a task sets *in_progress to true and is immediately preempted by a
>     softirq that runs a TC ingress program calling bpf_icmp_send(), will it
>     read the same per-CPU flag and spuriously fail with -EBUSY?
> 
>     Does this critical section need to run with bottom-halves disabled?
> 
> https://lore.kernel.org/bpf/20260515202358.20252C2BCB0@smtp.kernel.org/
> 
> Would using two separate per-CPU flags (one for softirq context, one for
> process context) or disabling bottom-halves around the critical section
> address this race condition?
> 
> [ ... ]

I've replied on the v5: the race should be acceptable as it will fail
close with EBUSY, if we want to avoid this we might want two PER_CPU
in_progress flags, one for softirq and one for the process context. In
any case, what we want to prevent is recursion (the kfunc triggering
itself), so softirq interruption from process should be okay as it
should concern another packet.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312


