Return-Path: <netdev+bounces-266829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DiqvC7cXsml9IgAAu9opvQ
	(envelope-from <netdev+bounces-266829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:32:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB926BF34
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF190301186B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD33382E8;
	Thu, 12 Mar 2026 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yf4aHP3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A1E573
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279154; cv=pass; b=GqeKSdgCnXmXKc86dm9EDyTDSGj6N+UHgfGkonty2axXUwvnVNTzFej9oFjrmv73ORXORk7EXm3GJTH53F1Vdok+Joxv8wN8Y8I9JKvA1zVKGrLAtO/3tpm6UsApktyGI4taG3Fdxc9F9pMjGcImis5nnKukxvNKXZFSHCopMVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279154; c=relaxed/simple;
	bh=y9uu7FcX/KxUjrUSZiND35L3q0YMiAGZBRoGZTxrt+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6F+/AM4AWfLh1F0R42H8o+gGIgACrII2fiR3v3RnNSOde+tGk06H7zgIwS3lxS0jnp+ikm3LgZQGGklrCn04CiNsUdgPZ9rBfTNoD5McqN7DUKUIizMJzobeEKLJfdV0JOZd4YZ8utZXrctfZbmzQfmN/JX+OQI200VHTFcEAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yf4aHP3E; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899fc9853b7so6626276d6.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773279152; cv=none;
        d=google.com; s=arc-20240605;
        b=S1jQ2xCG0OMLC8QU8jjwGXLNhcrfj+/xHcFFZtyNTkzTD0032n1eDWOgvCSx/7KgI8
         iWdNA3pQVuMi2ln2b4EkJa/gviC7RAuqVvW/JVBDRk3h+Harf+Go3pedjdQ0Wz6+jmPH
         Ws1p6Ovk/hB9x3ENIOCzeuX2Kusy/h0XRYwVJ8kJCpJVSoAEAbchnvkmp/cNsLLCJ2ZC
         7goixxh2bvpAbnuMTzgkLzSAHl11ECeF4+yX6BKuQ+u2hSXcvZIRtDbgj/eXznerYPjL
         9RvRpNwNsKROXBjPM21aUHrenrv0H7qxbDUl/wLAlTSuSYwKVin4UfPbgnffYeTYBZKw
         PJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rkYFJbOUU313ISgdC9ZMKNJi4gSionYq1nRxXskUCI=;
        fh=aFaLzrRfN1R74H7Jat4PIIqQu8SGdDE43SUWvANGDyg=;
        b=kIRoTEcnJkgehrVtZkQIesVziF+e6WUr6GqmeT5KmRNwgmKfoa6MsMdw14kqU1cMR/
         4eUVwqQqmf+Tobmvf4lhuSzZbjfjkHja3tlWPwGv6EC9vIZT6fdKRed/NT1thDCCsePm
         BxwqQNas5Z0+sIUp572pOiB8l5nWikhGgJBQq0Zxktk/1xNLrWRsP8aBurjTiKlNDJM+
         XQJbQdIerJeqOIeG0Jea8KHu+fo9bENkC01UazDw2vgJie9GPxfyyhCXt3DmQ6HnuL5e
         zjYtlfEkVNh9dcPokOXXXpegpEEeTpzFXvORaaJDA6ltUp+HUcsCRxF6DL4BypKj4+D+
         yjAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773279152; x=1773883952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rkYFJbOUU313ISgdC9ZMKNJi4gSionYq1nRxXskUCI=;
        b=yf4aHP3EoRYm11yoiqE6828AMtt7jBkZw/qFdY623ctCw4bI4OdQ5qvBQGxhQ7RFXw
         x57fQLXV/hqMLK+42v0GHtNHbrRTtRmln3/cGdH1yPb9Yoiys8kEIakTWelqApi2Z6iZ
         3N2p9ZspGKsc6SklyRMa+x7CVE/EWfoD1IVZuumnSAg0z/Ck4LGcZsN4WNRjKHpJsSuL
         8PCLT40e15rXNorWLM53lyIsjxQUyqADXIkGUE/8j5ketiqQv2rQm3cwJD4BJiyRO8vw
         tsP7bCrSyAm4ALtA4e3DRcwUbvgurxNZEX+psZ3eg5R8qyQ6JVK5XxIKX/zwPxJn0td/
         aGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773279152; x=1773883952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rkYFJbOUU313ISgdC9ZMKNJi4gSionYq1nRxXskUCI=;
        b=eg2//L9nu0E6UB+DaGSKM+yrgzQzoIKe/LyOO+Srvtc3VoVa1Hi0CRcLlNfusNTAtN
         PjckOlxLvf9aYy247/9kKDcuCG+ojhIGl7wFiyzzjinPcMvyiUKuwohS+RdbFP78VBCN
         fkEIAGterSHqOovIfJ9kTkTWnlbJTNgRA9WqLCXb6jzGbtM34sGLixnjzuUHvgGz1zuT
         gzcO4Z0mF1VIggCJ2K96BQ0JUKKig8XSVr5o1YTKlJHzvcEcmNmc9F0fRHnbAeJykZuK
         iQmpf7c0CjaPWGTSAnpulyY6C1a3DV+YrzatbxLXRulsovTwDFNPAd6gX0NBgP3n7TP1
         /ljw==
X-Gm-Message-State: AOJu0YwwOwggzf1qdp/DZ20Yk8EMhJEwTfdgSd7zvTVz9MSWJNERF1eQ
	RVZOaNxCg6UKHZpnZffkUhT8KZcfCs+YTHQKtuCmiAlZubroJet0UWfgghaKF2a+YG3SOQJAVut
	ph4PdaEh2kQIpNKvvdqRwjsCd82Jm8qRyfKD+bE7o
X-Gm-Gg: ATEYQzyCGrYctrBfcoczzan2ni3HictcRwK2SI+LI/AYwr6hRDc0FQyJMGlAHRxxg/c
	1KYhlz1NGurXWvs/++YVCk6tdTBM1KpMbfKDD/gKzyPvj0ya6Eh4CVjSDnakfUjgXz8fm3WDyNV
	QqiXo7zxZGY144pdUH91j1RO431FlnMN3sKRHa8OXRaqIQAJOgOPyy0xrwT9QEF62DjZgdXkL+K
	azqWT35fi7nzdfkwFXeHOk5GNvKGzNo/CRrCIUcy3NPG+cJsUzEj58i16py+YL9iDebxGvllY61
	D7DrGF0=
X-Received: by 2002:a05:6214:1bc5:b0:899:e621:eac8 with SMTP id
 6a1803df08f44-89a66a7a9a9mr63657196d6.39.1773279151761; Wed, 11 Mar 2026
 18:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
 <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com>
In-Reply-To: <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:32:20 +0100
X-Gm-Features: AaiRm52quo5Qh_3a-Tim6Z_I1EMVk7PFjMS57hI0QMFF6lvT-cuVb59NrwxGqQo
Message-ID: <CANn89iKevHTf+MyJ+4PJ7ZR-+FcRqZiFubeLqRcyZ+gd4LWtsg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266829-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vidocsecurity.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4DDB926BF34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 2:24=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Mar 12, 2026 at 1:47=E2=80=AFAM Guanni Qu <qguanni@gmail.com> wro=
te:
> >
> > Hi,
> >
> > This vulnerability was discovered by Klaudia Kloc and Dawid Moczad=C5=
=82o
> > of Vidoc Security Lab using VIDOC tool, and independently validated
> > and patched by
> > Jenny Guanni Qu.
> >
> >
> > 1. BUG DESCRIPTION
> >
> > In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object returned by
> > ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt_flags
> > is read immediately after the release. This is a use-after-free on a
> > logically freed object.
> >
> >   skb2->dev =3D rt->dst.dev;
> >   ip_rt_put(rt);              // frees the route
> >
> >   /* route "incoming" packet */
> >   if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read
> >
> >
> > 2. ROOT CAUSE
> >
> > File: net/ipv6/ip6_tunnel.c
> > Function: ip4ip6_err()
> >
> > ip_rt_put() calls dst_release(), which schedules destruction via
> > call_rcu_hurry(). The rt->rt_flags read happens in the same function
> > context before any RCU grace period can elapse, so the memory is still
> > accessible but the object is logically freed.
> >
> > Note: KASAN does not detect this because the RCU-deferred free has not
> > completed by the time rt_flags is read. The memory is not yet poisoned.
> >
> >
> > 3. AFFECTED VERSIONS
> >
> > - Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrumentati=
on)
> > - Source-level analysis confirms the bug on 6.12.0 (arm64)
> > - The put-then-use pattern has no fix in HEAD as of v6.12
> > - Architecture-independent (logic bug)
> >
> >
> > 4. EVIDENCE
> >
> > Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/40
> > path hits where the same rt pointer value is observed both before and
> > after ip_rt_put():
> >
> >   vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
> >   vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0
> >
> > All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunnel
> > endpoint hit the vulnerable path every time.
> >
> >
> > 5. TRIGGER
> >
> > Send ICMPv6 Destination Unreachable (code 3) packets to a configured
> > ipip6 tunnel endpoint.
> >
> >   from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
> >   inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4) / \
> >           IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
> >   pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=3D3) =
/ inner
> >   send(pkt)
> >
> > Requirements:
> > - ipip6 tunnel configured (ip6_tunnel module or built-in)
> > - Ability to send ICMPv6 packets to the tunnel endpoint
> >
> >
> > 6. IMPACT
> >
> > - Use-after-free read on a route object (struct rtable)
> > - Under normal conditions: reads stale but valid memory (RCU protects
> >   the actual free). Behavior is correct by accident.
> > - Under memory pressure or with KASAN slab quarantine: could read
> >   corrupted data, leading to incorrect routing decisions or crash
> > - Exploitability: low in practice due to RCU grace period, but the
> >   code is formally incorrect and violates memory safety
> >
> >
> > 7. FIX
> >
> > Save rt->rt_flags into a local variable before calling ip_rt_put(rt).
> >
> > Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecurity.c=
om>
> > Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vidocsecur=
ity.com>
> > Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
> > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > ---
> >  net/ipv6/ip6_tunnel.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> > index b60e13c42bca..857a7ff8a041 100644
> > --- a/net/ipv6/ip6_tunnel.c
> > +++ b/net/ipv6/ip6_tunnel.c
> > @@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_pa=
rm *opt,
> >   u8 rel_type =3D type;
> >   u8 rel_code =3D code;
> >   struct rtable *rt;
> > + unsigned int rt_flags;
> >   struct flowi4 fl4;
> >
> >   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> > @@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> > inet6_skb_parm *opt,
> >   goto out;
> >
> >   skb2->dev =3D rt->dst.dev;
> > + rt_flags =3D rt->rt_flags;
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
> >
>
> ip4ip6_err() is supposed to be called under rcu_read_lock() protection.
> call_rcu() and call_rcu_hurry() should not proceed until this thread
> has reached rcu_read_unlock().
>
> Can you share the stack trace so that we can root cause the issue ?
>
> Your fix is not complete, because we latch rt->dst.dev into skb2->dev
>
> skb2->dev =3D rt->dst.dev;
>
> So the device could also disappear, and UAF would also happen.

Also you forgot to include a Fixes: tag

This is crucial for any patch targetting net tree.

Thank you.

