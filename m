Return-Path: <netdev+bounces-254243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JSiHBIDemku1gEAu9opvQ
	(envelope-from <netdev+bounces-254243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:37:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B132A156F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 731CC3004F25
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928034EEEF;
	Wed, 28 Jan 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrozRyPw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD832EFDBF
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603856; cv=pass; b=sNV7eNsjXrmdRtfRM+ESAqdTfFhn6KMLrI5+ucVt6w8fCWNJErFU3uI4Vfktcv4z013F0A3heBeC8RGLE6descJNPACKKca3eroKyloKrecE8XNq/J9KPwkmNU94Ty/B5IyvJQIy+kGTwg76rTONvPhItp3zCwffBa0LA+anFgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603856; c=relaxed/simple;
	bh=Ir4mKiYqztmOr3S2cJBvK/FDCPhPU58yNx72le/W9GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqc+aeEte8mTuZC6b0D31iOnADpJLP/eI3WPfBStWI5SSyn7agKmWb4NkOb19WuOfHK8Qf98Pq0aPSsCrfYFdYzmL2b74Mhp8DRun6WAW8CKUQ9MTSNLxxPVOrtAtLDsYby5j+FkmdjRRU7RiT+KP5aCsPmPufq15urZWD+umRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrozRyPw; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50143fe869fso71398291cf.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769603853; cv=none;
        d=google.com; s=arc-20240605;
        b=LOLFsTPlASgFmGqrzt4G+mUCanqYYoEvJhBCB8MjdkBQDzGev3yMf/WeOZnBPeTvnV
         oIvWVMQqrYKZQUBAYUSbT/AOmCUdd+ECODw138V4NJHx+x35FOuxq6OBHrj1eRbgF9Ps
         E2JAh3CKx60wK418AUZQr3Cmne9KEpDcswyhQmwk6e6EzNjWm3C6OSdFOJ9v0YLJsdRu
         5Bj0wE2XO+OP4/hkORPrJ3r+lnXacCIpmkSB/brJx8P9g+PR57dlgHUnQwN2vme0+0Tc
         DM6gtd7/lsliKrVjqI+mHv4u+f9M0aKlQgHWiRm2aEu6tOhZO1sbebYyiGtrSM7+9+q+
         THSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DnhuV0tZSBEyDRalqNqq5c0t7++LRumvCgBdxsbHqI=;
        fh=hejTrwsSVkB3ADvtaaSMSpD6gBrmYQoNo2YdC40kTJM=;
        b=NppT0utGyBRsJWXfRcOvJe4VmGs6QHq61yafwTP/U16p+b6QEYO30mVnfjYtm0RX8g
         sofFph1vPGxsXQQxUA+yH1jI0tdvyOlCJUVuVqVrXw8ATHJfWa7e6BqCxSuo9v/AbfIQ
         HzOBHSUzUXoBHhiUEaORn31fH9vrTatNJgkCBy5su93hTIXgcC2mIIjEsIBbjEiCR7uQ
         lnREpDG4lojWS0OquCzU9JM8zJ4e+WAjWp+gPN+iJPfXYBy3VLLJzRDNh9V4xPkn6Udo
         q6CgZkYx5RVNA2umKugBHR6iPz2vg2jpDdCpWAx8v0Rowpyjar0zh3GiayJzD9ktYQTO
         dvjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769603853; x=1770208653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DnhuV0tZSBEyDRalqNqq5c0t7++LRumvCgBdxsbHqI=;
        b=qrozRyPw9ddZKBIAUxhm/H+2ZXMBFZaBc5KAEQS747cgOQe/3f2oVshUdcdPUQuKmq
         UvTDGap+mV8R+C5vO8tY8nOVqv6GTa4hi4OoBg19RXEJqXJ/CDTVPGzzrR8t3aNJs35J
         /JO9ICGiLxPm70xCXyvkOJ3CS4mwYbcXtl2Msnxvix9US5Sj8vPUNNI44PeEgAwxAlUE
         ru4boV6k0hzENkjZYSnwDeYRU5iQvVYIjeap1q82fIzDz22rdhO/8ekM0r3bwAitK0Ni
         beRFnFvV3zIqwMJG4ET3Bm6bd7YUnKGdDQnhRbGUF5MwXbI70dL4KjDZ+3p5XXm4Z++v
         l5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603853; x=1770208653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DnhuV0tZSBEyDRalqNqq5c0t7++LRumvCgBdxsbHqI=;
        b=b3xsyT8DZtKdC2YTAWI3I24oNy+T8xUzyYpC+Vt39C9Zjdduxu+k2ahKk6bjs2aiM2
         vziWWn75MpKMh0EKbeHwJ68Vi9SoSxP71DWxE0KjTPs3GLiRX4E8d7o+Op16jwsc3m0Y
         97EdKgJA7F7M44KVCLZhMKBZTZPc1C/qDuXbn/AwmrHkWoxrdkQ1Y0NGxmpAP5ZsVvaf
         t3y5DcarS4xM4rFnSXafNbLEBxz5hNephQu+uL4WtBNZ1D9LyI7IAIem4Tz+OF+pbJrX
         fuqAwE7jrdld0Xwfy7k2tUpDxZjShJDPNC7mGzJSFYS7+QnVNS4u0kqxVASQHbuJ73Fp
         PO4A==
X-Gm-Message-State: AOJu0Yy4DIaXTjgBkGbO3synTNuN1c2z2Wld3DX0Yb0MTN/DOBo3ub0l
	d+bpi9EcLtJLqfmD4I7XODHNqp4VsdGufEFnOawiAJzVl0acVLpvMVITJhJui8ZyPGZGEW0Ocp7
	+4f0DvHVILO6OO29leaqoVjOFv2KADSnf2Y/yD+PX5glZRo83FRT4Z82Ee6c=
X-Gm-Gg: AZuq6aJZJdXY/65CtJeVVNIUJb2G8Q0JWhydoS7VpYHCmXsXflREp76gqWFzJn0pyFH
	WnA34C6wytUBqU1ogVBo4FjRASYeicq/GfLjyFyrcCCfUCIg0AxwlfqgTiatjBgDT9zV/idqJDN
	lQXJnT1WlL5KsYln/YAFK1nM03A99Eb8cbvaPQ/tYkKYFinSYOsJcNncveYEhAkFGcGZ2OMEeJm
	6t5L6CM8v9yIc0h8i0dDGPPhVFsNvg4DlgBGrv5/nhhhTcjDkHa5kT1AdyBh2gEBP40zi2ztRBc
	VNui
X-Received: by 2002:ac8:7d15:0:b0:501:4a4a:c24e with SMTP id
 d75a77b69052e-5032f7659demr55490051cf.25.1769603853160; Wed, 28 Jan 2026
 04:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070311.48892-1-mahdifrmx@gmail.com> <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
 <CA+KdSGPvcGrUGeMiguBZ_RcHQjXeik+DgqetWaGNW8aGK3LUZg@mail.gmail.com>
In-Reply-To: <CA+KdSGPvcGrUGeMiguBZ_RcHQjXeik+DgqetWaGNW8aGK3LUZg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Jan 2026 13:37:22 +0100
X-Gm-Features: AZwV_QhvYgN91T1aet-BjUOmr1F62n76BJxc5TiKwzLIOBiihGjmjHSaQFcXkQ0
Message-ID: <CANn89i+k+dB_9G+gvCpv+_8wWSxp71LxQTdbOZVm7LSugRK5+A@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254243-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,zohomail.in];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B132A156F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 1:27=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> On Wed, Jan 28, 2026 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jan 28, 2026 at 8:03=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@g=
mail.com> wrote:
> > >
> > > This commit adds SNMP drop count increment for the packets in
> > > per NUMA queues which were introduced in commit b650bf0977d3
> > > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > > counters are incremented currently by the caller for skb. And
> > > that these skbs on the intermediate queue cannot be counted
> > > there so need similar logic in their error path.
> > >
> > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > ---
> > > v6:
> > >   - increasing a single counter based on socket family
> > > v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@g=
mail.com/
> > >   - check if drop counts are non-zero before increasing countrers
> > > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@g=
mail.com/
> > >   - move all changes to unlikely(to_drop) branch
> > > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@=
gmail.com/
> > >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@g=
mail.com/
> > >   - change ENOMEM to ENOBUFS
> > > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@=
gmail.com/
> > > ---
> > >  net/ipv4/udp.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index ffe074cb5..dd302f5fb 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct sock *s=
k, struct sk_buff *skb)
> > >                         skb =3D to_drop;
> > >                         to_drop =3D skb->next;
> > >                         skb_mark_not_on_list(skb);
> > > -                       /* TODO: update SNMP values. */
> > >                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_P=
ROTO_MEM);
> > >                 }
> > >                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D P=
F_INET)),
> > > +                              UDP_MIB_MEMERRORS, nb);
> > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D P=
F_INET)),
> > > +                              UDP_MIB_INERRORS, nb);
> > >         }
> >
> > Hmm.. I have not followed your prior attempts, sorry for coming late.
> >
> > Note that an UDP AF_INET6 socket for which ipv6_only_sock(sk) is false
> > can receive
> > IPv4 and IPv6 UDP packets, if bound to any addresses.
> >
> > The to_drop list could contain a mix of IPv4 and IPv6 packets.
> >
> > Ideally we should track SNMP values in the proper space (Ipv4 , IPv6).
> >
> > See IPV6_V6ONLY and /proc/sys/net/ipv6/bindv6only for reference.
> This is the exact discussion I had with Willem de Bruijn:
> https://lore.kernel.org/netdev/willemdebruijn.kernel.17f36003699cb@gmail.=
com/

I think Willem was wrong :)

__udp_enqueue_schedule_skb() is called either from
__udp_queue_rcv_skb() for IPv4 packets,
or __udpv6_queue_rcv_skb() for IPv6 packets, and they both can feed
packets to a single and shared UDP socket.

An IPv4 packet will not go through __udpv6_queue_rcv_skb().

It would be deceptive to increment IPV6 UDP counters if a host only
receives IPv4 UDP packets.

