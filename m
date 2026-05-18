Return-Path: <netdev+bounces-289093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLNABIglC2pAEAUAu9opvQ
	(envelope-from <netdev+bounces-289093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094656F11F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECCB130055C0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEE371046;
	Mon, 18 May 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDoFq9u1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FD36F429
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115176; cv=none; b=MMYLft1OOA0/ObeVcBCqOWCW3R+vD8fagU37VIB1bncHWhJRLeaF7+cA8nnBeEvMgxqvJCQRCNfjd9S0qVKsupgjSIGaB1tJdaoYls2pbTauJLF1da7UbxbM2Q9W2gzJq9eCyhDcMOETzZXX+UKTHcNhWw4gG3Cy0LzPLu6TLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115176; c=relaxed/simple;
	bh=RogBAxxq8noxKAc7aW/xyYbRbLZgr4qUmDiwc9tcu2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFpiJPCvNsybXAAl6pv9WiEX3zbmeh5GlM2AJT+wtCnxguuKpApKMmldU5CYI+JE2fWfhFitEuQBmtZ83gAkYygWQJFp9vbf2GhrEBc7ypUTs+F/YB8tWUqcgGc0Gnk9/lW3+uz0MK3hI64NgS+Wj75xRbr2GvsprCqhMKUN9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDoFq9u1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so1574398f8f.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779115174; x=1779719974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUlcTJbqHH/a0lNc4ZwIftVoYCcktEMzS3W/h9hsyBs=;
        b=mDoFq9u1AsPUh543t3oCblxxKR0/v4u1fk5NZ5KmUcc1zN+5W7fQiD4Whs+NSDfCAb
         tLoPheKhObqnFK0GvtIIYalhaHbA/RO9dV6FOHeEDdYZIJsqduraswBuYTqPHIy6ZbGb
         s4p0PzjsjWwXOr3XGbnvfwgcbdwugG9a6V0r26HHIHn7HxJf/C/6XhUEF5ym/DYM2V8p
         YEElN95KLcDABbgX259B8Hv6lq+AiAEcBVpq02k8l5dYzVcShN+VBYIkmE1ZqBXDE3x5
         fNQMrJWe3yhJJaBbGuwOUnnBxoOAgwGWUNSx5BJ8w/HHi71RTgRU5I3uu5U6g1SzbbgL
         aYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115174; x=1779719974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUlcTJbqHH/a0lNc4ZwIftVoYCcktEMzS3W/h9hsyBs=;
        b=POyvXH02od+ka49hziqhq/C5GFPiEU0e0zRB/F3GuYncGkxQPBV5R4x/1s8w0ikyao
         DcZtYclPNwNJZHHqFTvC5uU+DaTQ50uPYgYypF8mPHmMmm8qdZbIpsfcw3GU0O4RZO7P
         GP3nzqSLDgJieM6qomZzsoBFN5GGu+aXRizfrmjDv8W/zbMY7JzsO6mDrC5n6iBbex0g
         FqrcgjQFFiJ/b5kDuIz5ajtAtZQ68CRb4lgE6QICTBPX+mGs4BfNI2S7B/LjHouz1zbT
         Fx2jM4kPzL8zveKR2wP46Kdxdapytt8deahBQuDWbMvT6+qb5Il6xT9lxdoeea+/1abv
         vprA==
X-Forwarded-Encrypted: i=1; AFNElJ88szBZhrr6kpf+vxTzhPm7MnZdSoiD6B88pSb4K2+R4HmClOCJvYyBFg+IDCXVqa5YfgEBHBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHtV2LPdh0CyqdtIDyygu6rzkoJZaGT+BaIvhGYh/EKnXtXX8
	tZtmBCOie8ko4Zt6DxgAF3IopcpGuaykbA5jWzZKQRVZ9lxi2qO/0Gf8
X-Gm-Gg: Acq92OGrfaurQ7OlmnaQ5tUqJk87pGTNl2PvlcOwJyk2BXkDr1wULApR1nqqj+KVEoc
	g80spNrJND3w8L6ZLikUxfN2t6h4N5HW8o9Wi7cXxCV6DBIFAY/owDeuqFaAudT329UuUojSzd5
	th0YPDcpiJqlxQ5dqohmanv4PZIdudk28RodiEOEA0UzMXrjdctU+487nZz32oxhy6L4sLTtspq
	KtvHk2tKdCFwwWQqmq7NXPOmQj3h5E2hnrSbmbg1TC/6OUCmlif83oS0cbBlRaPNHcqwgPT3bcq
	TSIcedg+W4c2wDCSCEd5jIPfEbNUxPsSARGx7VfQPadbqiJ305H287Z+NjBxIk5WFLxsXmg6D4d
	SEvpqlLkzCpE8qLuq8gmQLakdx+7Ofx0rLR8NDfUYgcyXgQT9j+hxkpnqbOXmKnlhD9D4+AJ0Qp
	Yj5YIBdxjBhYcTyTYxRbVR1+NToqB2zCc2QxErmXKx9hvppISTarN0jYI=
X-Received: by 2002:a05:6000:240b:b0:452:bc55:c684 with SMTP id ffacd0b85a97d-45e5c5d6764mr25771099f8f.19.1779115173464;
        Mon, 18 May 2026 07:39:33 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm8741804f8f.6.2026.05.18.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:39:33 -0700 (PDT)
Date: Mon, 18 May 2026 16:39:31 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 6/6] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <agsko7KjEILkHAk4@gmail.com>
References: <20260518122842.218522-7-mahe.tardy@gmail.com>
 <92695da279ff66c47eeab8c93562f171982732ad4f420f0057c773efb6c1db8f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92695da279ff66c47eeab8c93562f171982732ad4f420f0057c773efb6c1db8f@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	TAGGED_FROM(0.00)[bounces-289093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0094656F11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:07:53PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index d0ac0502f6df..a9e9806877cf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> > index 6e1ba539eeb0..7830334b747a 100644
> > --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> > +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> > @@ -13,6 +13,9 @@ int unreach_type = 0;
> >  int unreach_code = 0;
> >  int kfunc_ret = -1;
> >
> > +unsigned int rec_count = 0;
> > +int rec_kfunc_rets[] = { -1, -1 };
> > +
> >  SEC("cgroup_skb/egress")
> >  int egress(struct __sk_buff *skb)
> >  {
> > @@ -65,4 +68,32 @@ int egress(struct __sk_buff *skb)
> >  	return SK_DROP;
> >  }
> >
> > +SEC("cgroup_skb/egress")
> > +int recursion(struct __sk_buff *skb)
> > +{
> > +	void *data = (void *)(long)skb->data;
> > +	void *data_end = (void *)(long)skb->data_end;
> > +	struct iphdr *iph;
> > +	int ret;
> > +
> > +	iph = data;
> > +	if ((void *)(iph + 1) > data_end || iph->version != 4)
> > +		return SK_PASS;
> > +
> > +	/* This call will provoke a recursion: the ICMP packet generated by the
> > +	 * kfunc will re-trigger this program since we are in the root cgroup in
> > +	 * which the kernel ICMP socket belongs. However when re-entering the
> > +	 * kfunc, it should return EBUSY.
> > +	 */
> > +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> > +	rec_kfunc_rets[rec_count & 1] = ret;
> 
> Will this program affect background traffic when running on the system?
> 
> The recursion program is attached to the root cgroup and intercepts all
> IPv4 traffic. While v5 changed SK_DROP to SK_PASS to avoid blocking
> traffic, the program still calls bpf_icmp_send() on every IPv4 packet
> without filtering for test-specific traffic.
> 
> This means background IPv4 traffic (SSH, DNS, other tests) will trigger
> ICMP Destination Unreachable messages, potentially causing network
> disruption and test races on rec_kfunc_rets and rec_count.
> 
> The egress program demonstrates proper filtering by checking for TCP,
> SERVER_IP, and server_port:
> 
> SEC("cgroup_skb/egress")
> int egress(struct __sk_buff *skb)
> {
> 	void *data = (void *)(long)skb->data;
> 	void *data_end = (void *)(long)skb->data_end;
> 	struct iphdr *iph;
> 	struct ipv6hdr *ip6h;
> 	struct tcphdr *tcph;
> 
> 	iph = data;
> 	if ((void *)(iph + 1) > data_end || iph->version != 4)
> 		return SK_PASS;
> 
> 	if (iph->protocol != IPPROTO_TCP)
> 		return SK_PASS;
> 
> 	if (bpf_ntohs(iph->daddr) != SERVER_IP)
> 		return SK_PASS;
> 
> 	tcph = (struct tcphdr *)((void *)iph + sizeof(*iph));
> 	if ((void *)(tcph + 1) > data_end)
> 		return SK_PASS;
> 
> 	if (tcph->dest != server_port)
> 		return SK_PASS;
> 	...
> }
> 
> Could the recursion program use similar filtering to explicitly check for
> the test's traffic?

I could restrict a little bit more by ignoring all traffic that is
non-TCP for the dest port or non-ICMP but not sure this is actually
needed. E.g. writing something like this before bpf_icmp_send:

if (iph->daddr != bpf_htonl(SERVER_IP))
	return SK_PASS;

if (iph->protocol == IPPROTO_TCP) {
	tcph = (void *)iph + iph->ihl * 4;
	if ((void *)(tcph + 1) > data_end ||
	    tcph->dest != bpf_htons(server_port))
		return SK_PASS;
} else if (iph->protocol != IPPROTO_ICMP) {
	return SK_PASS;
}

But not sure this is strictly needed.

> 
> > +	__sync_fetch_and_add(&rec_count, 1);
> > +
> > +	/* Let the first ICMP error message pass */
> > +	if (iph->protocol == IPPROTO_ICMP)
> > +		return SK_PASS;
> > +
> > +	return SK_DROP;
> > +}
> > +
> >  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312


