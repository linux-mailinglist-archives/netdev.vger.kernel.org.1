Return-Path: <netdev+bounces-261284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOF/D04loGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:49:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD061A4898
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 694DD30138BE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88724302750;
	Thu, 26 Feb 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="dmdX9L9D"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4630EF9B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102987; cv=none; b=LsAe8rbaqyHjlc+ZrF7eM8EBLAQfWOWzhixMdmFhdg+9K/uQoIJblYPvkvyX3Y8qcpH1ca8P/Omm+riSNAGwI4U+lGerCi0lMFtYXV0tKBlUukPbJxgO07VEyPyTB5mJmiGe9pTx9mXnHPvxvLxZZ6tpCxryRslUlj6y8cNiWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102987; c=relaxed/simple;
	bh=ZW8VyAp+w0dfg+/3/eISbRejprAVSGfHEntjmZGncjM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oE1uB6VcUSt2tjvFYbTf+32Az1iUcANgLhXo7e/QxhIo2O91m5P1N2mz+ba5Cdm6FHqOTuHOBmdD9zx25TUucqU0gLsxZwZkUdD+G6CnNQ9RjOrGKRDZNG8CCnNLIEIsjzjYPR8VnijnnV8289lPhkm/QeGg0ALd0a8rlRmIm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=dmdX9L9D; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E97C3A0372;
	Thu, 26 Feb 2026 11:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772102981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+8F6uaAAY+nVOcexAkwvGHGH7ZBxlH5CrIG25K9cK8M=;
	b=dmdX9L9DFyuFztWLTBIVbxkDY6VEY1uOGIRBP5iZKj8KalSMEXWhM/0Tnctbhhpv2S+zGC
	C+SBnP/2I0DjhlqQr33Z6dQuSFBqiC912K2T04QVBgLMYPBzrVMNWSJAtduAPlduOZcwmA
	wCHC49+wtq7pnXKu6JIzX6Kim5yU9q+zMDsH3bGztXiu7zODU3eMDIPgUAot+ia4Qidp2K
	Lu40FII4yZaom0djW2/VQBZMSr4kcXiprJpv3rDri2nTylgeY1m0JCEOSAuKxjfib8zI9y
	RK88iPJ+xDInRBq+RjdqbugYNJ+BjWDXkJEc+n8pz/nZ0lIqXed6KoreZsnHZQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 11:49:39 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, nicolas.ferre@microchip.com,
 pabeni@redhat.com, phil@raspberrypi.com, =?UTF-8?Q?Gr=C3=A9gory_Clemen?=
 =?UTF-8?Q?t?= <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
In-Reply-To: <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
 <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
 <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
Message-ID: <342fd96e9f9668392705496e54d93eff@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261284-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Queue-Id: 6FD061A4898
X-Rspamd-Action: no action

On 26.2.2026 10:52, Théo Lebrun wrote:
> On Wed Feb 25, 2026 at 6:50 PM CET, Russell King (Oracle) wrote:
>> On Wed, Feb 25, 2026 at 06:42:08PM +0100, Théo Lebrun wrote:
>>> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
>>> > @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> >  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>>> >  			     skb->len);
>>> >
>>> > +	macb_tx_lpi_wake(bp);
>>> 
>>> Should this be protected by a bp->eee_active condition? It could go
>>> in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for most
>>> platforms. Probably negligeable though.
>> 
>> It will read the register, find the bit clear, and then return if
>> EEE is already disabled.
> 
> Yes I agree with your sentence, sorry my point was unclear. I was not
> describing a bug but rather a performance optimisation.
> 
> We would look up bp->eee_active to know if we can avoid calling
> macb_tx_lpi_set(), to avoid grabbing bp->lock once per xmit.
> That spinlock is interface-wide.

So you're suggesting to revert to the v2 approach?
https://patchwork.kernel.org/project/netdevbpf/patch/20260224091821.47671-4-nb@tipi-net.de/
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Nicolai

