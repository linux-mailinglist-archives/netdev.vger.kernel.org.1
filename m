Return-Path: <netdev+bounces-66673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE98403AB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258CC1F22CA8
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551075B20F;
	Mon, 29 Jan 2024 11:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CE59B73
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527111; cv=none; b=L+oTypKmWBQoJoVbAaNals3BVhajBrhqfGr7c5Kz/uYf39f497wz3Rw4F8NX8LNHn95SQ+wTcURB3d6p6ua6S04K/JmiLXMurK6uQ+KHrp05p2IqYRBUwTB/1QMX9XgL4Z62FML2bP4Yu9/c2wvPviSl6EQt0OIl6/AREIu5i+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527111; c=relaxed/simple;
	bh=HlaOeVQhgkiwBN138UWGOaw01CFMLHbZqWHOv0XiVwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRWxu0R3Jehf5HX3iaxqf0p42GcFT9Qy0qXQ8CY6fOKqQ3KC5Ih4+dcRslq7WxYpJx/zKNtrg00tRpdtTDiPNa6Woc6fX7Dzr+918bpd/sD0JtM1c986Gh6OhChpjJRaOxOCJnvFb/uQloOUG+8MZG7c1J5+4Etshu6CVYX8Ie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8BxOPCBibdlEcEHAA--.24498S3;
	Mon, 29 Jan 2024 19:18:25 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhN7ibdlU4klAA--.27859S3;
	Mon, 29 Jan 2024 19:18:20 +0800 (CST)
Message-ID: <89242926-c87f-4902-9904-f5bd32164042@loongson.cn>
Date: Mon, 29 Jan 2024 19:18:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
To: Serge Semin <fancer.lancer@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
 <xrdvmc25btov77hfum245rbrncv3vfbfeh4fbscvcvdy4q4qhk@juizwhie4gaj>
 <44229f07-de98-4b47-a125-3301be185de6@loongson.cn>
 <72hx6yfvbxiuvkunzu2tvn6glum5rjrzqaxsswml2fe6j3537w@ahtfn7q64ffe>
 <ZbKrRL9W5D1kGn0F@shell.armlinux.org.uk>
 <52cjdjvgfiukshwoy276pega4tlaq3bouaw6syvjvmab5fbo5n@ugw6ztxjjgvl>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <52cjdjvgfiukshwoy276pega4tlaq3bouaw6syvjvmab5fbo5n@ugw6ztxjjgvl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhN7ibdlU4klAA--.27859S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4kXFWrtr1kXrWftF1UArc_yoW8WF1fpr
	W8A3W5KFW8Krn7tr1qyw1UtryFyrW3tw1DW3srtFy8tr1qgF1aqr12grWYgry7ur4ru3W2
	vF4F9w43u3WDJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/1/26 04:12, Serge Semin 写道:
> On Thu, Jan 25, 2024 at 06:41:08PM +0000, Russell King (Oracle) wrote:
>> On Thu, Jan 25, 2024 at 09:38:30PM +0300, Serge Semin wrote:
>>> On Thu, Jan 25, 2024 at 04:36:39PM +0800, Yanteng Si wrote:
>>>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c: In function
>>>> 'loongson_gnet_data':
>>>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:463:41: warning:
>>>> conversion from
>>>>
>>>> 'long unsigned int' to 'unsigned int' changes value from
>>>> '18446744073709551611' to '4294967291' [-Woverflow]
>>>>    463 |         plat->mdio_bus_data->phy_mask = ~BIT(2);
>>>>        |                                         ^
>>>>
>>>> Unfortunately, we don't have an unsigned int macro for BIT(nr).
>>> Then the alternative ~(1 << 2) would be still more readable then the
>>> open-coded literal like 0xfffffffb. What would be even better than
>>> that:
>>>
>>> #define LOONGSON_GNET_PHY_ADDR		0x2
>>> ...
>>> 	plat->mdio_bus_data->phy_mask = ~(1 << LOONGSON_GNET_PHY_ADDR);
>> 	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
>>
>> would also work.
> Right, explicit type casting will work too. Something
> deep inside always inclines me to avoid explicit casts, although in
> this case your option may look more readable than the open-coded
> bitwise shift.

OK!


Thanks,

Yanteng

>
> -Serge(y)
>
>>
>> -- 
>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


