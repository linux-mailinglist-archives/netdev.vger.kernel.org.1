Return-Path: <netdev+bounces-258805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLZWAbc/kml8sQEAu9opvQ
	(envelope-from <netdev+bounces-258805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:50:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12513FD2C
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAEF3028812
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3B2BEC34;
	Sun, 15 Feb 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGmZd2Ta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAA23C4FA;
	Sun, 15 Feb 2026 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771192244; cv=none; b=prwKyMAHnm3GP4Cmvn6P1+D9xTlfvpbGmqd0WDoQlvuojATFZZ2mfY1ZVUOAi+ufLhy6Z05HiUK56/dx+y2Fd3KmQw/d7TNK3Ha2pNLkRkXm9kxkj9WSHbIIoKjnEw6bqf2PqQjtYOfwFuQ+oNfyOo658LpkN3wefEeGDABZJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771192244; c=relaxed/simple;
	bh=Dtf+8iAY0/nR0Q1UvYDCOzOiMW4PSm3WaauDupv65LU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OTlmG9yDN5em5890JKFKSO1UggoaQz2DZwuN0dX6pVMAazt2KPfbWYOvGoHguOM5K/+opQqpBaN916awvMjBzV2pmbX7TUUsfTgsCumROSHN2+9hmEUhxgqa8RMMLrcLT8unBt/sG98ONv0/1vKhgzNrHeuDz0lkUi/AqFX2do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGmZd2Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD3C4CEF7;
	Sun, 15 Feb 2026 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771192243;
	bh=Dtf+8iAY0/nR0Q1UvYDCOzOiMW4PSm3WaauDupv65LU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HGmZd2TayGfTVjnC6M4T0MtMekwYqP2xEApEHXKgi00h7y1zKt0UNUS8btbBMd7S3
	 TL0WQ3XSc+98f3pF4DGDw8jbgn6dzoz5DoUKZQwCNjaPcjRtTT3sJxOecRbFfCwSDL
	 fC73vjQwPoSa94b5t29EAepiCqTO0SqtSZb4xTED6AAoVnVi8dDJxaf2T4BJdhJYnM
	 OqZnJItNUKIdoErFfIj0D3qW191z9q1xCHhEXFU5aBdNA7Y16ol67S6ANyQMxpsCRL
	 OeoQY/+2qIk+Im/eQB6edop8p4ZFWwlxH189stkXeTs/v4Rv9UdOxJUWMhB8YVLtZY
	 DWTLTXnrUfBlw==
Content-Type: multipart/mixed; boundary="===============0197281021437678642=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e28e4c337ddd569844020f2a999c7becc918fa9cfe2a0e0fa21ca363d3bb1f7@mail.kernel.org>
In-Reply-To: <20260215204353.3645744-6-kuniyu@google.com>
References: <20260215204353.3645744-6-kuniyu@google.com>
Subject: Re: [PATCH v1 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: willemdebruijn.kernel@gmail.com,cong.wang@bytedance.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 15 Feb 2026 21:50:43 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258805-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 5A12513FD2C
X-Rspamd-Action: no action

--===============0197281021437678642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>-				u32 off, u32 len, gfp_t gfp_flags)
>+				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
> {
> 	struct sock *sk = psock->sk;
> 	struct sk_msg *msg;
> 	int err = -EAGAIN;
>
> 	msg = alloc_sk_msg(gfp_flags);
> 	if (!msg)
> 		goto out;

[ ... ]

> 	skb_set_owner_r(skb, sk);
>-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
>+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);

[ ... ]

>-/* Puts an skb on the ingress queue of the socket already assigned to the
>- * skb. In this case we do not need to check memory limits or skb_set_owner_r
>- * because the skb is already accounted for here.
>- */
>-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
>-				     u32 off, u32 len, bool take_ref)
>-{
>-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
>-	struct sock *sk = psock->sk;
>-	int err;
>-
>-	if (unlikely(!msg))
>-		return -EAGAIN;
>-	skb_set_owner_r(skb, sk);
>-
>-	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
>-	 * data originates from the socket's own protocol stack. No need to
>-	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
>-	 */
>-	msg->sk = sk;

The consolidated sk_psock_skb_ingress() does not carry forward this
msg->sk = sk assignment. alloc_sk_msg() uses kzalloc, so msg->sk
will be NULL for self-ingress messages.

In __sk_msg_recvmsg(), the from_self flag is set based on msg->sk:

    from_self = msg_rx->sk == sk;

This controls copied_from_self accumulation, which
tcp_bpf_recvmsg_parser() uses to advance tcp->copied_seq:

    seq += copied_from_self;
    ...
    WRITE_ONCE(tcp->copied_seq, seq);

With msg->sk now always NULL, copied_from_self will always be zero
for TCP sockets using a BPF verdict program that returns SK_PASS.
tcp->copied_seq won't advance, which would affect TCP receive window
advertisement.

Should this assignment be preserved in the consolidated function
when skb->sk == sk?

>-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>-	if (err < 0)
>-		kfree(msg);
>-	return err;
>-}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22042899757

AI-authorship-score: low
AI-authorship-explanation: Commit is part of a coherent series from a known kernel maintainer addressing specific syzbot bugs, with typical kernel commit style and mechanical refactoring consistent with human development workflow.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Dropped msg->sk assignment breaks TCP copied_seq tracking for sockmap verdict SK_PASS path, affecting TCP receive window advertisement and potentially stalling connections under sustained traffic.

--===============0197281021437678642==--

