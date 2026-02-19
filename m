Return-Path: <netdev+bounces-259546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDjKDzhSl2kzxAIAu9opvQ
	(envelope-from <netdev+bounces-259546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:11:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E51617CA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A96301BF61
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558C3502B6;
	Thu, 19 Feb 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiEqsA2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF480235071;
	Thu, 19 Feb 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524659; cv=none; b=hEbmAnDiqqGiLHJooIKvRxrVj/iGdANygcXy5f6jNEPSKa5mknJ8/yRyLoz3sEWyVELVy0QVCjYfxN/OOij0+5BY0L56ua6aZIhgt7C5agp8MMTg39zZ3S14E1iFxpZW9cCJEbw/v7stVwcoSr+zIirEDLmuZ9837FJANWvHp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524659; c=relaxed/simple;
	bh=ZdR+XCWWCEE+0mQLk/14clIF1WSqOWjK0Y7yNhb9UUc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sQaPpV2S0zYlKJ86vnnB1xRqwrS7RTNTSDQA+bKHE0jp6mM/AHZ9htEcdANWI7mJWZ5n4z7OPShkM+1VFWm7wKwYHD7+QaEjAc9L4yHtoveuGvY43WmPrSb49HmgUaOXsaWJ8zWMOpJqgvJ5cvBcvJE1J/W3aph9ez7HHX6RxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiEqsA2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151DDC4CEF7;
	Thu, 19 Feb 2026 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771524659;
	bh=ZdR+XCWWCEE+0mQLk/14clIF1WSqOWjK0Y7yNhb9UUc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IiEqsA2M94+iRE5Y7F3CJrCsL8irEKRxD/xKNmbzfiFzyXpk/Q0epRqe8guFbY8BH
	 hCZ1DcvT+Or8VtpxfmoDUSr8DyhQf/mRL8wYWsKev0wMafyfcS+k8Mnmf+JgQct1Au
	 CsiazsyL+aYwo5G1R9VzoNw31VXuLEPn2yyHkb/DODINs860KUsPbgMpcaZn9Ka7/M
	 Ji+ZtetZgg1+seI8AOZGKqP0MTPTKpclWA3wmdkxrzeZqZpwgmFSM+O7XFSSpzlxCu
	 WfVSw8bK7f8nWtl/vRYT2cm/im3HscJdOfHCpjIbjewaXgkMQbmn3Bg+vJAjaP/cYJ
	 wOwDtGgiy+DIQ==
Content-Type: multipart/mixed; boundary="===============1189534981472302392=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b8d59a7285647804e2c8484dc8cb118abf0ecd69657edab42393389088e349c5@mail.kernel.org>
In-Reply-To: <20260219173756.315077-7-kuniyu@google.com>
References: <20260219173756.315077-7-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: willemdebruijn.kernel@gmail.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 19 Feb 2026 18:10:59 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259546-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,syzkaller.appspotmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994E51617CA
X-Rspamd-Action: no action

--===============1189534981472302392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
>  {
>  	struct sock *sk = psock->sk;
> +	bool is_udp = sk_is_udp(sk);
>  	struct sk_msg *msg;
>  	int err = -EAGAIN;
>
> @@ -583,12 +585,15 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	if (!msg)
>  		goto out;
>
> -	if (skb->sk != sk) {
> +	if (is_udp)
> +		spin_lock_bh(&sk->sk_receive_queue.lock);
> +
> +	if (skb->sk != sk || is_udp) {
>  		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> -			goto free;
> +			goto unlock;
>
>  		if (!sk_rmem_schedule(sk, skb, skb->truesize))
> -			goto free;
> +			goto unlock;
>  	}

[ ... ]

>  	skb_set_owner_r(skb, sk);
                        ^^^

If sk_psock_skb_ingress_enqueue() fails after this point (for
example, skb_to_sgvec() fails and skb_linearize() also fails under
GFP_ATOMIC memory pressure), the error path frees msg and returns
-EAGAIN, but the skb is kept with skb->destructor set to
udp_sock_rfree.

The caller sk_psock_verdict_apply() then queues this skb onto
psock->ingress_skb for retry via sk_psock_backlog().

On retry, sk_psock_handle_skb() calls sk_psock_skb_ingress()
again. The function acquires sk->sk_receive_queue.lock, then calls
skb_set_owner_r() which calls skb_orphan(). skb_orphan() invokes
the current skb->destructor, which is now udp_sock_rfree():

  sk_psock_skb_ingress()
    spin_lock_bh(&sk->sk_receive_queue.lock)   <-- held
    skb_set_owner_r(skb, sk)
      skb_orphan(skb)
        skb->destructor(skb)           [= udp_sock_rfree]
          spin_lock_bh(&sk->sk_receive_queue.lock)  <-- deadlock

Could this self-deadlock on the receive queue lock?

> +	if (is_udp) {
> +		skb->destructor = udp_sock_rfree;
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
> +	}
> +
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>  	if (err < 0)
>  		goto free;
>  out:
>  	return err;
> +
> +unlock:
> +	if (is_udp)
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
>  free:
>  	kfree(msg);
>  	goto out;

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

[ ... ]

> +void udp_sock_rfree(struct sk_buff *skb)
> +{
> +	struct sock *sk = skb->sk;
> +
> +	spin_lock_bh(&sk->sk_receive_queue.lock);
> +	sock_rfree(skb);
> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22193327667

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep understanding of UDP memory accounting internals and references a specific syzbot report, consistent with an experienced kernel networking developer.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Self-deadlock on sk->sk_receive_queue.lock when sk_psock_skb_ingress is retried after enqueue failure for UDP, causing a system hang.

--===============1189534981472302392==--

