Return-Path: <netdev+bounces-58502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290E816A92
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163FA1F21CB3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9812B9B;
	Mon, 18 Dec 2023 10:09:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2606134A9
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.193])
	by gateway (Coremail) with SMTP id _____8CxO+ltGoBlpAcCAA--.10734S3;
	Mon, 18 Dec 2023 18:09:49 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.193])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxkuNqGoBl3Q0KAA--.47878S3;
	Mon, 18 Dec 2023 18:09:47 +0800 (CST)
Message-ID: <46ffe0a3-f870-431d-aff3-69ccb0c93615@loongson.cn>
Date: Mon, 18 Dec 2023 18:09:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] net: stmmac: Pass stmmac_priv and chan in some
 callbacks
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, loongarch@lists.linux.dev,
 chris.chenfeiyang@gmail.com
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <361389e731d14e3e2094f6ff5501597e9f762f34.1702458672.git.siyanteng@loongson.cn>
 <759f33f0-e75a-406b-9318-272e50f2ec3b@lunn.ch>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <759f33f0-e75a-406b-9318-272e50f2ec3b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxkuNqGoBl3Q0KAA--.47878S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1rGr1rWrWfXF18Aw43Jwc_yoW8GF45pF
	1fJ3s3Gas5trWfXa1kJr4DXryUJF1xJw18XF1xGFn2ya1Yyr12qr1vg3yvgryUAFZ2gw15
	Jr4jqF1DZrWUJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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


在 2023/12/16 21:01, Andrew Lunn 写道:
>> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
>> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>
>>   
>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> As i've said a few times, i don't know this driver.
>
> Is it a queue or is it a chan? Is this change consistent with the
> reset of the code base?

It is a chan, but there is only queue here. so we refer to dwmac4:

static void dwmac4_rx_watchdog(struct stmmac_priv *priv, void __iomem 
*ioaddr,
                    u32 riwt, u32 queue)
{
     const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;

     writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(dwmac4_addrs, queue));
}

---------------------------------------------------------------------------------

@@ -271,12 +299,13 @@ static int dwmac1000_get_hw_feature(void __iomem 
*ioaddr,
  static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
                    void __iomem *ioaddr, u32 riwt, u32 queue)
  {
-    writel(riwt, ioaddr + DMA_RX_WATCHDOG);
+    writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
  }


We also use queue instead of chan.


Thanks,

Yanteng

>        Andrew


