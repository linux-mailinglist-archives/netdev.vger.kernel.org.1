Return-Path: <netdev+bounces-214364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC1DB29250
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B5E196664D
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDA022156A;
	Sun, 17 Aug 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWjl7Beo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C24221275
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420160; cv=none; b=HEPhV36ca051R9JtAXK8SdCBo7UHH9kWoCbhJa0OUz+0AWmLhMKPDI0V2O9G50tb/OnRN6myYyvIeCxSsK0PqHAfBXulcp7lG5u6Wy0YyKZzopEZLLmuWs1H05ZqEAfe8INuJACq9A5eYLdpQ+PB+oHiVlESgl4TZKSilqVovQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420160; c=relaxed/simple;
	bh=skk3bwgggwxUoahjfYSH2fe5PRYax27kvyegnDosuRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMl5tAzc+kq4TXCWUEqRhzfe66LHix5skFHFYfNEO3SUCJH1Bhr87M/AfPwd5Y0ZOXsR8Huda6c4dpVXu1cAlDHjfAyr2yLsM5big2In/u+vE7p4l2FjxmDPFxDNqS5yfKGdeVD8Yp3QE/jD2HOeonXb+WgWhvaJT5UUwqEtK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWjl7Beo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FC201400041;
	Sun, 17 Aug 2025 04:42:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 17 Aug 2025 04:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755420156; x=1755506556; bh=UBxAH3Eqra2xQGOBIjcZa79z0oTxuD2RIWt
	YKIdUirI=; b=ZWjl7BeooIrut4NFAQze2EfAJUo3X/3wSGU80HnOJV22XttbR9W
	X/UWjQM1T/JtH1jF7dE9xtD6q+OYhtO+Va0XmDj1gqGDrN+9BMARdzXKVptZnwxI
	TtpCUKa8jL/2SJDIexvOLVe/LZM57vrdLefyma32muxm8UFEMyeufv4jRmGltsy1
	sNxKN8h9dy/Lp/0UzESW396pe1ySrega6f/pPxy9EtrLEIqCUm1JMz6RybaRaR+4
	lhRkLJYlyEa/TO+nVB4p9GlaqUextCSTiY0RRHmoNvIai3KoXxxbbOqaMH/Fcjvr
	z84hdl1FBRMQsZfIERtB+aC3563l2qtg/JQ==
X-ME-Sender: <xms:_JWhaLc2-MhJt2FzQhAatmLoScWo14_SMup8QLVMC6ThMg0ZRAarZQ>
    <xme:_JWhaOGKqTwWMVEQMjhKoLwDf9F21dSwLrNFUlk-_Bt9l6TuSbL43XVKHa_zqnXnc
    Tf6wNc4WcROrMU>
X-ME-Received: <xmr:_JWhaET97lmupVdXfbGAQofeg9fEImYY5L9xqB1HTe3YNgpTN9rsVxd9Ngap9WS-AHI06o4rOwc22L1U0Z34gGF5eHPiYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghprggrshgthhesohhpvghnrghirdgtohhmpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhes
    sghlrggtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhise
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_JWhaMYdffb9PJ9bPcjFfLF4izQqxsTKRMQLeOPuaJVsm9LAOxGPtw>
    <xmx:_JWhaH1HL5QtFER1ss8Z21kre3YNmqoxvB-7R4BS-ejL6CsH_irLBA>
    <xmx:_JWhaHq6nqhyh7RN5gYU6uJ4xIUx3bsZQI3SP2ErwRp7j4_qksJYPA>
    <xmx:_JWhaOPoYpOChpVY2ssZXOszr7iQPmvrZG4RpNkYYloBVY6g71aZdw>
    <xmx:_JWhaAzMLY64UlDXbH314be2N67uAxR8yGocCKENxuzL3iFU_55CQI2s>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 04:42:35 -0400 (EDT)
Date: Sun, 17 Aug 2025 11:42:32 +0300
From: Ido Schimmel <idosch@idosch.org>
To: cpaasch@openai.com
Cc: David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: Make nexthop-dumps scale linearly
 with the number of nexthops
Message-ID: <aKGV-OQ_EO749Xi0@shredder>
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
 <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816-nexthop_dump-v2-1-491da3462118@openai.com>

On Sat, Aug 16, 2025 at 04:12:48PM -0700, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When we have a (very) large number of nexthops, they do not fit within a
> single message. rtm_dump_walk_nexthops() thus will be called repeatedly
> and ctx->idx is used to avoid dumping the same nexthops again.
> 
> The approach in which we avoid dumping the same nexthops is by basically
> walking the entire nexthop rb-tree from the left-most node until we find
> a node whose id is >= s_idx. That does not scale well.
> 
> Instead of this inefficient approach, rather go directly through the
> tree to the nexthop that should be dumped (the one whose nh_id >=
> s_idx). This allows us to find the relevant node in O(log(n)).

[...]

> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

