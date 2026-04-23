Return-Path: <netdev+bounces-280874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GdtAFl+6mk40AIAu9opvQ
	(envelope-from <netdev+bounces-280874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F734573B7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F6793014DA0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DA3537E9;
	Thu, 23 Apr 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlrmIFCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACB33EAEC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975320; cv=pass; b=krlO/S61GRlobs725NclxlUuDM5JR4KJ1bhEIUsUqqG1AquCFAr8imqKfG3xPPVVcFjqJ+BTZB1zSNftaFrd92DMERaUg+b1Uq/dm1iQHpGPO8xKp81BiaGhfU0ODYnmrTMQ0bPzjzhN14Pk6l7JJG0wY6eaXeTnXlOc4b3hBS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975320; c=relaxed/simple;
	bh=DnLD0NvQTZeX4t628F28c1S2voKzmuTcDUINDaebbec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUxfnFpVcgemVgXVmHSHYhjsGIV2Kd8O2gcwtdmqQTPH8KqtlPDc+dGCNoSY403rH/ypSTAbG63PeK1iaEOMY/dHOQqeJUblOF4Jvz6PjyWao4BMdEinwEbJn/dtP+DmmKz4xWxoRcVgW+Qc16xIMwGVV3gEITB3lNc7g+TW52A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlrmIFCY; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c726f46baso8933527c88.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776975318; cv=none;
        d=google.com; s=arc-20240605;
        b=X1F5rvq8fV+oLNwVDrQiKMiuUQa9y26bwHMhTagoig+KtuAOxyRwUD2wGcCNwx9RBe
         vJTaO6ttLdnzi554oBhocyyzeeU+XEzse0Z6D0FA5h2pwY6vtyt6N0uKAjXpjMyeXmlS
         EbTeaWz+OCTCtHTDIk1R6RK9afO14QaOuQ4JyajicfycGH2tRMNjimS2/hP0ONGcpEfX
         SuL5DUkVCpFqpPuBVCM0BpcT0E/BORA3bls1WSog1EgFVLuQGuxFg8Zf6nl7tPML8JMI
         i8LIIVVtr6KOzCtRFQixGayJbXQIE7xiUp+y0eRlIyRVaV7hEp7Zi+KJ+eq81PIcwiWp
         y8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZleEa8fRPxXtIqzsbMyag/KbL8SqJ0A9P8D5EOyKYc0=;
        fh=sQOv4BE0r/0SbjKqde0C9oDVh9l4ukdsQziVcO7sulM=;
        b=A/Q4mhy4yNas1DPbwKY/W9NLtDYcWrK07cN+WKWHKpFbqnZAqdeMNx9DabX4OVoiVj
         Ut5ruKtOox3qvAWvzxDpNO/6p/4vs5AKp6ETlblsE5UWEth+6uAk4SDA/8sqOLX8lXzu
         q+osx4nLiC2tccq6kAGx38ViEMYKQFm3q4vIeF6jBe0L1PmbJ5YFRGq8gGKw+Rn7eHVK
         Lrf1PSvtv5fOwGmq3WXkh2iQQHM+D8f9UgxkPoEb/bqCTmFaA4XevLzaWYzcKm0KNnq+
         AHjMRkllaMkYjw79Gz8sdqbc9Q2s9t4nVuSsiHaV60oQ1/7Pvm9GHfLWmFizHY3SWwpw
         mgfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776975318; x=1777580118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZleEa8fRPxXtIqzsbMyag/KbL8SqJ0A9P8D5EOyKYc0=;
        b=PlrmIFCYKIoO/l+/omxZuRl+AQbPiY3N0MRvfJioOcUCldUyz1dJ+Tq+R1eun/a29X
         8IeOyvUB657zfBKIRLaP2QV3WQNK+4JtlpBMNdwyl9Pq7Abrigu+4o3cEOyS2hmuvIke
         VlKY4rVr7c9SbevQe3w6+JwSmU05QbyMbHJBZOQgatoXgpDsTUVH58S0jhjb5RTctN2Z
         rz4ABKSZCPrTT7ZmwjXsIw52W885v2+uAj/a/1kr3AE2jG73R5O80L5e0aoymNn1pqjm
         7DQqnKuFGnx8S5x6BUIZazwfEbvpjtot4aIW/Le5FbnwnkIcm+e/FWMgBLLrb+6QMD+3
         8Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975318; x=1777580118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZleEa8fRPxXtIqzsbMyag/KbL8SqJ0A9P8D5EOyKYc0=;
        b=eoeO6zJGjfeS8pqZ9fFP/MIPJRGwRCf1sPW0C0tB31hcd4nj4yBHI6RjKEE2Z9HJ8E
         r7dA0ZIJP6WnIdJc/NDmup+gXSI76yI4ke/v/da4/Newpr5b6qkr8+wGJWrKAmgv/WFN
         ENJYzDZiWFnCt3G8aVYeEATmLmFvKFvQiNRYLtdXOPyMNbGwZ2oI6JCCRbyFIW7BwtI/
         MP4oqLlEU+39wAN/Z2/0AFzoc5NTGUNfObZuLABNkSMWLZm9wtSj4Y7jSFfr8vGwdmEi
         6Y7FCJLIDw9hTj+BdzHtrbMYrRrtxoo1lPF4eAQ34WrGNZYxFCEXaCu7eb8HfOTsh92h
         6wtA==
X-Forwarded-Encrypted: i=1; AFNElJ+qvfrGZBhOLIRjGFTLxiDei+9/MPQl3hBxa6oao29QNLhWdmnQp7vGc5XILKdq5ELaIEF67A0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2d4C39KYQvm144mtpFMdq21UxjVJ3G5hUkjDLd4nn6nSP8VJR
	DXtYvCGRbvGWk1oQiI7DHoAKEJvk5YAUX0+pOSeOHQJUneWkoae4SVJ1EoPGzOQweuoL9HqTl7W
	mKaIQ6N836Rwr3wmMkRm7LqLZGMbamrTKedwKtqCm
X-Gm-Gg: AeBDiet+a1RrQ8sBTG/HI42eyiQAjxG9ksHv0TA+7/Ow8FbQUQu37jfh4qz9oi0X+uu
	DzaPlbfsA3pQ6DlkiwxphdBbco/LKYirMlUr2lysy5IBRjCCNwmxbR5eIYTosijTLTqE3QTIUOv
	IwU5SNg0uemU2qLseZ8kLEPczrj5nMAQRm2uCxcXmXZAXIcS3U7gCEfOC20A2MoKjj8Qi893bnd
	9p7fuu6Cy7eZ7FazDl6PS3rlofLeRGykUrjUhui92hSENlEx74AhiI9IQnsabPli+zCYu1V4O6G
	f6mze+U9F6pC17Bvj7vSkllYcdnaqu5B5ymJidrguSGQw7Epzpv/SKD/We7IeWtPZtE8rFn9SCl
	Dh4rNKmNcVnn9KpHM1DnQpHKuZOUGgKLnA9DUSlC0TO4esIHdJNwI9oyK2E1OAN6wZJWCMMDyEQ
	==
X-Received: by 2002:a05:7022:6091:b0:12d:b8e5:5ee with SMTP id
 a92af1059eb24-12db8e50b51mr4993135c88.23.1776975315368; Thu, 23 Apr 2026
 13:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423010933.3899132-1-kuniyu@google.com> <CANn89iKwALD=b-FqwQe=GjB23u5ksdepOZG+3PCjMESBqSw1bg@mail.gmail.com>
 <CAAVpQUDt+Ox3Q0Lu7SVH5doFrTxFJOSigfP5E1WGB0Bi102S4Q@mail.gmail.com> <CANn89iLZ3GUpK-iEvr0iyut1p-oXPn64rOnCcqpmbtfLwduNHQ@mail.gmail.com>
In-Reply-To: <CANn89iLZ3GUpK-iEvr0iyut1p-oXPn64rOnCcqpmbtfLwduNHQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Apr 2026 13:15:03 -0700
X-Gm-Features: AQROBzB31nNHiyNFFEk1s0JN9PL3jw0yXLY-Qg7-JtL0EXV2cs4NsfM5eSRjlbo
Message-ID: <CAAVpQUDcLnCibvXiEqUf-Q_T4WfdWTkXQH13OYrJbfXeOwJ8Eg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-280874-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,04905b8b3523856476c0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: F1F734573B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 11:59=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Apr 23, 2026 at 11:51=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > On Thu, Apr 23, 2026 at 12:29=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Apr 22, 2026 at 6:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > __udp4_lib_mcast_demux_lookup() and __udp4_lib_mcast_deliver()
> > > > reads the number of sockets in the 1-tuple hash table chain
> > > > locklessly. [0]
> > > >
> > > > Let's use READ_ONCE() and WRITE_ONCE() for hslot->count.
> > > >
> > > > [0]:
> > > > BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash
> > >
> > > ...
> > >
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 =
PREEMPT(full)
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/12/2026
> > > >
> > > > Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp=
*_lib_mcast_deliver.")
> > > > Fixes: 63c6f81cdde5 ("udp: ipv4: do not waste time in __udp4_lib_mc=
ast_demux_lookup")
> > > > Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/netdev/69e97093.050a0220.24bfd3.004=
8.GAE@google.com/
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > >
> > > You forgot to change net/ipv6/udp.c
> >
> > Ah exactly.  Will add this in v2.
> >
> > >
> > > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > > index 15e032194eccc3c29b3e5f3a09214cad60623329..1f4dabe4c350118441f61=
c1cf0398e698581542c
> > > 100644
> > > --- a/net/ipv6/udp.c
> > > +++ b/net/ipv6/udp.c
> > > @@ -953,7 +953,7 @@ static int __udp6_lib_mcast_deliver(struct net
> > > *net, struct sk_buff *skb,
> > >         hash2_any =3D 0;
> > >         hash2 =3D 0;
> > >         hslot =3D udp_hashslot(udptable, net, hnum);
> > > -       use_hash2 =3D hslot->count > 10;
> > > +       use_hash2 =3D READ_ONCE(hslot->count) > 10;
> > >         offset =3D offsetof(typeof(*sk), sk_node);
> > >
> > >         if (use_hash2) {
> > >
> > >
> > > Also one part is missing in udp_lib_get_port()
> >
> > I excluded this part since it's under spin_lock_bh(&hslot->lock).
> >
>
> But you would need a spin_lock(hslot2->lock), wich we do not hold.

Ah, it's hslot2->count !  I'll cover that too, thank you !

>
> > >
> > > @@ -289,7 +289,7 @@ int udp_lib_get_port(struct sock *sk, unsigned sh=
ort snum,
> > >                         hash2_nulladdr &=3D udptable->mask;
> > >
> > >                         hslot2 =3D udp_hashslot2(udptable, slot2);
> > > -                       if (hslot->count < hslot2->count)
> > > +                       if (hslot->count < READ_ONCE(hslot2->count))
> > >                                 goto scan_primary_hash;
> > >
> > >                         exist =3D udp_lib_lport_inuse2(net, snum, hsl=
ot2, sk);

