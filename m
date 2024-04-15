Return-Path: <netdev+bounces-87756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C0B8A46DC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 04:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34675B20BC8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286AEEBB;
	Mon, 15 Apr 2024 02:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA84A24
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147709; cv=none; b=Tz4W6gdwFOxLPinLsKQwgLRhqmT9nC/TiaEhJ0vdqkElYZJjAFh6es0xcXh92kdrhXj0tek83R6Jo6QTkpbsxiKszpRMo17jOtVk00DguvyZqbEjsnvpAGmbwk6/OVcM1UNJt5kcxEc5vc2jR/UbFSbPNOYvTMFo6gFHD3QFqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147709; c=relaxed/simple;
	bh=o2qlqFm7bzP8WWTWOSXFfrzH0ty0EoPRYm3C5bN0Fp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwIhs0FA1R1EBwFhin1uMoaaxq1hO0WcGAoxAxR/jgu9ZEegS5by/X/k35O2OD1qAFSaGgatIZnoWFVRIzktGX/7n7gKGC5olME40lzBY5mitgUrbdIjEqF+lwxvKtitoki21moIvQW8p0VK/gJvHOhFd8gBnO5PeffrYt6UkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Axjus4jxxmqI0nAA--.23894S3;
	Mon, 15 Apr 2024 10:21:44 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxxxE0jxxmMht7AA--.28255S3;
	Mon, 15 Apr 2024 10:21:40 +0800 (CST)
Message-ID: <0e8f4d9c-e3ef-49bd-ae8b-bbc5897d9e90@loongson.cn>
Date: Mon, 15 Apr 2024 10:21:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/6] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
 <20240412184939.2b022d42@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240412184939.2b022d42@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxxxE0jxxmMht7AA--.28255S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4DJw17CrWDXr43XryruFX_yoW8AFWDpr
	W3Aa4qgrZrtr48C3Z5tw1Dury5Zay3G34UuF4xJrsIgF9rC34jqr129F45Wr17Ar4jq3W2
	vryDuFs7CFs8AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 9e40c28d453a..995c9bd144e0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -213,7 +213,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>   			 loongson_dwmac_resume);
>>   
>>   static const struct pci_device_id loongson_dwmac_id_table[] = {
>> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
>> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> In file included from ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:6:
> ../include/linux/pci.h:1061:51: error: ‘PCI_DEVICE_ID_LOONGSON_GMAC’ undeclared here (not in a function); did you mean ‘PCI_DEVICE_ID_LOONGSON_HDA’?
>   1061 |         .vendor = PCI_VENDOR_ID_##vend, .device = PCI_DEVICE_ID_##vend##_##dev, \
>        |                                                   ^~~~~~~~~~~~~~
> ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:11: note: in expansion of macro ‘PCI_DEVICE_DATA’
>    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>        |           ^~~~~~~~~~~~~~~
> ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:44: error: ‘loongson_gmac_pci_info’ undeclared here (not in a function)
>    216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>        |                                            ^~~~~~~~~~~~~~~~~~~~~~
> ../include/linux/pci.h:1063:41: note: in definition of macro ‘PCI_DEVICE_DATA’
>   1063 |         .driver_data = (kernel_ulong_t)(data)
>        |                                         ^~~~

Will be fixed in v12.


Thanks,

Yanteng


