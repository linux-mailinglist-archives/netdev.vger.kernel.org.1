Return-Path: <netdev+bounces-211182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E835B170E5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BAE7AC42D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708911E32BE;
	Thu, 31 Jul 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAXT7iuS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6471990D8;
	Thu, 31 Jul 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963712; cv=none; b=KSD+Xh8FxCL6/ReUPc0TbVUixsOYUWdKXwqBGP7grvx07SFg24eiXk5VTGOtryt90ndXTOHB4tJLDVOK/v/d9F2nTbXICN2vVc+jliRcd35cyYcPEBc7tB1N005iNa90+GF3TtOc7d5YiKfUSMrxLy0Lfjy3bnRcnm0AvzJNHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963712; c=relaxed/simple;
	bh=eyO1TrLMlEtrenSc1Ru9gF9wqkZNhnimPOg/iczhekE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP7keT7ICoAxZj7z9ACuSGltOjfeLYWLuwQgdqNl8ziztOT0ckssSiWtGbt/ECyc9eCILj5eCQj0sUBzcCC5AoRv9KsDJHlvPJ+vunWeIa6GZXkCOqePGSr3KByhDl1HKgJyd5znVNiwyc5gIm5YBwGf/DwSHH+0lkLRQqAfZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAXT7iuS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38AF47A232A;
	Thu, 31 Jul 2025 08:08:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 31 Jul 2025 08:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753963709; x=1754050109; bh=15iezWKQjz6LO3nVAiquccDeiBPZNVR4lsE
	l6zIpCPE=; b=dAXT7iuSzHJfEsZt9PCgLolr43EJJL7itzi9agwizdMCBbb9tTo
	r0kLTqXpzMPOv7D0XbArGs+rf0FhfoG+o/IThfJrQnfZhdGTQ0O6i4L/1FytWIJW
	QVCbX1pWt1QHpJheLY60tdne3dMhqCg+q83zo7Jf7B6SDo5LDQrtm5kg107Wpz0U
	InZRLhipNWMLCy08StIMdh+Q/Cfo0gNcVNZwX7Qr9/4lf0JsGG+yRl2UEtKLALuw
	sWwY2BwysGn71HeysRWB7GVFvNaG9xY8p+6wqhFR4zHKQSpRRBKtw4ZbrUjdg+5a
	8wiMMLW+yS9V6kOoiQRi1yDXYzskyAvyQoQ==
X-ME-Sender: <xms:vFyLaMvX1k0_24n4BxBrgC8AOeacOZLET8DDJVyZxOiG7j0V2aKFQA>
    <xme:vFyLaEFz_qRfBjOddlzkmf80FxpRLy5f1_foHJt-uXw4MV1NjQCVrpouaHbh4-Lv6
    UJ3n6KxQZI7xjI>
X-ME-Received: <xmr:vFyLaNwucYvecc261KBDmbj7bqAMrekcx3DmBEfnGEtJrbI88g5xR5DexXof_WnmqfxCUmTkwnT8n3w6yvHZkx0V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgvnhhglhhonhhgkedrughonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vFyLaO2XIdOx8i5zBP5m0Z3RDOtFwwUubMns1oYAOVfrj-C8VM9ISA>
    <xmx:vFyLaNqEFCDydg8EslYbHZzXiFJFQBAbd7aCoJFl36_Y8p1fv2c7_g>
    <xmx:vFyLaLWlthAA_wsPMZVgasWgqXoBTDmvrfa3hNOFNFfgqL7NgdNAww>
    <xmx:vFyLaGot9h_zmjOCLnyae7nkBSlepJuzaKCPhNg4glba5FeW0iZH3w>
    <xmx:vVyLaOP82C2riJaYNW_SuZkH2ev9UVHHvcf4SH95SIF6SritB7tQFJ1F>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 08:08:27 -0400 (EDT)
Date: Thu, 31 Jul 2025 15:08:24 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: dsahern@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vrf: don't down netif when add slave
Message-ID: <aItcuFGx1S7ySE3y@shredder>
References: <20250731112219.121778-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731112219.121778-1-dongml2@chinatelecom.cn>

On Thu, Jul 31, 2025 at 07:22:19PM +0800, Menglong Dong wrote:
> For now, cycle_netdev() will be called to flush the neighbor cache when
> add slave by downing and upping the slave netdev. When the slave has
> vlan devices, the data transmission can interrupted.
> 
> Optimize it by notifying the NETDEV_CHANGEADDR instead, which will also
> flush the neighbor cache. It's a little ugly, and maybe we can introduce
> a new event to do such flush :/

Cycling the netdev is not only about neighbors, but also about moving
routes to the correct table (see the comment above the function):

ip link add name dummy1 up type dummy
sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=1
ip address add 192.0.2.1/24 dev dummy1
ip address add 2001:db8:1::1/64 dev dummy1
ip link add name vrf1 up type vrf table 100
ip link set dev dummy1 master vrf1
ip -4 route show table 100
192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1 
local 192.0.2.1 dev dummy1 proto kernel scope host src 192.0.2.1 
broadcast 192.0.2.255 dev dummy1 proto kernel scope link src 192.0.2.1 
ip -6 route show table 100
local 2001:db8:1::1 dev dummy1 proto kernel metric 0 pref medium
2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
local fe80::f877:f7ff:fecb:bfb dev dummy1 proto kernel metric 0 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
multicast ff00::/8 dev dummy1 proto kernel metric 256 pref medium

And it doesn't happen with your patch:

ip link add name dummy1 up type dummy
sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=1
ip address add 192.0.2.1/24 dev dummy1
ip address add 2001:db8:1::1/64 dev dummy1
ip link add name vrf1 up type vrf table 100
ip link set dev dummy1 master vrf1
ip -4 route show table 100
ip -6 route show table 100

You can try configuring the VLAN devices with "loose_binding on".

