Return-Path: <netdev+bounces-219851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB712B437AB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C033A854E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC422D3731;
	Thu,  4 Sep 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lXUfOehW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jj4OQoB6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C07081F;
	Thu,  4 Sep 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979650; cv=none; b=dn63/jf5WnR/rOFsmj+BFGCnfet9wFKNRvLPHz/bC//wg5iZAmjG0J2zhymbWU1I4k1jndvD77M3gI8xY9L29qPRgyMYXiyfigFsTYz8JUc3NNM2VVuCqgXlwv9r0MpEaa59g3JEKrTl57nxYoUOQgqfCqOz4ivhloCjlo3m9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979650; c=relaxed/simple;
	bh=VbZVS5Dg4DDI6OYnVGP2ic6emtQx1a8qK46eYzbd1iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eogfm/vxw5Oc/eAjARZ8QZuIVDHWSwSYd1BIOkXWRYqegKHGFI7g07zcCOot3cafogdfYTFEwBnbVFouCcNuJO/hTim9xKQrMFmkVmmdCrdHeB3T8tyDcwBNSkya5ZuR+c8A8BzwbGgpNLY7B0r78E6JvdWxeDy+RwDdufNyGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lXUfOehW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jj4OQoB6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BE8A14001F0;
	Thu,  4 Sep 2025 05:54:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Sep 2025 05:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756979646; x=
	1757066046; bh=b47tdDARfEiTwuQ3hf+5RWFsfXNqTxNJTg2FAkCOtvk=; b=l
	XUfOehWOft9uDlScA3+oh0pL26WPX5Q2FGllngz2njoiaqnsbcvC14/A18DsEl8E
	1yrWufLLCBt+pcGEyJFVvOg5/5FT/SJlyiGSWcZYAylC9Wp1m1KioJ6CRRUtLfT7
	R4e/PT9IqniHuGizCRmgnqApuonHulvUY0qFfZn+zE2iJ5b6re+DWi6JzW4Ngrwk
	ogb1IbqJXnQJgDk7Pt2ipIaXMpsdacHEo4uYIarAUdvfeW42E8ylaFdutFoc4aNw
	kFHimInBzwn1UYMK//vwE+8Ou4pxhYtMZ6MN/hLoayp5DOKSUziQagF0Jg6Bq1Zk
	4Obr9v9ZX0mi8o4+hmCmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756979646; x=1757066046; bh=b47tdDARfEiTwuQ3hf+5RWFsfXNqTxNJTg2
	FAkCOtvk=; b=jj4OQoB67s5a0bCCfu+VoDdUJuiC152+JdZMAMd3kAKRWu/rX5b
	7MF6gVt5QZ0iI9s2dc5ceZHL1nmTGCfQJZ3Aa9XQ9WfrXifvikE6Pb3J8cHJM59G
	BEhscZC4CEnZJZYlAhKXxCia53lp9XzzYCHytMp9BTbZzJA/3SuqePnLfCTJ+4aH
	UUt5HeOZwpwVOHz25MK76tR5gakx0gvFWEgW7FpLBC+hijgf0TbtPcKLclWSzUIP
	1DbtMTDl1vzVgJtOxj/RTw8aT+WWVJFkP0zUIp9pO6XMwj7MflmNQWes2UnedVvH
	APmzLBnEOBXyADE7SgCOTcv8Stok0f7LLwg==
X-ME-Sender: <xms:vWG5aAyVPmhngvGNzdyC8wEoEazSYva0DXr9P10c8GGB97GRXyKeBw>
    <xme:vWG5aI3RGU7E7Kp5Cmd5qU28FVfn4QsZHbCR0l64BTtV1WwI8Fvo0GWyj6fVfcSSE
    v8aG150n73gnS5sUZs>
X-ME-Received: <xmr:vWG5aPdmHyjpcd9Mmlxe4rVvAVXhoaGiGBWHB3ZnuxiSkZ0_jUvdbg0S24Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgr
    sggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vWG5aFVSUKzu3lL76TbjuZE4561OxO7Nr_z2JE16FKRXL0air6IbdQ>
    <xmx:vWG5aP-AvKsk6f3YZ9FQ6xYnivFmNEdPdBdGChT2k-XkQWWTp6F9jg>
    <xmx:vWG5aHimAjWLAHuG_oRjyRIGoLxipxgHz6o1imOQ5bHAeRWpbqaZVQ>
    <xmx:vWG5aDfVt5U1wSRK5VZXN4hPPcMl3OyPYw7_VtNGq9q9fYkObvkwYg>
    <xmx:vmG5aPOdtRs-jLpk28JFvnYPyUbEFo1zDO8w3DdEbYbqH5QFAQscnKS1>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 05:54:05 -0400 (EDT)
Date: Thu, 4 Sep 2025 11:54:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	john.fastabend@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com, dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Message-ID: <aLlhuyBQ8C610qv-@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
 <aLgVCGbq0b6PJXbY@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLgVCGbq0b6PJXbY@krikkit>

2025-09-03, 12:14:32 +0200, Sabrina Dubroca wrote:
> 2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> Pushing out the pending "too big" record at the time we set
> tx_record_size_limit would likely make the peer close the connection
> (because it's already told us to limit our TX size), so I guess we'd
> have to split the pending record into tx_record_size_limit chunks
> before we start processing the new message (either directly at
> setsockopt(TLS_INFO_TX_RECORD_SIZE_LIM) time, or the next send/etc
> call). The final push during socket closing, and maybe some more
> codepaths that deal with ctx->open_rec, would also have to do that.
> 
> I think additional selftests for
>     send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, send
> and
>     send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, close
> verifying the received record sizes would make sense, since it's a bit
> tricky to get that right.

Hmm, after thinking about this a bit more, maybe we don't need to
care? There could be more records larger than the new limit already
pushed out to TCP but not received by the peer, and we can't do
anything about those.

I suspect it's not a problem in practice because of what the TLS
exchange between the peers setting up this extension looks like? (ie,
there should never be an open record at this stage - unless userspace
delays doing this setsockopt after getting the message from the peer,
but then maybe we can call that a buggy userspace)

-- 
Sabrina

