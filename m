Return-Path: <netdev+bounces-275738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP5FDbAe1GmJrQcAu9opvQ
	(envelope-from <netdev+bounces-275738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B83EE3A763A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F8B43014B91
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D8342146;
	Mon,  6 Apr 2026 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="o57RMeOs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCtOOgJy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989B1E531
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509158; cv=none; b=fH9PfkzPuDfrEpWWKXcqRvdrqoZ+MpT/5IP4unORFYkzKHFf4E+n4paxI2Ev4wWkVG/ORw1x77wunzFvIs1qAJEkTjblDhWIYVgPx53KFQU4vukkDH+phMhwaOJMrnCsxpBfeJD3LRCJkRFk58dEPuHruxHQ0TL7s2wypDaRAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509158; c=relaxed/simple;
	bh=magp0IE22P75Lgn1+dhhXcundRnYJLEqy3cGcTt9mAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYTum9ZuDHCJ6i83Au3ipZBtFFwNFRL67rE8AlxjTDqiKmexgoN3vLviMY0gB6LTVbCYfYbhZ8qekt5VcHA9fTtqgk/v8vL3yW0c5P7TB/j/O0NrI2vFubvgQ3OdtrsMDvETbwtyA2CwVf1fvhut0+2Z/wuF+IEhRz6mpxHwrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=o57RMeOs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCtOOgJy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AE7B1400265;
	Mon,  6 Apr 2026 16:59:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 16:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775509155; x=
	1775595555; bh=utKnC8uziAIDCTK5Eh+hCDCjtBl/gA6MDG1mYjtAUnE=; b=o
	57RMeOsnTOOyT4IW73/rH932rTXAJYAKDarX8U33faxn2fX+fNmh8YOg8fjXySxh
	w+N3HU1y8Lbsl3PCXyWN/ZVapWYZ0Dp7DEmD6i80SbZYfKxB1xN9jSk3KPFazEiP
	/GzQkZ7rYfebQvSer6fJqV1KpwmMoUaiq1RBaIj/SZY4m2yEIb1PTiFLoTc4ACnd
	0y72L2xlSBYdNnPrTqQ/nrsV+Xhe/AhX+dEwuHi3xxRJx7F73zVbrqn/iT4iRI//
	/dXX8BeFsUi18vfk8G5/51A27vJa9FXVFJCVGaN+DVu8EQCQBVKgFJpNP8pgp1iN
	s7oSog0CR5q47xiQ2xCjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775509155; x=1775595555; bh=utKnC8uziAIDCTK5Eh+hCDCjtBl/gA6MDG1
	mYjtAUnE=; b=dCtOOgJyOzaofiuY2yGDWxrJVJDH5uXb+yHCefmHqd96DfDgf8e
	5B+kL679NQkY5Rs6poa5VMP82Wc/dlgi7AnTN30ke3t29V6H7O05EjHJgZUyqsNG
	o8SlVgKzrfFJ+SuqbUUrRzAwEC64rSd4STCVzlUNhzkKZmxAOEMYjDvveM+lC4VV
	1OYVkjbGukXZO26PirL9yHDFUyuGiQ+5J2kgDVami6OzBP44WzkpKdMdttD+hmvr
	Y35xLNh1ro7MoIG/HfgeYb7cW6HQjZhyJV/zW/CdnyOhhS1qxPBZijoKTyAcAflZ
	NoTlJfRoFcfGzn3QSrHLhKLOwwsy5sHmSRQ==
X-ME-Sender: <xms:ox7UaTwmIU27iIqzfFlnEwaZohMZJo5WRaj2wYt-W6CnHHxDR2tZ8g>
    <xme:ox7UaXGa-KMSB1x57vKOsNhnJSoVURGNnreWdcfdQT5G-GHQhNbOWw8JlGJXzewS-
    ENBLesL1oiB4XJ36jiZYNlRJCaj7h22JbazJBgWFSITPargQYd2xMs>
X-ME-Received: <xmr:ox7UaYuBGFIxyoD2eppztvR9oiAJxB3FkmU7n88LCncPpwtYgOmnY6Av554W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrjhgvthhhfigrnhhisehpuhhrvghsthhorh
    grghgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhope
    htrghrihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:ox7UaXBHpCEtcgdH5aJO-9EtGi4LiUL66rOTtSdR4d7f6-QWM0pCRw>
    <xmx:ox7UaTCh6yyWawZF43xpaA5z0rmfAWj9-8SO-kW4E5zi1u7kb2CYCQ>
    <xmx:ox7UaRqTYzZ8f_MVS3Zwya4YIWTahmS9KkbWztIVcwFLjXVTnIWdNQ>
    <xmx:ox7UaeELIJA4riF8AqfsIJqwQQ5f5E9tDAl44iHLn2o-kBY6nztGzw>
    <xmx:ox7UaVmSSLzpmJyz-sce5F3ovXD6o2rcGzUdtFcW8YeIfJN05DtjJby8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 16:59:14 -0400 (EDT)
Date: Mon, 6 Apr 2026 22:59:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v12 5/6] tls: add hardware offload key update support
Message-ID: <adQeoGH8qmhhCSal@krikkit>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
 <20260402235511.664801-6-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402235511.664801-6-rjethwani@purestorage.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275738-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B83EE3A763A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-02, 17:55:10 -0600, Rishikesh Jethwani wrote:
> During a TLS 1.3 KeyUpdate the NIC key cannot be replaced immediately
> if previously encrypted HW records are awaiting ACK. start_rekey sets
> up a temporary SW context with the new key and redirects sendmsg through
> tls_sw_sendmsg_locked. When no records are pending, complete_rekey runs
> inline during setsockopt. Otherwise, clean_acked sets REKEY_READY once
> all old-key records are ACKed, and the next sendmsg calls complete_rekey.
> complete_rekey flushes remaining SW records, reinstalls HW offload at
> the current write_seq, and frees the temporary context.
> 
> If another KeyUpdate arrives while a rekey is already pending,
> start_rekey just re-keys the existing SW AEAD in place.
> 
> If complete_rekey fails (tls_dev_add or crypto_aead_setkey),
> we stay in SW mode (REKEY_FAILED) until a subsequent rekey
> succeeds, while maintaining TLS_HW configuration.
> 
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> TLS 1.3 key update cycles.

Something here doesn't seem to work. I have a very simple
client/server pair where one side just loops doing large send()s and
does a rekey (send keyupdate + change key) every N iterations (I've
set N large enough that it goes about 5 seconds between rekeys), and
the other receives all the data and changes its RX key when it sees a
keyupdate. If both sides are doing SW, it works. If I configure either
side to use offload, decrypt fails after the rekey unless I add a
small sleep() just after changing keys on the TX side.

-- 
Sabrina

