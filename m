Return-Path: <netdev+bounces-271755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e+TSMTdfxGkuywQAu9opvQ
	(envelope-from <netdev+bounces-271755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:18:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516132CD52
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 23:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8E63064E28
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9639E183;
	Wed, 25 Mar 2026 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZB0+kL+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942F39769B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476682; cv=none; b=BRp61bHlH+Il2YNreX6qb78jtyNuKzb3diSuDBklb5XlFV1wmdMkwP+PXrztrDFu9SRvkzCCH9OGoqDVNnQD25qjCdDdqiBlQmjUemerGGN8nkN7vrBXw4Iy/nLOdKo+O7NpoE2H3J+iQBIZQDbk9pkhki26IfZieLJeVo9a+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476682; c=relaxed/simple;
	bh=zXKgry6IT7kKIlSxJ8aohxD9hL/rThgEOx2ispAOZfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUMSQ8/yb57Vb8mW7DZMgZyqDAet8CAeP7m1O43XEc/Ff0a35LxoF54aHJP/k4eS2gmw8dTKoqJle9zTgyevJXHYOYz4COpArzSiWQ3U8T9Gcn0qhwbfapyzSKcMot/7zFzIkvKhwLgWwZ59aBoncS9MAl/up2W1R+QHkoPanDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZB0+kL+Z; arc=none smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-463f00cda04so156647b6e.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774476680; x=1775081480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EsVKT/T0m3KfafHCDtG3SbO+x/uq+F3nuhtS5ZgxOo=;
        b=o0CzyeybGWKBUC+L3dMt4BihJkGrlXPrqOQzrFk4t00BbGDft7fTn975EIk7HH5XEm
         /ofWve0jyHtk7Z/jKtTEwreQaM2pBgJJ942uqMGrQiyz1ganzGIXZkJMypQA11S9sqJe
         JJJT3yzR03/7zdJyOAEo2LcbbRUJXaOSeu46da8RQZMSoJV8sVfeN2XWgNs5OUiRGFxt
         ALD20Yw2ITc9nQivoPfzYd6N6T5umFd6YdKtgjsyuZ2BSMMSS7CIIFw76Sb+KV1kxWOd
         wLc5967f7oTenzvwBmfgLvbt8EIH7JHZ/Z4YUFWASnNWaAZWBSbn5etbaqe5n7HiIEXE
         8yeA==
X-Forwarded-Encrypted: i=1; AJvYcCXzOL4MfQu/ETmsOKfnZBUhNuZ426qX4f/Y4PTm2GYNZv3Wi0dcRiFASIVPZdo5o8dqXEPz0P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/S3+ojf4p2x0AoTcTQEF6GJddRw/s7DHXuCpcLvl6BaJSYlG
	Qqtv+16OvuZHqAfwzbuhG6FSDao/HOmu/aa7VDpK1Veqw9v2aCXlUNMRSvgobmlwOPo4j3BIuV+
	YioeqTN/hzhsXySdiyYSlD+o/IrM3L6S/i5SHXtOXpp0u+t1+9dlOJ/IK9xGpIdSoEWHGHgAxab
	LJGcGhY5Kt+gAoW+MiA5TH7Piv4QelYOZiQ9/lWn2zBUwdHu0SKQErlAcCkLeBwxuvOaLIGJ05B
	F/tRA6W6w==
X-Gm-Gg: ATEYQzyE/yQM2rsBHPayGJ7zzUOf41X7v16nmWWWVDFY/tA+b31sZYskmzZixuS64Jz
	m5T6qjpjLuTCj+gjZpzMnk34Xn+vE9CVid0Hz2AYzVk5SBHwpfL6H6Y8jnFZ66OC7Fm4VquHU42
	X4Dh1w7HSgzNa1WcE/I55NgGH1tKXi/8T/zOT+MSvFkm8l1c7iMkWitTj1kWv06DeFbQf29AtH2
	L1qB7PfNPDpozwnm38w4DhKbOtKsuwFdSVkHGzYpRb0cxHzndqxGcBEcICMq3J8UCTeamusqpAA
	66rhtTrXjq+FOlvDn972GWEG3ZRYGV1Tid0Wway1pVkiA7VqY+CzmtIO9eVhidIkxAmC82svBbg
	OTyQI79J+Enyq5WT3iHioEHZZvGeGO1q0CnLK4f7mK0EE7tDhbbKBJn2Le0WYbYmN3e63cHYyjW
	iA7fX2Pu6CyiNiKai3lfNHLPKLIdz7UJYlyKcmZsEUW5njbUlTq5LFWZk=
X-Received: by 2002:a05:6871:42ce:b0:3e7:ecd7:b292 with SMTP id 586e51a60fabf-41ca70e9e9dmr3366968fac.46.1774476679726;
        Wed, 25 Mar 2026 15:11:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41cc7725677sm100601fac.4.2026.03.25.15.11.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:11:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-128d0b690feso1604702c88.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774476678; x=1775081478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EsVKT/T0m3KfafHCDtG3SbO+x/uq+F3nuhtS5ZgxOo=;
        b=ZB0+kL+Z1jH2tV9MW5nbNk3x1E7rqSskcuGKRwgBHvABIi1lXx0RJsYoC/MLRfVsBp
         2PMQMhfk2i8Cg5h2pF4Rve8GBezzU3UzFvJVDBAJHAeXZkzP8qVuovhTClmz71QcZhEv
         oxk4MU1hrp/K+l8UPnUxkFzVt4qSjnOYBjZKk=
X-Forwarded-Encrypted: i=1; AJvYcCXcXnqYn2pj6a3zZEk1NGJ58fmswZcW7errSz3CJxzBbwmntsppi/9Y60xJ3ZVH0IeyKX5huJo=@vger.kernel.org
X-Received: by 2002:a05:7022:4583:b0:127:5cda:fb7d with SMTP id a92af1059eb24-12a96e3eea9mr3158085c88.6.1774476678242;
        Wed, 25 Mar 2026 15:11:18 -0700 (PDT)
X-Received: by 2002:a05:7022:4583:b0:127:5cda:fb7d with SMTP id a92af1059eb24-12a96e3eea9mr3158066c88.6.1774476677640;
        Wed, 25 Mar 2026 15:11:17 -0700 (PDT)
Received: from [10.14.5.144] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6513e9bsm1912010c88.0.2026.03.25.15.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:11:17 -0700 (PDT)
Message-ID: <eb7b544f-7fde-4b3e-863c-633c04329edd@broadcom.com>
Date: Wed, 25 Mar 2026 15:11:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] net: bcmgenet: fix leaking and racing timeout
 handler
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com
References: <20260325173602.3676778-1-justin.chen@broadcom.com>
 <77801f99-517e-4b60-846a-f26469a7526a@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <77801f99-517e-4b60-846a-f26469a7526a@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271755-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1516132CD52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 3:00 PM, Florian Fainelli wrote:
> On 3/25/26 10:36, justin.chen@broadcom.com wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> The bcmgenet_timeout handler tries to take down all tx queues when
>> a single queue times out. This is over zealous and causes many race
>> conditions with queues that are still chugging along. Instead lets
>> only restart the timed out queue.
>>
>> While reclaiming the tx queue we fast forward the write pointer to
>> drop any data in flight. These dropped frames are not added back
>> to the pool of free bds. We also need to tell the netdev that we
>> are dropping said data.
>>
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> 
> The first bits in bcmgenet_tx_reclaim would be fixing:
> 
> Fixes: f1bacae8b655 ("net: bcmgenet: support reclaiming unsent Tx packets")
> 
> and the other part in bcmgenet_tx_timeout() would have:
> 
> Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
> 
> Both fixes look good to me:
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks. I will resend v2 as two patches once we get verification the 
patch is working as intended.

Justin

