Return-Path: <netdev+bounces-59533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537781B2CB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 10:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079241F256FF
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B64C3B3;
	Thu, 21 Dec 2023 09:40:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207064C3C8
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8AxG+kcCIRlfGIDAA--.17203S3;
	Thu, 21 Dec 2023 17:40:44 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxvr4ZCIRlEYgDAA--.11380S3;
	Thu, 21 Dec 2023 17:40:42 +0800 (CST)
Message-ID: <a73cba7a-ecdc-40fc-a9f5-f67d4b809e79@loongson.cn>
Date: Thu, 21 Dec 2023 17:40:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/9] net: stmmac: Pass stmmac_priv and chan in
 some callbacks
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>
 <20231220150846.GL882741@kernel.org>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20231220150846.GL882741@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxvr4ZCIRlEYgDAA--.11380S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryrWw1DCFW3WFWUuF4DGFX_yoW5XFy7pF
	W7Aa4j9rZ7tr4fXan7Jw4rZFy5Xa9rt3y8ur48tws3WF4vka42qrn0gayYkryDZF4Fg3Wa
	vF45C3W3CFn8AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2023/12/20 23:08, Simon Horman 写道:
> On Tue, Dec 19, 2023 at 10:17:04PM +0800, Yanteng Si wrote:
>> Loongson GMAC and GNET have some special features. To prepare for that,
>> pass stmmac_priv and chan to more callbacks, and adjust the callbacks
>> accordingly.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c |  2 +-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  |  2 +-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    |  2 +-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     |  3 ++-
>>   drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     |  3 ++-
>>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  2 +-
>>   drivers/net/ethernet/stmicro/stmmac/hwif.h          | 11 ++++++-----
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 +++---
>>   9 files changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> index 137741b94122..7cdfa0bdb93a 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>>   	writel(v, ioaddr + EMAC_TX_CTL1);
>>   }
>>   
>> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
>> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>   {
>>   	u32 v;
>>   
> Hi Yanteng Si,
>
> perhaps dwmac-sun8i.c needs to be further updated for this change?
>
>    .../dwmac-sun8i.c:568:10: error: incompatible function pointer types initializing 'void (*)(struct stmmac_priv *, void *, struct stmmac_dma_cfg *, int)' with an expression of type 'void (void *, struct stmmac_dma_cfg *, int)' [-Wincompatible-function-pointer-types]
>      568 |         .init = sun8i_dwmac_dma_init,
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    .../dwmac-sun8i.c:574:29: error: incompatible function pointer types initializing 'void (*)(struct stmmac_priv *, void *, u32)' (aka 'void (*)(struct stmmac_priv *, void *, unsigned int)') with an expression of type 'void (void *, u32)' (aka 'void (void *, unsigned int)') [-Wincompatible-function-pointer-types]
>      574 |         .enable_dma_transmission = sun8i_dwmac_enable_dma_transmission,
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.

Sorry, I'll fix it.


Thanks,

Yanteng


