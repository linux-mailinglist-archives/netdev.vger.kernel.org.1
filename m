Return-Path: <netdev+bounces-239218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E01C65CF4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28A3A4EBBAB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467152EF65A;
	Mon, 17 Nov 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hS514xmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C128468B
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405525; cv=none; b=G7Bvjdnaaxmfn4sfvV7x8fhExWJse41KCsXjuHNP4ujdqh4x4jp2Eg9NORVqC9VGizuxFGTB61PK6J0mp+WFbEDtUV6hpz3MK2e/lkcAdfoK3NqjOq9v5WJDTbW8plyBKTW55j70Srd+YyHnu8IP1DpfKG1SIYoyO7sFCAGxK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405525; c=relaxed/simple;
	bh=N0zzGvB4gmHXQPUV/DvfUAPgtp1mAqHxxP4vQDVL390=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y09Qw6hNN6RhFoA1aTyaT1zLTF3yInECRhOvoMz1Ik7o6UopeG49vw4aD+z4W10tXb/prpFgSKsiVT8p5taGXdppYVHKRu4qBXN40GxpC9kKriehRRQv07g3Bp90wFZuQGnl3bxgWcmjynEZjM0KCDvdrNLD/ws6GUWttFADlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hS514xmb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC81D1A1B5B;
	Mon, 17 Nov 2025 18:51:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90C70606B9;
	Mon, 17 Nov 2025 18:51:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4549B10371413;
	Mon, 17 Nov 2025 19:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763405518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=t/mcnN4+ND5npEnAXQxOQIc+lsltG5KMC8Z93nq3lYM=;
	b=hS514xmbsxkDamrwJz8tZhCR0g0yUTwBbMZj6/rGOgycqbpS6WOz1Kq/lHrKsmDX4I8Kth
	S8hVW9yN+GTej7ppCIPJAUH6yfy4j5t4aICMEtWLvXw2+ta/Yo8J+uvxWfJHqC6basJpNv
	r+Upr/YzyGTucqQuwJ8KXR3iEDuzg1GRtPMAADc6gn+NxnrECZ+z9LDjvFhBpXfoEEBpKW
	pddG6JdfhA2qcJrw6MaJHFXDy0+IKrFIVkJYwLdAauERhYLNYOynJSoeDQlaGZN0cJiEeV
	ng5H+wAZyw+zgR7RGlYJYYmDCCOb9q9dVjNmsaf6hj4k75UYp2+lj8pRSqdW0A==
Message-ID: <bcd94483-281a-47e7-b82a-14064ad36129@bootlin.com>
Date: Mon, 17 Nov 2025 19:51:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 4/5] net: dsa: microchip: Free previously
 initialized ports on init failures
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
 <20251117-ksz-fix-v4-4-13e1da58a492@bootlin.com>
 <fed4309a-af05-4222-b9af-2ff8c655f3df@bootlin.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <fed4309a-af05-4222-b9af-2ff8c655f3df@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

On 11/17/25 5:28 PM, Maxime Chevallier wrote:
> Hi Bastien,
> 
> On 17/11/2025 14:05, Bastien Curutchet (Schneider Electric) wrote:
>> If ksz_pirq_setup() fails after at least one successful port
>> initialization, the goto jumps directly to the global irq freeing,
>> leaking the resources of the previously initialized ports.
>>
>> Fix the goto jump to release all the potentially initialized ports.
>> Remove the no-longer used out_girq label.
>>
>> Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/net/dsa/microchip/ksz_common.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
>> index a622416d966330187ee062b2f44051ddf4ce2a78..2b6f7abea00776fafff0c1774cab297a7ef261da 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -3035,7 +3035,7 @@ static int ksz_setup(struct dsa_switch *ds)
>>   		dsa_switch_for_each_user_port(dp, dev->ds) {
>>   			ret = ksz_pirq_setup(dev, dp->index);
>>   			if (ret)
>> -				goto out_girq;
>> +				goto out_pirq;
>>   
>>   			if (dev->info->ptp_capable) {
>>   				ret = ksz_ptp_irq_setup(ds, dp->index);
>> @@ -3083,10 +3083,8 @@ static int ksz_setup(struct dsa_switch *ds)
>>   			if (dev->ports[dp->index].pirq.domain)
>>   				ksz_irq_free(&dev->ports[dp->index].pirq);
>>   		}
>> -	}
>> -out_girq:
>> -	if (dev->irq > 0)
>>   		ksz_irq_free(&dev->girq);
>> +	}
>>   
>>   	return ret;
>>   }
>>
> 
> Looking at the code, I think it's still not enough, but feel free
> to correct me.
> 
> In ksz_setup(), in one single loop we do :
> 
> dsa_switch_for_each_user_port(dp, dev->ds) {
> 	ksz_pirq_setup();
> 
> 	ksz_ptp_irq_setup();
> }
> 
> However when anything fails in the above loop, we jump straight
> to out_pirq, which doesn't clean the ptpirq :(

Good catch, I should also merge together the out_ptpirq and out_pirq 
labels then. And ensure that the PTP IRQ is initialized before freeing it.

I'll respin with that.


Best regards,
Bastien


