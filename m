Return-Path: <netdev+bounces-301777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hefYOBdOPGq6mQgAu9opvQ
	(envelope-from <netdev+bounces-301777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:37:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB26C1870
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="uxy9/Wu0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301777-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C971730102CC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BBF21638D;
	Wed, 24 Jun 2026 21:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025237416B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:33:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336800; cv=pass; b=p6zmAOKMVZWrvE9pqpsmsYk2KvHUO/L92AaORdAJbuk9uPEdwrGXHJkT8FwO0/ORGpaBNuMDASjWKj1lho05jdrlI4eNljpQU5PKRPuLMKRZH0g62Y2vym4wzu6dClGnF1JSoIL7sizqXYcI5QAgPixDRRqg3wrKUqRtU0g56F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336800; c=relaxed/simple;
	bh=rvc4TEFeuCgkWrl/ybtdz29Xy4B2P8fBztIzw1BjsMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNTUSSwPKkmxbMv7rGWef8KExYuzIVZ/4X1vjOmTLX5g9sjoouQVxB2dK8raA7Cp0cxvw4dpazrjWlC5SMe9UlcojnRNW1DjO4JfE81jfveNL1tUmaW37BlbMJk+wJjmigN8i8EFtBnsXlJoOPuvBkFlJWs4gIySLOE4EP4m/Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxy9/Wu0; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139a71baa35so4005348c88.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782336798; cv=none;
        d=google.com; s=arc-20240605;
        b=jRWxMgy/6XEVrBZPW5algvLch0n752Lutm8nZQOxlQde3ZAXg8C8PxgQ0ywtz5CaV/
         szJ/96AqIVanJQ2ORPpf3xHNWA86QUmT+xK9hwHR2xT0aTByCySF4wEsk3JLQDAz3b2b
         Kn5PI8JGpXUrANIuMHL8itPy3EFfPGe20utsjmkingS+zilJ1FmkUDePDv3NL6BE+4lM
         P661gYDetDkhHuFbK8Vk3gJdGrJBbyMg7V1XjnT1GYIHKpHg1UzHmisPdtgAhHoD3zs1
         E4yCHs3Y37hk82ZRGFWDq1D88p882fAUPlJd+z5jcuLQ95RUvSl8kldptiMADX2A4NnI
         dJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        fh=R0Ory94YDaD38rHkUVoTz442s0mL4G6fn4DxwXq6DqI=;
        b=WQhV3bAueQzLVZcJoLiGIRA3QI3oHELKe2Vm2ErdXCro8qDIrZanAkFGzcBNkAZsBR
         6AWQvbKJbhX7DX3GwZHcpp/P0pnTLA33vaa/8agZx0WHPvQtOwO8u/xU0K+UFb2vlLY0
         z1rE7yJipr3JJlUncXHXEUZuyvLhcahRTRaim8bbUZgVsK9YJM3l3vIXwSZ/kKXa4Jhg
         kxgsC9v9l0ri/1nrp/X9cWRJ6FAOY2uJsvyYaTYbK1yXICPami2tLkPLh5xCQIY3Tt+k
         bbJpX7pt36BqvUKaorQbcExfLMjaansZZCqszg72iwQFATCWARA1Jwn8z2gscov7gsZ8
         YsWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782336798; x=1782941598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        b=uxy9/Wu0pVyaODyS4qe8Gq8UOoH+djcSG4AaNyFxyMZQ4JtTNL/3zKpQm0n2IP7MeU
         LedNpWoPJoSz8OrJn4frRAO4xWuQLO+f3QTzsjCrKOFdpdbbHKhBWl8njGgBBBPRYleU
         j5q8gMZ0ahIEEm01HPyQQWLStIuPIiM1N4QxaRAC/MrOO4qSPU7knLCunlf5Do+xDqNY
         Dw/+NNPkxiZ+7oD4pvwhRQpjvFHWdNoAkl6eEFfjQ35hr4kkA33FH0ua3m6fCy5Q2/vR
         avmpVRk0C8wDmgaAUI9mCHMmJz6DwWbs8ZpLBjIXPPlBN32wOT9LGvEdbWcaEmGk7kGf
         Uzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336798; x=1782941598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        b=EHnivEzsCs77enNoFMXoAA5kqlYup4Yz6nvyDmnygGyomfcJU39M9bs6uRKb5sXurY
         SzFN6SUpPyqLampyYjpdDhZ38eUWjtA5smY50f/ykq7zMaGAw5m7YyRjAXrbAk9mi8sD
         nOhQ6LSujTIHVFgb/C4IDUtFirgCBYk8sAVW48rn3CPnzBku4kDQCn6lY031dKz92y77
         KN8sEjxXg0bHyQ5mU4sZgOG8Z4YP8ccIWynmwrp4ly3y0gcjPXPl672vPUfBeaTS0JY9
         vRfN+s8wfrBir5AjU+gf7hkZ4Rwg9rAeyTQviPA5PPReGK2JnFB6oFxVAFvMOmHzCCBN
         uTog==
X-Forwarded-Encrypted: i=1; AFNElJ8G2Dc2ifn8rM/G5iIGxRkKbhRD0lhuACpXkEY1Las+1KNhFM6OyTD4/GKmSFoJ954kMZhnPL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWx13HoWRlYmurfGYXYa6lMB9Jueqbi8xvPO2ZQb8w2L7ejVcx
	n5d6RiE/nrAUmyuFbWC8vHz/smxN19qhopt9/JK5WD/gQKzOAIP5hzKFsQgkMx+8tOuZLz/6O9K
	MfAq63cWUVocL3UBvCVCUnOWNTIh9u4aD6M9Wprh6
X-Gm-Gg: AfdE7cmg1lp7uUDeJt7NzFYbCjrjc3RNb5ybJ9eNm9IjK0zHm/qn10Bm601CmobwHal
	nBvaLD8K3HY90ORW/oXRCPaeMtO4casCPVt9MxXuCtpW5cZSBBjmmBAy/3x7uJ0qu5fGelV0Eoa
	8N66vBkzcPRax11x7m7r+kR07wUD152gZ1hc3WwNLyuBs/Xa/0radSJb83GwsPdermseVgXjyD5
	i+vDlZJyEhdTe+kP78+rGUs7HaXG8rGzNjUNJc7gtgRUJqsYqI3R5R48/t4n3sLXtnSJaJio4KR
	kJK/FHoT7iKRGlMODrhv8ROkBLBP51D/y4K8hSu6RCq1sZYmMyfSG8ppwJhMaOCTmMbgJce8fhD
	bAy4j6FveU3oTZEHwvI5+bHamgZe/0AeLj7MeDUQ=
X-Received: by 2002:a05:7022:623:b0:138:49ea:f463 with SMTP id
 a92af1059eb24-139d0c22beamr3720202c88.16.1782336797094; Wed, 24 Jun 2026
 14:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com> <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
In-Reply-To: <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 14:33:05 -0700
X-Gm-Features: AVVi8CenWMo1L6C-o6EOGzBIYsJyV25RjaCHhELt7xS_6-7remiUvIF891YEneA
Message-ID: <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on lookup-bind-release
To: Michal Luczaj <mhal@rbox.co>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFDB26C1870

On Wed, Jun 24, 2026 at 2:26=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 6/24/26 22:01, Willem de Bruijn wrote:
> > Jakub Sitnicki wrote:
> >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
> >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> >>> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =3D=
 false.
> >>>
> >>> Because sockmap accepts unbound UDP sockets, a BPF program can increm=
ent a
> >>> socket's refcount via lookup. If the socket is subsequently bound, th=
e
> >>> transition from unbound to bound causes bpf_sk_release() to skip the
> >>> decrement of the refcount, causing a memory leak.
> >>>
> >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
> >>>   comm "test_progs", pid 2451, jiffies 4295320596
> >>>   hex dump (first 32 bytes):
> >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
> >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
> >>>   backtrace (crc bdee079d):
> >>>     kmem_cache_alloc_noprof+0x557/0x660
> >>>     sk_prot_alloc+0x69/0x240
> >>>     sk_alloc+0x30/0x460
> >>>     inet_create+0x2ce/0xf80
> >>>     __sock_create+0x25b/0x5c0
> >>>     __sys_socket+0x119/0x1d0
> >>>     __x64_sys_socket+0x72/0xd0
> >>>     do_syscall_64+0xa1/0x5f0
> >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>
> >>> Maintain balanced refcounts across sk lookup/release: (re-)set
> >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> >>> unbound) as not requiring a refcount increment on (a RCU protected) l=
ookup.
> >>>
> >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for dat=
agram sockets")
> >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >>> ---
> >>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject unha=
shed
> >>> sockets in bpf_sk_assign").
> >>> ---
> >>>  net/ipv4/udp_bpf.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> >>> index ad57c4c9eaab..970327b59582 100644
> >>> --- a/net/ipv4/udp_bpf.c
> >>> +++ b/net/ipv4/udp_bpf.c
> >>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct =
sk_psock *psock, bool restore)
> >>>     if (sk->sk_family =3D=3D AF_INET6)
> >>>             udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> >>>
> >>> +   /* Treat all sockets as non-refcounted, regardless of binding sta=
te. */
> >>> +   sock_set_flag(sk, SOCK_RCU_FREE);
> >>> +
> >>>     sock_replace_proto(sk, &udp_bpf_prots[family]);
> >>>     return 0;
> >>>  }
> >>
> >> There is a side effect that an unhashed (unbound) UDP socket can now b=
e
> >> selected in sk_lookup with bpf_sk_assign.
> >
> > The commit does mention a related fix, beneath the ---, commit
> > 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
> > That fixes a similar issue by exactly disallowing this:
> >
> >     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> >     This matches the behaviour of __inet_lookup_skb which is ultimately
> >     the goal of bpf_sk_assign().
> >
> > So ..
> >
> >> Though perhaps that's for the
> >> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
> >> sockets either, so we would have both socket dispatch sites behave the
> >> same way.
> >
> > .. there are two conflicting types of consistency here? Consistent with
> > __inet_lookup_skb or the TC bpf hook. Of those the first is the more
> > canonical.
> >
> >> Also, with this patch, if we insert & remove an unhashed UDP socket
> >> into/from a sockmap, we end up with an unhashed non-refcounted UDP
> >> socket. Not entirely sure if that is actually a problem or not.
> >>
> >> Willem, what is your take on having unhashed non-refcoted UDP sockets?
> >
> > I don't immediately see a problem, but I'm not an expert on SOCK_RCU_FR=
EE.
>
> Perhaps it's worth mentioning that unhashed non-refcounted UDP socket is
> already possible: first auto-bind via connect(AF_INET) (which also sets
> SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).

Setting SOCK_RCU_FREE itself should not cause a problem, but I think
we should take a step back.

AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
into sockmap, not to allow using unconnected UDP sockets in sk_lookup etc.

Actually, v4 of the patch was implemented as such but did not get any feedb=
ack,
https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.com=
/#t

... and v5 (the final commit) somehow removed the restriction for unconnect=
ed
UDP socket as well.
https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.com=
/

Given the initial use case, sockmap redirect, is still blocked by
TCP_ESTABLISHED
check in sock_map_redirect_allowed(), I feel there is no point in supportin=
g
unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
(without buggy sk_lookup).

