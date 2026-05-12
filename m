Return-Path: <netdev+bounces-287198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEY4ElU1A2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD25220AA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35C623073D3F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF053A71A9;
	Tue, 12 May 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="k33owVT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOAt7p85"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2383A9857;
	Tue, 12 May 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595121; cv=none; b=RiMv76x39u0ujKk83KeddNNRyblb0AZfPZEclA5wGpSLTyjqAHpLififitCRDen2zstiwepEWB3wHL8kHO2pYeI5FWN2xZikZhlMl2EhFjlaK1PUpWvixnKsxcGdaqw+CxiU4vuYMiP0AOlyVq5gXuxRTv/HhwMEwZi86zwZjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595121; c=relaxed/simple;
	bh=NcC1MlJZrapUlD5Jotb30gxy9ENaimLWjJjlTIHnJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmFwE1T/ijLCvMUhkKUfFepz8Et1ltOo+CMQyePTIlYzr1PXmr1oMApnROZgVWnFXYOENX/lw1CAvj50lYL+xltMqc5rna/tcUXyUqCULYfv9AHBDKKW2lBQgz/GuD1/8XOxuZ6+7E/flltXnlTIKvAoaM5oKuBQtxJB4qnHhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=k33owVT5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOAt7p85; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A48FEC0148;
	Tue, 12 May 2026 10:11:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 12 May 2026 10:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778595118; x=
	1778681518; bh=8rIPU8AIBdJZgMFCffZ//wVFsddKbCYEFAnaAMXg0xQ=; b=k
	33owVT5ofFEroEoCWrF1DzTEE+n+C9S9gWzzDopudmYPkrXTGN6k3+piZJYDnpVg
	tDtv6S1ascwM3ERaLIgqBOrJTGydGzGXly05f/6RqpKhWwruRJ+maavZihUhOGGe
	vH6Kg2Qm2T/uXTdi+E3O/BD6ApKV/Z2cCJsotYtJ+DNv4TGkoas1mPmQiXFeyniX
	bwGfzWrOQSwd/mqhddb2rP2qld7CoZvMM/yeOWXJ87Ui73dnvxB326XOZ85/Zjts
	WFfig/5lTsZG9L9uBSB08vEYi9Fn1TOB6EukPM6ABQTd/OmPe9tcahr41pAZwlPw
	CAHsY84C31/uos8u63CaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778595118; x=1778681518; bh=8rIPU8AIBdJZgMFCffZ//wVFsddKbCYEFAn
	aAMXg0xQ=; b=IOAt7p85jqzIr+rk0kLkD+68gRoDtF8vDpRtZocj5TQOlal2Hhs
	/y7xlxLRbjp2l7HwzzRMHi2qrHp1Aq3VRu2yotqc7JZ1CPHBBPGXJYOO6Nq+7JyL
	WNjNQJxD9tNL/h2dZ27yuBlwMendtnjjpHvsFi1g8V3pKftV8CdpD9+YYUzeXJ/2
	WQuAnLQo95fJEsuL13H0hreBc6Sib1GACGXA6JJseeZcWOEI56VfXXl/eMCOGAoi
	bPolAPyfjMykLEXHUPNddNTWi5c4Lq2xzFHacq4IFrXkmaqSAYV2SSxInqvU25QB
	3rDuF7t3rJ/QpVU60aS+2zi8himy265gr3w==
X-ME-Sender: <xms:LjUDaiEply8olF59m08JvrboGRI93XqQ8XhU4XFS2G_FN11kkOCSJg>
    <xme:LjUDaoTeSKgTc4xg51zHtZ_ut3qN_7mZOk51ab4iyl4vADyS0HyR-3I8krfwxbdzK
    r_sJ8rlJXTlSdQvjQAL6XOouO0kvJCo1wAO8Mkq11-rO4k7DuueuSEQ>
X-ME-Received: <xmr:LjUDagaGITrKkczGpMrgYy8M-j9TBSgwk-5rESjnfT4E1xD-i7Yd2sMJch-O2Jsp5_8qytmAFe7FVR2YeqSh968>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepuggvvhhnvgigvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghv
    sehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LjUDar0q2bEDRb4D8GFDfiTfXvl7WycBJnyvk0FDbEUA6qTdzlVfEQ>
    <xmx:LjUDarr8H-utst0MZqtGXW0jRt1Vb7nSvlth7F_r7TrzdF_zFknyjw>
    <xmx:LjUDaiOe8ZjRMMEqBzfNqB69S5vR-KCtM1OWIw1PCflGA7xElZRz-w>
    <xmx:LjUDasr_3cjy0E_1EG0JozQ9aeubeZzQnfPBtDZO6mf6vzNIroKEmA>
    <xmx:LjUDatUYB_mDwmABZ3hjGaAA33y8k4Oo188c-CyN_9IW4O2M-hyfpWaR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 10:11:57 -0400 (EDT)
Date: Tue, 12 May 2026 16:11:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: David CARLIER <devnexen@gmail.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in
 ovpn_tcp_close()
Message-ID: <agM1LMZ30jZDRqZ3@krikkit>
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
 <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
 <4ff6590a-6695-4c6c-b677-a7891b249165@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ff6590a-6695-4c6c-b677-a7891b249165@openvpn.net>
X-Rspamd-Queue-Id: 7CDD25220AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-05-12, 15:55:39 +0200, Antonio Quartulli wrote:
> Hi,
> 
> On 12/05/2026 06:56, David CARLIER wrote:
> >    Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
> >    ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
> >    - happy to roll those into v2 as well, or punt to a follow-up,
> >    whichever you'd prefer.
> 
> @Eric, if you have no objection, I'd pick this patch up in my tree and let
> David follow with a new patch for net-next.

But this patch is not fixing any problem either, right? Then just wait
until David sends the whole change at once?

And since the "rcu_dereference_sk_user_data + !sock || !sock->peer ||
!ovpn_peer_hold(sock->peer)" pattern is used multiple times, it would
be better to turn it into a helper (ovpn_tcp_get_peer()?). That way
the caller can't be tempted to play with sock->peer.

(also, please wait at least the usual 24 hours before applying)

-- 
Sabrina

