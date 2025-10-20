Return-Path: <netdev+bounces-230847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB94BF07EB
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00AB4F1C8E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A3236A8B;
	Mon, 20 Oct 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="OU0QyNo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hY23YsDG"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EB2F5A0E
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955429; cv=none; b=YFdUiMlbuejUgaPL4hNMQRNEwHksEQDgzN1tvs4HnHn7AfyD4NQlZk2v36Pjt6VY3XI8uyKUwAe0U+yqUyr12T0GQWfZW7Qqe+GYFAxUEUpub+FhvEZbhqiVPfkTZFbzJUeFc34BoWa9lirdpvkP6h+bSgQmUhUuz3NKcJ7/0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955429; c=relaxed/simple;
	bh=Bi1ZyrjFUUzdXejo4FKxsDT1MWcut7RqHKd9HQ7ELCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S65dx9bcsF0itkDXQQpWde/TgP/ebG1S/5SXr8ltckddBQ6vGbTaw4qpp95IpG7USuIat/zZFioo7Ox42X/WKx+JAFwTwqovXYgIpOs/brqRpxlRrahB6oGMvjYC9zFIlTUHEeF3bxImBu+/m9eSsaKFdzzPBwaMk56XPxa0xrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=OU0QyNo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hY23YsDG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D4D37A00DA;
	Mon, 20 Oct 2025 06:17:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Oct 2025 06:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760955424; x=
	1761041824; bh=COJPeuzxx2EjODn6UrAi0vPMZdrmpDAocWEIAZ7GEGc=; b=O
	U0QyNo4tsZpXjljiWMQNd8lqSDa4KyLuwJDI1VBYBC4cvDRpLAcgTDbLvSYRqE5k
	qYlT3qyR4vMEGiNndxlLaDU903v5ucINb+ALF8wNIz1sYZShV8BNzVoNTLMVeJGM
	NgniRe3pXVGUgAHkz8N/DsXw/S7h0sPCPniDhHCIZK+1Eg1sL+yrBNg+ra29/b3K
	YD08ywnLNgXhVhWKv3OXwiMurrjaA8BIHMJUusd30ivmV7Dctx6mdwPJ9ZJ5T4Zx
	zoe+om44XrVjR3ki4KB2+8VbpnlrKlBmxJjM4slZ6MTz+MxAQoAwhLX8AeDpVGKj
	Zvlu/VYbwyTsVejnGO2hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760955424; x=1761041824; bh=COJPeuzxx2EjODn6UrAi0vPMZdrmpDAocWE
	IAZ7GEGc=; b=hY23YsDGqFPBPwOsPH449GG0w9+nzY/xKNK6qOc1Oe1/F7RKPm9
	ro4yAseaEDep++KFRt0UBkwG+aq/Bs9D3pCMbobZD/CosZ9c/cBmJHyFxNlPwErF
	sa9sv+0ANBqcEPppsce8K4rHU27IFVZitPNKe9dL7ediwmCn5PMHOUYRfZM4Dp+j
	QzpukWe3k9wbRMbpSFeIPtD0AFn59sDNk/+mQzYG0oZJoSAiJzGzOGpEGEPsVLUI
	baPsbb6dFcO/KXD1j9FehajwidAPp2LnL8MIh/vLkbB0ulYjb8PreyZS2+AWWp3z
	wALTCBW4Bqn2wcmWa0Sh0FgJeAwRjzs+HTw==
X-ME-Sender: <xms:Hwz2aLVUsLgbkw3ev7hx1i6TVngkNrzwZAKDahmsCam7nFqrNNG_KQ>
    <xme:Hwz2aCqqc6o40Ln453f_3rrNWFwGVRFiB3uEhLSWH30JbXchH6JghjYqitC6vUFJO
    VLhQDTAaBRaXP59Z3eEz1POxKHymY5znjfnqYQ_PvG59imld7CLDo8>
X-ME-Received: <xmr:Hwz2aNntZVwJOT6Bsb-S6XBE5zsqab0wuLQ7WN7j4PvGkw8IdnR9OTviInP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Hwz2aC1ZDNLEMbNel0kAyqBEFysmoBxrknwSiEPDr_CcXlQkX12oxw>
    <xmx:Hwz2aKT0GuuckfoLKCaeMArMxiXWcUA4esY2AWMZ6hf8ZiWlWN7Z3Q>
    <xmx:Hwz2aLx_LfIFYYuc2KVPaiu7hijXnyYGcW9CD_c-vZ1w6tDOnTfwyA>
    <xmx:Hwz2aKCbNUreRaSWeua-nel8Zpc0lBAx7OFq0o6TyA-iZyl3NIW9xQ>
    <xmx:IAz2aHvhotjjZRXLJWjvXcj0PweAGeoQ29_g4ZbTYGJo8O-1CUnI-trd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 06:17:03 -0400 (EDT)
Date: Mon, 20 Oct 2025 12:17:01 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 3/3] ovpn: use datagram_poll_queue for socket
 readiness in TCP
Message-ID: <aPYMHdIX68S1Yk-l@krikkit>
References: <20251020073731.76589-1-ralf@mandelbit.com>
 <20251020073731.76589-4-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020073731.76589-4-ralf@mandelbit.com>

2025-10-20, 09:37:31 +0200, Ralf Lici wrote:
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 289f62c5d2c7..308fdbb75cea 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -560,16 +560,34 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
>  static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
>  			      poll_table *wait)
>  {
> -	__poll_t mask = datagram_poll(file, sock, wait);
> +	struct sk_buff_head *queue = &sock->sk->sk_receive_queue;
>  	struct ovpn_socket *ovpn_sock;
> +	struct ovpn_peer *peer = NULL;
> +	__poll_t mask;
>  
>  	rcu_read_lock();
>  	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> -	if (ovpn_sock && ovpn_sock->peer &&
> -	    !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
> -		mask |= EPOLLIN | EPOLLRDNORM;
> +	/* if we landed in this callback, we expect to have a
> +	 * meaningful state. The ovpn_socket lifecycle would
> +	 * prevent it otherwise.
> +	 */
> +	if (WARN_ON(!ovpn_sock || !ovpn_sock->peer)) {
> +		rcu_read_unlock();
> +		pr_err_ratelimited("ovpn: null state in ovpn_tcp_poll!\n");

nit: the extra print is not really necessary once we've done a full
WARN. But if you want the custom message alongside the WARN, maybe:

if (WARN(!ovpn_sock || !ovpn_sock->peer, "ovpn: null state in ovpn_tcp_poll!")) {
	...
}

(you can find examples of the "if (WARN(cond, msg))" pattern in
net/core/skbuff.c:
drop_reasons_register_subsys/drop_reasons_unregister_subsys
and other places)

Other than that, the patch looks good, thanks.

> +		return 0;
> +	}

-- 
Sabrina

