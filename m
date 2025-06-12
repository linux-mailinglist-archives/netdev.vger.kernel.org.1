Return-Path: <netdev+bounces-197028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D8AD7661
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B927B505F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65B29A322;
	Thu, 12 Jun 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O4xLsFKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+mUcqWj"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B349299AAB;
	Thu, 12 Jun 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742045; cv=none; b=K415Xp6kXuPmw1LroICloesczO6A+Uo3pNSsvXqNonhyuYv3wlZ9LWrLAzfsOrupOYON5m7P5c3/94jUL0vrQNhuDR4EWF+rUY5OmX5zw1HJRMlzJE6H4Azxcvzgd8POybfERyaFXV2prq5nz85G3xvYnaBxL03qXEhq85OBfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742045; c=relaxed/simple;
	bh=TvKPFY9PN30dftdt4TdDN4waIsgGAY0x6eO7C/osMvc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gfK+8fxRfpvyNb/h20q3xA8sJmJ/aId2eCO65Or9j/OYoy3TT1nyL4nw3IE4uFdQVH0iNUTRGYXy72B64voxJdc4N07uouLBUDMOmpw9KGD+ifOvxJ+w+kcGPXFVykUpxugsM+LKyVJiCqsN+6gyXaZAaKgll10GpwdZq2/YET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O4xLsFKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+mUcqWj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8349711401C3;
	Thu, 12 Jun 2025 11:27:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 11:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749742043;
	 x=1749828443; bh=kSW5V3qXM0uMitihH5rTOGEmJIp6Xt/2AQPY8NBwQuY=; b=
	O4xLsFKnAeFgLx5yVsYToH1PR4lWdwbJs+D12Nkyn3b5evb7GZsdOrtPAF73euTT
	ej7h/SLdZfifHrimExeuSQOJBh8K9NUHfh6/NFoKIhd3KrQJQt1S7DTNImPXmZjF
	A7eDOyPmVWChYj0stWxriIXKpSSlzTLpqgc2DXAYxvFft7Mi1whSsS4s7jz+HovJ
	Yoom+HhOycj6lyiuLUh56SRRzk6c7cV/wcWn6S1iDMu7RMWnCzGdWPCSPvcJAV/q
	bqmOXDwMaFBPeJpilVtHa1zjcCf9ZbkYrUn8Vq3ZE1MsH8huKKGf38F4bSmIC/o3
	5mbuqu18qmQsxvznFd3Vaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749742043; x=
	1749828443; bh=kSW5V3qXM0uMitihH5rTOGEmJIp6Xt/2AQPY8NBwQuY=; b=o
	+mUcqWjCMuyJdri6K1m9pnbg9LBJxcU8JFFSsMZ5ByHbKyErIgMTt86bU0JRSzQj
	q10wHZT07uYWhiWGAdbSh8wMmB3LuN49V6oUfA3w7UZuNwz8mkoE0mE0UF+FvA4v
	dhJ9/4qUMFe3fOmKZY+z/231IZDvfn7D9q8a5h0BkMMevEHjR6xAOywVtywN54U2
	pmGDKMbxhe0pKEscichLCLBdxB9pSTaKbPNF289gR+mtcsyWMeBixKS/y4k46kXw
	r3o5oqeer96BQg8EtFsvdFc7erc9dJRNEN2WbYR4zJba5ZJMkVTZ2SNcyS0LT53J
	gow+1OjCyTgMRJ/VV21Mw==
X-ME-Sender: <xms:2vFKaMqZkCIfBSLPtxLo0h7Mtu29IHtDNWViYPtF0lWqhBFfBDLekw>
    <xme:2vFKaCoT69sRLlNcXeTATN_E3P0yei_ZduX3dHbr76bzRdcexjp9_jKLGbO5rK4SA
    fVKtLPwY2_hBJLzWIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehlrghnhhgroh
    eshhhurgifvghirdgtohhmpdhrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgif
    vghirdgtohhmpdhrtghpthhtohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpd
    hrtghpthhtohepshhhvghnjhhirghnudehsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:2vFKaBM9Z-Q8gr-tmBPDoMDP8GbRhRG9QMB_HzQ9r5rGIdNMPmMrGg>
    <xmx:2vFKaD5_Ow3HpbiaKUKjKUE8-3mY39X2eqWKZTXBy6j8anOhvtx_RQ>
    <xmx:2vFKaL6lEmQBWJLWqoO2gNf7YGBNqSlEDqkOjT9g6xtGiCid6LRGSw>
    <xmx:2vFKaDji52x8-CIjQypUTj2oT63JwrGHTnyb2kCq_3096IdzxJQkyw>
    <xmx:2_FKaAVxPqEBRH2g4nVvNzhMrlgtTKU3C_uTLT91QnV4XvFDx_YOwn5W>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 581E3700063; Thu, 12 Jun 2025 11:27:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0988381ff57d4bb7
Date: Thu, 12 Jun 2025 17:27:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jijie Shao" <shaojijie@huawei.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Jian Shen" <shenjian15@huawei.com>, "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Hao Lan" <lanhao@huawei.com>, "Guangwei Zhang" <zhangwangwei6@huawei.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <ad6c3eb7-22d9-4f81-8656-a1f62aba3b4d@app.fastmail.com>
In-Reply-To: <20250612073253.2abdd54e@kernel.org>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612073253.2abdd54e@kernel.org>
Subject: Re: [PATCH] hns3: work around stack size warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 12, 2025, at 16:32, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 21:09:40 +0800 Jijie Shao wrote:
>> > The normal way of doing this would be to use the infrastructure
>> > from seq_file and then seq_printf() and not have any extra buffers
>> > on top of that.
>> 
>> seq_file is good. But the change is quite big.
>> I need to discuss it internally, and it may not be completed so quickly.
>> I will also need consider the maintainer's suggestion.
>
> Arnd, do you mind waiting? We can apply your patch as is if the warning
> is a nuisance.

It's not urgent, as the current warning limit is still 2048 bytes
for 64-bit targets. I am hoping to have all patches in place for
the next merge window to be able to reduce the default limit to
1280 bytes and I can just carry my local fix for my own testing
until then.

    Arnd

