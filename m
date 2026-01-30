Return-Path: <netdev+bounces-255147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +gcfKAGzfGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:32:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310EBB0F6
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888873006B15
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B22EFD89;
	Fri, 30 Jan 2026 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Je3QXedC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23A2E6CD3
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779889; cv=none; b=YliM531Wxs874mrd+SaTn+k65Ii5v0pl/bVwDQTYvizz10Q7sV/gXVwnZxgJufDimR8H2sQJFtRKt4eM6f6cMH9fl5dHDg/VHBHWQFbX53z6AnjFPRdqX3jj5NYMCadQmhkihoGG+bN9Nc1OknJVxX0xvaXEChF+U8SySGaHoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779889; c=relaxed/simple;
	bh=hL5khFf6UEpdzd/wemhA4ueSRWnX1kLYeMPoYajrg7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI1jI0+vihJyjmyqMx8Pe7Prmtlh2TJpuPPnmBRNuDAq0gD+7ltlYrE7VLMPvq5aIAeQtMgOIH6n0Xr34dAl3k6hyKR2fFOVTXAgOf+xoZTQpAqbYeyO9u+HxY9OInXRfhbkLaATPcpieJUPkg9tfsKgWBRuwQBdqynWx7YOsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Je3QXedC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 49B191A2B3A;
	Fri, 30 Jan 2026 13:31:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AED06075A;
	Fri, 30 Jan 2026 13:31:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA61A119A885C;
	Fri, 30 Jan 2026 14:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769779877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xTK8tAu6w9g3aPu2BEnOdbHOCzcvo1aEGx2JsyjLMrI=;
	b=Je3QXedCusIL99qPH6dRX/rGGRT8cxRkO23AcC+69zSPzSJnFOpPFGELu1haIQCpcvtnB/
	GLi8Lc47JyCf1KGJaxBtTkXASZJNeIF/ZNEDF1doxrTG3z/MliUvsyvOO2BLkG8MFUNcWK
	rUEGMCmJW1jurzBzvva9lkbJgojEDS81b8Y1VyEEoLV7g6tc+ofWgI9IkA5KuSIdv1Mza4
	RB4tyOizdjKqEeGbRIVSP5UjKJruP+nf6OwlfzyCdvb+EcNriAzTuBibcq5dRfK2fqSmkj
	LvVGGhsynEiFyLvO6YzpOZX+MX2LmIU2+rH5RiQW4rl2U8sPd8N9LrfOkQUwyw==
Message-ID: <82cb8e66-d99e-4baf-97c5-1602d2cd0fbb@bootlin.com>
Date: Fri, 30 Jan 2026 14:31:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/13] net: phy: Create SFP phy_port before
 registering usptream
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-6-maxime.chevallier@bootlin.com>
 <5074665.31r3eYUQgx@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5074665.31r3eYUQgx@fw-rgant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255147-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 2310EBB0F6
X-Rspamd-Action: no action

Hi Romain,

Sorry I missed these when sending V2, I'll integrate in v3.

On 28/01/2026 16:49, Romain Gantois wrote:
> Hi Maxime,
> 
> On Tuesday, 27 January 2026 14:41:53 CET Maxime Chevallier wrote:
>> When dealing with PHY-driver SFP, we create a phy_port representing the
>> SFP bus when we know we have such a bus.
> 
> Shouldn't this be "with a PHY-driven SFP"?

indeed,

Thanks,

Maxime

> 
> Thanks,
> 


