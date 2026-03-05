Return-Path: <netdev+bounces-264124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJbZAfjgqGnzyAAAu9opvQ
	(envelope-from <netdev+bounces-264124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:48:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AE209FED
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3AA0301E3D3
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D471DF254;
	Thu,  5 Mar 2026 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJWNBLC3"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41C15746F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675311; cv=none; b=flq6xQh2RU342z1BvMuldzXZkmJM9olDigb1zfi/mo2nbCuEAlF8p6Q2Vlbx7SmFmmVCKYPoqfMxmWDzIUCvipBzIKfiZ4q5ogt1MCfPuB5BMstiIn2gNieC2P6x3jCxl904ipn67/ARiGCLGZZ00dQxyG1COfSoSW9f7cl5SpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675311; c=relaxed/simple;
	bh=IEvQkKrDCFSs0g+lWRw582cZkJZ4fe+BWJn7/H5Dq/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIuV8ojMJn2IX3ZaGawTzoIxS57B5fZugl99iMw2fW4X9p9+xWW911UyhOp8TIi5ym3/snmk2ONEjx9Z1X1kDUxkOWtuSEj3WwFTAt5GROlKyUTYnmVOJvUqmm6BTR0JJRRNX1d19IJUuzf10mAVPDL/4Wr/w2Wju0BJQlkvHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJWNBLC3; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Mar 2026 09:48:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772675308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D009twMs8s5iYn56OQIX52TjVOfgGF664WoLEilRwtI=;
	b=GJWNBLC3+iRrGzLpmLsET3irh5eDR+dAxwkoSRrLyhlE/VA6ykcLFdla+DBKs+rXPu/N5i
	RHZ99f73PmKqxLPvRSpwKRsBUxqNOHd+9Mx8sxaoSVeFPOMicBFzxGx7hStH2GFC6Zvmdj
	B73bJS3jzBvL5wGpFb1OUqxCvMhWCY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space()
 for UDP.
Message-ID: <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-3-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A60AE209FED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264124-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP only
> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> 
> Otherwise, sk->sk_write_space() is read locklessly.
> 
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> 
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> v2: Cache sk->sk_write_space in sock_wfree()
> ---
>  net/core/skmsg.c   | 2 +-
>  net/core/sock.c    | 8 ++++++--
>  net/ipv4/udp_bpf.c | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 75fa94217e1e..3d7eb2f4ac98 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
>  
>  	psock->saved_data_ready = sk->sk_data_ready;
>  	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
> -	sk->sk_write_space = sk_psock_write_space;
> +	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
>  }

I noticed that Patch 1 and 2 were submitted earlier and are on bpf tree.
Given that Eric's commit (which you reviewed) is now in net.git, these two patches
should probably be dropped in the next version, right? Just confirming.

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=2ef2b20cf4e04ac8a6ba68493f8780776ff84300
  
>  void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 693e6d80f501..710f57ff3768 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
>  	int old;
>  
>  	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
> +		void (*sk_write_space)(struct sock *sk);
> +
> +		sk_write_space = READ_ONCE(sk->sk_write_space);
> +
>  		if (sock_flag(sk, SOCK_RCU_FREE) &&
> -		    sk->sk_write_space == sock_def_write_space) {
> +		    sk_write_space == sock_def_write_space) {
>  			rcu_read_lock();
>  			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
>  						       &old);
> @@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
>  		 * after sk_write_space() call
>  		 */
>  		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
> -		sk->sk_write_space(sk);
> +		sk_write_space(sk);
>  		len = 1;
>  	}
>  	/*
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 91233e37cd97..779a3a03762f 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
>  
>  	if (restore) {
> -		sk->sk_write_space = psock->saved_write_space;
> +		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
>  		sock_replace_proto(sk, psock->sk_proto);
>  		return 0;
>  	}
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

