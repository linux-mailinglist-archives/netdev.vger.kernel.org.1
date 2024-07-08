Return-Path: <netdev+bounces-109746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F9929D22
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678E21C20C83
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0867328B6;
	Mon,  8 Jul 2024 07:31:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF211862A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423903; cv=none; b=qcJXLqnLcs3kYcGtAGADPe1z3jp6mIfzUznEEtr82L27WdvCCwd95B1deJSqYrRtZcFG4aL8lqYX3P1BXnS91wf7GY2tjKMSrty7+jQpbsJLTIBYZpmsLVts4FQziBwUzboUjFQRYLB2q8xTZ8QyNUH0DqnDMpAdL8OnZtMBVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423903; c=relaxed/simple;
	bh=eRGWnBw3MLYCpyPq8Z0dl5fJkHCqvVJgi0g+cZfe4Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOuKhv7hYtjHVi4xAx7TGs+cVCICvdYJr+VhmKULXJqYBbADeXJUCTNOvWLUTYmxNvsJKMRWbi/DCNxDyNXp5PiCOVKi9Ij9plEsJo1DOGERmJ2ub/GxJ3fmZHh+AXSynl0c6p6eoRr2BzMk1p+3oWOjjuvMKRQsaFwtlrV3z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8DxvuvWlYtmFu4BAA--.5777S3;
	Mon, 08 Jul 2024 15:31:34 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRcXRlYtmm10_AA--.3150S3;
	Mon, 08 Jul 2024 15:31:31 +0800 (CST)
Message-ID: <036f740c-480c-425d-82b4-2e21522524d7@loongson.cn>
Date: Mon, 8 Jul 2024 15:31:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
 <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>
 <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
 <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn>
 <CAAhV-H6ZzBJHNqGApXc-5wiCt9DqM51TMkC2zmj5xhoC-rfrnA@mail.gmail.com>
 <d7s5plkdd2ihxlhnvpds2r4dywivkfkszew567uevzkfv56ae2@r3p6asvdyu3j>
 <CAAhV-H6A_=5MjC1iriO2fHbvamLXkcn9susXxpru2LN5Qu0xLA@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H6A_=5MjC1iriO2fHbvamLXkcn9susXxpru2LN5Qu0xLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxRcXRlYtmm10_AA--.3150S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4xGrW8XF1kGFWDXr4DJrc_yoW5Ar1xpr
	yUZFWjkF4kAF1ftryvya1Ygr1Yy3s2qr4UXrn0gw48GF9F9ry7JrykKF45CFyjkr1DJw1j
	vFWIqF9rWFy5JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/7/7 21:57, Huacai Chen 写道:
> On Sun, Jul 7, 2024 at 6:51 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>> On Sat, Jul 06, 2024 at 06:36:06PM +0800, Huacai Chen wrote:
>>> On Sat, Jul 6, 2024 at 6:31 PM Yanteng Si <siyanteng@loongson.cn> wrote:
>>>>
>>>> 在 2024/7/5 20:17, Serge Semin 写道:
>>>>> On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
>>>>>>>>> But if you aren't comfortable with such naming we can change the
>>>>>>>>> macro to something like:
>>>>>>>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
>>>>>>>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
>>>>>>>> is a little better?
>>>>>>>>
>>>>>>> Well, I don't have a strong opinion about that in this case.
>>>>>>> Personally I prefer to have the shortest and still readable version.
>>>>>>> It decreases the probability of the lines splitting in case of the
>>>>>>> long-line statements or highly indented code. From that perspective
>>>>>>> something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
>>>>>>> the driver currently don't have such cases, we can use any of those
>>>>>>> name. But it's better to be of such length so the code lines the name
>>>>>>> is utilized in wouldn't exceed +80 chars.
>>>>>> Okay.
>>>>>>
>>>>>> I added an indent before 0xXX and left three Spaces before the comment,
>>>>>>
>>>>>> which uses huacai's MULTICHAN and doesn't exceed 80 chars.
>>>>> I meant that it's better to have the length of the macro name so
>>>>> !the code where it's utilized!
>>>>> wouldn't exceed +80 chars. That's the criteria for the upper length
>>>>> boundary I normally follow in such cases.
>>>>>
>>>> Oh, I see!
>>>>
>>>> Hmm, let's compare the two options:
>>>>
>>>> DWMAC_CORE_LS_MULTI_CH
>>>>
>>>> DWMAC_CORE_LS_MULTICHAN
>>>>
>>>> With just one more char, the increased readability seems to be
>>>> worth it.
>>> If you really like short names, please use DWMAC_CORE_MULTICHAN. LS
>>> has no valuable meaning in this loongson-specific file.
>> At least some version of the Loongson vendor name should be in the
>> macro. Omitting it may cause a confusion since the name would turn to
>> a too generic form. Seeing the multi DMA-channels feature is the
>> Synopsys invention, should you meet the macro like DWMAC_CORE_MULTI_CH
>> in the code that may cause an impression that there is a special
>> Synopsys DW MAC ID for that. Meanwhile in fact the custom ID is
>> specific for the Loongson GMAC/GNET controllers only.
> Well,
> I prefer
> DWMAC_CORE_LOONGSON_MULTI_CHAN / DWMAC_CORE_LOONGSON_MULTICHAN /
> DWMAC_CORE_LOONGSON_MCH / DWMAC_CORE_MULTICHAN,
> But I also accept DWMAC_CORE_LS_MULTI_CHAN / DWMAC_CORE_LS_MULTICHAN,
> But I can't accept DWMAC_CORE_LS2K2000.
>
I'll use DWMAC_CORE_LS_MULTICHAN for now, Let's continue discussing

this macro in v14 (If necessary).


Thanks,

Yanteng


