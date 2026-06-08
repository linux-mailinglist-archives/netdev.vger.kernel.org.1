Return-Path: <netdev+bounces-296604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sSEVHGvTJmqwlAIAu9opvQ
	(envelope-from <netdev+bounces-296604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000B657414
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DSXLaZBB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296604-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296604-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40E0330A7912
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316943CCFD8;
	Mon,  8 Jun 2026 14:23:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCE3CB2FD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:23:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928624; cv=none; b=bcV15ZdoKeXCI4ZSNnEaN15u1O0z0UYa68rKyws3e4FhE0ZqydB0VuvCyoZst06Tm+5j1QAwLW0bLeedUT8vZvm9wTnLPxLyevbNzZxRqkFyMCmuyB+/YWY8kspEEy484YISWkvLmLaiLcMdHgCPg/vl0GAnJpXMdH/TKxJJXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928624; c=relaxed/simple;
	bh=xG/h0yiLY7kKhERjflmJpWKl2eHPNJz95wXZRDGbjaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZRPvtV5iSPhxqSOUm6gHXUkr+G3LMwDipPxlDn0H+bGtlEKXJ2ZOZWv143WWekJU/lqTVdsOxEPIg9DAqJ95VwA07JpMQQIZOX02b+9+R6OA2PhTTc/fo+wkWvs0soXz6DBDP/TN9i770yjtCA0M/TEoRynNOgDiiIL5NFJ7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DSXLaZBB; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 00FF11A37D2;
	Mon,  8 Jun 2026 14:23:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C10F25FFB7;
	Mon,  8 Jun 2026 14:23:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D55C1106A295D;
	Mon,  8 Jun 2026 16:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780928620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4aYIYlMAWcvFfdd8owfFa2HC1tQ1UBlKgz/uYgabcE4=;
	b=DSXLaZBB0Yo4RlfGRuHgxJMH1r9sqnayn4OhC+Wu43oCDXKdbo8Me7RRMpEzmmjGvW12N4
	12gKHoLnN0glEg815oyTv23BUj3JZm91KLg9EDB4/hLyigNT9ERNu10m6OfCu7pUVrWOuY
	Cgs9AmW8cfdjo0r1VdKq7dhXPj7k9mb3XzxZtqD8Yca4dWybWLEwnl3AZIVFLGRMgbnHgm
	Rp2i2HWlcITW8QHhUL9dvNpNKMcR14eBCybY4USeNHq0RSJuchzQC/k3TTaxo6VuAOY8Y5
	Lgvc9UkAXnDHgrWBnH7bkjY/V6RcIsee2v/a3JUQvrE7WgIQHRQzaAZ+WqBwDw==
Message-ID: <d2aec499-071c-471d-b6ba-005f6e77d273@bootlin.com>
Date: Mon, 8 Jun 2026 16:23:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/6] r8169: add support for phylink
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
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
 <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
 <e8ff0b30c02e4bc996380c4bb93225fa@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <e8ff0b30c02e4bc996380c4bb93225fa@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296604-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1000B657414



On 6/8/26 09:40, Javen wrote:
>>
>> Hi,
>>
>> On 6/5/26 12:39, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> Transfer old framework to phylink. Phylink can support fiber mode card
>>> which can not get link status or link speed from standard phy registers.
>>
>> This is a good start, but you need to go deeper than that. Looking at the end
>> result, you still access tp->phydev a lot in this driver :
>>
>> Looking at r8169_mdio_register() for example :
>>
>> -> don't configure the PHY eee support with phy_support_eee() and
>>    phy_disable_eee_mode(), let phylink to that for you
>>
>> All over the driver, there's still a lot of manual control of the PHY with phylib,
>> look at the calls for phy_init_hw(), phy_resume(), and so on, you need to
>> assume that with phylink you may not have a PHY.
>>
>> The problem then is that there are places in the code where PHY registers are
>> directly accessed :
>>
>> static void rtl8169_init_phy(struct rtl8169_private *tp) { [...]
>>
>>        if (tp->mac_version == RTL_GIGA_MAC_VER_05 &&
>>            tp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_GIGABYTE &&
>>            tp->pci_dev->subsystem_device == 0xe000)
>>                phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b); [...]
>>        genphy_soft_reset(tp->phydev);
>> }
>>
>> In the end, you shouldn't even need to use tp->phydev at all.
>>
>> It's hard to know what this is all about, but it seems like something a PHY
>> driver should have to do, not a MAC driver :(
>>
>> Also, I'd merge the next commit with this one to have one single commit doing
>> the phylink conversion.
>>
>> Maxime
>>
> Hi Maxime,
> 
> I have one question about the existing link-change interrupt model.
> 
> For most r8169 chips, the PHY exists and the current driver uses the MAC LinkChg interrupt to notify phylib:
>         if (status & LinkChg)
>                 phy_mac_interrupt(tp->phydev);

This is the first time there's an attempt to port a driver that
typically deals with an embedded PHY to phylink, so we need to
sort this out.

The main issue is that this assumes the phy device is an integrated
PHY. But what if the PHY isn't integrated and can deal itself with the
interrupt ? or there's just no PHY ?

I think we could imagine adding a phylink helper that would call
phy_mac_interrupt(pl->phydev), however we need to make sure that
this is only done when the MAC is handling the interrupt on behalf
of the integrated PHY, and not any PHY.

> 
> After converting the driver to phylink, my understanding is that the MAC driver should avoid keeping a private tp->phydev pointer. The PHY can still be found during setup and passed to phylink_connect_phy(), but then I am not sure how the MAC-routed PHY interrupt should be handled.
> 
> Would switching the internal PHY to PHY_POLL be acceptable , or would you prefer to keep the existing interrupt-driven behaviour? If the latter, what would be the preferred way to notify phylib without storing tp->phydev in the driver?

I think we need to address this instead of falling to POLL :)

> 
> I also have a related question about the existing firmware handling and sw_cnt_1ms_ini logic. Some of this code touches MAC MMIO registers, so it does not seem suitable to move it entirely into the Realtek PHY driver. The current code uses tp->phydev in this area.

I'll continue looking at this deeper in the upcoming days :)

Maxime






> 
> What would be the preferred phylink-compatible way to handle this? Should the driver still keep the tp->phydev, or is there another recommended approach?
> 
> Link: https://lore.kernel.org/netdev/b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn/
> 
> Thanks,
> BRs,
> Javen
> 
> 


