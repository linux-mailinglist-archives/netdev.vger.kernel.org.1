Return-Path: <netdev+bounces-50854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D957F74A5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FE01C20CB8
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C1286BB;
	Fri, 24 Nov 2023 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 175D510E7
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:14:23 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8Cx5_GuoWBl+5Q8AA--.54368S3;
	Fri, 24 Nov 2023 21:14:22 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+SroWBlRZ1LAA--.37806S3;
	Fri, 24 Nov 2023 21:14:20 +0800 (CST)
Message-ID: <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>
Date: Fri, 24 Nov 2023 21:14:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxE+SroWBlRZ1LAA--.37806S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF45WryrCrW7uw1rGw17Arc_yoW8Ar4fp3
	4UWayUKr48trs5Gw1Iya98Gr95Jr42ya48Ca15Ww1rW345Xw13CF4jkF1xZas8tFW8X3yx
	Ar40ka15ZrZ5Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RuWPUUUUU==


在 2023/11/22 11:39, Andrew Lunn 写道:
> On Tue, Nov 21, 2023 at 05:55:24PM +0800, Yanteng Si wrote:
>> Hi Andrew,
>>
>> 在 2023/11/12 04:07, Andrew Lunn 写道:
>>>> +#ifdef	CONFIG_DWMAC_LOONGSON
>>>> +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_AIE | \
>>>> +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
>>>> +#else
>>>>    #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
>>>>    				DMA_INTR_ENA_UNE)
>>>> +#endif
>>> The aim is to produce one kernel which runs on all possible
>>> variants. So we don't like to see this sort of #ifdef. Please try to
>>> remove them.
>> We now run into a tricky problem: we only have a few register
>> definitions(DMA_XXX_LOONGSON)
>>
>> that are not the same as the dwmac1000 register definition.
> What does DMA_INTR_ENA_AIE_LOONGSON do? This seems like an interrupt
> mask, and this is enabling an interrupt source? However, i don't see
> this bit being tested in any interrupt status register? Or is it
> hiding in one of the other patches?

In general, we split one into two.

the details are as follows：

DMA_INTR_ENA_NIE = DMA_INTR_ENA_NIE_LOONGSON= DMA_INTR_ENA_TX_NIE + 
DMA_INTR_ENA_RX_NIE

DMA_INTR_ENA_AIE = DMA_INTR_ENA_AIE_LOONGSON= DMA_INTR_ENA_TX_AIE + 
DMA_INTR_ENA_RX_AIE

DMA_STATUS_NIS = DMA_STATUS_TX_NIS_LOONGSON + DMA_STATUS_RX_NIS_LOONGSON

DMA_STATUS_AIS = DMA_STATUS_TX_AIS_LOONGSON + DMA_STATUS_RX_AIS_LOONGSON

DMA_STATUS_FBI = DMA_STATUS_TX_FBI_LOONGSON + DMA_STATUS_RX_FBI_LOONGSON


>
> This is where lots of small patches, with good descriptions helps.

Ok, thanks for your advice, I will try to split it in the next version.


Thanks,

Yanteng

>
>       Andrew


