Return-Path: <netdev+bounces-276226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKL0Hw+r1Wm28gcAu9opvQ
	(envelope-from <netdev+bounces-276226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2B3B5DDE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C678130488F6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A852E22BD;
	Wed,  8 Apr 2026 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2+xOnLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C733FE0F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610600; cv=pass; b=TtOze2XFw6cKT9d6JMyeOLG+APuApyGTDH5Ds/sqgPgBif0Lqt6WZWstCsd1jQMG9PZ12RilLUAU8XuhgEwaeWZDpNn4vakZU7jJFMYk02veXU0xoEX6WdxogxMMUUqvSE19jR8Nl5a0j5rzEfIMFQQeB9bWFGUpTAic+pXvoWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610600; c=relaxed/simple;
	bh=HLGbLzprX3o7Q33ND9CNMaeFSbXEBCSoLXtKU9cKgOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkndbfFtJvikFXgh3zDlD2DKYh1IG6KOP/HkSIN+pBLfV6qrhsfJfe9vFn9DH15H4M1HCzxNkEM87eRfHu+4xLjEU16l4Wbd1t1hprABxfcEQv3tHdhd54f6I8Demh+QuQm03UVF5d4fcOBKJmGkcCgiwynJIPY/TEF78SezEWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2+xOnLL; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so3975756d6.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 18:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775610598; cv=none;
        d=google.com; s=arc-20240605;
        b=G3GYI9K9tr3DU1vaYphO0e/wr93+7x+7hFD+NxYV0t9eHSc4zK0gZ8F8tKS8hQs/nQ
         U2p+e+cW66Pz49E0c85f3YMuFeev6fQU3/goZzjPbRedeno1r95atkKqvZGEJipA3K2Z
         MTvpO6yJgKb7TShnBts0Ur8S9Z/k8C48P+b3GTLbAC29vdmtxsG78ISi6HJNEOWGhrIJ
         Lc8ehbBHqidM7l3SfF4eqVkIt+G5aUVZJTuMM+97sgFPG4sRAoBUDG2XqdHriUwzX1ug
         Ht/GJn0TGTdJd+Vg5+ef2S2rmuwS1zSRlkeVgS1Yu2U0TzAyTWEpRkjoc15iZgs7EVoT
         Tqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CnllyHcmL42d+sntBlRrvIMxVfxG4aHz1wIWuprY20=;
        fh=daX/rpnO3wVEtWgQX86pnbZS+22UyzTs3Iv1lKBwrck=;
        b=JW+XCSczMUqUNys3FKs7xnE6ImgarbLi2hJgY4TMoWTFSXNIyaR3onBK3SreUtxsDM
         UWfUSgvwQK6+zqfcBfw6hEBu+P9PImypIArGDdBBdHgBDlsZVSrKjOzLh6kWVyV8y9jK
         NLVFtCmgj24dmXYOxnbA2YdfnQMFcjkXT/ri6c6xaohUYSrijGU/ae1dWJIoffZvk3nk
         d8x+yB+3pnNpFDGk/c+w06ngq75sm/vaq9H/5DTVh3Z05yIE2oqoz+8i4ycqed1CVnVl
         /8gworL5FFWsGXJF9FpN7YoGApMFHUvKLNShUK3IQ5eucuCcQ+q2A9XHlY70+3Os4tOC
         cZug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775610598; x=1776215398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CnllyHcmL42d+sntBlRrvIMxVfxG4aHz1wIWuprY20=;
        b=v2+xOnLLwtD3Uq1OYFZNmrlkqpgxjaGtubRS4fgVbZEvuH2D2cczg5IOyxcxPiHymc
         DCakWlfS1ykAK+2syumq54mzAgyLQ4c8t66I8bGmmyp2GbOIHgsZZVBTjJf31xdHOD1X
         BLGLc54kG6r1Pwv9SUmOxWgqKbiJHaOC3FnRaDs4iP2+9XbXhtLjlfdnW/Ji2PjHr/XT
         y+L96LY0kpjxbZ8pFZeEjyLbC0u9tfDNlOAuj0F5F9LfC3epRyqJZJ5JuIC+QoXkMSDd
         igolou9YUH+siEmqNJ7UOGQ2W1sUeyhB+3K1BStJ/Jt1KR6ZXyAVOawqIQsxSGFoVVX9
         6Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775610598; x=1776215398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CnllyHcmL42d+sntBlRrvIMxVfxG4aHz1wIWuprY20=;
        b=LJA8+AIAlV4VKZYjxx3UPeao5H1i/xdTdECx3h9CzSgkLamQg8/Fu0zFdRs6PLRe/a
         vHOILlA1/SImWx7T5wcB8NKY65T/lJu0vZhv1/Er2e/ULk5Pn/ckVc1zunglzgGMR3+P
         N+Qjr/0TmlVt4fhw2lYqMVUJyDIgkcJd+rQQHMXf0FztjLnkNcqrj23MFzmY40W1FaHm
         XXCweNc1hpnkbrlXz2Nba8bIxEQmCMUQ0chWJlBUdH7hrwC2Q2MVwFn09iCUqm5Ls5S7
         06pTwphLqyODP6iN0KMhmYjsDP3FS9hoiYdacFOYW4sw3sIS8buZ0KT0vx8mZJqtJcDs
         AEBg==
X-Gm-Message-State: AOJu0Yz3C2ozyxkGnwnrNcpT9mOBhahgLzYaQn4ImEbzcOXymGui/3G5
	VJwTtGn3SsuJwg2z4n2nFwCl4C1fw96xsKDlcgpLmTvtac4hRHalxizFmbJ8nnFuO9rTsLqcbms
	AMOMKICWL0vNLYuLbmd146Pj8EIwjfkcRoR22Qvhc8KdQJL7YrDL5ghDsv4Y=
X-Gm-Gg: AeBDietnhV43IAJjMm5p0+jguqNoH3ef6DBcr/U4LGnvY1+GGi7Z7jPgWh2jl4Tn3ie
	Rx008a7weqo9akX/5iG2VJi+V9MHvvpUOmnE0YcoKutqrzHQOD+nmzcveDhEOx9oxjzPFxKSosf
	I0IOiKdAcfnIVAMq3gNbyYZzaGRQBxFIy78el+/J/s82odz9S0O7NzvwU8neBGX9QyT+cK+lg0o
	MK8CaIttDyT2HZRB8TyUDjw7/ywvmiOpn33lvHTmuVkkepZ/jadSO3LJReLAzhdM8ozpvWX3HVj
	tT7w/w==
X-Received: by 2002:a05:6214:300b:b0:89c:ac42:e119 with SMTP id
 6a1803df08f44-8a5eb234eafmr309305806d6.8.1775610597101; Tue, 07 Apr 2026
 18:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408002802.2448424-1-ntspring@meta.com> <20260408002802.2448424-2-ntspring@meta.com>
In-Reply-To: <20260408002802.2448424-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 18:09:45 -0700
X-Gm-Features: AQROBzDN6Bjc7JHGf3pJNRJZD6llfhcIh61WMtfBNKyiuVxyBGROyIH2L8JlWyo
Message-ID: <CANn89iKEgkbS=FEssas9upr4kTpAuH2PRehthBC4Oc4bBfW8hQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: rehash onto different ECMP path on
 retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276226-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 00E2B3B5DDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 5:28=E2=80=AFPM Neil Spring <ntspring@meta.com> wrot=
e:
>
> Add sk_dst_reset() alongside sk_rethink_txhash() in the RTO, PLB,
> and spurious-retrans paths so that the next transmit triggers a fresh
> route lookup.  Propagate sk_txhash into fl6->mp_hash in
> inet6_csk_route_req() and inet6_csk_route_socket() so
> fib6_select_path() uses the socket's current hash for ECMP selection.
>
> The ir_iif update in tcp_check_req() covers both IPv4 and IPv6
> because it was cleaner than gating on address family; IPv4 is
> otherwise unaltered, and not having autoflowlabel in IPv4 means
> I wouldn't expect a new path on timeout.
>
> It is possible that PLB does not need this (that there are other
> methods of reacting to local congestion); I added the sk_dst_reset
> for consistency.
>
> Signed-off-by: Neil Spring <ntspring@meta.com>
> ---
>  net/ipv4/tcp_input.c             | 4 +++-
>  net/ipv4/tcp_minisocks.c         | 9 +++++++++
>  net/ipv4/tcp_plb.c               | 1 +
>  net/ipv4/tcp_timer.c             | 1 +
>  net/ipv6/inet6_connection_sock.c | 8 ++++++++
>  5 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7171442c3ed7..3d42ab45066c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5014,8 +5014,10 @@ static void tcp_rcv_spurious_retrans(struct sock *=
sk,
>             skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>             (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=3D
>              ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
> -           sk_rethink_txhash(sk))
> +           sk_rethink_txhash(sk)) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREH=
ASH);
> +               sk_dst_reset(sk);
> +       }
>
>         /* Save last flowlabel after a spurious retrans. */
>         tcp_save_lrcv_flowlabel(sk, skb);
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 199f0b579e89..ef4b3771e9d8 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -750,6 +750,15 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>                  * Reset timer after retransmitting SYNACK, similar to
>                  * the idea of fast retransmit in recovery.
>                  */
> +

What is the following part doing?
tcp_v6_init_req() uses something quite different before setting ir_iif
A comment explaining the rationale would be nice.

> +#if IS_ENABLED(CONFIG_IPV6)
> +               if (sk->sk_family =3D=3D AF_INET6)
> +                       inet_rsk(req)->ir_iif =3D tcp_v6_iif(skb);
> +               else
> +#endif
> +                       inet_rsk(req)->ir_iif =3D
> +                               inet_request_bound_dev_if(sk, skb);
> +
>                 if (!tcp_oow_rate_limited(sock_net(sk), skb,
>                                           LINUX_MIB_TCPACKSKIPPEDSYNRECV,
>                                           &tcp_rsk(req)->last_oow_ack_tim=
e)) {
> diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
> index 68ccdb9a5412..d7cc00a58e53 100644
> --- a/net/ipv4/tcp_plb.c
> +++ b/net/ipv4/tcp_plb.c
> @@ -79,6 +79,7 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_p=
lb_state *plb)
>                 return;
>
>         sk_rethink_txhash(sk);
> +       sk_dst_reset(sk);
>         plb->consec_cong_rounds =3D 0;
>         tcp_sk(sk)->plb_rehash++;
>         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index ea99988795e7..acc22fc532c2 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -299,6 +299,7 @@ static int tcp_write_timeout(struct sock *sk)
>         if (sk_rethink_txhash(sk)) {
>                 tp->timeout_rehash++;
>                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH)=
;
> +               sk_dst_reset(sk);
>         }
>
>         return 0;
> diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection=
_sock.c
> index 37534e116899..2fe753bb38b4 100644
> --- a/net/ipv6/inet6_connection_sock.c
> +++ b/net/ipv6/inet6_connection_sock.c
> @@ -48,6 +48,11 @@ struct dst_entry *inet6_csk_route_req(const struct soc=
k *sk,
>         fl6->flowi6_uid =3D sk_uid(sk);
>         security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
>
> +       if (req->num_retrans)
> +               fl6->mp_hash =3D jhash_1word(req->num_retrans,
> +                                          (__force u32)ireq->ir_rmt_port=
)
> +                               >> 1;

Why not setting mp_hash to sk_txhash ?

Why are you using ">> 1" ?

rt6_multipath_hash() seems to be bypassed, it might be time to add a
comment there
explaining that mp_hash needs to be 31-bit only...

Perhaps use rt6_multipath_hash() and expand it to use a socket pointer
to retrieve sk->sk_txhash when/if possible
instead of yet another flow dissection.

> +
>         if (!dst) {
>                 dst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_=
p);
>                 if (IS_ERR(dst))
> @@ -70,6 +75,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *s=
k,
>         fl6->saddr =3D np->saddr;
>         fl6->flowlabel =3D np->flow_label;
>         IP6_ECN_flow_xmit(sk, fl6->flowlabel);
> +
> +       if (sk->sk_txhash)
> +               fl6->mp_hash =3D sk->sk_txhash >> 1;

Seems inconsistent, and same question about the right shift.


>         fl6->flowi6_oif =3D sk->sk_bound_dev_if;
>         fl6->flowi6_mark =3D sk->sk_mark;
>         fl6->fl6_sport =3D inet->inet_sport;
> --
> 2.52.0
>

