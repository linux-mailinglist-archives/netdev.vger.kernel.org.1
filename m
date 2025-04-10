Return-Path: <netdev+bounces-181236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B7A8425A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685DB19E117A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC8281509;
	Thu, 10 Apr 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dfg+YRcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8Zp9VEO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE3204F80;
	Thu, 10 Apr 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286517; cv=none; b=RslGfJIw8MKCbfS/NWNY1BCIdIlVHqgu6l6pRDCzHSq01wc0jAb4FOyjmxm7IqPwgG7r0/nI6A+Y21WqhgcvvCf2/sTWYmP22XXj8+sQRzYNtRilQzsMsqesfyR7K/8VkVmp5Q5ulS0KtdEvsxEwVs34qQk0hane+arbY0kh/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286517; c=relaxed/simple;
	bh=gl9oaGaRIsYt/WyBdN7UO9fsD1iIFpw+hRE7Ip3gDTM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lC32WcmvF6gnoFOm6SyYpfmdJG+efXWksk34eNmb2SqsZzcUZ3AxCWv287z10elZokkeR3nSgjgOdwvdFPO9IRt/Ymq49JYvjxggbu37WeQJT7oiPZNMUZhX1kbHKPvFcyjgYzAw0y2DNA+sAHMjLojTHz6IhD1olHsdkhL1yOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dfg+YRcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r8Zp9VEO; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8903511400E8;
	Thu, 10 Apr 2025 08:01:53 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 08:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744286513;
	 x=1744372913; bh=gl9oaGaRIsYt/WyBdN7UO9fsD1iIFpw+hRE7Ip3gDTM=; b=
	dfg+YRcn27ujd2Kv89PNH28iSsx/7J18F2jg5wmmBRf8pCwvQaPjV1o7P8x/kROs
	vvkaEZGKh4Yqj/RLXvclFPtu4fPBMK93Enw9GPRzzd22JO5qVvYm0yiIY2OM+VUY
	LDtnq75Oz7w9eYYD91Bign6GT4zSA/4zm6MROyaMlWAFiKWre29U84VLxU2FSPkE
	NT8uPtszkU/yY7WEuAAw1X0JSKFJVmEtqK9qOtv7PpM0LtNOCaMPhVbAQg2Wt2kj
	ehPfW65hcdqzweofIQJwcG/YCyhN2fBlCluT87167OUV386sVeQu/JcMKerWhegc
	iyUPtZcAywhDc6RVXB7nUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744286513; x=
	1744372913; bh=gl9oaGaRIsYt/WyBdN7UO9fsD1iIFpw+hRE7Ip3gDTM=; b=r
	8Zp9VEODKfutsmRAEbgUnrmBP3s0vdxVjQ8hpakmL3zjajt6qqTpVw916454vjfD
	MYCRUzOEQP66c9+jX4v3aRjSpzYdR3Pn2o6ABlec/Jb5b5J0FuSN3zDzgEJncxJG
	mr3wzL6l/A6SV4p+IF4pP1V3cyE2ZJRzIm2kkXP9GowfJB2Gkb15nmC3EMZTHmhu
	EvaIZiuyGZoiFUksZ6ewc3NIgmf17tWIdAfOXtj2hf/Yh/2erVvJqYsgVmYyw70p
	WL9b1Dpt3dH/1I6j59XUt7MntbL0AAiWiX/QrDcuw9gI8Sh+Gq2BMb8rn81QmirA
	MEVWkzxStZrSeZgYJBRtA==
X-ME-Sender: <xms:MLP3Z3ZzkHrptGtQOUk4WRvDyC57tPhsZw9eTxDP4-DVo3giJ-5fBg>
    <xme:MLP3Z2ZJ-wOZhDIeQ-61FKaOu6linY8MUS3ia6cJ4zjA8_UAANbvmqWCqELvg8xO-
    G4GclEPSZT2KHJX96Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinh
    hugidrohhrghdruhhkpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordgu
    vghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepughqfhgvgihtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthht
    hhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrggu
    rdhorhhg
X-ME-Proxy: <xmx:MLP3Z588WIt1trNXStRldSHp7GGw67WcEJeidMURVp7sO9bDhwqc0Q>
    <xmx:MLP3Z9oVgKRh86jQsy2Z2YvyqQrLhGfsSpuomX5U0Ip0M10L_vEhqg>
    <xmx:MLP3ZyruZoteQa0f9aj6BpwIy6D1WAEC9Mg7V3M4simfzGzh1FZ-wA>
    <xmx:MLP3ZzTAa1BWV4e7XYPfF-qLN-dK0NxTmJItaIgjsgO8qeTPamDZjw>
    <xmx:MbP3Z_j0t2xgFRutTCp2TfvmslhP_6FnsCjYr9_pkLwdxVg5p1L3TQFr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2B1352220073; Thu, 10 Apr 2025 08:01:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2340d8c52bdbc82d
Date: Thu, 10 Apr 2025 14:01:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Daniel Golle" <daniel@makrotopia.org>,
 "Qingfang Deng" <dqfext@gmail.com>,
 "SkyLake Huang" <SkyLake.Huang@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Simon Horman" <horms@kernel.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Message-Id: <0b5c6443-f50f-47a1-b5f5-900d70b69e06@app.fastmail.com>
In-Reply-To: <67f7a119.050a0220.b15d0.3df3@mx.google.com>
References: <20250410100410.348-1-ansuelsmth@gmail.com>
 <c108aee9-f668-4cd7-b276-d5e0a266eaa4@app.fastmail.com>
 <67f7a015.df0a0220.287b40.53b2@mx.google.com>
 <67f7a119.050a0220.b15d0.3df3@mx.google.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: mediatek: permit to compile test GE SOC
 PHY driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 10, 2025, at 12:44, Christian Marangi wrote:
> On Thu, Apr 10, 2025 at 12:40:15PM +0200, Christian Marangi wrote:
>
> Also 99% I could be wrong but from what I can see in NVMEM kconfig,
> NVMEM is not tristate but only bool? So NVMEM=m is not a thing?

Ah, I missed that. In this case your patches are both fine.

Acked-by: Arnd Bergmann <arnd@arndb.de>

