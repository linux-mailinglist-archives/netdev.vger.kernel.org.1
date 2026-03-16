Return-Path: <netdev+bounces-268223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECPRAI08uGmpagEAu9opvQ
	(envelope-from <netdev+bounces-268223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:23:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA129E13B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534263064EAF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD8330B2E;
	Mon, 16 Mar 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AbkkZbbz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAa84iDV"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C573290BB
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681456; cv=none; b=GzLZVS9hqG6Kce49Kc43/u3eZT3km7KBwUtZ7tAJRU+ZhVorVezjs0nwUnbnWeVW1pll+oEO0twZLo7OaA2HzO5stp/qMKro1o+wPwfk8aI/7bMZHZnoSzCij2DjDql65gO1yR3YD2lJI5vuoxPTBjhq4rTgi7ajmYwmqb4dj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681456; c=relaxed/simple;
	bh=TZcGow5xvMSOIfWDuU3w9kHk6Qk9f/ohwalC5ASZj6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqSouzvrmh5yAB1eNF0eRTsThPBcysz2IdK5fGy1bYhG0YFOihRNvbD2GH3/LKZ0aLztpnAo8R0fcOwIGwuXc1En7kR9fNG/E5ecJf7U6DLCSEwsRRZSlkNZdbbWz9uYEs6bj1jlnXRVPscDU80Cmg9Z754EZijP/RlvOmZ0xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AbkkZbbz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sAa84iDV; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E58041D0003A;
	Mon, 16 Mar 2026 13:17:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773681451; x=
	1773767851; bh=D6i4dne03Ekv33hBc9P56rNBOq5rDBa8J1+Dx2VbveU=; b=A
	bkkZbbzrC69Zsai5wOR3EAGut/psc7InRAb+KhXAihmSYwPkKTJZyCZRkfc6QnPX
	lloxzq6sCepowNYuwWbiS/B3/HRJSsB3GdMUVKgLTWfU+LFLHki9+b+IgdshRAu8
	bYLIWV7h6grBmeWCyWxcyMZjavqthsSbfLVNYkI2Lf3CQAKo93ddCPcXy8vcqqhL
	MWf3liTWvG7sis+zsD9Fam0i9H43wbozMu37DdpMIEo5o3Okk/Gm2E6Fa7S1EPEM
	NdzswhDRh8i/Dwa1dEDXj5JxMyY0ypq2lyuqe/9E+5rHrzjJhR3GJPqGQcCS9ggD
	IfhlaurdqIt54rucPjJ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773681451; x=1773767851; bh=D6i4dne03Ekv33hBc9P56rNBOq5rDBa8J1+
	Dx2VbveU=; b=sAa84iDVm15AzUFA/milSVuB6FOugwIhPNgidjt/ojn9iIhJeT1
	FeKGehIPjLczHq9WIhGt4SmCCNCXiqTKdLkGVoXoRru0zsCw/hALygLRDcaavGe4
	AWe7YMF7yP8/pTVVLAgZi9tvmJ5/T1uQkEsbSTrIBqCNsKFnYQ5GlYqeKy7rKzZw
	5W9cUiYG+qTvyhGsaHqnv0/G+VaHwCcSFf4ht2Z3S7Y3opt4o4i8Lag9w5Pbe+cb
	s/WdytmHdz8YXkAZvKSdoB3hU2ZXc/eg5BVlvubFHFycnVgyb2Nr64UDM388MfKQ
	nP8WfjL0WPD1Nz+WU2KEwdKW0tvIsCd1HAw==
X-ME-Sender: <xms:Kzu4aamnq2wNGeRaLlKqAM0QIoyKb9yqTCOlGLhEH7ZoGX09DWCl2g>
    <xme:Kzu4ab1WbRCv5SzSQB1Ww26oaeKFg2eHDSaJKrsltJXbQgwDnQXnKEysFgfF_FrZi
    OhfvvaGp_2cktZm4edkDaA-0qKcvuLanHOBEoli2SxOhQulwnKDyVE>
X-ME-Received: <xmr:Kzu4afRK9j4UzlD5TdmRanj_KkMfc-UPk2jwB7ZdxTI_0yKJlRGFfqw2uUE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgr
    nhgtihhsseifuggtrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:Kzu4acwf3acQTADQk6QlTxMf_EXpcZbO2NkWUfja4s11fpwG6SQpjg>
    <xmx:Kzu4aXAii94Azb53WQFJC1TR0SHfG-fruOmVvxq-l0va1hAcMkLJDw>
    <xmx:Kzu4aQEqItRVX6rXltZ05CoxvAQMivJSJ2V9C5RDBnIlo8j5C7WChw>
    <xmx:Kzu4aWOdUiJDD6BKgJkkuipCNs7Wzax6PQMy2j4d6mPAT9J1EP5qfQ>
    <xmx:Kzu4acUAm-cCMopYKQMuzHyR4Hfqe18Nc7AhtHOjW37J0my5LudEfTCr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 13:17:30 -0400 (EDT)
Date: Mon, 16 Mar 2026 18:17:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 6/8] tls: Flush backlog before tls_rx_rec_wait in
 read_sock
Message-ID: <abg7KM-LWM8OKvM8@krikkit>
References: <20260312014804.5083-1-cel@kernel.org>
 <20260312014804.5083-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312014804.5083-7-cel@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,wdc.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 57CA129E13B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-11, 21:48:02 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> While lock_sock is held during read_sock, incoming TCP segments
> land on sk->sk_backlog rather than sk->sk_receive_queue.
> tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
> data remains invisible until release_sock() drains it, forcing
> an extra workqueue cycle for records that arrive during
> decryption.
> 
> Calling sk_flush_backlog() before tls_rx_rec_wait() moves
> backlog data into sk_receive_queue, where tls_strp_check_rcv()
> can parse it immediately. The existing tls_read_flush_backlog
> call after decryption is retained for TCP window management.

I'm really confused by this.

 - Why is the existing tls_read_flush_backlog not enough?
   - and what is it still accomplishing now that we're flushing before
     every tls_rx_rec_wait?
 - Why are other RX paths not affected?

You first paragraph and the comment in the diff kind of say the
problem is that tls_rx_rec_wait() doesn't try to feed from the
backlog when sk_receive_queue is empty.

> @@ -2387,6 +2387,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		} else {
>  			struct tls_decrypt_arg darg;
>  
> +			/* Drain backlog so segments that arrived while the
> +			 * lock was held appear on sk_receive_queue before
> +			 * tls_rx_rec_wait waits for a new record.
> +			 */
> +			sk_flush_backlog(sk);
>  			err = tls_rx_rec_wait(sk, NULL, true, released);
>  			if (err <= 0)
>  				goto read_sock_end;

-- 
Sabrina

