Return-Path: <netdev+bounces-212349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251FB1F8F3
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD01780A6
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C26227563;
	Sun, 10 Aug 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FykBMwph"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47981E7C19;
	Sun, 10 Aug 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811718; cv=none; b=iBm0qEkn4r30UmPCquJtfUDt8nmMA/VtnMi9kSmcdDggnMbTYM9Y3V7+biDa169VFU+RkPuj8PMaPpZqp2edse0XEu5UX5f9CjHP4GW1NqNT4Geq04Tveys6hmnGr38lJDOPctfwjV5UOnXKAKUs3oNbovI2cssKSBNLYjExXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811718; c=relaxed/simple;
	bh=LHgDFxP3XNY/BaNZDOHVAHZ0/bMk5RECcQRqMjPp2kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyi5gextIN9mPdyV1hfPfhTJuTPoP5Tl0jGF+/JO1ndHi+fBzGgPBwLI/CeWfxzL9j3/lTM0X2j8Sjcu1CRkaZcTaeuTxxBfgzd0W7hgt1U1YeN9Be8oSJ6TTlGs5MkSqdLO31VaDWIljAV9fM8SdwQs4Y6csqY+YVxT1mSLWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FykBMwph; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 532E21D00027;
	Sun, 10 Aug 2025 03:41:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 10 Aug 2025 03:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754811715; x=1754898115; bh=ZBpDMWwG52ZlaidcpEch1+eTaLrx9B9nAIB
	cLcWcipQ=; b=FykBMwphm94LCK9WWheVlz2z/mmSjeophpu8qZSqSQPaA+Zjhwy
	MdhD+bk/WEKBDjfWQNpiSk8ShcTXacERf6ZiSWwv5hteB6zhMQ8MqhD6FZhAc91d
	oHww/m79p9DyrxHcSIE14DE+pc5XawSv/rpmemr7gbgLPu8o2sCp5eC8wl8HShT+
	WlpCB2utNFCp7tadhiya4P4lssEtTk9SQLRPGxaXpIOmXtBAX4wCftxX/+70lKxz
	l1qfIba3QFTZfJuDt1yscWPlbWIHnAlc49ZUenv1E+e5fnmQKqY0h6xaD4ZPM4kE
	2XWK9xq5TjteoNYLDDojA1SPeWHcyrLPXpQ==
X-ME-Sender: <xms:QU2YaAxDmBrN_Gdo59KNbwK8oSA925CfNUc0lpcIB6tBthT-YX7uKQ>
    <xme:QU2YaCzci3WgluqKFvPRQ-ptDLSEkKFpN7N_jHf0_nXwkAgd7ClnFsy4DDLUTuV7-
    JLU2_scfh5aUZo>
X-ME-Received: <xmr:QU2YaN2FCnP6cEDo5l6Kmgakp5zJqw0rJkBwY1ezHu6BSwYhuN0Z4W3ymhSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvghnghhlohhnghekrdguohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:QU2YaIog91-BIcvRmTWF3_hMp8s0wmdDdffT4VB2LH_X6GPm998mVw>
    <xmx:QU2YaLBWjc_8J9vgx0iF2tw-9NFDIkmyg5GCV-Up9X2vxFfD12KKcg>
    <xmx:QU2YaBqaCyiAlhv1_6jseAnjUMkHT-F1gbmMCtC_ySUOqQMnnxL6qw>
    <xmx:QU2YaOANkZyBf0O2BVa0EaQy33d1usHbXvY8AtvS4HJThfRKg1383A>
    <xmx:Q02YaEgm8MnVzXVJVdBy5_QPGIo7mWPiiZ8Uad5OU71HtI-TumyJ_ATK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Aug 2025 03:41:53 -0400 (EDT)
Date: Sun, 10 Aug 2025 10:41:51 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: dsahern@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com,
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: vrf: don't down the interface when add
 slave
Message-ID: <aJhNP_xQyENLSF6d@shredder>
References: <20250807055634.113753-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807055634.113753-1-dongml2@chinatelecom.cn>

On Thu, Aug 07, 2025 at 01:56:34PM +0800, Menglong Dong wrote:
> For now, cycle_netdev() will be called to flush the neighbor cache when
> add slave by downing and upping the slave netdev. When the slave has
> vlan devices, the data transmission can interrupted.

OK, but can you provide more details on the production use case for
enslaving the real device to a VRF during runtime? Usually this kind of
configuration is performed before data transmission begins. I suspect
this is why nobody complained about this behavior despite being present
in the VRF driver since its initial submission almost a decade ago.

I'm asking because the potential for regressions from this patch seems
quite high to me. For example, before this patch nexthop objects using
the enslaved device would get flushed, but now they persist. This can
impact offload of nexthop objects and it's possible I'm missing more
potential regressions.

Before:

# ip link add name dummy1 up type dummy
# ip link add name vrf1 up type vrf table 100
# ip address add 192.0.2.1/24 dev dummy1
# ip nexthop add id 1 via 192.0.2.2 dev dummy1
# ip nexthop
id 1 via 192.0.2.2 dev dummy1 scope link
# ip link set dev dummy1 master vrf1
# ip nexthop
# echo $?
0

After:

# ip link add name dummy1 up type dummy
# ip link add name vrf1 up type vrf table 100
# ip address add 192.0.2.1/24 dev dummy1
# ip nexthop add id 1 via 192.0.2.2 dev dummy1
# ip nexthop
id 1 via 192.0.2.2 dev dummy1 scope link 
# ip link set dev dummy1 master vrf1
# ip nexthop
id 1 via 192.0.2.2 dev dummy1 scope link 

> 
> Optimize it by introducing the NETDEV_VRF_MASTER event. When a net device
> is added to the slave of the vrf, the NETDEV_VRF_MASTER event will be
> triggered, and the neighbor cache will be flushed, and the routes will be
> moved to the corresponding table.
> 
> The moving of the routes across tables is tested with following command:
> 
>   $ ip link add name dummy1 up type dummy
>   $ sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=1
>   $ ip address add 192.0.2.1/24 dev dummy1
>   $ ip address add 2001:db8:1::1/64 dev dummy1
>   $ ip link add name vrf1 up type vrf table 100
>   $ ip link set dev dummy1 master vrf1
> 
>   $ ip -6 r show table 100
>   local 2001:db8:1::1 dev dummy1 proto kernel metric 0 pref medium
>   2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
>   local fe80::cc26:8ff:fe02:ae95 dev dummy1 proto kernel metric 0 pref medium
>   fe80::/64 dev dummy1 proto kernel metric 256 pref medium
>   multicast ff00::/8 dev dummy1 proto kernel metric 256 pref medium
> 
>   $ ip -4 r show table 100
>   192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
>   local 192.0.2.1 dev dummy1 proto kernel scope host src 192.0.2.1
>   broadcast 192.0.2.255 dev dummy1 proto kernel scope link src 192.0.2.1
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

