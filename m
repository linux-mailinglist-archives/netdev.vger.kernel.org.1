Return-Path: <netdev+bounces-253924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMfrALbdeGnytgEAu9opvQ
	(envelope-from <netdev+bounces-253924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D397021
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09A87306B8DC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625F135E53E;
	Tue, 27 Jan 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QSYDW22E"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01422FFDE1;
	Tue, 27 Jan 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527281; cv=none; b=jxfDGNrupNvkPDf18bSa/J1mlibuyoKoLaMgvdSnTiHIyugEULo9gDSm1EDXy9VWQVFcm5V75KnP1q81b1Vk+1OL+j9HU/J0CUXtiACQvZTfHUn0baDrc9uYXoX34kEEOeA7e9lk6/UNqAruBXf738CXvpC/u8thYWUS+YJNbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527281; c=relaxed/simple;
	bh=RRUg811pJ+cBdX9jlMunpOkfkjGJUh4eB4dsjIBSMRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+nLVR8LhNz7CxrLuBJK0uSnyBTcmbfm6Z4rm+hpczrXXdPiRHmc/cNjVFNhsDNZzQs4kSgZHvHcImXx9HX0/rhn2GbsBpjceqd85JdOVxxlq3ThcSEzZZBO2jXL7fsQ2GtycAOj6OtCXVBusCUok3fChNGb2feiUtiS73f/a9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QSYDW22E; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 176AA1A2A7B;
	Tue, 27 Jan 2026 15:21:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF933606F5;
	Tue, 27 Jan 2026 15:21:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A874119A8687;
	Tue, 27 Jan 2026 16:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769527276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WMipDv9MuM92RjWoMNI3U7Qxd5CzrA27eVlnKn0dWe8=;
	b=QSYDW22ExISK7Q8SZmdjSQJwM0GDH4aDLo1xhOhw6iahcLOYX/1LhxAZSROIihs6uZ//uu
	ru6gCMqLo00PzOY5zODRGu2vxciahLy75tVSBzWxpSEmy2LYbQ9HvtZYeK4aaVbv1OrWym
	p0imOALuuvQYvV6xM0nGYy2C5k43VMf5xdNjlPj5AnPui3cuBbQPCPeS7hMZBQ4SWVJDOq
	dsvlRroiBkXMg9dJgcek7xRO8eojznHw3vdKxhRhrP/H7p0uzuX93OGOkwpBp1J1SF2Ter
	/eTYQBogOX7C1YLf6Ei6Xw0cAghX5H7D1nivcGWBGkkutkGzdo3unYN34ttxrw==
Message-ID: <d86d05ac-6c1f-418e-80fe-ef354053caf6@bootlin.com>
Date: Tue, 27 Jan 2026 16:21:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/13] net: phy: phy_port: Correctly recompute
 the port's linkmodes
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-2-maxime.chevallier@bootlin.com>
 <20260127150021.110a0ddc@kmaincent-XPS-13-7390>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260127150021.110a0ddc@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A73D397021
X-Rspamd-Action: no action



On 27/01/2026 15:00, Kory Maincent wrote:
> On Tue, 27 Jan 2026 14:41:49 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
>> a PHY-driven phy_port contains a 'supported' field containing the
>> linkmodes available on this port. This is populated based on :
>>  - The PHY's reported features
>>  - The DT representation of the connector
>>  - The PHY's attach_mdi() callback
>>
>> As these different attrbutin methods work in conjunction, the helper
> 
> Typo here:           ^^^^^^^^^

Erf, thanks :)

> 
>> phy_port_update_supported() recomputes the final 'supported' value based
>> on the populated mediums, linkmodes and pairs.
>>
>> However this recompute wasn't correctly implemented, and added more
>> modes than necessary by or'ing the medium-specific modes to the existing
>> support. Let's fix this and properly filter the modes.
>>
>> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> It is the only fix of the series, maybe you should send it standalone?
> Else this seems ok to me.
> 

I considered that yeah, however without the rest of this series, this
bug has no impact. I'll probably split it out anyways, depending on how
review goes for the whole series.

Maxime

