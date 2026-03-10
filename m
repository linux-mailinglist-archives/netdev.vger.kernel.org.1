Return-Path: <netdev+bounces-266235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHmsCMBMsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:54:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F02551BA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 892CF3146973
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F523BE62C;
	Tue, 10 Mar 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZQu4KHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF43BD65B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158493; cv=pass; b=ERFWOd9yi9FMsoQPd5HiByhV6K886UNXA7Qs9rqOzgxfP0178fcc1cnU7g337PdrJ1IYXuhpT0AB6+rh43YiH5LqPu3WTm0v5gX/z1SK0BCh93RO15Cde2nROwp7PKb4sn8Wf6IUqUMzOurWB2cvb+aj7TGN6pL7+6i8ec001PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158493; c=relaxed/simple;
	bh=0G0N3PxwlIEIEQUvA3mRgzf5BBDjBYMiQjccYQ+Fwg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7qZIssXsBjgndccRhBhIM7s89W5Fp5BjVxr9hVJ12lsD2lDHJFaQYazaVAVE97rDdbekt5IlXk0p+8Z18FRhPT51ZVqrTwsyeRYIEvmSLhwhCvg2mR+DCLYpDc2iClYi8dmkngZd2ECagHIT8xF+i06z2cQSWVCxX9UziUbhwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZQu4KHs; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso16041836c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158491; cv=none;
        d=google.com; s=arc-20240605;
        b=DVoJl+b0xrSJ39ps6qMB8OurQbZJVQjJB7yvy3i66BzxMerBWp5bHoUNjtBQ+8CBDB
         n7GMC8xC/HkIW0Ky6ZcUxz8lW9f3DVWtsBUU42A+ZuidKC6UjVeQ2smzed+nCHZkHoUn
         T+ztSl2HCk30LYBsGBDOqO3nxAdifQF+lm7A+DF24lfrU6jnT/IkypBSl763uQjHQ0AZ
         KJ+kxOCLAWEwwv95Uo24SC/yaeEWsv69y+EX1HFas6NNa6c8Svvo4FhZKwIngx21RYT2
         ylhLaHcHvWDQ0IUSsL6ysZNzobp0bLRa5tBpS6QbmIkN0omQ+ycSDM1TpLeBF3fT8TXV
         8vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Lqt1yvveJmpbfgprzVsKqynVLK35qyDb/txVZp8y+I=;
        fh=4a88uxhSiXmBDAyuqcLoAZLzlhA51WqI2rKU5/Y6u+E=;
        b=ZQbalRdFZHCZxUN96Fkds/2nkYx2EcnvjPw//1HhZdVBuAidq00jbmyEUBbMIcU2w/
         tWeLmRuZ5t8jxhrDpxtu9EpPaN3k5RbRUlBKZ/XdvWelQYereSxuUI6lnT32CJnsi4Ju
         CwlckagLdxF3brF+g8Dubaj2aQCNKhPAKq5abpJbDQSYybYsviGHvb/nPoLweL/Ijut/
         av+VNBHzkHYS3NlXIA+sFtRAg8onrdv20QdOidFXUXKhOXjyZaiD0un+U2Vt88l7BIVp
         uWmBQp7SSiqgPHwKcPRLBIRtZuxo24T3vUSo1kU5QWZTDLOyBmFwXflzVXmh7XIpy6+G
         ht1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773158491; x=1773763291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lqt1yvveJmpbfgprzVsKqynVLK35qyDb/txVZp8y+I=;
        b=cZQu4KHstq58UMHD7xYUcAtDgVAyarLJcyTdMGO48XsIVrQKxGRkixPydPSnuanOB4
         sp3h6FYML4FJySebfE9/mDo2/ACAg1Wp7hVNtfkW7OB0xjs8WceNha3LcdEvFXL5Z6rN
         SZbSX0oBs5h/mNW9CvdXLKs6fGIf4q3Iqrfp/kN4VjcMjM6dZHmWHX/0BouWIq2OCb+e
         7eWixuiX9HtfC1r4jB+Kyi0a371RS3EzeaGRmt9agLyKYukoYVvE9yGqa2Bfh0AlLsq1
         O4ZROcovRqQ15WqWVtUdPHSR9toz6gi5HpKBkjqug7cxT8pXLJOq4Ovpnp4JY7dzOD/j
         57Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158491; x=1773763291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Lqt1yvveJmpbfgprzVsKqynVLK35qyDb/txVZp8y+I=;
        b=gUMNHP1hl+0ZnvwZu4hsYcEMED6JsHjrjcx5aI9jUDJAUaZjRPEAriR7sfYY4XlXMU
         AV0BHpaETqDtmmXnkS8W8rVam/kxU+G/TlvpqpUtHP3wGjmhmuYQSspWLToRGD0UzTIR
         J2elLA5YGe5lUYy68LzQSIxPAAkjM/6vrwNb7OVKncjY5URZgpKgFjm1vu1cTNKin3Zj
         pXC5fcHo0OXNTfuUUHyh8UlZKo+kuUwUtyuWSBA3pMoOMHk1/1/RgxFuaTivaJjvUhIo
         IT7DQrWRfMPpzloqVfoojEllll1PF8A6HaWIOmsmCu98MCt263Z6RrQBlgSr9odSvNv4
         +hjg==
X-Forwarded-Encrypted: i=1; AJvYcCV1hR6auxbwdR9/Et9wVacvOEoqogyQ+yBcTibC3sBfs9W4dm+pnzdmfxAkbjfTpjrymQW9pKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydl11Pmqg5cRxI0B5uD3mklbXiHrXmgkghJWVDxtfk3dLdmVwO
	Rpy7LbZVQx8ovIYRKxCpidDKlAGoTdMrfwPSQ/o9AYeASrUNat3UyIhLENiFNc8S6EF9EInR30o
	AEY6JeEPL5e0kFizIWG90W/I/3CFQoxoQJGkbxg1p
X-Gm-Gg: ATEYQzx0JqxtY15FxFG6phQI/CHF4kcMbNjKihS7lGNE/LQjDIE0ggd4m+HjKWv55Vh
	xIJ/GT/9fQ+f2ZlHqCRRn4q2nATMKKR9FKObXAf4OllqW3huNI0aH8uGkSrlt4w5CiLwVgglVcr
	s7/sLv2FA2s8AmJdEG42u6XL1pxy2kmyaa2s2GuSK3Yk84tPBfCN6FNKSgwUtZGwZMW20teewHs
	0xXIMcL6sKBLESj7ijfiNSEM3/hvqr9P3irZl51fDkDYYgCfUFMnlqQIqWXPeY7eLY1B081c93p
	0/70jYhYFs+yvJ35zmB/bL7wJNYbMIKaxknGmOR/JPuVL4M4nLbCp+zLGS080B3Ix4yv+I4=
X-Received: by 2002:a05:7022:40c:b0:11a:44d1:533a with SMTP id
 a92af1059eb24-128c2dc2a74mr6705983c88.12.1773158490746; Tue, 10 Mar 2026
 09:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309180804.3471287-1-kuniyu@google.com> <20260309180804.3471287-3-kuniyu@google.com>
 <CADvbK_dpip5BC1YST=-XKQ-V-8MwxDOgnwDWiHuFiAEB-BuCkQ@mail.gmail.com>
In-Reply-To: <CADvbK_dpip5BC1YST=-XKQ-V-8MwxDOgnwDWiHuFiAEB-BuCkQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 09:01:18 -0700
X-Gm-Features: AaiRm53qjpnyqKs1H9lPsIJ4cVzV-i2aFl84vMoMfiN-n5IVd8jRdzlrBnAWx5w
Message-ID: <CAAVpQUC0V=sf0GBq0tbiTMnxSQZ4o=zwfx3iWaiQw1+Fw6pybA@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
To: Xin Long <lucien.xin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 495F02551BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266235-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 7:09=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Mon, Mar 9, 2026 at 2:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > The cited commit mechanically put fib6_remove_gc_list()
> > just after every fib6_clean_expires() call.
> >
> > When a temporary route is promoted to a permanent route,
> > there may already be exception routes tied to it.
> >
> > If fib6_remove_gc_list() removes the route from tb6_gc_hlist,
> > such exception routes will no longer be aged.
> >
> > Let's replace fib6_remove_gc_list() with a new helper
> > fib6_may_remove_gc_list() and use fib6_age_exceptions() there.
> >
> > Note that net->ipv6 is only compiled when CONFIG_IPV6 is
> > enabled, so fib6_{add,remove,may_remove}_gc_list() are guarded.
> >
> > Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated =
list of routes.")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v3: Use IS_ENABLED()
> > v2: Fix build failure when CONFIG_IPV6=3Dn (no net->ipv6 definition)
> > ---
> >  include/net/ip6_fib.h | 19 ++++++++++++++++++-
> >  net/ipv6/addrconf.c   |  4 ++--
> >  net/ipv6/ip6_fib.c    |  6 +++---
> >  net/ipv6/route.c      |  2 +-
> >  4 files changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> > index 88b0dd4d8e09..7e91f8f35552 100644
> > --- a/include/net/ip6_fib.h
> > +++ b/include/net/ip6_fib.h
> > @@ -507,12 +507,14 @@ void fib6_rt_update(struct net *net, struct fib6_=
info *rt,
> >  void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *=
info,
> >                      unsigned int flags);
> >
> > +void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc=
_args,
> > +                        unsigned long now);
> >  void fib6_run_gc(unsigned long expires, struct net *net, bool force);
> > -
> >  void fib6_gc_cleanup(void);
> >
> >  int fib6_init(void);
> >
> > +#if IS_ENABLED(CONFIG_IPV6)
> >  /* Add the route to the gc list if it is not already there
> >   *
> >   * The callers should hold f6i->fib6_table->tb6_lock.
> > @@ -545,6 +547,21 @@ static inline void fib6_remove_gc_list(struct fib6=
_info *f6i)
> >                 hlist_del_init(&f6i->gc_link);
> >  }
> >
> > +static inline void fib6_may_remove_gc_list(struct net *net,
> > +                                          struct fib6_info *f6i)
> > +{
> > +       struct fib6_gc_args gc_args;
> > +
> > +       if (hlist_unhashed(&f6i->gc_link))
> > +               return;
> > +
> > +       gc_args.timeout =3D READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interv=
al),
> > +       gc_args.more =3D 0,
> Why is it using comma instead of semicolon here?

Ah, my silly mistake.

I initially used designated initialiser and later moved it down
after adding hlist_unhashed(), but forgot to replace s/,/;/.

I'll update this.

Thanks for catching !

pw-bot: cr



>
> > +
> > +       fib6_age_exceptions(f6i, &gc_args, jiffies);
> > +}
> > +#endif
> > +
> >  struct ipv6_route_iter {
> >         struct seq_net_private p;
> >         struct fib6_walker w;
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 0e55f139e05d..f4e23b543585 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -2862,7 +2862,7 @@ void addrconf_prefix_rcv(struct net_device *dev, =
u8 *opt, int len, bool sllao)
> >                                         fib6_add_gc_list(rt);
> >                                 } else {
> >                                         fib6_clean_expires(rt);
> > -                                       fib6_remove_gc_list(rt);
> > +                                       fib6_may_remove_gc_list(net, rt=
);
> >                                 }
> >
> >                                 spin_unlock_bh(&table->tb6_lock);
> > @@ -4840,7 +4840,7 @@ static int modify_prefix_route(struct net *net, s=
truct inet6_ifaddr *ifp,
> >
> >                 if (!(flags & RTF_EXPIRES)) {
> >                         fib6_clean_expires(f6i);
> > -                       fib6_remove_gc_list(f6i);
> > +                       fib6_may_remove_gc_list(net, f6i);
> >                 } else {
> >                         fib6_set_expires(f6i, expires);
> >                         fib6_add_gc_list(f6i);
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index fadfca49d6b1..dd26657b6a4a 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -1133,7 +1133,7 @@ static int fib6_add_rt2node(struct fib6_node *fn,=
 struct fib6_info *rt,
> >                                         return -EEXIST;
> >                                 if (!(rt->fib6_flags & RTF_EXPIRES)) {
> >                                         fib6_clean_expires(iter);
> > -                                       fib6_remove_gc_list(iter);
> > +                                       fib6_may_remove_gc_list(info->n=
l_net, iter);
> >                                 } else {
> >                                         fib6_set_expires(iter, rt->expi=
res);
> >                                         fib6_add_gc_list(iter);
> > @@ -2348,8 +2348,8 @@ static void fib6_flush_trees(struct net *net)
> >  /*
> >   *     Garbage collection
> >   */
> > -static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_a=
rgs *gc_args,
> > -                               unsigned long now)
> > +void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc=
_args,
> > +                        unsigned long now)
> >  {
> >         bool may_expire =3D rt->fib6_flags & RTF_EXPIRES && rt->expires=
;
> >         int old_more =3D gc_args->more;
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 08cd86f49bf9..cb521700cee7 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -1033,7 +1033,7 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt=
, int len,
> >
> >                 if (!addrconf_finite_timeout(lifetime)) {
> >                         fib6_clean_expires(rt);
> > -                       fib6_remove_gc_list(rt);
> > +                       fib6_may_remove_gc_list(net, rt);
> >                 } else {
> >                         fib6_set_expires(rt, jiffies + HZ * lifetime);
> >                         fib6_add_gc_list(rt);
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >

