Return-Path: <netdev+bounces-41559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A687A7CB4D2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E9B21118
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C434195;
	Mon, 16 Oct 2023 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmYjLW7g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D0381A9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:38:29 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3DE9B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:38:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3954f6dcso6126073276.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697488706; x=1698093506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=42P4dDsvAvSKGIwNZvOmYDs0ORuSxxlM87KN6hrtLD0=;
        b=fmYjLW7gdmf4+zObh+UiftQcIkGFvYuaf2R0CA2fDsFcRnAif/B8rczdThKZjfGDQ+
         9dyD0u1TjSo9/DQYYJGVPKfDPFdpGzJdKLvMBpcXV14rEmcwjKwfgUS3CL3iIzk8lYJs
         h+6Itijcbsl4fw48jN6zcHGNRcmxgzRdIuNVCK26QaJKbmcjlnKzJ12tq3YnqW+JmK9Q
         ezW6dOt1+QhCkeA7j2qWUG5hZmjl4iA5azBHsmgiClXE9wBl6ZwBAjkKAC1qBvJ2A/L9
         j2XqDgGcUded4NnKVnBn7VhZ5Cx9tnIHEfJs2qdp2yedlFDA2qpKx0eglOLhEV14wmEz
         zvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488706; x=1698093506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42P4dDsvAvSKGIwNZvOmYDs0ORuSxxlM87KN6hrtLD0=;
        b=MsFx/+S7LEoaCwL+ZMCDay66YFuM+9P+XFsIJgQ9Y52S963Ciq9GirpTJ92mTPT2Un
         Ra3xYfgW/th+3LqIuldrArfmBSsPmADS3oIcgEhx9f7o/sZN+oax1Hkihn9z8TYbGWAx
         wfPmhUUv4qJzbEryWj6bszL0/6lRcah6LJWW7vId0WZe/UuAAvkZERXf+5qZnad+as71
         bKAdty00dUQJLguKB/y7As812ecr0UlK7INMYsJfhfsFHJPLW5LncIZwZfX3wPI7RR/Q
         tZ4y6uxIBDSkfwRK1S6A+mCB1HMMimQ4PCNuHag99iGHVoJAN6H0qSY03O2Cur/RgHRa
         5wPA==
X-Gm-Message-State: AOJu0YwKNz9XzfZp86EUaCj7BeAvNqEHL9cQ6DYfCFeyhWrQBLCmr3y0
	8nL+tbJtecX5QiBqtpzXRbDhZ08=
X-Google-Smtp-Source: AGHT+IFBJC21ZzwlnPuojmXXsct1gBdsNNB0JV8bT67i9SDfKY28G4YS+FVPrIQDwsmg4BkuR/UraXI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:ac07:0:b0:d89:4d2c:d846 with SMTP id
 w7-20020a25ac07000000b00d894d2cd846mr3217ybi.12.1697488706513; Mon, 16 Oct
 2023 13:38:26 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:38:25 -0700
In-Reply-To: <20231013220433.70792-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231013220433.70792-1-kuniyu@amazon.com> <20231013220433.70792-7-kuniyu@amazon.com>
Message-ID: <ZS2fQXqhjRlG64kZ@google.com>
Subject: Re: [PATCH v1 bpf-next 06/11] bpf: tcp: Add SYN Cookie validation
 SOCK_OPS hook.
From: Stanislav Fomichev <sdf@google.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13, Kuniyuki Iwashima wrote:
> This patch adds a new SOCK_OPS hook to validate arbitrary SYN Cookie.
> 
> When the kernel receives ACK for SYN Cookie, the hook is invoked with
> bpf_sock_ops.op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if the listener has
> BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().
> 
> The BPF program can access the following information to validate ISN:
> 
>   bpf_sock_ops.sk      : 4-tuple
>   bpf_sock_ops.skb     : TCP header
>   bpf_sock_ops.args[0] : ISN
> 
> The program must decode MSS and set it to bpf_sock_ops.replylong[0].
> 
> By default, the kernel validates SYN Cookie before allocating reqsk, but
> the hook is invoked after allocating reqsk to keep the user interface
> consistent with BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/tcp.h              | 12 ++++++
>  include/uapi/linux/bpf.h       | 20 +++++++---
>  net/ipv4/syncookies.c          | 73 +++++++++++++++++++++++++++-------
>  net/ipv6/syncookies.c          | 44 +++++++++++++-------
>  tools/include/uapi/linux/bpf.h | 20 +++++++---
>  5 files changed, 130 insertions(+), 39 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 676618c89bb7..90d95acdc34a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2158,6 +2158,18 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
>  	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
>  	return ops->cookie_init_seq(skb, mss);
>  }
> +
> +#ifdef CONFIG_CGROUP_BPF
> +int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
> +			   struct sk_buff *skb);
> +#else
> +static inline int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
> +					 struct sk_buff *skb)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #else
>  static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
>  					 const struct sock *sk, struct sk_buff *skb,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d3cc530613c0..e6f1507d7895 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6738,13 +6738,16 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> -	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
> +	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK
> +	 * and validates ACK for SYN Cookie.
>  	 *
> -	 * The bpf prog will be called to encode MSS into SYN Cookie with
> -	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
> +	 * The bpf prog will be first called to encode MSS into SYN Cookie
> +	 * with sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.  Then, the
> +	 * bpf prog will be called to decode MSS from SYN Cookie with
> +	 * sock_ops->op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
>  	 *
> -	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
> -	 * input and output.
> +	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
> +	 * BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB for input and output.
>  	 */
>  	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> @@ -6868,6 +6871,13 @@ enum {
>  					 *
>  					 * replylong[0]: ISN
>  					 */
> +	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
> +					 * MSS.
> +					 *
> +					 * args[0]: ISN
> +					 *
> +					 * replylong[0]: MSS
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 514f1a4abdee..b1dd415863ff 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -317,6 +317,37 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
>  
> +#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
> +int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
> +{
> +	struct bpf_sock_ops_kern sock_ops;
> +
> +	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +
> +	sock_ops.op = BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB;
> +	sock_ops.sk = req_to_sk(req);
> +	sock_ops.args[0] = tcp_rsk(req)->snt_isn;
> +
> +	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> +
> +	if (BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk))
> +		goto err;
> +
> +	if (!sock_ops.replylong[0])
> +		goto err;
> +
> +	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);

I don't see LINUX_MIB_SYNCOOKIESSENT being incremented in the
previous patch, so maybe also don't touch the mib here? The bpf
program can do the counting if needed?

Or, alternatively, add LINUX_MIB_SYNCOOKIESSENT to
the BPF_SOCK_OPS_GEN_SYNCOOKIE_CB path?

