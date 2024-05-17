Return-Path: <netdev+bounces-96909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30588C82A6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665211F2153C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DCA8489;
	Fri, 17 May 2024 08:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C579D0
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935379; cv=none; b=iYZccQ4oqSXWHZEBke9CntwJXWjr+c8XZc368947ZwPx3qshGQMdQYE3uSMXQjGlfoWSEtUdgyd/bjiwLcipna5ybMyVYiLRVxCwUJ8Y03LcxbLwXT1mM8KqhA1pPmN814dhxuyqKUzfu1+im+T6djyYAjJuF7+HuLg+YuDJUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935379; c=relaxed/simple;
	bh=ND961LWHYSgjd+CllGjBRRnur2vGPw2t/BFZTC8/+wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSogXcvMmeieClP19GJPynelaPW4yY02Y4Vw3NIxf/hRGawmiCo0DGWUspOYBTNaN3IvKoTfjmrZ4wvFJj9GGHrU7iUrVg9jPs028bVqxleHsgKejTHmbtziPaDw3BaQrsnf0IP8yRFmXaufPzJm60iOWag4lMUglL947d+OSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8CxBeuOGEdmsOUNAA--.21561S3;
	Fri, 17 May 2024 16:42:54 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxP1WLGEdmwy4kAA--.4707S3;
	Fri, 17 May 2024 16:42:52 +0800 (CST)
Message-ID: <460a6b52-249e-4d50-8d3e-28cc9da6a01b@loongson.cn>
Date: Fri, 17 May 2024 16:42:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
 <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
 <kw7fb7mcy7ungrungmbe6z6rmfzswastesx66phtcxxez6vvgw@dal7dt2kj54u>
 <CAAhV-H4TtoV9LAfhx1+fu40XgDqQ+W-tXt36XoieK87_ucBgcQ@mail.gmail.com>
 <nt5bjlmul5jchxvx6zzgvbmdsegpwwz7quzt57vfejnxng7smz@abqdfipuclzh>
 <CAAhV-H5UMJvOtt+YFChqPC1eMkj5UjCEnFJ_YksWjk+uriZPzw@mail.gmail.com>
 <d2ibcsxpzrhjzjt4zu7tmopgyp6q77omgweobzidsp53yadcgz@x5774dqqs7qr>
 <CAAhV-H7Fck+cd14RSUkEPrB=6=35JGkHLBCtrYTGD924fYi2VA@mail.gmail.com>
 <xa2ewgfe3qjljsraet5d77qk3dygcvexnqk5atm5fm5oro3ogp@xctegdmx2srt>
 <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H5JT+QfZgHX7K3HYLFSxuZeer4PdUPjehtyXKcfi=L2oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxP1WLGEdmwy4kAA--.4707S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw15XFWxZr4kCFWUCryUJwc_yoW5ur15pr
	ZxXFZxKryktry7WF4j9ws29r4YyFWDXr48Wr43Aw1Sy3Z0yr93tr1UKrW0k3s7ArZ3uw4j
	gr1UZFZ3Aa4YyFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

Hi Huacai, Serge,

在 2024/5/15 21:55, Huacai Chen 写道:
>>>> Once again about the naming. From the retrospective point of view the
>>>> so called legacy PCI IRQs (in fact PCI INTx) and the platform IRQs
>>>> look similar because these are just the level-type signals connected
>>>> to the system IRQ controller. But when it comes to the PCI_Express_,
>>>> the implementation is completely different. The PCIe INTx is just the
>>>> PCIe TLPs of special type, like MSI. Upon receiving these special
>>>> messages the PCIe host controller delivers the IRQ up to the
>>>> respective system IRQ controller. So in order to avoid the confusion
>>>> between the actual legacy PCI INTx, PCI Express INTx and the just
>>>> platform IRQs, it's better to emphasize the actual way of the IRQs
>>>> delivery. In this case it's the later method.
>>> You are absolutely right, and I think I found a method to use your
>>> framework to solve our problems:
>>>
>>>     static int loongson_dwmac_config_irqs(struct pci_dev *pdev,
>>>                                            struct plat_stmmacenet_data *plat,
>>>                                            struct stmmac_resources *res)
>>>     {
>>>         int i, ret, vecs;
>>>
>>>         /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>>>          * --------- ----- -------- --------  ...  -------- --------
>>>          * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>>>          */
>>>         vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
>>>         ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
>>>         if (ret < 0) {
>>>                 dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>>>                 return ret;
>>>         }
>>>        if (ret >= vecs) {
>>>                 for (i = 0; i < plat->rx_queues_to_use; i++) {
>>>                         res->rx_irq[CHANNELS_NUM - 1 - i] =
>>>                                 pci_irq_vector(pdev, 1 + i * 2);
>>>                 }
>>>                 for (i = 0; i < plat->tx_queues_to_use; i++) {
>>>                         res->tx_irq[CHANNELS_NUM - 1 - i] =
>>>                                 pci_irq_vector(pdev, 2 + i * 2);
>>>                 }
>>>
>>>                 plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>>>         }
>>>
>>>         res->irq = pci_irq_vector(pdev, 0);
>>>
>>>       if (np) {
>>>           res->irq = of_irq_get_byname(np, "macirq");
>>>           if (res->irq < 0) {
>>>              dev_err(&pdev->dev, "IRQ macirq not found\n");
>>>              return -ENODEV;
>>>           }
>>>
>>>           res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>>>           if (res->wol_irq < 0) {
>>>              dev_info(&pdev->dev,
>>>                   "IRQ eth_wake_irq not found, using macirq\n");
>>>              res->wol_irq = res->irq;
>>>           }
>>>
>>>           res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>>>           if (res->lpi_irq < 0) {
>>>              dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>>>              return -ENODEV;
>>>           }
>>>       }
>>>         return 0;
>>>     }
>>>
>>> If your agree, Yanteng can use this method in V13, then avoid furthur changes.
>> Since yesterday I have been too relaxed sitting back to explain in
>> detail the problems with the code above. Shortly speaking, no to the
>> method designed as above.
> This function is copy-paste from your version which you suggest to
> Yanteng, and plus the fallback parts for DT. If you don't want to
> discuss it any more, we can discuss after V13.

All right. I have been preparing v13 and will send it as soon as possible.

Let's continue the discussion in v13. Of course, I will copy the part 
that has

not received a clear reply to v13.

>
> BTW, we cannot remove "res->wol_irq = res->irq", because Loongson
> GMAC/GNET indeed supports WoL.

Okay, I will not drop it in v13.


Thanks,

Yanteng


