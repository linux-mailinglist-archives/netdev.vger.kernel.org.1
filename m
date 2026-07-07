Return-Path: <netdev+bounces-305394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39jgNtnPTGqOqAEAu9opvQ
	(envelope-from <netdev+bounces-305394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C3771A1FD
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V4Y7Q7RH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305394-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305394-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 623A2303C2A5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3678A3DA5D9;
	Tue,  7 Jul 2026 10:06:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4430EF94
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:06:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418782; cv=none; b=kxrF+0N+9c3V+pm1Gkvh6JEYSOWb3TffuCWaNzBiprangj7T/2vXekIcgQJcwSxT0CGQFQA1PMgdrwkdlXkF/4vhxwlPDDlLdFe9UY1FrMPrZXoeNd1MOd6mIQIu4rB6uCRpVPQnjElV/NEnPd+h9yNvGfReh+KW7FiQZGtxhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418782; c=relaxed/simple;
	bh=OAKB6REpwMAL3mD8f/kvOYmQD6X0GhKuKto/VKRSscc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNSmW/TxwkXB4kmfKKqo4/0CxhVC9iHl//nRBIdO1bDfuDw7WhF3eAwzrgQOBCHj//vTlR3G21QR8oa4/N62GhtdyPT9Kkw0ol5BpM7lHckH+puCLPf8GqxCfbDm271CqbFIDgIZpcQylvEiVPrNn8Tcqq2/WNdMYbH2vpBkAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Y7Q7RH; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so21424145e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783418779; x=1784023579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nKMzBrNPng+OFv7tZKgSIEKfGOpCS7rDlLCvXC7fDo=;
        b=V4Y7Q7RHfgFf+JB6BGzY4VjhE15lIDP66ULj9x8I3S2HI4TtCPN6Eu1i6y1EiplEWP
         ztCXpnHktjsci8m22o2YhPgew1YkXfShxQ5g/AkhARIjckpIEQr31cQdQnk6LKS7B8+u
         h+DmlPSkE1dSVPHhnBZMzIhzidx4Bj+HTzTrAo50r+12kNBvYVZ/wTxxWtlwDGDYRr+5
         AXIeHShm970EQMyISxF1YDcXZ4hEgs/hnBbd9qr7y939XJ3CM97M/6cL/ZyHmtbbzVu5
         GU5yBasEG0wg1ZRZioCpAlpQmGXRZ9zsltZyMlb1eDpTdYgPDH+iCrHYAcH6tJhI0ZUl
         mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418779; x=1784023579;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nKMzBrNPng+OFv7tZKgSIEKfGOpCS7rDlLCvXC7fDo=;
        b=pUXAcSz0mE3R2DdVGpG9exzfILTg/d8ROhBgoxsLuwp+9g0UW5HVA0JQucIFqF9Mpo
         TWOg/8u7hbXtX3vatu+P7zbVBjf3gkMa0nDl14BYaMOySLbNdJ/sl3Ta4acdq1UGQKix
         ENDI0P0vqpo4Y4SG4Pbk8Djhy00rkU5eHTy080JnHwfMetWF4+zOq4IAL2AzJTWR7WUU
         M01OxGgPGiAGs6U80hYoZLWjiCnsn/eOYl4PnA9SAt5laWqWAh/WzbSTTwr8eRMduprD
         d2Q0cTnRVEJxcmHUN/LpRi5pjn7ihV2iB5ZGFcOxMPFVh6YIcr3JWJlclIG7DKw/kDSY
         ELvw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7nRhhvAJDst8+ftv+sL/JAsNltZR5kGPHJq4iUrHkcPrwo5gBnssCS9jlSPlDrk27AUJhK/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4vjVMqfqj5STC8Q0YOiGfUTBiWIhamuDjOgm7mERaCq/DURw
	LI5+5hERdIJdpiup3kYTwgk7+Cx1SBafvlIjWWuq1C82nhLC4hHXefn4
X-Gm-Gg: AfdE7cmQqoGcRO1CjzMnnVatagrjjkYInckX2jACRf16uNOKYm9n5FFCITRn+ZoxfEi
	Jlgt8Ep0iAyyHXbLvIjL5sFyY2bsVR85JS1JzM+ZxPWNMns1UiWEZvPyjrW+s8Txy7UFR2vo4L4
	fhKAocqUFuIbLYUBOn/0IqAujJXswjQ+qMJ6dEFfCEZfpQ8VMpZfW69MDIsvAWvzm2UwddOr3Ue
	VMLlyWdJXUL1wykZi7JEXMris4BDIlFYtLG28D/njRe8HFt2RZcAtcWi0Ni7XPldLk7geV7u6x6
	xh4koCSqTJGn/F4ehYtNO3plTbORWjFEtp9XHqpcXRmZEvu+C34xViv3YQIGxc0sENgDdMsZ86J
	Zbnp2aJqkr2UfkP+7Vmc3lkVJF5HRec60FQC9Pmhnz03c1UeFYhEMjiPLpMQIKyNzwK/gI6pvrO
	7socZqcZXhaZmzCkIq2slHYUDeuPrAqtXhudNn5/mYneL7
X-Received: by 2002:a05:600c:3b05:b0:493:bb45:d54d with SMTP id 5b1f17b1804b1-493df09e3a9mr49840045e9.37.1783418778334;
        Tue, 07 Jul 2026 03:06:18 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3676dsm47709045e9.5.2026.07.07.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:06:17 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:06:15 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com, song@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzPl9lLtjcRFXxD@gmail.com>
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
 <20260706230142.1691146-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706230142.1691146-1-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:song@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,opts_copy.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38C3771A1FD

On Mon, Jul 06, 2026 at 11:01:27PM +0000, Kuniyuki Iwashima wrote:
> From: Mahe Tardy <mahe.tardy@gmail.com>
> Date: Mon,  6 Jul 2026 09:35:21 +0000
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> [...]
> > +static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)
> 
> Can we do this better with assigning a single bit to task_struct ?

Yes, that would be way simpler but I avoided touching task_struct. If we
are okay with that then it could be simplified.

> 
> > +{
> > +	struct bpf_ksock_send_guard *entry;
> > +	struct hlist_bl_node *pos;
> > +	struct bpf_ksock_send_bucket *bucket;
> > +
> > +	bucket = bpf_ksock_send_bucket(current);
> > +	hlist_bl_lock(&bucket->head);
> > +	hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
> > +		if (entry->task == current) {
> > +			hlist_bl_unlock(&bucket->head);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	guard->task = current;
> > +	INIT_HLIST_BL_NODE(&guard->node);
> > +	hlist_bl_add_head(&guard->node, &bucket->head);
> > +	hlist_bl_unlock(&bucket->head);
> > +	return true;
> > +}
> > +
> > +static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
> > +{
> > +	struct bpf_ksock_send_bucket *bucket;
> > +
> > +	bucket = bpf_ksock_send_bucket(guard->task);
> > +	hlist_bl_lock(&bucket->head);
> > +	hlist_bl_del(&guard->node);
> > +	hlist_bl_unlock(&bucket->head);
> > +}
> [...]
> > +__bpf_kfunc struct bpf_ksock *
> > +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> > +		 int *err__uninit)
> > +{
> > +	struct bpf_ksock_create_opts opts_copy;
> > +	struct bpf_ksock *ks;
> > +	struct net *net;
> > +	int err;
> > +
> > +	/*
> > +	 * sock_create() derives the network namespace, credentials, and cgroup
> > +	 * from current. Kernel threads, including BPF workqueue callbacks, do
> > +	 * not carry the context of the task that invoked the BPF program.
> > +	 */
> > +	if (!bpf_ksock_has_user_task_context()) {
> > +		err = -EOPNOTSUPP;
> > +		goto err_out;
> > +	}
> > +
> > +	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> > +		err = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	opts_copy = (struct bpf_ksock_create_opts){
> > +		.family = READ_ONCE(opts->family),
> > +		.type = READ_ONCE(opts->type),
> > +		.protocol = READ_ONCE(opts->protocol),
> > +		.reserved = READ_ONCE(opts->reserved),
> > +	};
> > +
> > +	if (opts_copy.reserved) {
> > +		err = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
> > +		err = -EAFNOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.type != SOCK_DGRAM) {
> > +		err = -EPROTONOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
> > +		err = -EPROTONOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	ks = kzalloc_obj(*ks);
> > +	if (!ks) {
> > +		err = -ENOMEM;
> > +		goto err_out;
> > +	}
> > +
> > +	net = current->nsproxy->net_ns;
> > +	if (!bpf_ksock_net_try_charge(net)) {
> > +		err = -ENOSPC;
> > +		goto err_free;
> > +	}
> > +
> > +	/*
> > +	 * Use the normal current-task socket path so LSM/cgroup policy,
> > +	 * socket labels, and the active netns reference match a socket(2)
> > +	 * created by the BPF program's caller.
> > +	 */
> > +	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
> > +			  &ks->sock);
> 
> This also triggers LSM in __sock_create() so needs the loop
> detection, no ?
> 
> Same for __sys_bind_socket() and __sys_connect_socket().

This should be okay as create/bind/connect can only be called from
SYSCALL progs and not LSM progs. We only care about recursion from the
kfuncs in the ksock_kfunc_btf_ids group which are also allowed from LSM
progs (release/acquire/send).

> 
> 
> > +	if (err)
> > +		goto err_uncharge;
> > +
> > +	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
> > +	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
> > +
> > +	refcount_set(&ks->usage, 1);
> > +	put_unaligned(0, err__uninit);
> > +	return ks;
> > +
> > +err_uncharge:
> > +	bpf_ksock_net_uncharge(net);
> > +err_free:
> > +	kfree(ks);
> > +err_out:
> > +	put_unaligned(err, err__uninit);
> > +	return NULL;
> > +}
> > +
> > +/**
> > + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> > + * @ks:		The BPF kernel socket context.
> > + * @opts:	Pointer to struct bpf_ksock_addr_opts with local address.
> > + * @opts__sz:	Size of the opts struct.
> > + *
> > + * Binds the socket to the specified local address and port.
> > + * This is optional; if not called, the kernel will auto-assign.
> > + *
> > + * This function may sleep while binding the socket, so it can only be used in
> > + * sleepable BPF programs (SYSCALL).
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> > +			       const struct bpf_ksock_addr_opts *opts,
> > +			       u32 opts__sz)
> > +{
> > +	struct sockaddr_storage addr = {};
> 
> nit: we don't need to initialise here since bpf_ksock_get_addr() does.

Ah actually I didn't know that compound literal in C would zero the rest
of the struct. Thanks, let's remove those two then.

> 
> > +	int addrlen;
> > +
> > +	if (!bpf_ksock_has_user_task_context())
> > +		return -EOPNOTSUPP;
> > +
> > +	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
> > +	if (addrlen < 0)
> > +		return addrlen;
> > +
> > +	return __sys_bind_socket(ks->sock, &addr, addrlen);
> > +}
> > +
> > +/**
> > + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> > + * @ks:		The BPF kernel socket context.
> > + * @opts:	Pointer to struct bpf_ksock_addr_opts with remote address.
> > + * @opts__sz:	Size of the opts struct.
> > + *
> > + * Connects the socket to the specified remote address and port.
> > + *
> > + * This function may sleep while connecting the socket, so it can only be used
> > + * in sleepable BPF programs (SYSCALL).
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> > +				  const struct bpf_ksock_addr_opts *opts,
> > +				  u32 opts__sz)
> > +{
> > +	struct sockaddr_storage addr = {};
> 
> Same.

Noted


