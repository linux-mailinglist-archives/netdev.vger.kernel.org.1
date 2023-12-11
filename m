Return-Path: <netdev+bounces-55788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A680C556
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8CC1F20F9C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EB21A10;
	Mon, 11 Dec 2023 09:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67AE0C2
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:57:37 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8BxK+kP3XZlLgAAAA--.1S3;
	Mon, 11 Dec 2023 17:57:35 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfS+4zHZldVpbAA--.5265S3;
	Mon, 11 Dec 2023 16:47:53 +0800 (CST)
Message-ID: <54242b04-0f9f-4384-a0c9-1add2b15c2d7@loongson.cn>
Date: Mon, 11 Dec 2023 16:47:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] net: stmmac: dwmac-loongson: Add full PCI support
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 dongbiao@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <0e9dd61f05571b01de369e449106db3ac2dd56da.1699533745.git.siyanteng@loongson.cn>
 <52a727bb-29d0-4d5c-9043-95903f7b9892@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <52a727bb-29d0-4d5c-9043-95903f7b9892@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfS+4zHZldVpbAA--.5265S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xGFy8Gr1xAr1fXF1DArc_yoW8Ww4xp3
	95AF15ZrykXry7uayUZayxJ3W8Xr48Zry8Cw47Cr12v3WFvr1ftF15KrW7CryxArZIkw40
	9w1jqF4vkFsYkacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2023/11/12 04:24, Andrew Lunn 写道:
>> -	res.irq = of_irq_get_byname(np, "macirq");
>> -	if (res.irq < 0) {
>> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
>> -		ret = -ENODEV;
>> -		goto err_disable_msi;
>> -	}
>> -
>> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> -	if (res.wol_irq < 0) {
>> -		dev_info(&pdev->dev,
>> -			 "IRQ eth_wake_irq not found, using macirq\n");
>> -		res.wol_irq = res.irq;
>> -	}
>> -
>> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> -	if (res.lpi_irq < 0) {
>> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> -		ret = -ENODEV;
>> -		goto err_disable_msi;
>> +	if (np) {
>> +		res.irq = of_irq_get_byname(np, "macirq");
>> +		if (res.irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
>> +			ret = -ENODEV;
>> +			goto err_disable_msi;
>> +		}
>> +
>> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> +		if (res.wol_irq < 0) {
>> +			dev_info(&pdev->dev,
>> +				 "IRQ eth_wake_irq not found, using macirq\n");
>> +			res.wol_irq = res.irq;
>> +		}
>> +
>> +		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> +		if (res.lpi_irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> +			ret = -ENODEV;
>> +			goto err_disable_msi;
>> +		}
> This is where a refactoring patch is useful. Have one patch which
> moves this code into a helper function. The commit message can say it
> just moves code around, but there is no functional change. The second
> patch then moves the call to the helper inside the if (np).

Thanks for your advice!


In fact, we have already done this in <[PATCH v5 6/9] net: stmmac: 
dwmac-loongson: Add MSI support>, and the function is 
loongson_dwmac_config_legacy().


Thanks,

Yanteng


>
>        Andrew


