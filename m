Return-Path: <netdev+bounces-274118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENKGGTQkzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917E37BAD3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B83530DB58C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE643CEDD;
	Wed,  1 Apr 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="U2GbOT+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZ738efc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47C42882D
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050784; cv=none; b=hTGkZPfsjoO/uU+kRhdRrVB67LhTlQsNy2A5A5iS96YJaEDrrYap0+P3qQsaMPFl3Z7zMJsopS9xXPh2wEiJB323HbVqWvJPkHuH4rCbdwLFPANzs1E7Az1iAhDWUYZrE3nWO7xJ20ADpAukZsYs0PLrYuNikHS3d/Hs7Wa1804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050784; c=relaxed/simple;
	bh=9ezkFMua5fvQjGpFB38HLgmY5ysfHBahR/kae6T3Loc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qehm+fOf44uRAoBaeXix9DrlWzpQtvxTSpRdu4bsl5z2KuncIj0ezL8ZTwKqbWlJHbiK9TqKD9TLRMK205EDTa6xDv0WwxsePJQAxI1HFc2bgldJZdoQpbvwQh2RB0ghsIxsNAd7XIB9SkRIuMFURCHKj31A0diP1UgkLaoLmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=U2GbOT+2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZ738efc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19C007A02EB;
	Wed,  1 Apr 2026 09:39:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 09:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775050780;
	 x=1775137180; bh=vdubklz07CuK7Pxaz+Un37LR4jBXZPeNSfPS4gwXkmg=; b=
	U2GbOT+2t2zI2SvncvhQSkWhifQisKu2HoTIRhHQrS3N7fIwTxceXtiygY1hgHKc
	8VtMS2rIZYTyhk8pF3ArtstfLaYcPOucthHjJXa8XN7YUjdkpU3H5pAETwqwFvmC
	4Ii0B7FR98XnnwuA+5t+1ps02tQ4h7o91tDLOoO+0+R7XTUiolQ7ADIl4wFmRQPG
	KQ9Z6n1+rgPcjW7SYV1Z2fXxX1UUVDpH4Cjr3XjXkjrrms41nLDFg5AWBPkdndnG
	z0qZTQxbrrnkyfSsMkyVM3ka1Ju1PKNaS6R/L/HVIW7W9xjXQxkJbDqM/L3YloWq
	m3nfqffv/Ywnved7tluXjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775050780; x=
	1775137180; bh=vdubklz07CuK7Pxaz+Un37LR4jBXZPeNSfPS4gwXkmg=; b=E
	Z738efckjGTv+qakK1+xplazJTyKl+kCr1wk/9YsPWRVOo3+VPSNuVXfbCTTu4Y2
	pL2xraGQkkvKZR/fO87KvU+DP19n7/TrS4GLfT5SG9acjflR7vvMxOO3kKBNuOPe
	wQ4M/B3IMUtQqeSWryU6WaPXB/7/i8/u4ERcGT0y2rrqzITcZLUnQPtZinbHT9X6
	OYNRD4ZJlxnyIbw9meCL8tK2/bBast9toNn850sCwuDsUBLwiE+j4ZoFy00ShOhX
	g8WxTs4YX8hAk5DMHefjb+9+AzpDlb9c9oIKoEW9XFaC2hapH9jSG0CvEOyYjlML
	ML70Rp4FV44pk5Oqv/5QA==
X-ME-Sender: <xms:HCDNafcRt-JWIeIu-M6K9ORbKIykiwz_ZP7FpcEo4XqtyrGeD9-Wzw>
    <xme:HCDNaej_t6c-CRwqAtgM4FGmptutOch0E9yxbpNUCUJrMdTMeacbuf5IGVxxapec3
    ovbioHskavE3OOZhyZGtFfj4Fj7iTIUT6S3P8wTWxrPJ-SQ>
X-ME-Received: <xmr:HCDNafw0mDkfKRldbAlTDPz1m9xdufHplC0oNeW3cAiPYFc9nzLKQBHTqAYAk10CibZ86GWrHHhc6srGqyfKE3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttd
    dtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepgfekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiud
    eltdefffefvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopeihihhmihhnghhqihgrnhehledusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshgvtghurhhithihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HCDNaSMW6TQroxanJygBAK_KtC8Ziyl2_LmbbSEBQqA_hqJMp94dNQ>
    <xmx:HCDNaYVVbsHADxWI1-scNrLNl0DgwwZcGdwk_KqqjzHbUF4i_VFeIQ>
    <xmx:HCDNae3rOaiXNbs1tjVm0o_JBEq8hNUietGP_4ZbW3yCamO1zGnoAQ>
    <xmx:HCDNaeo9YJor5xEcB3qtPW7AMv0L_hMMCONN9Lzh4CWcYj-Fo2Mvnw>
    <xmx:HCDNaeVf00OpwIfiJHekc__2sLnLGDGmoi48POntUj4s01zaAwDHVeTO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 09:39:40 -0400 (EDT)
Date: Wed, 1 Apr 2026 15:39:38 +0200
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org
Subject: Re: [SECURITY] ipv6: opt_flen wrap via repeated IPV6_DSTOPTS cmsgs
 triggers skb_under_panic (local DoS)
Message-ID: <2026040101-schilling-serpent-09cb@gregkh>
References: <CAL_bE8+MpRX-B4wn_-9kqMDQXJDxV2GgTJi_X+WA9GoaoV_gMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_bE8+MpRX-B4wn_-9kqMDQXJDxV2GgTJi_X+WA9GoaoV_gMA@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274118-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6917E37BAD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 08:56:22PM +0800, 钱一铭 wrote:
> Hi,
> 
> I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
> ancillary-data path that can panic the kernel via `skb_under_panic()`
> (local DoS).

As you've sent this to netdev, which is public, no need for security@k.o
to get involved here.

Also, as you have a reproducer, can you make a patch to fix this so you
get full credit for the fix?

thanks,

greg k-h

