Return-Path: <netdev+bounces-290721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDV3GmcSEGryTAYAu9opvQ
	(envelope-from <netdev+bounces-290721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F905B0798
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AA64301678B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717573A9D95;
	Fri, 22 May 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMA3q+vG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2F3A75B5;
	Fri, 22 May 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438147; cv=none; b=JWH2wqE+ybMakFKaQtyjPRIGoZdT2yS0jqd8hvh7WlGJa94+coVb3A//JXlT6EJ3d/6RmiWtB6sFG7rMI1IYRNuLu6NP2ingIFZ0iUZwvG05tHXWnE5G+Cha8hcn6NTieqHw34Kow2ramq6AxR2pTqnuuJvoko2azKihBSgAS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438147; c=relaxed/simple;
	bh=B/xGfeChgr6/kPR5j4YOpgmcwKPdHD81LbJcH8DaJ2c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fDuiEbEohR4hVYQ5ocA2b4t0XTeWjveJAfVLFKRCKxlJzXFuWKAOUyCM5kcjfGcRtg2+DNccHLkslIpqTMGPXDE2U2gxpVK2CM1/NnvEXTPc7ibqoI/bUhXdzMjHr8DYpXWA/6MRBloeJZh9n1EcBWhBXY8huLarilcQoRGmjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMA3q+vG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34701F000E9;
	Fri, 22 May 2026 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438145;
	bh=0klMbvMEy7RHVrJx+uOFj1zuxukGYA2wIZh4U69i/uw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FMA3q+vG6Am6XZUfCVz+ONQAgxPluVrLo+FAeU8qWa13lx7otEHddJsYOaSDHGv5B
	 xiQuv8UHVThqJHWAw3zaNjBkYRKXnlfP122fAKxMg7KmRK+WSiudGxCl6ANrBKIJkL
	 n/JCQ3P3HX31s16Ke2ytlDYvy1AIlUfzgUZWd/nb0RhxVPnKvbWXvyVLuT7F/YBEmg
	 xvTBf+RlGHOsyfeYARVQ9McjUYBjN1nylOxX634g+lYc2sDgX/zXH88Sdw3EHRj2UT
	 VlJMd+5FaOK7dKvY9oDAnduVG3b1AiIKjrW+YFEL4gqB6FOKj5CjFfc+oic1wPkJek
	 j9oXJOJqK7uyg==
Content-Type: multipart/mixed; boundary="===============3122944525735123887=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5d9fbf4b64d5684f423bcdb540d72734b962752adbbf69958138cfbc9c907f5a@mail.kernel.org>
In-Reply-To: <20260522074601.1658705-3-kuniyu@google.com>
References: <20260522074601.1658705-3-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 08:22:24 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290721-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,iogearbox.net,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47F905B0798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3122944525735123887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aec171ccb6ef..31130e1b63ea 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -7031,8 +7034,16 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
> +	 * and after recvmsg().  The bpf prog will be called under
> +	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };

The BPF subsystem requires multi-line comments to have the opening /* on
its own line. This comment starts with text on the same line as /*:

	/* Call bpf when TCP payload is queued to sk->sk_receive_queue

Should it be formatted as:

	/*
	 * Call bpf when TCP payload is queued to sk->sk_receive_queue
	 * and after recvmsg().  The bpf prog will be called under
	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
	 *
	 * It can be used to adjust sk->sk_rcvlowat and suppress
	 * unnecessary wakeups before sufficient data is available.
	 */

[ ... ]

> @@ -7176,6 +7187,11 @@ enum {
>  					 * sendmsg timestamp with corresponding
>  					 * tskey.
>  					 */
> +	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
> +					 * sk->sk_receive_queue and after recvmsg()
> +					 * to allow adjusting sk->sk_rcvlowat and
> +					 * to suppress early wakeups.
> +					 */
>  };

The multi-line comment here also starts with text on the same line as /*:

	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to

Should it be reformatted with the opening /* on its own line?

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..4a50fe2cd863 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>  	struct sock *sk = bpf_sock->sk;
>  	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>
> -	if (!is_locked_tcp_sock_ops(bpf_sock))
> +	if (!is_locked_tcp_sock_ops(bpf_sock) &&
> +	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
>  		return -EOPNOTSUPP;
>
>  	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
>  		return -EINVAL;
>
>  	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
>
>  	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);

The patch allows bpf_sock_ops_cb_flags_set() to modify
tcp_sk(sk)->bpf_sock_ops_cb_flags without holding the socket lock when
bpf_sock->op == BPF_SOCK_OPS_RCVQ_CB. However, the same field can also
be modified through bpf_setsockopt() which requires the socket lock.

Can there be a race between concurrent modifications?

When a BPF program in BPF_SOCK_OPS_RCVQ_CB context (unlocked) calls
bpf_sock_ops_cb_flags_set():

	bpf_sock_ops_cb_flags_set()
	    tcp_sk(sk)->bpf_sock_ops_cb_flags = val;

Another BPF program in a locked context could simultaneously call
bpf_setsockopt():

	do_tcp_setsockopt()
	    sock_owned_by_me(sk);
	    ...
	    tp->bpf_sock_ops_cb_flags = flags;

Both perform full writes (= val), not atomic operations. The
tcp_sock.bpf_sock_ops_cb_flags field is a plain u8, not atomic_t, and
no READ_ONCE/WRITE_ONCE is used. While byte writes are atomic on most
architectures, the lack of synchronization means one write can completely
overwrite the other.

Would this lead to incorrect callback flag state if two updates race?

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 37142e6d911a..3b8f392d8c69 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26275674572
--===============3122944525735123887==--

