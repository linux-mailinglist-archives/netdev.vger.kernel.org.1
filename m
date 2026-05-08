Return-Path: <netdev+bounces-285898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xAO5AhUB/mkRmAAAu9opvQ
	(envelope-from <netdev+bounces-285898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:28:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8524F8AD6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB80C3003BCD
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074E3F2110;
	Fri,  8 May 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UooR3nWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F43FCB0F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254095; cv=none; b=lSwTfDHkCyr/wOYSsN0068zHVhKSTIqTXAvcj1uF9f2TudghAxCMfSFygDkzaHGTNB3osrmX87hePmiKyfF9M2E8NuZ+Pffk2EmECTc3H/rzlZO1aezHVKJ3XwFcuLP4OpFr7lgbYXHf2H8JXJqIO0ydZ3EROwldOpObRpunK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254095; c=relaxed/simple;
	bh=9jtb35f0crCGnnq935Yf9dvcxp3G1+Y4iwe1G29XDb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scS/ebnxnasSrf4t0y3jLM/TyObnemyxBBa6tXXgCOipRndahZiNUkvrfB2QAo9XGbWYnC0PkmiFy85kqB+rPo3wCtw6SuLYZ4Dd2ayqu4Nuk+dWv3BdQ6iXSMshz3W7oekDGSP4wFoFaR88/XUFWMIhcw1giLm/UB5zcPwr7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UooR3nWU; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c8027e876fcso849933a12.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254092; x=1778858892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRskt9O7Kxq5nmB8B2ePNGaW8SgURuNPUxawOgj0fPQ=;
        b=UooR3nWUlBPUUgCAm841fhbV9/65A8s0AG1uLSHNYYHs8dMDwrWVtSEr6dW6cQGt90
         ryIpzgDhAN34idEyZ3CnYno4SzM3OmmZMTcr2VvcuqLlV8ayhRwR7wKOn3m3AVNd4tYu
         0u1EM97aFCQV5uhTeZcUgsTyjrJERog814RqesD8GJo0EqsX8k6D4kQjH55H0eSk63hS
         3wmWhSaOFTvciaOFA2Rq/iS1x3cds76XcCtAh2lMgWXfTf3dyF73u0OktYwyOTj57gPd
         4F3LoAE2deD89dizmEHFV9PDpvcS2DVhFBDM0jOxXXpTF5ZPOCZa57EFDTVaTaLhbw4d
         WowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254092; x=1778858892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRskt9O7Kxq5nmB8B2ePNGaW8SgURuNPUxawOgj0fPQ=;
        b=kpU5jHFRzpdxm/DxCqRkqEVA25/FliBfx/AdGnKQUEUQujAFxN0o3+ZhZmDtxX2KR1
         5iGKHAzg3pwsME/NJSazOT2QOWZPMIUkuTlilHlt4PHCYurFxMsoUGvn25h5k3Qq3J3A
         b8j90rR3GMT8YvrKH4yunI+QKsdozaFCe7Hpa7ik84hqq9nQH78Zr+IpI7o06JRyrQhZ
         S3eX0QOx7lEvVXrOK59mo8u/Z5CGcW0zAjAXoOfpUuLWLvdYLuMB4pCuuSqYnM0VRuwo
         d9L/6Q8wCDVDddUCDk87VXsJe0Tbhi3sUd+M0V3GUc1B/uQt3uT8q+ANYEQAbBuU3Epa
         ENjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EUAl/NkGNIgHM7dwPHfR/TEU4PmWRLfuLkg1pFbV2KcCa4CEgkAt0Hn72aStZdNCrJMaVv1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPllb77gHqqYgAmageVaiSZz58Ms+RCeKHUpCt9CN+Cj3hjor
	QsO8cjAB9SIEWKlQNHZh1EmvW0Pf9Er542qOkewSI5G2RdmJODG3/UpJ
X-Gm-Gg: AeBDietEQtIo3Gwg21brp+5JicEeYnxGJkjObs86xE8bm5UhOv0IwZntQIQr3yOFIFP
	rA3fYmGcrigy+/YsNBRLR/by1bJkFsLLab5acssIesQ1bJVWc9t6a9lcQ/acfzVejui4ZlpK2Q/
	OcGDEcYEU9GOk5ioesb4lSfTHO+GQNTM6BEugPZ1SX03MNr1M/clxBuwSbIndI7KIjDxpsuYLaV
	WXVcDQAPWczdBp16QNeEPYvIUgChJmFzc2Zoo4ZdTJtdTvXFsFeGsE7lx77pTSP/cuyZwNI72Uv
	oV6UovejqO+F7kyBoTeIbdzBLXAeH/QLAEo/XlbGydL6HBZTs2ISFAYpPuZSSpXwhWXGOGUgcE/
	Aeb/lmalyHe3wpbM8KtNf8yzJ/9VbSINjBaJ/zTyAWr2xW+NLKG6pGsWd4o54SDgMAkBkO9N8tp
	1kQrdbSqyhZTX7Vbo=
X-Received: by 2002:a05:6a21:329f:b0:39c:1f:3211 with SMTP id adf61e73a8af0-3aa5a9a037cmr14408234637.20.1778254091698;
        Fri, 08 May 2026 08:28:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735e3fsm2134975a12.31.2026.05.08.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:28:11 -0700 (PDT)
Date: Fri, 8 May 2026 08:28:10 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
Message-ID: <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-8-kuniyu@google.com>
X-Rspamd-Queue-Id: EC8524F8AD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285898-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_sock_ops.data:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/08, Kuniyuki Iwashima wrote:
> Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> Let's invoke the BPF SOCK_OPS prog when
> 
>   1. TCP stack enqueues skb to sk->sk_receive_queue
>      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> 
>   2. TCP recvmsg() completes
>      -> __tcp_cleanup_rbuf()
> 
> This will allow the BPF prog to parse each skb and dynamically
> adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> until sufficient data (e.g., a full RPC frame) is available
> in the receive queue.
> 
> Note that the direct access to bpf_sock_ops.data is intentionally
> disabled by passing 0 as end_offset.
> 
> Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> with bpf_sock_ops because payload is not in the linear area
> with TCP header/data split on and skb may contain a RPC
> descriptor in skb frag.  This also simplifies the BPF prog.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

I was reading the series expecting to find some skb_queue_walk-like
implementation, but since it's a cgroup hook we obviously don't
need to do that.. So at this point BPF_SOCK_OPS_RCVLOWAT_CB_FLAG
is basically a "rx queue skb" hook, right? So should we make
the name more generic? There is really nothing lowat-specific
here besides your new kfunc to read the payload?

> ---
>  include/net/tcp.h       | 14 ++++++++++++++
>  net/ipv4/tcp.c          |  2 ++
>  net/ipv4/tcp_fastopen.c |  2 ++
>  net/ipv4/tcp_input.c    | 10 ++++++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4e9e634e276b..003e46c9b500 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
>  }
>  #endif
>  
> +#ifdef CONFIG_CGROUP_BPF
> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> +
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
> +		bpf_skops_rcvlowat(sk, skb);
> +}
> +#else
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +}
> +#endif
> +
>  /* From net/ipv6/syncookies.c */
>  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
>  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1d9e52fc454f..80144b97a87a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
>  		tcp_mstamp_refresh(tp);
>  		tcp_send_ack(sk);
>  	}
> +
> +	tcp_bpf_rcvlowat(sk, NULL);
>  }
>  
>  void tcp_cleanup_rbuf(struct sock *sk, int copied)
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be5513..91bf421fc5b6 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>  	TCP_SKB_CB(skb)->seq++;
>  	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
>  
> +	tcp_bpf_rcvlowat(sk, skb);
> +

I'm also not sure about the particular placement of some of these..
For example here, why do it before updating tp? Why not after?

(and same for tcp_ofo_queue)

