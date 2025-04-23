Return-Path: <netdev+bounces-185215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C624CA99509
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55EB1750EF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789A281363;
	Wed, 23 Apr 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="j5roQobR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duftJup6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3D7081C;
	Wed, 23 Apr 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425666; cv=none; b=UZ/OvMLjGVsK947pFRI9XdCbGGIjXusQjE422qRamReyHYjKGokH9b4Ix8MMgIgFwB7kcA4nLHHqa5eDWghZVQbXy84mGfiXZvSypdLUAaeoGTJ0/OwJeQYpBRcg7O3tn/UFlhTr9K8pCOPY6+QX+bXBGCrkPU0fEmtWeCYVgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425666; c=relaxed/simple;
	bh=YRSeARXLJ0+M5QmRsyz4Ce0deqMVgy2QaSMuzKH37GY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Sw6FetIg3ZTE54pTFY66VsFY4jl3c77y7kN0AOKuCbGyjOl74yHxSoe9ePwRvd0Utce1m2hJDz/8BItmIRud5Wh4KJuNWmLzNRjl8eSY3037a24m+diockoju2xMX1atTHa9iVKymOF0vpS7wHf8NDdRdHHu4D0zLRwEfDNSo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=j5roQobR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duftJup6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DC8411401A3;
	Wed, 23 Apr 2025 12:27:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 12:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1745425662; x=
	1745512062; bh=laGTWJgN6UXMp/JePdc+em5lh/zIgzPhHj+TRdm/XTA=; b=j
	5roQobRuUZBo4oSrXJp3rLhbaK5D6itijy0J5yld3XvkI1AdJbWj5m5ORa0t7h+M
	gjYDD9gPKG5O9LMnnW0Iq/4MHI1NkqKpjp6kHYsBC7Cl0XM0Wh4/sn8CDqzfXvtn
	WyQQgv9nBjIticuyHKPtipSWsMbkQ9qSTqwhkLpRuDjT5PBUZhcCUyD+UxHoxoAB
	ta0sFbm6eDLy2WUrphbjWFvGGDopC23gDAVHypiQ8JozWytTBN8mYlCpLP5Pxsmd
	AYJqzjuQy9heQ4IEyXXFftQix3DnbH9A3VQCYBAO8rtLNMTDokQNmq0coi8j5wsg
	yrrzZwluLwMa0qACqu5Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1745425662; x=1745512062; bh=l
	aGTWJgN6UXMp/JePdc+em5lh/zIgzPhHj+TRdm/XTA=; b=duftJup6BBprq1Q4d
	9TUiJU1fGeeGxC8fpx6qlUPedU3EM7hYe36FmVBNKjJ0QfqR2dxI1VZY37oNN8Nv
	Di+wSofY1oS1YQGue7/cvju6Xpz81EDxPGKXRVOPNC+BcSZF4CMswuBerlNZ7v84
	Uq2NWWC3siD0e/pd68VLv3zKruHzqaHTxN9hUA8979GfmBLTBqgNfypAace/rG4P
	0hmfaW3tZaH1KbILKHCymWTjXLyBnb00HQf/s5JXOye8gbi385Ax+jQM/4mI3HpP
	55e27NU7sBYzUPhuLRdE67c6tfdxjqRILuRXbuHOv5++6oiLwWRkPFEV4IHom7Jm
	r09DA==
X-ME-Sender: <xms:_hQJaFEpjEImHWzGuHR0uRJltqXr_gz2P2SJe1L3wAK1DybwjHMhTw>
    <xme:_hQJaKV5bt_meAaHUQTmbHd7Sbt5JpqfXkXevMKI4_0RIfW8L5LZjwaByChE15pVQ
    A7xhpILGRdJR1DszLA>
X-ME-Received: <xmr:_hQJaHJh0JT6Y5C2sl0lgjhMNQK0uhvBXmMBHGTlSn9ucmTNgeHALvV3fs1oQjn1F3_AcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgffkfesthdtredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeejvdfghfetvedvudefvdejgeelteevkeevgedt
    hfdukeevieejueehkeegffejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtg
    hkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohep
    tghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:_hQJaLFVQYpxtYmw1bhObOqTh8klmDWe51TsXHNmtI6swv074KxUng>
    <xmx:_hQJaLVGPkrWmpWM8GaStSGkYNjbx_FGsFPOWcsIRjXXZfEwJASAGQ>
    <xmx:_hQJaGNVzTXWtQ-na1IaOE1J3o8kJxAeywIUgCOjun9v-cksv9RuIg>
    <xmx:_hQJaK3eBWfiwBN7VXTKUENDAU7-Z0XsltHnvqx9gF97fQjpIsNcSg>
    <xmx:_hQJaBjgyyp7xVRpWGfCVVH-pgrGwuV1GyJHXMEBo7I7gh-5gct-RgIf>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 12:27:41 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 99B339FD42; Wed, 23 Apr 2025 09:27:40 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 9882D9FC4C;
	Wed, 23 Apr 2025 09:27:40 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
In-reply-to: <aAXhiW6n-ftxAr9M@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine> <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora> <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora> <155385.1744949793@famine>
 <aAXIZAkg4W71HQ6c@fedora> <360700.1745212224@famine>
 <aAXhiW6n-ftxAr9M@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 21 Apr 2025 06:11:21 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <511372.1745425660.1@famine>
Date: Wed, 23 Apr 2025 09:27:40 -0700
Message-ID: <511373.1745425660@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Sun, Apr 20, 2025 at 10:10:24PM -0700, Jay Vosburgh wrote:
>> >I'm not familiar with infiniband devices. Can we use eth_random_addr()
>> >to set random addr for infiniband devices? And what about other device
>> >type? Just return error directly?
>> 
>> 	Infiniband devices have fixed MAC addresses that cannot be
>> changed.  Bonding permits IB devices only in active-backup mode, and
>> will set fail_over_mac to active (fail_over_mac=follow is not permitted
>> for IB).
>> 
>> 	I don't understand your questions about other device types or
>> errors, could you elaborate?
>> 
>
>I mean what if other device type enslaves, other than ethernet or infiniband.
>I'm not sure if we can set random mac address for these devices. Should we
>ignore all none ethernet device or devices that don't support
>ndo_set_mac_address?

	Devices without ndo_set_mac_address are already handled; they
are limited to active-backup mode and fail_over_mac is set to active
(just like Infiniband).

	I'm not aware of any network device types other than Ethernet
(which to bonding is anything with dev->type == ARPHRD_ETHER) or
Infiniband in use with bonding.  If there are any, and the driver
supports ndo_set_mac_address, and it fails for a random MAC if they try
to use fail_over_mac=follow, then I'll look forward to the bug report.

	If you're thinking of devices that are type ARPHRD_ETHER but
aren't actual ethernet (virtual devices, veth, et al, perhaps?), then
I'm not sure why those would require fail_over_mac=follow, as its reason
for existence is for multiport devices that can't handle multiple ports
programmed to the same MAC, which shouldn't matter for virtual devices
or single port physical devices.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

