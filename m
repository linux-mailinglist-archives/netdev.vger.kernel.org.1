Return-Path: <netdev+bounces-295317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbAdJsWiIWqfKQEAu9opvQ
	(envelope-from <netdev+bounces-295317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:07:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19E641B29
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=u+W5gTsp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295317-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C90A30B482C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE73C2797;
	Thu,  4 Jun 2026 16:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5253ABD98
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:00:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588819; cv=pass; b=aPPqb1NhmXDuiDkc0GrePOA0I1iTmIrAeRaPclHIpEzpeAGK8CMn5UcgzdzMvQTLRR+t0xaFxmqzjWZo71N4oCe9H2C4kXRMh44vNMa64XBljGV+Pq+bYECM+nWMz5c6qBT6lQMd0kBLrCMhTnLUWz9H4umgZxF1/Mf3PkdIfl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588819; c=relaxed/simple;
	bh=bLe1Y9Of8HNmICgPAiQwdq9YGoPx+pI+2J6qjn08Evs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU56knB+4BS9Ln4pm/gKI9EuQrIcE458KjI4wiIJhP98u+Ux6gZslXCwpqz7yJctP+N07dBLQzaDCILhmGWIhPpP0thyu8Ods2AiwcscAiQvvVCFZHG65PB322ClCdJ68KNYTI8vh8YwXBCo7O/18+6kmdUbQXgbvpyUduTk4Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+W5gTsp; arc=pass smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccf887de87so10055276d6.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780588818; cv=none;
        d=google.com; s=arc-20240605;
        b=OpiY07X3gGlKqZS/UnTlo6DLiZrMytIG0siADDMEbYDRHwUtnERFarUxJFCIHP4pcN
         pgPCorpXl2PmKwXovk5SDeXXR5pimglkar62fD0Zlf+38cbKn1tCq/QioRANHGDg2aht
         qAO7QQHsHm7z3vvTOGcVGxHDbHlbasKaLaSUrK0Op37v6qmNxOewRkcx1MYws1nrpZK1
         oX8mlJ0LXJc/ywb0/MCEcoF8l0Sp/CwVPuyRxsdw1fSiW7QKScPW8/zknJoWTkK8ITXq
         avlNOP1EFOo5IwpctPyIKQPKsE3/feVHN1D1f9JituZq2VL0ddKO6qb2kFbe52IP9WQD
         YTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        fh=0zGfenSGUjkfVRO6gi6TwRLf+U2tUnJLtixvV0DMJcU=;
        b=JjZ/zmGAatstzH3uQJqyje7cshH9+xUWmvst3662omc6HnfvbXLPImIM2Io3NCztHX
         gT7k5V/JStA4bggNaZ69pCnePE7hylohnFI1CL/sNWFxjBVUFx5gwW1YgC9Z1barR2UO
         ZWfUogrOHd3SxfaFmyK+qQnZC1OcVe/VPjpFFzpKyUuEZJmy5kFodNQk4ckGvAEfVC6H
         F6wkYUt5mMX9sGNRQWP3OKq8RZhQ9BV23C9w+EIYOHSI3qvWWJLTyLyR07sAOAdXHQIc
         MCt4Wo39j41OGpQdjyAVViMTkc9XqF1mcNFJRiZ3iiNqd/BiLB8n/4ZR0fuZydrUxX5A
         LURQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780588818; x=1781193618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=u+W5gTspgU7emHOlGec2XqngThnMxBQIKTmm7vfRDrXp13HcKDwBJjAihc7t3EVcT8
         7PAf76n/MVCgsKKCLlhchuRER60XCV/cXii/0T7dsooZuC1hD7ieY4Aj/zvqVX/xvGN0
         QBDzEz0fciASkL2RhvgytvVNAJKI8T7lIuibo8PmROiBAN7+FOGUmNRjJ6RZiBynNTcI
         k0M63+CNU9VSJujY23LYFOrzISTbMaCdN6d7vL6DriLQ0z3PAC7UWwmV2lndt4uJys+c
         4t+SPr7gsQ2hlPFUNUB53m3Quu6cmb3KiEcx+SDTCgwKymj626Zmwp2Fe7KJ7VBTm6rD
         qRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588818; x=1781193618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLg4KQvgwweGiSdYyzi1L3wlPRaBrfee+IZJmKuxAhM=;
        b=cFcLtrJvQQfVa2AJKNw6aepkMn7o6Tfx2tV8IFwhhED3vE6+CQlmAMRQ56tIrSn4PR
         U3sAPcYSyOIgYw+KQ7XgWrtVRiVkt2ZtbPrckO180zC4XPoT6x/kdq5jJyFwN+vYxg98
         trh4DTYSkHqw00+EoYzvy5/N8SAS/boqbITRf94rTiuIT1QQhNXNOaKA5zHn6O0wu90b
         JJlXBWqwQxJ2qjal34QP86KiBonyig6h31e5oRiNlTRuQuf8uGqRqc3rEpwZMQ8ewJQH
         GWFmiZVYbWGLNon1l+vFByWHdN0SdqkETrPc9doa24kBJClydv9d1Jtygt5i4GndilX4
         2y6g==
X-Forwarded-Encrypted: i=1; AFNElJ8U2O7QJ2s8d0b8I7UvBnksOykRk0rXQppSCmmPvo4XRBXRHzlWSlIb1uFvhEW+v6AYBmp2Qp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAB6Ovfqh8K+ZThnZH/N9So7u82x/m6YkgYsO1D8w4aRpDfKJA
	j1vB+XtW4L4xGYXVXbFNhYjun31pnZ7T9GPg8Ohi2y9513pruTBbOtiqeBL8VHRer2NI/gv5KLK
	F/ncO/GWG0ox3OvXK3BsnZfzkt56+EJZ5+thllD17
X-Gm-Gg: Acq92OGSH0c799tWv5KqVsMrVcAV07xlwu2b07+qq+CJmCwtdtW5dOwpvFf7Ijnuyp6
	y9Ix+coJXVkgh64VrTonu1Y1BOVvkCw6ShXxG1OYVOtQ5nXZnWGeZzgcUxiXvO97haIMJk4nOcW
	wfGYFCYL/Ow4LuXBr6n6pjcBVF18w9ec1x8a8cPgVdEidu8rFStZ7Xa4Oadfuys+DXlU1gz//Ag
	8ENgn6YwCgKv8pTeMuTAtUejv2Rbrm9IVHIR+U9e4WCMAje+jheajUV9XGUYDcVYjhTGvS8hEnX
	W4gDXt7Qh2l4hNL+ppGA0Oz9UyJR2pI9BWYMpCsFC7eLyPAeFmPzCCOcKH8tB3pVAwkykMcEU2k
	IJv6GkBVZDR9OrcKp8r+djuNJeAgUZw==
X-Received: by 2002:a05:6214:3c9f:b0:8ce:a005:3e93 with SMTP id
 6a1803df08f44-8cece02dadamr121809056d6.35.1780588815554; Thu, 04 Jun 2026
 09:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603162737.697215-1-rhkrqnwk98@gmail.com> <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
In-Reply-To: <b5d4d726-c32f-45e4-9ea7-28f7b6a1f8d7@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 09:00:04 -0700
X-Gm-Features: AVHnY4KFeB_7dmL9P1vPP7kjQ_Xqs-Cnp4utG2D6VMV7WmTclo4knkrnYzYYWMU
Message-ID: <CANn89iLhibjsgf-nk5U9be5kRpg3k4FXchKszmerkMbaaK6z6w@mail.gmail.com>
Subject: Re: [PATCH net v2] udp: clear skb->dev before running a sockmap verdict
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jakub@cloudflare.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-295317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:rhkrqnwk98@gmail.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:aleksander.lobakin@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,cloudflare.com,intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B19E641B29

On Wed, Jun 3, 2026 at 6:49=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/4/26 12:27 AM, Sechang Lim wrote:
> > On the UDP receive path skb->dev is repurposed as dev_scratch (the
> > truesize/state cache set by udp_set_dev_scratch()), through the
> > union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff=
.
> >
> > When a UDP socket is in a sockmap, sk_data_ready is
> > sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor=
()
> > (sk_psock_verdict_recv) to run the attached SK_SKB verdict program in s=
oftirq.
> > If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
> > bpf_skc_lookup_tcp), bpf_skc_lookup() does:
> >
> >       if (skb->dev)
> >               caller_net =3D dev_net(skb->dev);
> >
> > skb->dev still holds the dev_scratch value (a non-NULL integer), so dev=
_net()
> > dereferences it as a struct net_device * and the kernel takes a general
> > protection fault on a non-canonical address in softirq:
> >
> >    Oops: general protection fault, probably for non-canonical address 0=
x1010000800004a0
> >    CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREE=
MPT(full)
> >    RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
> >    RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
> >    Call Trace:
> >     <IRQ>
> >     bpf_prog_4675cb904b7071f8+0x12e/0x14e
> >     bpf_prog_run_pin_on_cpu+0xc6/0x1f0
> >     sk_psock_verdict_recv+0x1ba/0x350
> >     udp_read_skb+0x31a/0x370
> >     sk_psock_verdict_data_ready+0x2e3/0x600
> >     __udp_enqueue_schedule_skb+0x4c8/0x650
> >     udpv6_queue_rcv_one_skb+0x3ec/0x740
> >     udp6_unicast_rcv_skb+0x11d/0x140
> >     ip6_protocol_deliver_rcu+0x61e/0x950
> >     ip6_input_finish+0xa9/0x150
> >     NF_HOOK+0x286/0x2f0
> >     ip6_input+0x117/0x220
> >     NF_HOOK+0x286/0x2f0
> >     __netif_receive_skb+0x85/0x200
> >     process_backlog+0x374/0x9a0
> >     __napi_poll+0x4f/0x1c0
> >     net_rx_action+0x3b0/0x770
> >     handle_softirqs+0x15a/0x460
> >     do_softirq+0x57/0x80
> >     </IRQ>
> >
> > The rmem charge that dev_scratch accounted for is released by skb_recv_=
udp() on
> > dequeue, just above, so the scratch is dead by the time recv_actor() ru=
ns. Clear
> > skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
> > skb_set_owner_sk_safe() set just above.
> >
> > Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

