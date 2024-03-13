Return-Path: <netdev+bounces-79634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79587A4F5
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6514D1F210F2
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2CE1B59B;
	Wed, 13 Mar 2024 09:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1631CD00
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321941; cv=none; b=dDfy6EILvm+9udYhZAmOImo0BPeW4t0V5newIiIbr4bETYR2LRLbQLHxHXhtFks8IhGmwKjMwqNV/2zH6fRYS5TFSbzkPfMDnUAZPvSBnqmTY2dc40K3jPRxbPgDJBaWJ3Kh1mujtxGBae/AveKnd5rKtM7YSC7ijPkXOEXHLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321941; c=relaxed/simple;
	bh=xPmlAO4OygtzARMTMGDePmEdRnpSNfe7tP6+Tu9YKPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oh9IXdIh2qPe9IIUaJ+MxWAm8CSSMIUkAZYEDXOc8jYLNPA2qcdOYX36kYd+mOA1LEg/T96z9q/xtCI7Xja1wpKXsUS90B06i/ntOZ3rhRHH92ayqirwqmhvceFZiumpb2G+ngtrKc6obMA07VDKV2q4kK+sUmrK/f+IDEQWtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxXesRcfFlflwYAA--.59333S3;
	Wed, 13 Mar 2024 17:25:37 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXRMOcfFlgGVYAA--.36368S3;
	Wed, 13 Mar 2024 17:25:35 +0800 (CST)
Message-ID: <b2f51826-6c23-4754-89cd-d9b5acc90ac8@loongson.cn>
Date: Wed, 13 Mar 2024 17:25:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 10/11] net: stmmac: dwmac-loongson: Disable
 flow control for GMAC
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <101bfd570686485c59a325f65c5d0328c6cd91dd.1706601050.git.siyanteng@loongson.cn>
 <7iyirk4une53gmiabdk5j7rhsehdbqegmz5tyhhcyx4wae5i7s@5x6ueq527l6d>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <7iyirk4une53gmiabdk5j7rhsehdbqegmz5tyhhcyx4wae5i7s@5x6ueq527l6d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXRMOcfFlgGVYAA--.36368S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr13KFy3Gry7Kry7Gr15GFX_yoW5Wr17p3
	9rAa4j9FyDJF17Jan5Aw1DZFy5Wa47KFWUuayxK3yS9FsFk34vqr1YvFW5AF17urWDWFyS
	qr1Uur1DCF9xJFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/2/6 06:13, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:49:15PM +0800, Yanteng Si wrote:
>> Loongson GMAC does not support Flow Control feature. Set flags to
>> disable it.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 6 +++---
>>   include/linux/stmmac.h                               | 1 +
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 1753a3c46b77..b78a73ea748b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -335,6 +335,7 @@ static int loongson_gmac_config(struct pci_dev *pdev,
>>   				struct stmmac_resources *res,
>>   				struct device_node *np)
>>   {
>> +	plat->flags |= STMMAC_FLAG_DISABLE_FLOW_CONTROL;
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 3aa862269eb0..8d676cbfba1e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1237,9 +1237,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>>   		xpcs_get_interfaces(priv->hw->xpcs,
>>   				    priv->phylink_config.supported_interfaces);
>>   
>> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> -						MAC_10FD | MAC_100FD |
>> -						MAC_1000FD;
>> +	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	if (!(priv->plat->flags & STMMAC_FLAG_DISABLE_FLOW_CONTROL))
>> +		priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>>   
>>   	stmmac_set_half_duplex(priv);
>>   
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index 197f6f914104..832cd8cd688f 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -223,6 +223,7 @@ struct dwmac4_addrs {
>>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>   #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
>>   #define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>> +#define STMMAC_FLAG_DISABLE_FLOW_CONTROL	BIT(15)
> See my last comment in patch 9/11. This can be reached by re-defining
> the stmmac_ops::phylink_get_caps() callback.

OK.


Thanks,

Yanteng

>
> -Serge(y)
>
>>   
>>   struct plat_stmmacenet_data {
>>   	int bus_id;
>> -- 
>> 2.31.4
>>


