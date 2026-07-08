Return-Path: <netdev+bounces-305946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6c9ELhqXTmpGQAIAu9opvQ
	(envelope-from <netdev+bounces-305946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:29:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B4729822
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=NQ8w0Ns0;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=VrQiw1AX;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305946-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305946-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6D63019BA6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778C48A2B5;
	Wed,  8 Jul 2026 18:27:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB243800D;
	Wed,  8 Jul 2026 18:27:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535261; cv=none; b=PIBTtkR67XtWZAFFjO9oICSCrKc6N/CWO8AlUGc0wcLCI4fg5EH35zWE2mBcJ1pSmXdUH3EMIP0Hg/NOqq1cyQEJpuE4Qbt6VI8Z4UG/x/STSyQ8EGuReI5bgB3o6ACL+YwfXbGHi4tREo6KMPK/QTP0CX5ed1N7IqPc13jL+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535261; c=relaxed/simple;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBg3lXPTt6KR+kWxWCU0dW4R52wk6CgSNulS/Yivwmx6+n54h0aj4V+6I6BNSW7DFkhActdbOU/7a83oNTHiM4vCrCvFN7kJsIliNzQu6RfrwDHRXsWup8JG9TRH8FCpOAMLL4/HvDjIHWKKp8E02cT4cTrGro0pYvvh2BNIIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NQ8w0Ns0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VrQiw1AX; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535258;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQ8w0Ns0sMDpcxo56FYrlRW/4dVTE2c5t+BOp7S+vYSyEcrkJamMg6RKHdRs+Ufc9
	 stm0g4g2q21AL/gxFpafIMpNbdX1Wd6AtCFN/ifbhrn213vefmRP+Vf+v9cmdnyQCQ
	 qairUvNPdr4Skvvhm8AEAlU/hTxcNOz7D1VVw2YbChKUDsFFGJPYk7j4vMgS+P0oWH
	 RxfTZ3pNVOzTf7ZJgyxcODSn8yjeMvCcb/g9YSo4cAl7N45fe7FXJeOYV456f68HmZ
	 wseWEtVrlQB6RH6Mh2KLPa4E+9DyjbX4O1kWoUWnT+sW214P89iqG6RaWqX7yZwGkT
	 vgp28RlXM/VVQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 49E3A493F1; Wed,  8 Jul 2026 18:27:38 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535256;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VrQiw1AXARNU6X4FGPQhC5hJnwn5L8jbeJ/P6hBM7Ao69CA9z240azFFJd6G3IPvO
	 jDi78qFXX/62lAU9C2ynYqW4/Kt7iTovv85mz3oKWstUY/YoKgIj4Dek0bxPLs/Evz
	 ivVDOwKflIMrXpFKbZ/KeqFckCbnyIW+zAaHQKzJW5NgUtE03OXGhFsdQclOMp3HQ5
	 GECHH6pcSOQrJGygGxbIrysDeEErJAr1H5QMQOm6WNCle6F0WI5mPuAAOOUQ38rRu9
	 dtKxHQhLwAAhOOG/0gQPCVp5nC/eo/nyFbtG16WEuNpEqmpeKdmbd/ZUEEVUCeEjB9
	 Z3ehZdubkpSAQ==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 01F1C493D0;
	Wed,  8 Jul 2026 18:27:35 +0000 (UTC)
Message-ID: <dadd3b8d-fab8-4ad0-9167-e46132a1db1f@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
 <6b368510-05d4-4d73-b588-8002d0d59915@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <6b368510-05d4-4d73-b588-8002d0d59915@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,birger-koblitz.de:from_mime,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C4B4729822



On 7/1/26 17:05, Andrew Lunn wrote:
>>   #include <linux/usb/usbnet.h>
>>   #include <uapi/linux/mdio.h>
>>   #include <linux/mdio.h>
>> +#include <linux/if_vlan.h>
> 
> Does this patch require this header?
Yes, because of the use of __vlan_hwaccel_put_tag later in the patch.

> 
>> @@ -414,7 +570,6 @@ static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
>>   
>>   	usbnet_suspend(intf, message);
>>   
>> -	/* Enable WoL */
>>   	if (priv->wolopts) {
> 
> Please try to avoid changes like this.
Fixed in v2.

> 
>>   	/* Force bulk-in zero length */
>>   	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
>> -			 2, 2, &tmp16);
>> +			2, 2, &tmp16);
>>   
>>   	tmp16 |= AX_PHYPWR_RSTCTL_BZ | AX_PHYPWR_RSTCTL_IPRL;
>>   	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
>> -			  2, 2, &tmp16);
>> +			2, 2, &tmp16);
> 
> Please put white space changes in another patch.
Will be removed from v2.

> 
>> +	/* Initialize MII structure */
>> +	dev->mii.dev = dev->net;
>> +	dev->mii.mdio_read = ax88179_mdio_read;
>> +	dev->mii.mdio_write = ax88179_mdio_write;
>> +	dev->mii.phy_id_mask = 0xff;
>> +	dev->mii.reg_num_mask = 0xff;
>> +	dev->mii.phy_id = 0x03;
> 
> If this device is going to have a long term future, it really should
> move to phylink.

As discussed previously, I started converting the code to phylink,
but for the PHYs implemented as IP-cores in the the AX88179A-based chips,
the behaviour of the PHYs is so different from their discrete counterparts
because of other firmware used, that even if they have the same PHY-ID as
their discrete counterparts, they behave entirely differently and in a
way that is adapted to being used via USB as part of a USB-Ethernet
adapter.

Only few of the USB-Ethernet drivers presently use phylink (asix,
lan78xx), btw.

Birger

