Return-Path: <netdev+bounces-269557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB0vNM4rvGn4twIAu9opvQ
	(envelope-from <netdev+bounces-269557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:01:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF032CF48F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02E732D3AC8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA43E8699;
	Thu, 19 Mar 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="N2eVJr5Z";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Sp0OHZ0p"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8C37C101;
	Thu, 19 Mar 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939096; cv=none; b=QhYDfUjOxqpty6OyRxkxS2N1D6h8h9ozFY51c2SEI9BXIB/WYTVZQOtRItEymRGWPdfnkLCu+1xX9cvSqRxXfbP5mUvIMTGMMu8ttY/BKFxAHaDEOIlg6D5+Kn6NP9uezOSRO9+haMvHkiYwfwzfQUh6j3wduoEp7vTR3VcFE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939096; c=relaxed/simple;
	bh=tb7ymzpKPJVLiW7lW9Qri0h1vBmvcYheUsd8EfunfWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw8lNjz0qO9LpM6f5Plj7WbhZXx9lEHNrrEBFHaPiexjkrwGkD3cUkgStzO3lmA16OEtakjZZWY9MqxCFHThL8wSVwfbaXqLqw+dJNC6H/VxvOTGb+O9GAaoiumqv6JetuXNx08gmtKlkwe/8vNjSjZHPKHGN/ws00UnNscOCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=N2eVJr5Z; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Sp0OHZ0p; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773939092;
	bh=tb7ymzpKPJVLiW7lW9Qri0h1vBmvcYheUsd8EfunfWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N2eVJr5ZvkKqA3Mt4f1cnENJ5RzVWo3AyRtdAzGZsIF8pjt1BA9oYwSC9BOm8SttP
	 zsiK0U6OAjtzKj9A4VCwgRcNu0F+A0RGSsSeGRwf2YCP6haKJhldxh8UurwRX3v6d6
	 2CW3u5lKzU+Hft5DS/XWc/tm+ysRbjOogu5Wq9K8Nxpo+9EHgqMYqwJwgx8dFQcU20
	 meHItH2L0X1gYMThuzPTpel4HBi5XK4Py0FOUNi0arkaGCB7CFI4gJ1WfYU378dMq/
	 KWgP2X0mEhyY69VcdNkq86qM0RWoJzpsD4NMF5nzdsNcfrX1s9UpgNMLD1k8hVzrko
	 LP4alzri9QS+w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B75183FEAD; Thu, 19 Mar 2026 16:51:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773939090;
	bh=tb7ymzpKPJVLiW7lW9Qri0h1vBmvcYheUsd8EfunfWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sp0OHZ0pAhaVr9Fr5cycozBY4JEdI20z5Hi6AfVs/Ho1eYo3hO8fTohEWjJLzkbx9
	 fi4pGx5oe3BwNtDLcRUSHbGZWmYEFoqNfBukPlAUJK7V81/Tj+4M7ij5Yy6R79NBdp
	 PUSRe+OpfgeOzGCglNQ/f1lRz0BgK2sb1beGhKiV/hWItFieq6I956YLYZfGzl/BPg
	 Sfh2wccjBK7oNmGGTmyDhrkFUi6OGxzvgaDshtbWt4rs6F762AGDWjVa3XGi5H5iFQ
	 7ULN+sev/4mG9RyNF3u5un5m2V0Yi09x+Xe2VUFMRLD6PIILorBGt/9Mt8NYZWC0Ai
	 IXsAR6VXPR3XA==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5B3BB3FE9A;
	Thu, 19 Mar 2026 16:51:30 +0000 (UTC)
Message-ID: <acabbc3f-ffe3-48e6-a630-00eb4daac9c4@birger-koblitz.de>
Date: Thu, 19 Mar 2026 17:51:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
 <9efbf132-f367-487b-aa66-8a9610d91d2d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <9efbf132-f367-487b-aa66-8a9610d91d2d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-269557-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BF032CF48F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/03/2026 5:29 pm, Andrew Lunn wrote:
> On Tue, Mar 17, 2026 at 07:07:14PM +0100, Birger Koblitz wrote:
>> The RTL8157 supports 5GBit Link speeds. Add support for this speed
>> in the setup and setting/getting through ethool. Also add 5GBit EEE.
>> Add functionality for setup and ethtool get/set methods.
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
>> ---
>>   drivers/net/usb/r8152.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 3b6d4252d34c63ead8f11a120e212325a5f7d505..bab8e10e5f99afcb332e333c2739ed7509b03419 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -604,6 +604,7 @@ enum spd_duplex {
>>   	FORCE_100M_FULL,
>>   	FORCE_1000M_FULL,
>>   	NWAY_2500M_FULL,
>> +	NWAY_5000M_FULL,
>>   };
>>   
>>   /* OCP_ALDPS_CONFIG */
>> @@ -725,6 +726,7 @@ enum spd_duplex {
>>   #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
>>   
>>   enum rtl_register_content {
>> +	_5000bps	= BIT(12),
>>   	_2500bps	= BIT(10),
> 
> Any idea what bit 11 is for? There is not normally any speed between
> 2.5G and 5G.
No, I have no idea, and I puzzled about this, too, plus triple checked 
it. But this reflects a hardware register, hardware engineers sometimes 
leave bits out. _10000bps will be bit 14 for the RTL8159.

> 
>> @@ -9934,6 +9979,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>>   		} else {
>>   			tp->speed = SPEED_1000;
>>   		}
>> +		if (tp->support_5000full &&
>> +		    tp->udev->speed >= USB_SPEED_SUPER) {
>> +			tp->speed = SPEED_5000;
>> +			tp->advertising |= RTL_ADVERTISED_5000_FULL;
>> +		}
> 
> Let me check i understand this.
> 
> ethtool supported will indicate 5G, independent of the USB speed? But
> it will only advertise 5G if the USB bus is USB 3.0 or higher, which
> can do 5G. The user can however use ethtool to advertise 5G, for USB
> 2.0?
I puzzled about this, too and then decided to leave it like this. The 
support for 5GBit is a hardware feature, so it is OK to state it is 
supported. But my tests with slower USB connections really show that it 
is better to rely on throttling the link speed itself, since flow 
control will do a rather bad job if the Ethernet connection can handle 
much more than the USB connection behind. However, if the user insists, 
they can advertise a higher speed.
> 
> I suppose the question is, are there any link partners which do 2.5G
> and/or 5G, but not 1G? I guess not.
That was my rationale, too.

Birger

