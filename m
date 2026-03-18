Return-Path: <netdev+bounces-268903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEToJhlUumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:28:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C552B6EF1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 454B03012221
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5F35F5FE;
	Wed, 18 Mar 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Igr+e360"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A42AEF5;
	Wed, 18 Mar 2026 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818897; cv=none; b=YUeZrXPT4Hwv8XbVj2RHb0HssQLdavn4bYLbWqxwQGmnj5CByh4BEAwfCwMUxFIr+M2xRg5Z0/3cmyCh7fwHqHATiIaZNoekX3IyW9rZAO6vLDEx9HhcgJZWjfWaKqsk23PVp3EGIYI7jSbupiKw4Ee9N/cClekY2zljFrGF10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818897; c=relaxed/simple;
	bh=tyNDwT/c4EgLIq2KDNMI76gENRuNuEaZPNPWw1KXtbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NENJEcmfeWutBaPf8g1uKKaJsnjDquGlcZVtsYQ5qOP5jWxjbLizYd7qUAuLO941hCY+GzMaD5EbqxJX1D89Rrb+YVhA2J0/Ja/xsYVG6tySpmWcpPVuHFocBcyvXJ4DrOnvlj0MMa140MwI7oy1qJHuD/9W6su9Neo9+PuS/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Igr+e360; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E73C4E426E1;
	Wed, 18 Mar 2026 07:28:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C21166004F;
	Wed, 18 Mar 2026 07:28:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCD9C104506E5;
	Wed, 18 Mar 2026 08:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773818890; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C4nJS6tAOgtGlGNN1yVO/wIVoSFFTD4/CQv2k971l8g=;
	b=Igr+e360tpWobh65YlNw+wMnypBDn6b06MqScRPqvEe1lEN3LYn2ZaCU87/xp94wxvePPl
	TlAezRPzGZQbGl8kX6Uitek1whwBDW69gxoTZxm+KME4Cr+8mt3rKU4CgSEd0oZTKOT3eL
	3mXCUo9d0D9GYuKn6JVeIPrOCdncpS4ppTtV92RGELUbZ+TFXnhi/scQMZ1sfvo7+gNnbk
	fijw58G7C5IWNlvN2Pdv45/IArd1eyK1+WeBIw0ExoKNftM41GVewG1HUR+4guUrZ8B8TD
	j1S3/KRsYo30b6pkkF31dM5C5OyMT397JS1j0YiZ3CaP4HqtsN4KrHU35Lfk0w==
Message-ID: <839f1eb9-cdc5-49bf-8ce0-1be9f5ca1c33@bootlin.com>
Date: Wed, 18 Mar 2026 08:28:00 +0100
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
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260312190705.0b3a3f78@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 90C552B6EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi again Jakub

On 13/03/2026 03:07, Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 16:27:46 +0100 Maxime Chevallier wrote:
>> Expose the phy_port information to userspace, so that we can know how
>> many ports are available on a given interface, as well as their
>> capabilities. For MDI ports, we report the list of supported linkmodes
>> based on what the PHY that drives this port says.
>> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
>> can output on this port.
> 

[...]

>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2026 Bootlin
>> + *
>> + */
> 
> so many lines for a copyright :(
> 
>> +#include "common.h"
>> +#include "bitset.h"
>> +#include "netlink.h"
> 
> alpha sort

So that's not as easy as it looks, "bitset.h" is really barebones and
needs definitions for stuff like ETH_GSTRING_LEN, but also all the
u32/bool types, etc.

In all files in net/ethtool/*.c the local includes list isnt' properly
sorted due to that.

So either we fix that, or keep them sorted that way. If you have a
preference let me know, for now I'm letting these out of order but I
can sort this out (pun intended) if you think it's worth :)

Maxime



