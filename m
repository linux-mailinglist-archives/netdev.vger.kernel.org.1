Return-Path: <netdev+bounces-270479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH3nBeQmwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:41:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886682F1586
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D40303D701
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86432387373;
	Mon, 23 Mar 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="htFl5Xkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1kD77AOa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89C37F758
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265488; cv=none; b=Hv6fIn7JObOH9KhTOSDK2eAKUI1iEe6PgnlnYGXGtCZAt8hLSXWNnvbX/CfRjMgCM1EtiO1MAyNdxuJJhceALpSpF8G9ws3kx2dT+o/u5Kx+cJ5ffrQq0onqTXjKMERWtWp0au5PovJdeUJCLmWl9djR7a3voA6fUmgbduStZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265488; c=relaxed/simple;
	bh=UJcEnc5AWCHo1mHbu9Gr+oY1HftJroueaHxJIUNHybA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV6opgyMPuHzEjorWaCGvsqpmP9JlF8iBUf4sHbGqP71VPzdABlkWb4gUV7Zovafg1A1lDpJcvjMdtZDjy3fFJowLU9PNtm3VVkLAgFBiKvVJ/PXHJ+hZe4/3eiw5Qb4BvESDmz3efSVW+4tY7vLir9z+yUDOfzs9yuqHwM6MKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=htFl5Xkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1kD77AOa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FD321400082;
	Mon, 23 Mar 2026 07:31:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 07:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774265485; x=
	1774351885; bh=vRsmg8gaC0t46C47uqnzqJL9EPThq2kwCz/1WO6apZs=; b=h
	tFl5XkcYnDjsA0RfCekZL84JZO62jgzanvxAdZV4gb/Y5+Jadcqi0Jyf1atsPpmI
	L8XUNYu2o5ltjnAQy9oz8eTRPyiXn/1MR9Zo8TQTNylo34a29ClSmmIhEJfplkkH
	yLZ/+wXkW+6RhDR6pudEEfnPsMGrraJnkvndtASQq//R1ai8Qo4NoCn68Aqb+j93
	3gMzEBAC3+Jk2xQc0eIDUZjyy7IuL2pdGf1Gl8IgbS5TFsAI/KyxiQQibDb8QA0k
	bmHA9uJmBecKI34vr7ey8lJobuRbVfgRL2+dBkx3sCTH5zsk9ZEsdJ/hM/+W7WBD
	h+qSsT1z3/yKDFsIIRt3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774265485; x=1774351885; bh=vRsmg8gaC0t46C47uqnzqJL9EPThq2kwCz/
	1WO6apZs=; b=1kD77AOaOInma6GRlt+l9GZFMovJEu7ppKM5Ad0pPxpFm0yGEw3
	SJJkaaybW03YL2t2+U1/VMvS1Uect+0bxfvuh482iUTFhizUKHim8sQUzv+dOuw7
	N8v2MDgbbZdc+uMI2q1TSLutFNar5KYdRI3ON5emkaqkg1MO6719/6tytM/nUUeN
	hAyd9yXsTn4haroMRMl4Otpi3KlN1atiXjcrxfdzPD9h/cFdso0zvk1eCAzgNKna
	WOpBYmVB9hVMvJuMZ4xO12PU2mZRxLwh07ovnLNlFuWwDOH11s7nmi/r/UXCcYr2
	lWkoBMJT4ojmhxIYgtFBxv5T37UA3Pv7Rfw==
X-ME-Sender: <xms:jCTBade-XD8TcMNkej4lNEyz7zlq82-3CfK_oCbWklxVv6Tn3InI8w>
    <xme:jCTBab7Z1Tykoke6PQWy3_ar0MAZnqaJ11VO5lbVRI5Q7WQAtTlDnJo3a7dUvmxsp
    1IOy0ZI9oV4Ovoparmo5qqOUSMbzWUk7JBu15DvzsdoC9i_g6vEOv5R>
X-ME-Received: <xmr:jCTBaUs-i88ztYURTyEn9sO3whGpR0dz9-lVZ6uPmwbKiHnQp_HFC76LyPJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:jSTBabhHskHiqIwCjY8gXx9uHsffUyPXfa7W7wf4p_wQDjkg4D_-kA>
    <xmx:jSTBafo00kbDqaOXxirBPqe0zmPx8E3qQ_haGGIUEngYN7672bRHgg>
    <xmx:jSTBaYsl-jP2Wh7RKlo9iOFh8Tbd7Zj4PLPnK1TV7EkhCNjM2sdsNg>
    <xmx:jSTBaSac7ZjD6-M7_wVaw-go0rkmxWkykUBkF9M0i5nWpPCazH-X0g>
    <xmx:jSTBaQF86X203klVYStzGXEU7IvGJu3c9OnwMyVpkYX7oj7a3-zUgadP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 07:31:24 -0400 (EDT)
Date: Mon, 23 Mar 2026 12:31:22 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 7/8] tls: Restructure
 tls_sw_read_sock() into submit/deliver phases
Message-ID: <acEkik8Bt_PILxPL@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-7-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-7-ab1086ec600f@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270479-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 886682F1586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-17, 11:04:20 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Pipelining multiple AEAD operations requires separating decryption
> from delivery so that several records can be submitted before any
> are passed to the read_actor callback. The main loop in
> tls_sw_read_sock() is split into two explicit phases: a submit
> phase that decrypts one record onto ctx->rx_list, and a deliver
> phase that drains rx_list and passes each cleartext skb to the
> read_actor callback.
> 
> With a single record per submit phase, behavior is identical to the
> previous code. A subsequent patch will extend the submit phase to
> pipeline multiple AEAD operations.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 70 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 5b154afbd7ac2ddd51b46d8d6bef0a7a41f0a841..5ae7e0c026e4437fe442c3a77b0a6d9623816ce1 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2346,8 +2346,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>  	struct tls_prot_info *prot = &tls_ctx->prot_info;
> -	struct strp_msg *rxm = NULL;
>  	struct sk_buff *skb = NULL;
> +	struct strp_msg *rxm;

nit: networking tries to follow the "reverse xmas tree" ordering (a
bit broken in ktls because of context structs).

[or just leave this alone because setting it to NULL doesn't hurt?]


[...]
> +		/* Phase 2: Deliver -- drain rx_list to read_actor */
> +		while ((skb = __skb_dequeue(&ctx->rx_list)) != NULL) {
>  			rxm = strp_msg(skb);
>  			tlm = tls_msg(skb);
> -			decrypted += rxm->full_len;
>  
[...]
> +			copied += used;
> +			if (used < rxm->full_len) {
> +				rxm->offset += used;
> +				rxm->full_len -= used;
> +				if (!desc->count)
> +					goto read_sock_requeue;
> +			} else {
> +				consume_skb(skb);
> +				skb = NULL;
> +			}
>  		}
> +		/* Drain all of rx_list before honoring !desc->count */
> +		if (!desc->count)
> +			break;

I'm not really familiar with the read_sock users, why is it ok to
ignore desc->count reaching 0 while we're in the rx_list loop?

>  	}

-- 
Sabrina

