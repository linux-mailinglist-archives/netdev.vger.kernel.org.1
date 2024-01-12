Return-Path: <netdev+bounces-63217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564D82BD67
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F9A1C23B96
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFBF56B7C;
	Fri, 12 Jan 2024 09:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0F51C2E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.41])
	by gateway (Coremail) with SMTP id _____8Bx3+uNCaFlqoMEAA--.13224S3;
	Fri, 12 Jan 2024 17:42:37 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.41])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx74dxCaFl6NITAA--.51288S3;
	Fri, 12 Jan 2024 17:42:34 +0800 (CST)
Message-ID: <0e580cd4-2b8d-451b-aa31-289b7a51645e@loongson.cn>
Date: Fri, 12 Jan 2024 17:42:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/9] net: stmmac: dwmac-loongson: Add full PCI
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <b43293919f4ddb869a795e41266f7c3107f79faf.1702990507.git.siyanteng@loongson.cn>
 <ZZPoKceXELZQU8cq@shell.armlinux.org.uk>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZZPoKceXELZQU8cq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx74dxCaFl6NITAA--.51288S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy5uF17ArWDJw4DGw15GFX_yoW8Gr4kp3
	93GFy7tF97Wr9rK3W8ZrWUX3WUu3y7t3yF9w4UCa45Wan0vrZ3Zr40g3yj9FyfAFWkC3yk
	Xw1UXF4vvFykGrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2024/1/2 18:40, Russell King (Oracle) 写道:
> On Tue, Dec 19, 2023 at 10:17:06PM +0800, Yanteng Si wrote:
>> @@ -125,42 +126,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> -	bus_id = of_alias_get_id(np, "ethernet");
>> -	if (bus_id >= 0)
>> -		plat->bus_id = bus_id;
>> +	if (np) {
>> +		bus_id = of_alias_get_id(np, "ethernet");
>> +		if (bus_id >= 0)
>> +			plat->bus_id = bus_id;
>>   
>> -	phy_mode = device_get_phy_mode(&pdev->dev);
>> -	if (phy_mode < 0) {
>> -		dev_err(&pdev->dev, "phy_mode not found\n");
>> -		ret = phy_mode;
>> -		goto err_disable_device;
>> +		phy_mode = device_get_phy_mode(&pdev->dev);
>> +		if (phy_mode < 0) {
>> +			dev_err(&pdev->dev, "phy_mode not found\n");
>> +			ret = phy_mode;
>> +			goto err_disable_device;
>> +		}
>> +		plat->phy_interface = phy_mode;
>>   	}
>>   
>> -	plat->phy_interface = phy_mode;
>> -
> So this is why phy_interface changes in patch 2. It would have been good
> to make a forward reference to this change to explain in patch 2 why the
> "default" value has been set there. Or maybe move the setting of that
> default value into this patch?

Thank you for your review. Sorry, I have been modifying the code 
according to serge's

comments for the past 10 days. I have not forgotten your comment. I will 
reply to you

next week.


Thanks,

Yanteng

>


