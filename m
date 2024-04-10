Return-Path: <netdev+bounces-86491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B389EF66
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE5E284218
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0F157E6E;
	Wed, 10 Apr 2024 10:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88DD155733
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743443; cv=none; b=XDu58DIPrSP29r0EhmyJn47Ydc0pr4yPmkmcOgp9OLNAdOtb7bKKlaUUM40hvLT4jvtH0E/B30Ht+XGO5DWYLIbzB22TALVqdSLHlDxhbB6mcFTqUNdK5raZOns9Qu5AXIhKhqHXpxoezG3LveS1WWnmDpwYJS1GJxldFx2jgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743443; c=relaxed/simple;
	bh=cHfSIDkmtptlYbYaQcalsbmRuRJEiXsREDavsHE6xJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwzMjstX7GwNlPwdE06JehonfVM+/TK9iU6IkHOCX5xnWHP5co3Ni3Esg4rtmE00UTNXyKUxP+8ALl8zcVxZN9ji8E3tOGS7jA+Exsq6uYL8UeWUK0cEOvADPu5WOj0AUjHcTfvW1/6u0z+56vo86yPI3azfX2hBx3llg5PbnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8DxbOkNZBZm2TAlAA--.9498S3;
	Wed, 10 Apr 2024 18:03:57 +0800 (CST)
Received: from [192.168.100.126] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs8KZBZmcVd3AA--.31017S3;
	Wed, 10 Apr 2024 18:03:55 +0800 (CST)
Message-ID: <027eca32-3310-422d-ab52-5002af96d960@loongson.cn>
Date: Wed, 10 Apr 2024 18:03:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
 <CAAhV-H45G+5kB9zvcYuXhEgc4Z41D3AdSNpW+TW0NXLfmapasA@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H45G+5kB9zvcYuXhEgc4Z41D3AdSNpW+TW0NXLfmapasA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs8KZBZmcVd3AA--.31017S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF18uFy8Ar1ftr47CF1kCrX_yoW5Jw1kpa
	yfA3Z8Gr1UGr1jkayDZr4DXrySv3y5C3y3Gw43J34093sIyFWxXFWFkrWDA3s7urykur10
	q34Uta1DuFykJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUUUUU


在 2024/4/10 11:15, Huacai Chen 写道:
> Hi, Yanteng,
>
>
> +        * post 3.5 mode bit acts as 8*PBL.
> +        */
> +       if (dma_cfg->pblx8)
> +               value |= DMA_BUS_MODE_MAXPBL;
> Adding a new blank line is better here.
> OK.
>> +static void loongson_phylink_get_caps(struct stmmac_priv *priv)
>> +{
>> +       struct pci_dev *pdev = to_pci_dev(priv->device);
>> +       struct stmmac_resources res;
>> +       u32 loongson_gmac;
>> +
>> +       memset(&res, 0, sizeof(res));
>> +       res.addr = pcim_iomap_table(pdev)[0];
>> +       loongson_gmac = readl(res.addr + GMAC_VERSION) & 0xff;
>> +
>> +       /* The GMAC device with PCI ID 7a03 does not support any pause mode.
>> +        * The GNET device (only LS7A2000) does not support half-duplex.
>> +        */
>> +       if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>> +               priv->hw->link.caps = MAC_10FD | MAC_100FD |
>> +                       MAC_1000FD;
>> +       } else {
>> +               priv->hw->link.caps = (MAC_ASYM_PAUSE |
>> +                       MAC_SYM_PAUSE | MAC_10FD | MAC_100FD | MAC_1000FD);
> I think some GNET support HD while others don't, so we should enable
> HD here, and clear HD only for the later 0x37 case. Otherwise you
> disable HD for all devices indeed.
Yeah, you are right. I will fix it in v11.
>> +
>> +               if (loongson_gmac == DWMAC_CORE_3_70) {
>> +                       priv->hw->link.caps &= ~(MAC_10HD |
>> +                               MAC_100HD | MAC_1000HD);
> I remember that kernel code allows a line exceeding 80 columns now,
> and keeping in one line looks better at least in this case. Moreover,
> we don't need { and } here.

  Networking code (still) prefers code to be 80 columns wide or less.

  see https://lore.kernel.org/netdev/20240202123034.GO530335@kernel.org/

>> +static int loongson_dwmac_probe(struct pci_dev *pdev,
>> +                               const struct pci_device_id *id)
>>   {
>>          struct plat_stmmacenet_data *plat;
>>          int ret, i, bus_id, phy_mode;
>>          struct stmmac_pci_info *info;
>>          struct stmmac_resources res;
>> +       struct loongson_data *ld;
>>          struct device_node *np;
>> +       u32 loongson_gmac;
>>
>>          plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>          if (!plat)
>> @@ -87,11 +514,16 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>          if (!plat->mdio_bus_data)
>>                  return -ENOMEM;
>>
>> -       plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>> -       if (!plat->dma_cfg) {
>> -               ret = -ENOMEM;
>> -               goto err_put_node;
>> -       }
>> +       plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
>> +                                    GFP_KERNEL);
> This is an irrelevant modification, don't do that in this patch.
OK.



Thanks,

Yanteng


