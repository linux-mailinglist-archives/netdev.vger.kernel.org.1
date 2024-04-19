Return-Path: <netdev+bounces-89569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA68AAB98
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DEA1F21AC0
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6877F10;
	Fri, 19 Apr 2024 09:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995937B3FE
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519617; cv=none; b=W8Xpx9uAMefJRVDSm0vw1amtKeCG8scqdoYdDivrctzRhPfe3mgfeFFcHN2RkaeBp5WyIIXtRSH8UZje4nGr8r/MFyJ3n8FoI1guOfStZ+FsGKmY2ESPXS77jpC21l2bAoo6jmZ+5IsUcsR2siw2ykBOlIMc3qTHl1lHVpg0oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519617; c=relaxed/simple;
	bh=DwDohIq1KCt497jjlFAvMvtBz/hmiJ48LUhg9Pqf3+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvqZSuweF07Qf0+XKmKs9rX9o0pNNjC2WA1QM4oQRoLuP1UGxAWR5XHL1aFZCqWHcA1vYkmoCAkQJ85C4rnnOCMp0TuEGUotpangnAKDpqYLz8FKwwwytNS1R+b34447w+vATd+c3chRXNc50OTq8oEjouOrwsilLMt0xwqVgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxSPD8OyJmqLwpAA--.13373S3;
	Fri, 19 Apr 2024 17:40:12 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjhP5OyJmhxeAAA--.56012S3;
	Fri, 19 Apr 2024 17:40:10 +0800 (CST)
Message-ID: <dcd397a5-489d-41d4-b2fb-a3d80046739a@loongson.cn>
Date: Fri, 19 Apr 2024 17:40:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/6] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
 <20240412184939.2b022d42@kernel.org>
 <0e8f4d9c-e3ef-49bd-ae8b-bbc5897d9e90@loongson.cn>
 <b3g2spu4y4f2atapsheaput7sjl4abeslwjacy65xaowsbgrsl@to7ek2fubiud>
 <y6ea3idgz5i4qhhb4agbizmosgg6yuijgsjhgexwxnioqczwlo@slq7q5ln3twr>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <y6ea3idgz5i4qhhb4agbizmosgg6yuijgsjhgexwxnioqczwlo@slq7q5ln3twr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjhP5OyJmhxeAAA--.56012S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFy7KF17Wr45WF4rWw1rAFc_yoW8tF1xpr
	y3Aa4q9rZxtr48Aa1ktw1DWryYvay3J34UuF4fJwnagF9Fy34YqrnF9F45ur17Cr4jq3W2
	v34DuFs7CFn8AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/4/18 20:31, Serge Semin 写道:
> On Thu, Apr 18, 2024 at 02:14:17PM +0300, Serge Semin wrote:
>> On Mon, Apr 15, 2024 at 10:21:39AM +0800, Yanteng Si wrote:
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> index 9e40c28d453a..995c9bd144e0 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> @@ -213,7 +213,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>>>>    			 loongson_dwmac_resume);
>>>>>    static const struct pci_device_id loongson_dwmac_id_table[] = {
>>>>> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
>>>>> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>>>>    	{}
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>>>> In file included from ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:6:
>>>> ../include/linux/pci.h:1061:51: error: ‘PCI_DEVICE_ID_LOONGSON_GMAC’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_LOONGSON_HDA’?
>>>>    1061 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##_##dev, \
>>>>         |                                                   ^~~~~~~~~~~~~~
>>>> ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:11: note: in expansion of macro ‘PCI_DEVICE_DATA’
>>>>     216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>>>         |           ^~~~~~~~~~~~~~~
>>>> ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:44: error: ‘loongson_gmac_pci_info’ undeclared here (not in a function)
>>>>     216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>>>         |                                            ^~~~~~~~~~~~~~~~~~~~~~
>>>> ../include/linux/pci.h:1063:41: note: in definition of macro ‘PCI_DEVICE_DATA’
>>>>    1063 |         .driver_data = (kernel_ulong_t)(data)
>>>>         |                                         ^~~~
>>> Will be fixed in v12.
>> Just move the PCI_DEVICE_ID_LOONGSON_GMAC macro definition from Patch
>> 5/6 to this one.
OK.
> ... and of course pass NULL as the data-pointer to PCI_DEVICE_DATA().

OK. Thank you!


Thanks,

Yanteng




