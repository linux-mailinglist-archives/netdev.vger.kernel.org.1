Return-Path: <netdev+bounces-266827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F0tBEMWsmkiIgAAu9opvQ
	(envelope-from <netdev+bounces-266827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:26:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08A26BEF3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F1FD3033205
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFE34888F;
	Thu, 12 Mar 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcUU0xmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A683264F1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278695; cv=pass; b=Zs3U8n3e72KwP4ZUR9Mz0VTzNQKJVSf3bSMdp3VLPTJUV69KlmMi7fvcSYqTGo7FzII8i/ctqF5PVxbEuiei/cYlYX+hn6Nb3/NcJQztSH8rizXGbDU4aYXf8BnZxp0Jy3v4g6HBoiylAcgYEa+DMqHqBqR169JYw38Y2hObu8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278695; c=relaxed/simple;
	bh=Mjtg/R+C/rKH28UFPc1Eb7oXDL2SyQO7djbBZ1JPdt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9CZ+fL/QkWBH/pTJKuRRr6VMY+DADrrWkN80qjbOTwSEDwaGiE6EsCmZL1nFxfCDkNLAZpgIMq8+bJ1pkx3N84SXDLbRHbGPKITOtmcVQfAZUTr85lnuYndnWwZnvIWUAic6rb0Ll6DRapH0WDLsNoIbDlp/MTtsvd9BZQAlqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcUU0xmA; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a07f66f4eso5824306d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773278693; cv=none;
        d=google.com; s=arc-20240605;
        b=QNV316ajYXKjshMgSPcC2Ut/Miwa6kSknj+2pLgTcUYYoSvspwLHDgOEnCHNIdjjH9
         ukPwexFFFSen4pn4aNQJhoLXwqyJS9vkJuf6wxMV6ABWuZTUhM31nBe+kbkwBpT7PUDp
         b24I097K+eZtwUnpIBAxEz+mVfRS5tvopbuMkZ9TMjtCrR1xMT6B6rUU4BtSvOoNv2VU
         ukxALgY89ekfCFSU39H+RboNdjNTfR/evA9GAeZ3k3VUkvIYVOXXb8MdOsf2Tir/ZxtH
         WL4em2hNP/XLwEbBMyx85un8iJ16EFVbtakuktrTkFziDfGwhasEtOAxazIPJnn0+9yr
         YOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J565lgslpmA1Y4hs4Zgv9VSKrhq9S5YcNR91nadtpAU=;
        fh=aFaLzrRfN1R74H7Jat4PIIqQu8SGdDE43SUWvANGDyg=;
        b=WmRZJLzfyQWW2G6w3HbFPsB6hcTsL4WwpvF46M+SzigqCAx6AKkqbAUBPZJnex95WH
         QCDX+X2XL7E5L+3qMT/vx7+DwQeCOYa0HCcUActIABEsw5QG7o/W/8hkXXGIK8auji9U
         YWPrMNXdECItlzBWu1noCCyW5yeEqUBPBWbmOBjushtAK7KVWQz0fb5Tg6t9vLLWsmzJ
         IxUfWtmptp9wOs2lbYJl9tC23oZUWwVkXVIrbK94HyJVFy061voX4YdFS7c2mv3VCtEx
         HDiVuK/1jw/VpTSm7nWzpvgA3jkaCYhQwt0mq0v0hMH0xfJ6mLAKsRdT+C2cEeyurxt1
         Smvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773278693; x=1773883493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J565lgslpmA1Y4hs4Zgv9VSKrhq9S5YcNR91nadtpAU=;
        b=fcUU0xmAmRYLbzl6+/CgY7yXFoncuIrqH8887Hpxj2ZAMlwcSXUgvJcGNiC8jNzP9U
         4MxVtkuFL68oPXQfMHjsI9MkUE7bSNQQhBOHgyhzt/HR78GJjQJsAXlhsSf3ZyQP/DyV
         Xf+l17VaDDTYlSVjJKDnICCPJsjSyk410tvSCDCGbCHp3yH465BUUKnctnzhxODMQV25
         8plQ6dwazT4JcF8EIKgsm3baVMlGQ2JMVDweiUZz2QSStKqEnU8tnS3onvR3E6Lm8IuS
         bz4ehDBMoNy4oTHa6xL49VjDQKA61tVECY2GnrG5A5XVlMBTUe5rRI1WkgI5/mN9OR14
         yvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773278693; x=1773883493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J565lgslpmA1Y4hs4Zgv9VSKrhq9S5YcNR91nadtpAU=;
        b=Azj/yrxdSss+etq+sjMDiLf6opHJYyGLtvEpwe256tFVGgaYEQtFhIUgTmyhrZ2EiU
         hbT2htf6vs2dKyc1p+CNzvKc2iUPDi9j56nA0xeiLCinwT1wrkBYbewo1flK0ln5UXW1
         X9PTbZGLGzPfsFvd+yPm4IvGOSbTGIhCKPCTQ4Xg84idxCmYERM/rBYn/XAE4czqALRk
         Omo403AakELcpsumc17+vDMMfCEs8fSY9gQ281ZSOXmo2JrQmV3LGHk31XYlsYtJEkYv
         mOJLZXZcYI98TJK8ofAiPex4BgwqJ5Gxgn5Zk7fZXGbTY62OCl0083UtnECdNQeoR8C/
         AeUg==
X-Gm-Message-State: AOJu0YwWeGGeuFbOA4axY5Sqr2dCf2PWEjSxozG2LZLaS6MyRF/+d4Hb
	l5unPa8e4h58Gr07TL80h+sdOCnbNr/OUEREA+FbZm5p2uQyN4XyMs2hPucRN0oGkAEKVZVRQGk
	VEDUGJ7vyYDDcKLlVpJqIYKcwjZlT2w/TvuEG+0hxVGvSSaUK7mknmx4KyN0=
X-Gm-Gg: ATEYQzzJ3q8InS04gdN/poGqDShXiGI+wnyH6dLAuSpSN1tcHQtPVgLK7oyuzOpT67l
	15tz8GKJL3soGWXL3/Y4Rw6HDNU/XWrrH5oe6Dt3Cg5Q+RCAmiDjZsUgelqOvxRL4nfreDSkwt7
	zUr0ffQYEPe7ZYonAi4Mm9neJI9aU3ar/4UlLrxaZNWi3ZOZB6dw1ApywTR4+1v7c85Y1bKK1vL
	g1V6QNDh9ejRSivOg21t/Fldjr77oclnYw8JkTFIx0/p2wYNnJK4lg3fqM3mPoS8P6EU66U9LvF
	DtZe9+Y=
X-Received: by 2002:ad4:5e8c:0:b0:899:e6c1:e730 with SMTP id
 6a1803df08f44-89a66ac2a44mr66475256d6.54.1773278692972; Wed, 11 Mar 2026
 18:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
In-Reply-To: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:24:41 +0100
X-Gm-Features: AaiRm51rTAhSagL3L1ECH7lPWDDXrHLvO9SkFUhWS-VOPq1r0YtccnqZi7M03EU
Message-ID: <CANn89iKBxREGEgFatAcFLb+PiHUtgMKUJ5u+Tm9-SD0OKh29tw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266827-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vidocsecurity.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7B08A26BEF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:47=E2=80=AFAM Guanni Qu <qguanni@gmail.com> wrote=
:
>
> Hi,
>
> This vulnerability was discovered by Klaudia Kloc and Dawid Moczad=C5=82o
> of Vidoc Security Lab using VIDOC tool, and independently validated
> and patched by
> Jenny Guanni Qu.
>
>
> 1. BUG DESCRIPTION
>
> In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object returned by
> ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt_flags
> is read immediately after the release. This is a use-after-free on a
> logically freed object.
>
>   skb2->dev =3D rt->dst.dev;
>   ip_rt_put(rt);              // frees the route
>
>   /* route "incoming" packet */
>   if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read
>
>
> 2. ROOT CAUSE
>
> File: net/ipv6/ip6_tunnel.c
> Function: ip4ip6_err()
>
> ip_rt_put() calls dst_release(), which schedules destruction via
> call_rcu_hurry(). The rt->rt_flags read happens in the same function
> context before any RCU grace period can elapse, so the memory is still
> accessible but the object is logically freed.
>
> Note: KASAN does not detect this because the RCU-deferred free has not
> completed by the time rt_flags is read. The memory is not yet poisoned.
>
>
> 3. AFFECTED VERSIONS
>
> - Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrumentation=
)
> - Source-level analysis confirms the bug on 6.12.0 (arm64)
> - The put-then-use pattern has no fix in HEAD as of v6.12
> - Architecture-independent (logic bug)
>
>
> 4. EVIDENCE
>
> Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/40
> path hits where the same rt pointer value is observed both before and
> after ip_rt_put():
>
>   vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
>   vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0
>
> All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunnel
> endpoint hit the vulnerable path every time.
>
>
> 5. TRIGGER
>
> Send ICMPv6 Destination Unreachable (code 3) packets to a configured
> ipip6 tunnel endpoint.
>
>   from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
>   inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4) / \
>           IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
>   pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=3D3) / =
inner
>   send(pkt)
>
> Requirements:
> - ipip6 tunnel configured (ip6_tunnel module or built-in)
> - Ability to send ICMPv6 packets to the tunnel endpoint
>
>
> 6. IMPACT
>
> - Use-after-free read on a route object (struct rtable)
> - Under normal conditions: reads stale but valid memory (RCU protects
>   the actual free). Behavior is correct by accident.
> - Under memory pressure or with KASAN slab quarantine: could read
>   corrupted data, leading to incorrect routing decisions or crash
> - Exploitability: low in practice due to RCU grace period, but the
>   code is formally incorrect and violates memory safety
>
>
> 7. FIX
>
> Save rt->rt_flags into a local variable before calling ip_rt_put(rt).
>
> Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecurity.com=
>
> Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vidocsecurit=
y.com>
> Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>  net/ipv6/ip6_tunnel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index b60e13c42bca..857a7ff8a041 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>   u8 rel_type =3D type;
>   u8 rel_code =3D code;
>   struct rtable *rt;
> + unsigned int rt_flags;
>   struct flowi4 fl4;
>
>   err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
> @@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
> inet6_skb_parm *opt,
>   goto out;
>
>   skb2->dev =3D rt->dst.dev;
> + rt_flags =3D rt->rt_flags;
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
>

ip4ip6_err() is supposed to be called under rcu_read_lock() protection.
call_rcu() and call_rcu_hurry() should not proceed until this thread
has reached rcu_read_unlock().

Can you share the stack trace so that we can root cause the issue ?

Your fix is not complete, because we latch rt->dst.dev into skb2->dev

skb2->dev =3D rt->dst.dev;

So the device could also disappear, and UAF would also happen.

