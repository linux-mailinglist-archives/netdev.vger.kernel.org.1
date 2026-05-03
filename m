Return-Path: <netdev+bounces-283680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCzPCIyz92n2lAIAu9opvQ
	(envelope-from <netdev+bounces-283680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 22:43:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52804B75D8
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 22:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE76C30075FF
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BA3A6F02;
	Sun,  3 May 2026 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="munPYpqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6643A169D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841022; cv=none; b=Ywel+MQP33T1VuPTguebDFTqAyRM2HpINNNm3fsMqqu7nv3gXC+k6QKQq6HUUR2tGZopUmQWERiLvCZ5T2BvOhgA6oNEXngPEW7bRpxwTANCng3FwR0ZUUpDn0sQ+GQnMqWVywv/bHGz/wh5QOPjFEJfDCcbQlq7gRV0jq64H1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841022; c=relaxed/simple;
	bh=DGU7Hb9GiIVqSOpoRRUdccsq0yKi05mS1XrNhyYgyMs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BnBu1Y4bK2Z8RH6eGiKoyH8OJ++oV8f5NcIKmKebC9UfjS7pmwOZqdJi5RRy0EGGR5j/f9Lu6RFV/eewy55hKyiFKig29xgn7DugNHgyO86Kxvu01owIFSRJUaGQ2iRqPMt2jRSaW6iw7NMQbgShW5V+pR8iMQtW2wu0ER3mN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=munPYpqb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794719afcd4so30751327b3.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777841019; x=1778445819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0R6GY4BRav2xrTpW0epk0FMl4icshfyZdWHMNaD6SE=;
        b=munPYpqbJykdMHQFiVB8/5Mt6NFEqTB6lbzr0GDc47ESE7zASFR+TiWQhajsNwRI6g
         ymaH43gZnvQNa9mYqEWd3bOjx0KJR3MCVfu3S4qvtzh5PiluzBunStd5XaK6i0+fwH4u
         1UkMWsJkprwvUPLF+n7VWt0ZYrqQaHOUISOLcqcyKlB/R8AUA93L9sQkVxx41/dsfw/v
         GQop8JJkBeszUGoqFvdIiM70zpZKDodONbvqWLH5hQIiwUJ0ztSHMsWG3OPLNg1ToF0K
         7ZmVHGkrUeht5LFLswOwVTKl1ak5waiGtYrjzx1YFl+8dmGDG5w+y02fL7edlkoOucUW
         +jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777841019; x=1778445819;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0R6GY4BRav2xrTpW0epk0FMl4icshfyZdWHMNaD6SE=;
        b=OAkJA0ex/smqqjkWgqKvmcvS331wGq8rHnzmD86BIw19yGUZnXuKYypwZkQZ+QiK91
         Uf+JJEuvLo/oOtGjKem8cJCP/GcZ8KraEa3Xo6WbFWvE2PYYlBO6MViWgoNiMDna6Z7m
         piJDWdm2V3mTs2a29k4Tgs4eUsiOWy9RPfRaqYTuOa/75ZsOl2g7Kjucx355bSxAAM4C
         TbB6dAb3QPp+4rhtEMvvIY0heByhZpFpEFD2AUE96+srWSd9Lq6Cxoy8Vr+ISOvp3+0V
         XrbRnhOiMGAAhSdsxs0K4i55LRQyJNEu863J9bq++IgdbqJnRqWmkeo4Tz/poA8X/fxD
         heQw==
X-Forwarded-Encrypted: i=1; AFNElJ9EBO9tAU4gmTeQfsLRgl0pPGxF3l8Oao304U4gGNH6TArNo+Q+w4msIMYUayDOUiAXeoj3zKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzue2Qk0jFBNrN64zuVUvgnP8Lsj6c7R4M2NbYVIIPWOr3iW2DJ
	86zl8t7VzozRo49K/IfnyoyttZ/7rlKsS5c2sUFsHK/k0PDFGyoB57Sr
X-Gm-Gg: AeBDievQnEfMd2DDtzMvWw7Wr4YH9Pltf5BAQVHle3wX+lyi4Q1PfqxyAJmFq1tYLIy
	iPpOgd4GOvl4sIWI5hJ1USEckkc8sqHV110bDvxoBU1sCb8nO+U0A2E1gAn13Y0XiO69AWbxMTJ
	hnCwo8n6qzMyamV5bsYXrUVxSPhvY+2Yj1XCtQ8lbO1jKaoFMKYgul76Hi2oRLljdsSsi+CE25D
	lxnubkBtpumgwSWoIoyb7U1OPe4BGmUoftHdWz8kXkAz6ehsF0VSkHzBcHSVJQW2Rgbnvb93vru
	8vRVjJMZl1OpKGS5z39E1Vf8WdpXBw8+gTH+y6Hz6C/w+tB1/5yY6Q4k1eegeNd0PVTPddr6ua0
	NAoGm3IsrTr8TcfFr7sc3nrPI/Z6hGpyBG19KMefbJCPjzL9XzSb076chhkhYbX4cofPxjdq6+w
	zsME2SADTw5QRDIEq3bQuTidAqSLF/k1dccwTMAvm1YS4RKoT5DO2Q8Z0vPaGelVAmUGtIaYNz2
	WpUhA2i72EIbsM=
X-Received: by 2002:a05:690c:968b:b0:7ba:f907:145c with SMTP id 00721157ae682-7bd7710328amr78373037b3.33.1777841018695;
        Sun, 03 May 2026 13:43:38 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686fbcdsm40087957b3.40.2026.05.03.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:43:38 -0700 (PDT)
Date: Sun, 03 May 2026 16:43:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: dsahern@kernel.org, 
 kuznet@ms2.inr.ac.ru, 
 willemb@google.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3269daabfa48e@gmail.com>
In-Reply-To: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B52804B75D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ms2.inr.ac.ru,google.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
> scope and shared across netns. mem_check() reads fl_size to decide
> whether to deny non-CAP_NET_ADMIN callers; capable() runs against
> init_user_ns, so an unprivileged user in any non-init userns can
> push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
> other unprivileged userns on the host.
> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented next
> to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
> is placed in the existing 4-byte hole after ipmr_seq, so struct
> netns_ipv6 stays the same size on 64-bit builds.
> 
> Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
> was added; machines and connection counts have grown.
> 
> mem_check() folds an extra per-netns ceiling into the existing
> non-CAP_NET_ADMIN conditional. The ceiling is half of the total
> budget that unprivileged callers have ever been able to use, i.e.
> (FL_MAX_SIZE - FL_MAX_SIZE/4) / 2 = 3072 entries. With FL_MAX_SIZE
> doubled, this preserves the original per-user reach (~3K, what an
> unprivileged caller could already obtain before this change) while
> forcing an attacker to spread allocations across at least two
> netns to exhaust the global non-CAP_NET_ADMIN budget.
> 
> CAP_NET_ADMIN against init_user_ns still bypasses both caps.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
> v6 (this submission, addressing v5 review by Willem):
>     - Rebased onto current net (resolves the conflict on
>       include/net/netns/ipv6.h that v5 hit. ipmr_seq is now
>       atomic_t but remains 4 bytes, so flowlabel_count still
>       fills the 4-byte hole after it).
>     - Restored fl_free() to its original position in both
>       ip6_fl_gc() and ip6_fl_purge(). v5 had moved fl_free()
>       after the new atomic_dec() to avoid the use-after-free
>       on fl->fl_net. v6 instead caches fl->fl_net into a
>       local before fl_free() in ip6_fl_gc(), and uses the
>       net argument already in scope in ip6_fl_purge().
> v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
>     computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
>     which evaluates to 3072. v4's FL_MAX_SIZE/8 = 1024 would
>     have reduced the per-user budget below the ~3K an
>     unprivileged caller could already obtain before any of
>     this work, defeating the reason FL_MAX_SIZE was doubled
>     in the first place.
> v4: addressed Willem's v3 review on netdev. Dropped the
>     flowlabel_has_excl cacheline argument in favour of "fills
>     the existing 4-byte hole after ipmr_seq", and reordered
>     atomic_dec(&...flowlabel_count) to sit immediately after
>     atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge.
> v3: addressed Willem's review on the private security@ thread.
>     Merged FL_MAX_SIZE doubling, dropped test data, moved
>     flowlabel_count near ipmr_seq, inlined fl->fl_net in
>     ip6_fl_gc.
> v2: per-netns counter + cap, sent to security@ as a 2-patch
>     series.
> v1: fix-shape sketch in original disclosure.
> 
>  include/net/netns/ipv6.h |  1 +
>  net/ipv6/ip6_flowlabel.c | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 499e42881..ef698f5fa 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -119,6 +119,7 @@ struct netns_ipv6 {
>  	struct fib_notifier_ops	*notifier_ops;
>  	struct fib_notifier_ops	*ip6mr_notifier_ops;
>  	atomic_t		ipmr_seq;
> +	atomic_t		flowlabel_count;
>  	struct {
>  		struct hlist_head head;
>  		spinlock_t	lock;
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index c92f98c6f..28e43718d 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -36,7 +36,7 @@
>  /* FL hash table */
>  
>  #define FL_MAX_PER_SOCK	32
> -#define FL_MAX_SIZE	4096
> +#define FL_MAX_SIZE	8192
>  #define FL_HASH_MASK	255
>  #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
>  
> @@ -161,9 +161,12 @@ static void ip6_fl_gc(struct timer_list *unused)
>  					fl->expires = ttd;
>  				ttd = fl->expires;
>  				if (time_after_eq(now, ttd)) {
> +					struct net *net = fl->fl_net;
> +
>  					*flp = fl->next;
>  					fl_free(fl);
>  					atomic_dec(&fl_size);
> +					atomic_dec(&net->ipv6.flowlabel_count);

If resubmitting, moving fl_free here makes sense (only the second case
was entirely unnecessary).

>  					continue;
>  				}
>  				if (!sched || time_before(ttd, sched))
> @@ -197,6 +200,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  				*flp = fl->next;
>  				fl_free(fl);
>  				atomic_dec(&fl_size);
> +				atomic_dec(&net->ipv6.flowlabel_count);
>  				continue;
>  			}
>  			flp = &fl->next;
> @@ -245,6 +249,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
>  	fl->next = fl_ht[FL_HASH(fl->label)];
>  	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
>  	atomic_inc(&fl_size);
> +	atomic_inc(&net->ipv6.flowlabel_count);
>  	spin_unlock_bh(&ip6_fl_lock);
>  	rcu_read_unlock();
>  	return NULL;
> @@ -464,6 +469,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
>  
>  static int mem_check(struct sock *sk)
>  {
> +	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
> +	const int unpriv_user_limit = unpriv_total_limit / 2;
> +	struct net *net = sock_net(sk);
>  	int room = FL_MAX_SIZE - atomic_read(&fl_size);
>  	struct ipv6_fl_socklist *sfl;
>  	int count = 0;
> @@ -478,7 +486,9 @@ static int mem_check(struct sock *sk)
>  
>  	if (room <= 0 ||
>  	    ((count >= FL_MAX_PER_SOCK ||
> -	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
> +	      (count > 0 && room < FL_MAX_SIZE/2) ||
> +	      room < FL_MAX_SIZE/4 ||

And here make checkpatch happy and add spaces around the division
operator.

> +	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
>  	     !capable(CAP_NET_ADMIN)))
>  		return -ENOBUFS;
>  
> -- 
> 2.34.1
> 



