Return-Path: <netdev+bounces-274898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEjRIv9az2kXvgYAu9opvQ
	(envelope-from <netdev+bounces-274898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CDD3915A3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C137730157D9
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7622FBDE0;
	Fri,  3 Apr 2026 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sxB8E558"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A818364E85;
	Fri,  3 Apr 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196921; cv=none; b=uuigT8CILVC6h/4B1c6L5dvoqvbrA11ylI+aRCNM3VZqJOm6vONBFrX5RLTsZXwQg0et1qjoGl8hRVA727SVKYjiPVJRXuuUpAVMkBJWcBCJcJ24Hp7eY5wOdvbsr9FV0JICAgW9hmGUMm5jAnfepk/ixOc0I88szvFJezkz/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196921; c=relaxed/simple;
	bh=pjR0Q/XoEtgsmPSrfesugnXuBvkvGF+ho/i2RPoE5nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfb6hw2fjsO6XnMd74DNA6iL5DtPw8f2lBDy63FJZUvxsRU2Pf1c8MsEFqi+PzBtmzS02W5dhLk5QP0j23uITAiJPvJFCrKQuZp2+W5xtdfofCfZENqaznuTvhvET7kskpepaAgmrb0tt8ZzrhDalS08TzIySF/yFkEu3twQjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sxB8E558; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B55394E428C7;
	Fri,  3 Apr 2026 06:15:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68BD1603C1;
	Fri,  3 Apr 2026 06:15:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28CAE10450264;
	Fri,  3 Apr 2026 08:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775196906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2sxqu5R5Wk043JMyFgXFiDt3SNRh3XWkGz4XQz5WOSM=;
	b=sxB8E5585jew5frnLVqXXVpr/xBG7/82juZnbfFT743AWuaB9hvQwWPL67A/pTTqUWhFGT
	aFzC6ODrmTlAux5ytSvQbl8lEQ6dyl8Z7FXLkogZt34gPDd46An9c/QwKn0P0M2QRf3tw/
	a/PrszfKdlYbBXzShSv++h8KhMjUYLsV4fIPdocY/6Uuhyc36XlyCiLm93UGDCx4bilv4D
	kJ3yzpQ+l7x4rpDgZXVQlDm8MEqv/PEA4yx8Pw/RXb5tvucga0JNctndBr33q1k4ly2aIn
	PmKY2a6exIKeM/D3+h9EQYAzTUtotND/2a/sdHgcuUWC9qsHkaS+VcpOMUDudA==
Message-ID: <8f780d3f-c4ef-4976-ad0b-60718c29e06a@bootlin.com>
Date: Fri, 3 Apr 2026 08:14:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory
 pressure
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Baruch Siach <baruch@tkos.co.il>,
 Serge Semin <fancer.lancer@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260401041929.12392-1-CFSworks@gmail.com>
 <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 94CDD3915A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell

On 02/04/2026 19:16, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 09:19:27PM -0700, Sam Edwards wrote:
>> Hi netdev,
>>
>> This is v4 of my series containing a pair of bugfixes for the stmmac driver's
>> receive pipeline. These issues occur when stmmac_rx_refill() does not (fully)
>> succeed, which happens more frequently when free memory is low.
>>
>> The first patch closes Bugzilla bug #221010 [1], where stmmac_rx() can circle
>> around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
>> a filled descriptor (due to OWN=0), and attempt to dereference the buffer.
>>
>> In testing that patch, I discovered a second issue: starvation of available RX
>> buffers causes the NIC to stop sending interrupts; if the driver stops polling,
>> it will wait indefinitely for an interrupt that will never come. (Note: the
>> first patch makes this issue more prominent -- mostly because it lets the
>> system survive long enough to exhibit it -- but doesn't *cause* it.) The second
>> patch addresses that problem as well.
>>
>> Both patches are minimal, appropriate for stable, and designated to `net`. My
>> focus is on small, obviously-correct, easy-to-explain changes: I'll follow up
>> with another patch/series (something like [2]) for `net-next` that fixes the
>> ring in a more robust way.
>>
>> The tx and zc paths seem to have similar low-memory bugs, to be addressed in
>> separate series.
> 
> I've tested this on my Jetson Xavier platform. One of the issues I've
> had is that running iperf3 results in the receive side stalling because
> it runs out of descriptors. However, despite the receive ring
> eventually being re-filled and the hardware appropriately prodded, it
> steadfastly refuses to restart, despite the descriptors having been
> updated.
> 
> What I can see is there's 40 packets in the internal FIFOs via the
> PRXQ[13:0] field of the ETH_MTLRXQxDR register.
> 
> With your patches applied:
> 
> root@tegra-ubuntu:~# iperf3 -c 192.168.248.1 -R
> Connecting to host 192.168.248.1, port 5201
> Reverse mode, remote host 192.168.248.1 is sending
> [  5] local 192.168.248.174 port 43728 connected to 192.168.248.1 port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  30.3 MBytes   254 Mbits/sec
> [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
> ...

Ah !!

I have been struggling with that problem this week too. I stumbled upon
it while trying to test your TSO series, and at firts I thought it was
because of the TSO patches, but turns out it's not, I reproduce it on
net-next.

The main problem for me is that it's not always reproducible, it may or
may not show up when I run iperf3 after a fresh restart.

This is on socfpga (dwmac1000), so it seems the problem exists across IP
versions.

I've been on and off trying to make progress on that during the week,
but without success so far...

Maxime

