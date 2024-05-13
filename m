Return-Path: <netdev+bounces-95963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66DD8C3EBA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665A61F2230D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7214A088;
	Mon, 13 May 2024 10:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B1487EC
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595422; cv=none; b=oTRU+t+8qnSlU1IyOnkPZFF8fZbGB+6WfRLsanExTEa439iDhAxfVMKz5MDkV0x97FLPBX0/NoXwzEdPL2uvRd6tjkaClgLBQTaFi7E3Onv3Zm5OnymDZBVkTiheqTojmF5J6QAwB57DseTTpZhlDj0Voj1e96nwpLxtpCutB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595422; c=relaxed/simple;
	bh=DC8k8kR4rqntnjIWBWVWRgtiIvWvURVycOjvWUecDKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuSWgWyYst/jupP03aiRVNwcMFOhGYj7Lzg553/8RF60GQQDcJI19g9MQRH8s3Q4HG43H4hUPOdC+AA98cnvMVMOAsatiYo+sF1uMJvADDADz3BoiNPNHQ/FuLj+cDe6iGXAYPoPud7FNONriwdIqX1mhWA38zyOtThpl0l+Q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8BxtOqZ6EFmsSIMAA--.17549S3;
	Mon, 13 May 2024 18:16:57 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxtFaX6EFmHdEcAA--.34929S3;
	Mon, 13 May 2024 18:16:56 +0800 (CST)
Message-ID: <67de62f1-c4c5-4534-979a-7eb430a836de@loongson.cn>
Date: Mon, 13 May 2024 18:16:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 12/15] net: stmmac: dwmac-loongson: Fixed
 failure to set network speed to 1000.
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <9b9f8ddd1e3ac9e05fa0d15585e172a4965f675f.1714046812.git.siyanteng@loongson.cn>
 <2pxumw5ctsnvr2mzqxnj7lvlzttxtokmzhwvswmq7ujigatdsz@mcfh5tlte3cl>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <2pxumw5ctsnvr2mzqxnj7lvlzttxtokmzhwvswmq7ujigatdsz@mcfh5tlte3cl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxtFaX6EFmHdEcAA--.34929S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zry3uFykZryxCw13tF15ZFc_yoW8Kry5pr
	93Aa4a9rZFqr17Cws3Zwn8ZF95ZFW2qrWkWF4Iywn3uF93AayjqryjvFWY9Fy7Ars5ZF1a
	qrWUur4UWFs8CrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU28nYUUUUU


在 2024/5/5 06:13, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:10:37PM +0800, Yanteng Si wrote:
>> GNET devices with dev revision 0x00 do not support manually
>> setting the speed to 1000.
>>
>> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 8 ++++++++
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
>>   include/linux/stmmac.h                               | 1 +
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index df5899bec91a..a16bba389417 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -10,6 +10,7 @@
>>   #include "stmmac.h"
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>>   
>>   struct stmmac_pci_info {
>>   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>> @@ -179,6 +180,13 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   
>>   	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>>   
>> +	/* GNET devices with dev revision 0x00 do not support manually
>> +	 * setting the speed to 1000.
>> +	 */
>> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
>> +	    pdev->revision == 0x00)
>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>> +
> That's why it's important to wait for the discussions being finished.
> If you waited for some time I would have told you that the only part
> what was required to move to the separate patch was the changes in the
> files:
> drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> include/linux/stmmac.h
>
> So please move the changes above to the patch
> [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> * with the flag setup being done in the loongson_gnet_data() method.
>
> Thus you'll be able to drop the patch 14
> [PATCH net-next v12 14/15] net: stmmac: dwmac-loongson: Move disable_force flag to _gnet_date

OK.


Thanks,

Yanteng


