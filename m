Return-Path: <netdev+bounces-162003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E9A2516C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 03:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAD1883CBB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 02:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52C7082B;
	Mon,  3 Feb 2025 02:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0570803;
	Mon,  3 Feb 2025 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550716; cv=none; b=Sq13JAosIAfxxqULO0eWB85vJGFlcJkS0i7S2mq2pabVGj3WYJNuDZFQuHyYNOiQpvYMzt2EDnnZmIImrVCaFIpKS4DIws4tVb2Nc+lyImOW0NhSpMHv9tNb6fZh3NDkNSm+TTvvG0AziXd9Pz3L8KxVUdP+a2kwK3eiWHPDrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550716; c=relaxed/simple;
	bh=5RB+ANAI/sMP6FypfR/rEHg7UPsxBcpF3uvlCMQl0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7+5Ud33XVHyI3lcByWuyudzDSpHIFUUIb71vzFK+R95HR7yLqQpzGvJvfqYQrK/570GvMKzZp6XWpxuedDhCHjcnyRuzeKUdvqKvQIn5d68aGrtE1tZCvpaUhAhi1Ux4WuWw9xlH73U/mrATuHckVVdu8X1fSWVWXIUhpkHBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Feb 2025 11:45:06 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 86B522006FCC;
	Mon,  3 Feb 2025 11:45:06 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 3 Feb 2025 11:45:06 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id EC03D388;
	Mon,  3 Feb 2025 11:45:05 +0900 (JST)
Message-ID: <905127b5-96c8-4866-8f69-d9d8a7091c99@socionext.com>
Date: Mon, 3 Feb 2025 11:45:05 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability value
 when FIFO size isn't specified
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
 <4e98f967-f636-46fb-9eca-d383b9495b86@roeck-us.net>
 <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z56FmH968FUGkC5J@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 2025/02/02 5:35, Russell King (Oracle) wrote:
> On Sat, Feb 01, 2025 at 11:14:41AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jan 27, 2025 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
>>> When Tx/Rx FIFO size is not specified in advance, the driver checks if
>>> the value is zero and sets the hardware capability value in functions
>>> where that value is used.
>>>
>>> Consolidate the check and settings into function stmmac_hw_init() and
>>> remove redundant other statements.
>>>
>>> If FIFO size is zero and the hardware capability also doesn't have
> upper
>>> limit values, return with an error message.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> This patch breaks qemu's stmmac emulation, for example for
>> npcm750-evb. The error message is:
>> 	stmmaceth f0804000.eth: Can't specify Rx FIFO size

Sorry for inconvenience.

> Interesting. I looked at QEMU to see whether anything in the Debian
> stable version of QEMU might possibly have STMMAC emulation, but
> drew a blank... Even trying to find where in QEMU it emulates the
> STMMAC. I do see that it does include this, so maybe I can use that
> to test some of my stmmac changes. Thanks!
> 
>> The setup function called for the emulated hardware is
> dwmac1000_setup().
>> That function does not set the DMA rx or tx fifo size.
>>
>> At the same time, the rx and tx fifo size is not provided in the
>> devicetree file (nuvoton-npcm750.dtsi), so the failure is obvious.
>>
>> I understand that the real hardware may be based on a more recent
>> version of the DWMAC IP which provides the DMA tx/rx fifo size, but
>> I do wonder: Are the benefits of this patch so substantial that it
>> warrants breaking the qemu emulation of this network interface > 
> Please see my message sent a while back on an earlier revision of this
> patch series. I reviewed the stmmac driver for the fifo sizes and
> documented what I found.
> 
> https://lore.kernel.org/r/Z4_ZilVFKacuAUE8@shell.armlinux.org.uk
> 
> To save clicking on the link, I'll reproduce the relevant part below.
> It appears that dwmac1000 has no way to specify the FIFO size, and
> thus would have priv->dma_cap.rx_fifo_size and
> priv->dma_cap.tx_fifo_size set to zero.
> 
> Given the responses, I'm now of the opinion that the patch series is
> wrong, and probably should be reverted - I never really understood
> the motivation why the series was necessary. It seemed to me to be a
> "wouldn't it be nice if" series rather than something that is
> functionally necessary.
> 
> 
> Here's the extract from my previous email:
> 
> Now looking at the defintions:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_RXFIFOSIZE
> GENMASK(4, 0)
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define
> XGMAC_HWFEAT_RXFIFOSIZE GENMASK(4, 0)
> 
> So there's a 5-bit bitfield that describes the receive FIFO size for
> these two MACs. Then we have:
> 
> drivers/net/ethernet/stmicro/stmmac/common.h:#define
> DMA_HW_FEAT_RXFIFOSIZE    0x00080000       /* Rx FIFO > 2048 Bytes */
> 
> which is used here:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:
> dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
> 
> which is only used to print a Y/N value in a debugfs file, otherwise
> having no bearing on driver behaviour.
> 
> So, I suspect MACs other than xgmac2 or dwmac4 do not have the ability
> to describe the hardware FIFO sizes in hardware, thus why there's the
> override and no checking of what the platform provided - and doing so
> would break the driver. This is my interpretation from the code alone.
> 

The {tx,rx}_queus_to_use are referenced in stmmac_ethtool.c, stmmac_tc.c,
and stmmac_selftests.c as the number of queues, so I've thought that
these variables should not be non-zero.

However, currently the variables are allowed to be zero, so I understand
this patch 3/3 breaks on the chips that hasn't hardware capabilities.

In hwif.c, stmmac_hw[] defines four patterns of hardwares:

"dwmac100"  .gmac=false, .gmac4=false, .xgmac=false, .get_hw_feature = NULL
"dwmac1000" .gmac=true,  .gmac4=false, .xgmac=false, .get_hw_feature = dwmac1000_get_hw_feature()
"dwmac4"    .gmac=false, .gmac4=true,  .xgmac=false, .get_hw_feature = dwmac4_get_hw_feature()
"dwxgmac2"  .gmac=false, .gmac4=false, .xgmac=true , .get_hw_feature = dwxgmac2_get_hw_feature()

As Russell said, the dwmac100 can't get the number of queues from the hardware
capability. And some environments (at least QEMU device that Guenter said)
seems the capability values are zero in spite of dwmac1000.

Since I can't test all of the device patterns, so I appreciate checking each
hardware and finding the issue.

The patch 3/3 includes some cleanup and code reduction, though, I think
it would be better to revert it once.

Thank you,

---
Best Regards
Kunihiko Hayashi

