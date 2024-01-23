Return-Path: <netdev+bounces-65032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D57E838EB6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29332288649
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000C5D8E7;
	Tue, 23 Jan 2024 12:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52276524AB
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014067; cv=none; b=Z5C+wSapxVH+CGQuGGVfK51aEL7BNTKR/m+OZHxGj75ImsiJtHvcMYhEMYLbwDf8eBGCjQsy1J/XBhrDAd4Ph23Ves/sUjF5VlEu58sNUQGY8EYY/wCjsq108T0N6qNxf9tEeEwA6nx0QT2SKSJk2jhXaWQP08812QlsejaI+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014067; c=relaxed/simple;
	bh=q9n00tnBFonXMjTna0qQYzgXk1NOjbjSEIkMY4LJ58A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/DpRn5C48xDKf91hONumeTabsWPITJKeLucoR8QFbE/38qkK5uG8uz9VGL88ZWpE2E+Bum4+8/Qlp4r8YXNvULcQCraWlQQDK25QGSZSDoHffIi0dA7P24qJbm07VHauXvPaJaw5+j2kW+QSSW5UWyo+VQsrVKuCxKoK0vTtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.155])
	by gateway (Coremail) with SMTP id _____8AxDOtvta9lsCYEAA--.6521S3;
	Tue, 23 Jan 2024 20:47:43 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.155])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxfs1tta9lNGoUAA--.24196S3;
	Tue, 23 Jan 2024 20:47:42 +0800 (CST)
Message-ID: <7615ea18-977e-41b2-80d1-93a4b970d52b@loongson.cn>
Date: Tue, 23 Jan 2024 20:47:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 9/9] net: stmmac: Disable coe for some
 Loongson GNET
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <479a6614d1fc4285c02953bf1ca181fa56942fb6.1702990507.git.siyanteng@loongson.cn>
 <axkfpgoyf2pd76k25563uzd5hfb5gsfr5cqlumn2gezai5xblj@h455tdgbogdh>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <axkfpgoyf2pd76k25563uzd5hfb5gsfr5cqlumn2gezai5xblj@h455tdgbogdh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dxfs1tta9lNGoUAA--.24196S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1kCw4rtrW3AF47Jr18Zwc_yoW8GF43pF
	W8Aa4jkF97Xr1UC3Zxtw4UXF98Ca97tFWUWF4xK3sxWan2k3s7tr15KFWY9r1xZr1FgFW2
	vrWUuwnxCFn8CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==


在 2023/12/21 10:36, Serge Semin 写道:
> On Tue, Dec 19, 2023 at 10:28:19PM +0800, Yanteng Si wrote:
>> Some chips of Loongson GNET does not support coe, so disable them.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/hwif.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
>> index 3724cf698de6..f211880925aa 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
>> @@ -73,6 +73,11 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
>>   		mac->desc = &ndesc_ops;
>>   	}
>>   
>> +	if (priv->synopsys_id == DWLGMAC_CORE_1_00) {
>> +		priv->plat->tx_coe = 0;
>> +		priv->plat->rx_coe = STMMAC_RX_COE_NONE;
>> +	}
> Couldn't this be done in dwmac-loongson.c?

Sorry for the late reply, I have been busy with patches 4 and 5.

I think I can give you a definite answer: This is possible, just like

the method you mentioned in patch 5, I only need to

overwrite ld->dwlgmac_dma_ops.get_hw_feature.


Thanks,

Yanteng

>
> -Serge(y)
>
>> +
>>   	stmmac_dwmac_mode_quirk(priv);
>>   	return 0;
>>   }
>> -- 
>> 2.31.4
>>


