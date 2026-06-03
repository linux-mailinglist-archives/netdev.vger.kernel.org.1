Return-Path: <netdev+bounces-294696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dZZUIXn4H2q3tQAAu9opvQ
	(envelope-from <netdev+bounces-294696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200156364BB
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 11:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=m0prZVM6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294696-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DBF6300750B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67D428841;
	Wed,  3 Jun 2026 09:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092A339708;
	Wed,  3 Jun 2026 09:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480117; cv=none; b=ijLv/IqV00IJ3pOxLbpvkXjhbUmjvHp0IemwxPVXmbXMrcyQBuUsX5swiSSBADUUJc1I3CHtbl+3Y847ayhNuWdkx9zTJrjBQb2dz4iJ/3CXcUAAsaBp/Dq06H72SalEyVuS83ZZT7/KSickn60CfL4W7t9Lz2PBd2MFPDHUBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480117; c=relaxed/simple;
	bh=hDnLDvhqbVCU2VOwBDHfh7+5jqwgjR/RNFzjS3fwavM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi4fQwW+F91v9CRzU9CSNENKR9PRkFn+r+MkMc5v3PNBMWhpZu4Pexxdv9W9LIn3kgoD5GcF+xYT12lsipRt7+S8Eh8NuajSl4fDS/9zsiY9zUvqvtVEIqcGTQWEJRkdKjyK4wwB0joBpOrwKNRu2VHjugFWCATwf+lDResNACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m0prZVM6; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BB11A1A378D;
	Wed,  3 Jun 2026 09:48:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 856715FFA8;
	Wed,  3 Jun 2026 09:48:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 691CE10888CC5;
	Wed,  3 Jun 2026 11:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780480112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lsa284HlyvD7YcDPlDuDUhOG7yi8maBQiEgj343AeqA=;
	b=m0prZVM6kdyfWz2eQLzUPyjLAzhR+2OFD/pJEx8SLeVIojbAKA/nvTwxnUkmsx0gnFe6XE
	Mmns3gtmmSm0Y7AS0b20ZnzN6NRcH9OSF0j0BrfNIC56z3cN0doJkk6klJntbpdJHuJtqX
	Ie51OjubB4NGaKNbUVDQMQzcaPaxxkbxjxTSiVn0Y8tvmSiaBgn2OIofYYs9NjvLt22+1P
	Na8Lzqn3OYkJF6sKzznG/3VnMm49oTSknwDz2bX+d4cqF+60A2S1EMlt7W/wytO7l+ma09
	/8oweZqQVr5RqlWk+qxOh6i/TPBYbO9Ezssi3AnCcjjSSVl8x/1qhsZDC/KiZw==
Message-ID: <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
Date: Wed, 3 Jun 2026 11:48:27 +0200
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
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
 <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294696-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 200156364BB

Hi,

On 6/3/26 11:13, Javen wrote:
>> Hi,
>>
>> On 6/3/26 10:00, Javen wrote:
>>>> On 6/3/26 08:59, javen wrote:
>>>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>>>
>>>>> Add support for rtl8116af dummy phy driver, match phy id and read
>>>>> link speed from MII_BMCR.
>>>>>
>>>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>>>
>>>> Can you elaborate more on why this is needed ?
>>>>
>>>> The cover says :
>>>> "
>>>> In this mode, the driver
>>>> needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY
>>>> driver, while selected standard PHY registers are handled through the
>>>> SerDes register.
>>>> "
>>>>
>>>> Why can't you use the SerDes registers for your PHY driver ? The
>>>> phrase above suggests that the "SerDes registers" have the typical
>>>> C22/45 layout. There are PHYs and PCSs out there that aren't accessed
>>>> through regular MDIO with regmap being used to translate the mdio
>>>> accesses done by phylib into the actual register access method used.
>>>>
>>>> Maxime
>>>>
>>>
>>> Thanks for your review.
>>> Maybe I shouldn't call it a "dummy" PHY. It is actually a real, dedicated PHY
>> driver for the RTL8116af operating in Fiber/SerDes mode. The reason we
>> cannot use the standard generic PHY driver is that hardware does not
>> correctly populate the standard Gigabit Status Register (MII_STAT1000, Reg
>> 0x0a).
>>> Here is a snippet of our MDIO read trace during link up:
>>> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x0a,
>>> value=0x0000
>>> r8169 0000:85:00.1: MDIO read: tp->ocp_base=0xa400, reg=0x05,
>>> value=0x41a0 Reg 0x0a returns 0x0000, the phylib generic status parser fails
>> to resolve the 1000Mbps link, causing the driver to incorrectly fall back to a
>> forced 10Mbps, even though the physical link is actually UP at 1000Mbps.
>> Therefore, we need to register a custom PHY driver to provide a
>> specific .read_status callback that parses MII_BMCR instead of relying on
>> MII_STAT1000.
>>
>> This behaviour of not getting proper information through the standard
>> register happens on multiple different PHYs, so having a dedicated driver is
>> the way to go indeed.
>>
>> What does this PHY do exactly, does it connect to an SFP cage as the name
>> seems to imply ? If so, what kind of mode can it support ?
>> 1000BaseX/100BaseX, maybe SGMII as well ?
>>
>> What I don't quite understand then is why you have the need to return a
>> custom PHY ID that matches that "dummy" driver, in the next patch.
>>
>> If this is a regular PHY with C22 registers, what's the original content of
>> PHYSID1/2 ? M
>>
>> Can you explain what the hardware looks like exactly ? What are the different
>> components involved, etc ?
>>
>> Maxime
> 
> It supports 1000BaseX mode.

Ok, but the driver for the "dummy" phy seems to be able to report SPEED_100, which
you can't achieve with 1000BaseX. Either this is a stray check in the PHY driver,
or there's more to it than 1000BaseX :)

Also, if this is 1000BaseX maybe you need to use the C37 helpers to read the link
status :

https://elixir.bootlin.com/linux/v7.1-rc5/source/drivers/net/phy/phy_device.c#L2607

> The datapath in Fiber mode is strictly and simply: MAC -> PCS -> SerDes. MAC accesses the PCS registers via MAC OCP channel. Although it is accessed via MAC OCP, the register definitions at those addresses are exactly the same as the IEEE 802.3 Clause 22 PHY standard registers.
> Reading Reg 0x02 and 0x03 via this MAC OCP interface simply returns 0x00000000.
> [ 1671.299837] r8169 0000:85:00.1: 8116af read: reg=0x02, value=0x0000
> [ 1671.299906] r8169 0000:85:00.1: 8116af read: reg=0x03, value=0x0000
> So we need a dummy phy id to attach phy driver.

So this PHY actually doesn't exist ? what you have is a PCS that you access
over MDIO, right ?

It seems it all boils down to how the realtek MAC driver deals with PHYs and
PCSs and SFP, that is without using phylink or the SFP infrastructure at all :(

Can you check for the C37 thing and the SPEED_100 reporting ?

Maxime



> 
> BRs,
> Javen
> 


