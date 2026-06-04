Return-Path: <netdev+bounces-295082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8lKEFJIyIWo2AgEAu9opvQ
	(envelope-from <netdev+bounces-295082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:08:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4763DDD1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:08:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=vbft8c13;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295082-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC27E3067B4F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428D37E303;
	Thu,  4 Jun 2026 08:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713D3859CB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560139; cv=none; b=IQEmI6YFsuTz89/IseVk9DYpR2DnfEE34FWcVVaafWmJ0Qsfz1o2oakhYAaA46AXUbBC9rBmwoYRutJg223JIAeGKIOzwQn6P0bjTgENuTSfbZJzTljod/UZk52VJg1cCYImHlm9M7BKtm0iF1/BawgtAp7NZ/XlXVFH1yTyb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560139; c=relaxed/simple;
	bh=6DPDWi1Fdv2KhLiabVa6e+jQ5ofL59QW9KnnH61wnVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUiBqBvsVzXi+fw6pyvUUZ8+6Ex8B7vBy+nuahiS+ibzwUwQQvqgXbPvZlq8l3aA9mrSrwyZh3l+mOVUa92sGs0st0xQqMPhR0KDtauxeHfsjkwyCEXnM+Jtvttv8vz47+EqCO91v9V4b7RoYelVE6OeeAWgHGKWBp/HOV8iNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vbft8c13; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4F8E24E4059C;
	Thu,  4 Jun 2026 08:02:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20E335FEF7;
	Thu,  4 Jun 2026 08:02:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37204106A17D7;
	Thu,  4 Jun 2026 10:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780560129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xzaY2tAeL0L5YgTXcoH5IsPMnKeR68XcgGGXMSuV3dA=;
	b=vbft8c13XxpGiNTq+kj/BYvMTABGQqMT7eNS3flN+N47rhIOXIvi/Cv++Y1aclKZ23Qpj1
	JMntgP54DZ9hwVjBA0oYXhtRKU1hHrbdlPP2NpQ0FH0wpPflTdkqziZwVhhisufHfJUQ05
	2886I3iw1CIE1uCY1hWkb0Bbvfzsz4pV/99+S5gOW8L21mDGp/gUsYiuSbI3BBhfJhW3Mc
	5cz3nhK1bCazMawqn/oO5cxY2BxUb+fOkB/6UnSBGi+u0TCOztv31CnESG7s3DgBmK9MSI
	t+7sBfHHY+lpwC4gbqahWdS+LtPVOJEkO6qomDnzDW0lhPXlD9zmJWnN+Vzlzg==
Message-ID: <5d0a38d0-44ab-4689-a243-8c9aed057d93@bootlin.com>
Date: Thu, 4 Jun 2026 10:02:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
 <20260601084029.815461-3-maxime.chevallier@bootlin.com>
 <2823b00cb2aa211d8f4f392a37537351@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <2823b00cb2aa211d8f4f392a37537351@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FD4763DDD1

Hi Nicolai,

On 6/1/26 11:31, Nicolai Buchwitz wrote:
> On 1.6.2026 10:40, Maxime Chevallier wrote:
>> When phy_probe fails, let's clean the phy_ports that were successfully
>> added already.
>>
>> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
>> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  drivers/net/phy/phy_device.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 6ccbfacf7d1d..a171cbe2a74a 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>>      return 0;
>>
>>  out:
>> +    phy_cleanup_ports(phydev);
>> +
>>      sfp_bus_del_upstream(phydev->sfp_bus);
>>      phydev->sfp_bus = NULL;
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

I'll be moving phy_cleanup_ports(phydev); after the sfp cleanup,
can I keep your review tag ?

Maxime

> 
> Thanks
> Nicolai


