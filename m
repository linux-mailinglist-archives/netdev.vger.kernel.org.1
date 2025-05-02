Return-Path: <netdev+bounces-187465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9CAA7414
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287584C015D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC91255E55;
	Fri,  2 May 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCjcfw/4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tX7g9Z2q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851A255E2F
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193494; cv=none; b=n7uc2IY+8R877ha085aagPAC7xlKcEFtdJRRiT6Ej6F4HA0cBjJLVtKGiFWa6t2kvreVfa7hlSUeAJxtcDgNTSR4CVD66hBLhEXd1JAfWk/CHNW31elWhztzcqnnZVoQbLbPEv7mI7NBOurhzd9Q1CMvC3ixjRKRT96WXmpd0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193494; c=relaxed/simple;
	bh=bXWtEgK9TzRiij/Dk4f7B88nhogoZIxK/QBLZY6dhAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lorwj83vQLiPjcGF8biZrb+b8YbGE+2QI8B9puity3stXRy2c5AOZhaukebLqEQ88p3RmuNhHjwk1ZP2HfCBfsYMdUtAfCC1XN4G1Nt3W2trw6z9mrRHaLE8tV6m7nylgThCjT2IQaXeus1PowHqb7Kog02viQPAvxwfeuHj1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCjcfw/4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tX7g9Z2q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 2 May 2025 15:32:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746192753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIFY1lnbeFhsEKUNrmrLTutQgu030503n74UHDdUDsU=;
	b=aCjcfw/4LNyI3jsIeYsWb56w8nsXB94Pj1O6TJokHpaMBFo3v8GSaTaxKgbcXmj3aUEA/y
	ZyY/nIAfTQuW2LUdv35Qt8U+s+kvdLU70MFt+xRQn8SlOaJ8DNu+W8Cv0aHemfeJBuRcKs
	8Kdv9lvNP2mdoBB+lCRqJS6WId7gzbZnmkeXoZ7NP1fCb2wdoPFXOj0dr+8UusNe6Z0b20
	moNh5nruodUSgWQW7b0AciKErIO370xpM/onIaqANe/0JvQxnO9/WWwCV0FCTBhD0c7TdX
	IInmKD+9bXLeOKs29pBRW7QbcgwLswwjhcRLNZYnssXiEuQAWoEp+yjBqgtReg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746192753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIFY1lnbeFhsEKUNrmrLTutQgu030503n74UHDdUDsU=;
	b=tX7g9Z2qGZwo4rmtwq9FU/TETMOoF5zlSQHEp118YsLQfmaV+G+hMKrdJOPPpiBp9qd9Qt
	FPM7tdRgmbsAtOAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
Message-ID: <20250502133231.lS281-FN@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
 <878qng7i63.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <878qng7i63.fsf@toke.dk>

On 2025-05-01 12:13:24 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
> >   * PP consumers must pay attention to run APIs in the appropriate cont=
ext
> >   * (e.g. NAPI context).
> >   */
> > -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
> > +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
> > +	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
> > +};
>=20
> I'm a little fuzzy on how DEFINE_PER_CPU() works, but does this
> initialisation automatically do the right thing with the multiple
> per-CPU instances?

It sets the "first" per-CPU data which is then copied to all
"possible-CPUs" during early boot when the per-CPU data is made
available. You can initialize almost everything like that. Pointer based
structures (such as LIST_HEAD_INIT()) is something that obviously won't
work.

> >  #ifdef CONFIG_LOCKDEP
> >  /*
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(struc=
t sk_buff *skb,
> >   */
> >  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
> >  {
> > -	struct page_pool *pp =3D this_cpu_read(system_page_pool);
> >  	const struct xdp_rxq_info *rxq =3D xdp->rxq;
> >  	u32 len =3D xdp->data_end - xdp->data_meta;
> >  	u32 truesize =3D xdp->frame_sz;
> > +	struct page_pool *pp;
> >  	struct sk_buff *skb;
> >  	int metalen;
> >  	void *data;
> > @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_=
buff *xdp)
> >  	if (!IS_ENABLED(CONFIG_PAGE_POOL))
> >  		return NULL;
> > =20
> > +	local_lock_nested_bh(&system_page_pool.bh_lock);
> > +	pp =3D this_cpu_read(system_page_pool.pool);
> >  	data =3D page_pool_dev_alloc_va(pp, &truesize);
> > -	if (unlikely(!data))
> > +	if (unlikely(!data)) {
> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
> >  		return NULL;
> > +	}
> > =20
> >  	skb =3D napi_build_skb(data, truesize);
> >  	if (unlikely(!skb)) {
> >  		page_pool_free_va(pp, data, true);
> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
> >  		return NULL;
> >  	}
> > =20
> > @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_b=
uff *xdp)
> > =20
> >  	if (unlikely(xdp_buff_has_frags(xdp)) &&
> >  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> > +		local_unlock_nested_bh(&system_page_pool.bh_lock);
> >  		napi_consume_skb(skb, true);
> >  		return NULL;
> >  	}
> > +	local_unlock_nested_bh(&system_page_pool.bh_lock);
>=20
> Hmm, instead of having four separate unlock calls in this function, how
> about initialising skb =3D NULL, and having the unlock call just above
> 'return skb' with an out: label?
>=20
> Then the three topmost 'return NULL' can just straight-forwardly be
> replaced with 'goto out', while the last one becomes 'skb =3D NULL; goto
> out;'. I think that would be more readable than this repetition.

Something like the following maybe? We would keep the lock during
napi_consume_skb() which should work.

diff --git a/net/core/xdp.c b/net/core/xdp.c
index b2a5c934fe7b7..1ff0bc328305d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -740,8 +740,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
 	u32 truesize =3D xdp->frame_sz;
+	struct sk_buff *skb =3D NULL;
 	struct page_pool *pp;
-	struct sk_buff *skb;
 	int metalen;
 	void *data;
=20
@@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
 	local_lock_nested_bh(&system_page_pool.bh_lock);
 	pp =3D this_cpu_read(system_page_pool.pool);
 	data =3D page_pool_dev_alloc_va(pp, &truesize);
-	if (unlikely(!data)) {
-		local_unlock_nested_bh(&system_page_pool.bh_lock);
-		return NULL;
-	}
+	if (unlikely(!data))
+		goto out;
=20
 	skb =3D napi_build_skb(data, truesize);
 	if (unlikely(!skb)) {
 		page_pool_free_va(pp, data, true);
-		local_unlock_nested_bh(&system_page_pool.bh_lock);
-		return NULL;
+		goto out;
 	}
=20
 	skb_mark_for_recycle(skb);
@@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
=20
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
 	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
-		local_unlock_nested_bh(&system_page_pool.bh_lock);
 		napi_consume_skb(skb, true);
-		return NULL;
+		skb =3D NULL;
 	}
+
+out:
 	local_unlock_nested_bh(&system_page_pool.bh_lock);
-
-	xsk_buff_free(xdp);
-
-	skb->protocol =3D eth_type_trans(skb, rxq->dev);
+	if (skb) {
+		xsk_buff_free(xdp);
+		skb->protocol =3D eth_type_trans(skb, rxq->dev);
+	}
=20
 	return skb;
 }

> -Toke

Sebastian

