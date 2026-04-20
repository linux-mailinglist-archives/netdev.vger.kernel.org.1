Return-Path: <netdev+bounces-279885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sARsIEVt5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE04329D8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57D63301E3EB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E623A6EFA;
	Mon, 20 Apr 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnyggAXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B43A6EE1;
	Mon, 20 Apr 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706637; cv=none; b=KX+rOmVKZitOdZPbPLHaloJZgsmv8eMQ70G18gHOAbJI5FI5+YSDzONgEIn+vmqSSakvwjAEeFpP9kkIe5r/ZtgWBz0Tm7PcZehDKorseh/op3JMHdce0JF1dLwCrvuV5qPFBfRKSqMHL4z87SnxroFmB1WP/HJKpIRCeu+MKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706637; c=relaxed/simple;
	bh=KqxQbOQ+N7Meg/QYWsIPuGwiBTXOMWIPiL0SLZyZIPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG+Oli/oOVM/9If7tadQ/yd7esG7RNf3y2i0aSl1ArovTOCiagohheUkYn6IChQUqw5jbMelN0TvvB6DXnryUbq1lonbgmeIwyRYxvIXSZ8dxaQNyKb2Rx1vlOc79MmdeDdmwC3b1H9wdANTfiimYWYsmOnA33j0Ht0NtM3Q52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnyggAXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10638C19425;
	Mon, 20 Apr 2026 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706636;
	bh=KqxQbOQ+N7Meg/QYWsIPuGwiBTXOMWIPiL0SLZyZIPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LnyggAXEOE94OSoiZ8rJ9sL0ZIF+z07SCfya9KwB4IJ7ny8X2aJH1NFAjHvb8kDl3
	 +dWo6HL+VitOlSfSJHXNx6rOLYQZ3ya6/SZTmOpO0t5Sf7K9naWthJJ+UmumlSff9f
	 taWGArtQ2Qtv0sHC66v5a5EZysgtE0NXJrxoTO8MJwF+W56ZmnkhYqF/FoKkrkYJ9J
	 oBjC+m8q7OsDC8BhFNsEXsjoDL3vayy6V2kLGDEPSnlydhTdymHEdxvtCm3F6uC2zo
	 TTn5lu0Mhq9urnpwJuBs3RS0a0fsvvWc7DD0QPEbEMWJbtmTNOnf1vFXNvYUgH28JO
	 MHvKu0t51YbAA==
Date: Mon, 20 Apr 2026 10:37:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Kees Cook <kees@kernel.org>, Feng Yang
 <yangfeng@kylinos.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netlink: clean up failed initial dump-start
 state
Message-ID: <20260420103715.347fbd4a@kernel.org>
In-Reply-To: <20260420162734.854587-1-michael.bommarito@gmail.com>
References: <20260420162734.854587-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FBE04329D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 12:27:34 -0400 Michael Bommarito wrote:
> When __netlink_dump_start() has already installed cb->skb, taken the
> module reference and set cb_running, a failure from the first
> netlink_dump(sk, true) call returns via errout_skb without unwinding the
> callback lifetime. That leaves cb_running set and defers module_put()
> and consume_skb(cb->skb) until userspace drains the socket or closes it.

On a quick look I can't see which path clears the dump state in case we
keep failing to allocate an skb. Could you add more info on that?

> Share the normal callback teardown in a helper and use it on successful
> completion and on the initial lock_taken=true failure path. Keep the
> lock_taken=false continuation path unchanged, because recvmsg()-driven
> retries legitimately preserve cb_running when they run out of receive
> room.
> 
> Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Validation inside a UML guest on current mainline:
> 
>   - An unprivileged local task (uid=65534, no CAP_NET_ADMIN) opens a
>     plain NETLINK_ROUTE socket, preloads sk_rmem_alloc with echoed
>     NLMSG_ERROR replies from an unsupported rtnetlink type, then issues
>     RTM_GETLINK | NLM_F_DUMP | NLM_F_ACK.
>   - Stock kernel: the initial __netlink_dump_start() hits the rmem gate
>     and returns via errout_skb with cb_running stuck at 1 until
>     recvmsg() or close() drives forward progress.
>   - Patched kernel: the same probe leaves cb_running clear immediately
>     on the lock_taken=true failure, and the larger-rcvbuf continuation
>     path (legitimate dump in progress) is unchanged.
> 
> A scaling pass on 3500 such wedged sockets in a 256M UML guest shows
> about 3.8-3.9 MiB of extra unreclaimable slab (/proc/meminfo
> SUnreclaim) beyond the visible queued rmem on the vulnerable kernel,
> roughly 1.1 KiB/socket. Real accumulation, but the test hits
> RLIMIT_NOFILE long before the guest approaches OOM, so this still
> looks like a local availability cleanup rather than an exhaustion
> primitive.

This should be part of the commit message, it's useful to understanding
the problem. Actually more than the current commit msg TBH.

> No Cc: stable@ on the theory that the bug self-heals on
> recvmsg()/close and the accumulation is mild. Happy to add it and
> route to net if you'd rather see it backported.
> 
>  net/netlink/af_netlink.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 4d609d5cf406..7019c17e6879 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2250,6 +2250,20 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static void netlink_dump_cleanup(struct netlink_sock *nlk)
> +{
> +	struct module *module = nlk->cb.module;
> +	struct sk_buff *skb = nlk->cb.skb;
> +
> +	if (nlk->cb.done)
> +		nlk->cb.done(&nlk->cb);
> +
> +	WRITE_ONCE(nlk->cb_running, false);
> +	mutex_unlock(&nlk->nl_cb_mutex);
> +	module_put(module);
> +	consume_skb(skb);
> +}

It's probably better to create a helper that shares the code with 
the release path as well. And try not to switch the skb freeing 
to consume_skb().

>  static int netlink_dump(struct sock *sk, bool lock_taken)
>  {
>  	struct netlink_sock *nlk = nlk_sk(sk);
> @@ -2258,7 +2272,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>  	struct sk_buff *skb = NULL;
>  	unsigned int rmem, rcvbuf;
>  	size_t max_recvmsg_len;
> -	struct module *module;
>  	int err = -ENOBUFS;
>  	int alloc_min_size;
>  	int alloc_size;
> @@ -2366,19 +2379,14 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>  	else
>  		__netlink_sendskb(sk, skb);
>  
> -	if (cb->done)
> -		cb->done(cb);
> -
> -	WRITE_ONCE(nlk->cb_running, false);
> -	module = cb->module;
> -	skb = cb->skb;
> -	mutex_unlock(&nlk->nl_cb_mutex);
> -	module_put(module);
> -	consume_skb(skb);
> +	netlink_dump_cleanup(nlk);
>  	return 0;
>  
>  errout_skb:
> -	mutex_unlock(&nlk->nl_cb_mutex);
> +	if (lock_taken)
> +		netlink_dump_cleanup(nlk);
> +	else
> +		mutex_unlock(&nlk->nl_cb_mutex);
>  	kfree_skb(skb);
>  	return err;
>  }

If you're planning to repost - please wait until tomorrow, we ask that
revisions are at least 24h apart so that people across the timezones
have a chance to chime in.

