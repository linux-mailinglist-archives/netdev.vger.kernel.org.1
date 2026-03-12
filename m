Return-Path: <netdev+bounces-266852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLgaBGcksmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:26:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5626C322
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC6083046078
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD22362138;
	Thu, 12 Mar 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyhkn5Fd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928443603D8
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282404; cv=pass; b=FZJsW+wA8sXd2H5aeg1ti6wI5wA97EKkqNnW+4IzNxxmw5Af8clh2jhW+K9Ilu11KkktELflAuh4wZe85ve0pHpL5x8o2HN1BODtIrHAY83Zs4wd6Hj88mZ0tNp7CBjd5eVhcHXaVf54nyhFRkSmVzIYRKgxq16oLsrC+WbqVlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282404; c=relaxed/simple;
	bh=6H632KUZeL6qJZGs8TIAvo3Sqr13NLiDhXz7No3+HsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhz6QyrfR6IUSOH/oP+MmmgkZfyKAoxEVZLALt/zMFqmJHYeooL61gqPvOZYnxlpt8WUcMeOgZrijmBOve8mScOOP38lesvq+iZgMZMGqka2XhySHaa0lG8pudjAPRDMxf9S6FMOxyhd/KfN9wxhiMe+iq9rDXLnljioxpjKWek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyhkn5Fd; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899ee87355dso7330376d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773282401; cv=none;
        d=google.com; s=arc-20240605;
        b=abLMSOM/73jTdEgzSSPPM2ybdd1ZV1397aSWtDIG7h+4IwXAt0Nv/GXDLVAQ9CPDup
         EE1hkj85bAzIWEC4l84SvE0h+J+t3Fn4D69Ga5Rnwa4RiHo8rxRbbTw/NrK/teB+uEa7
         maLMsPkVXvO7LRSkPJDfkxAkk98Sr9ou89Nha31ryX2KAyTfSY+ruL09heFQLr+0QCy1
         IsOspTX2AAxSk1ZatLDnI5W19qCqbx1LmTVvII6qMyXD5Iwlm0Ynp+c5Oto7X0MHgESU
         zBSXBEcDO+ct2M4fmIgn/4hqnoZbTNnCIFY0so7oIT3wn7aZfCtTixh1PbRxoDs0cyo0
         5pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcr+zV2qeLYyDRFxN6Memk911jsqXj4Ju7ZKYZqj0dw=;
        fh=uJOxayjV8RE7bUakCZ766BiS7aouVFgIzrtMnCA10sM=;
        b=RMXsTimEa+Dy3wt/jG+G5zffUXeluBn+2tTm8k/U5q2+fRPMHRCAVOLXTWAJ4yMSS8
         cTnYUaGeE5wr09w6fuD7Q2z7v/tR4MCmrfFekIARyyPOc8HhQvjOrlYjhN+j3batMtR4
         uVfq3adoZ5xAHWPFP08ka+3x/gvTCm5V46VVUDn76f5cNAtm4rVYUPSpP2Fxszj8N0By
         B/71VzAaWsvay5eqTsryCA+T302g+XhkXLusS2f/oJ/H4hSobsdNl2wDLFRONc/FTDyA
         abKWbP/k6OW0ngO3cr99xqnbxKOXcQ6cwPN90alyuxrjdWHMS0BcOBTC2PYADN6vTIgi
         mrNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773282401; x=1773887201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcr+zV2qeLYyDRFxN6Memk911jsqXj4Ju7ZKYZqj0dw=;
        b=Zyhkn5FdIAF/s+fr8aO1u6CIYE0omSsWYShfcYMqQoCvgja5Q/UlCzbu3NcMHcpF4C
         T4yAtq9KhxOyMcdeQteAE/iiA0nK8a1SJWXbQqdrTnGMFK1zPGKoAlB5u0iokeuiuX3p
         cr8KuGzmYCjrNZGGv+jHrITP1kyj0IXVxAhz/X63XVJCXEYUeSkJ7eLcEOY/X28AQxht
         BO7N2+4LXUS7Y8UC2n8DeankEqmzpMT80puayFzynxo6LG7pprqo+l5lDlltFhtLP83a
         e84sxSkZgW74ztG8svIzFU/MS9iYW2QeSXDO/2ccPusliCPKouEQRdTupHMSRHXzO92B
         g8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773282401; x=1773887201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcr+zV2qeLYyDRFxN6Memk911jsqXj4Ju7ZKYZqj0dw=;
        b=psiog/LDJl8AOH7rSupRW38q3Q4vtEZONt4hEwWa08iPLKEDw6Bpb71/q+2EpIDigg
         wFvtr1lrolOKoAP4a8QsJLQLMy6Ug0a3/3/iETu51u36zJjJ7lzBi+L7KvS6D2XFwlVt
         8AR0CsDkwG+xKJPEKSFElngkjzVV6edNuHVC8saS2+p+R+tnhbpzfreyhPFwBh59k2F2
         iEA+WDu1yc59z3FdS2pCVwcJ9afJOZMKIALLjagJQL/NCdmJa0FwHweE4I2zspOcufu4
         UF6MLUVe3IIRlC+V9OY78RaBIbueA3ohModY5m49c2LpWg/nEdXhoi5xUP89k7KlfroH
         TG9g==
X-Gm-Message-State: AOJu0YzbZ4+D9im96hkxY6UJK3ylGnikADAiXldOdZ2Jo+ZgJDu9Ys4h
	hCOlUZ9XhwgNvaOHyIKqrivk2qStNjqcFb6OXczRyAB+CwoQ3ROxp6Z2BYlsezLICHqFYDmkvg3
	QBh2flkacJ4HeNSJd//i3I8cnIAQTYJ0=
X-Gm-Gg: ATEYQzxCNIwLmFmDJMXo1XC1xingm22XmXsQ6pHXPQEooA6IfQ3upa/4wS+jE6RHAls
	mpuKi2ZnxCAxPD3ri8k6S9wMW9ig9RmHGbD02zVsnepMvjTwTNVgWCBhku2aVcEn2hB/ncgwCOh
	2RX1+U3rIGXpph/gMdYKoHH7dqF0dekmI8tgR26c8yFIkQVFfzBAb4pVPaBGOyKkrVDRpC/kwD1
	tYFjHekGiI9M+DK6fZjhgBKOvSDjfnXf+EhLSHBbqamyEbLuEHr0na7d8lZTpIJCptCAkjfJihp
	lqoX4pY=
X-Received: by 2002:ad4:5765:0:b0:899:f0af:4f51 with SMTP id
 6a1803df08f44-89a669f70femr68515206d6.20.1773282401464; Wed, 11 Mar 2026
 19:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
 <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com> <CANn89iKevHTf+MyJ+4PJ7ZR-+FcRqZiFubeLqRcyZ+gd4LWtsg@mail.gmail.com>
In-Reply-To: <CANn89iKevHTf+MyJ+4PJ7ZR-+FcRqZiFubeLqRcyZ+gd4LWtsg@mail.gmail.com>
From: Guanni Qu <qguanni@gmail.com>
Date: Wed, 11 Mar 2026 19:26:30 -0700
X-Gm-Features: AaiRm52-jlJUojvAkPEmoMgSmzHeW25hcV4hFiUJPZZZFeED16Im-YMzScaJjfo
Message-ID: <CAFzOa14ubmPEmst65Nmtyy3hwtdCYqviv8NNmfXeJ9v5EwwoSA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266852-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 65C5626C322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

Thank you for the review.

You're right that ip4ip6_err() is called under rcu_read_lock()
protection via icmpv6_rcv() -> icmpv6_notify() -> .err_handler, so
the RCU-deferred free via call_rcu_hurry() cannot complete while
we're still in this function. I should not have characterized this
as a use-after-free. It's a use-after-put that is currently safe
due to RCU but violates refcount semantics.

The original discovery used kprobe instrumentation (not KASAN), so
there is no crash stack trace. The call path is:

  icmpv6_rcv()
    rcu_read_lock()
    icmpv6_notify()
      ip4ip6_err()        <-- .err_handler
        ip_rt_put(rt)     <-- drops refcount
        rt->dst.dev       <-- use-after-put
        rt->rt_flags      <-- use-after-put
    rcu_read_unlock()

v2 addresses both issues and adds the Fixes: tag.

Changes since v1:
- Also save rt->dst.dev before ip_rt_put(), as you pointed out
- Reworded commit message: use-after-put, not use-after-free
- Added Fixes: tag
- Removed incorrect Co-developed-by

---

From 96a562ef1b602454841ba770d80fbe6b1eeb3d2b Mon Sep 17 00:00:00 2001
From: Jenny Guanni Qu <qguanni@gmail.com>
Date: Thu, 12 Mar 2026 02:19:24 +0000
Subject: [PATCH v2] ipv6: ip6_tunnel: fix use-after-put in ip4ip6_err()

In ip4ip6_err(), after ip_rt_put(rt) drops the route reference,
both rt->dst.dev and rt->rt_flags are accessed. While this is
currently safe because the function runs under rcu_read_lock()
(via icmpv6_rcv -> icmpv6_notify), accessing a reference-counted
object after dropping its reference violates refcount semantics.

Save both rt->dst.dev and rt->rt_flags into local variables before
calling ip_rt_put(rt).

Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's err_handlers=
")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczad=C5=82o <dawid@vidocsecurity.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b60e13c42bca..2bb9b54015e9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -567,6 +567,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *=
opt,
  u8 rel_type =3D type;
  u8 rel_code =3D code;
  struct rtable *rt;
+ unsigned int rt_flags;
+ struct net_device *rt_dev;
  struct flowi4 fl4;

  err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
@@ -614,11 +616,13 @@ ip4ip6_err(struct sk_buff *skb, struct
inet6_skb_parm *opt,
  if (IS_ERR(rt))
  goto out;

- skb2->dev =3D rt->dst.dev;
+ rt_dev =3D rt->dst.dev;
+ rt_flags =3D rt->rt_flags;
+ skb2->dev =3D rt_dev;
  ip_rt_put(rt);

  /* route "incoming" packet */
- if (rt->rt_flags & RTCF_LOCAL) {
+ if (rt_flags & RTCF_LOCAL) {
  rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
     eiph->daddr, eiph->saddr, 0, 0,
     IPPROTO_IPIP,
--=20
2.34.1

Thanks,
Jenny

On Wed, Mar 11, 2026 at 6:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Mar 12, 2026 at 2:24=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Mar 12, 2026 at 1:47=E2=80=AFAM Guanni Qu <qguanni@gmail.com> w=
rote:
> > >
> > > Hi,
> > >
> > > This vulnerability was discovered by Klaudia Kloc and Dawid Moczad=C5=
=82o
> > > of Vidoc Security Lab using VIDOC tool, and independently validated
> > > and patched by
> > > Jenny Guanni Qu.
> > >
> > >
> > > 1. BUG DESCRIPTION
> > >
> > > In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object returned b=
y
> > > ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt_fla=
gs
> > > is read immediately after the release. This is a use-after-free on a
> > > logically freed object.
> > >
> > >   skb2->dev =3D rt->dst.dev;
> > >   ip_rt_put(rt);              // frees the route
> > >
> > >   /* route "incoming" packet */
> > >   if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read
> > >
> > >
> > > 2. ROOT CAUSE
> > >
> > > File: net/ipv6/ip6_tunnel.c
> > > Function: ip4ip6_err()
> > >
> > > ip_rt_put() calls dst_release(), which schedules destruction via
> > > call_rcu_hurry(). The rt->rt_flags read happens in the same function
> > > context before any RCU grace period can elapse, so the memory is stil=
l
> > > accessible but the object is logically freed.
> > >
> > > Note: KASAN does not detect this because the RCU-deferred free has no=
t
> > > completed by the time rt_flags is read. The memory is not yet poisone=
d.
> > >
> > >
> > > 3. AFFECTED VERSIONS
> > >
> > > - Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrumenta=
tion)
> > > - Source-level analysis confirms the bug on 6.12.0 (arm64)
> > > - The put-then-use pattern has no fix in HEAD as of v6.12
> > > - Architecture-independent (logic bug)
> > >
> > >
> > > 4. EVIDENCE
> > >
> > > Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/40
> > > path hits where the same rt pointer value is observed both before and
> > > after ip_rt_put():
> > >
> > >   vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
> > >   vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0
> > >
> > > All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunnel
> > > endpoint hit the vulnerable path every time.
> > >
> > >
> > > 5. TRIGGER
> > >
> > > Send ICMPv6 Destination Unreachable (code 3) packets to a configured
> > > ipip6 tunnel endpoint.
> > >
> > >   from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
> > >   inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4) / =
\
> > >           IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
> > >   pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=3D3=
) / inner
> > >   send(pkt)
> > >
> > > Requirements:
> > > - ipip6 tunnel configured (ip6_tunnel module or built-in)
> > > - Ability to send ICMPv6 packets to the tunnel endpoint
> > >
> > >
> > > 6. IMPACT
> > >
> > > - Use-after-free read on a route object (struct rtable)
> > > - Under normal conditions: reads stale but valid memory (RCU protects
> > >   the actual free). Behavior is correct by accident.
> > > - Under memory pressure or with KASAN slab quarantine: could read
> > >   corrupted data, leading to incorrect routing decisions or crash
> > > - Exploitability: low in practice due to RCU grace period, but the
> > >   code is formally incorrect and violates memory safety
> > >
> > >
> > > 7. FIX
> > >
> > > Save rt->rt_flags into a local variable before calling ip_rt_put(rt).
> > >
> > > Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecurity=
.com>
> > > Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vidocsec=
urity.com>
> > > Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > > ---
> > >  net/ipv6/ip6_tunnel.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > > index b60e13c42bca..857a7ff8a041 100644
> > > --- a/net/ipv6/ip6_tunnel.c
> > > +++ b/net/ipv6/ip6_tunnel.c
> > > @@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_=
parm *opt,
> > >   u8 rel_type =3D type;
> > >   u8 rel_code =3D code;
> > >   struct rtable *rt;
> > > + unsigned int rt_flags;
> > >   struct flowi4 fl4;
> > >
> > >   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> > > @@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> > > inet6_skb_parm *opt,
> > >   goto out;
> > >
> > >   skb2->dev =3D rt->dst.dev;
> > > + rt_flags =3D rt->rt_flags;
> > >   ip_rt_put(rt);
> > >
> > >   /* route "incoming" packet */
> > > - if (rt->rt_flags & RTCF_LOCAL) {
> > > + if (rt_flags & RTCF_LOCAL) {
> > >   rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
> > >      eiph->daddr, eiph->saddr, 0, 0,
> > >      IPPROTO_IPIP,
> > > --
> > > 2.34.1
> > >
> > >
> >
> > ip4ip6_err() is supposed to be called under rcu_read_lock() protection.
> > call_rcu() and call_rcu_hurry() should not proceed until this thread
> > has reached rcu_read_unlock().
> >
> > Can you share the stack trace so that we can root cause the issue ?
> >
> > Your fix is not complete, because we latch rt->dst.dev into skb2->dev
> >
> > skb2->dev =3D rt->dst.dev;
> >
> > So the device could also disappear, and UAF would also happen.
>
> Also you forgot to include a Fixes: tag
>
> This is crucial for any patch targetting net tree.
>
> Thank you.

