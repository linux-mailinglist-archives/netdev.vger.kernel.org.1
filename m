Return-Path: <netdev+bounces-284977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPfIHmF++2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:46:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DD24DEF8F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C4730177BA
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FE4BCAD9;
	Wed,  6 May 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="A/tWM9I+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBB44E044
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089478; cv=none; b=Wo0ddml19uw5CrYsTsWE78CS9+c4LC/Jce25igKhpwsovWng7gd5tOysLuNUieYeym05t729dd6U4C0hyUSUwcneZosAX6hFAkhZvBukWlEZ3kMecQdbvTqLUJwEKhAIuv3e6DhtFeKUhV5CAeHo1s1mhJ3Z6yr28Nirc9wZyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089478; c=relaxed/simple;
	bh=/YjFQWxNpMQZ2f2KytppViSRzU0yZJvUee9ryGQwSOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeGTMQSVS0xLtoITtsTftjaz8SQMsBZR1HRE2fsX5Ro/1HGdZObbdsCuAVQTNBeXsgUUOuHH8edaqm0AL5TV2/jBdkTdiwrqVPFut7PkItpCKtuVjxMq5Rlww8rycDtw2cKaJBGjnQo0HasmLy2PQ8nF3Ri9PNLFBzukOceVbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=A/tWM9I+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8eae9229110so1064530685a.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778089473; x=1778694273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6wXO6STmxH+YsbEuPXhWzzsM6OvvesRxD9MxXwGEOY=;
        b=A/tWM9I+MidkfGgsZV3URMJGGeCgr+x0pwX/vDmp9qjFxG3qTM0C7yaPymIneMJsak
         00eo6ukEIws+rAbKxilEt8PE3bBQl/bdeIR843LD5oyHIoQlulo6XQ2P7r5eu8hR4feO
         KEVy7WEU2p/Ey/PiAiRMaz+tmrsQkdVuICkapNuYK1QpbWLQoF14Yl0qTNN55VLq3nHj
         tbr9KV5I1Xt75WkkNjVUdlujZzYhGTnfDX4KghuHirRo+pcUytReOCCL8DveJ7DESIQB
         UXqEHuL//GRfLjdNZXXg54F1QEu0gFapghqGj2IZcfZ9iImftmoCfFv33sIOaKewB+a6
         47XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089473; x=1778694273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6wXO6STmxH+YsbEuPXhWzzsM6OvvesRxD9MxXwGEOY=;
        b=Ud3+fM6Qw/0aniMiwVTahiUFzfwz58OuDrQVHfK/jSiOHdAmw/i367TGoCMwX5B0DZ
         RcWKBmDum38wTbSz/SkRayBVHmmctm+PLEvpiiGjls5ZRwyvM+GyWCm2XvmKim5fxjKh
         y60YTaZfzbX3mmDklS0uDJ9y4hF0PdcivROQdBFAAvrF7oqQs5BRR2fteq7RBmWGBhrp
         t8l9YNyOnC2tvpGJXt0SYSZ4RaFUKmfWjLB2mlNlvm/0d6Aw/MjdQsHeaz0YQdTQ9jKk
         xknhJa7QG/cIodd1poCno1p0JqNbMyj0Z03sq4zMdGoMlcpwUtuAIA6RJ7ffMbANkv9h
         B9Xg==
X-Forwarded-Encrypted: i=1; AFNElJ++AZAd4qUj0oxY07XoG7kYOL99F0Lk/SsCK+ogftzI4oYcL3nhhw9wF37iN1SKVNfHUeP5ziw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVb0o86OWAxXxcbxGMDFgeAM+BWooE6AXd6j0Gi/HAN/mbWLy
	Jqzd2c386HQAlSFmHNvBfsZt3FUwRiu21kOInFKtDLUJ86SWOQopaXUhObveUTPK95w=
X-Gm-Gg: AeBDies1CMA/tf3KqNOgZ58hyUgMouZyLnV1CZ7Cb7RS5BayT6hj4el4Vsv+FUgv09x
	nw5PZYek/e8pU+fC/IFLPyqAci1oJU+O4hSsgWbERwns0rJwLghQf+ieLEPh/5J5tfKlThU4ICu
	S0IadQk44vSH9wnPzeoYalL3OysUKMp/IxVdwYhhAcl9o/0K3vGR60OwvG4IbTQLFsTGHJnaYHm
	YT2SbpLoHUjl9zdER4oTrBXloTiBtSMksGoLDumi4UPQDkPyFENjm8KkYkVEWoTYmj33krVrjb4
	OqrZ42yHTeoVXIeAZyyMdmCXc9wYyB+4R7YZZf0gWGFgUjof60zIcqhM7XmCdnCICnJOSICSvO6
	QDGSYF2MCc28Wfs4eR54sh7fitnl+xCbKLzlTiIalBmwaj0CBrXTLFDdWMFvkvkS5FqFIe1psZG
	y+9EoHkKDyggS2Ts0Pmx+iZvHMkpuG/f9nZSxlbZxYrfTstApjjt40HMuR9lmZ9vr36Zwf1dt09
	w==
X-Received: by 2002:a05:620a:f0c:b0:8f1:9e59:220e with SMTP id af79cd13be357-904d63e7a90mr642596485a.39.1778089473124;
        Wed, 06 May 2026 10:44:33 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm1736572285a.34.2026.05.06.10.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 10:44:32 -0700 (PDT)
Message-ID: <7f3a0f16-5159-4bbc-8b15-9b5841603bf6@riscstar.com>
Date: Wed, 6 May 2026 12:44:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Xilin Wu <sophon@radxa.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, matthew.gerlach@altera.com,
 mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <DD71CDEABC7C16D5+02d052ff-13bb-4712-a847-91416f76c578@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3DD24DEF8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284977-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:mid,riscstar.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

On 5/5/26 9:30 PM, Xilin Wu wrote:
> On 5/1/2026 11:54 PM, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
>> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
>> that can be accessed, along with several other peripherals, via two
>> PCIe endpoint functions. There is a main driver for the endpoint that
>> decomposes things and creates auxiliary bus devices to model the SoC.
>>
>> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
>> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
>> MSIs.
>>
>> Add a driver for the eMAC/MSIGEN combination.
>>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  13 +
>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +
>>   .../ethernet/stmicro/stmmac/dwmac-tc956x.c    | 791 ++++++++++++++++++
>>   include/soc/toshiba/tc956x-dwmac.h            |  84 ++
>>   4 files changed, 890 insertions(+)
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/ 
>> net/ethernet/stmicro/stmmac/Kconfig
>> index e3dd5adda5aca..66bcfaccbe21f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -404,6 +404,19 @@ config DWMAC_MOTORCOMM
>>         This enables glue driver for Motorcomm DWMAC-based PCI Ethernet
>>         controllers. Currently only YT6801 is supported.
>> +config DWMAC_TC956X
>> +    tristate "Toshiba TC956X DWMAC support"
>> +    depends on PCI
>> +    depends on COMMON_CLK
>> +    depends on TOSHIBA_TC956X_PCI
>> +    default m if TOSHIBA_TC956X_PCI
> 
> Hi Alex,
> 
> I think GENERIC_IRQ_CHIP should be selected here.

Yes there are a number of things missing in the Kconfig definitions
and I'm working through them this week.  And yes, since we use
irq_generic_chip_ops we must ensure CONFIG_GENERIC_IRQ_CHIP is
enabled here.

> Thank you for the driver.

Thank you for your feedback (this and others I see).

					-Alex



