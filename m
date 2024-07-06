Return-Path: <netdev+bounces-109621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF653929293
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EDF1F21FC6
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10633BB2E;
	Sat,  6 Jul 2024 10:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A15695
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261867; cv=none; b=OJdjxITXfoxkCj+5v5Hpqu8gZC4A4fjqfakGpmZLeydcaFjjuPXZ2w0qchkTDVxyHVhstPYo37gigF3CLMDeqd+Kbw3BfNRu+gU1LgLqZq5tA+8qq3byQMMsW59Z2JM7aHJjGNxEQIzUrG/9vbfWi0ZGic4lkbyiodjjAJGN3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261867; c=relaxed/simple;
	bh=whsptQZF/BtFJXLQIkT+DRFFTp9wScZLxTuuHa4S1Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUTqq1yGel4U8OQRFQRcU4bk1a9y1eAkYwxLP5CvcJ0+K+wXvMXCajELiIysg5pX5euiEJpkmwl20Gwmal+3inTKLZuKvnlPyB+Ygm7enC1mNNclRVpI8e6J1EPbJ0j/AgcsfIlm74ROJj/qXOyz/2U00vX79pDn1var0tzAiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8Bx3+veHIlm144BAA--.4722S3;
	Sat, 06 Jul 2024 18:30:54 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXcfdHIlm9kE9AA--.10840S3;
	Sat, 06 Jul 2024 18:30:53 +0800 (CST)
Message-ID: <2b819d91-8c2a-4262-9cbb-c10e520f10c9@loongson.cn>
Date: Sat, 6 Jul 2024 18:30:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, andrew@lunn.ch,
 hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
 <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
 <8652851c-a407-4e20-b3f3-11a8a797debf@loongson.cn>
 <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <kgysya6lhczbqiq4al6f5tgppmjuzamucbaitl4ho5cdekjsan@6qxlyr6j66yd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXcfdHIlm9kE9AA--.10840S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur4fXF43WF1UJw1rJFWrJFc_yoW8Xry5pr
	yjqFWDKws7CF4fK34vyr4YgryFqw1Sqr4UZF15Wr18GFZF934Ikryvkr4rCFyjvr1DJ3W2
	vFyFga9xCFy5JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2024/7/5 20:17, Serge Semin 写道:
> On Fri, Jul 05, 2024 at 08:06:32PM +0800, Yanteng Si wrote:
>>>>> But if you aren't comfortable with such naming we can change the
>>>>> macro to something like:
>>>>> #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
>>>> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
>>>> is a little better?
>>>>
>>> Well, I don't have a strong opinion about that in this case.
>>> Personally I prefer to have the shortest and still readable version.
>>> It decreases the probability of the lines splitting in case of the
>>> long-line statements or highly indented code. From that perspective
>>> something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
>>> the driver currently don't have such cases, we can use any of those
>>> name. But it's better to be of such length so the code lines the name
>>> is utilized in wouldn't exceed +80 chars.
>> Okay.
>>
>> I added an indent before 0xXX and left three Spaces before the comment,
>>
>> which uses huacai's MULTICHAN and doesn't exceed 80 chars.
> I meant that it's better to have the length of the macro name so
> !the code where it's utilized!
> wouldn't exceed +80 chars. That's the criteria for the upper length
> boundary I normally follow in such cases.
>
Oh, I see!

Hmm, let's compare the two options:

DWMAC_CORE_LS_MULTI_CH

DWMAC_CORE_LS_MULTICHAN

With just one more char, the increased readability seems to be
worth it.


Thanks,

Yanteng


