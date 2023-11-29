Return-Path: <netdev+bounces-52093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA57FD422
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC948B20AAD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2F1B287;
	Wed, 29 Nov 2023 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825A1D73
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:30:08 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8CxtPCtEmdlu6E9AA--.58038S3;
	Wed, 29 Nov 2023 18:30:05 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvdyoEmdlArpPAA--.45770S3;
	Wed, 29 Nov 2023 18:30:00 +0800 (CST)
Message-ID: <b8c66153-1c2a-44d7-93f8-de34800d7b55@loongson.cn>
Date: Wed, 29 Nov 2023 18:29:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
 <2e1197f9-22f6-4189-8c16-f9bff897d567@lunn.ch>
 <df17d5e9-2c61-47e3-ba04-64b7110a7ba6@loongson.cn>
 <9c2806c7-daaa-4a2d-b69b-245d202d9870@lunn.ch>
 <8d82761e-c978-4763-a765-f6e0b57ec6a6@loongson.cn>
 <7dde9b88-8dc5-4a35-a6e3-c56cf673e66d@lunn.ch>
 <3amgiylsqdngted6tts6msman54nws3jxvkuq2kcasdqfa5d7j@kxxitnckw2gp>
 <4f9a4d75-7052-4314-bbd1-838a642b80ab@loongson.cn>
 <gbwyupdmey4qiabqtpkqryufsme3dx5wxs3gp3snamijfkzyda@7r2av5z7szs6>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <gbwyupdmey4qiabqtpkqryufsme3dx5wxs3gp3snamijfkzyda@7r2av5z7szs6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxvdyoEmdlArpPAA--.45770S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFW7uw1rAF18XF1DJrW8uFX_yoWxuF4fpa
	yUCayjkr4ktr48Jw1Iya15XFy5trWFyFWjgr4rWr15ua909w1rArWxKF4fuFy5XFWkGa4I
	yr48C3Z8uFyDZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2023/11/27 19:32, Serge Semin 写道:
> Yanteng
>
> On Sun, Nov 26, 2023 at 08:25:13PM +0800, Yanteng Si wrote:
>> 在 2023/11/25 00:44, Serge Semin 写道:
>>> On Fri, Nov 24, 2023 at 03:51:08PM +0100, Andrew Lunn wrote:
>>>>> In general, we split one into two.
>>>>>
>>>>> the details are as follows：
>>>>>
>>>>> DMA_INTR_ENA_NIE = DMA_INTR_ENA_NIE_LOONGSON= DMA_INTR_ENA_TX_NIE +
>>>>> DMA_INTR_ENA_RX_NIE
>>>> What does the documentation from Synopsys say about the bit you have
>>>> used for DMA_INTR_ENA_NIE_LOONGSON? Is it marked as being usable by IP
>>>> integrators for whatever they want, or is it marked as reserved?
>>>>
>>>> I'm just wondering if we are heading towards a problem when the next
>>>> version of this IP assigns the bit to mean something else.
>>> That's what I started to figure out in my initial message:
>>> Link: https://lore.kernel.org/netdev/gxods3yclaqkrud6jxhvcjm67vfp5zmuoxjlr6llcddny7zwsr@473g74uk36xn/
>>> but Yanteng for some reason ignored all my comments.
>> Sorry, I always keep your review comments in mind, and even this version of
>> the patch is
>>
>> largely based on your previous comments. Please give me some more time and I
>> promise
>>
>> to answer your comments before the next patch is made.
>>
>>> Anyway AFAICS this Loongson GMAC has NIE and AIE flags defined differently:
>>> DW GMAC: NIE - BIT(16) - all non-fatal Tx and Rx errors,
>>>            AIE - BIT(15) - all fatal Tx, Rx and Bus errors.
>>> Loongson GMAC: NIE - BIT(18) | BIT(17) - one flag for Tx and another for Rx errors.
>>>                  AIE - BIT(16) | BIT(15) - Tx, Rx and don't know about the Bus errors.
>>> So the Loongson GMAC has not only NIE/AIE flags re-defined, but
>>> also get to occupy two reserved in the generic DW GMAC bits: BIT(18) and BIT(17).
>>>
>>> Moreover Yanteng in his patch defines DMA_INTR_NORMAL as a combination
>>> of both _generic_ DW and Loongson-specific NIE flags and
>>> DMA_INTR_ABNORMAL as a combination of both _generic_ DW and
>>> Loongson-specific AIE flags. At the very least it doesn't look
>>> correct, since _generic_ DW GMAC NIE flag BIT(16) is defined as a part
>>> of the Loongson GMAC AIE flags set.
>> We will consider this seriously, please give us some more time, and of
>> course, we
>>
>> are looking forward to your opinions on this problem.
>>
>>
>> I hope you can accept my apologies, Please allow me to say sorry again.
> Thanks for your response. No worries. I keep following this thread and
> sending my comments because the changes here deeply concerns our
> hardware. Besides the driver already looks unreasonably
> overcomplicated and weakly structured in a lot of aspects. I bet
> nobody here wants it to be having even more clumsy parts. That's why
> all the "irritating" comments and nitpicks.
I get it.
>
> Anyway regarding the Loongson Multi-channels GMAC IRQs based on all
> your info in the previous replies I guess what could be an acceptable
> solution (with the subsystem/driver maintainers blessing) is something
> like this:

Okay, thank you, I will try them one by one and report the results in time.


Thanks for your advice！


Thanks,

Yanteng

>
> 1. Add new platform feature flag:
> include/linux/stmmac.h:
> +#define STMMAC_FLAG_HAS_LSMC			BIT(13)
>
> 2. Update the stmmac_dma_ops.init() callback prototype to accepting
> a pointer to the stmmac_priv instance:
> drivers/net/ethernet/stmicro/stmmac/hwif.h:
> 	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
> 		     struct stmmac_dma_cfg *dma_cfg, int atds);
> +drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c ...
> +drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c ...
> +drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c ...
> +drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c ...
> !!!+drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c ...
>
> 3. Add the IRQs macros specific to the LoongSon Multi-channels GMAC:
> drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
> +#define DMA_INTR_ENA_LS_NIE 0x00060000	/* Normal Loongson Tx/Rx Summary */
> #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
> ...
>
> +#define DMA_INTR_LS_NORMAL	(DMA_INTR_ENA_LS_NIE | DMA_INTR_ENA_RIE | \
> 				DMA_INTR_ENA_TIE)
> #define DMA_INTR_NORMAL		(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
> 				DMA_INTR_ENA_TIE)
> ...
> +#define DMA_INTR_ENA_LS_AIE 0x00018000	/* Abnormal Loongson Tx/Rx Summary */
> #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
> ...
> define DMA_INTR_LS_ABNORMAL	(DMA_INTR_ENA_LS_AIE | DMA_INTR_ENA_FBE | \
> 				DMA_INTR_ENA_UNE)
> #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
> 				DMA_INTR_ENA_UNE)
> ...
> #define DMA_INTR_LS_DEFAULT_MASK	(DMA_INTR_LS_NORMAL | DMA_INTR_LS_ABNORMAL)
> #define DMA_INTR_DEFAULT_MASK		(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
>
> etc for the DMA_STATUS_TX_*, DMA_STATUS_RX_* macros.
>
> 4. Update the DW GMAC DMA init() method to be activating all the
> Normal and Abnormal Loongson-specific IRQs:
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:
> 	if (priv->plat->flags & STMMAC_FLAG_HAS_LSMC)
> 		writel(DMA_INTR_LS_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
> 	else
> 		writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
>
> 5. Make sure your low-level driver sets the STMMAC_FLAG_HAS_LSMC flag
> in the plat_stmmacenet_data structure instance.
>
> Note 1. For the sake of consistency a similar update can be provided
> for the dwmac_enable_dma_irq()/dwmac_disable_dma_irq() methods and
> the DMA_INTR_DEFAULT_RX/DMA_INTR_DEFAULT_TX macros seeing your device
> is able to disable/enable the xfer-specific summary IRQs. But it
> doesn't look like required seeing the driver won't raise the summary
> IRQs if no respective xfer IRQ is enabled. Most importantly this
> update would add additional code to the Tx/Rx paths, which in a tiny
> bit measure may affect the other platforms perf. So it's better to
> avoid it if possible.
>
> Note 2. The STMMAC_FLAG_HAS_LSMC flag might be utilized to tweak up
> the other generic parts of the STMMAC driver.
>
> Noet 3. An alternative to the step 3 above could be to define two
> additional plat_stmmacenet_data fields like: dma_def_intr_mask,
> dma_nor_stat, dma_abnor_stat, which would be initialized in the
> stmmac_probe() method with the currently defined
> DMA_INTR_DEFAULT_MASK, DMA_NOR_INTR_STATUS and DMA_ABNOR_INTR_STATUS
> macros if they haven't been initialized by the low-level drivers.
> These fields could be then used in the respective DMA IRQ init and
> handler methods. I don't know which solution is better. At the first
> glance this one might be even better than what is described in step 3.
>
> Note 4. The solution above will also cover the Andrew's note of having
> the kernel which runs on all possible variants.
>
> -Serge(y)
>
>>
>> Thanks for your review!
>>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>> 	Andrew


