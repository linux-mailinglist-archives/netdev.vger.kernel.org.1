Return-Path: <netdev+bounces-277426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBy1EUf72Gk5kggAu9opvQ
	(envelope-from <netdev+bounces-277426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9468F3D81F9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECD5302BB94
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9592B398914;
	Fri, 10 Apr 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CDvPQcC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n0BsgU5B"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9C3A63FB
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827538; cv=none; b=SoBPOOjwIrquPLqxi1tNAzp8aOwwvGEJFV6awa9vsy/xWrMx70LbzCoMwSldLjQ4IDQhufDourEzgynDdTaFwDiXbCNy6dEBTGi8jRw7HatG00C4Cd9/9NkOSvD6YBuPUgxebUtE3B4MVNVCRe4AasEbkdd3tEcZtbSrhonFpKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827538; c=relaxed/simple;
	bh=CTcfoymNaxzlrXeM+5SZPO8JhTqk1n2JG4U1xY5q7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9zaYllVs3lrr+laJr/qbPIEvCGq1rhen03KYmi0rg9F7kczQpCeLNiqEgCdXNFAwWsmvrdiiq//QfGyrW2e2bNwAZWkDgWMCKnUU1EoCc6fN43zRDUG8BSHgCu8gTVwy8KBHUl3CA7YeHiA6yZeUOPLf/9Z6U0SfG1vMqTZs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CDvPQcC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n0BsgU5B; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 99AA0EC03F7;
	Fri, 10 Apr 2026 09:25:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 10 Apr 2026 09:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1775827534; x=1775913934; bh=aFkmreeq3/dfbEM6YafxOOhalQEvs8cI
	ZWWAaR+OyO8=; b=CDvPQcC0EYd8Mfq+IDwtxWV09TCn3p4JlOX4//LM+jtDme03
	e8AOurdl1sZy4fgK6b9NU2JWgcgaF808ylrcZbal5H/7rTyJ0hC9nEFDgFnB4C3Z
	BUNTMlCBP9pWxUwj1sxDPFd3TGlkmm8omoVoe1SZrzPuhc1WQH1az57RLkmrZBPP
	fXFQ8pCio3C41CXGReUWxX0M0IbxQnxAxUgr9l5DXZABgd5vMv7ZQHVSHv1xbn5W
	2tGFU/k2V1GDXiEJzdCCoVYu1rOb4VT6xKZCMxBXTnjgNrnOK7rQNCH31JdLNXlD
	4u1xCaTUvRH7RAa3wW8PYv2QJiAUdm8Jqm8ETw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775827534; x=
	1775913934; bh=aFkmreeq3/dfbEM6YafxOOhalQEvs8cIZWWAaR+OyO8=; b=n
	0BsgU5BTFu5QzznyQp42kHGxxv6xJA50HtIpHppXeBwhGmo5Rlk8jhNEPOC0s0gB
	3YEHvYdon5RaT6nD3MR5QbhgI92b4c+yPiJKNsjvNS3Ot+m7gRQbkTCLXPVptM88
	kLRcxMfM9Y/D5WX+rJk7C5K3QRDVr6A9nocURoF6EvRdCeRzjmQQ+0T9bj547wYJ
	UX1RAxloKYSWpnVX367bA0CAl8EUDoxOg5fJ6q0NC1uVcwaYKStevR5wybsyX3WL
	sQPA0XSO7f0hIfDckM9u1xyos/EiJvBshp9Y3riL5FQaAHdMIeRrJPN1cmSUGTtP
	iLf9zizvTodhdpO4xPYgg==
X-ME-Sender: <xms:TvrYaWLYNP14dvmV8Tawdso1JdZI_AzTwKHWakRsA1ryEdTPGIFlFA>
    <xme:TvrYaZ-YcX385SqaHZwoq_THvPiTjPNb_-aEw4VS-UoN6xNAsuIi9bvfJxpN9-ooD
    TWji1hc-LQbqZTxYXEMdLjR6iUX7NgJLs5jAdRnnreMtbVbRAP9x5w>
X-ME-Received: <xmr:TvrYaSEPYtVwcMEAasM0AuD15AEnAJTiiqya9iA6qvMG3zhTp7gAQLkdzNz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesphhurhgvshhtoh
    hrrghgvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:TvrYaU5UcrfSqGRFf8Ddw1IZe1vUdcy_mHRJ2rnmEXYZTi26nw5KhQ>
    <xmx:TvrYabaP3nWKevnVQD4GN-WYHf84pmZ7clvaMWDIGO332LZnXMWW6g>
    <xmx:TvrYaSiGp5_odMgjIh8KlC36pTmkP7qkqaNbA3kQ1l4cccGwZCz_dg>
    <xmx:TvrYadccVaMsXXgV01bC2-Ok4m4wagzVSVxFgiV1LCrHdffmNGTunA>
    <xmx:TvrYab__gMFOVa308DIDj6y04KdHNZObxzR0e2qW_KBxpgDvTgugaEpM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 09:25:33 -0400 (EDT)
Date: Fri, 10 Apr 2026 15:25:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v12 5/6] tls: add hardware offload key update support
Message-ID: <adj6SUiUDN38Hdv-@krikkit>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
 <20260402235511.664801-6-rjethwani@purestorage.com>
 <adQeoGH8qmhhCSal@krikkit>
 <CAKaoeS3pNe-DH2vA1E7t9NOn3H_ZUGk+cM0LgoYogkWEU0aqLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKaoeS3pNe-DH2vA1E7t9NOn3H_ZUGk+cM0LgoYogkWEU0aqLQ@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9468F3D81F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-09, 10:46:40 -0700, Rishikesh Jethwani wrote:
> On Mon, Apr 6, 2026 at 1:59 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > 2026-04-02, 17:55:10 -0600, Rishikesh Jethwani wrote:
> > > During a TLS 1.3 KeyUpdate the NIC key cannot be replaced immediately
> > > if previously encrypted HW records are awaiting ACK. start_rekey sets
> > > up a temporary SW context with the new key and redirects sendmsg through
> > > tls_sw_sendmsg_locked. When no records are pending, complete_rekey runs
> > > inline during setsockopt. Otherwise, clean_acked sets REKEY_READY once
> > > all old-key records are ACKed, and the next sendmsg calls complete_rekey.
> > > complete_rekey flushes remaining SW records, reinstalls HW offload at
> > > the current write_seq, and frees the temporary context.
> > >
> > > If another KeyUpdate arrives while a rekey is already pending,
> > > start_rekey just re-keys the existing SW AEAD in place.
> > >
> > > If complete_rekey fails (tls_dev_add or crypto_aead_setkey),
> > > we stay in SW mode (REKEY_FAILED) until a subsequent rekey
> > > succeeds, while maintaining TLS_HW configuration.
> > >
> > > Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> > > TLS 1.3 key update cycles.
> >
> > Something here doesn't seem to work. I have a very simple
> > client/server pair where one side just loops doing large send()s and
> > does a rekey (send keyupdate + change key) every N iterations (I've
> > set N large enough that it goes about 5 seconds between rekeys), and
> > the other receives all the data and changes its RX key when it sees a
> > keyupdate. If both sides are doing SW, it works. If I configure either
> > side to use offload, decrypt fails after the rekey unless I add a
> > small sleep() just after changing keys on the TX side.
> >
> 
> Found 2 issues with this test case:
> 
> TX HW Rekey: The start_rekey function is missing the EOR (End of
> Record) marker. Fix will be included in the next code submission.

For this, pay attention to the "[ANN] net-next is CLOSED" messages on
netdev, we're approaching the next merge window.

> RX HW Rekey: When the receiver tries to rekey, multiple new records
> are already decrypted by the NIC with old key and present in receive
> queue. To handle these records, we need to store the old key to
> encrypt with the old key and decrypt with the new key. Also, we need
> to consider back-to-back rekeys if we store the old key.
> 
> Any suggestions on how to address this?

I'm sorry, I can't spend this much time on solving this problem. I've
already allocated a significant amount of time to reviewing/testing
this submisison (including pointing out some very basic things). And
it seems you've already found a solution (store and use the old
key(s)).

-- 
Sabrina

