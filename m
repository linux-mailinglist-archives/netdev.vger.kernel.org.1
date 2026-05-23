Return-Path: <netdev+bounces-291075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEbNDndxEWq5mAYAu9opvQ
	(envelope-from <netdev+bounces-291075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A85BE2B5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5687301024D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8F384CE0;
	Sat, 23 May 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElRPYG/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E5384CFF;
	Sat, 23 May 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528050; cv=none; b=HXcRyM0dWy+BctUdyKmSNHYgPrhkQd2wQYvM4rNAWagftL3XCxmrNQJ7BZ2O2T1295T8B+cG3NpswUmZs78H1e6xylopGnfxf55bvhJt9i7p1qdZXYtzdGU1FWqZTBqpTiI9wEgVnM7DeZ8birAravc1GhKgsq+uxNmnDAdgqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528050; c=relaxed/simple;
	bh=6Xcn7B7qmI0qUAv1OhGjEHP+AVU5j4UJ7/cYbjTwDsg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CCxLEUOCResnJhWNVwxTNeXyaf243GnbwobN/7A8m3Ep+AbcyRvBYe3mj9/9KREGlRZkM2r4xkj/W46iqMUpHCh/dE5jsCcEzp0ukFM7/ynrXeU4lYxALoFocAeB+z5IhHPdRYnrdNGzwFayz+Z2EoPlWN5xrjWviSWGZOBnGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElRPYG/Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D457E1F000E9;
	Sat, 23 May 2026 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779528048;
	bh=NTtAx2d+109kQ0IX+/HFrVybTb6ZAbjsIjTkxgBI4Co=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ElRPYG/Yk9DfM4SgUsSfq2X/v4ASY8iFU3cUbtW+mjDA0aHOY3P69wzfuA0RlkRwa
	 lNQpgVeT8WGCpjp/NerMSEypI7dAOofQeCF5KRyj79EwYiAiq6YkBaK1Zh1KCifl8j
	 7ym+MObvPBDrPw46Eo1kGqwOVrlS6EG7G8wuudJy7weAWwMACvj+ZGErCtc9LIdy2l
	 08gakeKVLitiXUfSLSosSSiWeGs6ujk8gElrvOHuS76Qyq6lS7dzAgRFCFOx4gjKgj
	 U3SrnDzi+knxirc+gNbT85FbA8ZyTvQ7dOJQcfbsXVkNczynJq0lT06OwOQILsf97f
	 VMn5Ft1tg/O7w==
Content-Type: multipart/mixed; boundary="===============0440544860669773859=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c22e29480bb68a660c370353b55438b66b1bcfd1ddd2b941323624a9c9f6cbfe@mail.kernel.org>
In-Reply-To: <20260523083001.2911931-9-kuniyu@google.com>
References: <20260523083001.2911931-9-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 09:20:47 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291075-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid]
X-Rspamd-Queue-Id: A68A85BE2B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0440544860669773859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 82ec2291d6f0..4041b9fc1c74 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
>  		return 0;
>  	}
>
> +	if (!skb_queue_empty(&sk->sk_receive_queue))
> +		return -EUCLEAN;
> +

Is there a TOCTOU issue here? The check occurs before acquiring
sk->sk_callback_lock, which means:

Thread A (process context)
__bpf_sock_ops_cb_flags_set()
    if (!skb_queue_empty(&sk->sk_receive_queue))  // queue is empty
        // check passes

Thread B (softirq context)
tcp_rcv_established()
    // adds packet to sk->sk_receive_queue

Thread A (continuing)
__bpf_sock_ops_cb_flags_set()
    write_lock_bh(&sk->sk_callback_lock);
    // sets bpf_sock_ops_cb_flags despite queue being non-empty

Looking at the tcp_in_sockmap() check below, it contains
lockdep_assert_held(&sk->sk_callback_lock), showing that related
validation checks are expected to be performed under this lock:

>  	if (unlikely(sk_is_mptcp(sk)))
>  		return -EOPNOTSUPP;
>
>  	write_lock_bh(&sk->sk_callback_lock);
>
>  	if (unlikely(tcp_in_sockmap(sk))) {
>  		write_unlock_bh(&sk->sk_callback_lock);
>  		return -EBUSY;
>  	}

The commit message says the goal is to "strictly prevent any potential
race conditions" by ensuring the receive queue is empty when
BPF_SOCK_OPS_RCVQ_CB is enabled. Can this check be moved after the
write_lock_bh() call to eliminate the race window?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26328541814
--===============0440544860669773859==--

