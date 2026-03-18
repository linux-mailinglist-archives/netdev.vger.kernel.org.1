Return-Path: <netdev+bounces-268942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL0rLJVyumkeWwIAu9opvQ
	(envelope-from <netdev+bounces-268942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D42B934F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E953D3035F54
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608EF3B3BE0;
	Wed, 18 Mar 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzfFJ1wr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19253B38AD
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826019; cv=none; b=Uxfft356HzyKti2X3gYtJTFwixOfoGQUAREFAq7Jf6OJ9obxjK8ehlaTWsxTG3lhjynoVXgN/koZ2a2f8KA1zols0lq/oXYHgyo3RG6GtSxrgZN+iJML2tr34skv1PIY5omqS7WoAw/933eourAnpoLmCDy0a+HJc7uPDvNO1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826019; c=relaxed/simple;
	bh=pz0q01S8narva8pSOcKufNnzDN4305jWST9PjoGQOBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVWlm98a6gPBLPUnuTYwpu/PpuQJf9rj7BoSsVArfOPzsR3zMoNf3Kip0Sd6JtXfoDD0YxqlUDZSpRvLVQJuYI1GWljWQlEYeLH1159OHYDbRbqODvLM7uyX47451TvJLNHW/CL2cpUfln1upJ0gcG9rOOUjf53tWp0di8jpys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MzfFJ1wr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 29B8F1A2EA2;
	Wed, 18 Mar 2026 09:26:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0C256004F;
	Wed, 18 Mar 2026 09:26:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65D9F1045072B;
	Wed, 18 Mar 2026 10:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773826014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YGHVlireFv0kkvh//K8T0VMZj4wyfyXl5yA1YI71+Fs=;
	b=MzfFJ1wrF8TJMxXfmlSfod7fsvYCeFQmaqdSC+D8ieivW0IalEGChWhzIY9Kf5/4AnT4p3
	hbdLzctwOWh3tXqVJa6doKR4ddO/h/jQ8O+dzhkLnBHr6IdjD3fzPhTI/nO9DfEY4K6bps
	wg4mnULH8NAdBnsEBSvYPOwI7ec2pzCIlzr6hRFszEg8yLdYWsdtpg7rd6MfdELzjJBLBR
	RgW8Vj2ug4LOYq/o8hLLWGjV9DkXRgPRRvSqWo6gadIAHdYrSgs8DrEDrL/A/dSABkPKGj
	xkOotSXms+474IQ4ojkBskjjCYrLZLECZfmbe+TlkAriUHgzmUkHyRuaFap35Q==
Message-ID: <0495251f-79d4-49e8-8829-60e3ad105093@bootlin.com>
Date: Wed, 18 Mar 2026 10:26:49 +0100
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
References: <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20260312134526.3lnifstvb5dpghrg@skbuf>
 <20260313153849.qkfzv5c2u6fepjku@skbuf>
 <DM3PR11MB8736ECCCE15258C04287889EEC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <DM3PR11MB8736ECCCE15258C04287889EEC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268942-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 707D42B934F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

On 3/13/26 6:29 PM, Tristram.Ha@microchip.com wrote:
>> On Thu, Mar 12, 2026 at 03:45:26PM +0200, Vladimir Oltean wrote:
>>> Thanks for the comment. I took a deeper look at the ksz_switch common
>>> driver and I've started working on some patches. I'll return when
>>> they're more or less ready.
>>
>> So if the common ksz_switch were to remain preferable, we still have the
>> problem that it's very cluttered/abstract and impossible to follow and
>> ensure correctness/lack of regressions for other hardware.
>>
>> Bastien, Tristram, I've tried to address that very particular issue by
>> giving KSZ8463 its very own dsa_switch_ops structure, which it doesn't
>> have to share with anyone else.
>>
>> I have no hardware to test, but some patches are here:
>> https://github.com/vladimiroltean/linux/tree/ksz_separate_dsa_switch_ops
>>
>> Do you think this would be useful? For now I've created a common ksz8_setup(),
>> but it can be further split into whatever granularity is required for
>> ksz8463 to have its own IRQ domain operations.
>>>> One could conceivable walk this alternative route of having independent
>> per-family dsa_switch_ops and only call ksz_common.c when something is
>> truly common ad infinitum. We could use it to get rid of dev->info->regs[],
>> dev->info->xmii_ctrl1, etc. We could further give ksz8463 a separate
>> ksz_ptp_clock_register() implementation with different PTP operations,
>> to address Bastien's concern. I stopped at only 19 patches though :-/
>>
>> What do you think, is this direction something worth exploring? Does it
>> help with the PTP IRQ differences here?
> 
> What I did was to simulate the port interrupt mechanism used by KSZ9477
> and LAN937X switch families.  I think that does minimum disruption to the
> original code.  That new interrupt code also allows interrupt use for
> KSZ8863, KSZ8895, and KSZ8795.  I provided that code to Bastien to test.
> 

I took a look at Tristram's patches, they should work but I'm not a big 
fan of emulating other hardware behavior to fit the existing driver. I'd 
rather go with Vladimir's approach.

Thanks for these patches Vladimir, they provide a clear path forward for 
the remaining work. I'll rebase my work on top of them. I'll implement a 
ksz8463_setup() function to match the KSZ interrupt scheme before adding 
PTP support.

And, indeed, implementing a ksz8463_ptp_clock_register() should then 
make it easier to add the periodic output support I plan to implement 
afterwards.


Best regards,
Bastien


