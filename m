Return-Path: <netdev+bounces-285708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKg1EGiU/WmXgAAAu9opvQ
	(envelope-from <netdev+bounces-285708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB364F335B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBB6D3008C85
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7037B003;
	Fri,  8 May 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIloGflp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF2328B75
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226259; cv=pass; b=e80Qtv3t5CJZlHeb/ekAinkFP8F+eDHOGh9X6mLkQOW3F6erGD9uorCpTDagfm4LN7cfycuJmgE4BThDSvQB4VKR/VDZMD8zuZL8+lEpyqw2nwjlmzPLB/A+oapryFTdUKvuxQSZBec/x08JM0WnazGr76O0ck9rps/UsI9nl/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226259; c=relaxed/simple;
	bh=sMkNhibmcIHRkremZT1q3Qua/h7GiOCly5spXEAKDT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz/E1+x7DuWTDr+xEtJQTcJ5itmGvFJhOVfwhFk4gOH4vKiu12EMOLi4OQrj7bUvzGMpU5Zn000GLqOTKpYDbD49OcmBUNCKw2N3zZRmZPBFzewrHCSjn725gb643WORr1PO8Ic1w7PE0rSXS+RS58NAxCsPxYa1g+heewRfVtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIloGflp; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so1715106c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778226256; cv=none;
        d=google.com; s=arc-20240605;
        b=KJMMYGrZUiUhVLvuPyUZnzqUaukLTw6YUlXqul25qa+f0XVEhGxMtbbLYyMz2KHzrY
         0Vwpn7Qd1oHxr3M7iqHY3vfI5l5BJ4FpAGKyDGbqplH8gYfhKmPUVtAlIthEVjsXzgsj
         8WysZ5M/49Ek+0ikIkXO0cnUxoFoDNL37t+sr/9lE7/4lKW96yScqboNfddFgmNevbWC
         R6zX4XV9qDpuB0oLmCbYwGjWHBDdX3VMGIDNdEjW8nnwGxzkwJf10vNtrlwe6lz6uX2z
         Kg5MSATH/Uto9V29rtsKM7G4ZNUleM6nBxK8rSww49owx2lqy0ey9/pg1fM7p4Fndlhj
         2pjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        fh=RQS22hAj9VYv1az8yu1mRTOROhVcx8SKBpzXdfBoSKc=;
        b=UGYr3dh30xilLt5Ac200jAT+WS0xr78REMzgCVIRcG5HsI3K4MZxjNvUZ4wQYi4ebg
         idHZVTozFElIIBrPa7lmuGaq8s/DVIxqkbaA/913mFZzZ01fbDYkUJ+tfVt2gVn8rQVX
         Yt9u6sDr6QICdy23hKygl7k9L7UxYpQCAggwe/9ZIQn2iQZxJ9nvKsjcznOpOxLvBlxU
         h1At5fNBhZtKdDJu/agsn7wZDjp6csB697GRenpLQFxs8UzER1Neps0ychbuOFiIjMIG
         aFhPj+scXOII9vYmK+3F4ERJ+JTh5L2aMz2aeBHSc1LcD4bPl9Mxm6idT74DvR141Rfa
         0ukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778226256; x=1778831056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        b=QIloGflpnddVYrXyblUfpne1rXkvZJ7Ub+41ex0XRE0rqj5I8sK0afmQLL0oqYC26K
         cl7zcNOQ/V2nIv5DOu/dDhWMTciBHtKV14kTK97CAjlMPwkqIhJvApWaPA+TFi33Dpmm
         xHwG11uO4vxpHNYV9xrtPnCE1ZvQTIjV5cuzazwdC4SHi3IijI5cAj7JpdttePrTWKlI
         Q6flMBcxDQxl12xYp4LKPS/+MRLAQkWopYhia53an2SWc818DWGYCHWwkTcW2JFO2Jji
         FDjGmHU9KEub4+BoxQ5318tkaJeMbGrCRD5qnNlTtoeuFUOXhRVLHTR/NoZRfujsiRCH
         Eblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778226256; x=1778831056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pi0joMkG2M93+42Ksix4AKGdNipw+mH9xoz9YwVjrAc=;
        b=CjJv5dshWB6Y6sycl1O/hGxP4UtWvEzdKRrBVIZhusJnpbn3FV19Jx+1FD5DwcsDim
         Xa0gqQGTqJb9i/iFkk1lPEuldpsSZ0uWBH2nFxRkgA1z0N3U8X1xHmwMPf6UjbE807Ok
         M2NiXTRM5Vvs3JoDE16CDsZqxHYyRYsIgoiME1HPF5kP9AP85cfXY99gPhnXgGX2n5zd
         hD9Ca557ZpKZDv9ybpMwtVcCrvhGhA4UCMGrREsCPvNXCwaPBO9MvA48ckTDPFcyA49S
         nvddiyzysez1MVskOwgt32j1SdJoWJCbLHVETb476rr/kGGUSK371oxq0PzljsEIvjPk
         /n3w==
X-Gm-Message-State: AOJu0YzO34DkTQ9EcYIl/7N7u7rTIBg1aWnrzlElSINmaKSIdbBmW6OY
	OgIO0F69GA0khgTGR/+rVlX6g1X1MH+kjKgKCpKpb8YWF6K9PjMY6UwRnKZOxvw74U6EDSesx48
	8wmvWHJNFJohWcD8iflNC/id70qG8FWA1o1iX/XGv
X-Gm-Gg: AeBDieve/t9WkXNVzNAcQQUr1s9H1ncsVCa6Cf2zA/GrYFlLJRxO7vtYi4oyDIcPWAX
	Z9iTsaNvlj9bRebmAHsUkcG/1RGvC2stGg+Std4hNLs0z5mGOLQ8rQjP6P2KuDnkFAUqZXFeBHf
	ss8/JDL6MVHJz3wVs89WPXrtvD3Y4m4xoKg737BsFNzAI68VUKnr73JWouJ9jXicCXzhtkR+Qe1
	lT9v6k1u+X28yaRzimV3+8YS77kMUXdpZ4UmN3VXDpWKJAzEcqh8X8Pp6jDvHus3lB4ETOcCQdV
	6CUw8QeMyQQwExxi9OyJdOL01HZ7KMhSHZhbHY9aXr0mEOipcFbPRKhQbryuI/+UDWt7iFmaZNM
	RPA0o6ESstEecRgvBMt4WVROohFNJQkI=
X-Received: by 2002:a05:7022:b90:b0:12c:6ebe:b458 with SMTP id
 a92af1059eb24-1323b0abc56mr2860980c88.17.1778226255338; Fri, 08 May 2026
 00:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507104612.236253-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260507104612.236253-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 00:44:04 -0700
X-Gm-Features: AVHnY4Kf-tKGIUBHz4lbVIHn4sjHfFnnyWpgpskKoutXwyLUklAhJoc7UZz6kIA
Message-ID: <CAAVpQUA6z4bZVReNDMToRVL1V7xmYg4Tq2YMnWyU8AYXWoeB5A@mail.gmail.com>
Subject: Re: [PATCH net v7] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Joe Stringer <joe@wand.net.nz>, Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DB364F335B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,wand.net.nz,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 3:46=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> causing a panic when the skb enters the wrong L4 receive path [1].
> An initial attempt tried to fix this in the BPF helper by checking
> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> this check via a TOCTOU attack by modifying iph->protocol around the
> call:
>
>     iph->protocol =3D IPPROTO_TCP;
>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>     iph->protocol =3D IPPROTO_UDP;
>
> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> since its introduction =E2=80=94 it can assign any socket type to any skb
> without protocol validation.  Since the BPF helper check alone cannot
> prevent a malicious BPF program from crashing the kernel, add protocol
> validation in skb_steal_sock() to reject mismatched sockets regardless
> of how they were assigned.
>
> The check is applied to all prefetched sockets.  Early demux paths
> already only assign matching protocols (e.g., UDP early demux only
> assigns UDP sockets to UDP skbs), so they pass the check naturally and
> the extra branch is negligible.
>
> Pass the expected protocol from callers rather than extracting it from
> the IP header.  For IPv6, walking extension headers to find the L4
> protocol is complex and unnecessary since each caller already knows
> the protocol it handles.
>
> [1] https://lore.kernel.org/bpf/20260403015851.148209-1-jiayuan.chen@linu=
x.dev/

Why did you drop selftest ?
Also this patch should go to bpf.git instead of net.git.


> [2] https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%4=
0linux.dev
>
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/net/inet6_hashtables.h |  7 ++++---
>  include/net/inet_hashtables.h  |  7 ++++---
>  include/net/request_sock.h     | 16 +++++++++++++++-
>  net/ipv4/udp.c                 |  2 +-
>  net/ipv6/udp.c                 |  2 +-
>  5 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtable=
s.h
> index 2cc5d416bbb5..218498373a9c 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -106,12 +106,13 @@ static inline
>  struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int =
doff,
>                               const struct in6_addr *saddr, const __be16 =
sport,
>                               const struct in6_addr *daddr, const __be16 =
dport,
> -                             bool *refcounted, inet6_ehashfn_t *ehashfn)
> +                             bool *refcounted, inet6_ehashfn_t *ehashfn,
> +                             int protocol)
>  {
>         struct sock *sk, *reuse_sk;
>         bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>         if (!sk)
>                 return NULL;
>
> @@ -153,7 +154,7 @@ static inline struct sock *__inet6_lookup_skb(struct =
sk_buff *skb, int doff,
>         struct sock *sk;
>
>         sk =3D inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6=
h->daddr, dport,
> -                             refcounted, inet6_ehashfn);
> +                             refcounted, inet6_ehashfn, IPPROTO_TCP);
>         if (IS_ERR(sk))
>                 return NULL;
>         if (sk)
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 6e2fe186d0dc..a2a044f93cc4 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -446,12 +446,13 @@ static inline
>  struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int d=
off,
>                              const __be32 saddr, const __be16 sport,
>                              const __be32 daddr, const __be16 dport,
> -                            bool *refcounted, inet_ehashfn_t *ehashfn)
> +                            bool *refcounted, inet_ehashfn_t *ehashfn,
> +                            int protocol)
>  {
>         struct sock *sk, *reuse_sk;
>         bool prefetched;
>
> -       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched, protocol);
>         if (!sk)
>                 return NULL;
>
> @@ -494,7 +495,7 @@ static inline struct sock *__inet_lookup_skb(struct s=
k_buff *skb,
>         struct sock *sk;
>
>         sk =3D inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->da=
ddr, dport,
> -                            refcounted, inet_ehashfn);
> +                            refcounted, inet_ehashfn, IPPROTO_TCP);
>         if (IS_ERR(sk))
>                 return NULL;
>         if (sk)
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092..3469e4903aed 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -89,9 +89,11 @@ static inline struct sock *req_to_sk(struct request_so=
ck *req)
>   * @skb: sk_buff to steal the socket from
>   * @refcounted: is set to true if the socket is reference-counted
>   * @prefetched: is set to true if the socket was assigned from bpf
> + * @protocol: expected L4 protocol
>   */
>  static inline struct sock *skb_steal_sock(struct sk_buff *skb,
> -                                         bool *refcounted, bool *prefetc=
hed)
> +                                         bool *refcounted, bool *prefetc=
hed,
> +                                         int protocol)
>  {
>         struct sock *sk =3D skb->sk;
>
> @@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_=
buff *skb,
>
>         *prefetched =3D skb_sk_is_prefetched(skb);
>         if (*prefetched) {
> +               /* A non-full socket here is either a reqsk or a
> +                * timewait sock, both only contain sock_common and
> +                * lack sk_protocol. Since both can only be TCP,
> +                * use IPPROTO_TCP as the protocol.
> +                */
> +               if ((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) !=
=3D protocol) {

Please add unlikely() here.


> +                       skb_orphan(skb);
> +                       *prefetched =3D false;
> +                       *refcounted =3D false;
> +                       return NULL;
> +               }
> +
>  #if IS_ENABLED(CONFIG_SYN_COOKIES)
>                 if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_reqsk(sk=
)->syncookie) {
>                         struct request_sock *req =3D inet_reqsk(sk);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0ac2bf4f8759..ceb4d29a64ac 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2618,7 +2618,7 @@ int udp_rcv(struct sk_buff *skb)
>                 goto csum_error;
>
>         sk =3D inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, uh=
->source, daddr, uh->dest,
> -                            &refcounted, udp_ehashfn);
> +                            &refcounted, udp_ehashfn, IPPROTO_UDP);
>         if (IS_ERR(sk))
>                 goto no_sk;
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 15e032194ecc..d9c12cce5ace 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1106,7 +1106,7 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buf=
f *skb)
>
>         /* Check if the socket is already available, e.g. due to early de=
mux */
>         sk =3D inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, u=
h->source, daddr, uh->dest,
> -                             &refcounted, udp6_ehashfn);
> +                             &refcounted, udp6_ehashfn, IPPROTO_UDP);
>         if (IS_ERR(sk))
>                 goto no_sk;
>
> --
> 2.43.0
>

