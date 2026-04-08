Return-Path: <netdev+bounces-276459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNo0JjBB1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:51:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E803BB759
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39F87301579D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF87738C434;
	Wed,  8 Apr 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J95HISEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2A377003
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649069; cv=none; b=T76gIrplf+32eNJUmlSAe9iQBW090P9CRf9k+YTlwHtd2WhJy8hwRaB0Gy7jcWlqGDLTCIo/0nDv0S2Uow8V0h5xwLKrL2uca0PoTabJG2w7JI7WpRCcWFYglIJtTUeU4N25h8dWzeqw/C86KQrnQ+TrSy5SeFdVYNCwA/MQcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649069; c=relaxed/simple;
	bh=X58ciQKprArFwD51+U6hqe12tyByg+hkvzjFAJm9gMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KabpA/IkNce3VCEG0tkyzYGT7uvPHoxeO8+CZX7gsoa1GtF7P2xRpuVkU/3omcZ7eqVVhAjgWMdtm4TlRVYAOb5MXMwhPEqG8C/oZGIaF8957aUVY6Af3i/bXk/f1w/sEcy5hGMWaTzNKCKZgQUDzC8e1zf/Oku4S28oF+ZeyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J95HISEd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso32633845e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649067; x=1776253867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW6UoyfUV2pgEC2VeAz88BmtH42V9gawKLQgrG0Az5I=;
        b=J95HISEdWw6t+iJ+mITeniNClchl/Jyfb0sagdeL6341DO3/HKthy1wJYZGyP2DL1I
         jqIdE49s0hTSXXFefU5wVgC5Z+ojL8aQ3T85Pze3nyhYGWbHq6PV1d/yjiVqj7J2Hn1Z
         SI2qyOi0G1RsD2K8lrEC5uoOoqYbJOoTrBeBhIXeL8yGDnDDSJXpM04I8kdr4DjNmx1S
         9ZWF5RGMik1Sx28zvKSrdn0YDE57fZAf3LUkauB0/IALjWiM0F99IRIOJI6fhWEgyUZK
         uL4jT6/6jazUT6h5k/iixHGDP2t6UfkDs55qH30FJJet8b/pEm5FJoZefi8E41hIU+I2
         oRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649067; x=1776253867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW6UoyfUV2pgEC2VeAz88BmtH42V9gawKLQgrG0Az5I=;
        b=gncmONALXhSlpVN+7qCj1awttQPU/hhCoQtlo0pq+ITA213dyW1cWzAiJ3zWcBkbFK
         VABDaknqX7OoWympw3DZlQ5u9tR52CQXvCQpA+7SAF6v/AART94kSY6Z4DqLcckKY6Oj
         bjHvRnhiurknwZBqhZsi8Vn8dCdPpU6Wk9drcdErjmwASH/8zrhPtUektiAUwR0ZRfg4
         OMag+nvkXGKq4mixyWwLrL5+UnPxuwYewQbXKRiDDm7q5mERlzaU9EoN+N+3/QWJsu86
         QewS8jmR9fqAlU0hw/4KPsAmEFKRnLWBqfRr3Q+y/vz9AbM7DvmZd1Ifjc/cWRjmIciS
         f64A==
X-Forwarded-Encrypted: i=1; AJvYcCXaXZTxokASfhPRVy8tsbYTz4OcklT3BIGIhqjzxkU46BRYXpJi72KU/vKMXy+/iV+1YCMAUV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLkrhUKCZpf1brh1Xbe6OQVv41S0wNSCI9W6I9JMK6UgL3VVq
	GWKJDNSyPwjwe8c1xUbyOTti9dK8Bu/4UbITdaoKd+RjTH8rPt0fITzl
X-Gm-Gg: AeBDieugXZciafEx0HJ0XejGWF1YchRSMBi9nVxXJGv4WoUOUBInRFTH0ESqf3o2E6J
	96DymTkaEDZ6OEKbg2QokyV0o/c3kXLkpv0aEmPZ4nWSo5s4sRof8X6Ir16kbEiQuS6tlw2/2IA
	4zQpGuUsfLecI+ne/ht3v8yzkPElN98l4KiaAHFO6dzZlcBmBx84m2H42OPE/Q4lAPWT3YSa3OB
	9wbb+zzNr0Y2wpcr5oZH205e3Qav42CmpsFR+y/qzkRyAhSqWrbjbRiD3vBvAkM4kCCyXyf//Kh
	OYuZPMhGH6577ZDxePk/c9v01Xhb2iV8NLhKrYnVpsVCLpQyx0WWfwEN05h/eBSU3XEaxX3slVr
	wTzZZ+FxGF6szsaOva/FMeefVHnXkviIUSTzQ9X/xuMWDq3aFQOuMcBSiRNuktK3Khg116sxdX1
	+PuhGzkrbqnrFAHAdlXUYNl/Q68pXRNURq6GmsLMlgUy9cFF73CP+bTSDchZBO2rJnprqShucvl
	iyVONZb2A==
X-Received: by 2002:a05:600c:3549:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488997d2ccemr267423825e9.23.1775649066543;
        Wed, 08 Apr 2026 04:51:06 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dd1c81sm17369545e9.33.2026.04.08.04.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 04:51:05 -0700 (PDT)
Message-ID: <1296ca80-f783-4584-b953-f92f6594c39f@gmail.com>
Date: Wed, 8 Apr 2026 13:50:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <ab6a06c1-2d7d-4032-8d38-063470cd45c0@lunn.ch>
 <fe14415a-52fa-42cc-9e4c-e3876588d513@gmail.com>
 <c235ee5c-6057-4c10-9960-9c5a3527bf22@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <c235ee5c-6057-4c10-9960-9c5a3527bf22@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24E803BB759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 16:45, Andrew Lunn wrote:
> On Fri, Apr 03, 2026 at 11:43:24AM +0200, Fidelio LAWSON wrote:
>> On 3/26/26 13:18, Andrew Lunn wrote:
>>>> +	mutex_lock(&dev->alu_mutex);
>>>> +
>>>> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
>>>> +
>>>> +	if (!ret)
>>>> +		ret = ksz_write8(dev, 0x6F, indir_reg);
>>>> +
>>>> +	if (!ret)
>>>> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
>>>> +
>>>> +	mutex_unlock(&dev->alu_mutex);
>>>
>>> What address space are these registers in? Normally workarounds for a
>>> PHY would be in the PHY driver. But that assumes the registers are
>>> accessible from the PHY driver.
>>>
>>> 	   Andrew
>>
>> Hi Andrew,
>> These registers belong to the KSZ87xx switch address space, accessed through
>> the switch’s indirect access mechanism. In particular, the offsets used here
>> correspond to entries within the TABLE_LINK_MD_V indirect table of the
>> KSZ8-family switches.
> 
> So this errata is for ksz87xx only?
> 
> For this PHY, do all PHY register reads and writes go through
> 
> https://elixir.bootlin.com/linux/v6.19.11/source/drivers/net/dsa/microchip/ksz8.c#L957
> ksz8_r_phy()
> 
> and
> 
> https://elixir.bootlin.com/linux/v6.19.11/source/drivers/net/dsa/microchip/ksz8.c#L1221
> ksz8_w_phy()?
> 
> We already have some "interesting" things going on in these
> functions. PHY_REG_LINK_MD and PHY_REG_PHY_CTRL are not standard C22
> PHY registers. They take the values 0x1d and 0x1f. The 802.3 standard
> defines 0x10-0x1f as vendor specific, so this is O.K.
> 
> So you could define 2 bits in say register 0x1c to indicate the errata
> mode. You can have a PHY tunable which does reads/writes to these two
> bits, and ksz8_w_phy/ksz8_r_phy which translates them to indirect
> register accesses?
> 
> It is not even really violating the layering.
> 
> 	 Andrew

Hi Andrew,

Thanks a lot for the feedback, it was very helpful.

Yes, the erratum affects KSZ87xx devices only, and all accesses to the 
embedded PHYs indeed go through ksz8_r_phy() / ksz8_w_phy(), as you 
pointed out.
I followed your suggestion and reworked the implementation accordingly: 
the errata selection is now modeled as a vendor‑specific Clause 22 PHY 
register (0x1c), handled entirely in ksz8_r_phy() / ksz8_w_phy(), which 
translate reads and writes into the appropriate indirect TABLE_LINK_MD_V 
accesses. This keeps the PHY‑facing API clean without breaking the layering.
I’ve dropped the DT approach and adjusted the implementation based on 
the review comments. I’m sending a v2 with these changes shortly.

Thanks again for the guidance.
Best regards,
Fidelio


