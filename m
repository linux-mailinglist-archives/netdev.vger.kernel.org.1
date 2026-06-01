Return-Path: <netdev+bounces-293580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HT7OsgrHWo4WAkAu9opvQ
	(envelope-from <netdev+bounces-293580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F161A5F7
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99A88300A4DB
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4BC37FF5C;
	Mon,  1 Jun 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxWhHt4X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBl4wSSN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08F37F72E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296614; cv=none; b=uE49AJtsqpwwxg9qg13AEzRmjsGj5zuXEoqAc/Zt6aX88tXtnlgBDHwMCw6CgJ7pjcEnuPiDjNzYST3p+ZAmuAotL2hlzXXnQgmtCiFYIf0Oxaeo3UBklqSQL7VmL1J39R36kw80mxaki+v9lUBYoh+C8us0sZK8kbdOnD4hTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296614; c=relaxed/simple;
	bh=vgCaYGakgdW5YqcZTBtWS+V2GugAvOWIridZQ/ZeXwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCBa8BD2EcBQk0ZShahco51lJLvNShauc5LKZN+G+xArxabU4QzTg6WTcXxrXSXvENWCmmQZMwaSi9LeQyLv77sj2ltzOlr4K0s48kvzM1AQdbRpLL2B/SyvkYRzxo5Uzwh22hiNtCm4XAaVKUlEZNWDteObMv/ichrKeJNqqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxWhHt4X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBl4wSSN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Jun 2026 08:50:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780296610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJRlqzQnR1CjQYAnfmxKeICL6VJNyR6kHyAFMt7TKc=;
	b=IxWhHt4XWPFXlRSSKGR/1Qj6dcUkUdko9hT4QkAWTxTA6nebi+xalylwieY4n+mP0sd+Gy
	DeDoMnTsKJbKxogv4lQvREYjg1AX9N5EtavzR3l9KU7T2CXpEbukYopL6hOwWj7QRon4sp
	DdFB3xmtMyceSX9VHQ02THqvQOsFRU7nZqY1BD2ZKi22FbFjpExfCfrmqV98YgMAOmIaUy
	iK+OSndwuRVvOSdXkzPymrNcddl/xNhITnh3mh/XE9Q0BmQWF/KbSXAZBg3eA5/9A7M4Jx
	6Dnc4eXhALSXti91BD8xWp79IllZYdXy9bTT/E09TiW48a8GxQO3q5O3it9CmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780296610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpJRlqzQnR1CjQYAnfmxKeICL6VJNyR6kHyAFMt7TKc=;
	b=RBl4wSSN4XFQkDE1+P99i/6HrVLit13knWxvZYzV2RPIyGlieQU/ARKiWTtZzufMbXhX46
	3sNZt/ksb7QY8wAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
Message-ID: <20260601065009.YBMkQ84z@linutronix.de>
References: <20260530055907.280160-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530055907.280160-1-kuniyu@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-293580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 815F161A5F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-30 05:59:05 [+0000], Kuniyuki Iwashima wrote:
> 
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/inet_connection_sock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index dbcd37dfdc15..b546ce15ee03 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1145,6 +1145,8 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>  	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
>  		return false;
>  
> +	preempt_disable_nested();
> +
>  	/* The timer needs to be setup after a successful insertion. */
>  	req->timeout = tcp_timeout_init((struct sock *)req);

That tcp_timeout_init() has a BPF_CGROUP_RUN_PROG_SOCK_OPS() in it.
Could we move that preempt_disable_nested() a bit lower just before
mod_timer()?

>  	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> @@ -1155,6 +1157,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>  	 */
>  	smp_wmb();
>  	refcount_set(&req->rsk_refcnt, 2 + 1);
> +
> +	preempt_enable_nested();
> +
>  	return true;
>  }
>  
Sebastianc

