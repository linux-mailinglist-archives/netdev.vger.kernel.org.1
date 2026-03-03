Return-Path: <netdev+bounces-263080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCOAD9GhpmlqRwAAu9opvQ
	(envelope-from <netdev+bounces-263080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:54:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E051EB3E9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4054E306145D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D804388E63;
	Tue,  3 Mar 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVhyXp60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DD282F05
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527773; cv=pass; b=PJjPG9FHdwegbgvPvhrFG20XX2Aho0OCdP6IatkY4MDsEkVaPPKkSWFqN2iwhFHKtZuB02fmjHVDExKOPd6XlfVY+wcL77c+uEYNMtB2Mxy9O2x4WWikwenzgzCQ32Uvyb4N10hWYW3mUeXAiWMdFWbgBjiiy08qj47t9BUOkBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527773; c=relaxed/simple;
	bh=1AqsvOqNRMqwYQ/YcVOH8zeiA01xGEtXh7OJ1cLbSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhMeH9wM3QvdkQGJ4DtxVREBCFx5Uuzp6BJ+k2ommJ4vFGkNR9EWmXZ3YYc7LB7InnCHlZcHRXCBDOmNrZCvGt65I2HrCLWsActhG5/4qUTssXdLDwDQPpLXrryrJGUSjIrw6d10fQq/Cziz82Dvut+vQH1lp8zqW0S39HlUJH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVhyXp60; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069df1d711so48015071cf.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 00:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772527771; cv=none;
        d=google.com; s=arc-20240605;
        b=RmKpyAl3jCYXQaL4FCwmhV0MDB5m2rRvht5lZ5fdaIHxtO2cGyuuSRcEZNADsX4zuD
         OE8TNr0/tjJCF1yWy9WQq/ZMW8w6anw4kKEIcdCqKPu1US4BhM2OpXIsBMrVWnF5MLbW
         jk+YUWnlytdQmJvoR3DfK+Yp7xrlSsAYebKCe7v6Ew7/5Xj2JpaqSArcS2kRFqMdZbZU
         RJM/7fSPXRmGFIikjDgrZ8nRJelHjSMJxgmB/rirnK++Jw12ZEeIQmQl691gXkxhRZA9
         ZY7zXm2dT9dYFVNMQia+QhP63SK+Dqk3upST1gDQc71xFibR0zd7YyChQbrsJ6VaQQXL
         EY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        fh=3QIewB4+N9LdkzYX3NRDg5t6f1ZCkmk2c2SH+VXt0lk=;
        b=fVjXn91JzZEkhOShrauS0DrAdSQ1eLW2GriRimrsA7q5FBAPvFotCKfs9roLi7j4lR
         xe1yR8+R4b7ucDATQnWyiqZRAXHN6T1ryGAGylNzGXQm2cq+SBuV2IEp9ig4HekrfRJC
         QVfs55XP7ZWGhLw2cpbGdzzisiEE+L63Qg8u434govm/2yYNWDxTjbnsoqlfIy3OcVZd
         PH0I+vny74xYtmWJ865ABscCJLb8sCK6q0XWXMYvw4ZAGXyQL4vDwI0Q7T8bA5pak6kW
         B2JT7RI0lDhsV/H4awqAt3WZPMPq6rmxBz57t9wnXqowPnIMT1QuQBrY19XkjAnhWlLg
         MMBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772527771; x=1773132571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        b=cVhyXp60zciM3AXflHDLPp5eARWYeqG6qfcTnMN6iWAHrkP8SPZjHXCG8vFLqr/0lj
         JHkB1QoDg2tHtKrOLght+nEuZedjq6mPq5CextF/86opO+U9IGD0/93MC9IxoBj+btan
         ZkX5M454fxFPTCCITQSVskfeOTbUb8xsYFduqAmeHGQ1j1wjPwTKauhWW+VGVFaVZ2iH
         NRiaCEuI1TRZ2Jco1zkSEtG6sRVhlu5IbPSOrpjlpRhJfePNJEbVWSFg/7t+3hvK97Qb
         rgiOPEqnfDqbxIFpdtUEd+Lmze/GJfxa9gF2EObU3pMnOcijOFPEYyjWZDMFn81fL2Mn
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527771; x=1773132571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJFJxH+8x5vYr/jSCBou90e7JFINIUv2cUf96EZsYn4=;
        b=OVD5wKlsYn31Fli5gwpjGpeMn7EckSBbR8LpCW4vb+VRjCxH1S5XLih9G8loz0w8f2
         m+ArO6Ql37P9C1rCnCaqE/qfSyTEr7KC813LA2rSPt03ZJi2EeWcPyVEtK8uJuv9q5NX
         00zv7rdda4sB4ajjuApJ/CYA2vE9qNTs2cJzMQAC0iCYGhc2WwRKaVdOi0R1NGktPYl+
         CW2yjBIgxHCWhF8klmr9Wkv5+HQbPrRV9GVuhzg6ynkdlR9wdnUR7sB7A/njZInz+hCf
         3zviiylyOnh/nfhZG7ulC7UyQCmnc/hAsW0radWKl2gWnOi/UdaTYzPmMcUGdo55cX73
         KXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlJjohliIzi0H4lwsNYksrTcyqEnHhm1+OGX16QVZnZ7JVGODqzLAD2IzY22sOFC1Fl9UwRRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/wj17T99aT1xPZ8f1owF0Cj8QdMY0/QyDM0nArN/8cbc5hDm
	c086jUBns/83BrJc77tWgXes3JlGiTiURzjgGUCgsZXNMj+LrW/1dApquCUuhXSLmL0esWdPQ2C
	n3HagM2Qr5hQtekArBcISM/WC3CAD+D6TCZlpvfHS
X-Gm-Gg: ATEYQzwwGaY2yLOlCqtSjQYb5eTcKPdDj2p9q0in/dZGUwdlyfqPmFuZAYK1gmhjiax
	yfIR6awKGdtAibULUlskAWrbz+vNWLTNPUqDlq2tyaSkGXNefb8YBG7pDtTTYmknVlrCe43p+xb
	a9oTmcI+/1LKriIwyv7f0/F9ny6Am+b2Kpoqyv11+bGPQ9kTRZaIjIjTcIOE4OClWfVMgbv5IoR
	Gzb99bYHjqZYzk634mAOP6OWp8Vuqrrn/3FXDhHRwt29fw5gMoH7fsBsO8nyISZRlcVdxEBF17x
	lZPaI4o=
X-Received: by 2002:a05:622a:1a9f:b0:501:45c5:935e with SMTP id
 d75a77b69052e-507526b46f9mr182579481cf.7.1772527770566; Tue, 03 Mar 2026
 00:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303074847.2814835-1-kmta1236@gmail.com>
In-Reply-To: <20260303074847.2814835-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 09:49:19 +0100
X-Gm-Features: AaiRm53vlNvYGd57BJCoo0f6cwXNmR2U51OBhyb8mBCxLXDtUTevNoI3OdqqTzk
Message-ID: <CANn89i+10Jz0BpOPdajdLccfBz5UNq9ay7qcXS0LwDaU-07ozQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: replace per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 98E051EB3E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263080-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 8:49=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> Replace memset(&opts, 0, sizeof(opts)) with targeted initialization of
> only the three fields read unconditionally by tcp_options_write() and
> bpf_skops_write_hdr_opt(): mss, num_sack_blocks, and bpf_opt_len.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so removing it reduces per-packet
> overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dn):
>
>   Before: 5 store instructions zeroing 40 bytes
>   After:  3 store instructions zeroing 4 bytes
>
> With CONFIG_MPTCP=3Dy the savings are larger: 12 stores (96 bytes) become
> 3 stores (4 bytes).
>
> A BUILD_BUG_ON guards against future field additions: if the struct size
> changes, the assertion fires and forces the developer to audit whether
> the new field needs explicit zeroing.
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 16 ++++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 326b58ff1118d..ae04c697dbacc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -965,6 +965,8 @@ static unsigned int tcp_syn_options(struct sock *sk, =
struct sk_buff *skb,
>         struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
>         bool timestamps;
>
> +       opts->options =3D 0;
> +
>         /* Better than switch (key.type) as it has static branches */
>         if (tcp_key_is_md5(key)) {
>                 timestamps =3D false;
> @@ -1549,7 +1551,20 @@ static int __tcp_transmit_skb(struct sock *sk, str=
uct sk_buff *skb,
>
>         inet =3D inet_sk(sk);
>         tcb =3D TCP_SKB_CB(skb);
> -       memset(&opts, 0, sizeof(opts));
> +       /* Only zero fields read unconditionally by tcp_options_write()
> +        * or bpf_skops_write_hdr_opt(). Other fields are set by
> +        * tcp_established_options()/tcp_syn_options() before use, or
> +        * gated behind their OPTION_* flag.
> +        *
> +        * If you add a field to tcp_out_options, this will fire =E2=80=
=94
> +        * audit whether the new field needs zeroing here.
> +        */
> +       BUILD_BUG_ON(sizeof(opts) !=3D
> +                    sizeof(struct mptcp_out_options) + 40);
> +       opts.mss =3D 0;
> +       opts.num_sack_blocks =3D 0;
> +       opts.bpf_opt_len =3D 0;
>
>         tcp_get_current_key(sk, &key);
>         if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>

Interesting idea, but the implementation is a bit fragile.

I would instead add a group in struct tcp_out_options to clearly mark
which group is zeroed in  __tcp_transmit_skb().

Partial patch to give the idea :

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 46bd48cf776a6a37e6ab2664245cd1e35a88d4f8..b96168f50170b7359d26de23891=
28bc80d4d549e
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *optio=
ns)
 }

 struct tcp_out_options {
+       /* Following group is cleared in __tcp_transmit_skb() */
+       struct_group(cleared,
+               u16 mss;                /* 0 to disable */
+               u8 bpf_opt_len;         /* length of BPF hdr option */
+               u8 num_sack_blocks;     /* number of SACK blocks to include=
 */
+       );
+
+       /* Caution : Following fields are not cleared in
__tcp_transmit_skb(). */
        u16 options;            /* bit field of OPTION_* */
-       u16 mss;                /* 0 to disable */
        u8 ws;                  /* window scale, 0 to disable */
-       u8 num_sack_blocks;     /* number of SACK blocks to include */
        u8 num_accecn_fields:7, /* number of AccECN fields needed */
           use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
        u8 hash_size;           /* bytes in hash_location */
-       u8 bpf_opt_len;         /* length of BPF hdr option */
        __u8 *hash_location;    /* temporary pointer, overloaded */
        __u32 tsval, tsecr;     /* need to include OPTION_TS */
        struct tcp_fastopen_cookie *fastopen_cookie;    /* Fast open cookie=
 */
@@ -1565,7 +1570,7 @@ static int __tcp_transmit_skb(struct sock *sk,
struct sk_buff *skb,

        inet =3D inet_sk(sk);
        tcb =3D TCP_SKB_CB(skb);
-       memset(&opts, 0, sizeof(opts));
+       memset(&opts.cleared, 0, sizeof(opts.cleared));

        tcp_get_current_key(sk, &key);
        if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {

