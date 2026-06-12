Return-Path: <netdev+bounces-298438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qX9pDq1qK2qe9AMAu9opvQ
	(envelope-from <netdev+bounces-298438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE56763E1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HthUEHhU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298438-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE963112E55
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27C376475;
	Fri, 12 Jun 2026 02:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDF374A1B;
	Fri, 12 Jun 2026 02:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230250; cv=none; b=JIO+zsLciigIgnQZUqANKqmTG2MLMCaKiRH2UTM+92bsvVpA1/cflTXVS7bTXsqyBy8Oc4F6rV28ABy+zPOOALHEr9e+BPUn9FGXJRGQYydl3VBjRiABPryXTVAmQrpS2y+sq68vnYHP+g5njlqlvq62qU8bJSdkFHSzzFwBqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230250; c=relaxed/simple;
	bh=wwbF+tsZQrpd6kwFDfZR5ljQW6+9hebJQLVJMjVNQFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fHhuyt68y6zUF4mgDWtc+C6v5EzFRjhXprPfOrZnZo3SPqJAnA0LVA0tycWP5RJz5jcMcvoOeApajOemYNvhrHmA+VGRSoFwIzUW4yNOdJ+jplZ0j+2enn5IP3dim+LwjaWodkt6Fynn0xxRD5UI7ew3vXSkvENX11Rg3MK+3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HthUEHhU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BE41F000E9;
	Fri, 12 Jun 2026 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781230248;
	bh=cVQ9qlqsIn4q8GxhJe6rtO+ljHE4Bqr7eLlZm7l2/gM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HthUEHhUWtgnfRNg+aAbVQjzbsIsiIjrQrIAFgN9+lrW6nAzK8V3NKY1JAVDJXULA
	 wjovXDkzIMilC84BziWCNo6gSA7Gd9SlwPLeeF0dTYI3530skdTzHi3mUC1d3qvOaP
	 Xn2iFCy75CNKu/JrLHibeaSQpyPx/KqmDb9f1aQ5kxia6VVlm//1lTbeWx1L2ee4a9
	 EfR7slKI8oEuQL0jp77fT8de/HfOn5E/B44saBlHRyPtw2dYhqzV1aHQ22XDV9rZHM
	 +L71qKvxBi9UHTUmGe6CqKc3YFCmtcJUi1RE07/RgKB9RXtDQiltPGpPAzS09kjMFW
	 xigKGC98B3sDQ==
Content-Type: multipart/mixed; boundary="===============5717406214657926375=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe2e906f9235c7786e45b393a48da682d9adaaed96389cbb109e3132b63ef783@mail.kernel.org>
In-Reply-To: <20260612011452.134466-2-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-2-xiyou.wangcong@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/5] tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback splice
From: bot+bpf-ci@kernel.org
To: xiyou.wangcong@gmail.com,netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,hemanthmalla@gmail.com,zijianzhang@bytedance.com,xiyou.wangcong@gmail.com,cwang@multikernel.io,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 12 Jun 2026 02:10:48 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-298438-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com,multikernel.io,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS(0.00)[m:xiyou.wangcong@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:cwang@multikernel.io,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:xiyouwangcong@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82AE56763E1

--===============5717406214657926375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..549f37077244 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -756,4 +814,753 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>  		newsk->sk_prot = sk->sk_prot_creator;
>  }
>
> +static int splice_send_ring(struct sock *sk, struct sk_psock *psock,
> +			    struct msghdr *msg, size_t size, int flags)
> +{
> +	struct sk_psock_splice *self_s, *peer_s;
> +	struct sk_psock *peer;
> +	int total = 0;
> +
> +	if (msg->msg_flags & MSG_OOB)
> +		return 0;
> +
> +	self_s = rcu_dereference_protected(psock->splice, 1);
> +	if (!self_s)
> +		return 0;
> +
> +	while (size > 0) {
> +		size_t done, space = 0;
> +
> +		/* All peer / peer->sk accesses happen under RCU. If the ring
> +		 * has space, grab the peer's ring_ref before dropping RCU: that
> +		 * pins peer_s (and its ring) so the copy below can run outside
> +		 * RCU and fault/sleep normally. peer_sk is *not* pinned by the
> +		 * ref, so it must not be touched after rcu_read_unlock().
> +		 */
> +		peer_s = NULL;
> +		rcu_read_lock();
> +		peer = rcu_dereference(self_s->peer);
> +		if (peer) {
> +			struct sock *peer_sk = peer->sk;
> +			struct sk_psock_splice *ps = rcu_dereference(peer->splice);
> +
> +			if (ps && READ_ONCE(ps->ring_buf) &&
> +			    !sk->sk_err && !(sk->sk_shutdown & SEND_SHUTDOWN) &&
> +			    skb_queue_empty(&peer_sk->sk_receive_queue)) {
> +				space = splice_ring_space(ps);
> +				if (space && percpu_ref_tryget_live(&ps->ring_ref))
> +					peer_s = ps;
> +			}
> +		}
> +		rcu_read_unlock();
> +		if (!peer_s)
> +			break;
> +
> +		/* Holding peer_s->ring_ref: peer_s and its ring stay alive.
> +		 * The copy touches only the ring, never peer_sk, so a normal
> +		 * faulting copy is safe here.
> +		 */
> +		done = splice_ring_write(peer_s, &msg->msg_iter,
> +					 min(size, space));
> +		percpu_ref_put(&peer_s->ring_ref);
> +
> +		if (!done)
> +			break;
> +		total += done;
> +		size  -= done;
> +	}
> +
> +	/* Wake exactly once, after the loop, re-deref'ing peer under RCU.
> +	 * Doing this inside the loop would carry the _sync hint repeatedly
> +	 * and cost a redundant wake per wraparound iteration.
> +	 */
> +	if (total) {
> +		rcu_read_lock();
> +		peer = rcu_dereference(self_s->peer);
> +		if (peer)
> +			splice_wake_sync(peer->sk);
> +		rcu_read_unlock();
> +	}
> +	return total;
> +}

Is the flags parameter needed? The function signature includes an int
flags parameter, but the function body never references it. The only
flag checked is msg->msg_flags for MSG_OOB.

The caller tcp_bpf_splice_sendmsg computes this value as:

int flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED) |
            MSG_NO_SHARED_FRAGS;

but it appears to go unused. Should it be dropped from the signature,
or is there intended handling that was omitted?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27388683867
--===============5717406214657926375==--

