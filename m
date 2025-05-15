Return-Path: <netdev+bounces-190776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BBAB8AB2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886DE1BC1D70
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFB1B0F0A;
	Thu, 15 May 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gFCEUkQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYpSyON9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB04B1E75;
	Thu, 15 May 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323050; cv=none; b=Iwtvxs267jH6Dmk6RlwTOJH5AQZ8X6M26lBks8LLWwkmEQ9OrK/IE8JD0ctFm/m8ljliMBWY5pFUCNFjm0PtgTk6zsGw7j4evSQjbwxhgsossQ6zLTFVKRVOzasP1RTqPiwvTSh2kDju1cXt5uuawVawpa40dfP528wJvabImZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323050; c=relaxed/simple;
	bh=gAq66lmlIXirgAZXOLRYYgtXpOMIICQ55VBAdFF5qA8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Pe5kIMOq53pBvEcppT1tV+bi1XqIYEeSBhpyA2VM6biXFBAWJeUoJFuJ2pekZhFvYGpKsSI/8o/8PF3m7aimb0OBrHzPzQTQ6NlduAnGbw6iZdMidjGcmVzim4Cd8riNG+H1hNmDlntCLy5A86feeiZGp0eGe8mD7P9chp5miyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gFCEUkQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYpSyON9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90D2C2540130;
	Thu, 15 May 2025 11:30:44 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Thu, 15 May 2025 11:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747323044;
	 x=1747409444; bh=TJEMi2DZszncr9ngWM9TKXoTkgSwUZkQzL00n+Zz2qw=; b=
	gFCEUkQRlUW98VEKJW6ae5xVd+2EGQmmZgY9V2ErOJMpmFSLtVeYUn7vBh1mIR/c
	pIMMsKnKmsb8oSTKmVNR4nQhn8NaOJ3E7NJgOt3AbPlENy2Oufwf78MY9MQNZuJc
	zt5jawQqJ/dP1eAqy/ZkUpzVS2WsINx5Yn7cwbf/VWURsBfLkAXCPVDv3zQXnkZS
	pnkBPCWw0SMka9wIDpBfUUWyOT9aSjbYHFksospR/sD/AnkJWV1Q0EkGgIbIs5Q+
	X7BhiCmpe7ZVI0FI4tv9aWUlK1m9jIDMovUtmT11Q4lf7kTPhaRu5lLosTDJUsm5
	T4csTDxbUqyfcdCebT4Ocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747323044; x=
	1747409444; bh=TJEMi2DZszncr9ngWM9TKXoTkgSwUZkQzL00n+Zz2qw=; b=e
	YpSyON9eH8YqK1sQFhY1jM2zM4qA+qlYy9v8lCfn74O8NXgcs2h0LcsdF8vc8tL3
	ExSVzbbo2PGseYQ5iS/ognfYwExLgdNGD8nvMrBKHtZq/XpVJC11Z4Tz3OSPG6m6
	AmyWtoRn37iMjRbHiEO2E2+Xl0Jq2eZhsz3DPiph27MnxB1/gssf3YTlByf+UJzd
	NOeRDuWQf8xps1JO8tYo+02Iyf7+7Y30+C220Fyf2bZGih9DtyWK/n3Nl74SDuRY
	Os7M99b9ISREomM5wTXRhpK6FJ3cVpZzz3WdOQL4CL1NoPjIhRE+oPUmpHFGpK9A
	CdsFu1Hcvp/zmuXvcwwKg==
X-ME-Sender: <xms:owgmaGMh5Bb8X3GqK7Ok5r4gIdbtYZXS9VBplR-Db3prXUGMSNwv7A>
    <xme:owgmaE9FW56lru7QtPDjKQiU9fBQmce8GvGSQ551VpMKkA9tDRYgummYk443eQIqc
    xu9b5HhxgpAlA7qzls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphgvuggrsegrgigvnhhtihgrrdhsvgdprhgtphhtthhopegurghvvghm
    segurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkoh
    iilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvth
    guvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mh
X-ME-Proxy: <xmx:owgmaNTUVctqHw-QjwD0nY9t83FdegmgXutQmh9Bz6ofcioYOn9OGQ>
    <xmx:owgmaGuCFQGeJIU5ZA6L-BTxwVvzoVY466kSh82V3Ufj3v9M6Uqx_Q>
    <xmx:owgmaOdtPArKqOLch2ZSkrn9I4enfRxvTKPMZwlnFhIQhKC1os924A>
    <xmx:owgmaK3xUsqzlsLJm-8KuoHYjzmyHRW7TH52jdFoeiqs2smkdP7v0g>
    <xmx:pAgmaPJvSgWKQufyoyLQUTE0ALLALHWgjv4ZEKgpaPgvHXyf5HKAmDAT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABE3A106005F; Thu, 15 May 2025 11:30:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ted1cd7a392a3d5bf
Date: Thu, 15 May 2025 17:30:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Peter Rosin" <peda@axentia.se>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Davis" <afd@ti.com>,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Cc: "kernel test robot" <lkp@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Samuel Holland" <samuel@sholland.org>
Message-Id: <8819720e-dada-4489-a867-c4de0f95a003@app.fastmail.com>
In-Reply-To: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 15, 2025, at 16:05, Krzysztof Kozlowski wrote:
> MMIO mux uses now regmap_init_mmio(), so one way or another
> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
> !REGMAP_MMIO case:
>
>   ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
>
> REGMAP_MMIO should be, because it is a non-visible symbol, but this
> causes a circular dependency:
>
>   error: recursive dependency detected!
>   symbol IRQ_DOMAIN is selected by REGMAP
>   symbol REGMAP default is visible depending on REGMAP_MMIO
>   symbol REGMAP_MMIO is selected by MUX_MMIO
>   symbol MUX_MMIO depends on MULTIPLEXER
>   symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
>   symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
>   symbol MDIO_DEVICE is selected by PHYLIB
>   symbol PHYLIB is selected by ARC_EMAC_CORE
>   symbol ARC_EMAC_CORE is selected by EMAC_ROCKCHIP
>   symbol EMAC_ROCKCHIP depends on OF_IRQ
>   symbol OF_IRQ depends on IRQ_DOMAIN
>
> ... which we can break by changing dependency in EMAC_ROCKCHIP from
> OF_IRQ to OF.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202505150312.dYbBqUhG-lkp@intel.com/
> Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build 
> regmap")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

I'm unable to test this on my randconfig setup, but the patch
looks sensible to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

In the dependency loop above, I think the PHYLIB bit should also
be changed, but that is an independent problem.

I see that OF_IRQ still depends on !SPARC, which may be another
source for problems, so it's possible that anything that tries
to use OF_IRQ causes a build failure on sparc as well.

     Arnd

