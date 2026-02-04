Return-Path: <netdev+bounces-256884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPBpJnvZg2nGuwMAu9opvQ
	(envelope-from <netdev+bounces-256884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:42:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149BED564
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCE8D3013892
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD53A0B15;
	Wed,  4 Feb 2026 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="N0gkAz4J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnWDlKGK"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B539A819
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770248566; cv=none; b=nJr/lixjqdCVv1R2xKeyu19tJ/xcgUq2eOFQGLsCi3NRN6yP6jzRT9iMPv7Apau0FHIDBgeaWjPMsDrbmTx+vMUTSlLJuo+4KocVK/g+0lOuzWy/p3owefVEPOZWC4lScF+r0ZrROy7P6RG/n2OWxL5Lw/92Dqm/Y5pLnx7N+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770248566; c=relaxed/simple;
	bh=TxjxcN8JBl22FArzEpgRibOmZ8734YZVRL+t6/CzSL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5xhWM3I9WeZHqjngWBZYZ16zxBEood45c53A7LI/6taPrgjG9IV3Di3DSufieHU/UhnhspUYYaS1FOS0ygW7ot10Tnr6xI9o9aXMjUJZoltCNhEqWn/PVAy1o9XZAkWn8ryuIqVoIq8eEbwlAFDVSWCNhg4B/UXxf+2Awj5GU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=N0gkAz4J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnWDlKGK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB4A57A0066;
	Wed,  4 Feb 2026 18:42:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 04 Feb 2026 18:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1770248563; x=
	1770334963; bh=rHd3aM+kE+4T7O1GEe9xwF4lr4rE9FUBgAx/wfHTljA=; b=N
	0gkAz4JmUxHK35g5emK59Dk6cijVbxeQZ1v+wW60PN0DTpo8Lt9fsd2ERqqo5AT1
	hWgZxkRJxN4mnQprNT669M06NWnTUSywiQRuu2q1a4/by25mhtpbAEZz5H7pPPyG
	3f3Y3NpnvS6JonN/Dcq8S+gms0DzmWINSK25/kIUG5ycD5r+AqDjdYW4ccUK3zO4
	NylARjZhO3pGKLVrAniqCa0+tIg+cg0cHjo+PLED/Oy0xIgrt27XiFZvICyNPzRl
	ZZ9YrBT3HjHJlJu7wRYMCxg5JWgGKkAr62Y5UaYlwXs/z4KrRT1xuB+2dLujiZUw
	/eFrcPtL2YnDVhNpiGQsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770248563; x=1770334963; bh=rHd3aM+kE+4T7O1GEe9xwF4lr4rE9FUBgAx
	/wfHTljA=; b=fnWDlKGKY8c0JmNP6OhwDG6WG1n7QOpvlbrfjwJOTmcXejVL7zg
	iSVeE1W+xlG/q8w5Spmh4rwTkaP4eaCbrJlvn/uJ6SQj6k3s3wE1rvPQpYk6daEt
	A8PTqmeSD4dBZrtVWZyKwshEEsTCDWxqZMPVxA6QENCOzaKBZBo0ZyYHm6JqI/Yy
	xnEGur3f3ZuxWjFxtOHw1RZAWoTr5nskYtpejBCtWxKOk15G3GLS9AfPMrFUXMcc
	mfOjQUCHXRTbJXHcGxTmwczQV0Ak+ueySAaQ0hHZ2O6lt5xfaPd/V7ahWjnxdNDu
	lHDIE6muF5oT5APrrUvfGIvmj/SDuqwSxpg==
X-ME-Sender: <xms:c9mDaTqEM3y8vTB91MABs9Ofv8a5zQUkHZZaswY9Au-pGtz5GrzUnw>
    <xme:c9mDaZfTZBnrM_PNSHTF4PhxXdYCOkOdWwQ-SA3LDDzV1VSSeynTJvCCCLIfz00BI
    JNycrFyh48T0OR8jNeODu81kVMAauRAOQopKyWzSazL2p1Y6GzfGQE>
X-ME-Received: <xmr:c9mDabn6jC_bjt2PB8DSwYjRDqW6t_Z8fPhf8l0x4Vpfxh2lmCrsLnn_dDcZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepjeekleevleekfefgueehveejueekvdehvdeugedvkeelgefhleegieev
    ffdtuedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhope
    htrghrihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:c9mDaQY0g6vNNTrl7gi4tFR5S9J04CXnBe70tEWRwdVGj35e872Ryw>
    <xmx:c9mDaQ4hrVcY3yPeH9mMlmt--5c5IUWHIyB5o4Cjdu8k9gOjuIrhwg>
    <xmx:c9mDaaB4UKgiRAzOB7ySAjLIeIKWPyb9ZD4y1BIoyRRrueC9D8EMtQ>
    <xmx:c9mDae8pvLNVBFziGt2DYOLkxUfnxaiIs18Tx2S6OunXGuUs6Gg5vg>
    <xmx:c9mDaZcwtr_LMF1uxe_x1Tf16tG2I14atBwghYct0sHGH1VLcStfkrd->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 18:42:42 -0500 (EST)
Date: Thu, 5 Feb 2026 00:42:41 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	leon@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH v6 0/4] tls: Add TLS 1.3 hardware offload support
Message-ID: <aYPZcTAaRiLaCLQN@krikkit>
References: <20260203184835.3619101-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203184835.3619101-1-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,purestorage.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0149BED564
X-Rspamd-Action: no action

2026-02-03, 11:48:31 -0700, Rishikesh Jethwani wrote:
> Hi all,
> 
> This patch series adds TLS 1.3 support to the kernel TLS hardware offload
> infrastructure, enabling hardware acceleration for TLS 1.3 connections
> including KeyUpdate (rekey) support. It also adds a selftest for
> validating hardware offload functionality.

@Maintainers Sorry, I haven't been able to look at this in detail yet,
could I get some more time?

-- 
Sabrina

