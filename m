Return-Path: <netdev+bounces-106461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA59167E1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7451C2087E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFBE14A62F;
	Tue, 25 Jun 2024 12:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707573463
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318701; cv=none; b=E8HZwXsrvGt9AdcvGi1ow6aXhItNF68GKXfKMWSziSlrk/f8u2SuviFYEQ827dllj16WF4eDSsQ46j0SHkTG/7SJB1BHIK31l04kB0PQYpLfo3vAMIHWuGmpNc2Zd14HpQzhs1merLKmi7dzZZqC62iUOC3SLvUm9OyZVbX1qw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318701; c=relaxed/simple;
	bh=TzuoW8dWelFJHRi/shhiMtrIgy5O6r17Q7D4fSpNTD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFuEkS+GjQXEC6DleUEM4Or7p0A6ONPPN3s7UWkFWc+tC4i/l6bBgyP4WewhAd6Qw0ChYM+SpcKyfjbI9oMShmGVZE/Aj6TSC9bEO66ucHgWbxjF9S55uJXjQYTU6p3r03j29wqnGOA710ZGpsYJp6oS1leeUQNt7k4dhq3h/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8CxOuqnuHpmF+AJAA--.39308S3;
	Tue, 25 Jun 2024 20:31:35 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZcWkuHpmSYgwAA--.39505S3;
	Tue, 25 Jun 2024 20:31:33 +0800 (CST)
Message-ID: <55193345-f390-4fbb-b4e6-0bcd82cedc9a@loongson.cn>
Date: Tue, 25 Jun 2024 20:31:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
 <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>
 <xafdw4u5nqknn2qehkke5p4mrj4bnfh33pcmkob5gbl7y5apr4@pkwmf6vphxsh>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <xafdw4u5nqknn2qehkke5p4mrj4bnfh33pcmkob5gbl7y5apr4@pkwmf6vphxsh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZcWkuHpmSYgwAA--.39505S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1DuFyDur1kGrWkKFy3Awc_yoW5Xry7pr
	W0yFZrGryDG3WxJF1UtF45Ga40yrW7Ja4UZF1jq3W8J3s8ZwsIqF1Ivr4vgFyDXrZ7ZrWU
	Jr1qqF98Zw45JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/6/24 09:47, Serge Semin 写道:
> On Mon, Jun 17, 2024 at 06:00:19PM +0800, Yanteng Si wrote:
>> Hi Serge,
>>
>> 在 2024/6/15 00:19, Serge Semin 写道:
>>> On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
>>>> Loongson delivers two types of the network devices: Loongson GMAC and
>>>> Loongson GNET in the framework of four CPU/Chipsets revisions:
>>>>
>>>>      Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>>>> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>>>> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>>>> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>>>> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>>> You mentioned in the cover-letter
>>> https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
>>> that LS2K now have GMAC NICs too:
>>> " 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
>>>       channels, so we have to reconsider the initialization of
>>>       tx/rx_queues_to_use into probe();"
>>>
>>> But I don't see much changes in the series which would indicate that
>>> new data. Please clarify what does it mean:
>>>
>>> Does it mean LS2K2000 has two types of the DW GMACs, right?
>> Yes!
>>> Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
>>> enabled and 8 DMA-channels?
>> Yes!
>>> Seeing you called the new device as GMAC it doesn't have an
>>> integrated PHY as GNETs do, does it? If so, then neither
>>> STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
>>> for the new device, right?
>> YES!
>>> Why haven't you changed the sheet in the commit log? Shall the sheet
>>> be updated like this:
>>>
>>>       Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>>>    LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>>>    LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>>> +LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
>>>    LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>>>    LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>>>
>>> ?
>> No! PCI Dev ID of GMAC is 0x7a03. So:
>>
>>   LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a 1
>>   LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a 1
>> +LS2K2000 CPU         GMAC      0x7a03          v3.73a 8
>>   LS2K2000 CPU         GNET      0x7a13          v3.73a 8
>>   LS7A2000 Chipset     GNET      0x7a13          v3.73a 1
>>
>>> I'll continue reviewing the series after the questions above are
>>> clarified.
>> OK, If anything else is unclear, please let me know.
> Got it. Thanks for clarifying. I'll get back to reviewing the series
> tomorrow. Sorry for the timebreak.

OK. No worries.


Thanks,

Yanteng


>
> -Serge(y)


