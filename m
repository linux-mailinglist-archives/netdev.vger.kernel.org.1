Return-Path: <netdev+bounces-280842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFcsITFq6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9884563B0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 500AE300B9CF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407036C9CB;
	Thu, 23 Apr 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nt9Pez8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3026E6F3
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970286; cv=pass; b=Kq+TxNtMF46jgEKkUNXXMjWu0tDxyHH2ArMf81UnPHx/osGklxgYScK+qBm47yi4gmdmEE53txC+OIcDRSb83zyigE32JErCOrHAmgwyCCE/sIvwmxL5KcHHD4ufpCEtaq+XGiu34CDu3he+/Qs5qFPjEEnGfDhunrN7kTmjOSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970286; c=relaxed/simple;
	bh=0GZR/5Ap41PfEx9zoatbMX2tpDEJVOh48RIrv/UmJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Uq7YndzAhlhmSwpf4Nb6/1t8gmXVCiJbKETq2VckDd1dstlawKnF53dblRPImL8wg7vGPsJbdTtX1EbjuI/HJlsKFOjF2fMs1cYjSgWIQCoPnE55wLqn3dLpdBhR9KbvRK+F5BbymayNQkW4eE3Kb+JxZSmjfnVfBQXd4SJ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nt9Pez8N; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1279eced0b9so10488731c88.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 11:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970284; cv=none;
        d=google.com; s=arc-20240605;
        b=OE2sz5PP5WdDUKa/R+Uo5tBEsfEjzEcnPUETdfIfYVqpjHy2Ka0xr3Z1Bxi1uaIK4C
         CRMiaaks6QWzsZQzWCNMMNFEt0pirEEzRZo72nmRc3aLlLiRQwCpgBrTwDcRmDaBDB5l
         /2RbXPZ3YZvCS4mpQimRG9F0sdv3jtaypj5/3OcfoI0PldV7wZBEvto7g3/ms4lOks23
         Q9mztrASu9hImCdhKzyyV922aEIj/ZWujOwYUR5MItLbbNx00MhE9zmn5gPPz9tIRtdo
         VPscI8OIyonoAvAHpkSzJDz/WigcVMf4nPE79Bsxu2Mk88N/x6gr9mKvDrvtAm/IYn+M
         6HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLSsMLz6/iZL3g93nUiAhy7oSyYv4b0L7cJWV3CiODA=;
        fh=WFv1ruutvmQPDYzxHqaz5UuQlAurbiBlupcXWdFHbtc=;
        b=aAyAL6915G3X8cLk6qfk9unsdsHXb9KEDbHn+Z8bDvb1bRsNlvo4NHop7JPQYP6xB3
         odL+/qSl8vyCWAYRYJUO8YQYoeLelL4AsQvxSZgC4hMhUW5ynwlmeLyxUt4RGis1LHRl
         UQUFRWyhSMDZET7ZFLxX4N7xKD3g56BWYm9bBWnpu58QWybyqX2Ieyyf7D6VJ+cDkDxp
         VhA7SGrUGnHa8uQhVzOjkNiqIUijUkTzVaD/dgdgBwPE5XouKAmYFbc1Vm0Atgf+6WVr
         NNXNP3pKBY211msp0iWZ6IyHd59AnukPNF7Q3FgGoeP/Jd0Qf0avFVy47GMr+WCvfmtC
         7ZPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776970284; x=1777575084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLSsMLz6/iZL3g93nUiAhy7oSyYv4b0L7cJWV3CiODA=;
        b=Nt9Pez8NWqnl1QK2iafewOvtYM5cibh8tqWpd2+/p/LsSIzQfIyeq+8TCyCE6Kqfp/
         B/wOUWFpWhvmIlwhgj+PkKymoLK4MheZPnq8+lzZcyBT5+GOpiJX0rJMxeShtCZNieJ1
         Kw+N+zDkehuhZ2RrWbA91d/d0D+LAVZGXMifYgDe0BJEhVUTHotsJU6TFVus/X4lypTy
         BuFG+V4qKBC0reo/ckMi8V9EGoIa/V1g6SksA9v4aMMbNG0s/2Wrb/NqggoI6o3D6yF5
         k9T6cQ3G6POwCa5tdtaHxMyNs46OCVsBofH6wOeERvEj0GS5FKHOIYj6THkmjifFijzi
         6hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776970284; x=1777575084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLSsMLz6/iZL3g93nUiAhy7oSyYv4b0L7cJWV3CiODA=;
        b=nkDzYOkU4tqwCnCf+1BWl10Ah3opd5Zxa5E/ixVH/zZbXH9rXriabzZJ/b1OMAbYz+
         FAeFHHkTAjpC152udg8dAHByiErQczRGf5KSTd5n61UmAYiV8D+pUkyC/83Dn88AyBlu
         twHya+uDTF57WOVbXhki36gY3L+IP76P+m88YI6Qz6orXqooM9Wji/9MJnGJ8maaOg9u
         ZwiN0rJOZYZ9vsn4xwqT5BZderAm/m3ajWFX0pGTAMlQteImNUNKDfsfm61DYHU9qMMI
         mdtL6umUgEUu/otr4k5/dbSST3Ap1yOyk08UIdUuzjR5zaE0qJILLXTTGJNDbYUq8PNp
         Pziw==
X-Forwarded-Encrypted: i=1; AFNElJ+TreMDEfRAEesow5q0R7Bhrqvv3yCUk+mUtm1Rv3tKyxfOGtBCV7aHYrNNoALkJRaSSzN2t8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZRZb2VikGQ6epsXfLVWPsrbG+z7ZeWlbIfApr3p9NSnGrrNU
	kALpd3vkwMvHvE17V6EGxGiOjaoY5kj29OU6oK3FE9XqN75/Q1PxG8RZchuKAC6Wh4yQ92G4NIa
	68CiFYvhR3nA851tbC1sVJ905GGR5LyPb5tpcfwR7
X-Gm-Gg: AeBDiev1ZeYKyvwsIIQo+43PhgpjqW+wme7z9BVGUbJ83BRbdUZ4nbV0nXfqOS5fRM+
	1/6sZggDF4kGmG4W2sirGb1Sr0FyVDtV+TUdR6XWd+Di/NTT07ignTPReKxX79ZPQ1I0sbSlRVT
	hVWod+FJtdU/jfDnItB14X9pOTdDqUOMQLWbEi6cKHG6Ocvfh8587AK9Cc8eFlsmr45SEfG39iz
	+ZWxMrn4a77ST1eLfAwrHHU70c4M4Fp9N3uoftf/t0dfM9M2RolZFyuHH5gLyIrfj87EkZxsyzN
	HRbJPvXvmTHPSDBBmB+9TV1BA08/NvtNaVU6HrBu1iR3NfmpM8BQJbdDJFl33DPevZe1VtU/J4V
	qQuswkEQyIQlXNFxbKFdyZ2IXpnHHZDxESNZIKzmKu11vbMJqd1tRUIWf6FMq//VujGRNEYmHpg
	==
X-Received: by 2002:a05:7022:458d:b0:128:cc63:82f0 with SMTP id
 a92af1059eb24-12c73fa3bf6mr12089949c88.25.1776970283383; Thu, 23 Apr 2026
 11:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423010933.3899132-1-kuniyu@google.com> <CANn89iKwALD=b-FqwQe=GjB23u5ksdepOZG+3PCjMESBqSw1bg@mail.gmail.com>
In-Reply-To: <CANn89iKwALD=b-FqwQe=GjB23u5ksdepOZG+3PCjMESBqSw1bg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Apr 2026 11:51:11 -0700
X-Gm-Features: AQROBzB86jCCOBoE9huff1XRTzymQVzgd2G-f9yTQSyJvMQqA2jBKKVdPLnZmSg
Message-ID: <CAAVpQUDt+Ox3Q0Lu7SVH5doFrTxFJOSigfP5E1WGB0Bi102S4Q@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Use READ_ONCE()/WRITE_ONCE() for hslot->count.
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	David Held <drheld@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-280842-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,04905b8b3523856476c0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C9884563B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:29=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Apr 22, 2026 at 6:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > __udp4_lib_mcast_demux_lookup() and __udp4_lib_mcast_deliver()
> > reads the number of sockets in the 1-tuple hash table chain
> > locklessly. [0]
> >
> > Let's use READ_ONCE() and WRITE_ONCE() for hslot->count.
> >
> > [0]:
> > BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash
>
> ...
>
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 PREE=
MPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 02/12/2026
> >
> > Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp*_li=
b_mcast_deliver.")
> > Fixes: 63c6f81cdde5 ("udp: ipv4: do not waste time in __udp4_lib_mcast_=
demux_lookup")
> > Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69e97093.050a0220.24bfd3.0048.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
>
> You forgot to change net/ipv6/udp.c

Ah exactly.  Will add this in v2.

>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194eccc3c29b3e5f3a09214cad60623329..1f4dabe4c350118441f61c1cf=
0398e698581542c
> 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -953,7 +953,7 @@ static int __udp6_lib_mcast_deliver(struct net
> *net, struct sk_buff *skb,
>         hash2_any =3D 0;
>         hash2 =3D 0;
>         hslot =3D udp_hashslot(udptable, net, hnum);
> -       use_hash2 =3D hslot->count > 10;
> +       use_hash2 =3D READ_ONCE(hslot->count) > 10;
>         offset =3D offsetof(typeof(*sk), sk_node);
>
>         if (use_hash2) {
>
>
> Also one part is missing in udp_lib_get_port()

I excluded this part since it's under spin_lock_bh(&hslot->lock).

>
> @@ -289,7 +289,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short =
snum,
>                         hash2_nulladdr &=3D udptable->mask;
>
>                         hslot2 =3D udp_hashslot2(udptable, slot2);
> -                       if (hslot->count < hslot2->count)
> +                       if (hslot->count < READ_ONCE(hslot2->count))
>                                 goto scan_primary_hash;
>
>                         exist =3D udp_lib_lport_inuse2(net, snum, hslot2,=
 sk);

