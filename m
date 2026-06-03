Return-Path: <netdev+bounces-294687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OKI8NJDrH2qesQAAu9opvQ
	(envelope-from <netdev+bounces-294687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:53:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EB635E22
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:53:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ZnUwckA+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294687-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942B83059A6F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FF423164;
	Wed,  3 Jun 2026 08:52:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0C410D06
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:52:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476758; cv=none; b=Oz3LaxH01pnzYEP7Nt+gfKyi02/ff3w+GEV0pILs6UztYIOaOk1dyTMrHug3zNwfRqbbM0qpGunxMP6r9bRDtMZX2BiE4TVJNIJmF59mUI4Vjt/2UtvEr6UhK8G+PkEY5MyhanlXZuHK5l0PtPN8jzoHwlKq5Vvun+ydw4TIr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476758; c=relaxed/simple;
	bh=RE/Zj/t1+FMfjYA6bjL+XT3fbStNtIs5GkWX+6ztI5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyFTqP4tWSK7qzCIOQbEgDFKiJDVPY64AAqCDK5koxBbEH2mQZ8JMCC/NMk/F0rdpqnJptQ9SIIhoVYeV7my0rTw2jiRB0YZJY/qdrJE9sx5Nc1reyC9SGkWAjOoJM3I7iYEC6OFGPEsaNBikmQNnVwBhcXydDHV4APL7B3Jv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZnUwckA+; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12FB2C62216;
	Wed,  3 Jun 2026 08:52:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 151165FD24;
	Wed,  3 Jun 2026 08:52:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3192B10888413;
	Wed,  3 Jun 2026 10:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780476748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eo9kA44gQ5MhrhekfzyB7OX6oHlcxve3kXco3iA6of0=;
	b=ZnUwckA+4fxBjqzbpxuqsMeuo1F52eOviKl7tIgnLfY9Ta+zfKHw7du2+6Pd2WfwdCYGoi
	n5916bNva3nEBF7pelb/mnyZN4XlEttrczAHsXklPJD7M0mG5WPTW8mssc48xQo7X7hYr3
	7HhfiYixNFPtqbQxcH3P+1z+vmng6mL7wfOa2Uw2O7uKQ39PlDPRMOEkHXAs9SnkdzLCi7
	eqfFrbI1XJ8yaTTj68/nX2XoUvJEe+byIN5xRcSUoKVQvXSIdahEw2sNLOIb2geeZJUBhK
	PgD2wuvAH/qlQ8fEYUPqPjRZIekBnFOtJB8xwbLjG6tsFzITBf3OIXXQMofaEA==
Message-ID: <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
Date: Wed, 3 Jun 2026 10:52:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
To: Javen <javen_xu@realsil.com.cn>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 250EB635E22

Hi,

On 6/3/26 10:00, Javen wrote:
>> On 6/3/26 08:59, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> Add support for rtl8116af dummy phy driver, match phy id and read link
>>> speed from MII_BMCR.
>>>
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>
>> Can you elaborate more on why this is needed ?
>>
>> The cover says :
>> "
>> In this mode, the driver
>> needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY
>> driver, while selected standard PHY registers are handled through the SerDes
>> register.
>> "
>>
>> Why can't you use the SerDes registers for your PHY driver ? The phrase above
>> suggests that the "SerDes registers" have the typical C22/45 layout. There are
>> PHYs and PCSs out there that aren't accessed through regular MDIO with
>> regmap being used to translate the mdio accesses done by phylib into the
>> actual register access method used.
>>
>> Maxime
>>
> 
> Thanks for your review.
> Maybe I shouldn't call it a "dummy" PHY. It is actually a real, dedicated PHY driver for the RTL8116af operating in Fiber/SerDes mode. The reason we cannot use the standard generic PHY driver is that hardware does not correctly populate the standard Gigabit Status Register (MII_STAT1000, Reg 0x0a). 
> Here is a snippet of our MDIO read trace during link up:
> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x0a, value=0x0000
> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x05, value=0x41a0
> Reg 0x0a returns 0x0000, the phylib generic status parser fails to resolve the 1000Mbps link, causing the driver to incorrectly fall back to a forced 10Mbps, even though the physical link is actually UP at 1000Mbps. Therefore, we need to register a custom PHY driver to provide a specific .read_status callback that parses MII_BMCR instead of relying on MII_STAT1000.

This behaviour of not getting proper information through the standard
register happens on multiple different PHYs, so having a dedicated driver
is the way to go indeed.

What does this PHY do exactly, does it connect to an SFP cage as the name
seems to imply ? If so, what kind of mode can it support ? 1000BaseX/100BaseX,
maybe SGMII as well ?

What I don't quite understand then is why you have the need to return a
custom PHY ID that matches that "dummy" driver, in the next patch.

If this is a regular PHY with C22 registers, what's the original content of
PHYSID1/2 ? M

Can you explain what the hardware looks like exactly ? What are the different
components involved, etc ?

Maxime


