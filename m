Return-Path: <netdev+bounces-296675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5qA4F6gEJ2o/qAIAu9opvQ
	(envelope-from <netdev+bounces-296675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC96598A3
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Pr+zHCYK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296675-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A035349C564
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA43D7D6C;
	Mon,  8 Jun 2026 17:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041003D6CA6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:21:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939314; cv=pass; b=j6TB2CpPd1QA2TgXSi+mbWZoub0uPDOCPJlYPzRPJ1km4XSr0dsxqUw98tbZFBFoOfRr7SxSe4veZJPZ9NsxvWiiNow98Eb9jklCee16NruxplcCVpOo6/mVAjGPoIkPYLrn8V0wksEtqfCuiMNXQK9o+I2GZo0jcg+dZhohSeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939314; c=relaxed/simple;
	bh=QhL6+Og5Q/2hRDexNOZHX54YQpZaWEITisbjv1OZ03M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHK6g8LrZhONlnNiYDsajVN7NXsSHFBOk1jpG+3DQCHN0/SbcUFAWD1HR58Mn/RUhM4GNVgTfrA6cLIHcSEwfAMYbSgTVugRaToqlPyS/xTZXaJgxR0xwEy+3vXzIa9tP4ow3HObzN0FRkcG+K0gaBZHwNHl4xcS1cJQo3154j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr+zHCYK; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13817614cd3so1006745c88.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939312; cv=none;
        d=google.com; s=arc-20240605;
        b=fiUACs1YyNvhhU2lm/TyybFtgbXAbhubgknLouf0odGiAeyL693PWGvXTTN263ZFqI
         mD4PIziiMJPKNyBj/tymXjQSlzdqIeMl9xPhmdZpqiCkwkw2X9EtRKSeQ1hGUlwxE3e+
         ukIFXdVO5g3hFl5+0r9zFUvEaLB/kSrvjTst1koWOiuR/Lbhs9wJjSJoYICoGU1nTHo2
         CtJz5rWgFmamsFU8qJIg+lfMPSAXWlTRMX1sS83aggyp/joMP/PenjB8kt2gQknhAXr2
         YwPskWbRK3VQoancVO9680g2OEQw7SSdEuA874AHSiQtXStLkI1CbRFbqMOrwoz/VYKS
         83Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        fh=2xsvJuxyo2qBD/+odr/W7hZxPo5rVRo0Nbf/JoZ83ZI=;
        b=YUXI4S421UjSNurcc7JJ//A4xgUnNpIAcn4nWOSAg5GfSjRJcVoP7ee/XdCS9mCMyx
         OgQDLRg1IWEUkjC7DQhkfovaiIBDjZ4rbbS8ZSxw6VUpDj+QSiaSIDjl2eeJa+EUWTRB
         Sbi8ZBl1Psvv/z8KMNkdXLcFLWxRc3rOkwY4q9j5hIbievCMtfK2tA5i58dmSyV7lNdv
         M8SbESwhAjdSGz6h/KugERPNCX+5gwlE10zLzCjYxqWqR1ON+7SwZBP09Ux3FGoGXML7
         el/+rbhicwRrSF/kxXpuv5dmwV5qG6xM0lEgAgtz2DqPjsjCN+hvShi35lVkwEopZ0RK
         wNbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780939312; x=1781544112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        b=Pr+zHCYKZ61QQRxYPxO77pfbp9wONivQ5ufwLdbowWyUhXqeKmoOKiblLJW4SlzJQj
         2TQFJmAlM8oeZke4LLhcdLhFA2yoeJvWwN4sVlOlSZGmqOB0iLaKSYJ9XByVPLy+ISEH
         lMtKmDmiNwriLYzuDoeLMSqa8ccw85OEo/36sbw7LaxEOSTXmJCNUnyCgEXg9lzN9n3V
         gmR9yOsJeYaCBnsS+1lIAB6PAVUxSg5P82CguyVXA6HSsEc8TLRBf3gqCZFbfeHpVmcS
         8g8zZBf+XDKVqlQ967m9QL8r4SYrYHAnxHCg8LpFo+1o+tGfWiVsfwi0sBDG2G3WAGvt
         0wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939312; x=1781544112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wd8GNmsbbskCMjCK+uQDvW4BClWHx0VSsIW/uXHLcIQ=;
        b=b/YV9URAxBo+lfDsgk5ZSzAMqYWm3lFFA/UyMTF276G6t8kX2aqsbHAEhPL1/5Itk9
         T8dRrWTYl+0Cz3NbG/aFHqgMP1dpk35Yz8Z0H1ZA++RHC43aQGZLkeLp18R1rfhLonqX
         Y56Jnm+q/eQPd5p1qUUNK2Yk+9RU6LOx8Sn18pmvXkhhMlloEMXKAezRkc7Z5ZCMZjpB
         HglroHzKKrysA2ITXcVS0N7J165mIaFqkrjZdSI/SBjWEvKPZoAwDuf9U9oYWkRIKO3n
         zwHTB0f60OF5jN5jbEdHiH5UXSxx2+QgM0UqcEcCESPYbqu4eF25olwdbXUnJQJFV9LT
         /1Rw==
X-Forwarded-Encrypted: i=1; AFNElJ+O8Tm0Kptgp7/RwmVSmCvbq2TkbcwB+nD0Azv+etce8rQ7E+17do0MdI/zjPLYDN+8cu4IdSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/xCHu634Lk8x7qLhz7DL5hl5Z8/CqV3XdXemNJqjwFgzSFeg
	t698jTanJ1LZqpr95djPE1CGC5fTzyVnLlUNpKVBY4YV6OQ72eAMZnledLCBic+0vn1jj7fcmR9
	GMtWBIqmQsaSAChr4pLp2cUExBysn7Ag5iZCnexQY
X-Gm-Gg: Acq92OGlJJFKBTT+tjdCDnZSLLecrSEE7rQx/v1iQ1CT0tn6Np+h8zxHP+8p9rYHoRg
	xd3xsWCcNv0fgTvJsnBdptObH6Nsr35MaRGboRlIwEFQSgAa/fAL3K7Ur9CIDl7wjaoOT7F8rOf
	HsbMytlaCgbh4ZCp18Rs0pS3i4BlxKlX3XQUAF2t0uc4lCOeZcM437YvQ3gPcZir2UqTawzQVWH
	j5zTeumVppazQY4gK8yXK0JKJepu4Jh82HaFW0acZOzLDRFAkOCyG4DY2h+gvfHNlpFbdE/5i7a
	PkXft5Cnff4TxApg6vAQqoTomateSPu3yyEpxHYm2SlmXa/zn1nPbrW7T6/leq2lORoEroYB4hd
	0/yhTJ4ruVeapqywZ8RUabnkfiOQwWkxIWnfsmH9mp7C1DrL+uPX0FZoIhUI57HTjrTpF7HQ=
X-Received: by 2002:a05:7022:439a:b0:137:ef27:e2b1 with SMTP id
 a92af1059eb24-13806731a20mr8368591c88.29.1780939311188; Mon, 08 Jun 2026
 10:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev> <20260608125846.157004-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260608125846.157004-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 10:21:40 -0700
X-Gm-Features: AVVi8CdEYEu_V10M8S7Ftf79tPIdsLj4WF1IsqTeM2icUsCKu5PzvQ1A8P3-Rcc
Message-ID: <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,wand.net.nz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBCC96598A3

On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
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

I'm curious about the BPF maintainers' stance on this kind of "bug"
where admin tries to shoot oneself in the foot.

I saw Alexei said this recently, and I guess it applies here as well ?
https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQu2OW=
Qx27_w@mail.gmail.com/

---8<---
Not every "bug" needs a fix.
If a malicious bpf user wants to crash the kernel they will
find a way to do so. Especially with agents.
We cannot realistically close all of the holes.
Right now the priority is to fix the issues that normal
users can hit and not bots.
---8<---


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
> index 2cc5d416bbb5a..218498373a9c1 100644
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
> index 6e2fe186d0dcb..a2a044f93cc4b 100644
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
> index 5a9c826a7092d..c2b8c6350b624 100644
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
> +               if (unlikely(((sk_fullsock(sk) ? sk->sk_protocol : IPPROT=
O_TCP) !=3D protocol))) {
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
> index 0ac2bf4f8759b..ceb4d29a64aca 100644
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
> index 15e032194eccc..d9c12cce5acef 100644
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

