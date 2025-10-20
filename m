Return-Path: <netdev+bounces-230886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC248BF121B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E818966CC
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B12F83AA;
	Mon, 20 Oct 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ED+T8UAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4U+6ceh"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E5228CB8;
	Mon, 20 Oct 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962814; cv=none; b=e27V5x8jyvv718+GzsGGEZCrAOg5u/JlgNwGxFZnLnCQ67+JlwWbHlUkDc/pFFGckb5voEqSlAcu5lCSNy/B0g5sl3n93nvSvBl4rZTzdzLBF3oro0bYRLC8HzIRsj+F65isPNub2lFUNKrgAuBF9Za50xmWcRH/0ZFVhfYPx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962814; c=relaxed/simple;
	bh=0EcbDveXf0J+xVodzGLLy9+lLNXsm0t/s0zfqzuvq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwUdOcFCGLLXf/EL9SUHkQNpAMhibl9dKXpTqUv2Ddylw1BNgpwlyDa9NgPxUTVdntlScj2XBuvbllSBwsjhIIdNHzT0aWoz+CQC7yAD80WtpW35psjJFUT9TrqoUS4BI79QaehRRoIXoOCf8CZaIYwvx1SKooAXoZHBDLFxV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ED+T8UAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4U+6ceh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 99F201D000CA;
	Mon, 20 Oct 2025 08:20:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 20 Oct 2025 08:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760962808; x=
	1761049208; bh=PKh5Wl/ZPsV5XtmPQ2Ms9jV5CN2xEptRs8u2MKhw23w=; b=E
	D+T8UAUrWD/x+DVDvC7EPYajI2dDyiz8AkSko8OAln+UykMgPt5fuYLoDsSGJKnT
	+Ejh3hxbvRzhOKZQiAfyxUckcJf/no1mk0kLFS0fghox/T9Nz5un70SSftYmK5U1
	8kIFZSS/KpDjSYt68B8FQRfO7uTxLymuoV1LmFN+1cvwW2mqs0unYUOyCGqWroa6
	LBLJm7Jk6lKQ5xDG0iAbzwd/8e3e8ZMwKuYaY/4UHLusfYAT/9s7kdx3THQOtJHj
	mcxGR8PnnmqziDkjbAs1v7lKha1pUeV/55ex757mzEMrOkv6ObxPu95Fud6dPZwj
	fiZ2kwl2kbUK3lkJEbZGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760962808; x=1761049208; bh=PKh5Wl/ZPsV5XtmPQ2Ms9jV5CN2xEptRs8u
	2MKhw23w=; b=T4U+6cehyaccwKMCqqOUlBYyN8zJMWoETTrERIJ1CPSL8qRnEqb
	BETIBGkcpLZ8pCYF+ZX0C2ca1drFF8HO3qCEAJvmidUCc6+z444yBYYd8ziZuVFO
	cI7yDGQ9DY/apJn/sY1rsrWJkdYkIdJeVmQvgPik3b67JSRcbCglgD5vKJKne6of
	swmO/tAZQkDra9S22VvFRTPK1+cMNVsLZTv8X2KzOM8T2Vanrt4jTTM/Q3uVlEIq
	PA6eQt7O6YvP1Bga39H21dbskmQMA/7TJ5f1lFQCzVodYNHAix9qYctdFKown0D3
	iXzkkk3QNUxCuG4jtSMYmN2B4CTmL9QbTeA==
X-ME-Sender: <xms:9ij2aNwfEnVUSNuIL8lzOUEZdlbWFQfhx6f0e56gkcXCjAzR8KR7VQ>
    <xme:9ij2aHpNXM-VRKiqdQFq7H64cnFN0CJBX244RUE45bdIRGgpzsvTY3zNV-KuVrhEE
    RBqZDbcAFCC7uQqEwKzAbcr5Zk33MyxPiHIjSXxazLotPaXLLAFdw>
X-ME-Received: <xmr:9ij2aNc4Jx0PL3XpP5TWOiHDCznpPmZ6C8AGZDxVNRtm69SBzMZKh_V25glO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeifrghnghhlihgrnhhgjeegsehhuhgrfigvihdrtghomhdprhgtphhtthhopehshiii
    sghothdoleellegvsgdvfeegieejfhekfehflegsfhelsghfsehshiiikhgrlhhlvghrrd
    grphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepshihiihkrghllhgvrhdqsghu
    ghhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrd
    hklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhht
    sehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:9ij2aKqBX5ou8PP1r3YJsseRT_Ld4TIzT2jxg2Cpnis6sv2BKodRQQ>
    <xmx:9ij2aHn2CxLSybvvPZLEb7BKtP8VepZbo_-gF9HSz2Ed_Yk4Z8d6kw>
    <xmx:9ij2aLQav8c31lXf1exrMOs4-etGTUsPTatDDrecmTzptzPUnXxfdQ>
    <xmx:9ij2aNaGL9WWSgPgI7bCcV53D0Ot8ISBA-HDJPPovXDN7r3Nl2yi_Q>
    <xmx:-Cj2aI4Mcir2SaysmhdY1HLuneWvudHYWTNBtIRExGkKQekcNPkgBHDh>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 08:20:05 -0400 (EDT)
Date: Mon, 20 Oct 2025 14:20:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wang Liang <wangliang74@huawei.com>
Cc: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
Message-ID: <aPYo8wGLna44_57b@krikkit>
References: <20251020112553.2345296-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020112553.2345296-1-wangliang74@huawei.com>

2025-10-20, 19:25:53 +0800, Wang Liang wrote:
> #syz test

I've already sent
https://lore.kernel.org/all/15c383b3491b6ecedc98380e9db5b23f826a4857.1760610268.git.sd@queasysnail.net/
which should address this issue (and the other report in
xfrm6_tunnel_net_exit).

-- 
Sabrina

