Return-Path: <netdev+bounces-49589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9607F296A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDCA281635
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E623C094;
	Tue, 21 Nov 2023 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3797CFA
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 01:55:31 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8AxueqSflxlH4Q7AA--.42193S3;
	Tue, 21 Nov 2023 17:55:30 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxS9yNflxlJkxIAA--.27100S3;
	Tue, 21 Nov 2023 17:55:27 +0800 (CST)
Message-ID: <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
Date: Tue, 21 Nov 2023 17:55:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxS9yNflxlJkxIAA--.27100S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxArykur1DWr13tF17AF1xXrc_yoW5uFyUp3
	yUZa98Gr1ktr4fJw4xGan0vFyrX3y5tFyUC3WrWry3uay3u34a9rWjqFWjvF9xGa1kWa4f
	tr40k3WDCF90qacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Hi Andrew,

在 2023/11/12 04:07, Andrew Lunn 写道:
>> +#ifdef	CONFIG_DWMAC_LOONGSON
>> +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_AIE | \
>> +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
>> +#else
>>   #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
>>   				DMA_INTR_ENA_UNE)
>> +#endif
> The aim is to produce one kernel which runs on all possible
> variants. So we don't like to see this sort of #ifdef. Please try to
> remove them.

We now run into a tricky problem: we only have a few register 
definitions(DMA_XXX_LOONGSON)

that are not the same as the dwmac1000 register definition.


In this case, if we use these "#ifdef", it will reuse most of the 
dwmac1000 code to

reduce maintenance stress, at the cost of sacrificing a little 
readability; If we created

a new xxx_dma.h, it would add a new set of code similar to dwmac1000, 
which is exactly

what the v4 patch did, which was great for readability, but it also made 
the code more

maintenance stress, and we got reviews complaining in v4. That is, we 
need to find a

balance between readability and maintainability.


however， we haven't yet come up with a way to do both, so it would be 
great if you

could give us some advice on this.


v4:<https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>

>
>> @@ -167,7 +167,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>>   	int ret = 0;
>>   	/* read the status register (CSR5) */
>> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>>   
> Please break this patch up. Changes like the above are simple to
> understand. So have one patch which just adds these macros and makes
> use of them.
OK!
>
>>   #ifdef DWMAC_DMA_DEBUG
>>   	/* Enable it to monitor DMA rx/tx status in case of critical problems */
>> @@ -182,7 +182,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   		intr_status &= DMA_STATUS_MSK_TX;
>>   
>>   	/* ABNORMAL interrupts */
>> -	if (unlikely(intr_status & DMA_STATUS_AIS)) {
>> +	if (unlikely(intr_status & DMA_ABNOR_INTR_STATUS)) {
> However, this is not obviously correct. You need to explain in the
> commit message why this change is needed.
>
> Lots of small patches make the understanding easier.

Because Loongson has two AIS, so:


#ifdef    CONFIG_DWMAC_LOONGSON
...
#define DMA_ABNOR_INTR_STATUS        (DMA_STATUS_TX_AIS_LOONGSON | 
DMA_STATUS_RX_AIS_LOONGSON)
...
#else
...
#define DMA_ABNOR_INTR_STATUS        DMA_STATUS_AIS
...
#endif

>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 7371713c116d..aafc75fa14a0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7062,6 +7062,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>>   	/* dwmac-sun8i only work in chain mode */
>>   	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
>>   		chain_mode = 1;
>> +
>>   	priv->chain_mode = chain_mode;
> Please avoid white space changes.

OK!


Thanks for your review!


Thanks,

Yanteng

>
>         Andrew


