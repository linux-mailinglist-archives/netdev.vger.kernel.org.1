Return-Path: <netdev+bounces-265541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJLHLhvDrmmRIgIAu9opvQ
	(envelope-from <netdev+bounces-265541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A242393CB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24DFE302C31D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD823BED34;
	Mon,  9 Mar 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KnE2JS/Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A733B5301;
	Mon,  9 Mar 2026 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060880; cv=none; b=u9kC9Ldv0Zw3l3UPNkh6K1kui1+c5Qz6XD3UtXyN4Mby8W7G9afUnDwJHSmBw4dfGIsuNEqc4YPASJKkSf7o8y9H4NXS4b+FCQulLxDOBY3jVsLMkBuAsQFPoJ5LUeJbLjxQ4Chk3RLfe786y5qpKLT/OPNm4P5tp/KZbVNWAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060880; c=relaxed/simple;
	bh=JEs2IWfmscrKw+t0H8dNptKKC8kR/QKpS4L+iYAFxzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCgCT0cLHyVb0iWnx/WeXO5j+GrpMLTLZphQDq6qI7oDAPDYEJO2izaezNsXzu9ZGh7dwZYFK67yTmF7abrmY1jBv5iVVSwCt54FpF3ttdTcrQGKMvpRWfhpAQfmjwm8ZS4ctHUCU8lgKsefJsONK48ECjWyGSKNLkJs30iyHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KnE2JS/Z; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50C9E4E425D9;
	Mon,  9 Mar 2026 12:54:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 231675FFB8;
	Mon,  9 Mar 2026 12:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD71D10369B92;
	Mon,  9 Mar 2026 13:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773060874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZR9GAoP8GpYeY6MkEWjSdSANaRmKWabJF46IrFRn1Rs=;
	b=KnE2JS/ZI7dVsvlB0zYO641VEYu0fTPBI6o2A4cgrTRwMEN2aU5gDTdAjNB0+W86lC1F1l
	BGmz5tSb8p2zExVVHVpSCD3XgdSOB30Z6E15x3qxTMM361tk4IbQ3QZPccTfzzXtXV9X4M
	i+VO61uF9NVrGBHsQQa/SAI4By/eVagw39Vq5phVrNa4K4fO/TgwgoVdO5wIzUXlyl52nE
	iHgg5yNFnCFAaxpvLc0Dc33EMFdb850TR2zIZCwMS+T+yCMLSCUcgLduvWs1uWYY/0hdIL
	8ySEFnz6RucXDfeDMHEw5NBhZZYQEShfGdlPaA6rsKLGkdYrnZi7W2x77bL76g==
Message-ID: <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
Date: Mon, 9 Mar 2026 13:54:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: olteanv@gmail.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 Tristram.Ha@microchip.com
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
X-Rspamd-Queue-Id: 42A242393CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265541-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Vladimir,


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
> Note also the previous interrupt code only works for KSZ9477 and LAN937X
> families of switches, which have interrupts for each port.  The older
> switches like KSZ8863, KSZ8895, and KSZ8795 all have only one global
> interrupt and need change to work in this framework.
> 
> These switches have link change interrupt bits for external ports, so it
> is easy to simulate them as port interrupts.  But KSZ8463 only has 1 bit
> for link, so it is necessary to add some special code to return a value of
> 3 to indicate both ports have link change.
> 
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
> 

I have a new iteration ready. It uses only the high byte of the 
interrupt registers for the KSZ8463, which keeps unchanged the current 
8-bit accesses logic.

Shall I send it ? Or would you like more time to think/discuss about 
whether we should split ksz_common into several drivers ?


Best regards,
Bastien

