Return-Path: <netdev+bounces-270560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGMAFWhOwWmhSAQAu9opvQ
	(envelope-from <netdev+bounces-270560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:30:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B722F49C9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9F13309A51F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837AF3ACA7E;
	Mon, 23 Mar 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dN8HrL4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rjqe7cgD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937773AC0C2
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275303; cv=none; b=c2PSpfwZNu3yoxAhtBZxRBUUiKH0UDFlXncvrrUsk2BNMtrU9fOczjL35vnMelW9zLyNrYttdzwE4J8ArihFkkuqmlBHpBETNQaFY7Y+JWC6W/9pO6r+9uQVh8K+nO7oFQ7B+Gr8Df/1YK27wf5XIt5Kl9SU5WPeYQhJG0OfrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275303; c=relaxed/simple;
	bh=kNENg0utlEIbKnqLa79KxzGrhb6ZP2goPgtbUF60iUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUiz1Im2A+gEYaKv10LdPAP1Vju5okDM6DssW8jqzOsk2+XX+D/nKPTqTMXLvSuN0EExA8dlXbzDIi1cRC8VR3tEzr9fxRUCu8bRHqfBso6CaaW9kt1GPRkpEMIdvrHFMtqRF+MGETFZ8xE8v59narEc6m4vG1gvz1FzUjTENcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dN8HrL4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rjqe7cgD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 859A87A0202;
	Mon, 23 Mar 2026 10:14:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 10:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774275299; x=
	1774361699; bh=TROWWBXYBXdd512/aPtlL+3fC33AxkatZLOYX9IOR+U=; b=d
	N8HrL4jTdvCXuxv8D49rCZjby+5uwulMTRjmaeTFqYk4D5wDZ1gnCIIPM4Af5R3i
	u2yKeHjA84O1dF3G5XRYSglYNv649Gp4LQQgExDUaSu9FQl+NYEFT1YRKrWblrM9
	MCL+mP58EuV77Muzakj4+jnMDCMXh55tfvsKNPvwsx2Z8V50bMtYELi3Gvpdm7Xb
	pywh9Hpes5s4Le3m5VWk4xwRsOlCea2WEc3tjapp8E0Rc6ik/gVrWH3xQ3utyNah
	JzwGzaWNVXcnhkfxSghpupGqcD4mhr2CKMlUCWaU7MrZTt3qHrPsmEXTSCE/OvnS
	7KMBbMyh8BGkj18qfx4fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774275299; x=1774361699; bh=TROWWBXYBXdd512/aPtlL+3fC33AxkatZLO
	YX9IOR+U=; b=Rjqe7cgDfeUEvJ5pyjvw0lEj5zSYsAJzPrLfuqtSM4sb4igPh0p
	WSt7MEWT/x4bJw1/VBqE1a6eg3aU9J6qqPzMK4RcJbo6H4uf/0KNI06N63ThvfCI
	Ij4jifQVC2f7qbG0R9klJaCjlwpqNg6J9cZr4678/LC4qIioehrsJHuYbJN4+K7o
	JPjYdAZOwMa7TTOx3oqfrrJ3znmyyorpQk7L4CGzdeGjqofaIFL07bo6LctwFAVS
	DbX1xwOmCqDSTSJ3tOWDyg3kAkYpM0sfqiTVqGS9In8eINUR31n1RvCt9/86E0fU
	2/E3vQ8XvwPuTLpnbw7FB09q74Q1wyaDq6g==
X-ME-Sender: <xms:4krBafyuCY7LlArd6uSaGG9YI9bb4_6VW-W6oB7Q-kHVZ31hVM-dqQ>
    <xme:4krBaX9XVZTxQ4559sNj_YXkDHLUYd94bFDkrBD_EqUX177wOD2yaK_bOrB51mJXA
    L8AzE81KCnnSUNOIaXm3X36YOmGzBTD_ZOxa_IAzFEW2x4TwXgGqyM>
X-ME-Received: <xmr:4krBaXgvu-fZUC9dLVBcVjkM61ijt2STD9mdM8iburwWOTGF4qRxN8rrnNiZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4krBaeFlRvzeGVzBqwCrP7rJKY02nD0mULiHPuRPR1CiXoeFWBVGwA>
    <xmx:4krBaW_ixyavQ_OG4uwxyhjJIwGj9gSSIUa601IdwrBIt9U2WK-LiQ>
    <xmx:4krBaVweSKeMtfK0TJKSRRNJ4lZmQVGl5YY9XV0b2GmbYEs4bbjipg>
    <xmx:4krBaSNTWF3jp8TYWLQvlq_g34cC5dgq9_KBYAvrAyZbjaULcfKbsQ>
    <xmx:40rBaXolxvPAg-A31C4Chi25XrmrZ_QiCQg-B77VHeqxewXt_FqHbcy9>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 10:14:58 -0400 (EDT)
Date: Mon, 23 Mar 2026 15:14:56 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
Message-ID: <acFK4DWAD5h_Oc0f@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	TAGGED_FROM(0.00)[bounces-270560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D5B722F49C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 5ae7e0c026e4437fe442c3a77b0a6d9623816ce1..bc500ba7ce81eb33763c37a8b73473c42dc66044 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -261,6 +261,12 @@ static int tls_decrypt_async_drain(struct tls_sw_context_rx *ctx)
>  	return ret;
>  }
>  
> +/* Submit an AEAD decrypt request.  On success with darg->async set,
> + * the caller must not touch aead_req; the completion handler frees
> + * it.  Every error return clears darg->async and guarantees no
> + * in-flight AEAD operation remains -- callers rely on this to

-EBUSY (which is not a "real" error) will result in calling
tls_decrypt_async_wait, but not other errors?

> + * safely free aead_req and to skip async drain on error paths.
> + */
>  static int tls_do_decryption(struct sock *sk,
>  			     struct scatterlist *sgin,
>  			     struct scatterlist *sgout,
> @@ -2340,6 +2346,13 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  	goto splice_read_end;
>  }
>  
> +/* Bound on concurrent async AEAD submissions per read_sock
> + * call.  Chosen to fill typical hardware crypto pipelines
> + * without excessive memory consumption (each in-flight record
> + * holds one cleartext skb plus its AEAD request context).
> + */
> +#define TLS_READ_SOCK_BATCH	16

I suspect that at some point, we'll have a request to make this
configurable (maybe system-wide, maybe by socket?).


>  int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		     sk_read_actor_t read_actor)
>  {
> @@ -2351,6 +2364,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	struct sk_psock *psock;
>  	size_t flushed_at = 0;
>  	bool released = true;
> +	bool async = false;

nit: reverse xmas tree(-ish)

>  	struct tls_msg *tlm;
>  	ssize_t copied = 0;
>  	ssize_t decrypted;
> @@ -2373,25 +2387,61 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	decrypted = 0;
>  	for (;;) {
>  		struct tls_decrypt_arg darg;
> +		int nr_async = 0;
>  
> -		/* Phase 1: Submit -- decrypt one record onto rx_list. */
> +		/* Phase 1: Submit -- decrypt records onto rx_list. */
>  		if (skb_queue_empty(&ctx->rx_list)) {
> -			err = tls_rx_rec_wait(sk, NULL, true, released);
> -			if (err <= 0)
> +			while (nr_async < TLS_READ_SOCK_BATCH) {
> +				if (nr_async == 0) {
> +					err = tls_rx_rec_wait(sk, NULL,
> +							      true,
> +							      released);
> +					if (err <= 0)
> +						goto read_sock_end;
> +				} else {
> +					if (!tls_strp_msg_ready(ctx)) {
> +						tls_strp_check_rcv_quiet(&ctx->strp);
> +						if (!tls_strp_msg_ready(ctx))
> +							break;

This (and tls_rx_rec_wait) looks like tls_strp_check_rcv_quiet should
return the value of msg_ready.

This is also not very different from tls_rx_rec_wait(nonblock=true),
why are you separating the nr_async>0 case and open-coding the core
operations from tls_rx_rec_wait()?

> +					}
> +					if (!tls_strp_msg_load(&ctx->strp,
> +							       released))
> +						break;
> +				}
> +
> +				memset(&darg.inargs, 0, sizeof(darg.inargs));
> +				darg.async = ctx->async_capable;

tls_sw_recvmsg also has:

    if (tlm->control == TLS_RECORD_TYPE_DATA && !bpf_strp_enabled)

before setting darg.async. bpf_strp_enabled isn't relevant since
tls_sw_read_sock aborts when there's a psock, but I think record type
matters here.

> +
> +				err = tls_rx_one_record(sk, NULL, &darg);
> +				if (err < 0)
> +					goto read_sock_end;
> +
> +				async |= darg.async;
> +				released = tls_read_flush_backlog(sk, prot,
> +								  INT_MAX,
> +								  0,
> +								  decrypted,
> +								  &flushed_at);

The level of indentation for phase 1 is getting really unreasonable.

> +				decrypted += strp_msg(darg.skb)->full_len;
> +				tls_rx_rec_release(ctx);
> +				__skb_queue_tail(&ctx->rx_list, darg.skb);
> +				nr_async++;
> +
> +				if (!ctx->async_capable)

Do we want to break out here (stop the current decrypt batch and move
to phase 2) if we've already had to process all pending decrypts
(tls_decrypt_async_wait has been called)?


> +					break;
> +			}
> +		}

-- 
Sabrina

