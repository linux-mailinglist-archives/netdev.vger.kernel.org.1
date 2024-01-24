Return-Path: <netdev+bounces-65437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866483A750
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA830B2B3EA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46F199D9;
	Wed, 24 Jan 2024 10:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F11AAB9
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093702; cv=none; b=dYuAr/Axk0lMxXCC49hdcMERO5NuXjwloJ0qkXR+0yzB+nzEA4Bd8vq4mJpv5YLAvUtIE7DfsQnevYCyFzfnzjwSLkvJwQ8yUF3SjWi72tWsLEJaEnCXEH+RJRStgCICJsxIuJ8hBNiCqo9shW2mBod13yKkaNZEB9LGTWdgzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093702; c=relaxed/simple;
	bh=Keo6Vfpz0JdkOxM6RyL0ruR9XBey8eEEyX4NlFSdgD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWyqcDhncJfBC2S48CDfJtEXPUx4/YEXMNyyRR4hai3yBdr/+110kOSmSRgu4oExQZNyaPZwV6wI82fIhOB6to0vvYiWXcN2c6M5Y3YAmqrRw7/XZaJb7gYIAc9wd/3UlhnbmyPWhyLNG6KJYhH0QRn0XqzQvc+ebTfzL9t1xIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.155])
	by gateway (Coremail) with SMTP id _____8DxfeuB7LBlXbUEAA--.18399S3;
	Wed, 24 Jan 2024 18:54:57 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.155])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxdMx_7LBl3b0WAA--.52096S3;
	Wed, 24 Jan 2024 18:54:56 +0800 (CST)
Message-ID: <83f2dba6-1aec-4088-b1e0-e417b14fedb0@loongson.cn>
Date: Wed, 24 Jan 2024 18:54:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/9] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <89d95c7121117df7ce6236b330c443e13fdbaa80.1702990507.git.siyanteng@loongson.cn>
 <ex6xwrpnjbgq3vzvycyninsrdb2spc32t5aoiftnuq5aqkh4yx@fexrffrpec5l>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ex6xwrpnjbgq3vzvycyninsrdb2spc32t5aoiftnuq5aqkh4yx@fexrffrpec5l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxdMx_7LBl3b0WAA--.52096S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw43Gr4DGw1rtr17WFyUurX_yoW5WrWDpw
	s7Za4v9a4DtF17G3Z5Jw4qvF90ga47KFWUuF4Ikw4SvanFkryqqr1YqFW5AF17urWDWFWa
	qr1j9r1DCFnxAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2023/12/21 10:35, Serge Semin 写道:
> On Tue, Dec 19, 2023 at 10:28:18PM +0800, Yanteng Si wrote:
>> Loongson GMAC does not support Flow Control feature. Set flags to
>> disable it.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 6 +++---
>>   include/linux/stmmac.h                               | 1 +
>>   3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 9e4953c7e4e0..77c9bcb66a8e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -160,6 +160,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
>>   		break;
>>   	}
>>   
>> +	plat->flags |= FIELD_PREP(STMMAC_FLAG_DISABLE_FLOW_CONTROL, 1);
> Why FIELD_PREP()-ing?

This is very early code and will be changed to:

plat->flags |= STMMAC_FLAG_DISABLE_FLOW_CONTROL;

>
>> +
>>   	return ret;
>>   }
>>   
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 9764d2ab7e46..d94f61742772 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1236,9 +1236,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>>   		xpcs_get_interfaces(priv->hw->xpcs,
>>   				    priv->phylink_config.supported_interfaces);
>>   
>> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> -						MAC_10FD | MAC_100FD |
>> -						MAC_1000FD;
>> +	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	if (!FIELD_GET(STMMAC_FLAG_DISABLE_FLOW_CONTROL, priv->plat->flags))
> !(priv->plat->flags & STMMAC_FLAG_DISABLE_FLOW_CONTROL) ?

OK!


Thanks,

Yanteng

>
> -Serge(y)
>
>> +		priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>>   
>>   	stmmac_set_half_duplex(priv);
>>   
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index 067030cdb60f..5ece92e4d8c3 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -224,6 +224,7 @@ struct dwmac4_addrs {
>>   #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>>   #define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>>   #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
>> +#define STMMAC_FLAG_DISABLE_FLOW_CONTROL	BIT(16)
>>   
>>   struct plat_stmmacenet_data {
>>   	int bus_id;
>> -- 
>> 2.31.4
>>


