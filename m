Return-Path: <netdev+bounces-89856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B648ABE9E
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 07:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7E9B20B7F
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820279F2;
	Sun, 21 Apr 2024 05:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39538C
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713677729; cv=none; b=XM9VtJwZ7a7j+H5pW+z5F2QlZYhGR3/ZIcsfE5erkY0fUJN6Y1nB60KZEpUChsEANXsV2BIYThy84hLDt4Cny3P/8PSTJccJtNyIP/5ciNBo4dUbGp5WePruuuQwdfwCM75Djlspi8/y9qQq/7FbyaErnRFJSJQxJWFXlS03D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713677729; c=relaxed/simple;
	bh=anEBq/tG108x822NWjTleMjemuyuJwJDEcvy4KcP1aw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjfEQ8UVjqnStkZtv5m3ntE9qEI122TP93HThljTjaIA8bWDNSNFi8Xi+F3mLjycTYAYg/a8pXlawU0nuKUigyqmBER9SOcxyI/G7W7O08L+JHcGQFHLKwYq5MUMQFGnp0SDKZL3CM6AUqOui4PUUBhr4cIH17V8c2xy2xrqUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxSfGUpSRmaw8AAA--.459S3;
	Sun, 21 Apr 2024 13:35:16 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd6TpSRmRxIAAA--.477S3;
	Sun, 21 Apr 2024 13:35:16 +0800 (CST)
Message-ID: <932e5719-66d1-446d-b67c-4c87b00d63b0@loongson.cn>
Date: Sun, 21 Apr 2024 13:35:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
From: Yanteng Si <siyanteng@loongson.cn>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <9a8e5dfef0e9706e3d42bb20f59ea9ffa264dc8c.1712917541.git.siyanteng@loongson.cn>
 <jd4wmvwgmuzmdun3np3icp3lfinzhedq7enp5axqxs62ev4q2z@pl2ogfkscmqn>
 <da349ea7-e12f-4749-8c54-604f65780d9e@loongson.cn>
Content-Language: en-US
In-Reply-To: <da349ea7-e12f-4749-8c54-604f65780d9e@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxjd6TpSRmRxIAAA--.477S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFy5ArWfCw4fCry3GF1fZrc_yoW8XrW7pr
	9ayFyagry3Zrn2ywn3ZryDZFy0vr1Yyas5Gry8WF1UCFZ3Wr1YgryxuFWqvr17Ar4kZFy5
	Xr409r48uFn093gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/4/20 19:02, Yanteng Si 写道:
>>> - memset(&res, 0, sizeof(res));
>>> -    res.addr = pcim_iomap_table(pdev)[0];
>>> +    /* GNET devices with dev revision 0x00 do not support manually
>>> +     * setting the speed to 1000.
>>> +     */
>>> +    if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
>>> +        pdev->revision == 0x00)
>>> +        plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>> Move this to the loongson_gnet_data() method.
> Okay, But I noticed your comment at the end that we need to splite as a
>
> separate _pre-requisite/preparation_ patch, this fix is for gnet 
> devices, there is no gnet at this time. So, if I understand you 
> correctly, we should need two patches: net: stmmac: dwmac-loongson: 
> Disable force 1000 net: stmmac: dwmac-loongson: Add Loongson GNET 
> support net: stmmac: dwmac-loongson:  Move DISABLE_FORCE_1000 flag to 
> loongson_gnet_data() method

Sorry, my email client messed things up.

Okay, But I noticed your comment at the end that we need to splite as a

separate _pre-requisite/preparation_ patch, this fix is for gnet devices,

there is no gnet at this time. So, if I understand you correctly, we should

need two new patches:

++ net: stmmac: dwmac-loongson: Disable force 1000

     net: stmmac: dwmac-loongson: Add Loongson GNET support

++ net: stmmac: dwmac-loongson:  Move DISABLE_FORCE_1000 flag to 
loongson_gnet_data() method


Thanks,

Yanteng



