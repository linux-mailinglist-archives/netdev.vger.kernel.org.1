Return-Path: <netdev+bounces-94829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663938C0CF0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCBD1F22420
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3514A085;
	Thu,  9 May 2024 08:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9931127E1F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245073; cv=none; b=GEokoLy3H130gBlHPlt6NBZH+ESg9G8YaDZSET5SyszTq30wZ1ME+7H8WXdGzB20FNIMVD3J9lJn9wHck6Szv0UjPgnKojYXRxtewmhwD3VEOGa+kjhbZAQuF4zWwQbt9NTrOj38phfb4IVpVlvJtKp8sRPUPO1QklaJvlcnNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245073; c=relaxed/simple;
	bh=D2iDzNdeQWHB0QtXMopxQRRdVMqhh5gKID1na6iNNFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teLHNM8KuFA/+5MjofzskLEoRz1UKzIVk7y9QueoXd9Ej+9xQ/3KkV3bavY0siMvcpWvKsz/49ogp4T3nFt564895NoogdfTORUONnrfHeHcqCP5KyynpjVOcv6W+rHCyzZHYe4+jUWZh/FdsqyWVqAcLK65H6P0Nk0PHyGKnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Cxg+oMkDxmyegJAA--.13698S3;
	Thu, 09 May 2024 16:57:48 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjlcIkDxmR+0WAA--.38711S3;
	Thu, 09 May 2024 16:57:45 +0800 (CST)
Message-ID: <7b56eabc-53e1-4fbe-bf92-81bb1c91ddfc@loongson.cn>
Date: Thu, 9 May 2024 16:57:44 +0800
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
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <jkjgjraqvih4zu7wvqykerq5wisgkhqf2n2pouha7qhfoeif7v@tkwyx53dfrdw>
 <150b03ff-70b5-488a-b5e6-5f74b6398b20@loongson.cn>
 <pdyqoki5qw4zabz3uv5ff2e2o43htcr6xame652zmbqh23tjji@lt5gmp6m3lkm>
 <CAAhV-H7Dz0CVysUVVVe4Y8qGxpmwJ0i6y2wKnATzNS=5DR_vZg@mail.gmail.com>
 <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <tbjruh7sx7zovj4ypvfmer3tkgp63zrwhsaxj6hpcfc7ljaqes@zyd3acrqchik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjlcIkDxmR+0WAA--.38711S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWfJw45GFykAF47uFWkKrX_yoWxJry3pr
	WfCFW7KrW5Jry3GF1qvw4jqrnIyrWUtr48Xr15tw18Cw1qyr17tFy8J3yjkr97CrWDCF1U
	ZF4UtF47uF98JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

Hi Serge

在 2024/5/8 23:10, Serge Semin 写道:
> On Wed, May 08, 2024 at 10:58:16PM +0800, Huacai Chen wrote:
>> Hi, Serge,
>>
>> On Wed, May 8, 2024 at 10:38 PM Serge Semin<fancer.lancer@gmail.com>  wrote:
>>> On Tue, May 07, 2024 at 09:35:24PM +0800, Yanteng Si wrote:
>>>> Hi Serge,
>>>>
>>>> 在 2024/5/6 18:39, Serge Semin 写道:
>>>>> On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
>>>>>> ...
>>>>>> +static int loongson_dwmac_config_msi(struct pci_dev *pdev,
>>>>>> +                              struct plat_stmmacenet_data *plat,
>>>>>> +                              struct stmmac_resources *res,
>>>>>> +                              struct device_node *np)
>>>>>> +{
>>>>>> + int i, ret, vecs;
>>>>>> +
>>>>>> + vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
>>>>>> + ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
>>>>>> + if (ret < 0) {
>>>>>> +         dev_info(&pdev->dev,
>>>>>> +                  "MSI enable failed, Fallback to legacy interrupt\n");
>>>>>> +         return loongson_dwmac_config_legacy(pdev, plat, res, np);
>>>>>> + }
>>>>>> +
>>>>>> + res->irq = pci_irq_vector(pdev, 0);
>>>>>> + res->wol_irq = 0;
>>>>>> +
>>>>>> + /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>>>>>> +  * --------- ----- -------- --------  ...  -------- --------
>>>>>> +  * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>>>>>> +  */
>>>>>> + for (i = 0; i < CHANNEL_NUM; i++) {
>>>>>> +         res->rx_irq[CHANNEL_NUM - 1 - i] =
>>>>>> +                 pci_irq_vector(pdev, 1 + i * 2);
>>>>>> +         res->tx_irq[CHANNEL_NUM - 1 - i] =
>>>>>> +                 pci_irq_vector(pdev, 2 + i * 2);
>>>>>> + }
>>>>>> +
>>>>>> + plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>>>>>> +
>>>>>> + return 0;
>>>>>> +}
>>>>>> +
>>>>>> ...
>>>>>>    static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>>    {
>>>>>>            struct plat_stmmacenet_data *plat;
>>>>>>            int ret, i, bus_id, phy_mode;
>>>>>>            struct stmmac_pci_info *info;
>>>>>>            struct stmmac_resources res;
>>>>>> + struct loongson_data *ld;
>>>>>>            struct device_node *np;
>>>>>>            np = dev_of_node(&pdev->dev);
>>>>>> @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>>>>>                    return -ENOMEM;
>>>>>>            plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>>>>>> - if (!plat->dma_cfg) {
>>>>>> -         ret = -ENOMEM;
>>>>>> -         goto err_put_node;
>>>>>> - }
>>>>>> + if (!plat->dma_cfg)
>>>>>> +         return -ENOMEM;
>>>>>> +
>>>>>> + ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>>>>>> + if (!ld)
>>>>>> +         return -ENOMEM;
>>>>>>            /* Enable pci device */
>>>>>>            ret = pci_enable_device(pdev);
>>>>>> @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>>>>>                    plat->phy_interface = phy_mode;
>>>>>>            }
>>>>>> - pci_enable_msi(pdev);
>>>>>> + plat->bsp_priv = ld;
>>>>>> + plat->setup = loongson_dwmac_setup;
>>>>>> + ld->dev = &pdev->dev;
>>>>>> +
>>>>>>            memset(&res, 0, sizeof(res));
>>>>>>            res.addr = pcim_iomap_table(pdev)[0];
>>>>>> + ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
>>>>>> +
>>>>>> + switch (ld->gmac_verion) {
>>>>>> + case LOONGSON_DWMAC_CORE_1_00:
>>>>>> +         plat->rx_queues_to_use = CHANNEL_NUM;
>>>>>> +         plat->tx_queues_to_use = CHANNEL_NUM;
>>>>>> +
>>>>>> +         /* Only channel 0 supports checksum,
>>>>>> +          * so turn off checksum to enable multiple channels.
>>>>>> +          */
>>>>>> +         for (i = 1; i < CHANNEL_NUM; i++)
>>>>>> +                 plat->tx_queues_cfg[i].coe_unsupported = 1;
>>>>>> - plat->tx_queues_to_use = 1;
>>>>>> - plat->rx_queues_to_use = 1;
>>>>>> +         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
>>>>>> +         break;
>>>>>> + default:        /* 0x35 device and 0x37 device. */
>>>>>> +         plat->tx_queues_to_use = 1;
>>>>>> +         plat->rx_queues_to_use = 1;
>>>>>> - ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>>>>>> +         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>>>>>> +         break;
>>>>>> + }
>>>>> Let's now talk about this change.
>>>>>
>>>>> First of all, one more time. You can't miss the return value check
>>>>> because if any of the IRQ config method fails then the driver won't
>>>>> work! The first change that introduces the problem is in the patch
>>>>> [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_config_legacy
>>>> OK!
>>>>> Second, as I already mentioned in another message sent to this patch
>>>>> you are missing the PCI MSI IRQs freeing in the cleanup-on-error path
>>>>> and in the device/driver remove() function. It's definitely wrong.
>>>> You are right! I will do it.
>>>>> Thirdly, you said that the node-pointer is now optional and introduced
>>>>> the patch
>>>>> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
>>>>> If so and the DT-based setting up isn't mandatory then I would
>>>>> suggest to proceed with the entire so called legacy setups only if the
>>>>> node-pointer has been found, otherwise the pure PCI-based setup would
>>>>> be performed. So the patches 10-13 (in your v12 order) would look
>>>> In this case, MSI will not be enabled when the node-pointer is found.
>>>>
>>>> .
>>>>
>>>>
>>>> In fact, a large fraction of 2k devices are DT-based, of course, many are
>>>> PCI-based.
>>> Then please summarise which devices need the DT-node pointer which
>>> don't? And most importantly if they do why do they need the DT-node?
>> Whether we need DT-nodes doesn't depend on device type, but depends on
>> the BIOS type. When we boot with UEFI+ACPI, we don't need DT-node,
>> when we boot with PMON+FDT, we need DT-node. Loongson machines may
>> have either BIOS types.
> Thanks for the answer. Just to fully clarify. Does it mean that all
> Loongson Ethernet controllers (Loongson GNET and GMAC) are able to
> deliver both PCI MSI IRQs and direct GIC IRQs (so called legacy)?

No, only devices that support multiple channels can deliver both PCI MSI 
IRQs

and direct GIC IRQs, other devices can only deliver GIC IRQs.

Furthermore, multiple channel features are bundled with MSI. If we want to

enable multiple channels, we must enable MSI.

Thanks,

Yanteng


