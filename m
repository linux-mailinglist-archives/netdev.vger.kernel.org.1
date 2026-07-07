Return-Path: <netdev+bounces-305487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpgCHFMLTWp8uAEAu9opvQ
	(envelope-from <netdev+bounces-305487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD671C853
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=IgLSxXyp;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305487-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305487-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803BA301F1A2
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86983168E1;
	Tue,  7 Jul 2026 14:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B842B325;
	Tue,  7 Jul 2026 14:00:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432822; cv=none; b=pBkO8Cvi9qInmhwqndfjGbsXxRgV0iXDvkHg2t5j/AjoGT5JlUIa/0oSPLLGdv9QZhjVunQbA9DYoXGlRUCK6FZ6Dh151+wXKtNg64w2bCujxa9lzCAdI3aWBY2SGNqgh6Mu559Orkd/qmwR6lxb74J3+qRLJ5AIxbgoJGNiykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432822; c=relaxed/simple;
	bh=hTF38CRsldNCAc84C+24BLtsxFbQnmuW4qGHVVfFL+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1OfuQORiCU4BEZFzbh9Hz8aJj2RllQjuZmiJ0jts4qJoOd5jDbdZryk2eU1FQ+hX4nW7VyrPYQrpFOIV03UG7vF3HcI4qbY1Hj4en4s0KGZnJHZmyUavAZfQpDLYX65JgU7vfnCqwGuEPe7KHR+vlEXl1gfWgS0gadLM712QH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IgLSxXyp; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C60C41A0EB2;
	Tue,  7 Jul 2026 14:00:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97FEE60333;
	Tue,  7 Jul 2026 14:00:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D240A11BC2532;
	Tue,  7 Jul 2026 16:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783432817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3MYQXM7UkANi2WT6aY2MDPikz9inXNl8D1Bb0zGbg7o=;
	b=IgLSxXypfN0MZ1rOo5iQyhIvtBVeXlLuS5UH4O3XEPh1p68PIZ04ZGCSy5QdcqZs6lKAXn
	4VxKKSSOq6CwRimor6o1gmC9qjWDInEoTS7sZA7Q7CJgMdlChmeSFPiKfgu0s0l85B+nZG
	q89IW3Ct+6MxcgFTFMwiOPRCfWhmIuHbEkA7tAFN+fkKkHOE6H0cfyvlqAhB3G5/AbITsZ
	H+004Hnj5u3hmn5QQ5c5IdUiLVxVPoAALF10N2SEEJCk+y7xrKhrBHbcINJghsaUN9MCdJ
	eLQy054PtyzjzNHVW9bbk8ZnsZtpQ8r4n791uk1h04CNSEPqyO2WPtLnDpi2Hg==
Message-ID: <c1254d42-e617-4ebb-b65c-3c4079766489@bootlin.com>
Date: Tue, 7 Jul 2026 16:00:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
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
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
 <20260701110427.143945-10-maxime.chevallier@bootlin.com>
 <aaef7304-573a-419e-b631-30b300373a08@redhat.com>
 <7f47104f-8333-4c10-aab6-90552daabefe@bootlin.com>
 <e1034a59-1ab0-4a41-b709-9da253d4901f@redhat.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <e1034a59-1ab0-4a41-b709-9da253d4901f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,davemloft.net,lunn.ch,kernel.org,google.com,armlinux.org.uk,gmail.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,sashiko.dev:url,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0DD671C853



On 7/7/26 15:46, Paolo Abeni wrote:
> On 7/7/26 12:47 PM, Maxime Chevallier wrote:
>> On 7/7/26 12:12, Paolo Abeni wrote:
>>>
>>> Both sashikos instances points to multiple races with dumps. I suspect
>>> some explicit locking is required.
>>>
>>> https://sashiko.dev/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
>>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
>>>
>>> I *think* this is hopefully the last pending issue.
>>
>> True indeed, the other issues are sashiko saying "what if we detach a PHY and attach it
>> to another netdev", which can't happen :) I agree with some of the locking points that
>> were found, I'll address that likely as a separate cleanup.
> 
> I'm sorry, but I think it's better to address the above problems with
> the main series to avoid a window of opportunity that could cause a lot
> of quite randomic/drop by submissions to try to addresses them with a
> lot of noise on the ML.

I was thinking the opposite actually, send a cleanup series that gets the
locking part correct before continuing with phy_port, as it seems for now
the phy_port/topology code is avoiding races just because all the callpaths
happen to be under rtnl(), but this isn't formalised properly with asserts
and dedicated locks in the problematic parts of the code.

I otherwise agree, let's not send buggy code to be fixed later and I definitely
see what you mean about the random submissions to fix these.

Maxime



