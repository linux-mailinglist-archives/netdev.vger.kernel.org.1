Return-Path: <netdev+bounces-264712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPLBLOOYqmmIUAEAu9opvQ
	(envelope-from <netdev+bounces-264712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:05:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CB21D999
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E29300B451
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C333893D;
	Fri,  6 Mar 2026 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lQo1Tz30"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBE33A6E2;
	Fri,  6 Mar 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787838; cv=none; b=mP5dkUDDrWIqtkrXE0LgxI9MSu13adP/T3xORka/39tdyvtZMNkW7or9gYwqC03moldpuFnDv34LztjPEOp8TeyFoGnU0MQRZ8L+BlI/ukprnZkEDaiUVsubaoFxg4WK1K5H7iI/eRreIOkTCHzJpIk7Da4t1ycHw6e3pR29bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787838; c=relaxed/simple;
	bh=zV8WsNlP5ZzT5acXzNbKBV/9KRyTgSiyPoylqcbqXuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtGV0ttVfoJW4uBW/hxCTOwd8b5QJZHmir0GHC3F/+YdkwBqxsS73KdARh9qqquCh+1M+Obcriitp3Kev9ra6hfkzx5GUTvp+eyHLijSN8KEJWFYJz/0yDr5Ouwb1WsQEQkGuN8sWCatwBw6z7Q3cvYajbIdcHX3pMP4Ej5FrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lQo1Tz30; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B162B1A2D13;
	Fri,  6 Mar 2026 09:03:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BB185FF92;
	Fri,  6 Mar 2026 09:03:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 680E91036977C;
	Fri,  6 Mar 2026 10:03:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772787832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QmkVtn+YfoRj1HaqYqZmNOYocP3ang2W3ATFJL1qd3I=;
	b=lQo1Tz30vXTOQmTt8S3KROKy6QExMmVdS/FNk+oyuy89O47rOalayLSrhp6kGQd6Myq77u
	SyDLoUVctecIou+PFl+d7xyIqgeCkRFhspFybDR3DkElyI3UV+xmTFbQGhu72/hnfZMRkz
	YSpQzK4Du5xbXfTf3bZnZle80bD7eBUKGDE3mnTGtSmxc+2cxiotqLYsWIWDYUgvT35Dqw
	PzyS4fbJofcL/22nlV41eJ7n7id8q666jOTWOtcEcTOiLCiuCZU1Vg5KU/GPL96mlwH2L/
	lEzJxE6qTRDA8EibWjBB2tuR2CKOcFWvXUt4vLnrZEet9iP8MOjDvj+8MQ8CkA==
Message-ID: <785e440c-6b2a-4ed7-aee3-09ca6cee797a@bootlin.com>
Date: Fri, 6 Mar 2026 10:03:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Tristram.Ha@microchip.com, olteanv@gmail.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1E8CB21D999
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264712-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,microchip.com:email]
X-Rspamd-Action: no action

Hi,

On 3/6/26 2:10 AM, Tristram.Ha@microchip.com wrote:
>> On 3/5/26 1:51 PM, Vladimir Oltean wrote:
>>> On Thu, Mar 05, 2026 at 01:39:29PM +0100, Bastien Curutchet wrote:
>>>> Hi Vladimir,
>>>>
>>>> On 3/5/26 10:56 AM, Vladimir Oltean wrote:
>>>>> On Wed, Mar 04, 2026 at 11:18:52AM +0100, Bastien Curutchet (Schneider
>> Electric) wrote:
>>>>>> @@ -2890,14 +2899,18 @@ static irqreturn_t ksz_irq_thread_fn(int irq,
>> void *dev_id)
>>>>>>             unsigned int nhandled = 0;
>>>>>>             struct ksz_device *dev;
>>>>>>             unsigned int sub_irq;
>>>>>> -  u8 data;
>>>>>> +  u16 data;
>>>>>>             int ret;
>>>>>>             u8 n;
>>>>>>             dev = kirq->dev;
>>>>>> -  /* Read interrupt status register */
>>>>>> -  ret = ksz_read8(dev, kirq->reg_status, &data);
>>>>>> +  /*
>>>>>> +   * Most of the KSZ switches have a 8-bits long interrupt status
>>>>>> +   * register, but the KSZ8463 has a 16-bits long one. The overread here
>>>>>> +   * is safe because we only iterate over kirq->nirqs in the below loop.
>>>>>
>>>>> FWIW, this isn't the only thing making an overread "safe".
>>>>> If the adjacent register also has "clear on read" semantics, that's not
>>>>> good.
>>>>>
>>>>> I can't tell whether that's the case here, though. There are just too
>>>>> many hardware variations to check for. I just wanted to point out that
>>>>> the reasoning is incomplete.
>>>>>
>>>> You're right, I hadn't thought about the 'clear on read' case.
>>>>
>>>> I'll use ksz_read16() only for the KSZ8463 to be 100% sure it won't break
>>>> anything for other switches.
>>>
>>> I'm still on the fence on whether to say this or not, because I don't
>>> really want to get so involved in internal driver bookkeeping, but...
>>> this driver is just becoming a hell to review, even if I want to
>>> concentrate exclusively on correct API use, like I try to do.
>>>> Linus Walleij has added a new ks8995 driver, which has some overlap with
>>> the common ksz driver for the KSZ8 family. Now he wants to remove the
>>> overlapping device support:
>>> https://lore.kernel.org/netdev/20260219-ks8995-fixups-v3-0-
>> a7fc63fe1916@kernel.org/
>>>
>>> Maybe we should go the other way around, migrate KSZ8 support to the
>>> ks8995 driver instead? The common ksz driver is becoming just extremely
>>> convoluted to handle all hardware variations. Would it help in any way
>>> to maintain cleaner code paths, what do you think?
>>
>> I agree, this driver is extremely convoluted because of all the
>> different hardware it handles. It wasn't easy to fit PTP support for the
>> KSZ8463 into it. And I encountered the same kind of difficulties when
>> adding periodic output support (I have another series ready for this
>> once this PTP support will be merged).
>>
>> Regarding migrating the KSZ8 support into the ksz8995, I think we would
>> quickly hit the same pain points than in ksz_common. Even inside the
>> KSZ8 family we can find a quite big amount of differences between the
>> switches. For instance, both KSZ8463 and KSZ8563 support PTP, they share
>> lots of common registers but their interrupt scheme is very different.
>>
>> I've added Tristram in Cc:, who works at Microchip. Maybe, Tristram, you
>> have some insights about which switches could share code if we decide to
>> split the big ksz_common into several drivers ?
>   
> Although KSZ8463 uses 16-bit register for its interrupt operation, the
> bits that are necessary for actual operation are all in the high byte, so
> it is possible to simulate using 8-bit register for interrupt operation
> just like the other switches.
> 

I hadn't though about using only the high byte, I like this idea. I'll 
implement it in the next iteration with a comment explaining why it 
works for the KSZ8463.

> Note also the previous interrupt code only works for KSZ9477 and LAN937X
> families of switches, which have interrupts for each port.  The older
> switches like KSZ8863, KSZ8895, and KSZ8795 all have only one global
> interrupt and need change to work in this framework.

Indeed, that's what patches 1 to 4 are here for.

> 
> These switches have link change interrupt bits for external ports, so it
> is easy to simulate them as port interrupts.  But KSZ8463 only has 1 bit
> for link, so it is necessary to add some special code to return a value of
> 3 to indicate both ports have link change.
> 

This series only use interrupt for PTP means. TBH I haven't looked at 
the link change interrupt mechanism.

> KSZ8463 is based from KSZ8863 so it should have about the same 8-bit
> register definitions as KSZ8863.  But when it was designed it had a
> companion chip that operates as a 16-bit network controller.  Because of
> that all register definitions are described in 16-bit.
> 
> I need to try your patches to see how it works regarding to the PTP
> interrupts.
> 
> Regarding to the old ks8995 driver I think it was a simple SPI driver to
> start the KSZ8995 switch, which is an older version of KSZ8895.  It was
> used to locate under the PHY drivers.  I did not know it was upgraded to
> become a full DSA driver and is now trying to expand to the other
> switches.

Ok, thanks for these information

Best regards,
Bastien

