Return-Path: <netdev+bounces-266173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFKcFAs1sGnRhAIAu9opvQ
	(envelope-from <netdev+bounces-266173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:13:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD12F253090
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C160930EB557
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FF37418B;
	Tue, 10 Mar 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moC5Qn/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE438D6AB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151793; cv=pass; b=gNmQAEtcrvnUNOJMBArKHk7sGfZmqFuGULAloOWPOKVhIuvJy8T408VNb14FpLR6UuVZPQR1Ir/xmwS5BTxsT2KK8OH3CVmPG6d8PO3c2jZM7/kkuGKTaKsScK9zgH3blBHqezo+MVKYwMEQnvQtYM/msafljVVn9VmMqEfeuIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151793; c=relaxed/simple;
	bh=43Z4z/N+i8tgcCkt8nM5dHh/8N6xEcU6AqLnpsPTmLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ7s7h78FCdI+dh6ueyg1E40VHaEzpOGcph1WTsj2VSqNaR6/axtAFp0JnqZURlvvfz+sbJg928tLDsx17G9eHvR+/2oAe0xD7yXPfFkYLo+6nT1/jSzWwsMCIKU/ygfwRDd8Qe7JIK8ZG3Auzo/kE8UK2ZAzVU1RfiZNiSPpoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moC5Qn/d; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so8368153241.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151791; cv=none;
        d=google.com; s=arc-20240605;
        b=AapxoBDUo4gliacuOkDWuxt00nvPmB9/SKe91WinMocxHnFhgwv09/Po0u02gKY9r+
         bRf2XP575ywNPQYPCLcxLVxuP+bvV0oXto9fae+NAj6R8rjch2+t0S9PyEIDPOGvN5ZZ
         0zCuRC70QiDqGcz9xOjl4sv0g3V3R3hiH9wBoiH2LjA8/5Wr8BmgcjyL+5cEvmuqdGvc
         eCqMF6kuHa99ly48ggWgSS3sIyGKGeE1es+6JL/qP6CtwOBOOtyPtnzbHA9JnLDfGAkQ
         nKiVXXaHiCofYtWc9HiNXPBK1NMmdR1JtYMGaUNBGdxArZ94ox4uEoMbprQk0ajAQcnP
         HMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vD7fIFpK96kSG/+smrbmCQy5+PcrKP/Me7OrgjS1yw=;
        fh=8A2S+e7dUcmhvfNsA8EcxrrWPPsDFDl7M0XEcpMux5s=;
        b=YXDx8jsyk5UVQONApjeXDfRsA7VSDiSm0ZuWIxWmS003SRfZfioyerB2RLfA1XXfyO
         fPMRUFzBqYtv/xIjsvvEnEHFb+hpqM32WOj66chf73KO4k9Nyiic7m3/+D3oB7pDZ2r3
         xcxOEC2mLyYpCEo1q7D/KA8ag+R1LZl5RacVi8s/XHBsEvckRWEe9dnsmBkJNiiJ1OpX
         lm+qHra7FC6sWQk+b+klhQ2Pa5cQ29K9e9j1uU+U/rn7VXLnhI6KcpJrxMy167EyjN3I
         c0k3gc1wHxbv+0Hi4XHjWGWMZeNtjkDcWtsm0dsdWN2Ff5jxwFV+q6xgassg95u3fsRL
         bG8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151791; x=1773756591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vD7fIFpK96kSG/+smrbmCQy5+PcrKP/Me7OrgjS1yw=;
        b=moC5Qn/dD8pH5QM9IIkGMf7o0UJ21w2HGXwF+ZeAxG9U84svDM9WGmzIaSKEHsuVeU
         mriJ2phuzU1/znjsBUYmNfTNw98tdHa0tDWHYeOCqGTSVPagy7Ji0u0qFO68kQvBFhe1
         0S4zS5q2Qs3Am3oNIxUv45i7kyaKG0WszmlXTwci3nd+CdKZ0kVhxp0nuZAwUpM6sOUU
         3tCopvmRshsVc+QP6wM31wtXPdkNLYU9WlbWCwA4CWqSaCJoIoQEZSDqY8G082c3pgOJ
         tM6iCtItDXCICOJ2XMxh2xhBtvRa34+59ZA9P/9ncvSsvvdtmBdYnmggK7XwAKIdN79/
         VIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151791; x=1773756591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vD7fIFpK96kSG/+smrbmCQy5+PcrKP/Me7OrgjS1yw=;
        b=b0Pxqkly3CBM2++6yDJ5ezPe6ZPh2CWgpOCWRi94PpxTeCBPnKcfZOAVzcmvt7SmmI
         pwGv2kjOc8NeMNGOuq6IHSG03BBlr1QhCwmCt8XDSTIzZJSPVxWCVJo6G6gA19Qn0Try
         195zYKFR+4FNbGWQiis3fmwAce5KWp5KVpvon23SwB/vRbbWC72xx//3E48PB6xwNETs
         jkhwwJjebD0s6JMzQ92X78lLcQNj2dWV2N8JOGZe9xzJWwMTJ1gv0Olarp4ZQ42cdluC
         6ex9uLUrsh9ofl6klSTfMk01CBZCkJ7CS+78SUY/rr8mlXwpDkqvy6xlwKUHsrzEYnUh
         7tQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYdQ1yu4clRt224Syvjpi8dKxQFOJ4CHdWSCgMhd1P7VVuwUrhV1lemAX5GGrHnEtmjzkbj6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JRGmXUxKxynmxX+V4WZICBsrk1IldK4vBTX8ZGxbSpD7sGTZ
	EqDR/J4DbRbn1vgx+elzPXAFOauDm3XlQVZpKS82MVsSorufReB5Rh0w/F/TSERGHgPxsC1F06Z
	qLFGjgw/nh1DS3DFcvQJYQe5lGJOvClaTrxRrdg8=
X-Gm-Gg: ATEYQzy/v7rg5UmW0GbkNDK42+byK3OcFoN+zWD9mB1O3UBt+IlRT0LboxS2L8Z73h0
	M2SB59G3UX+8XPgruFGH//9oy83Y/f0QWpjjm1o3kvxe4ckPJFSf3vRsGUp22Zq+t1H91liXuJ9
	FwG95Viw82eQoPZqv1RAswsNDIwRxM6ZZSJ4tHMKQLv1XG5m4dSLz91tqII2js+QhT1gM9pOeUJ
	ahgK81TWQbMBZKVIIu3cw3CsUjJPY1zO0BOQh+PTBMEi0LaI9aCTWZ+Us5HNladcErz5p+B/qcW
	1yYArMvXz0JWBFZa+gCzjJsthSsP/9UOegWiuLt6dQ0SPsDPoXEofROh0Zuo9VkfKoQr68kWNOu
	j86rEang=
X-Received: by 2002:a05:6102:1621:b0:5f7:307e:80d9 with SMTP id
 ada2fe7eead31-5ffe61c7a99mr6542898137.28.1773151789917; Tue, 10 Mar 2026
 07:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309180804.3471287-1-kuniyu@google.com> <20260309180804.3471287-3-kuniyu@google.com>
In-Reply-To: <20260309180804.3471287-3-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Mar 2026 10:09:36 -0400
X-Gm-Features: AaiRm52ASxQ6b2t24sQg_VK0-92Va8tjGo8IvizhbpRhbtVD2AXsb76l2VYo3vE
Message-ID: <CADvbK_dpip5BC1YST=-XKQ-V-8MwxDOgnwDWiHuFiAEB-BuCkQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BD12F253090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 2:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> The cited commit mechanically put fib6_remove_gc_list()
> just after every fib6_clean_expires() call.
>
> When a temporary route is promoted to a permanent route,
> there may already be exception routes tied to it.
>
> If fib6_remove_gc_list() removes the route from tb6_gc_hlist,
> such exception routes will no longer be aged.
>
> Let's replace fib6_remove_gc_list() with a new helper
> fib6_may_remove_gc_list() and use fib6_age_exceptions() there.
>
> Note that net->ipv6 is only compiled when CONFIG_IPV6 is
> enabled, so fib6_{add,remove,may_remove}_gc_list() are guarded.
>
> Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated li=
st of routes.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Use IS_ENABLED()
> v2: Fix build failure when CONFIG_IPV6=3Dn (no net->ipv6 definition)
> ---
>  include/net/ip6_fib.h | 19 ++++++++++++++++++-
>  net/ipv6/addrconf.c   |  4 ++--
>  net/ipv6/ip6_fib.c    |  6 +++---
>  net/ipv6/route.c      |  2 +-
>  4 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 88b0dd4d8e09..7e91f8f35552 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -507,12 +507,14 @@ void fib6_rt_update(struct net *net, struct fib6_in=
fo *rt,
>  void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *in=
fo,
>                      unsigned int flags);
>
> +void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_a=
rgs,
> +                        unsigned long now);
>  void fib6_run_gc(unsigned long expires, struct net *net, bool force);
> -
>  void fib6_gc_cleanup(void);
>
>  int fib6_init(void);
>
> +#if IS_ENABLED(CONFIG_IPV6)
>  /* Add the route to the gc list if it is not already there
>   *
>   * The callers should hold f6i->fib6_table->tb6_lock.
> @@ -545,6 +547,21 @@ static inline void fib6_remove_gc_list(struct fib6_i=
nfo *f6i)
>                 hlist_del_init(&f6i->gc_link);
>  }
>
> +static inline void fib6_may_remove_gc_list(struct net *net,
> +                                          struct fib6_info *f6i)
> +{
> +       struct fib6_gc_args gc_args;
> +
> +       if (hlist_unhashed(&f6i->gc_link))
> +               return;
> +
> +       gc_args.timeout =3D READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval=
),
> +       gc_args.more =3D 0,
Why is it using comma instead of semicolon here?

> +
> +       fib6_age_exceptions(f6i, &gc_args, jiffies);
> +}
> +#endif
> +
>  struct ipv6_route_iter {
>         struct seq_net_private p;
>         struct fib6_walker w;
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 0e55f139e05d..f4e23b543585 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2862,7 +2862,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8=
 *opt, int len, bool sllao)
>                                         fib6_add_gc_list(rt);
>                                 } else {
>                                         fib6_clean_expires(rt);
> -                                       fib6_remove_gc_list(rt);
> +                                       fib6_may_remove_gc_list(net, rt);
>                                 }
>
>                                 spin_unlock_bh(&table->tb6_lock);
> @@ -4840,7 +4840,7 @@ static int modify_prefix_route(struct net *net, str=
uct inet6_ifaddr *ifp,
>
>                 if (!(flags & RTF_EXPIRES)) {
>                         fib6_clean_expires(f6i);
> -                       fib6_remove_gc_list(f6i);
> +                       fib6_may_remove_gc_list(net, f6i);
>                 } else {
>                         fib6_set_expires(f6i, expires);
>                         fib6_add_gc_list(f6i);
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index fadfca49d6b1..dd26657b6a4a 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1133,7 +1133,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, s=
truct fib6_info *rt,
>                                         return -EEXIST;
>                                 if (!(rt->fib6_flags & RTF_EXPIRES)) {
>                                         fib6_clean_expires(iter);
> -                                       fib6_remove_gc_list(iter);
> +                                       fib6_may_remove_gc_list(info->nl_=
net, iter);
>                                 } else {
>                                         fib6_set_expires(iter, rt->expire=
s);
>                                         fib6_add_gc_list(iter);
> @@ -2348,8 +2348,8 @@ static void fib6_flush_trees(struct net *net)
>  /*
>   *     Garbage collection
>   */
> -static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_arg=
s *gc_args,
> -                               unsigned long now)
> +void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_a=
rgs,
> +                        unsigned long now)
>  {
>         bool may_expire =3D rt->fib6_flags & RTF_EXPIRES && rt->expires;
>         int old_more =3D gc_args->more;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 08cd86f49bf9..cb521700cee7 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1033,7 +1033,7 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, =
int len,
>
>                 if (!addrconf_finite_timeout(lifetime)) {
>                         fib6_clean_expires(rt);
> -                       fib6_remove_gc_list(rt);
> +                       fib6_may_remove_gc_list(net, rt);
>                 } else {
>                         fib6_set_expires(rt, jiffies + HZ * lifetime);
>                         fib6_add_gc_list(rt);
> --
> 2.53.0.473.g4a7958ca14-goog
>

