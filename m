Return-Path: <netdev+bounces-270793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMY/MEvDwWkHWQQAu9opvQ
	(envelope-from <netdev+bounces-270793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267762FE818
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C3F30BEC71
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA4383C6C;
	Mon, 23 Mar 2026 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="QNSANW7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FB2FE582
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305855; cv=none; b=L8Muu9RJ04kUfbmT1PLy67nUv8BaKRwmCWnC7l8Unws6BzeUsNcjqy2s7rjp8omwHs57rOppX3Ij4flx0GuwHhs+Bd/8yxvGictBmL9BuQTUPCRK4cqkc3Q1zAEMlvafTVdvRyDRlFqokL8e5zaNgz8WX3p4or4wBcbjTG9UrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305855; c=relaxed/simple;
	bh=Z4ocOvu96Lz+j5U1eVzagxxsRYGeqp/mHcN9uTIyP30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag3wyBybPvqYkd5WbrvP/U6fOIsSov2Rpk9l0iEpW72Zlb1aPnLO5x1UNd3FOu+tV8jP8ZjRDGk0wj4rV9iyNf6iXgxNe4HdSk9m0QROEBSdvKFpP1wDdApS6fOR+f/nkHXXjSnpmID8mwiUauixdorhmOvTegweiHjP5o66oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=QNSANW7y; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rmss6xqS/EKKP4ypspK0N/KgItumBmPnU3VJYF7hjKA=; t=1774305854; x=1775169854; 
	b=QNSANW7yKk2syHPNK44bp37rmgpmehgXuG5e4lp74BbZQX/b5sKnW2INj5sEMdvLJcGUYHWLSlq
	hBJPXDZpcO9gqCp9id6rIcOhr5VAN9nu9m1nlbXPdB7zTwjwMW1ROgwtCRun4CS22HkqkLtdvOBDt
	DhfpXNLQMT0D0tn9XcTmt/89Su8drVgT8oAlYhsnG2GoZBvWVPeaQelV3eUUz8x7GOD+KoGBrX51o
	4g4kOygSgAREICT688FS10WgsKEME3tnbBiLTIaLcIWmCFcDXAsO5+mTYJk2QZfHxP+q/dT/ivK/F
	uP9Cxo7w5QfBS29syeWcRKHTjGDS2I+42R4Q==;
Received: from mail-yx1-f54.google.com ([74.125.224.54]:42072)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w4o0D-0001oP-VG
	for netdev@vger.kernel.org; Mon, 23 Mar 2026 15:44:08 -0700
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ea5b45673so4642794d50.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:44:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9qYKDMmNn2nkiqzXFk+pBhM+eig7PmbTuXObXVSz4GAYlu11o7eKxmauJBOacLlfzAQSWeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8uhl8pLHMFmJ0QJOVwhMiFFMjVZ5KvPRM8nztNnr3nylACZZ
	lV7vBaIdTQcEQmd48WEHZIXXYWBr4UNPajocaANqrfCcDPhP0lOLT3VQD5S9Ds+UeVU/JRVYnew
	SwqgLcM4hnBSTTD/Pq9bBHnK9dzJo5iY=
X-Received: by 2002:a05:690e:23ce:b0:64a:eda9:8ea9 with SMTP id
 956f58d0204a3-64ed77fbee1mr947511d50.2.1774305845190; Mon, 23 Mar 2026
 15:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-9-ouster@cs.stanford.edu> <20260318072131.268946-1-pabeni@redhat.com>
In-Reply-To: <20260318072131.268946-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 23 Mar 2026 15:43:28 -0700
X-Gmail-Original-Message-ID: <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com>
X-Gm-Features: AQROBzBwp6NAqT_0DymN6bsSauh__W1JqDhnD1dLkYqgjzXjYtF34KwrdnCsJqc
Message-ID: <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com>
Subject: Re: [net-next,v17,08/14] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 896d3442069c0201055de7cc1986913c
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270793-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 267762FE818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> [ ... ]
>
> > +/**
> > + * homa_rpc_alloc_server() - Allocate and initialize a server RPC (one=
 that is
> > + * used to manage an incoming request). If appropriate, the RPC will a=
lso
> > + * be handed off (we do it here, while we have the socket locked, to a=
void
> > + * acquiring the socket lock a second time later for the handoff).
> > + * @hsk:      Socket that owns this RPC.
> > + * @source:   IP address (network byte order) of the RPC's client.
> > + * @h:        Header for the first data packet received for this RPC; =
used
> > + *            to initialize the RPC.
> > + * @created:  Will be set to 1 if a new RPC was created and 0 if an
> > + *            existing RPC was found.
> > + *
> > + * Return:  A pointer to a new RPC, which is locked, or a negative err=
no
> > + *          if an error occurred. If there is already an RPC correspon=
ding
> > + *          to h, then it is returned instead of creating a new RPC.
> > + */
> > +struct homa_rpc *homa_rpc_alloc_server(struct homa_sock *hsk,
> > +                                    const struct in6_addr *source,
> > +                                    struct homa_data_hdr *h, int *crea=
ted)
> > +     __cond_acquires(nonnull, srpc->bucket->lock)
> > +{
> > +     u64 id =3D homa_local_id(h->common.sender_id);
> > +     struct homa_rpc_bucket *bucket;
> > +     struct homa_rpc *srpc =3D NULL;
> > +     int err;
> > +
> > +     if (!hsk->buffer_pool)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /* Lock the bucket, and make sure no-one else has already created
> > +      * the desired RPC.
> > +      */
> > +     bucket =3D homa_server_rpc_bucket(hsk, id);
> > +     homa_bucket_lock(bucket, id);
> > +     hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
> > +             if (srpc->id =3D=3D id &&
> > +                 srpc->dport =3D=3D ntohs(h->common.sport) &&
> > +                 ipv6_addr_equal(&srpc->peer->addr, source)) {
> > +                     /* RPC already exists; just return it instead
> > +                      * of creating a new RPC.
> > +                      */
> > +                     *created =3D 0;
> > +                     return srpc;
> > +             }
> > +     }
> > +
> > +     /* Initialize fields that don't require the socket lock. */
> > +     srpc =3D kzalloc(sizeof(*srpc), GFP_ATOMIC);
>
> In v6, Paolo Abeni suggested avoiding GFP_ATOMIC by doing the allocation
> outside the bucket lock. The current code allocates while holding the
> bucket lock (acquired above), which forces GFP_ATOMIC.
>
> Paolo's suggestion was to do a lockless RCU lookup first, and only if tha=
t
> fails, allocate outside the lock with GFP_KERNEL. Could this allocation b=
e
> moved outside the lock to use GFP_KERNEL instead?
>
> Reference: https://lore.kernel.org/netdev/1c82f56c-4353-407b-8897-b8a4856=
06a5f@redhat.com/

This code is invoked at SoftIRQ level, so the allocation must use
GFP_ATOMIC even if a lockless RCU lookup is used. In previous patch
versions I've discussed why Homa does not use RCU for homa_rpc
objects.

> Additionally, in a later review on January 28, Paolo and Eric Dumazet
> suggested using SLAB_TYPESAFE_BY_RCU with a dedicated kmem_cache for RPC
> allocations to improve performance and handle high RPC rates.
>
> This approach would allow lockless RCU lookups and faster reclamation. Pa=
olo
> referenced tcp established socket lookup as an example:
>
>   "Have a look at tcp established socket lookup and the SLAB_TYPESAFE_BY_=
RCU
>    flag usage for slab-based allocations. A combo of such flag for RPC
>    allocation (using a dedicated kmem_cache) and RCU lookup should improv=
e
>    consistently the performances, with a consolidate code layout and no
>    unmanageable problems with large number of objects waiting for the gra=
ce
>    period."
>
> The current code still uses plain kzalloc/kfree without a dedicated cache=
.
> Would it make sense to implement this optimization?
>
> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394=
f8cda@redhat.com/

I tried using a kmem_cache, but it made performance slightly worse:
average allocation time for a struct homa_rpc increased from about 380
cycles to about 400 cycles in my benchmarks. Since there is no
performance advantage to using kmem_cache I removed it.

I'm surprised how long allocation takes: 400 cycles seems like a *lot*
if there are per-cpu caches of the right size. Presumably no
synchronization is needed and all the function has to do in the normal
case is pull the top entry off a list.

>
> > +     if (!srpc) {
> > +             err =3D -ENOMEM;
> > +             goto error;
> > +     }
>
> [ ... ]
>
> > +error:
> > +     homa_bucket_unlock(bucket, id);
> > +     if (srpc && srpc->peer)
> > +             homa_peer_release(srpc->peer);
> > +     kfree(srpc);
> > +     return ERR_PTR(err);
> > +}
>
> [ ... ]
>
> In the v6 review thread, Paolo and Eric raised concerns about SKB freeing
> costs and suggested optimizations. Eric noted that proper software GRO
> significantly reduces SKB count using napi_get_frags() and napi_reuse_skb=
().

Unfortunately napi_reuse_skb is not currently exported. My
understanding is that I need to wait until Homa GRO is upstreamed
before I can request that it be exported. Once that happens I'll be
happy to use napi_reuse_skb.

>
> Paolo also suggested using deferred SKB freeing (skb_attempt_defer_free) =
to
> reduce the cost. While you mentioned that GRO is implemented in the full
> Homa but was left out of the initial patch series, would it be beneficial=
 to
> include at least some of these optimizations in this initial submission?
>
> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394=
f8cda@redhat.com/

When I asked ChatGPT about homa_attempt_defer_free it said that it
only works if the skb has no dst, no destructor, and no skb_nfct. I'm
a bit unsure how to proceed. Is homa_attempt_defer_free only intended
for incoming packets? If so, then presumably there is no dst? But what
about the other fields? Do I need to do something to clean them up
before calling homa_attempt_defer_free?

> [ ... ]
>
> > diff --git a/net/homa/homa_rpc.h b/net/homa/homa_rpc.h
> > new file mode 100644
> > index 000000000000..98bfd389f5b1
> > --- /dev/null
> > +++ b/net/homa/homa_rpc.h
>
> [ ... ]
>
> > +/**
> > + * homa_protect_rpcs() - Ensures that no RPCs will be reaped for a giv=
en
> > + * socket until homa_sock_unprotect is called. Typically used by funct=
ions
>
> This isn't a bug, but the comment references 'homa_sock_unprotect' which
> doesn't exist. Should this be 'homa_unprotect_rpcs'?

Fixed.

> > + * that want to scan the active RPCs for a socket without holding the =
socket
> > + * lock.  Multiple calls to this function may be in effect at once. Se=
e
> > + * "Homa Locking Strategy" in homa_impl.h for more info on why this fu=
nction
> > + * is needed.
> > + * @hsk:    Socket whose RPCs should be protected. Must not be locked
> > + *          by the caller; will be locked here.
> > + *
> > + * Return:  1 for success, 0 if the socket has been shutdown, in which
> > + *          case its RPCs cannot be protected.
> > + */
> > +static inline int homa_protect_rpcs(struct homa_sock *hsk)
> > +{
> > +     int result;
> > +
> > +     homa_sock_lock(hsk);
> > +     result =3D !hsk->shutdown;
> > +     if (result)
> > +             atomic_inc(&hsk->protect_count);
> > +     homa_sock_unlock(hsk);
> > +     return result;
> > +}
> > +
> > +/**
> > + * homa_unprotect_rpcs() - Cancel the effect of a previous call to
> > + * homa_sock_protect(), so that RPCs can once again be reaped.
>
> This isn't a bug, but the comment references 'homa_sock_protect()' which
> doesn't exist. Should this be 'homa_protect_rpcs()'?

Fixed.

> [ ... ]
>
> > +/**
> > + * homa_rpc_put() - Release a reference on an RPC (cancels the effect =
of
> > + * a previous call to homa_rpc_put).
> > + * @rpc:      RPC to release.
> > + */
> > +static inline void homa_rpc_put(struct homa_rpc *rpc)
> > +{
> > +     refcount_dec(&rpc->refs);
> > +}
>
> This isn't a bug, but the kdoc comment says "cancels the effect of a
> previous call to homa_rpc_put" which is self-referential. Should this say
> "cancels the effect of a previous call to homa_rpc_hold" instead?
>
> The function decrements rpc->refs via refcount_dec(), which is the invers=
e
> operation of homa_rpc_hold() that calls refcount_inc(). This misleading
> comment could confuse maintainers about the refcount lifecycle.

Fixed.

