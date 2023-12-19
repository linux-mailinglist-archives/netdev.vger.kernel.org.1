Return-Path: <netdev+bounces-58886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1281878E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823A8283BE7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542517758;
	Tue, 19 Dec 2023 12:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8818032
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8DxVPALjoFl0psCAA--.13345S3;
	Tue, 19 Dec 2023 20:35:23 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxG+QGjoFlq1EAAA--.2197S3;
	Tue, 19 Dec 2023 20:35:19 +0800 (CST)
Message-ID: <885a8904-9412-411d-9995-7d3ff350f309@loongson.cn>
Date: Tue, 19 Dec 2023 20:35:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] stmmac: Add Loongson platform support
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, loongarch@lists.linux.dev,
 chris.chenfeiyang@gmail.com
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <pwdr6mampxe33jpqdf6o5xczgd4qkdttqj4tvionxl7qbry2ek@hpadl7wi4zni>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <pwdr6mampxe33jpqdf6o5xczgd4qkdttqj4tvionxl7qbry2ek@hpadl7wi4zni>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxG+QGjoFlq1EAAA--.2197S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF47GF1fWFyrCw1rZr18Zwc_yoW5KF4Dpr
	W7Za4YgrZrtr1xA3ZYyw1DXry5Way3tr4UWa1ftr1fCFWq9ryjq34a9FWY9Fy7Zrs8uFy2
	qF1UCr1qk3WDArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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


在 2023/12/14 23:15, Serge Semin 写道:
> Hi Yanteng
>
> On Wed, Dec 13, 2023 at 06:12:22PM +0800, Yanteng Si wrote:
>> v6:
>>
>> * Refer to Serge's suggestion:
>>    - Add new platform feature flag:
>>      include/linux/stmmac.h:
>>      +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>>
>>    - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
>>       drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
>>       +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Normal Loongson Tx/Rx Summary */
>>       #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
>>       ...
>>
>>    - Drop all of redundant changes that don't require the
>>      prototypes being converted to accepting the stmmac_priv
>>      pointer.
>>
>> * Refer to andrew's suggestion:
>>    - Drop white space changes.
>>    - break patch up into lots of smaller parts.
>>       Some small patches have been put into another series as a preparation
>>       see <https://lore.kernel.org/loongarch/cover.1702289232.git.siyanteng@loongson.cn/T/#t>
>>       
>>       *note* : This series of patches relies on the three small patches above.
>> * others
>>    - Drop irq_flags changes.
>>    - Changed patch order.
> Thanks for submitting the updated series. I'll have a closer look at
> it on the next week.

I have prepared a new patch version and will CC you soon, so you can go 
straight

to the v7.


Thank,

Yanteng

>
> -Serge(y)
>
>>
>>
>> v4 -> v5:
>>
>> * Remove an ugly and useless patch (fix channel number).
>> * Remove the non-standard dma64 driver code, and also remove
>>    the HWIF entries, since the associated custom callbacks no
>>    longer exist.
>> * Refer to Serge's suggestion: Update the dwmac1000_dma.c to
>>    support the multi-DMA-channels controller setup.
>>
>> See:
>> v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
>> v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
>> v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
>> v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>
>>
>> Yanteng Si (9):
>>    net: stmmac: Pass stmmac_priv and chan in some callbacks
>>    net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
>>    net: stmmac: dwmac-loongson: Add full PCI support
>>    net: stmmac: Add multi-channel supports
>>    net: stmmac: Add Loongson-specific register definitions
>>    net: stmmac: dwmac-loongson: Add MSI support
>>    net: stmmac: dwmac-loongson: Add GNET support
>>    net: stmmac: dwmac-loongson: Disable flow control for GMAC
>>    net: stmmac: Disable coe for some Loongson GNET
>>
>>   drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 296 ++++++++++++++----
>>   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
>>   .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  61 +++-
>>   .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
>>   .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
>>   .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  47 ++-
>>   .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  65 ++--
>>   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
>>   drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +-
>>   drivers/net/ethernet/stmicro/stmmac/hwif.h    |  11 +-
>>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +-
>>   include/linux/stmmac.h                        |   4 +
>>   14 files changed, 413 insertions(+), 107 deletions(-)
>>
>> -- 
>> 2.31.4
>>


