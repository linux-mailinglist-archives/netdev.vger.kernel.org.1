Return-Path: <netdev+bounces-95964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD58C3EBE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469AD284064
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F7149E01;
	Mon, 13 May 2024 10:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB948149E10
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595636; cv=none; b=P+CY4Ltvr5XG4HaThW6ZJkxc1ok3nCtuCOCmcdSaAdixO5HJsuTybC6T7Ic+yS+m8a2TYCRcZH4m9g4IlfbnGLTwbAho8bJ4EYRQr5SIcjg2zTVRKP/MBPdQnH+XcCxtyvMNMi/hB4H73uc134bOM5jPYjh/0yTXvbHl0PG2mZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595636; c=relaxed/simple;
	bh=qxzVQPWGWD5cQCveaTxpVUfvO44No6ZvKjrTDJvferw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYc96K5zBF8lxPUG/J4zKLqDF1o2MHVLVl3LcfFJIeTqEsK6OfvqqjmRsag6HBsbUEVKTcRiMFdXpjFJc2OUID0rxmZj/cKMTjboQb2R3cddUqBFy3Qq8typRxJFxYWw161525svpaQIlH7VMmK7Lr02mT+6QMLfmIombTwVJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8DxNvBw6UFm8iIMAA--.29742S3;
	Mon, 13 May 2024 18:20:32 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxwVVu6UFm7tEcAA--.35755S3;
	Mon, 13 May 2024 18:20:30 +0800 (CST)
Message-ID: <3eefdc82-d149-47ed-86d4-57d2c11135ce@loongson.cn>
Date: Mon, 13 May 2024 18:20:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 14/15] net: stmmac: dwmac-loongson: Move
 disable_force flag to _gnet_date
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <7235e4af89c169e79f0404a3dc953f1756bab196.1714046812.git.siyanteng@loongson.cn>
 <djycwp72pttsu6tnczzhgzncq77ljg7ugb4mvhi2sgqcirielg@uknifyazm3dt>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <djycwp72pttsu6tnczzhgzncq77ljg7ugb4mvhi2sgqcirielg@uknifyazm3dt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxwVVu6UFm7tEcAA--.35755S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWfGF4kGF43uF47JFW5Jwc_yoW8uF45pr
	Z3Ca4a9ryftr1UGanxJryDXF909FW5trWkWF42y3sIgF97C342qry2kFWjvry7ZrWkZFy2
	qr48ur18uFn8CacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7K9aDUUUU


在 2024/5/6 05:53, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:11:37PM +0800, Yanteng Si wrote:
>> We've already introduced loongson_gnet_data(), so the
>> STMMAC_FLAG_DISABLE_FORCE_1000 should be take away from
>> loongson_dwmac_probe().
>>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 68de90c44feb..dea02de030e6 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -286,6 +286,12 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>>   	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
>>   	plat->fix_mac_speed = loongson_gnet_fix_speed;
>>   
>> +	/* GNET devices with dev revision 0x00 do not support manually
>> +	 * setting the speed to 1000.
>> +	 */
>> +	if (pdev->revision == 0x00)
>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>> +
> Just introduce the change above in the framework of the patch
> [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> and ...
OK.
>
>>   	return 0;
>>   }
>>   
>> @@ -540,13 +546,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		break;
>>   	}
>>   
>> -	/* GNET devices with dev revision 0x00 do not support manually
>> -	 * setting the speed to 1000.
>> -	 */
>> -	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
>> -	    pdev->revision == 0x00)
>> -		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>> -
> ... you won't to have this being undone. So this patch won't be even
> needed to be introduced.
>
> See my comment sent to
> [PATCH net-next v12 12/15] net: stmmac: dwmac-loongson: Fixed failure to set network speed to 1000.
>
OK.


Thanks,

Yanteng


