Return-Path: <netdev+bounces-269592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA+mIUs4vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:54:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4D2D059A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FB823054334
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B03F1659;
	Thu, 19 Mar 2026 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EIFN+mnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED185343D60
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942759; cv=none; b=r1l0TMQ9EyUM+eoVmSRcvxzpQ9rVEUzElu9c0TfEUkST1vccfjseJRtUYPO0k9e67CAVCUAd6sLCm4jOZ8rBbtzmc6n0PdcY1hBTRzN7mp2Y/3wleKbksAVsqz/p38W01KGsrPxexzF7SK3kISNMMTHiS7NsRYKmOpOmWxuoUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942759; c=relaxed/simple;
	bh=c7KdzH6EkQEnIu60qLdJacRQT5STh1ryZYSTEgsyFuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOu3xxSjt7F40kLBOmmdMeuLLLjHXhESa2yEdmdaArlAgTvjzFaHEm6BGEW6UUTOwQVL2zINu7cKLV+TpNYAaXqHIMaFgWFlSCMPuEu/GY6BsGdFVw6glBZR1TQhJ2RpdZrDEUbKBkv5ZSyou786YqnkFyAeRl2SlV+2LocVzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EIFN+mnd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 31FAE4E4271F;
	Thu, 19 Mar 2026 17:52:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 039B460050;
	Thu, 19 Mar 2026 17:52:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4730410450941;
	Thu, 19 Mar 2026 18:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773942746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8h+kJtiQNyxdX0LIfkr+wSpHBs0qYPkOOQXebt6tRfc=;
	b=EIFN+mnd/aoBLMU4JLMfZCIFtWSfuBBGKwM3h7Ys814nOH0MXqOfw/qcEkjHeOBNFs/qfK
	buUvvHfo1Ticbqg73nPzR9xZmHLfSdLEL0WRryiz6D6v0VFOnxlkwPIeCdxFNDWIt4RMHw
	NSMfgjxnCXkV1hpJm53YpkASDB+QFeSggtV45rEblLi7lS3Esgr90KlWfhYoSDj83i5x/7
	68WfkrCmQWMKN5368nQ62cFRcajj9g99HFbKMgssCzAdfVhhHJLXkdR1UHroM6xYzg0iy7
	s9Rjla2oXAhtfpp0/hsJ1olPzWo/eoVTp/M6xULHJkhEUYJRv9IA09tho3NsQA==
Message-ID: <e35c5cde-c631-46f4-850f-4737b1f591d9@bootlin.com>
Date: Thu, 19 Mar 2026 18:52:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 10/10] net: ethtool: Introduce ethtool command
 to list ports
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>
References: <20260309152747.702373-1-maxime.chevallier@bootlin.com>
 <20260309152747.702373-11-maxime.chevallier@bootlin.com>
 <20260312190705.0b3a3f78@kernel.org>
 <97bd2ab1-a8ff-4c0b-a328-952139f18fc8@bootlin.com>
 <20260319075343.0aa9fac8@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260319075343.0aa9fac8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 1DA4D2D059A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19/03/2026 15:53, Jakub Kicinski wrote:
> On Thu, 19 Mar 2026 10:27:11 +0100 Maxime Chevallier wrote:
>>> GENL_REQ_ATTR_CHECK ?
>>> I guess you'll have to move it to prepare cause we don't get info 
>>> here :(  
>>
>> Sorry for my comments coming apart on your review, I'm getting this new
>> iteration done in-between other tasks  :(
>>
>> I can't move that check to the prepare_data() step, as we need the
>> request->port_id field to be populated at that stage for the DUMP
>> op (for each port, we set request->port_id, then we call prepare_data
>> and so on).
> 
> Not sure I get what you're saying - that it doesn't work or that it
> leads to "duplicated" work?

What I mean is that it doesn't work yeah.

> Alternative is to add info to parse_request
> args which I suspect is useful long term anyway.

good point, I like the idea a lot :) OK let me give this a try, I need
to see how that looks like.

Thanks for the suggestion,

Maxime



