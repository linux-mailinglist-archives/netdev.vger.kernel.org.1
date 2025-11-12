Return-Path: <netdev+bounces-237875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60362C50FB9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B051886139
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834012DC348;
	Wed, 12 Nov 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sn8TWksx"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC792C21CC;
	Wed, 12 Nov 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933458; cv=none; b=sO/ejYbWkv+zwYFhsDfqSYQFYH1RvHpo7saOL6B7W+/0cK5S1KsD0lMLLCLCjEaT5CIvSyUtX04CuKbxnAeHPPFWXkAXF6lGcpKj0K92EOvIfgGYXsbbklWlhm3nAlAGMEzcA1zek2Xqxjt6Zb0ek/HuhsvtfuT6vy9WIrhBw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933458; c=relaxed/simple;
	bh=wuKIhQhEtgrHztRxPmC6x6TjFnuRn3eo8DIo218Td0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeCO5LAP3a6fE01uS1MpajjS3heJVoO3vQukYvKo3ha35WC9WwSXY05gMaB8YmmwFXH3klOKp/cxasZeCnNvOx0bkRXCICt0CbfJqbKMq4FowsMFMUGGN+5oTnkBG2sZ9sdC+nmmfYSlovTiAKbczwAYU6CJslQcevCMYl7RVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sn8TWksx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E7D731A19F8;
	Wed, 12 Nov 2025 07:44:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B45B56070B;
	Wed, 12 Nov 2025 07:44:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBA931037184A;
	Wed, 12 Nov 2025 08:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762933450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LeXLfZh+x68q92IP8JU7XiR2l1whiifjuFciiN302V0=;
	b=Sn8TWksxxVSwcCq9qt3PXVM3dPdMn0h1V4EYVRvILr13QFFsiy5F3at6iYLMXgzvBTqC9s
	p0irPkNj+6RtfaMyC4xnQI16wX7g9d2scMgGAHeMRdyR4xWTw9BItMt8KceZdAABlRZx/5
	Ns/lU3tbYGYvc2OeMVRQKIG1U72jUHmmQJdeevwXVFnHHv4pPnVAsrDTVoGBxZ0DxcDDad
	HKx9GRs/WKPQAZ8V74ih8bs7jvqSp8i5Ng1XRlXn8Q+6zgNoSE2n57M+obojUy/j3n9tuf
	wBDHUeKX6tHW7AUeqyWKH7peZ1a4+QX+NS/LAXgcsn52onDe918wVGlyL4wDXA==
Message-ID: <91ee0772-b166-4556-9c9e-e12fa0262088@bootlin.com>
Date: Wed, 12 Nov 2025 08:44:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
 <20251106-ksz-fix-v2-3-07188f608873@bootlin.com>
 <20251110182839.3dfb68bf@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251110182839.3dfb68bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 11/11/25 3:28 AM, Jakub Kicinski wrote:
> On Thu, 06 Nov 2025 13:53:10 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
>> index 3a4516d32aa5f99109853ed400e64f8f7e2d8016..4f5e2024442692adefc69d47e82381a3c3bda184 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -2858,14 +2858,16 @@ static void ksz_irq_free(struct ksz_irq *kirq)
>>   {
>>   	int irq, virq;
>>   
>> -	free_irq(kirq->irq_num, kirq);
>> +	if (kirq->irq_num)
>> +		free_irq(kirq->irq_num, kirq);
>>   
>>   	for (irq = 0; irq < kirq->nirqs; irq++) {
> 
> if the domain may not be registered is it okay to try to find mappings
> in it? From the init path it seems that kirq->nirqs is set to the port
> count before registration so it will not be 0 if domain is NULL.
> 

I first thought it was fine because __irq_resolve_mapping() inside 
irq_find_mapping() verifies that the domain isn't NULL, then 
irq_find_mapping() returns 0 when it doesn't find an IRQ, and finally,
irq_dispose_mapping() returns immediately when virq is 0.

However, after taking a closer look at __irq_resolve_mapping(), I 
noticed that there is a global irq_default_domain that is used by some 
architectures (mainly MIPS and PowerPC) as a fallback when 
__irq_resolve_mapping() is given a NULL domain. In that case, it seems 
possible for the function to return a non-zero virq that has nothing to 
do with us, and which would then be incorrectly released afterward by 
irq_dispose_mapping().

This second case shouldn't occur often but I can move the for loop 
behind the `if (kirq->domain)` check to be safe.


>>   		virq = irq_find_mapping(kirq->domain, irq);
>>   		irq_dispose_mapping(virq);
>>   	}
>>   
>> -	irq_domain_remove(kirq->domain);
>> +	if (kirq->domain)
>> +		irq_domain_remove(kirq->domain);

Best regards,
Bastien


