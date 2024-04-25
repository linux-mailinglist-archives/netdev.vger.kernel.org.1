Return-Path: <netdev+bounces-91228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A08B1C79
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF7BB23EB5
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F946BB5D;
	Thu, 25 Apr 2024 08:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9876035
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032485; cv=none; b=FhiYCk6I0+l2419YdTit/tBTXm5Syw0CIUM5sWGNhxZ+DkQOt2UzsTnest3wVgeq7Kp4EhICXPSIX+15P5r7bhpbMMLVjll4wf4WSVxafFWxv3aHzm+4KnjZ1dQrI7Ev9C8M+N4JXEMMIQDsR8VDMY1OOdE8WOCEPMEBCGKBi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032485; c=relaxed/simple;
	bh=01Pt3J7sAkG69j5OCUhz7MuF4fDrTvj2ox6AoyoZZsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bv2QA1kIlaEMglPjxJ21prqWx2szl+ceGDMgz9ZAf8CyBPzu5y/uJprirn1lLp6clt4rPqRJqNqwlAQ6FrX4XtthvqzGBFc2NndDCRhbbZgerWtUlw+yMQNth3y2C5Uqb1mWoA7qvLTwZnCjsOCAk6OitX5qa4p8NYcKeIPDhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxZ_BaDypmOLUCAA--.12940S3;
	Thu, 25 Apr 2024 16:07:54 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxU1ZXDypm9eIEAA--.1014S3;
	Thu, 25 Apr 2024 16:07:52 +0800 (CST)
Message-ID: <01a8f9ea-56b1-47d8-ab9c-9324e703b403@loongson.cn>
Date: Thu, 25 Apr 2024 16:07:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Huacai Chen <chenhuacai@kernel.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
 <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
 <CAAhV-H5=ZJ603J8ybKyCdMCK9B+OnA1Qu3M9GndbmqdCFgZcMA@mail.gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <CAAhV-H5=ZJ603J8ybKyCdMCK9B+OnA1Qu3M9GndbmqdCFgZcMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxU1ZXDypm9eIEAA--.1014S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF45KF45XrW5Gr1rWw43twc_yoW8Gw17pr
	ZxAF47trWrXr13XF4UWw43ur43tryUXF1jkw43A3savrWvyrn2yFn5KrW09rZ7GrZ8Cw4U
	uayUtF4DZ3W5GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Hi Serge and Russell,

在 2024/4/24 22:11, Huacai Chen 写道:
>> Once again. Please replace this with simpler solution:
> In full PCI system the below function works fine, because alloc irq
> vectors with PCI_IRQ_LEGACY do the same thing as fallback to call
> loongson_dwmac_config_legacy(). But for a DT-based system it doesn't
> work.
huacai's comments are here.
>
>
>> static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
>> +                                          struct plat_stmmacenet_data *plat,
>> +                                          struct stmmac_resources *res)
>> +{
>> +       int i, ret, vecs;
>> +
>> +       /* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
>> +        * --------- ----- -------- --------  ...  -------- --------
>> +        * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
>> +        */
>> +       vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
>> +       ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>> +               return ret;
>> +       } else if (ret >= vecs) {
>> +               for (i = 0; i < plat->rx_queues_to_use; i++) {
>> +                       res->rx_irq[CHANNELS_NUM - 1 - i] =
>> +                               pci_irq_vector(pdev, 1 + i * 2);
>> +               }
>> +               for (i = 0; i < plat->tx_queues_to_use; i++) {
>> +                       res->tx_irq[CHANNELS_NUM - 1 - i] =
>> +                               pci_irq_vector(pdev, 2 + i * 2);
>> +               }
>> +
>> +               plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>> +       }
>> +
>> +       res->irq = pci_irq_vector(pdev, 0);
>> +
>> +       return 0;
>> +}

How about we stay the same in v12?


Thanks,

Yanteng



