Return-Path: <netdev+bounces-277602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOwfIEd62WkzqAgAu9opvQ
	(envelope-from <netdev+bounces-277602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0B3DD3CD
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83BD030164AF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1E369965;
	Fri, 10 Apr 2026 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCiCpRDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E73346A6
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860293; cv=pass; b=Z8FPf4jJOafIWZ6zbQVwGl3lSq7LEibiScnNSc75D4p8COdTFWcpXEPgOwLxP/cHrhFSi1RnlyTnbK4chSu50Ss1tupVBgdAB3e8UerxPvSLu/Kslsprh54Ns/TpOWYZKucfYSaBEysD5sg48/gMh/6ESh9dJDvMHSo4o7ohru8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860293; c=relaxed/simple;
	bh=ABTHCdzsSmrh99b+XmN/GmmM0NPYS0sr2kFlxYc89VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6ywkVvhQujVnCrbLklnJpwa1H/7gqeShfkDzQoajUxbwPc/vzwovx1IFoPeixRDjoFEKCs2dWuCX40KmX/KZ0V9793VHQINqLhg6yuwxeKhepZPh4jkBxrZ2BamPOf1NcJU2vF5cScYQssdpylaB6a5qVYoz3J37xoZ4Ram7UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCiCpRDJ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so10107994c88.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860291; cv=none;
        d=google.com; s=arc-20240605;
        b=N69HPbFqwni/R0I9cg4VszolgiICxgFznE5jAtRpwpGzEha0xDiTbwLsZrpWdSX8kp
         iDGOtnmSCg63i4e3Dzltc5rwYEPYU4koTOPOZD+r2osmCk9WSH7Ec1VU/EHiiUwKn+wl
         MwDPHs2YCXGO4UlIqfN4Yfg7d1jYXJfCnwmfRppLS68rFiKYGFDC9OdHAdG/NLyeI80G
         QHBZggpdiYn6G6mO4cvIbxmYeBcKH1NafI6o7jMabEQlIbJAraJfG+bQtqHuJzUnxVw+
         Ke7OkPAEwPoJQrMVemlNNAPiwMeVTCYtr3OIA4t0p16ObOSjdNSCgy4S3pJtViP4sKGR
         kZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        fh=yBy1o+qd67IHeoYQt3i6Nj9CEtUzA1TbnUdJfy5rnbo=;
        b=haC6MOEvDbxJwnDM3ns1L3qGzftVNfndwXhOaJ2wGwycQnFFE671oOwIsW101Y+KE3
         BP+/xEn9kgBkZs/0ev0ddjcY8/6bo+iynHFCGvtHMSpLcNIN3YoJDCcjrxd8rzc0p1bY
         tYG1l72cne4nid9S/UKa//WUbCBrl9jMWyR4G/a6Pq9SlO4BaFue3xNNnt5TnBGXw3AL
         cYty14o08VHsD1wx5DEmEfeMvKp2LGhHG2KQLdGolIN7SgdQzqOpFu98coqy65Mnt1LE
         W3M5Db6jyL0WoHQesf7RpSQCsyVmyzAx8PgLZNTSCCTtMbBrhVvvpdEHqUTZVUY+NLPR
         kJeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775860291; x=1776465091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        b=tCiCpRDJyYClOoLPLIqcT/FtnvyUVc05LsY3A1CbGsGKTSwGpIsbaNNIEqp+YkQpym
         UPPd87pJ/MNhh1B6SDW62rrg2tTkdgc/Z+EYug6Uu/UbNA57pHRwDTQy+/pRs2PXv9PX
         Tm5J2WnnWmDyHy2ylF0s+ywrNQQNagXxh5tjb1BkFIDJ0/tJMXAMayvD41b++2z5yGtG
         +tyKkACgf7lojV9Dq5RsG1VT9DZRvkNvBqJl+LWe5VNuQaDAiESM9koFo353UqA/qo1N
         Djb1l8jFd6vye02DR1pNgwfAt5ryS0uS9MjHsTiEzwFhMTnDAwmD2cLD71XYiLfJ/zE6
         mb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860291; x=1776465091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t99f77g5Iy+T7II6EXVKP9R88xfslRKx2eeuK9aCq1Y=;
        b=m94IyTGA9NHqEKrl7xvUAgGveTmE2FbITEH4vTb5JnCv3XaZjxCW/zUDt8ZKWmEaCv
         YKXCJbfOIcfY3DD84yZM6U8vEFXPZip+RXum/YGCDd1auz9L9I7TETVgWIfXQleBOoe/
         s8xkLp7DDnkIKR/P8Phetk9o5uBsl6gKMYOF0/ZUivIammVsgzEEAdYYQZTuao6pFDRX
         DIa0VLtVc8QyzZUBGOe4wd7pykDddPGrhoHgTvieU+0ZUDRWug06tf4bQXz3+pAACS5C
         lz6EAy8n6wH0H2wUpK6QlZIojPyuBZIZrf2XD859BqcdFAIpnm9euVN7q4UAnjzZfXji
         82OQ==
X-Gm-Message-State: AOJu0YwvC3xNLfgZpGdsCWE0OI7+dK/lFsqphdk9mHzRni4WCTqIvbnq
	s09TjteGD+KaFuBDxgn2kWbbBEMc7xDWeLV4oHjJkJdv9A89BGGTlqZOguUdmtZnw9Lsymdv6SY
	C4vUGg7PmAuGrmFjIScH1bVw5p7knysmbkd1n8qFK
X-Gm-Gg: AeBDies3QVtTHFNM4YDRPnXDr/19Kwxw3FER4r96gbPOH2dsEgG2pU4+JEm01E6kD7J
	zNKkQBbnuZqVR3zqFpnMoBTdpP9gds5A2ctuZBqbDUjgeo/o9/AfSWh1oWkuysWeGFwi4mjbSik
	GneppxccvSUGJ30bh+w9Sjlb5ZDy4wSRWls8OODNUblohV0rcqSA8+zYzy+9bn+hqTSYRG6wHBY
	SIlv/QtN+9c+VyX8d3Ktfu58kda/YO0MZKDJcPNsk0kJSiSz8p595B/JUzSFssskz2rpgci8tPH
	HRHqmYjlrXwpK7CCR9ApQZgpH9AfA8pKuDsFN+D8r6u2SoENwHBRwvWsCyBTOaZzErrYwkQWCu/
	lGRiopBfAlh2F3aYwyjotmOdQC9zYuBz/hKVJEIMPzQZyxBDUj23q4OcjR/Zx
X-Received: by 2002:a05:7022:618:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c34e899e2mr3180909c88.12.1775860290635; Fri, 10 Apr 2026
 15:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409124129.361777-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260409124129.361777-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Apr 2026 15:31:19 -0700
X-Gm-Features: AQROBzBJ1676PQ8NXeBhPLu23LccTqdsnp6r1CI3D2XkGF_QrgIAfVv_LOtgQgA
Message-ID: <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: add missing syncookie statistics for BPF
 custom syncookies
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23A0B3DD3CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 5:41=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>    cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>    CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>    true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>    config for BPF program functionality.
>
> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>    This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>    net/core/filter.c which is compiled unconditionally, so wrapping
>    the definition in a config guard could cause build failures when
>    CONFIG_BPF_SYSCALL=3Dn.
>
> 3. Fix mismatched declaration of cookie_bpf_check() between the
>    CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>    'struct net *net' but the declaration in the header did not.
>    Add the net parameter to the declaration and all call sites.
>
> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>    statistics in cookie_bpf_check(), so that BPF custom syncookie
>    validation is accounted for in SNMP counters just like the
>    non-BPF path.
>
> Compile-tested with CONFIG_BPF_SYSCALL=3Dy and CONFIG_BPF_SYSCALL
> not set.

Can you add SNMP test in tcp_custom_syncookie.c by checking
the delta before connect_to_fd() and after accept() ?


>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> No functional bug here =E2=80=94 CONFIG_BPF is always enabled under
> CONFIG_NET, so the existing code compiles and works correctly.
> This is a cleanup and improvement, no backport needed.
> ---
>  include/net/tcp.h     |  7 +++----
>  net/ipv4/syncookies.c | 10 +++++++---
>  net/ipv6/syncookies.c |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6156d1d068e1..570a8836c2ba 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -598,7 +598,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const str=
uct request_sock_ops *ops,
>                                             struct tcp_options_received *=
tcp_opt,
>                                             int mss, u32 tsoff);
>
> -#if IS_ENABLED(CONFIG_BPF)
>  struct bpf_tcp_req_attrs {
>         u32 rcv_tsval;
>         u32 rcv_tsecr;
> @@ -612,7 +611,6 @@ struct bpf_tcp_req_attrs {
>         u8 usec_ts_ok;
>         u8 reserved[3];
>  };
> -#endif
>
>  #ifdef CONFIG_SYN_COOKIES
>
> @@ -715,13 +713,14 @@ static inline bool cookie_ecn_ok(const struct net *=
net, const struct dst_entry *
>                 dst_feature(dst, RTAX_FEATURE_ECN);
>  }
>
> -#if IS_ENABLED(CONFIG_BPF)
> +#ifdef CONFIG_BPF_SYSCALL
>  static inline bool cookie_bpf_ok(struct sk_buff *skb)
>  {
>         return skb->sk;
>  }
>
> -struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb);
> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> +                                     struct sk_buff *skb);
>  #else
>  static inline bool cookie_bpf_ok(struct sk_buff *skb)
>  {
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index f1474598d2c8..d685631438cb 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -295,8 +295,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, str=
uct sk_buff *skb,
>         return 0;
>  }
>
> -#if IS_ENABLED(CONFIG_BPF)
> -struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb)
> +#ifdef CONFIG_BPF_SYSCALL
> +struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
> +                                     struct sk_buff *skb)
>  {
>         struct request_sock *req =3D inet_reqsk(skb->sk);
>
> @@ -306,6 +307,9 @@ struct request_sock *cookie_bpf_check(struct sock *sk=
, struct sk_buff *skb)
>         if (cookie_tcp_reqsk_init(sk, skb, req)) {
>                 reqsk_free(req);
>                 req =3D NULL;
> +               __NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
> +       } else {
> +               __NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
>         }
>
>         return req;
> @@ -419,7 +423,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>                 goto out;
>
>         if (cookie_bpf_ok(skb)) {
> -               req =3D cookie_bpf_check(sk, skb);
> +               req =3D cookie_bpf_check(net, sk, skb);
>         } else {
>                 req =3D cookie_tcp_check(net, sk, skb);
>                 if (IS_ERR(req))
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 4f6f0d751d6c..111d7a41d957 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -190,7 +190,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>                 goto out;
>
>         if (cookie_bpf_ok(skb)) {
> -               req =3D cookie_bpf_check(sk, skb);
> +               req =3D cookie_bpf_check(net, sk, skb);
>         } else {
>                 req =3D cookie_tcp_check(net, sk, skb);
>                 if (IS_ERR(req))
> --
> 2.43.0
>

