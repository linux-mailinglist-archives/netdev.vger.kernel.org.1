Return-Path: <netdev+bounces-258206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L5fNPgyjGkAjAAAu9opvQ
	(envelope-from <netdev+bounces-258206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:42:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F883121ED9
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FFB3301DAD5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA633FE1F;
	Wed, 11 Feb 2026 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0mxrcduV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6C343208
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795765; cv=none; b=IrIMoWfhBwKII8U19dHmETIi12qsCUWnT3jeZTG3Nz/Uszh3KnO/R6RcnJ5x9LqLGbZAU4xUcvzhwtVzg5bhUYfxljVkvgBXU+bPT52DkThQShekFEQLhDyUy/+SRDf85nZ44Nwe7teBaoEV2iY/1X9nSEB4v0HRT5rPD+duAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795765; c=relaxed/simple;
	bh=9+spGj3ppA3muGr5Rl3L3kB0mP5wMYkW/j5P1MGwVRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGaMGn1Jh634IvBtfhGUbZKtEn6Uu1UhkWO6J2avc9l5RcCVvRyb+pRgWIOVQJCMNWo1fflH+t1jJeuE2koM9QbvXqDs6CFLFrgUCdavb0/UQNqUMdljcMOnrHNMv1zDp8rhmNYT32M3iMy/Bw7e7/SDp1PyFhScPkAELCiSNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0mxrcduV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F8EFC8F467;
	Wed, 11 Feb 2026 07:42:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9114E606BE;
	Wed, 11 Feb 2026 07:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D80B102F1D15;
	Wed, 11 Feb 2026 08:42:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770795760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ATDZLB5iIVAZfKZ0JOgmFSZxjgAKCzxQXahRUCaMZ2k=;
	b=0mxrcduVJWeUcV0xXKoi5cMDETpu/78TAutg1fUriUAAO6mRMKTSSvXawF9nw4XcxsGdce
	gTh48kw44ubOozgDhoDQwEJD2CvNbzSeyDrdds7xUoAwKB33W6ivK1X2XFqRaTg7aBtAmX
	mZpSzakBPScLgkG0PizyecjVxhHwNuWl2ECtz2vVajMCiMlfO1t76NWIVTbM26isJsLiX5
	k/quGzyqDqcLq0P37wNbNkUfk3UD5XxcT3rtkLOnpUDJJGrTKkjVqbcgLvo3Th2pTeBSVp
	J7dHSY+FPQTuqwrQPTWRaGA+XJbczj0COlSJU1g8iEOLgw2/tSsNVnueavVXsQ==
Message-ID: <3369b59c-a56e-4c5a-9da0-0d3becfa69d6@bootlin.com>
Date: Wed, 11 Feb 2026 08:42:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/13] net: phy_port: SFP modules
 representation and phy_port listing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
 <20260210201101.5df36a41@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260210201101.5df36a41@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-258206-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 2F883121ED9
X-Rspamd-Action: no action

Hi Jakub

On 11/02/2026 05:11, Jakub Kicinski wrote:
> On Thu,  5 Feb 2026 10:23:03 +0100 Maxime Chevallier wrote:
>> Here's V5 of the second phy_port series, this time bringing support for
>> more phy_port use especially for SFP, as well as the begining of a
>> ethnl uAPI.
>>
>> V5 doesn't contain a lot of changes, only a doc formatting fix as well
>> as a fix for a potentially un-initialized pointer.
> 
> Any idea why this is set to Changes Requested in PW? :S
> The 3rd patch carries a Fixes tag, makes me want to apply the first
> 3 changes for 7.0..

I guess it's because of AI review ? The first 3 patches can be applied
together indeed, it makes logical sense.

Thank you,

Maxime

