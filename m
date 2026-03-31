Return-Path: <netdev+bounces-273431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLl8Drkhy2mdEAYAu9opvQ
	(envelope-from <netdev+bounces-273431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6D36308D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62ED3019913
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823723090D9;
	Tue, 31 Mar 2026 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYX41Z4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD92233A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920114; cv=pass; b=oS+g6jANqALf7EsHbhaABHgeD5MnE9GSMBSZEyHqLfq1yoBl1MyLJs46PITNZAxDFGV+MuV95ncT/6dCrJDaaP1mzHiFUgcJtzJt8VaBhqwnLIzF8wAKRXlkmpbtGaWRIv762DHURLHSXkbMLAFh+D2Lf84sOLeplP4K++bPszw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920114; c=relaxed/simple;
	bh=fvTz1IRpJxhKnPo++V+kL9b5IKkpiz5dUGWbBQKfCKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7CBufWfRyh+MNidtMtjyOXGLCXZ54JiuhLgpsjTBAAQvCACv1GLct6cJMrJ/fmhyevvE8upgOux0UsGSpR6nscUCQBdlPM2LRUFSKxFMWOV5TT80MDFyPHzcymul3noj3gBA0zgFm/N4Dqviy7uFKGJH6fw7IaVzG0JsQdwLdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYX41Z4M; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12a74039dc6so4045366c88.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774920111; cv=none;
        d=google.com; s=arc-20240605;
        b=hs3B8emcVhf74TS+KDBM7UYC/cENpfjU2RaNd7sO43uDuArS4sf/oTf8cRJeZBf5FT
         XMKE4uNcIDp8Vf4a+4WnTbb79V9b0xCfTVtEX0fsaEfoKhKctIp/V2hgOjo1HW8Bdewc
         coh3wrrqIo5ERbyB2ZKXShVbzeh6Epobtkv5qoERRvVFZy8s72HZy2DJvX2jeWPwSWX3
         gtsQ9qGaDv/IVIncBpIrxwMwoqaxwGTX1/Fes17r+FdV6qnx+T8qWQ7LkTGhAnNZkpCE
         2LccrgfMmjOQb0bg05gi1l6ELqQ3qMEJGxD16cJ4pxi4EKc/P1aQrlzn96qKDOcjy4uL
         42ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        fh=CdBF6TsN9iJOMOC9U5OWtFspRjA4tjCk21g3YOVPYxM=;
        b=QReJj1n5lfJ0VwSZISW7DxZZ95pvQjDgjosz8aCj0X8yAVzYEYY/QCNx91lMs6sp4+
         vcBGNdgJleeAaYLhUAzqmuIG1hJKv7U2aMVNDnuI4MryHJyoW0VkYmCQnxFiXSYpw7pY
         GO5s4wHXjQXcvbf5SZbSUg05s7+vKg/UkJfg5S5HU4HTXZ+ekOJ9bIyox6Qy2aU4rvGR
         5EeK4p3pI00GAdL+EWj56nK5YBdTf8iAw78MFuO2GVdz3CvPhHbsDZqJGLupNepIcb7V
         1nu4LqSS3cIA32n6RGjVLe1YklE6wG+lLfco6CACm1qPrfKvtXBpMVa3jqAsjbL1Yli0
         rp5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774920111; x=1775524911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        b=qYX41Z4Mo42xNMxlacd/QMopWmBw2APmtSbMo86UKr+17KCS50DAH57KCPkzRj/hu6
         vjltyH/8A6Mx9etEFr/jS4C53PjM4gu8op3BYB8fMv5b86Npzg629XRdXEvcaBm4E/vH
         PqlndsB8FgDaLZCssx3g3WVSkbDscAxDX85hzK2qPJ1KckNx532zDhryjKEJ97D39U+u
         3WSyYh/pEgv3sPpc+HcsnOspEFJilUePV4LqgnAImvQvJfFXR9ucs92mGk/INa0WIV8x
         OnN3pe1F2aknW2Ey4LN92RMY81u5l6Y8PS5Xdht1Tz62EsXfYZhIi33qKhe5ZGmW4dSN
         DcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920111; x=1775524911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asBUfDtRMKucrOKQSzjBlvbQiLLd54e8FYUI/VhTDuw=;
        b=PSQCznWasc8hLGtZsajRrG1psT+nar++w2wIP7CVdBuKg6xs846NmdtM7QGy8ZbrnD
         MT2InJZPkmlXFRemFmcYVd41ufoonnGXDIyLX6P5+qq86ckkp9x86E6S2ChIRSEiK3Fq
         auypSoK4px+fkDfljdicZkgwrEOC75wg9EDBproo3tKQlywkjtucMxgNBpo69Hzq8Q6M
         uvVsNbzYLEKmtikRT0OORpzpbHK3YYnlb0s2khX5DT82NT6xi6gRjqRHVoG9tmtoE6oi
         Clj8g+iIaUsabpKiWQamXmDqguhKoLaIAnBtqXkXxg9P1ApkPTvft0RhwHL0kVs7W8NJ
         egng==
X-Gm-Message-State: AOJu0Yz6ESHBmAM+2tobGIm9WXbD1jMRe82o3n2dV5o5ivtg9InfWLSu
	NrQisuc9KVR22CedMPouCdlfVCz+U62ZGc+zi2kC86bkszMv+bIqGRXnqKS1aRiL8KIAXHdajAk
	XboBdIskrUyTdBmvEOxC4gfmYlFTzfjQ6UAp4sbWw
X-Gm-Gg: ATEYQzxdEgoeB6J+CPsmptwr8RJu54Ua0qmlC0od2bk11mk3YPj5w43CIPP8cVwm7qv
	BgRtt2ZPr9i7Vti1dh+QvgwzyoAYA3tzNsFXUc+zw//d+x97jbhs5Y9aGv5YUZRhEcNTGs85Zvp
	GdKMBgCWXFHEwyulh4D+I49V4n20R0ny/tSez7HTfjGKCdX7M0eFG9tyRWjwWc/hPBgvvoXnHB7
	LWPOIRbY4yVZnpb9J+g+DyaRP3bDWs/59gMMkMlYk6BCGRXUPLYcR4AL1ha5KTwe1Atxmyj0071
	WGZJ38PReLW8+ZwMWKK3pBiULD6iTarNSq+F5TORbguWyc+wy1wAPCZ2pAr+i4v02V4tv4dy
X-Received: by 2002:a05:7022:2209:b0:128:ea68:27f6 with SMTP id
 a92af1059eb24-12ab28fda86mr8134739c88.36.1774920110404; Mon, 30 Mar 2026
 18:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com> <20260330215707.2374657-2-jrife@google.com>
In-Reply-To: <20260330215707.2374657-2-jrife@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 18:21:39 -0700
X-Gm-Features: AQROBzCDjrWJyJmfSCXtFAx4PFUj1XlE0JIrlHyoRlyN8IxuQEL9bzRmPAc5E0k
Message-ID: <CAAVpQUDk1ywgsuCtreVCV4yVJRm_mcjsnC-+LuUwLRLHWavtZA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when
 sk_state == TCP_ESTABLISHED
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273431-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94D6D36308D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 2:57=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Adjust lookups and scoring to keep their results equivalent to before
> even if inet_daddr+inet_dport are left intact after disconnecting a
> socket (sk_state =3D=3D TCP_CLOSE). sk_state =3D=3D TCP_ESTABLISHED impli=
es that
> *daddr is non-zero, so remove redundant checks for that at the same
> time. Note that __udp6_lib_demux_lookup already checks if sk_state =3D=3D
> TCP_ESTABLISHED, so no change was needed there [1].
>
> I could find no discernible difference in performance in
> udp4_lib_lookup2 before and after the change in compute_score.

What workload did you test the series with ?

I think we want to see results under DDoS.


>
> (AMD Ryzen 9 9900X)
>
> kprobe:udp4_lib_lookup2 {
>         @start[cpu] =3D nsecs;
> }
> kretprobe:udp4_lib_lookup2 {
>         @lookup[cpu] =3D hist(nsecs - @start[cpu], 2);
> }
>
> BEFORE
> =3D=3D=3D=3D=3D=3D
> @lookup[11]:
> [80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [96, 112)         364973 |@@@@@@@@@@@@@                                  =
     |
> [112, 128)         34261 |@                                              =
     |
> [128, 160)          7246 |                                               =
     |
> [160, 192)           215 |                                               =
     |
> [192, 224)           126 |                                               =
     |
>
> AFTER
> =3D=3D=3D=3D=3D
> @lookup[11]:
> [80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [96, 112)         340568 |@@@@@@@@@@@@                                   =
     |
> [112, 128)         30753 |@                                              =
     |
> [128, 160)          8019 |                                               =
     |
> [160, 192)           231 |                                               =
     |
> [192, 224)           157 |                                               =
     |
>
> [1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gma=
il.com/
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  net/ipv4/udp.c | 20 +++++++++++---------
>  net/ipv6/udp.c | 18 +++++++++---------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b60fad393e18..d91c587c3657 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const str=
uct net *net,
>         score =3D (sk->sk_family =3D=3D PF_INET) ? 2 : 1;
>
>         inet =3D inet_sk(sk);
> -       if (inet->inet_daddr) {
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>                 if (inet->inet_daddr !=3D saddr)
>                         return -1;
>                 score +=3D 4;
> -       }
>
> -       if (inet->inet_dport) {
> -               if (inet->inet_dport !=3D sport)
> -                       return -1;
> -               score +=3D 4;
> +               if (inet->inet_dport) {
> +                       if (inet->inet_dport !=3D sport)
> +                               return -1;
> +                       score +=3D 4;
> +               }
>         }
>
>         dev_match =3D udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
> @@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *ne=
t, const struct sock *sk,
>
>         if (!net_eq(sock_net(sk), net) ||
>             udp_sk(sk)->udp_port_hash !=3D hnum ||
> -           (inet->inet_daddr && inet->inet_daddr !=3D rmt_addr) ||
> -           (inet->inet_dport !=3D rmt_port && inet->inet_dport) ||
> +           (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +            (inet->inet_daddr !=3D rmt_addr ||
> +            (inet->inet_dport !=3D rmt_port && inet->inet_dport))) ||
>             (inet->inet_rcv_saddr && inet->inet_rcv_saddr !=3D loc_addr) =
||
>             ipv6_only_sock(sk) ||
>             !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> @@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct =
net *net,
>         ports =3D INET_COMBINED_PORTS(rmt_port, hnum);
>
>         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> -               if (inet_match(net, sk, acookie, ports, dif, sdif))
> +               if (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +                   inet_match(net, sk, acookie, ports, dif, sdif))
>                         return sk;
>                 /* Only check first socket in chain */
>                 break;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 010b909275dd..b93a9a3e7678 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const str=
uct net *net,
>         score =3D 0;
>         inet =3D inet_sk(sk);
>
> -       if (inet->inet_dport) {
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
>                 if (inet->inet_dport !=3D sport)
>                         return -1;
>                 score++;
> -       }
>
> -       if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
> -               if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> -                       return -1;
> -               score++;
> +               if (!ipv6_addr_any(&sk->sk_v6_daddr)) {

This looks unnecessary.


> +                       if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
> +                               return -1;
> +                       score++;
> +               }
>         }
>
>         bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
> @@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, c=
onst struct sock *sk,
>
>         if (udp_sk(sk)->udp_port_hash !=3D hnum ||
>             sk->sk_family !=3D PF_INET6 ||
> -           (inet->inet_dport && inet->inet_dport !=3D rmt_port) ||
> -           (!ipv6_addr_any(&sk->sk_v6_daddr) &&
> -                   !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
> +           (sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +            ((inet->inet_dport && inet->inet_dport !=3D rmt_port) ||
> +            !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
>             !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif=
, sdif) ||
>             (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
>                     !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
> --
> 2.53.0.1118.gaef5881109-goog
>

