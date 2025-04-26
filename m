Return-Path: <netdev+bounces-186219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FCA9D76C
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 05:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B785A571A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE11A9B48;
	Sat, 26 Apr 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="coIDnhWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8xwFcWK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADE84A35;
	Sat, 26 Apr 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745639496; cv=none; b=G9O7pyjwdrR8Fp0RupxsB7D0aNDyXbVifDsNiO57eSwqm8Arr2NVOY6/HrsB4g209AzKqSLI1XXy/tjvoSNbbBPMy3G1PVXXfD09dZXaGQdlTitP5biDqi8Tsfyemc0XmZ0xWNjklcxIpKuayAmFPh67mz2dPBvreutpN3K3tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745639496; c=relaxed/simple;
	bh=3FCNAGBuMVeRlPJxHJKV9k+4t1GboLe5+s7gSRP29To=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=W9VCo4LeFQfm2CtTB0V+R/XhQ+tQd8eY+vqbB3Fx2SU84EKVYSn++h5pFJ1xEOTiw3JEfgdHd0+RxNMJgsq3fSXkNYn/+EmtYAMeIb/z2WmF2hfNE7oxdMvl815ggRlQOPaQdPsmgiFbl383SQ+snRDLYJ6QAppp/dZORRMnS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=coIDnhWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8xwFcWK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E3F213803F2;
	Fri, 25 Apr 2025 23:51:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 25 Apr 2025 23:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1745639489; x=
	1745725889; bh=OVocey+a7Pu/T08paWCevg+P1KK8ac/ZJAcer9HGsLM=; b=c
	oIDnhWS7oZ/v1FRa25fNQExJhMNcHwHg02Mi016H1/hptbQilHyHnVQTqNaLJ0Lz
	wQvQUqEusotmTdbEz+DCVX9yRYKldtJ6y9Ojac7EYl/P19nKcgBz1Ojqt7TDNJwe
	B9N7nzsXT3wepeXRvYzhROJ2+ODokcj93CHctMBJ8utRpvnTdi0Ka9Ry5jGq8f1D
	tFKtn4LmY1LN/nkqpbWr7ox+c7YDajoJNVARx2DgFIm+tDXkgeQS9c53oaLTZ5Hj
	NY15e2DE2Fe4p+G5ZasVmppaMnFTdTiCXURS/wwTISGXN/RybdffsDGTHSFnm6Lc
	4ocjg3b2Jr14jfrpWt4XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745639489; x=1745725889; bh=O
	Vocey+a7Pu/T08paWCevg+P1KK8ac/ZJAcer9HGsLM=; b=M8xwFcWKS/Aqe8fa0
	4eEKlLgtQQHXYVqi0ihn1MTAgKbWYuMSf0Ye5GUx6wDhw922jmeR1/MfWZrLsYTu
	SKHYwxmoqWsyqrGziwUZmQR5rS7QIZq6v7/HKFad5O914YxcY5LGYhGLJwFi7ped
	p8fEvBj105FPgRTJiQIxWhpgGJ7Z5AjKQZjd8VS0NUWzsOlABqSvijP4xAKswh+f
	r0htO2y9y66ZVH6fWx8GYbbIw8iNlghh0RGumGemGiliaIx7flG2zsOVsAuPD3SE
	6zVWH+GpwdzLhRcqDbmWiNNZx26olJSNkJbmeOAMuzMZYXsRbMT0YdIOJ1obzey+
	mieVw==
X-ME-Sender: <xms:QFgMaP9TjPUgvNppVTWhBFqPD7dHqBYW6Mogmn9AWLRP0KJriZ6NXw>
    <xme:QFgMaLv5QHmO1MjmUoZy1yjXxSQlc7gSeNtPldCaddrCexvJwusR2CTuj8PdxE7w8
    s4wBTJjJCqAK4F83yE>
X-ME-Received: <xmr:QFgMaNCuzFpCt95YzmvKPJAvDPODIc2fmjGfOona-4yY52DWdj0Yn_HworcHrmY6zLnu0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheegudeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QFgMaLe62FqbKcV93osDtJmURibHfjS2EWW-0BHtLD0dVgMxf6u2DQ>
    <xmx:QFgMaEOu_3TuBtTwrcza1OpP8WNn8h7ktBcvoXLEXPDVbET7A6L6hA>
    <xmx:QFgMaNkAGMgvaKuB5_PDfcrvoPDUOYqyGgyS77Lb_tgXxLOER31MIw>
    <xmx:QFgMaOvjpCskvassSRkqkYbbI6NYxhxzrymYTyt0zWBkqL_Mh59ESQ>
    <xmx:QVgMaL4XmfUpcRPZgJToeJ_uqxRr84hdhZEDR_aWraztX9PvTNxeo5wo>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 23:51:28 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 43C7F9FD42; Fri, 25 Apr 2025 20:51:27 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 423BE9FC54;
	Fri, 25 Apr 2025 20:51:27 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net] bonding: assign random address if device address is
 same as bond
In-reply-to: <20250425190419.273eb34b@kernel.org>
References: <20250424042238.618289-1-liuhangbin@gmail.com>
 <587559.1745538292@famine> <20250425190419.273eb34b@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Fri, 25 Apr 2025 19:04:19 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <657156.1745639487.1@famine>
Date: Fri, 25 Apr 2025 20:51:27 -0700
Message-ID: <657157.1745639487@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Thu, 24 Apr 2025 16:44:52 -0700 Jay Vosburgh wrote:
>> 	The code flow is a little clunky in the "if (situation one) else
>> if (situation two) else goto skip_mac_set" bit, but I don't really have
>> a better suggestion that isn't clunky in some other way.
>> 
>> 	This implementation does keep the already complicated failover
>> logic from becoming more complicated for this corner case.
>
>Any thoughts on whether we should route this as a fix or as a -next
>improvement? The commit under Fixes is almost old enough to drink.

	I'm fine with -next, the hardware this option was originally
intended for was uncommon even then (IBM POWER ehea).  I'm not aware of
any recent-ish devices with the issue this was solving (that multiple
ports of the NIC programmed with the same MAC made the hardware cranky),
so it's more of a correctness exercise in my mind.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

