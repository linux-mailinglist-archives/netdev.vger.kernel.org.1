Return-Path: <netdev+bounces-266238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F4SKg1EsGlLhgIAu9opvQ
	(envelope-from <netdev+bounces-266238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E309254772
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A292230087EB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698A3B6349;
	Tue, 10 Mar 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nt6MuXzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602C33B6FB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159435; cv=pass; b=Akm8d/9s0xEz9Y64+c/1eA4MG29EcK+OCWE5nu7/FSe4Z/V0k08CW3SYOP6TH74va+/M+UQ2UrrPbkn0QklkRh3ES5PMJMOfpg/R/hxmm6pakkpAAYNJ3BFlxnko38vTCFMqf5WAvtFGwfr6wH062xDvc4fwRHmAtkL3EkGNDFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159435; c=relaxed/simple;
	bh=jA6rZpVYq5bMHBbyJsUtaFneg2H8srjFU0y02ik2O58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkKJ7bzth2cYOl1F0MWcIgb1way8dp32Ie3Rkg0MsmR38V7RWP2Zhb7WmAd96+o+Jef8T7fyyO0hPDTqwl7auSRLoWy1sEHclsslQTTevWGoKgXAsVwlxCPESEYKwIlve3YqdgZz0YL3nttERAxcX001yym+q9zQFmuAyuwgCzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nt6MuXzr; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732e6a123so158687c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773159433; cv=none;
        d=google.com; s=arc-20240605;
        b=BYb2yvJi6doGhmfZw3jek9nNDvyPeDWr/H41fbdF4Wy7PJwA18rUixQHCJp3uX+lf/
         G0A3Zcoj/UlD8MPnXMDWTcVKln7cecDwfElivtrJt2aY+Mg/ac4sLxejPAw4Gg7fBUri
         F3FhyKGFJt1cyKLPBUEplKAo7d7kB+9kU3pnnKWU6tH+YKYsaKf25vwC3FHTruptQfRU
         znHNQ9LsxrYQNW0Nu2ocbzxm3nIu882fx/xdYtU3Ci6iJO60TPjIRTD5aVAUrTSeG3JL
         XMEirpjz0T6LA56OLmoM/6I6yXx0BB6zqhoY/gTiw8QgwMNwSe8WYyT85c4qfSLm/dL7
         gTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        fh=lQGSSK3tCbQRvMxeE0GzfOZF776eD592TQhFxrAF1aE=;
        b=PhWmJuM580tsR8EUHMgkIN4Iar2J9gO/XFn19dDtSSvH/mxxuBce+C6bN3k8S2J9pa
         xzBOe8X5XUjWwn71AKzuzahEzRwWV0BgrIH728PLHr+Tv11TPnjiHX2cguVb1C/hjh4v
         q3R3iakA3lITBr8q4DH8swF5uiPNiIGg3iXu+99KEuPeDMERtsvnRlq250zswbrZkDZT
         BdPgUdgSpKwe1vW1QiokkGt1DHIWtS63Jgi1EXFyu6msofj5m6f4J6GURkvuWrJv1V1M
         u2oYltS+EJs2IUZXajDmoi8CbWLZmZKgWRt64ajJTJ/9CsCyIW5mHYlEd1eGAdjN13CA
         CqUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773159433; x=1773764233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        b=nt6MuXzr286FIiSrIMGxLGbt7guPQk7TSxPDrNJksGZ6CeCoBowNH63Ns1pxmVr0T0
         F5dp3EqsapITnuZlj6wycFDGBOD/NCIDFrKuLxU6UStdvVH43+k7tGsqr2ci57508Xid
         qNhd/sqcAhAgbr+rzJ7n3yjiiIvqi0LBDhTeJZPXj/gVMdYP+KgrHc9Giq9M9JwTeBRT
         FgdNWHnXIME7KmgGCafArEdd7Nw27JVaUstvMoUgJhbulMtdS2EC5LSMtsd3s+73GG51
         DAsHTega9VjVSs086SNzot86R5VLg8QXy6fWoQ7vmP7StoUB2JrKD7/ly8vbdIzP9EyU
         nfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773159433; x=1773764233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBoK0ILVDset3KJAMLm9VclkZQJwqYX+/JNYcMjkA+0=;
        b=ieck2/Q8+ClBU0Z1frtP897rMKWaMENQPBpIsYBDVTuIaZG4j8jalVueSq4xtSeGjB
         OUpi1cS3xKs9Bs5TUmYiHlRLNkUZ51ruJu/cZ6r3jtHVRCtI7CTDwmRda3JIaYJahSJh
         Ir+efwoqQOFdtnlfu3TNcA3a8yjPfaXwe6jcK/QTHdf5kKKZebfwwD1ivnX0d8v8MD/n
         ijl+cqHhxSgyRrWBILMpx4UJGpTe1IclevmOc0MyqfkTbtdIbbfLeKxU3oeptSfTRRP4
         zE+TGF8/j/UX/cXeMhWgoev9HfYUojBdrjWgU6PuuP+f7920US1zR5r4QOBglGmGfjU2
         12fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTzCPVf3em8toXuYP29BV7k/opXSGsICIgv6UTb4P8ouVfHXkJ7zkYGoHZQCtkGR+n6+/VBaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrmh/qA28VixDhfzZB6PVWpiTI7o+JTaiWSWqs1RcebWxcgtQE
	40pvEjFVrH4mj5su23J2D1XZ97OkEm70H1R7RDyOsdKakjpA0pxmWs3HDfwDledzJctrr/miAKX
	8/4GthDhCabdxP7GDxzoiPgd3aD/11MuAyTzqsVeu
X-Gm-Gg: ATEYQzzfQ8KG7IOT/qfQLmq00ZmfMPMSveRfxlpSRaJXq21CfdKJBexJRXhwvhCYNdY
	W3I8nlLo7ZD/Dt5alx+hrNvPH+/WjBTqIjHCHjzQzvVk678jzOGfANa6UvssxRvF53OjC8uMfEG
	MVldF5VvjJumRGzsxDuld0PKHX5l/3AUnMCHbpwZYQTrSQV07Ah4fM5/ylnHB6P8eamDXuWx/8o
	QBfzCJvC1METY445BZ2Tv2XpUyNprRu5nMAsv/DaPYZWuXZ7QzTEkSriulLHFHfF9F89wANRSxg
	MpHgKUjGcMlN+LtN/6LDIM81vSItrhuOesHMV5QcQDdo/uZ1ib3WMKe8edcqdFGNX6hyUHY=
X-Received: by 2002:a05:7022:217:b0:119:e569:fbb4 with SMTP id
 a92af1059eb24-128c2ec2f69mr7177147c88.35.1773159432496; Tue, 10 Mar 2026
 09:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305215013.2984628-8-kuniyu@google.com> <20260310102555.147680-1-pabeni@redhat.com>
In-Reply-To: <20260310102555.147680-1-pabeni@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 09:17:01 -0700
X-Gm-Features: AaiRm52tVbsRFsnhdR1wCpfFj-wF1scdUVu4b0pjKpsyTNEAQqRKS-aRJ3EETZM
Message-ID: <CAAVpQUB-pC_LLJhMR2iNevZtkhf1V3xFD9ycthW2bqKQ0TF9fw@mail.gmail.com>
Subject: Re: [v2,net-next,07/15] udp: Remove partial csum code in RX.
To: Paolo Abeni <pabeni@redhat.com>
Cc: willemb@google.com, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	jmorris@namei.org, casey@schaufler-ca.com, paul@paul-moore.com, 
	kuni1840@gmail.com, fw@strlen.de, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3E309254772
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[google.com,hallyn.com,vger.kernel.org,davemloft.net,kernel.org,namei.org,schaufler-ca.com,paul-moore.com,gmail.com,strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> udp: Remove partial csum code in RX.
>
> This commit removes UDP-Lite specific partial checksum handling from UDP
> receive paths, including removal of UDP_SKB_CB fields, simplification of
> checksum initialization functions, and elimination of UDP-Lite guards.
>
> Link: https://lore.kernel.org/netdev/20260305215013.2984628-8-kuniyu@goog=
le.com/
>
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
>
> [ ... ]
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
>
> [ ... ]
>
> > @@ -2703,14 +2647,15 @@ static int __udp4_lib_rcv(struct sk_buff *skb, =
struct udp_table *udptable,
> >       if (ulen > skb->len)
> >               goto short_packet;
> >
> > -     if (proto =3D=3D IPPROTO_UDP) {
> > -             /* UDP validates ulen. */
> > -             if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
> > +     /* UDP validates ulen. */
> > +     if (ulen < sizeof(*uh)) {
> > +             if (pskb_trim_rcsum(skb, ulen))
> >                       goto short_packet;
> > +
> >               uh =3D udp_hdr(skb);
> >       }
> >
> > -     if (udp4_csum_init(skb, uh, proto))
> > +     if (udp4_csum_init(skb, uh))
> >               goto csum_error;
> >
>
> Does this refactoring introduce two bugs?
>
> The old code checked both conditions with short-circuit OR:
>   if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
>       goto short_packet;
>
> This correctly (1) rejected packets where ulen < 8, and (2) trimmed the
> SKB to the declared UDP length when ulen < skb->len.
>
> The new code changes the logic structure:
>   if (ulen < sizeof(*uh)) {
>       if (pskb_trim_rcsum(skb, ulen))
>           goto short_packet;
>       uh =3D udp_hdr(skb);
>   }
>
> First potential bug: When sizeof(*uh) <=3D ulen < skb->len, the entire bl=
ock
> is skipped. This means pskb_trim_rcsum() is never called, so the SKB
> retains trailing data beyond the declared UDP length. Won't this cause
> checksum calculations to include extraneous bytes, leading to valid packe=
ts
> being incorrectly rejected?
>
> This scenario occurs when UDP length < IP payload length, which can happe=
n
> with malformed or crafted packets.
>
> Second potential bug: When ulen < sizeof(*uh), the old code would
> immediately goto short_packet via the || short-circuit. The new code ente=
rs
> the block and tries to trim the SKB to a sub-header-size length. If
> pskb_trim_rcsum() succeeds, processing continues with skb->len <
> sizeof(struct udphdr). Is this safe?
>
> Looking at the IPv6 counterpart __udp6_lib_rcv(), it handles this
> differently:
>
>   if (ulen < sizeof(*uh))
>       goto short_packet;
>
>   if (ulen < skb->len) {
>       if (pskb_trim_rcsum(skb, ulen))
>           goto short_packet;
>       saddr =3D &ipv6_hdr(skb)->saddr;
>       daddr =3D &ipv6_hdr(skb)->daddr;
>       uh =3D udp_hdr(skb);
>   }
>
> Should the IPv4 code follow the same pattern, or should it preserve the
> original short-circuit logic:

Indeed, I'll follow the IPv6 pattern there.

Thanks !

