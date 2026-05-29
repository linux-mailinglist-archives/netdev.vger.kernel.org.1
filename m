Return-Path: <netdev+bounces-293212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGISL7PmGWoZzwgAu9opvQ
	(envelope-from <netdev+bounces-293212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:19:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC4607C58
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C23A4300F5EE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120AD3A383A;
	Fri, 29 May 2026 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dQjXBwDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44672383300
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082354; cv=none; b=IPccHcmK6bnOyGE09gkY3ZerfPAFCcugRea3vz25mzcLmgJUuy138B0H/1vATbpHe6OGWSbjdCgSDlJWzK7uxFOReF/5E+DXADWpbZ2Wqj95J4Ocp9XrlpnDv4a8+pRpmu3AQOF9mcGeXXBEWcR74SEVH5pvKs7wgGB/ePaMPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082354; c=relaxed/simple;
	bh=1l9kPAlL/kZWzxukLCkcVycSATc5e0pSWZyl0XMQAqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKNDV4mf8tZemhPxOWbYTouWnz0L1M83LT+WZ9h1jylGR5bPGrxh+6e0RJ0qRoeJ7jngovWDdbS15hst1Q/PrkykPZ2UmcK08Ne5rCjm8PQriIWtT4uv98MC0N9B+ILPnV1ViM1cpgjM6wZt7RiZO+3XoJ8Du8/ZS1YR/PY8Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dQjXBwDu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54C2BC62462;
	Fri, 29 May 2026 19:19:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DCD3601FA;
	Fri, 29 May 2026 19:19:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFE7010888650;
	Fri, 29 May 2026 21:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780082348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3gGoxTQCbYwgT6qgZ25zkEpFpUWos5GQ0SIqBI0ohrk=;
	b=dQjXBwDuZouyE7/+grw336kWZP1ASkXwCJYXad7bMXkRloidLOw5V+ccfrkOgwB1wMojwQ
	oE9nKMpeojxTmByPAujrkwUHkoE3MuaP78vDTtidEJ2kRx6ZHRHB9ShPPQvRoRJMvRX6++
	+enPFIl2lhExsWQe7o0woTYQMeuVW5Y5GnIwAm25f8/UEOcSUjmb5jFo/FwwrXOY3jm4nR
	6Rz23fvZ/EBOOAq7ZHlf163TsnSzVAFJqvd4cBowEc70W74a68FGRRBc7RGAN5A0xsZkzg
	vGzuO8p+Ht6EPBUTS4qzJ9fAOa1mSMJUXKJClMXPQvjZgC6+TLVlv2fn4811fw==
Message-ID: <e10fe18a-a0a0-4c80-8ca6-88d0e0f18559@bootlin.com>
Date: Fri, 29 May 2026 21:19:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt
 mask
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,synopsys.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293212-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60FC4607C58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/29/26 09:17, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
> and can trigger a MAC interrupt storm under heavy RX pressure. When the
> DMA runs out of RX descriptors it fires RBUE continuously until software
> refills the ring.
> 
> However, RBUE is redundant: the normal RX completion interrupt (RIE)
> already triggers NAPI, which processes completed descriptors and refills
> the ring, causing the DMA to resume. The RBUE handler itself only sets
> handle_rx - the same outcome as RIE.
> 
> Remove RBUE from XGMAC_DMA_INT_DEFAULT_EN and XGMAC_DMA_INT_DEFAULT_RX
> to prevent the interrupt storm while keeping normal RX handling intact.
> 
> Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

We had an opposite discussion about enabling rx buf unavailable
interrupts for other DWMAC versions :

https://lore.kernel.org/netdev/E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk/

While your patch makes sense, I think it's important to note that it'll
now make the "rx_buf_unav_irq" stat (that we can query from userspace)
stuck at 0 now.

That's a user-visible behaviour change, for a stat that can be useful,
one could consider that a uAPI change...

Do you have some numbers on the perf impact you see when buffer
starvation hits to see what we are gaining/losing here ?

Maxime


