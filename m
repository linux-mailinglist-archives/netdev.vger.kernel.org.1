Return-Path: <netdev+bounces-80755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78771880F64
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0649F1F21EB4
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FC3BB48;
	Wed, 20 Mar 2024 10:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE93C097
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929580; cv=none; b=n+wSXGQNN2tvpwl9GMBejVM1CJuU39vpU2KMaVfqQKTABDy+8+CNLfvUdCffMpyONauU9duN+8NLaVHNt51/4eQbuYja4RPMDHTVCMPhnuRpaPDlBpmMVDAYwTxzzfjw5isUGvBXmaC6J95E9Z8KPvln30nMVRqSh7a5UBXwPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929580; c=relaxed/simple;
	bh=p6qBKdkFhKRhtiGkRgRhIhc04idA02RF6tLmT0KZZ8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qty7sByl7FPp64yvEzThhE7xFfxqR8zYrq5Jkl1sgOJXE6OIcrss/gzte4948kaTqAheMxfZTbHCO77Ea9QbMmXvfjvv49dbY17x/LAiJ2+Fk6wN65FErjKlGHFho8fo4lFTlJjt9ZMFU2pb4n065q4oI/Xg7o5L2GWd3l2nT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8AxOOintvpl3jYbAA--.45343S3;
	Wed, 20 Mar 2024 18:12:55 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs+ktvplllBeAA--.50034S3;
	Wed, 20 Mar 2024 18:12:53 +0800 (CST)
Message-ID: <ff211347-df96-4ce1-83ab-3dc9e18dfce0@loongson.cn>
Date: Wed, 20 Mar 2024 18:12:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 04/11] net: stmmac: dwmac-loongson: Move irq
 config to loongson_gmac_config
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <776bfe84003b203ebe320dc7bf6b98707a667fa9.1706601050.git.siyanteng@loongson.cn>
 <xjfd4effff6572fohxsgannqjr2w44qm4tru4aan2agojs77dl@tneltus7zqo6>
 <6e7e2765-5074-4252-820f-e9b34960e8b3@loongson.cn>
 <6x5fg66cr2vwwcgr6yi45ipov5ejkst5fggcxd4y2mxkq7m6po@nkghfpdeduyj>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <6x5fg66cr2vwwcgr6yi45ipov5ejkst5fggcxd4y2mxkq7m6po@nkghfpdeduyj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs+ktvplllBeAA--.50034S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4fWFWfKw1fXrWfAF48Xwc_yoWxAryDpr
	W3Aa4YkrWDXry7Wa1qvw45XF9IyrW2yry8Ww47Aw17Was0vF9aqF18tr1UuFyxArZ8GF17
	Xr4UCFWfuF95AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==


在 2024/3/19 21:43, Serge Semin 写道:
> On Wed, Mar 13, 2024 at 04:14:28PM +0800, Yanteng Si wrote:
>> 在 2024/2/6 01:01, Serge Semin 写道:
>>> On Tue, Jan 30, 2024 at 04:43:24PM +0800, Yanteng Si wrote:
>>>> Add loongson_dwmac_config and moving irq config related
>>>> code to loongson_dwmac_config.
>>>>
>>>> Removing MSI to prepare for adding loongson multi-channel
>>>> support later.
>>> Please detach this change into a separate patch and thoroughly explain
>>> why it was necessary.
>> OK.
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> ---
>>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 85 ++++++++++++-------
>>>>    1 file changed, 55 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> index 979c9b6dab3f..e7ce027cc14e 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> @@ -11,8 +11,46 @@
>>>>    struct stmmac_pci_info {
>>>>    	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>>>> +	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
>>>> +		      struct stmmac_resources *res, struct device_node *np);
>>>>    };
>>>> +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
>>>> +					struct plat_stmmacenet_data *plat,
>>>> +					struct stmmac_resources *res,
>>>> +					struct device_node *np)
>>>> +{
>>>> +	if (np) {
>>>> +		res->irq = of_irq_get_byname(np, "macirq");
>>>> +		if (res->irq < 0) {
>>>> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>>>> +		if (res->wol_irq < 0) {
>>>> +			dev_info(&pdev->dev,
>>>> +				 "IRQ eth_wake_irq not found, using macirq\n");
>>>> +			res->wol_irq = res->irq;
>>>> +		}
>>>> +
>>>> +		res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>>>> +		if (res->lpi_irq < 0) {
>>>> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>>>> +			return -ENODEV;
>>>> +		}
>>>> +	} else {
>>>> +		res->irq = pdev->irq;
>>>> +		res->wol_irq = res->irq;
>>>> +	}
>>>> +
>>>> +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
>>>> +	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
>>>> +		 __func__);
>>> Why is this here all of the sudden? I don't see this in the original
>>> code. Please move it to the patch which requires the flag
>>> setup/cleanup or drop if it isn't necessary.
>> +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
>> This cannot be removed because it appeared in a rebase(v4 -> v5). See
>> <https://lore.kernel.org/all/20230710090001.303225-9-brgl@bgdev.pl/>
> AFAICS it _can_ be removed. The patch you referred to is a formal
> conversion of
> -	plat->multi_msi_en = 0;
> to
> +	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> First of all the "multi_msi_en" field clearance had been
> redundant there since the code setting the flag was executed after the
> code which may cause the field clearance performed. Second AFAICS the
> "multi_msi_en" field clearance was originally added to emphasize the
> functions semantics:
> intel_eth_config_multi_msi() - config multi IRQ device,
> intel_eth_config_single_msi() - config single IRQ device.
>
> So in your case there is no any reason of clearing the
> STMMAC_FLAG_MULTI_MSI_EN flag. Please, either drop it or move the
> change into a separate patch.

OK, you are right. drop it.


Thanks,

Yanteng

>
> -Serge(y)
>
>> +	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
>> +		 __func__);
>>
>> OK, drop it.
>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static void loongson_default_data(struct pci_dev *pdev,
>>>>    				  struct plat_stmmacenet_data *plat)
>>>>    {
>>>> @@ -66,8 +104,21 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>>>>    	return 0;
>>>>    }
>>>> +static int loongson_gmac_config(struct pci_dev *pdev,
>>>> +				struct plat_stmmacenet_data *plat,
>>>> +				struct stmmac_resources *res,
>>>> +				struct device_node *np)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>> You introduce the config callback here and convert to a dummy method
>>> in
>>> [PATCH 07/11] net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
>>> It's just pointless. What about introducing the
>>> loongson_dwmac_config_legacy() method and call it directly?
>> OK, I will try.
>>>>    static struct stmmac_pci_info loongson_gmac_pci_info = {
>>>>    	.setup = loongson_gmac_data,
>>>> +	.config = loongson_gmac_config,
>>>>    };
>>>>    static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>> @@ -139,44 +190,19 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>    		plat->phy_interface = phy_mode;
>>>>    	}
>>>> -	pci_enable_msi(pdev);
>>> See my first note in this message.
>> OK.
>>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>>    	memset(&res, 0, sizeof(res));
>>>>    	res.addr = pcim_iomap_table(pdev)[0];
>>>> -	if (np) {
>>>> -		res.irq = of_irq_get_byname(np, "macirq");
>>>> -		if (res.irq < 0) {
>>>> -			dev_err(&pdev->dev, "IRQ macirq not found\n");
>>>> -			ret = -ENODEV;
>>>> -			goto err_disable_msi;
>>>> -		}
>>>> -
>>>> -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>>>> -		if (res.wol_irq < 0) {
>>>> -			dev_info(&pdev->dev,
>>>> -				 "IRQ eth_wake_irq not found, using macirq\n");
>>>> -			res.wol_irq = res.irq;
>>>> -		}
>>>> -
>>>> -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>>>> -		if (res.lpi_irq < 0) {
>>>> -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>>>> -			ret = -ENODEV;
>>>> -			goto err_disable_msi;
>>>> -		}
>>>> -	} else {
>>>> -		res.irq = pdev->irq;
>>>> -		res.wol_irq = pdev->irq;
>>>> -	}
>>>> +	ret = info->config(pdev, plat, &res, np);
>>>> +	if (ret)
>>>> +		goto err_disable_device;
>>>>    	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>>>    	if (ret)
>>>> -		goto err_disable_msi;
>>>> +		goto err_disable_device;
>>>>    	return ret;
>>>> -err_disable_msi:
>>>> -	pci_disable_msi(pdev);
>>>>    err_disable_device:
>>>>    	pci_disable_device(pdev);
>>>>    err_put_node:
>>>> @@ -200,7 +226,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>>>>    		break;
>>>>    	}
>>>> -	pci_disable_msi(pdev);
>>>>    	pci_disable_device(pdev);
>>>>    }
>>>> -- 
>>>> 2.31.4
>>>>


