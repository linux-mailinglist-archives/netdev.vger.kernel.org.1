Return-Path: <netdev+bounces-295131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K9E5NkFFIWpCCQEAu9opvQ
	(envelope-from <netdev+bounces-295131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:28:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868663E893
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:28:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=g9RMeIGB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295131-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295131-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308A6312A137
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C74014B4;
	Thu,  4 Jun 2026 09:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34123FBEA5
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:08:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564140; cv=none; b=ifQhczYNKlu/Pnku5hkmhDbPLV2lMCEUY/y9dSVdDKLd1nJgzVDYL1fNT4U9CoRGxjAu0JyxE7LfkxQnBaWHlAbdopDk0QKIZvmFnwc/2RwonqkyHfkMBCXETtkCnZFFSH1+yR93ecHQm2DuuwQAfo7X1kCdc3b8sLCUsNIox8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564140; c=relaxed/simple;
	bh=uc00VLcog2WfkxxWWJqpT2Obgov4mLLl8LSCSoJjTjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMRoJaXCotwA+f93E1MlvyoiN7l4jEolqhu9pmmEQjC3izAGSmWVb5ikXe2lGV29+g3o1gwhVS0IXsC0B8B+rMygSkzbwMigfM9g10J2SIr30Q6XRxds/SoqosCouRgImmMKUWmp0vvGGZUBtucJ88tSVOk32xHpLk1Y2iq1cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g9RMeIGB; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6AC301A06B4;
	Thu,  4 Jun 2026 09:08:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C5285FEF7;
	Thu,  4 Jun 2026 09:08:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CD33106A157A;
	Thu,  4 Jun 2026 11:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780564134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4srTPRj0v03/Rg5p6EvI3FZ1fKDS+khyaN2aDtnMGC0=;
	b=g9RMeIGB3rFIgWSWkMjyN7yxGTGvvmcx238cAmEaOEHKpTLIJLqOXgUM06dMi3bB1W5Wnn
	rTDX0p4v7+OHUvoa7YkpkYkAJj70uqY5iPpEQEueUo87u9b0fgM6cZhlFdTsdn2C4NmJP/
	7pStr2bUdgg5zOPDXVXEcXHhSKB9WBaNLzBOMpLrWuUrEgVuUUg7/4TqM30uzfLw8ndEI1
	4iusgDcNUExGUEnT22LPl3E52IfQXFx0AKqiRBvRGBYs2F04yY6AzbcF+asLXlZcS7qtNv
	7jWSohrGmc2+u+VMT4sPacrjZxzEDKXZ+wh0ljQO5v0NjECbkXz7ytO6Y9KY6Q==
Message-ID: <90716dc8-f10f-4777-9939-829f7e8b84ca@bootlin.com>
Date: Thu, 4 Jun 2026 11:08:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt
 mask
To: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <e10fe18a-a0a0-4c80-8ca6-88d0e0f18559@bootlin.com>
 <6837ed21-196a-48dd-b8b0-0f6691a946d0@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <6837ed21-196a-48dd-b8b0-0f6691a946d0@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295131-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,synopsys.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4868663E893

Hi,

>> to note that it'll
>> now make the "rx_buf_unav_irq" stat (that we can query from userspace)
>> stuck at 0 now.
>>
>> That's a user-visible behaviour change, for a stat that can be useful,
>> one could consider that a uAPI change...
>>
>> Do you have some numbers on the perf impact you see when buffer
>> starvation hits to see what we are gaining/losing here ?
>>
>> Maxime
>>
> Hi Maxime,
> 
> Thank you for the review and for pointing out the rx_buf_unav_irq concern.
> 
> We do have interrupt storm data to share. On Agilex5, under heavy RX 
> pressure we observed:
> 
> Under heavy RX pressure we observed eth0:mac firing 1,821,811,555 times 
> vs 2,618,627 actual RX completions on eth0:rx-0 — a ~695x ratio.

Ouch indeed. The stat itself has to stay, but the behaviour of that
counter is already different depending on the DWMAC core version.

I think we can get this patch in, but please state in the commit message
the performance measurements you're mentioning, as well as the fact
that the counter will now always show at 0 on XGMAC2 devices.

Maybe we'll eventually need some switch to toggle these counters, as it's
some valuable information when debugging, but has a significant impact on
speeds.

With the commit log updates,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> 
> BR,
> Nazim


