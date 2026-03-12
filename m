Return-Path: <netdev+bounces-266870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFsDADonsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:38:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3E26C508
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486BB307C4B7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3CE374E7C;
	Thu, 12 Mar 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS35ctVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D41B4F0A
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283029; cv=pass; b=aZ+uOW3rPJnE68NBiO/KwScojyaxm6fpBOkq6oJiy3VPC3oB1G2eB483aS4pDZAVFBiHPOS8VLHICeiUDIo1Y+dLb+XHyTXoG5H5cg7sTvCTM/tsKfKcRYrFSZlIjbvvLHPNHRCWxDb+1n6YUPp6NcYnKVf+E9NVTM6QzY26C+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283029; c=relaxed/simple;
	bh=83kHemSwBum0UU01b1Y3UrtdyXeAl4uFbs4bCkIhVFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G18CIbPMtgSPHsFYy4nHTGdYpguVUDJS3Cnff64p5V8r03RhY608Hnl/TGxQWaWvkrT57QgKvJQPjmWZ9Z4ov0cIOdeHA/+oWqBfgBWDqWVUqJs4VcufWdSV10jyasWRHd7jlmpCorz5CDj+Fv8Y8JWOm0WYgJAXVBSm7lrjIm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS35ctVV; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a07f66f4eso6374686d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773283026; cv=none;
        d=google.com; s=arc-20240605;
        b=kAHChYvqKaUOpLAQfQr55qE/a13lrvQLAO8qJXPyS43jGBA/RXuJFMS7JVpC3oV+SP
         MJWqGCimZ+K9WyTFVLlNSIL9hm9t5gnY25Vfm2Yx4VN0LdMs97a30uKumpTEgFo5QK67
         aweJGKIpQUkvMVNWK/AiRyzdvflYUWyrh7u6nAwRu0GgbbtevqHoCz+LHax4OyeNRCBz
         /sxBt2+f6/XqTlIE+amWoQyik3BDqqlSd7sGBpgVFFQNgzpaSBoOtMw8EtaLGYXhjQbq
         ZHBcgsbwXQX0RdFp7tAhciBOc4lKbqCo7xl4/Mb6u7nvgJDHNw2IWMCTfACql7hZ3MDm
         vsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lPQknV0BdxTKgArg2PsER64sAldQZHBJhucCnD2eKCc=;
        fh=uJOxayjV8RE7bUakCZ766BiS7aouVFgIzrtMnCA10sM=;
        b=T+H8okK5xJIekUZqSqvwZd8wVRXb9No+ExJqKGf9o3ecSMWvovAVJ1yhZ0/SLyzycl
         12cAYvwzuqG4K9Tp5lXTwWu8eFZRo8+7qIzslB2BHr6f838KVjQ5BOnTnAyqT88Hqglx
         iGukiGujeL7INnKw7nTiFEy2bsy4/oXvILmIXfZja0jCw+c7ST/RkkDgHtANb2EkQsR7
         jrNhuit9WF7NBRkK6fdjFeVmwHA8ygkOMU0u8aGRU4itjdTlzzsV7W8xoyMXlhMjyv19
         ShRYU6sYNJ4rHuXsam0CuF6TFOVCAzdiJfyBm/85UH/72lLkKlj+BI/Q6U+QOXFSdozj
         TGYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773283026; x=1773887826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPQknV0BdxTKgArg2PsER64sAldQZHBJhucCnD2eKCc=;
        b=AS35ctVVLBAmHCBZIfKAOUozFJMdySfkT9kqsmgpvjJ9CwWYLbI+KzGrgDd9NesTax
         VOa1TTy9397Y0Yu/jlZCwqAn1oHZodiyVZ1NczUG2+Yhvjo5Kna6Kan4pY7eEUhIDwXV
         eep0oswogOqu0PFh/tBp+Xcw9IGonphVppwjmNmQaI3YymgVRcS0VnsPzfKy2iQ/1+cR
         YEgpaS00EwXDqqp20dKwGWOjqoYbFzF4Yu+4piUv+QB0HsBAhs2cyWV+QQNq94PvBXrB
         CmOvi9xUP7i886KYtK2PVU4YiSHiGV56mkKuEdnbWmMb56KaH4DRdfo/O/mUcsu83oMe
         xBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773283026; x=1773887826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPQknV0BdxTKgArg2PsER64sAldQZHBJhucCnD2eKCc=;
        b=YvqtW4m8hufvHy/Wuxh0aRzOe2t947eLxfnOHXhj/T/VWJHxKsoA+8eLqG4CwPH+k8
         WcXhC+sk4qO+0F3WH3uKVNZ20YWf9PtwfrSf0c4TpN0PGVE9xtswwDB+FTCqCTrpHrNZ
         XrqiRnmT2dY725ilMqF9vOBE5bWmcIhwC2hvPEcBEZRd+pQhXUZ1sM4vM+OvsaWCdiaQ
         MkKLg0Krvabywc9wqYI3fBzPePNWp5iM8r0bojRb3bJFRZxOastzsjQp4aVrHtgBk/St
         pZBeH7n83nWLkbozb7g2ecR5STfMYJhiIsEfwj5Da2FLqQtMLhxZS8ygG0QvygnzX8eB
         F12g==
X-Gm-Message-State: AOJu0YzNr2LW08sx3OdgFJUQr592ffwHW0MGknLmISvFIQkouSKdECzt
	1G3CxVU74b6/I062SrDpnGW9VBZv9wC04t83RARz5LYNI8YX6o3wRzJTHJs9S3hwxdxSyRmBKyv
	L5sRA6mh2pRI/5PulY0XUE6e2rchyHMU=
X-Gm-Gg: ATEYQzy8H0SvIXJ2fJabuU6PozXXyKK2ROXdS/ji2EdUSokYr3AA0xOUXtl0CybT8JB
	Y5T56P82zKjmxkk13UJojcXZ1l5cZWJSGM/f6C3cjCw79Vu2kTPoZDwMv66moJQo0zWLP79+dFe
	A1aYBRRHWTwqUkL5C/wmGxA7gEdiAMD9Bkaufk9qSrR9fMf55pUd1ekVH+AY4YLA1HoagCZQxMr
	hfeZOXOv8aX3AKoS8sixQ0h2X9cp461F5KApXfyn7ApolAiG+PidqfFr9GEJTJEOiyPf06pndwH
	j0Oa+D4=
X-Received: by 2002:a05:6214:622:b0:89a:1c81:65c1 with SMTP id
 6a1803df08f44-89a669dd63dmr68475266d6.16.1773283025846; Wed, 11 Mar 2026
 19:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
 <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com>
 <CANn89iKevHTf+MyJ+4PJ7ZR-+FcRqZiFubeLqRcyZ+gd4LWtsg@mail.gmail.com>
 <CAFzOa14ubmPEmst65Nmtyy3hwtdCYqviv8NNmfXeJ9v5EwwoSA@mail.gmail.com> <CANn89iLHwYxCLgBSQJ=jotaavFbB=jDiQufqjbbtzd6FB_-EMg@mail.gmail.com>
In-Reply-To: <CANn89iLHwYxCLgBSQJ=jotaavFbB=jDiQufqjbbtzd6FB_-EMg@mail.gmail.com>
From: Guanni Qu <qguanni@gmail.com>
Date: Wed, 11 Mar 2026 19:36:54 -0700
X-Gm-Features: AaiRm53fPvJqbWkTZ2E5c6JWshSijHJ3ntUSNxMjgCErzgFX_vsELewresbb4Gk
Message-ID: <CAFzOa17nTWH6SdpgTjZ8w9DC5P2QbWirxHr7bBcACkopanuyWg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: ip6_tunnel: fix use-after-free in ip4ip6_err
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	klaudia@vidocsecurity.com, dawid@vidocsecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-266870-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qguanni@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vidocsecurity.com:email]
X-Rspamd-Queue-Id: 59D3E26C508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

You're right, thank you for the explanation. The RCU read lock
guarantees the route object remains valid through the entire
err_handler call. I'll withdraw this patch.

Jenny

On Wed, Mar 11, 2026 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Mar 12, 2026 at 3:26=E2=80=AFAM Guanni Qu <qguanni@gmail.com> wro=
te:
> >
> > Hi Eric,
> >
> > Thank you for the review.
> >
> > You're right that ip4ip6_err() is called under rcu_read_lock()
> > protection via icmpv6_rcv() -> icmpv6_notify() -> .err_handler, so
> > the RCU-deferred free via call_rcu_hurry() cannot complete while
> > we're still in this function. I should not have characterized this
> > as a use-after-free. It's a use-after-put that is currently safe
> > due to RCU but violates refcount semantics.
> >
> > The original discovery used kprobe instrumentation (not KASAN), so
> > there is no crash stack trace. The call path is:
> >
> >   icmpv6_rcv()
> >     rcu_read_lock()
> >     icmpv6_notify()
> >       ip4ip6_err()        <-- .err_handler
> >         ip_rt_put(rt)     <-- drops refcount
> >         rt->dst.dev       <-- use-after-put
> >         rt->rt_flags      <-- use-after-put
> >     rcu_read_unlock()
>
> So... there is no UAF : rt won't be freed before we reach rcu_read_lock()=
.
>
> I think your patch is not needed. Your assumptions are broken.
>
> > v2 addresses both issues and adds the Fixes: tag.
> >
> > Changes since v1:
> > - Also save rt->dst.dev before ip_rt_put(), as you pointed out
> > - Reworded commit message: use-after-put, not use-after-free
> > - Added Fixes: tag
> > - Removed incorrect Co-developed-by
> >
> > ---
> >
> > From 96a562ef1b602454841ba770d80fbe6b1eeb3d2b Mon Sep 17 00:00:00 2001
> > From: Jenny Guanni Qu <qguanni@gmail.com>
> > Date: Thu, 12 Mar 2026 02:19:24 +0000
> > Subject: [PATCH v2] ipv6: ip6_tunnel: fix use-after-put in ip4ip6_err()
> >
> > In ip4ip6_err(), after ip_rt_put(rt) drops the route reference,
> > both rt->dst.dev and rt->rt_flags are accessed. While this is
> > currently safe because the function runs under rcu_read_lock()
> > (via icmpv6_rcv -> icmpv6_notify), accessing a reference-counted
> > object after dropping its reference violates refcount semantics.
> >
> > Save both rt->dst.dev and rt->rt_flags into local variables before
> > calling ip_rt_put(rt).
> >
> > Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's err_hand=
lers")
> > Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
> > Reported-by: Dawid Moczad=C5=82o <dawid@vidocsecurity.com>
> > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > ---
> >  net/ipv6/ip6_tunnel.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > index b60e13c42bca..2bb9b54015e9 100644
> > --- a/net/ipv6/ip6_tunnel.c
> > +++ b/net/ipv6/ip6_tunnel.c
> > @@ -567,6 +567,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_pa=
rm *opt,
> >   u8 rel_type =3D type;
> >   u8 rel_code =3D code;
> >   struct rtable *rt;
> > + unsigned int rt_flags;
> > + struct net_device *rt_dev;
> >   struct flowi4 fl4;
> >
> >   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> > @@ -614,11 +616,13 @@ ip4ip6_err(struct sk_buff *skb, struct
> > inet6_skb_parm *opt,
> >   if (IS_ERR(rt))
> >   goto out;
> >
> > - skb2->dev =3D rt->dst.dev;
> > + rt_dev =3D rt->dst.dev;
> > + rt_flags =3D rt->rt_flags;
> > + skb2->dev =3D rt_dev;
> >   ip_rt_put(rt);
> >
> >   /* route "incoming" packet */
> > - if (rt->rt_flags & RTCF_LOCAL) {
> > + if (rt_flags & RTCF_LOCAL) {
> >   rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
> >      eiph->daddr, eiph->saddr, 0, 0,
> >      IPPROTO_IPIP,
> > --
> > 2.34.1
> >
> > Thanks,
> > Jenny
> >
> > On Wed, Mar 11, 2026 at 6:32=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 2:24=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2026 at 1:47=E2=80=AFAM Guanni Qu <qguanni@gmail.co=
m> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This vulnerability was discovered by Klaudia Kloc and Dawid Mocza=
d=C5=82o
> > > > > of Vidoc Security Lab using VIDOC tool, and independently validat=
ed
> > > > > and patched by
> > > > > Jenny Guanni Qu.
> > > > >
> > > > >
> > > > > 1. BUG DESCRIPTION
> > > > >
> > > > > In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object return=
ed by
> > > > > ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt=
_flags
> > > > > is read immediately after the release. This is a use-after-free o=
n a
> > > > > logically freed object.
> > > > >
> > > > >   skb2->dev =3D rt->dst.dev;
> > > > >   ip_rt_put(rt);              // frees the route
> > > > >
> > > > >   /* route "incoming" packet */
> > > > >   if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read
> > > > >
> > > > >
> > > > > 2. ROOT CAUSE
> > > > >
> > > > > File: net/ipv6/ip6_tunnel.c
> > > > > Function: ip4ip6_err()
> > > > >
> > > > > ip_rt_put() calls dst_release(), which schedules destruction via
> > > > > call_rcu_hurry(). The rt->rt_flags read happens in the same funct=
ion
> > > > > context before any RCU grace period can elapse, so the memory is =
still
> > > > > accessible but the object is logically freed.
> > > > >
> > > > > Note: KASAN does not detect this because the RCU-deferred free ha=
s not
> > > > > completed by the time rt_flags is read. The memory is not yet poi=
soned.
> > > > >
> > > > >
> > > > > 3. AFFECTED VERSIONS
> > > > >
> > > > > - Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrum=
entation)
> > > > > - Source-level analysis confirms the bug on 6.12.0 (arm64)
> > > > > - The put-then-use pattern has no fix in HEAD as of v6.12
> > > > > - Architecture-independent (logic bug)
> > > > >
> > > > >
> > > > > 4. EVIDENCE
> > > > >
> > > > > Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/=
40
> > > > > path hits where the same rt pointer value is observed both before=
 and
> > > > > after ip_rt_put():
> > > > >
> > > > >   vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
> > > > >   vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0
> > > > >
> > > > > All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunne=
l
> > > > > endpoint hit the vulnerable path every time.
> > > > >
> > > > >
> > > > > 5. TRIGGER
> > > > >
> > > > > Send ICMPv6 Destination Unreachable (code 3) packets to a configu=
red
> > > > > ipip6 tunnel endpoint.
> > > > >
> > > > >   from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
> > > > >   inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4=
) / \
> > > > >           IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
> > > > >   pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=
=3D3) / inner
> > > > >   send(pkt)
> > > > >
> > > > > Requirements:
> > > > > - ipip6 tunnel configured (ip6_tunnel module or built-in)
> > > > > - Ability to send ICMPv6 packets to the tunnel endpoint
> > > > >
> > > > >
> > > > > 6. IMPACT
> > > > >
> > > > > - Use-after-free read on a route object (struct rtable)
> > > > > - Under normal conditions: reads stale but valid memory (RCU prot=
ects
> > > > >   the actual free). Behavior is correct by accident.
> > > > > - Under memory pressure or with KASAN slab quarantine: could read
> > > > >   corrupted data, leading to incorrect routing decisions or crash
> > > > > - Exploitability: low in practice due to RCU grace period, but th=
e
> > > > >   code is formally incorrect and violates memory safety
> > > > >
> > > > >
> > > > > 7. FIX
> > > > >
> > > > > Save rt->rt_flags into a local variable before calling ip_rt_put(=
rt).
> > > > >
> > > > > Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecu=
rity.com>
> > > > > Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vido=
csecurity.com>
> > > > > Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > > > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > > > ---
> > > > >  net/ipv6/ip6_tunnel.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > > > > index b60e13c42bca..857a7ff8a041 100644
> > > > > --- a/net/ipv6/ip6_tunnel.c
> > > > > +++ b/net/ipv6/ip6_tunnel.c
> > > > > @@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_=
skb_parm *opt,
> > > > >   u8 rel_type =3D type;
> > > > >   u8 rel_code =3D code;
> > > > >   struct rtable *rt;
> > > > > + unsigned int rt_flags;
> > > > >   struct flowi4 fl4;
> > > > >
> > > > >   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_cod=
e,
> > > > > @@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> > > > > inet6_skb_parm *opt,
> > > > >   goto out;
> > > > >
> > > > >   skb2->dev =3D rt->dst.dev;
> > > > > + rt_flags =3D rt->rt_flags;
> > > > >   ip_rt_put(rt);
> > > > >
> > > > >   /* route "incoming" packet */
> > > > > - if (rt->rt_flags & RTCF_LOCAL) {
> > > > > + if (rt_flags & RTCF_LOCAL) {
> > > > >   rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
> > > > >      eiph->daddr, eiph->saddr, 0, 0,
> > > > >      IPPROTO_IPIP,
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > >
> > > > ip4ip6_err() is supposed to be called under rcu_read_lock() protect=
ion.
> > > > call_rcu() and call_rcu_hurry() should not proceed until this threa=
d
> > > > has reached rcu_read_unlock().
> > > >
> > > > Can you share the stack trace so that we can root cause the issue ?
> > > >
> > > > Your fix is not complete, because we latch rt->dst.dev into skb2->d=
ev
> > > >
> > > > skb2->dev =3D rt->dst.dev;
> > > >
> > > > So the device could also disappear, and UAF would also happen.
> > >
> > > Also you forgot to include a Fixes: tag
> > >
> > > This is crucial for any patch targetting net tree.
> > >
> > > Thank you.

