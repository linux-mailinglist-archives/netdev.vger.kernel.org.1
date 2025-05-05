Return-Path: <netdev+bounces-187692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3FFAA8EAA
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3AE17493B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084F1F4623;
	Mon,  5 May 2025 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JsyZ1b4b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E42hsZhg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D67155C88
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435440; cv=none; b=ct4yRwzl3uogEAvvStJYaPkRqHIT7LUTe07Ag0UKHRZF2CsXrNyfGEMDP47dQxxpGEGiSQ8jxEhezyP9xYIBnMjYmdchrOOnN3bvAfNYbJrBw/BQ0r5lZK/SGM9hvfz88vtgr3bCel0z0MAtj7gxwV2vC1WBUhTSSIDL2j4lpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435440; c=relaxed/simple;
	bh=9KSOFqCouvAPXUIaFERVwNffS2Yd76AEW7nRjkeW0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtdiZy63PibcFtGSoUiOnudLKXimwhB/zQdTETNNwXSjzRIjjRyOvqzyYl1c2IQBc+DSmZ1y7ngvWfggUTa38JCCECHuzWve9YPwJ6PnzCwMg26By9Mhq8iAy67oMUJ9khWKPQenzzIznG3NyzfG67ZzuDlm+8pnfjk3Yr1pGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JsyZ1b4b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E42hsZhg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 May 2025 10:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746435436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FfjRNTFSF4kCYdBoCLyc7uSjRO+tk2Tnewi5gynsu4=;
	b=JsyZ1b4bi8qd2Hm9HfQvKPvHMVBy44eKwLDtuZqF9/MCFyYWT7JOoLHOVXNrgYKUq9UGOJ
	ZvBrvRrM3TuF+o4QnW+nZEb8e5ksy0idIIYPuX+RMpK9ovudZUezMS6hkvD0/hxJuQrrVl
	u4X5jlq1CQbD/2lQA0FPrM95fVvvcouxCU3b+YWK5GY+qNZFeKayKCAa9AV3vu3HT1Javf
	SuVRZP74xO7ecPRA2tSnt30RWSFN3yMbdkygty869p+1XzH0wNN+8fx7sWss41UAm0USn+
	m1lNXNDmYZmq2ai4tqZNL/B9aLw84ff+oi6M/fp9xO2+VRkDQNUQRKFFhelx6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746435436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FfjRNTFSF4kCYdBoCLyc7uSjRO+tk2Tnewi5gynsu4=;
	b=E42hsZhg6FhxonvcIWAfJWzajFY8m3o2o1jlaq3H6WEuzB/lMc71oT5lOg3OIDzye2e5Vk
	3GwJ3GHwgQZgf7DQ==
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
Message-ID: <20250505085713.ZAgyY1mJ@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
 <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de>
 <87ikmj5bh5.fsf@toke.dk>
 <20250502150705.1sewZ77B@linutronix.de>
 <87frhn57i3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87frhn57i3.fsf@toke.dk>

On 2025-05-02 17:59:00 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> I had in mind moving the out: label (and the unlock) below the
> >> skb->protocol assignment, which would save the if(skb) check; any reas=
on
> >> we can't call xsk_buff_free() while holding the lock?
> >
> > We could do that, I wasn't entirely sure about xsk_buff_free(). It is
> > just larger scope but nothing else so far.
> >
> > I've been staring at xsk_buff_free() and the counterparts such as
> > xsk_buff_alloc_batch() and I didn't really figure out what is protecting
> > the list. Do we rely on the fact that this is used once per-NAPI
> > instance within RX-NAPI and never somewhere else?
>=20
> Yeah, I believe so. The commit adding the API[0] mentions this being
> "single core (single producer/consumer)".

So if TX is excluded, it should work=E2=80=A6
For the former, I have now this:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2d11d013cabed..2018e2432cb56 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3502,7 +3502,12 @@ struct softnet_data {
 };
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
-DECLARE_PER_CPU(struct page_pool *, system_page_pool);
+
+struct page_pool_bh {
+	struct page_pool *pool;
+	local_lock_t bh_lock;
+};
+DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
=20
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a6024..b56becd070bc7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-DEFINE_PER_CPU(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 #ifdef CONFIG_LOCKDEP
 /*
@@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const=
 struct bpf_prog *prog)
 	struct sk_buff *skb =3D *pskb;
 	int err, hroom, troom;
=20
-	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, =
prog);
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
+	if (!err)
 		return 0;
=20
 	/* In case we have to go down the path and also linearize,
@@ -12629,7 +12634,7 @@ static int net_page_pool_create(int cpuid)
 		return err;
 	}
=20
-	per_cpu(system_page_pool, cpuid) =3D pp_ptr;
+	per_cpu(system_page_pool.pool, cpuid) =3D pp_ptr;
 #endif
 	return 0;
 }
@@ -12759,13 +12764,13 @@ static int __init net_dev_init(void)
 		for_each_possible_cpu(i) {
 			struct page_pool *pp_ptr;
=20
-			pp_ptr =3D per_cpu(system_page_pool, i);
+			pp_ptr =3D per_cpu(system_page_pool.pool, i);
 			if (!pp_ptr)
 				continue;
=20
 			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
-			per_cpu(system_page_pool, i) =3D NULL;
+			per_cpu(system_page_pool.pool, i) =3D NULL;
 		}
 	}
=20
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a7..8696e8ffa3bcc 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -737,25 +737,27 @@ static noinline bool xdp_copy_frags_from_zc(struct sk=
_buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
-	struct page_pool *pp =3D this_cpu_read(system_page_pool);
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
 	u32 truesize =3D xdp->frame_sz;
-	struct sk_buff *skb;
+	struct sk_buff *skb =3D NULL;
+	struct page_pool *pp;
 	int metalen;
 	void *data;
=20
 	if (!IS_ENABLED(CONFIG_PAGE_POOL))
 		return NULL;
=20
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	pp =3D this_cpu_read(system_page_pool.pool);
 	data =3D page_pool_dev_alloc_va(pp, &truesize);
 	if (unlikely(!data))
-		return NULL;
+		goto out;
=20
 	skb =3D napi_build_skb(data, truesize);
 	if (unlikely(!skb)) {
 		page_pool_free_va(pp, data, true);
-		return NULL;
+		goto out;
 	}
=20
 	skb_mark_for_recycle(skb);
@@ -774,13 +776,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
 	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
 		napi_consume_skb(skb, true);
-		return NULL;
+		skb =3D NULL;
+		goto out;
 	}
=20
 	xsk_buff_free(xdp);
=20
 	skb->protocol =3D eth_type_trans(skb, rxq->dev);
=20
+out:
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
 	return skb;
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);

> -Toke

Sebastian

