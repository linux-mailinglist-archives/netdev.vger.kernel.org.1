Return-Path: <netdev+bounces-199952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F190BAE283C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DB05A0CDA
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997371DE4EC;
	Sat, 21 Jun 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Lwb1Fk50";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0dDBIUE"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72891A23B6;
	Sat, 21 Jun 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497694; cv=none; b=Uc2CvU21yZs97gIG3jYgzmrKLFpp+ZDAEuvNyqh54ICi5VcveE5/zSCegA1djbsplRJXFRgtO9+LTjKbuesbDbt+FPtfrU3Pz5i5Z9/fvag1g/9shxopUDCfBZG8Nj7tie1mBhtxwb/RubmMINeOjsp90h++7drpzryYN+iDdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497694; c=relaxed/simple;
	bh=4qdEsGlCBHQX9nBVHiBVWpPuog5cz+ELrrOp+xiPHBk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rr4cIfaul0D1NZEEq4+mOefWiXbMxhIQeoQC6b3I2/cW4IfvUagHHLwHs2w5yuxlbmomOUtxjlxHAzF6ikWHG+GHtETCzn9TqmqFYWVmsGBX7bPMjJMvjIPi3dvvxYCBFGxPNePxvl9cGX1nevQPSAPdu6RN4Tc3uKgtFIsvBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Lwb1Fk50; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0dDBIUE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BB2DF11400F2;
	Sat, 21 Jun 2025 05:21:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 21 Jun 2025 05:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750497690;
	 x=1750584090; bh=ks3h8kqTA1Gd5HYWPg1HjxoNrsoTSLNAQpFpPQpS1BI=; b=
	Lwb1Fk50lqZhMxrwSSnou4213Axyfsk4OYHx7I4uDTzR6Xoooy87fciBcG1faSL9
	uh9GCM4XLGHKiczdX3wI60boToc9SPn6wcQMowANgl8yQ0BIKlK2Znmyl45WgptL
	BiJzC5+FItaayZkmUBprH+hjSDywRUrK3iNqt0ocZUKHVU4Eqm0ud2EH8HDOCxXP
	tkUSBdG0bK9esafHmCIFGwumS9sPde9Gy7yxqSYlVN0XZyOFQYkcXW8KpuRPjXXo
	nRmhYFEwgxdYFYw6OW5QUQdreBuFzYznYSNouW4oSTWoTNYXXhYDMURnTfUwjSg0
	OjCQIDHofxsCciVKBAcxpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750497690; x=
	1750584090; bh=ks3h8kqTA1Gd5HYWPg1HjxoNrsoTSLNAQpFpPQpS1BI=; b=K
	0dDBIUEAwJeXnjheoU8xaXyFF9hJgp2CSmqrNG1on/konNrF19GuTJrq2+DfDlmx
	ALYzkEPk2zEqTpkJ62uMA8S86pVHwmFnW8gzo8T9k51MxHcO3pE6nha9WjcR5viA
	qGWSEBEfHNBC8T+4hR7itgxtKXRYUQ86C6a3AioL1zqWtQBJizbtsFZW/WoPwwJm
	Tt/dYP6VJ7nGQ2H8xDHIXTywmA+p1MyCN2vZaXYAE1fpw6cJuXKtLmti7XxDySjk
	vxznUQEM6lvJtluD9LVj9asHCrCpy2GOC2WIy2AXbIHlW7ncNJ/XfVP5tXRTupE1
	bi15YHDQEOuGu+17OoNIg==
X-ME-Sender: <xms:mnlWaK6bNL4S_cieJ1Hvs65rgdnv37dk42HMikV4mpqfIW6cmv5btg>
    <xme:mnlWaD65ovBoZQrSyZtIOKxwqDya9bN4EGX_9YGW6PNLCiiWR4JmmGZS_BICbwRxU
    E5PruexhcU6GKLd298>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddutdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvjefghfdvueelffekffekvedvleevveeitedthedugeejveeiledujeeutedvleen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhprghsthgvsghinhdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughu
    mhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghp
    thhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:mnlWaJfrPig7I2IzHkzat4jY2IGQFpaAIMSIJN5NqDb1uQVw9WXjrw>
    <xmx:mnlWaHJlixBk9Rmdyi_o7UBwes8mhdd4MryOUQXJhELLEJtdI-YH8Q>
    <xmx:mnlWaOJh2uU0lHzrNGH7ZaiJvhqcAJ-Q6JhEt66_sfTczmBMFsP53A>
    <xmx:mnlWaIxVK8vuUHcth_jaxrEs7aOVvGjoBbnnL47wbBUyvgQhqVeyjw>
    <xmx:mnlWaPeTpImvQDmMcY-e2EXScz0qZ8bViMDnzP7ntkB-r501HnoOkoNQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00D73700062; Sat, 21 Jun 2025 05:21:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T00f0f82e82a5e42a
Date: Sat, 21 Jun 2025 11:21:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Simon Horman" <horms@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <75623e39-14da-4e4d-8129-790ed08b66ae@app.fastmail.com>
In-Reply-To: <20250621074915.GG9190@horms.kernel.org>
References: <20250620112633.3505634-1-arnd@kernel.org>
 <20250621074915.GG9190@horms.kernel.org>
Subject: Re: [PATCH] myri10ge: avoid uninitialized variable use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jun 21, 2025, at 09:49, Simon Horman wrote:
> On Fri, Jun 20, 2025 at 01:26:28PM +0200, Arnd Bergmann wrote:
>> 
>> It would be nice to understand how to make other compilers catch this as
>> well, but for the moment I'll just shut up the warning by fixing the
>> undefined behavior in this driver.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi Arnd,
>
> That is a lovely mess.
>
> Curiously I was not able to reproduce this on s390 with gcc 10.5.0.
> Perhaps I needed to try harder. Or perhaps the detection is specific to a
> very narrow set of GCC versions.

I was using my gcc binaries from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/10.5.0/
but more likely this is kernel configuration specific than the exact
toolchain version.

The warning clearly depends on the myri10ge_send_cmd() function getting
inlined into the caller, and inlining is highly configuration specific.

See https://pastebin.com/T23wHkCx for the .config I used to produce
this.

> Regardless I agree with your analysis, but I wonder if the following is
> also needed so that .data0, 1 and 2 are always initialised when used.

Right, I stopped adding initializations when all the warnings were
gone, so I missed the ones you found. ;-)

I've integrated your changes now, let me know if I should resend it
right away, or you want to play around with that .config some more
first and reproduce the warning.

      Arnd

