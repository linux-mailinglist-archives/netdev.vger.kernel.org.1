Return-Path: <netdev+bounces-260907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rcZSFanjnmnQXgQAu9opvQ
	(envelope-from <netdev+bounces-260907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:57:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB301196E97
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D7FB3025E12
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E44396D16;
	Wed, 25 Feb 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i55h3Baq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443128C854
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020646; cv=none; b=psizedKNFChZ9O3BvHi4+0EViYVmi21SzdQbAeUXo99a/wXdYSsP6eII6/Eotn1hKPaJKYED4xmax/G81ySC1DrluTWsaP5nLonZvZyrO5RSer3nJmkdQgOkXuu2P5OGFUrdx/8Wydww/IbNSw6eCjeMP3hDpNggPGv5D/tNHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020646; c=relaxed/simple;
	bh=gRRaI+geC4oozfeB8XGa0j0UpRd1bkCutfhQjfTPm28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfmCg/uPfvQ81IU0hRmTh/cbM6huUmP+3JMqf/ZaLYnQnMg1GJuSZStGIBQqoVCuuZavR119ZQfAZMLX8c3MZsooTpc7uRXGHnyDYIMpzs8TiXdmaXaGYuTdCJ9P2XlzBQulzu133to7619U5LAA2OKh2E8OlN9/q/742AYgXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i55h3Baq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0034AC116D0;
	Wed, 25 Feb 2026 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772020646;
	bh=gRRaI+geC4oozfeB8XGa0j0UpRd1bkCutfhQjfTPm28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i55h3BaqiZSzNZ4pm7zPDUntoGHf9LXdKOoQRiFpGjhZmMPF5xo3VTyhOYaiSgV0j
	 Jol03Wzr5kzhfDxhIy53KYJFZt6saiBHqPkumHCENy+LUv5nK8SXQRKsdwPB9WgHXw
	 gIgw+DzGUx/C2nl4zng7/uV31gLP12+Oda3bJg7ojJVXAI4u3vzEIzvyJT1REqAxm+
	 4RBDaUawJX/6u0nEK9IEvkKdA3fMjhsrvmHJZNBwLGBvamWsxgOEX4LqbT/yZ+Z0wq
	 pvWucSzZa4C4C35eUSBJ4vRJsppjbOKAA8gRqQ4OFnhBASCCRRMpiAwG+xGO+e57Ru
	 ZhL2B4i/byTVw==
Message-ID: <bf7df838-7337-4ef8-b0c4-492f9c9bced7@kernel.org>
Date: Wed, 25 Feb 2026 12:57:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] tcp: make tcp_v{4,6}_send_check() static:
 manual merge
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mark Brown <broonie@kernel.org>
References: <20260223100729.3761597-1-edumazet@google.com>
 <20260223100729.3761597-4-edumazet@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260223100729.3761597-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-260907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DB301196E97
X-Rspamd-Action: no action

Hi Eric,

Thank you for the patch!

On 23/02/2026 11:07, Eric Dumazet wrote:
> tcp_v{4,6}_send_check() are only called from tcp_output.c
> and should be made static so that the compiler does not need
> to put an out of line copy of them.
> 
> Remove (struct inet_connection_sock_af_ops) send_check field
> and use instead @net_header_len.
> 
> Move @net_header_len close to @queue_xmit for data locality
> as both are used in TCP tx fast path.

(...)
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index ecb362025c4e5183ec78aef4b45c249da87c19ea..bbc9355871c767b51e3d1a4d2436022a8556416c 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -34,7 +34,7 @@ struct tcp_congestion_ops;
>   */
>  struct inet_connection_sock_af_ops {
>  	int	    (*queue_xmit)(struct sock *sk, struct sk_buff *skb, struct flowi *fl);
> -	void	    (*send_check)(struct sock *sk, struct sk_buff *skb);
> +	u16	    net_header_len;
>  	int	    (*rebuild_header)(struct sock *sk);
>  	void	    (*sk_rx_dst_set)(struct sock *sk, const struct sk_buff *skb);
>  	int	    (*conn_request)(struct sock *sk, struct sk_buff *skb);
> @@ -43,7 +43,6 @@ struct inet_connection_sock_af_ops {
>  				      struct dst_entry *dst,
>  				      struct request_sock *req_unhash,
>  				      bool *own_req);
> -	u16	    net_header_len;

FYI, I got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  858d2a4f67ff ("tcp: fix potential race in tcp_v6_syn_recv_sock()")

and this one from 'net-next':

  fcd3d039fab6 ("tcp: make tcp_v{4,6}_send_check() static")

The conflict was in the context: here 'net_header_len' has been moved,
while in net-next, the line above has been modified. I'm sharing the 3w
patch resolving the conflict, just in case it can help others. Rerere
cache is available as well:

 https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/d58bc4b

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

------------------------ 8< ------------------------
diff --cc include/net/inet_connection_sock.h
index 5cb3056d6ddc,bbc9355871c7..433c2df23076
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@@ -42,10 -42,7 +42,9 @@@ struct inet_connection_sock_af_ops 
  				      struct request_sock *req,
  				      struct dst_entry *dst,
  				      struct request_sock *req_unhash,
 -				      bool *own_req);
 +				      bool *own_req,
 +				      void (*opt_child_init)(struct sock *newsk,
 +							     const struct sock *sk));
- 	u16	    net_header_len;
  	int	    (*setsockopt)(struct sock *sk, int level, int optname,
  				  sockptr_t optval, unsigned int optlen);
  	int	    (*getsockopt)(struct sock *sk, int level, int optname,
------------------------ 8< ------------------------

