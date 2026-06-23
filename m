Return-Path: <netdev+bounces-301410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5uALam1OmpUEggAu9opvQ
	(envelope-from <netdev+bounces-301410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A96B8C22
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:34:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=PwsCCeSx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301410-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FE1B301426D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BD30C14E;
	Tue, 23 Jun 2026 16:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17829992A;
	Tue, 23 Jun 2026 16:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232482; cv=none; b=cjknsJVOO4b431nEkAE3iF1oRJfYQN1t1XjNc4+6NHa3BCJSiPPLnxsRb0W5MT1Y4kd/QGBynDGBIXMse7IgGFHnL7kzGAoS631ifBqJGxtRTwiJthc+NBsDIpAgHrxz5uNlhi5uHSLkpfEQzBT09/3Tc/ZPQo1BmVC9y6ebe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232482; c=relaxed/simple;
	bh=Q7C2WLq+w3wseZRK2d2WjJK33bsL447mI7ejl55BvK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgxbdKZtBBhY11zEI/nsKCzmIMwOwRIYsP91YyrCpF85T0MZVLIwZ/NCM6xcOlrOfLy0EhFz8/TL1ayiOinICJ/M1qsMQOeqGXUwkSYCEvQ3DbamOCKaSJXwJouYrBRjqDCtDcr1Eg5Hx1AcF+gGd7hOe4ZPW1JlfIAFEWD3WZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PwsCCeSx; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A0DA51A08AE;
	Tue, 23 Jun 2026 16:34:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F793601C2;
	Tue, 23 Jun 2026 16:34:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85E0A106C8382;
	Tue, 23 Jun 2026 18:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782232477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2wrqOjRzMhTb93M3exBJA5foYnr34jfu7Zmsb7q95s4=;
	b=PwsCCeSxTkhSaGoTDg4xMxOoL2zk6ED1MVfvwyPJwRYk5o/tBKr9xwp0bp3tVAV+1jWQFx
	aXOFvygrE8H0EM9WRUdBcMhbSGm5hdjaRUlOF4YjdOBWMz7ruzOkAzqJZq+GSinJ0PHaZS
	OIvOUOReO5w6MMQYLlYlmJiiF6wmd+BoxMc33zS7hYx/XqLHFTnwqI+GspefyRnGHr+p/N
	hi36FB6nBMSnCDhwtkRiwqd5l44Pf0use01uJ9BgFF5cek9TkqE/RIy9ywPS072cIjLgoM
	7JDhtOCvX+1BDNMuow4M5LA+oaq6a1O23DTc0O20HQMNJmTcvTSGYPgmgT4Omg==
Message-ID: <6738bbb7-63ed-4c65-a0df-f5f9514fcde0@bootlin.com>
Date: Tue, 23 Jun 2026 18:34:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net: phy: sfp/mdio-i2c: defer RollBall
 probe + fix mii_bus leak
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623080538.7646-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A6A96B8C22

Hi Petr,

On 6/23/26 10:05, Petr Wozniak wrote:
> This series resends the RollBall bridge probe deferral (a fix for the
> regression in commit 8fe125892f40) and adds a related mii_bus leak fix.

These are bugfixes, you need to target the 'net' tree as explained here :

https://docs.kernel.org/process/maintainer-netdev.html

Thanks :)

Maxime
> 
> Patch 1 fixes a pre-existing mii_bus leak in sfp_i2c_mdiobus_destroy()
> that has been present since the helper was introduced in 2022. Patch 2's
> new -ENODEV path destroys the MDIO bus via sfp_i2c_mdiobus_destroy(), so
> patch 1 is a prerequisite to avoid leaking the bus on that path.
> 
> The v2 deferral patch was corrupted in transit and failed to apply; it is
> regenerated here against current net-next with no functional change.
> 
> v3:
>  - Resend: v2 defer patch was corrupted in transit and failed to apply
>    (netdev/apply); regenerated against current net-next.
>  - Fixed block comment style flagged by checkpatch. No functional change.
>  - Added patch 1/2 (sfp: free mii_bus in sfp_i2c_mdiobus_destroy).
> v2 (defer):
>  - Generalized scope: regression affects boot-inserted and hotplugged
>    modules where bridge init exceeds 200 ms; Aleksander Bajkowski
>    confirmed FLYPRO SFP-10GT-CS-30M / AQR113C broken when hotplugged.
>  - Corrected state machine description (probe runs in SFP_S_INIT after
>    SFP_S_WAIT) - Jan Hoffmann.
>  - No code changes from v1.
> v1: initial submission.
> 
> Petr Wozniak (2):
>   net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
>   net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
> 
>  drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
>  drivers/net/phy/sfp.c         | 23 ++++++++++++++---------
>  include/linux/mdio/mdio-i2c.h |  1 +
>  3 files changed, 24 insertions(+), 15 deletions(-)
> 
> 
> base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4


