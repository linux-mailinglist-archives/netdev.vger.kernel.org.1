Return-Path: <netdev+bounces-112737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23193AF06
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2831F2186F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD31152E12;
	Wed, 24 Jul 2024 09:24:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6A15351A
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813050; cv=none; b=ei1MYNk2PhYemZwvXFOSQGy+Sst0M0ovjR490msGr58FlxIF0Zc1BkYQu53KIpydHTzPgVUT8PYCCmqDPn+GEVKjzPG9BdSgygyT7isDCzBdrmi01WnFTT8uCmUdc2NyKhJEEoOIO0axH4E9EkHtaQhKa779QUouE7cny0AhCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813050; c=relaxed/simple;
	bh=U/nNiY4nMqPiygl184YBpIN+KaC+JtaXFZglJmLZXto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQ7ehLRk38Nf4mpL14XpYmfcCPKvUiDOL0mkEm0EHhwslJtIRa5waPxvI75I1azTO742mj8hNTuHQlpdHCZeX6RdWz2SrnXSvj+h/1VGVCishxkfDp5wMY+DYD7fI/AYbJG3B/5ROCnbbOXIR9DErSkmP/y7yB5cartD3yIf6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.124])
	by gateway (Coremail) with SMTP id _____8AxGuoyyKBmxuIAAA--.3323S3;
	Wed, 24 Jul 2024 17:24:02 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxssQvyKBmkxVXAA--.50306S3;
	Wed, 24 Jul 2024 17:24:00 +0800 (CST)
Message-ID: <f7bb575c-8eee-4aac-b913-fd1872419e5a@loongson.cn>
Date: Wed, 24 Jul 2024 17:23:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, si.yanteng@linux.dev,
 Huacai Chen <chenhuacai@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
 <69b137e3ee5917264d3278d4091770aca891d21e.1721645682.git.siyanteng@loongson.cn>
 <20240722152744.GA15209@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240722152744.GA15209@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxssQvyKBmkxVXAA--.50306S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy7CF1fKr4DKFWxuFyDJwc_yoW8Kw1rpr
	4fCa4akrWDtry7CanIvr45XryY9rW8ArWDJr4xt3WfWas8Ca4xtr9rKF4jyas7ZrZ7Ga1I
	vryj9r109FyDJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU


在 2024/7/22 23:27, Simon Horman 写道:
> On Mon, Jul 22, 2024 at 07:01:09PM +0800, Yanteng Si wrote:
>> The Loongson GMAC driver currently supports the network controllers
>> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
>> devices are required to be defined in the platform device tree source.
>> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
>> (implies FDT) as the system bootloaders. In order to have both system
>> configurations support let's extend the driver functionality with the
>> case of having the Loongson GMAC probed on the PCI bus with no device
>> tree node defined for it. That requires to make the device DT-node
>> optional, to rely on the IRQ line detected by the PCI core and to
>> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
>>
>> In order to have the device probe() and remove() methods less
>> complicated let's move the DT- and ACPI-specific code to the
>> respective sub-functions.
>>
>> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
>> Acked-by: Huacai Chen<chenhuacai@loongson.cn>
>> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 160 +++++++++++-------
>>   1 file changed, 101 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> ...
>
>> @@ -90,25 +158,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (!plat->mdio_bus_data)
>>   		return -ENOMEM;
>>   
>> -	plat->mdio_node = of_get_child_by_name(np, "mdio");
>> -	if (plat->mdio_node) {
>> -		dev_info(&pdev->dev, "Found MDIO subnode\n");
>> -		plat->mdio_bus_data->needs_reset = true;
>> -	}
>> -
>>   	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>> -	if (!plat->dma_cfg) {
>> -		ret = -ENOMEM;
>> -		goto err_put_node;
>> -	}
>> +	if (!plat->dma_cfg)
>> +		return -ENOMEM;
>>   
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n", __func__);
>>   		goto err_put_node;
>> +		return ret;
> This seems incorrect: this line will never be executed.

Sorry, I will drop it in v15.


Thanks,

Yanteng


