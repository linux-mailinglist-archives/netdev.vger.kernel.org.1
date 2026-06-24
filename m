Return-Path: <netdev+bounces-301778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CtcVAq9OPGrSmQgAu9opvQ
	(envelope-from <netdev+bounces-301778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:39:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B996C18B1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=P3LZAylK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301778-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301778-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 736F1300CB39
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029E3E638B;
	Wed, 24 Jun 2026 21:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43A3C583B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:39:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337192; cv=pass; b=mb20FUTeqsLr6QgaqxDqvgll/0btC67e13ZXhbyjYXK0VNDqovLQ6nTagZLHLkapmUfbHJelMdC/OPfbU0u5JLt36IK8NLjXDsc8p0wM/O0cWWKi3lVnjUWsoIuluEJi5DnvnLaomPQhW6ZeKMIaUFS+iy2GD0Xdb8vIgXGV0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337192; c=relaxed/simple;
	bh=a0BWoGM5wyNogAPP+XjvyDbv/wr3Fz33yIX41qc+w0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN4DslWB5Gnv6Dbh9jggoMB1HTzA380fxh7Zl1dd9PDZp60y6vHFQRjeS6fhZPenCgfZk7swbv1zCwKIn9qDksNzs5a3zajtUig/C+s4mcY/4qywFOzcrtI56hCfk7YhVmVxuPb45j2vQMbC/4cw2gH8dZ6sJoVaGD27WxKpaRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3LZAylK; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139a71baa35so4017957c88.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337188; cv=none;
        d=google.com; s=arc-20240605;
        b=YhK5MHtOHC1aipwOdPqJ1hxB36x78cvR7Vt8aGFilmJqdnEW0IIAyWXAHnXjQqT8RG
         g8UcAHl7xr5KtlxgWxIEvXmlv8LIJTYnWoHCfQKmmHlNTtnUVS8ECi2q3FFSei+qRJh3
         5G42l0ocpGTVLtm4KoY29vSc4jrC+I9O1hBy3RXKEtWdW4UjDI9iAQXdqQXwTdHrZNNy
         eW63lat0pfJF8zX49LQ1NtQnuGnnbPH/LwxsQuHl+OaJV97si0KLyCNaSJlxyUE0Xj+I
         2wJmTC7BJ/qTW6C27pEMXwVYR6tpHKfM5vyKzJR8HsomRxJvU0HrYSrcynSEBbDrPp4X
         kaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNSvwqHXnP6aEtKjspQ712l6vpxfCEvAq9jpKI16xuw=;
        fh=tihMnM8qojtts+1U8UnLKOsheLgnLdgG7l09Xf86CFQ=;
        b=K4aQDwIAi5BSNfIxO46zvSHB+KGCJQgrNWdCQT/3Z06gT6ikcoL/2cTQs9v97i4R4a
         YVPGXOooQBOqT7VycYXe6UAfRPhqxWWLoJHNIOIQxVdJXZmBZ04Y7kC/U5F+hWP9CT8S
         Xe0ZtRdDVdGsDW/RW8QnhyaClciYS2XKJlwWemSSwpa99zfcBLyZ8x3yA019gaBwwAnW
         Rclx+hpO+472cQgFqdwxzs7MC4baH2V4WpcNRaShKk8aZfYAoN49EKHSK+9eG6HQ2bCE
         Ui90k/0VfoW9O5Ro3tbCmyrlT4CbYEzs0EgKMMqdpVy8akbpYhE4ZvKFMTCBvkxbG9m2
         m9MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782337188; x=1782941988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNSvwqHXnP6aEtKjspQ712l6vpxfCEvAq9jpKI16xuw=;
        b=P3LZAylKob/nuUnYcPQ3YRs7smRwQ+je8crAXtoimBHbhcScPpObB02cV3FTGKF2YG
         Lb7JaoEe0lG+xudeJcMoS4N+7M8dXh9bY2LqtruJ3zLAeTX9D45Z+QXfNXtCZRWSBvGM
         p2RdT2mdkJdQha+1gYXDH1H3HT4ae2Qkg1JJOvK+8ihMpda69j8K4QC68lXwXhEAXSH9
         zsWubaVTdE0BTwhsNAnKygAoz3QNmrF+hnqycon64ooVlUIJzfXzwV2NYXMIBjQKmDjO
         2qDoIFC/oszGf423bolOvJZh7oAl1/8pxobyMhLN5ELjMQVoa1/wF2kAjPAL2OjW3Hiv
         /27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337188; x=1782941988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNSvwqHXnP6aEtKjspQ712l6vpxfCEvAq9jpKI16xuw=;
        b=WBX+MCWcppLGzs8EkladLJbQn7Bi1H1X6h+giZa20rYS5HWKAJX17fTyFnXMgIUBqU
         u8e7Xvxzx/n9l9rqOAYhEoMudrbqcCowvabIE2vg1J6pdXsYZNCBln3LFIv37/JNQK0y
         eRTU7DSkjkYdh7rtH0uiwIPwhBKev6BdoZMTNHQfpACVUNTtkPbohnhk2uyqJsIChusm
         2dexW9XLFqh9+++a9raEOpnsiJOYb29/Yo9ZxnjjBQ82MSKkcWUtWsCXg8xhNQfPWlSn
         TH8hGIaCpRwOX63xrP0ftsLkwDEw8iSuC1VrALEq+08ODYvf0AXZZoI+FccwtkobjuWk
         wClQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iL5kJeBglcSFFbXXpEY9hCD5n6M7GCo+Cgz/q4J/SF0XXE+WlbsRtMWVZNNdsBXUpXi7Kd9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdnARm54W2TZJdtG1LhHtVjQ9oNjO1N6LQu+QaxiLBv4IwEjj
	Un/m7TWGaOQ/4NbIY4m7pwOSRZ5dV/2xpicFx6RAftKM6plEufJ/7k/h68wrg5J2aReh5qoj0Ev
	A/KnZNxbmdo2wCglKrCXMYksD0wJkqSMxuIvpCrw0
X-Gm-Gg: AfdE7cmVCnshWu5+vAwzw40H0gk84hJwazGq4T5iVxQr39MZ2XzXpEQqRprXE16/CPw
	/43tncu28bOcdGgd9p+O/iyzgZk/mR8O/2ekdJKoe+IpQ9Tm38m8YEBOIz62dQVkvmknw4R+iuv
	6Zw/wIFYMBLP8RYiJCogkgLd8JXIbtiykssCVI0qJZRINnFJcopzzGk2ug9CLscbs57ePLoxeLO
	9zMMiMssTyafDqTdbvKZqgrmVvrHYFRSK3qp4r9S9b0aed3LOPjfRgiK5RSjnDxf+G268gJ3VyB
	Tefrifudbd4FOfTpB5E4Uml1GWlIYmulUDg+Rw1D0t8Y6zW8DdUsepvkEbm9S+BlSMgcXUyT96b
	ANnM8/RCXhr65FgsFw1A6jimGSOUWTDmBKbrI0/Q=
X-Received: by 2002:a05:7022:418:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-139d0c8901bmr4402081c88.21.1782337187102; Wed, 24 Jun 2026
 14:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com> <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co> <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
In-Reply-To: <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 14:39:35 -0700
X-Gm-Features: AVVi8Ccp6GmoDjpIUj-Vaf70dAXiuN1iiE4qx-o6J_Vc31yAsa0rWYIuFIlKCsk
Message-ID: <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rbox.co:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B996C18B1

On Wed, Jun 24, 2026 at 2:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Jun 24, 2026 at 2:26=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrot=
e:
> >
> > On 6/24/26 22:01, Willem de Bruijn wrote:
> > > Jakub Sitnicki wrote:
> > >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
> > >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> > >>> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =
=3D false.
> > >>>
> > >>> Because sockmap accepts unbound UDP sockets, a BPF program can incr=
ement a
> > >>> socket's refcount via lookup. If the socket is subsequently bound, =
the
> > >>> transition from unbound to bound causes bpf_sk_release() to skip th=
e
> > >>> decrement of the refcount, causing a memory leak.
> > >>>
> > >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
> > >>>   comm "test_progs", pid 2451, jiffies 4295320596
> > >>>   hex dump (first 32 bytes):
> > >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ..............=
..
> > >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@..........=
..
> > >>>   backtrace (crc bdee079d):
> > >>>     kmem_cache_alloc_noprof+0x557/0x660
> > >>>     sk_prot_alloc+0x69/0x240
> > >>>     sk_alloc+0x30/0x460
> > >>>     inet_create+0x2ce/0xf80
> > >>>     __sock_create+0x25b/0x5c0
> > >>>     __sys_socket+0x119/0x1d0
> > >>>     __x64_sys_socket+0x72/0xd0
> > >>>     do_syscall_64+0xa1/0x5f0
> > >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >>>
> > >>> Maintain balanced refcounts across sk lookup/release: (re-)set
> > >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> > >>> unbound) as not requiring a refcount increment on (a RCU protected)=
 lookup.
> > >>>
> > >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for d=
atagram sockets")
> > >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > >>> ---
> > >>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject un=
hashed
> > >>> sockets in bpf_sk_assign").
> > >>> ---
> > >>>  net/ipv4/udp_bpf.c | 3 +++
> > >>>  1 file changed, 3 insertions(+)
> > >>>
> > >>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > >>> index ad57c4c9eaab..970327b59582 100644
> > >>> --- a/net/ipv4/udp_bpf.c
> > >>> +++ b/net/ipv4/udp_bpf.c
> > >>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struc=
t sk_psock *psock, bool restore)
> > >>>     if (sk->sk_family =3D=3D AF_INET6)
> > >>>             udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> > >>>
> > >>> +   /* Treat all sockets as non-refcounted, regardless of binding s=
tate. */
> > >>> +   sock_set_flag(sk, SOCK_RCU_FREE);
> > >>> +
> > >>>     sock_replace_proto(sk, &udp_bpf_prots[family]);
> > >>>     return 0;
> > >>>  }
> > >>
> > >> There is a side effect that an unhashed (unbound) UDP socket can now=
 be
> > >> selected in sk_lookup with bpf_sk_assign.
> > >
> > > The commit does mention a related fix, beneath the ---, commit
> > > 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
> > > That fixes a similar issue by exactly disallowing this:
> > >
> > >     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> > >     This matches the behaviour of __inet_lookup_skb which is ultimate=
ly
> > >     the goal of bpf_sk_assign().
> > >
> > > So ..
> > >
> > >> Though perhaps that's for the
> > >> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
> > >> sockets either, so we would have both socket dispatch sites behave t=
he
> > >> same way.
> > >
> > > .. there are two conflicting types of consistency here? Consistent wi=
th
> > > __inet_lookup_skb or the TC bpf hook. Of those the first is the more
> > > canonical.
> > >
> > >> Also, with this patch, if we insert & remove an unhashed UDP socket
> > >> into/from a sockmap, we end up with an unhashed non-refcounted UDP
> > >> socket. Not entirely sure if that is actually a problem or not.
> > >>
> > >> Willem, what is your take on having unhashed non-refcoted UDP socket=
s?
> > >
> > > I don't immediately see a problem, but I'm not an expert on SOCK_RCU_=
FREE.
> >
> > Perhaps it's worth mentioning that unhashed non-refcounted UDP socket i=
s
> > already possible: first auto-bind via connect(AF_INET) (which also sets
> > SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).
>
> Setting SOCK_RCU_FREE itself should not cause a problem, but I think
> we should take a step back.
>
> AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
> into sockmap, not to allow using unconnected UDP sockets in sk_lookup etc=
.
>
> Actually, v4 of the patch was implemented as such but did not get any fee=
dback,
> https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.c=
om/#t
>
> ... and v5 (the final commit) somehow removed the restriction for unconne=
cted
> UDP socket as well.
> https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.c=
om/
>
> Given the initial use case, sockmap redirect, is still blocked by
> TCP_ESTABLISHED
> check in sock_map_redirect_allowed(), I feel there is no point in support=
ing
> unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
> (without buggy sk_lookup).

s/unconnected/unhashed/g :)

