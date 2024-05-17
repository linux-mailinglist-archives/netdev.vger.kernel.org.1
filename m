Return-Path: <netdev+bounces-96942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684528C84F4
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881621C215BB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62A38FB9;
	Fri, 17 May 2024 10:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA22E852
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942279; cv=none; b=U6yP10K0F3CdBsjLEM1MeAoes4pEFhnGg11FdBwt8sJ7VZmpwmecXWajHnnFh22PefGd0pFDDLniI6ViGp4Ri4oS7ucgg8y9pxyxsuGde5Y0bwSBvUBBA/DYqkVKUGIKDJHClrWhpZiHsdKVtyCZhjEOi1/GfjKBsqhUcZWCxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942279; c=relaxed/simple;
	bh=v3icsBIkVtfCKj7Gq39lX774d42+d32DfTVxWBt70wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y96ZYbhsatzVfspomk8LufjSdlIOBApIsOhfzhVEFVFmftzGGYEsOUrWh+VXBtwnbUteQL+ZalzEOnV6wA6cbyo+DVe1oi6IVLh1QYQvwSKni4timaOKeGhi/qgG843+yXhS/RpwNgbHQA3uPuKco8QVbDjmdXifVuj0Uwyobk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Bx9eqCM0dmnfENAA--.21530S3;
	Fri, 17 May 2024 18:37:54 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXbt+M0dmN0okAA--.4801S3;
	Fri, 17 May 2024 18:37:51 +0800 (CST)
Message-ID: <c09237c6-6661-4744-a9d3-7c3443f2820c@loongson.cn>
Date: Fri, 17 May 2024 18:37:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
 <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
 <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
 <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn>
 <l3bkpa2bw2gsiir2ybzzin2dusarlvzyai3zge62kxrkfomixb@ryaxhawhgylt>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <l3bkpa2bw2gsiir2ybzzin2dusarlvzyai3zge62kxrkfomixb@ryaxhawhgylt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXbt+M0dmN0okAA--.4801S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw17GFWfXryfCrWxXFW8AFc_yoW7GF18pr
	4fJFsFkry8JryfWr4j9w1DXry5trWDJw1UWr43J3WSy3Z0vrn2qr1jgr409a4kGrZ5Cr4j
	qr1UXFWxZa4UAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

Hi Serge,

在 2024/5/17 17:07, Serge Semin 写道:
> On Fri, May 17, 2024 at 04:42:51PM +0800, Yanteng Si wrote:
>> Hi Huacai, Serge,
>>
>> 在 2024/5/15 21:55, Huacai Chen 写道:
>>>>>> Once again about the naming. From the retrospective point of view the
>>>>>> so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
>>>>>> look similar because these are just the level-type signals connected
>>>>>> to the system IRQ controller. But when it comes to the PCI_Express_,
>>>>>> the implementation is completely different. The PCIe INTx is just the
>>>>>> PCIe TLPs of special type, like MSI. Upon receiving these special
>>>>>> messages the PCIe host controller delivers the IRQ up to the
>>>>>> respective system IRQ controller. So in order to avoid the confusion
>>>>>> between the actual legacy PCI INTx, PCI Express INTx and the just
>>>>>> platform IRQs, it's better to emphasize the actual way of the IRQs
>>>>>> delivery. In this case it's the later method.
>>>>> You are absolutely right, and I think I found a method to use your
>>>>> framework to solve our problems:
>>>>>
>>>>>      static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
>>>>>                                             struct plat_stmmacenet_data *plat,
>>>>>                                             struct stmmac_resources *res)
>>>>>      {
>>>>>          int i, ret, vecs;
>>>>>
>>>>>          /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>>>>>           * --------- ----- -------- --------  ...  -------- --------
>>>>>           * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>>>>>           */
>>>>>          vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
>>>>>          ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
>>>>>          if (ret < 0) {
>>>>>                  dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>>>>>                  return ret;
>>>>>          }
>>>>>         if (ret >= vecs) {
>>>>>                  for (i = 0; i < plat->rx_queues_to_use; i++) {
>>>>>                          res->rx_irq[CHANNELS_NUM - 1 - i] =
>>>>>                                  pci_irq_vector(pdev, 1 + i * 2);
>>>>>                  }
>>>>>                  for (i = 0; i < plat->tx_queues_to_use; i++) {
>>>>>                          res->tx_irq[CHANNELS_NUM - 1 - i] =
>>>>>                                  pci_irq_vector(pdev, 2 + i * 2);
>>>>>                  }
>>>>>
>>>>>                  plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>>>>>          }
>>>>>
>>>>>          res->irq = pci_irq_vector(pdev, 0);
>>>>>
>>>>>        if (np) {
>>>>>            res->irq = of_irq_get_byname(np, "macirq");
>>>>>            if (res->irq < 0) {
>>>>>               dev_err(&pdev->dev, "IRQ macirq not found\n");
>>>>>               return -ENODEV;
>>>>>            }
>>>>>
>>>>>            res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>>>>>            if (res->wol_irq < 0) {
>>>>>               dev_info(&pdev->dev,
>>>>>                    "IRQ eth_wake_irq not found, using macirq\n");
>>>>>               res->wol_irq = res->irq;
>>>>>            }
>>>>>
>>>>>            res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>>>>>            if (res->lpi_irq < 0) {
>>>>>               dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>>>>>               return -ENODEV;
>>>>>            }
>>>>>        }
>>>>>          return 0;
>>>>>      }
>>>>>
>>>>> If your agree, Yanteng can use this method in V13, then avoid furthur changes.
>>>> Since yesterday I have been too relaxed sitting back to explain in
>>>> detail the problems with the code above. Shortly speaking, no to the
>>>> method designed as above.
>>> This function is copy-paste from your version which you suggest to
>>> Yanteng, and plus the fallback parts for DT. If you don't want to
>>> discuss it any more, we can discuss after V13.
> My conclusion is the same. no to _your_ (Huacai) version of the code.
> I suggest to Huacai dig dipper in the function semantic and find out
> the problems it has. Meanwhile I'll keep relaxing...
>
>>> BTW, we cannot remove "res->wol_irq = res->irq", because Loongson
>>> GMAC/GNET indeed supports WoL.
>> Okay, I will not drop it in v13.
> Apparently Huacai isn't well familiar with what he is reviewing. Once
> again the initialization is useless. Drop it.

Hmm, to be honest, I'm still a little confused about this.

When we first designed the driver, we looked at intel,See:

$: vim drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c +953

static int stmmac_config_single_msi(struct pci_dev *pdev,
                     struct plat_stmmacenet_data *plat,
                     struct stmmac_resources *res)
{
     int ret;

     ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
     if (ret < 0) {
         dev_info(&pdev->dev, "%s: Single IRQ enablement failed\n",
              __func__);
         return ret;
     }

     res->irq = pci_irq_vector(pdev, 0);
     res->wol_irq = res->irq;

Why can't we do this?

Intel Patch thread link 
<https://lore.kernel.org/netdev/20210316121823.18659-5-weifeng.voon@intel.com/>


>
>> All right. I have been preparing v13 and will send it as soon as possible.
>>
>> Let's continue the discussion in v13. Of course, I will copy the part that
>> has
>>
>> not received a clear reply to v13.
>>
> Note the merge window has been opened and the 'net-next' tree is now
> closed. So either you submit your series as RFC or wait for the window
> being closed.
>
Ok, if I'm fast enough, I'll send an RFC to talk about msi and legacy.


Thanks,

Yanteng


