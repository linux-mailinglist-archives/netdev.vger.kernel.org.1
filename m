Return-Path: <netdev+bounces-266868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H7UErolsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:32:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517226C3F9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E07F301151A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14137C902;
	Thu, 12 Mar 2026 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg88fBXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F993563D5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282741; cv=pass; b=hhvF/jJ1MjBp9UlzdiFvl3XpP+a1kMZHEb1z9YhOAlNNQfxh33avAbdXX3HENIcacOvS/O4bfVkG7snWUZAVyNW+DLOjElxwXZAwJdxM88ars7F1skBRyeJclBbyMyo6fr6qkNExKvdclekjAmO4pPJlQDQoVelmCj99qhFeNXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282741; c=relaxed/simple;
	bh=ZUcYo1OLkmD6V1dJnHD9idN+CCmSE2GLV4h7cHU0FRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph7s5E7WeYKfTopDG+6Uf/gD2hRQfmSPqejqnvWPH1tcu2HGM6+iM5viprYjYPue2bv3F3CL89evK6M5EOplUB8AnNl7B++ZrLJvL8jzqgue1GQFeySNgcGoSlrV0IRzQtNDpGs/ktkBtiRkkVod5S4wkJT/fBPpAdfZY+ZHb8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg88fBXD; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506362ac5f7so5156401cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773282737; cv=none;
        d=google.com; s=arc-20240605;
        b=L4GPgw1RIT+UpH9DOJQ/Rq+MgLL8KoBxBqP08mbX6p0vs0r5tvltb8Z5RPFOsaIVBW
         Yw3AyN4yz9eyauGURrrSf5755Vzds478kiGir6YxoPJET7z0tbc3QB+O9oydMsxXHogl
         va18d4jsNCYEy1kcrlzTEubIsTgSWp5qm+oCJ6nn2MU/otaPonsJx6dQWgFLBIOAAeyo
         b/OZk2lYrwnc3RydcL7ZkYlAYrnWTLANDr4VN5+1UGwMy1bgS8Sl8FXlDQmJ0DhqkibA
         EsPLOeLGPaNcq6yVFSGWLBjD1j7Vov0OW41CErEmMMfAOwjFSWk1+O/361WoLMshMT5h
         9g/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDpGW33gbOOmWkNgwrzVBlJUpJVNHUgVDRMrgKpCTpo=;
        fh=aFaLzrRfN1R74H7Jat4PIIqQu8SGdDE43SUWvANGDyg=;
        b=QGLJ46R8wo9l2XOmiWPALEc5nDKqcRkHgpnmI0iuK+ublRK96DoL7A1nWp/eUAhNue
         8Xnh/8jjiceGzmnO2PhQ8d7dkyaJB5Rkx8XSxJvwGVC2L0qphpShF8Y9JtIsFkzd/QHs
         EPltz9bt+Il02mXRj4bYFOjzOPmbLdWvkZCyJC9Ugb9I8p/C/mWD90UB6lWi2NuqiVl0
         cbg33i2v7pAIp8accBJGIJ1VlmZFqUd5shHKgrWCsKYR9DqYjiI+wspJuoc0k+fKtqxX
         XW+RMDK5DnKOMhXUY1T56BY9dpra+XJqGnQVUdYVf51HOLA9U10Q5+hnsmQU0XC/sh0K
         14NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773282737; x=1773887537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDpGW33gbOOmWkNgwrzVBlJUpJVNHUgVDRMrgKpCTpo=;
        b=Eg88fBXDnGjvVckToqIqv7V6Gf5PGVfTxs+RCRDlj3eybGUIFDIASeZddpFvX04zdj
         0/PEDHfdsedYPFKSmWr9644zqooLbSz9jlakK5NzHo5SLWZxP+CLmQVc6Y8rlOOr1VUY
         HUNle/WSRWewcYMA7Brxmhqz1vGG6c09CTipoh5svB6yOp2FVkKmvqWBS12q6L/Tr6wM
         Hvz5gkylyJm5GKcb5qBWLWEYSq1Dgepjnvk7LVHCEOuLM3/CIbsVmEl/ow5jFsZT/g0m
         or7Cy/SuVTWVaMDeW4z8zV8GVEQXJeF88FaJr0ORdQs2UCWPuhWvro5+DcRiAIhmtAgA
         EOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773282737; x=1773887537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDpGW33gbOOmWkNgwrzVBlJUpJVNHUgVDRMrgKpCTpo=;
        b=J11ns7SC97zfPLBb97ywRh4NrPxLDINqI1mvT3uI1WOYzTYmykNCgDL6+XqPrfdk+d
         BsRRvd3EGiNCjOkOgtm9p2AHs7Uekc8w8R/LT5v+orXBBTuRywmxZ/qPMuBBKmwoCVDg
         ToksxF8WRqCPgiLjMJUNw0Ypcau9e2ysY6+vBGsUF5VtVfSyjBCqvOpIndIHvFfDAFyb
         UEXUMVkF98V5XvF3ZcUs7W/n9Yp42ELGaC11xz1a5Vl5hi88HQEnsA0qevSil03E91he
         SAljvYMeFmT+gyeXrGKw4kQEeNxZ9Mw3rT2sM9mJEa2aoVopNoMGRalVZQn+RhgWsm95
         GIfw==
X-Gm-Message-State: AOJu0YzFc2NJLXs2W47NbJjaad0QKk9Lg6Q8Y++p57ZYEQiY3k4/Qe/K
	rVZwc0a720XTE7fmBdh2HTobGdf0Fem1H5/gePJOFzCGesT6sIILIpumEVBaevE1Oa6zAgKJgnq
	bvs+bqNvzfeT9JW8oY6d2rbCndFIVWqv3b6dAK2E4
X-Gm-Gg: ATEYQzz9HdHhmaMI9bmgEbY0PMKz/hkhlXyI1sew6b5YtarVEk5fl1q4hEcLHzgCXUf
	O+qtj0oRHlRczUICNeKkm+2UtMMIXYLgXjzQhnycHKf87oQCpE74ibKaU9NLywVPLowOP2IEFUX
	hZatHaH6A8NXNKmiYjyP3AaezxGfNt+3GDvd3G/Pskz/1kgvdY5C6UdpLbEmmm0MF8LJxYwa8HL
	t7ip9otxnEon/AZ6GJ58nrFggE6NLcBYdTX7jO/dySwv0yU9j5mG8Nb5C550e2O17ZMlU+G3KDI
	oTvekQ8=
X-Received: by 2002:a05:622a:286:b0:509:18f4:6da7 with SMTP id
 d75a77b69052e-5093a188c25mr56483831cf.40.1773282737183; Wed, 11 Mar 2026
 19:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
 <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com>
 <CANn89iKevHTf+MyJ+4PJ7ZR-+FcRqZiFubeLqRcyZ+gd4LWtsg@mail.gmail.com> <CAFzOa14ubmPEmst65Nmtyy3hwtdCYqviv8NNmfXeJ9v5EwwoSA@mail.gmail.com>
In-Reply-To: <CAFzOa14ubmPEmst65Nmtyy3hwtdCYqviv8NNmfXeJ9v5EwwoSA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 03:32:05 +0100
X-Gm-Features: AaiRm50W0PUGgDiawyFEDbB08XyUO5OWjcfo3AFjGR9NFKlWZJqBA_3oOUQ6Sfw
Message-ID: <CANn89iLHwYxCLgBSQJ=jotaavFbB=jDiQufqjbbtzd6FB_-EMg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: ip6_tunnel: fix use-after-free in ip4ip6_err
To: Guanni Qu <qguanni@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	klaudia@vidocsecurity.com, dawid@vidocsecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266868-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2517226C3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 3:26=E2=80=AFAM Guanni Qu <qguanni@gmail.com> wrote=
:
>
> Hi Eric,
>
> Thank you for the review.
>
> You're right that ip4ip6_err() is called under rcu_read_lock()
> protection via icmpv6_rcv() -> icmpv6_notify() -> .err_handler, so
> the RCU-deferred free via call_rcu_hurry() cannot complete while
> we're still in this function. I should not have characterized this
> as a use-after-free. It's a use-after-put that is currently safe
> due to RCU but violates refcount semantics.
>
> The original discovery used kprobe instrumentation (not KASAN), so
> there is no crash stack trace. The call path is:
>
>   icmpv6_rcv()
>     rcu_read_lock()
>     icmpv6_notify()
>       ip4ip6_err()        <-- .err_handler
>         ip_rt_put(rt)     <-- drops refcount
>         rt->dst.dev       <-- use-after-put
>         rt->rt_flags      <-- use-after-put
>     rcu_read_unlock()

So... there is no UAF : rt won't be freed before we reach rcu_read_lock().

I think your patch is not needed. Your assumptions are broken.

> v2 addresses both issues and adds the Fixes: tag.
>
> Changes since v1:
> - Also save rt->dst.dev before ip_rt_put(), as you pointed out
> - Reworded commit message: use-after-put, not use-after-free
> - Added Fixes: tag
> - Removed incorrect Co-developed-by
>
> ---
>
> From 96a562ef1b602454841ba770d80fbe6b1eeb3d2b Mon Sep 17 00:00:00 2001
> From: Jenny Guanni Qu <qguanni@gmail.com>
> Date: Thu, 12 Mar 2026 02:19:24 +0000
> Subject: [PATCH v2] ipv6: ip6_tunnel: fix use-after-put in ip4ip6_err()
>
> In ip4ip6_err(), after ip_rt_put(rt) drops the route reference,
> both rt->dst.dev and rt->rt_flags are accessed. While this is
> currently safe because the function runs under rcu_read_lock()
> (via icmpv6_rcv -> icmpv6_notify), accessing a reference-counted
> object after dropping its reference violates refcount semantics.
>
> Save both rt->dst.dev and rt->rt_flags into local variables before
> calling ip_rt_put(rt).
>
> Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's err_handle=
rs")
> Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
> Reported-by: Dawid Moczad=C5=82o <dawid@vidocsecurity.com>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>  net/ipv6/ip6_tunnel.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index b60e13c42bca..2bb9b54015e9 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -567,6 +567,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>   u8 rel_type =3D type;
>   u8 rel_code =3D code;
>   struct rtable *rt;
> + unsigned int rt_flags;
> + struct net_device *rt_dev;
>   struct flowi4 fl4;
>
>   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> @@ -614,11 +616,13 @@ ip4ip6_err(struct sk_buff *skb, struct
> inet6_skb_parm *opt,
>   if (IS_ERR(rt))
>   goto out;
>
> - skb2->dev =3D rt->dst.dev;
> + rt_dev =3D rt->dst.dev;
> + rt_flags =3D rt->rt_flags;
> + skb2->dev =3D rt_dev;
>   ip_rt_put(rt);
>
>   /* route "incoming" packet */
> - if (rt->rt_flags & RTCF_LOCAL) {
> + if (rt_flags & RTCF_LOCAL) {
>   rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
>      eiph->daddr, eiph->saddr, 0, 0,
>      IPPROTO_IPIP,
> --
> 2.34.1
>
> Thanks,
> Jenny
>
> On Wed, Mar 11, 2026 at 6:32=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Mar 12, 2026 at 2:24=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 1:47=E2=80=AFAM Guanni Qu <qguanni@gmail.com>=
 wrote:
> > > >
> > > > Hi,
> > > >
> > > > This vulnerability was discovered by Klaudia Kloc and Dawid Moczad=
=C5=82o
> > > > of Vidoc Security Lab using VIDOC tool, and independently validated
> > > > and patched by
> > > > Jenny Guanni Qu.
> > > >
> > > >
> > > > 1. BUG DESCRIPTION
> > > >
> > > > In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object returned=
 by
> > > > ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt_f=
lags
> > > > is read immediately after the release. This is a use-after-free on =
a
> > > > logically freed object.
> > > >
> > > >   skb2->dev =3D rt->dst.dev;
> > > >   ip_rt_put(rt);              // frees the route
> > > >
> > > >   /* route "incoming" packet */
> > > >   if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read
> > > >
> > > >
> > > > 2. ROOT CAUSE
> > > >
> > > > File: net/ipv6/ip6_tunnel.c
> > > > Function: ip4ip6_err()
> > > >
> > > > ip_rt_put() calls dst_release(), which schedules destruction via
> > > > call_rcu_hurry(). The rt->rt_flags read happens in the same functio=
n
> > > > context before any RCU grace period can elapse, so the memory is st=
ill
> > > > accessible but the object is logically freed.
> > > >
> > > > Note: KASAN does not detect this because the RCU-deferred free has =
not
> > > > completed by the time rt_flags is read. The memory is not yet poiso=
ned.
> > > >
> > > >
> > > > 3. AFFECTED VERSIONS
> > > >
> > > > - Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrumen=
tation)
> > > > - Source-level analysis confirms the bug on 6.12.0 (arm64)
> > > > - The put-then-use pattern has no fix in HEAD as of v6.12
> > > > - Architecture-independent (logic bug)
> > > >
> > > >
> > > > 4. EVIDENCE
> > > >
> > > > Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/40
> > > > path hits where the same rt pointer value is observed both before a=
nd
> > > > after ip_rt_put():
> > > >
> > > >   vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
> > > >   vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0
> > > >
> > > > All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunnel
> > > > endpoint hit the vulnerable path every time.
> > > >
> > > >
> > > > 5. TRIGGER
> > > >
> > > > Send ICMPv6 Destination Unreachable (code 3) packets to a configure=
d
> > > > ipip6 tunnel endpoint.
> > > >
> > > >   from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
> > > >   inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4) =
/ \
> > > >           IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
> > > >   pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=
=3D3) / inner
> > > >   send(pkt)
> > > >
> > > > Requirements:
> > > > - ipip6 tunnel configured (ip6_tunnel module or built-in)
> > > > - Ability to send ICMPv6 packets to the tunnel endpoint
> > > >
> > > >
> > > > 6. IMPACT
> > > >
> > > > - Use-after-free read on a route object (struct rtable)
> > > > - Under normal conditions: reads stale but valid memory (RCU protec=
ts
> > > >   the actual free). Behavior is correct by accident.
> > > > - Under memory pressure or with KASAN slab quarantine: could read
> > > >   corrupted data, leading to incorrect routing decisions or crash
> > > > - Exploitability: low in practice due to RCU grace period, but the
> > > >   code is formally incorrect and violates memory safety
> > > >
> > > >
> > > > 7. FIX
> > > >
> > > > Save rt->rt_flags into a local variable before calling ip_rt_put(rt=
).
> > > >
> > > > Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecuri=
ty.com>
> > > > Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vidocs=
ecurity.com>
> > > > Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > > ---
> > > >  net/ipv6/ip6_tunnel.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > > > index b60e13c42bca..857a7ff8a041 100644
> > > > --- a/net/ipv6/ip6_tunnel.c
> > > > +++ b/net/ipv6/ip6_tunnel.c
> > > > @@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_sk=
b_parm *opt,
> > > >   u8 rel_type =3D type;
> > > >   u8 rel_code =3D code;
> > > >   struct rtable *rt;
> > > > + unsigned int rt_flags;
> > > >   struct flowi4 fl4;
> > > >
> > > >   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> > > > @@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> > > > inet6_skb_parm *opt,
> > > >   goto out;
> > > >
> > > >   skb2->dev =3D rt->dst.dev;
> > > > + rt_flags =3D rt->rt_flags;
> > > >   ip_rt_put(rt);
> > > >
> > > >   /* route "incoming" packet */
> > > > - if (rt->rt_flags & RTCF_LOCAL) {
> > > > + if (rt_flags & RTCF_LOCAL) {
> > > >   rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
> > > >      eiph->daddr, eiph->saddr, 0, 0,
> > > >      IPPROTO_IPIP,
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >
> > > ip4ip6_err() is supposed to be called under rcu_read_lock() protectio=
n.
> > > call_rcu() and call_rcu_hurry() should not proceed until this thread
> > > has reached rcu_read_unlock().
> > >
> > > Can you share the stack trace so that we can root cause the issue ?
> > >
> > > Your fix is not complete, because we latch rt->dst.dev into skb2->dev
> > >
> > > skb2->dev =3D rt->dst.dev;
> > >
> > > So the device could also disappear, and UAF would also happen.
> >
> > Also you forgot to include a Fixes: tag
> >
> > This is crucial for any patch targetting net tree.
> >
> > Thank you.

