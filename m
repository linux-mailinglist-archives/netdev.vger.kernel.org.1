Return-Path: <netdev+bounces-231679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF1BFC6DF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC494E2A66
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD21346E5B;
	Wed, 22 Oct 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dtTUwbII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgbyuhpC"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600662D7BF
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142690; cv=none; b=QSX3PHKmHtlNjXk1NogXwZC6YiGBiDqI/A0nKVMHYK8jFM1sLLX4czA1E7/aHndnx12ZoW7TB6rntmG1N4jhlztHNtpiUj5M3WxWVD/z4tyXB00cD0j6lI8gXbtobsPn+sK5lkKved74WcaviCiY9N3wk02djCyhzRslZyqmRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142690; c=relaxed/simple;
	bh=q3IpH5y6nurJNk8qRCre5QviDTtosg0fQPKWNipFaqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi927XADrMGuUGR3vTy5ahAPe5qGeYvH1aEOUvwHsgZFvZXN3sac/jAX8hmuOEkReeRiGs4xKqt/sq+3QL6HX3WFeXdDkaMIx6VZEc8qebIzQpVCQ4omihNIhTnSIC2YWUasgVXxs7jEYCFifP0oXNAXWewN3eNNJJ4B8lXqEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dtTUwbII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgbyuhpC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BA671400068;
	Wed, 22 Oct 2025 10:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 22 Oct 2025 10:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761142685; x=
	1761229085; bh=CGM9Ng0cDJJ6KHiY0zOyqatlhZf7mJg0BA1esw5pkNI=; b=d
	tTUwbIIUQZERqXMbJyc8Htx1JPKJp8O3TXGMi/x9lqhKYt4XTgWpfn5lbhq6HRME
	CYSLFipjXD9dORThZdg0db4M3ZxvSQpC92b5KvzqfbE1w5Y6jHDqkd15YtxoNacb
	7aaLpxFUbuyHtgWkADYDdidXrUJnGVD0GO0r3oE93ltbDB87JxsNQfYIJIuids/v
	uaMRwf+ZgqUvVJ7nCSl1O1H7/avdixfByZQX4K/+mZ6cv0AfxOiSfeV8oL1fGHoP
	widPd5eNIxPyfrrGKzbDrXvAI54LAsE2rT3Bs7ILbjqJAJX95eT4DDy2vHTpTcVN
	TW5pJOOLVnSoRD5jF4tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761142685; x=1761229085; bh=CGM9Ng0cDJJ6KHiY0zOyqatlhZf7mJg0BA1
	esw5pkNI=; b=RgbyuhpC158182rjUp3LDCYjQeh6d86G8wgJKuggLkxWeADIQ5i
	JcKpSLynZW6RIRDxx4hPVk66TifKd/MQQkKGItpjFGZH6Lu4q2PfDF0v3n6W6BLO
	09iv9zQe7ZIcHbne67fP8ErKhAO/eR3Nz+6oGpTTb4iTy2X8VTHgV0DJbNNS4arh
	k5BVTGSx+QdZ9U+iwFLqRI5+LWfb2CufH7705ALwqaCtBv1z698NSBL5xgfXZt7E
	qRGnbdX+1ufbM8xV8rxBf2mbVPNTyKEO0UaU0z9eJId09VXHVsrgm6ddQe9w+Lnl
	rIRnYmPOSNbA9/bTmsb7LuAt9LoLkucQ6ow==
X-ME-Sender: <xms:nef4aMAx5kdQ650SJyeqEtjSJ6JnxU2DigZfyHgq2IzoZS_Xc5Bbhw>
    <xme:nef4aNmpHln0AjbYagBVjx-x1TaUCIozaVaDXxMpIP2S9U-S7aHZOROvsN50MmDHp
    VWkqrXbEQDUqFV_PALe4GA5Cl5HyMbpbR_KSu1Z3fHj5DbnnyTNkw>
X-ME-Received: <xmr:nef4aFwFQNSzyDfiFqix6nFHbUBUTjBzi56_QOC-Ch5cc9_ORiBapNKS5tuv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:nef4aPQNzBHJojB4jSD3FsA1B3ioWPE2jrl6xrFtgScfvEBa-G86Wg>
    <xmx:nef4aF-3mYWB8AKIhKQOjXJ8rIXrv2Rx0NUF99l22LwVNkhEk1M9bA>
    <xmx:nef4aFtrfktzjKsQtqdSpH1mDJwuxsmPIpP60jkTxwHLv4nfxaI1Tw>
    <xmx:nef4aFPI7h0r6xoXxAs7hyp4hra93ZHWBk_-W1z_UMlemb8QruAs3g>
    <xmx:nef4aIbEurDouNMVPh6HI4Su2QRGU-ER_LNYL99sNo-K3wt9MEBpJSue>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:18:04 -0400 (EDT)
Date: Wed, 22 Oct 2025 16:18:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 3/3] ovpn: use datagram_poll_queue for socket
 readiness in TCP
Message-ID: <aPjnm7PM_yWsnn2A@krikkit>
References: <20251021100942.195010-1-ralf@mandelbit.com>
 <20251021100942.195010-4-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021100942.195010-4-ralf@mandelbit.com>

2025-10-21, 12:09:42 +0200, Ralf Lici wrote:
> openvpn TCP encapsulation uses a custom queue to deliver packets to
> userspace. Currently it relies on datagram_poll, which checks
> sk_receive_queue, leading to false readiness signals when that queue
> contains non-userspace packets.
> 
> Switch ovpn_tcp_poll to use datagram_poll_queue with the peer's
> user_queue, ensuring poll only signals readiness when userspace data is
> actually available. Also refactor ovpn_tcp_poll in order to enforce the
> assumption we can make on the lifetime of ovpn_sock and peer.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
>  drivers/net/ovpn/tcp.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Ralf.

-- 
Sabrina

