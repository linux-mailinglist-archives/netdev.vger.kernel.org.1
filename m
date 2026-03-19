Return-Path: <netdev+bounces-269576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLujI0czvGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:32:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AD2D00E0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B17FA309E0E1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FD165F16;
	Thu, 19 Mar 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HUFNqS3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl/6x2Y4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CE3DBD42
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940872; cv=none; b=MGnWUYXObJuNq7WNdud/YvJm+cTDu2eq/ue5aT0nX5nICAlOz9yPiJ6v1PNp1OUHTiiUJr/dun+PW8b4bRqXNXROdfQgCQgMAODfLTHxNCzGXBmQxWnmXMP7EBjFvSClMdTMA5CACurfACm0WrPlNrSjpxmWjvpyWXIVkjLl/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940872; c=relaxed/simple;
	bh=QlOhEG5OQDBGTfbPzjW/FPCZGRkL42lTVctz4bOYBx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVPPbl9mb8erMirLqhsRxYzZufMhzSTkhRf4l3FFaUOYZExSvNtBsS49MMElGkyiLkVzfw1IHKLc8cuBAjg7yeCMb1U+lUY8vcpKiKhds6+Cu34wqlxIVl6D2kK2bIXL9N6/RO3rMCtpuGSo7M7LJYggw9Bu0BLDnKsh0Z2M4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HUFNqS3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl/6x2Y4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 870CF1400082;
	Thu, 19 Mar 2026 13:21:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 13:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773940866; x=
	1774027266; bh=Kh7R68WmI/Muoq4kcOGMyf58Gpczi3668k+J0T0xvqs=; b=H
	UFNqS3+TQnjYkn81BHfsWcA2gq/LyqKYodZ1aC5/Y1QiGR+tK3QovsbpRTSwFiUU
	dBUGWMggUSlUafXIN4gTxlAPovM+AgC9N5CcVGcK1ucq1Iv46TCF448CoBZcX06p
	5q9DLVisbepubmIAs3pMze9BJCEUMEqM/MqY8MT475OgmzCqUHUhlFQ8vyTRHArh
	uHtw9IOan6e1BN30tM4j3jCWXrpRB+fSbz41ash4DktbPV7aQQpr5u8bB+70lICf
	RqLRvGh6FKuBwOU2IAEtM9ay6XEY6DFWr62uqODLAUTZ0L4e/uJJAVGVRE9zLUs1
	gC/QsygW5aib+bHFUEcZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773940866; x=1774027266; bh=Kh7R68WmI/Muoq4kcOGMyf58Gpczi3668k+
	J0T0xvqs=; b=kl/6x2Y4PWoGM7dFApi4Q+haz8zPwi3eq6krq2dUIfjtQip5fvh
	ZjIDKBFyifrCx5z6SueHusz0BjTSpDBgTghz26rrSfLMByt0o0Uu9ESgUEx3E+QX
	nvxllAd6bxwgBXgE4jqS6JDrJMD87LLpuT0GpBgDdJG+AbrxNphrvYPTK+Rtvkzb
	sojFGvfOwMA8BNbLovEpcWfkbi6rFR/OK1EF7WgIgbvR98iCZGVLcj0ADqurug3b
	Bm8iqwJ5aqacXxcd0OZ4Q29h3GGGZ3AD1UR1/8hWwnwuwx+xtL4xNbEO0pI24W5I
	yeLGVcw2IuzjRj/FHu2Agre7dEtIpeMT9Rg==
X-ME-Sender: <xms:gjC8aZsiajb0-IooUSDKIFjSeSN_afZRf04boo_SENlqAiuqQ2pdtQ>
    <xme:gjC8accbFUzkTyC3nMVNcC2iAz9Gfw-gvW4c5BMklWjOKNndPgwej3X0M1Trcbwcp
    oFInS5mBK0JJdIJN7GnX_0YtnAuGs2zqFyw3v97JlG01e9SSg1pGTI>
X-ME-Received: <xmr:gjC8aTYspLFrqMtkC_HzwVxIJ0pEK1z3httHioq0xB0SOkdML4WyF8x2d_ir>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
    pdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhm
X-ME-Proxy: <xmx:gjC8aeZUH5kgnCkQQv77ig4pmI4NV0MINJ9Y1eiLxe9C7jb5FVVZUw>
    <xmx:gjC8aYIaaZMlLkBSgr64YMf5M77r8L3SgAqt1znp5AG4dTrGn0mdvA>
    <xmx:gjC8aav1HJA0f9AwULx_WhMxz3s6W3wOQdaUHfc2zs_HGH5WQKScAA>
    <xmx:gjC8acUQzquTUJ5fX3iNROuJKIrfwUJuOPaGWE61h0LVFRCE1pZRIg>
    <xmx:gjC8afcrMLCo3zYdiwusi1Ry4_HlAs7wWRMhuagQZsvn8F4InLHfFHVk>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:21:05 -0400 (EDT)
Date: Thu, 19 Mar 2026 18:21:03 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH PATCH net-next v4 1/8] tls: Factor
 tls_decrypt_async_drain() from recvmsg
Message-ID: <abwwf79GJ69X1Wim@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 890AD2D00E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-17, 11:04:14 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The recvmsg path pairs tls_decrypt_async_wait() with
> __skb_queue_purge(&ctx->async_hold). Bundling the two into
> tls_decrypt_async_drain() gives later patches a single call
> for async teardown.
> 
> The purge is kept separate from tls_decrypt_async_wait()
> because other callers (the -EBUSY fallback in
> tls_do_decryption and the tls_strp_msg_hold error path)
> need to synchronize without discarding held skbs that
> are still awaiting delivery.

Sorry, but why do we need to keep the encrypted skbs around in the
async_hold queue once async decryption has completed? I guess I'm
missing something.

-- 
Sabrina

