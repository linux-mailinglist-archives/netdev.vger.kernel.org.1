Return-Path: <netdev+bounces-276322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJNmFV8B1mk7AAgAu9opvQ
	(envelope-from <netdev+bounces-276322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F63B8057
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0031730A4AAD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3E370D71;
	Wed,  8 Apr 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLQ9xsUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012D364933
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632394; cv=pass; b=YYptuvSSlR+aEJU6qIdNZQKp2Z7EnMOFQ4vxoKiXGFsfjIjd1I6tkhURiHjClIgAwnWBVXuXwgH8miE5ARg6Rjj99uCkBig/bFtdVvvJBfaVtJErcR+KYCzJ3MUGjIzu0q7nuCJznZ8UWEjx4Of6LvxLrOMkYUboIrOydr4R/h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632394; c=relaxed/simple;
	bh=8DfKppeG1H3d2mz7ZNBcve1RSocTPbxq5tKcophCaeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvZiGlcnG1OTvXLG/gBxR0BL02p2MsG1ZoLnWqIfJpC9h7c9o2XpxeN/sJKzMhUccctJvhiPZHVP2lP9nNuc2zcwSiqZKFZXVCU/1HDeAA/qUT0Q/Z2O8a2rnmb8b78JafSKBn/OMEtRMc+S8MEpD37wbQKuIUTUZ50dkr+dNuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLQ9xsUa; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50baafd6c4aso69140231cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775632392; cv=none;
        d=google.com; s=arc-20240605;
        b=R7slBdVC2kP1ScgHZj0LEcStTlC+O4hXn1Cn52Ge4W6MyYSrLYjO7vX2th88nwgQBZ
         1zMyQx1uKNtO4Q9SXphzqweQz70wAc3hsyljZRVbIK19WsbLfAbAJqXFgdQ/RCTBnxzW
         t2cqV7cKMl3JoFc6vkYYurfpKCN7j8FjkE6252HiBD7GMlNtWmMAzBVnSy9Xvh3wuPXT
         zuzW3ZJ1l3nXjhtI+iXe3V7A0vstmhEZty2a6YtR0JqEbvfU1pOWTlRfOPt8FAqAD+JH
         iKIbHd0cU8U9aKp06t7ySh39USwP0jAojde2r++a4xi0ORja8+71epY81FMag704AjpV
         cmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMPuu1CsMpwSgSU2YTkgFjpVXHiqQVpCu0wK7JFQDNE=;
        fh=bUleJHizcpGqVAWBj6xwq+3pSeTBlWWV4qwTOumewd4=;
        b=gPFIanLDIYEy3GxbzYeqOpN55fVz+xMfenXStwxrQvquHF1boChiAv2L35mlmmFpKp
         6P1TxwoWmhTLMpv3cRD/kLkO9h/FKSNYjtghsfxiL80VLwnqpHp2hYsFRXMit7vx4d71
         dLWbOw7Q4XWScsSm0BTQF7oQszimC4VDCESX/4l5RmDsJJyFUvJVdu7MFrwvWToYO7NA
         4lvtP77m1GTzbGnKUWB65YzqdHpU4N5o35W7+E9nmGcbaiOW5+cel4rKIs9cNrFzAwOo
         HNoCbsSsfHvsaF53rjxokm0W2muIlEVZX+vwFbWUyYyVuvof/R9JtGp8Xkc4AqiwRgI/
         jMWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775632392; x=1776237192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMPuu1CsMpwSgSU2YTkgFjpVXHiqQVpCu0wK7JFQDNE=;
        b=lLQ9xsUax12ajTs9WZXiW4vh10vfKIox181mTcZ7wArsib0U79e8UqOl/+bQGpn2De
         Uw+Ep5XyCkp8i2RLwTTd617/c2MaMdf7LsufFLjdiWHkzs3624k8/hVQj5dxwNpKmqtc
         wna+u9I+6w5EuTkdbX3zbYAHVL3MO/uQs2i0KNTWY/+NOmJLP9WwFpS2c3Bo1ym174C3
         n0xjMgcp4VzOhnORcwrPbbqaO45eREX2Z85rfuKk9SJrpeA1z5fCgzgYE00c3UXGGjLT
         BXWOECEZkGXX0oK7mUjEo5gG3uSxYg20wVk4a3lfM7//36kesC4871Bk2rfpxgYsXxtg
         Wipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632392; x=1776237192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMPuu1CsMpwSgSU2YTkgFjpVXHiqQVpCu0wK7JFQDNE=;
        b=T+cHfbRJ4UEIYQa1HqKkBnUmjK1R9SP7CDuHyBQ238YaDtN1kfP0/oL2501rCKeHNY
         1c5jm/dwi4Z/3G0D44WLHyXRcP/q12QCTlW21x7QR3nlrwNiIDNENEjK4Fp8+hV/X7GF
         wcg7B7Kf1T10ummvXN6OwXJZsk3X6GzpaborXKvr+fAKvXN2iJ2oy/oQvsmP4i7e4bTG
         d4I8K/n54dF10eD+uVVYwODEESBHvS6GDO7hITavCng3P6B2qzNlbLH0hENhAE5SaTQa
         9SSVW8tj5NJRISJmgOpgy6KaK/QUE/6Cl7uOkGOHtUpNz4CUB6HjCy44QF3jnpRD5qkl
         uQAg==
X-Gm-Message-State: AOJu0YxijvNrQTeTmLxEr+ja/4LHQzZEPtzN9zEE8he93JIKMDsfUZ8g
	xROAj8a+8kfq+FpI1DYaObu+oOlQu3k0m0SdOyk+WrA7RwudbcyUGBLiLU+3MbC0FZ4EdZFn5PH
	LbTlQGBwWtWNGw67lCyN/3oq3MnGdJOu+mPPtlDGxRlh2XLYExv98D1lwKwU=
X-Gm-Gg: AeBDievhG5Gb81savdY1kaa11CzW1vONkvxfOwsO8ScG/Ws5Bcx2WDlJ1krOotNd6+u
	XXhYnzCBOli+32/JGryVc8QQHL3Y/hM2JPl4GQVtyxD2rxQdfLDD56I98OHgcjw9s35jmzqpFYK
	iCnOiIFs3NEkYybVh7i29J3rdw6x6jcmPZwF0rHuw7fg54zPbri8WTF/evzrk+HJxPL3gUW7TsI
	cvwRJcG/amZMGHAfuRwDD4LG8YJSQhKzpHr2tOhQ8fNY7SOsgFPt7ForE+BPSK6ha+cet8DYDjG
	aINg7Q==
X-Received: by 2002:a05:622a:1806:b0:50d:a8f5:1c03 with SMTP id
 d75a77b69052e-50da8f5216emr62740461cf.4.1775632391389; Wed, 08 Apr 2026
 00:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408002802.2448424-1-ntspring@meta.com> <20260408070514.1840227-1-ntspring@meta.com>
 <20260408070514.1840227-2-ntspring@meta.com>
In-Reply-To: <20260408070514.1840227-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 00:12:59 -0700
X-Gm-Features: AQROBzBwfSbb0xuJt1Kai8pL1ntw_zrzt3wpBvc8Tj02fNm8vNHA2P5GNvJfNhU
Message-ID: <CANn89i+6ZaTKZbQrjF_d0mbMkYYK4a5B_Neef9VsgpuVCsU6Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: rehash onto different ECMP path on
 retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C23F63B8057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 12:05=E2=80=AFAM Neil Spring <ntspring@meta.com> wro=
te:
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

Please make sure to wait ~24 hours between sending a new version.

Documentation/process/maintainer-netdev.rst


> ---
>  net/ipv4/tcp_input.c             |  4 +++-
>  net/ipv4/tcp_minisocks.c         | 13 +++++++++++++
>  net/ipv4/tcp_plb.c               |  1 +
>  net/ipv4/tcp_timer.c             |  1 +
>  net/ipv6/inet6_connection_sock.c | 11 +++++++++++
>  5 files changed, 29 insertions(+), 1 deletion(-)
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
> index 199f0b579e89..27edf71effc2 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -750,6 +750,19 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>                  * Reset timer after retransmitting SYNACK, similar to
>                  * the idea of fast retransmit in recovery.
>                  */
> +
> +               /* Update ir_iif to match the interface the retransmitted
> +                * SYN arrived on; inet6_csk_route_req() uses this as
> +                * flowi6_oif, constraining ECMP path for the SYN/ACK.
> +                */

Please put this part in a separate patch.

Explain why it is important that the SYN/ACK is sent on the same interface =
?

What happens if it is not ?

Why are we keeping tcp_v6_init_req() part? Would it be dead code ?

/* So that link locals have meaning */
if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
        ireq->ir_iif =3D tcp_v6_iif(skb);


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
> index 37534e116899..3fd7acbe2c49 100644
> --- a/net/ipv6/inet6_connection_sock.c
> +++ b/net/ipv6/inet6_connection_sock.c
> @@ -14,6 +14,7 @@
>  #include <linux/ipv6.h>
>  #include <linux/jhash.h>
>  #include <linux/slab.h>
> +#include <linux/tcp.h>
>
>  #include <net/addrconf.h>
>  #include <net/inet_connection_sock.h>
> @@ -48,6 +49,12 @@ struct dst_entry *inet6_csk_route_req(const struct soc=
k *sk,
>         fl6->flowi6_uid =3D sk_uid(sk);
>         security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
>
> +       /* Use the request socket's txhash (re-rolled by tcp_rtx_synack()=
)
> +        * for ECMP path selection; >> 1 for 31-bit mp_hash range.
> +        */
> +       if (tcp_rsk(req)->txhash)
> +               fl6->mp_hash =3D tcp_rsk(req)->txhash >> 1;
> +
>         if (!dst) {
>                 dst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_=
p);
>                 if (IS_ERR(dst))
> @@ -70,6 +77,10 @@ struct dst_entry *inet6_csk_route_socket(struct sock *=
sk,
>         fl6->saddr =3D np->saddr;
>         fl6->flowlabel =3D np->flow_label;
>         IP6_ECN_flow_xmit(sk, fl6->flowlabel);
> +
> +       /* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
> +       if (sk->sk_txhash)

Why is the test needed ?
Note that because of the right shift ,  sk_txhash =3D=3D 1 would become 0 a=
nyway.

> +               fl6->mp_hash =3D sk->sk_txhash >> 1;
>         fl6->flowi6_oif =3D sk->sk_bound_dev_if;
>         fl6->flowi6_mark =3D sk->sk_mark;
>         fl6->fl6_sport =3D inet->inet_sport;
> --
> 2.52.0
>

