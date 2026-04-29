Return-Path: <netdev+bounces-282362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML2GO0Ly8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:57:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B589493C92
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8DB30221F8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C553F0ABD;
	Wed, 29 Apr 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fPLNGDa2"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED13F54B7
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463841; cv=none; b=LTMA3bd4IKDjP6mxusahdLnzPuWOyc/oczBUaMJc3Z2DxrdfEqbB84iomcvQK3K/mtYLGLrvH/fnSMLp6jtsbGhUYDGrQhCGCNztC3tCaAhy5ipWDwjn/ETKRfD2CiQvbVbmQX23jDC83Y69p5fEeRfRhdmrYhAEDSfD9lzv9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463841; c=relaxed/simple;
	bh=f+r2nKtk4YPwX0yTAujy/TEKAPTpBTvALCr9xgGAfhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxYp2NJWTurUEjqpO9LT/96LwyE0JMYAczdTRaRuzenYk+AnkzUh81cH1D+4EhrJjmaDSkA5MfDXMpkyDEpjWb2DzOuRhRiaClDGTGcZfQu6mznO0FLqsnBiczE/r1IedDo3hBQckFyq74ogG+CG/uwELx6kI4W4YqUPXLptTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fPLNGDa2; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0427810-3727-4cf0-b4c2-c8aeba3078df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777463836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpPWUY5XPwzD7ekD3H25/ZLvnnu8rqLnb/pYTK7ozDM=;
	b=fPLNGDa2kVNpWfEcdNnGc+EXRRZayprA1EyOMns5LrnD8taCVHKoanbgV0IvpTD9EQJnvK
	OWOsVg9T8RNb/q96yEexECOv8UTxZnmpp7O+HlT27rukY/XPytFTkvr7zHgdJZ7jidJHd6
	MgIWWRiGobnbLYwUthKvGLoLhKX6izg=
Date: Wed, 29 Apr 2026 12:57:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: tls: fix strparser anchor skb leak on offload RX
 setup failure
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, john.fastabend@gmail.com,
 sd@queasysnail.net
References: <20260428231559.1358502-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260428231559.1358502-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8B589493C92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	DKIM_TRACE(0.00)[linux.dev:?];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282362-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_SPAM(0.00)[0.931];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[linux.dev : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_TEMPFAIL(0.00)[linux.dev:s=key1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]

On 29/04/2026 00:15, Jakub Kicinski wrote:
> When tls_set_device_offload_rx() fails at tls_dev_add(), the error path
> calls tls_sw_free_resources_rx() to clean up the SW context that was
> initialized by tls_set_sw_offload(). This function calls
> tls_sw_release_resources_rx() (which stops the strparser via
> tls_strp_stop()) and tls_sw_free_ctx_rx() (which kfrees the context),
> but never frees the anchor skb that was allocated by alloc_skb(0) in
> tls_strp_init().
> 
> Note that tls_sw_free_resources_rx() is exclusively used for this
> "failed to start offload" code path, there's no other caller.
> 
> The leak did not exist before commit 84c61fe1a75b ("tls: rx: do not use
> the standard strparser"), because the standard strparser doesn't try
> to pre-allocate an skb.
> 
> The normal close path in tls_sk_proto_close() handles cleanup by calling
> tls_sw_strparser_done() (which calls tls_strp_done()) after dropping
> the socket lock, because tls_strp_done() does cancel_work_sync() and
> the strparser work handler takes the socket lock.
> 
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> ---
>   net/tls/tls.h      | 1 +
>   net/tls/tls_strp.c | 6 ++++++
>   net/tls/tls_sw.c   | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index e8f81a006520..12f44cb649c9 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -188,6 +188,7 @@ int tls_strp_dev_init(void);
>   void tls_strp_dev_exit(void);
>   
>   void tls_strp_done(struct tls_strparser *strp);
> +void __tls_strp_done(struct tls_strparser *strp);
>   void tls_strp_stop(struct tls_strparser *strp);
>   int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
>   void tls_strp_data_ready(struct tls_strparser *strp);
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index 98e12f0ff57e..c72e88317627 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -624,6 +624,12 @@ void tls_strp_done(struct tls_strparser *strp)
>   	WARN_ON(!strp->stopped);
>   
>   	cancel_work_sync(&strp->work);
> +	__tls_strp_done(strp);
> +}
> +
> +/* For setup error paths where the strparser was initialized but never armed. */
> +void __tls_strp_done(struct tls_strparser *strp)
> +{
>   	tls_strp_anchor_free(strp);
>   }
>   
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 94d2ae0daa8c..798243eabb1f 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2624,8 +2624,12 @@ void tls_sw_free_ctx_rx(struct tls_context *tls_ctx)
>   void tls_sw_free_resources_rx(struct sock *sk)
>   {
>   	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx;
> +
> +	ctx = tls_sw_ctx_rx(tls_ctx);
>   
>   	tls_sw_release_resources_rx(sk);
> +	__tls_strp_done(&ctx->strp);
>   	tls_sw_free_ctx_rx(tls_ctx);
>   }
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

