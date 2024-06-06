Return-Path: <netdev+bounces-101404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6928FE67D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE291F2344A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFED6194AE0;
	Thu,  6 Jun 2024 12:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8001850B6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676834; cv=none; b=aLZ1Xx1ycBGqzDduxvDNIE4HKAiWcPZI8UELYqrZH/R7FaetmFG3fwWWXcYlbOxhdko73UYNiRiK9eA72wANhyed0U67pGyq3SoFvsqLrfRyhj35hWh2OPNpt4ymeeRbjTm3HuwEvCtC370HlEIfUipuBbltvX4SzyYBNVwQun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676834; c=relaxed/simple;
	bh=um+77IZuQgKHWA5fOlt4Ua9ZC3f6mNekDkmSdLiFt8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTnEY8WEtfTQoBtHa2ok+SQho6X6HWwTGM14L5LaPlwItywQ00TAt7QdKrAUMLabm+tzqja8HCpESVdU30SmA1/1LA+TeIEkgb9JC2Lgnxaax/rMFViAoBUSsYiAlxPz/k0Zzuxcx1sx6DyqQm26KRkp9TL1W/aV1Kra/Y6vvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxX+sdq2FmojkEAA--.17917S3;
	Thu, 06 Jun 2024 20:27:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvscbq2FmWOUWAA--.57612S3;
	Thu, 06 Jun 2024 20:27:08 +0800 (CST)
Message-ID: <7e3dfe3a-8cdb-46fa-bc3a-0b4071bb78af@loongson.cn>
Date: Thu, 6 Jun 2024 20:27:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/15] stmmac: Add Loongson platform support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <l3zwis67sv4yzmpsryl5oyzxhpvbj4mkpmcntjez2ofhnvmyw2@fqy7mc6fcvvy>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <l3zwis67sv4yzmpsryl5oyzxhpvbj4mkpmcntjez2ofhnvmyw2@fqy7mc6fcvvy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dxvscbq2FmWOUWAA--.57612S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryfXFy5tFWrJr4rAF48Xwc_yoW8AF4Upr
	4rCFWfG3s8tr1fKFs8Zw48X34FyrZ5Cry8Jr1Yyr1kC3sxArWxJ34kKws8C34kur18CrWj
	qayvvrZ8Za15ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

Hi Serge,

在 2024/6/5 19:30, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:17:22PM +0800, Yanteng Si wrote:
>> v13:
>>
>> * Sorry, we have clarified some things in the past 10 days. I did not
>>   give you a clear reply to the following questions in v12, so I need
>>   to reply again:
>>
>>   1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
>>      channels, so we have to reconsider the initialization of
>>      tx/rx_queues_to_use into probe();
>>
>>   2. In v12, we disagreed on the loongson_dwmac_msi_config method, but I changed
>>      it based on Serge's comments(If I understand correctly):
>> 	if (dev_of_node(&pdev->dev)) {
>> 		ret = loongson_dwmac_dt_config(pdev, plat, &res);
>> 	}
>>
>> 	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
>> 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
>> 	} else {
>> 		ret = loongson_dwmac_intx_config(pdev, plat, &res);
>> 	}
>>
>>   3. Our priv->dma_cap.pcs is false, so let's use PHY_INTERFACE_MODE_NA;
>>
>>   4. Our GMAC does not support Delay, so let's use PHY_INTERFACE_MODE_RGMII_ID,
>>      the current dts is wrong, a fix patch will be sent to the LoongArch list
>>      later.
>>
>> Others:
>> * Re-split a part of the patch (it seems we do this with every version);
>> * Copied Serge's comments into the commit message of patch;
>> * Fixed the stmmac_dma_operation_mode() method;
>> * Changed some code comments.
> Thanks for the new version of the series submitted. I've received the
> copy and all the currently posted comments. Alas I'll be busy on this
> week to join the discussions and start reviewing the bits. I'll be
> able to do that early next week. Sorry for making you and the rest of
> reviewers wait.

Thanks for your reply.

Ok, I just had time to test Huacai's method.


Thanks,

Yanteng


