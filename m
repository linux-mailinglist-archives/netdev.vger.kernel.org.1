Return-Path: <netdev+bounces-160725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A34BA1AF5F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 05:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BDC16D436
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CE1D86C3;
	Fri, 24 Jan 2025 04:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EA1D63DF;
	Fri, 24 Jan 2025 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737692398; cv=none; b=p+nKxa/CrXggxAIiQenTxJxKbyH4mqbh2pCrLqFqzSf0oyofsEPsel70YEzqTNPXQiWKR9pXSF3b5HCeAx+UiBR5Mr7zdipXWREmiMe2zE9WfucKDPtRbTkGsi3GsMZYnY4FdfTAVlbKrtalauIc2xc+WoczqzkzwI6DpihT5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737692398; c=relaxed/simple;
	bh=tpq5jTfoYJOX3ibbIX4ypawNPCdAI1pRymruM7jn1IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R54dGLoneTkI3mnjiLf8iLAzxbU83LYrFCwprXabKO/oOQ/oTKFePr0hEJI6rydfojHpvbxuDUb1yCosgxwMyjMs3yZ6E6deCxW1ruIRSntworY+UCg0LubPqbQWsY4piTvs7TYl4Yg/9osV3WCnSM4Ea8C5L0wGzd63yno4Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jan 2025 13:19:53 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D7721208E511;
	Fri, 24 Jan 2025 13:19:53 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 24 Jan 2025 13:19:53 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 7A0E0E1E;
	Fri, 24 Jan 2025 13:19:53 +0900 (JST)
Message-ID: <c634eb72-6714-47e8-9270-b4ae99df9edf@socionext.com>
Date: Fri, 24 Jan 2025 13:19:53 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] Limit devicetree parameters to hardware
 capability
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <Z492Mvw-BxLBR1eZ@shell.armlinux.org.uk>
 <ea845c58-ee2a-4660-bc13-7e05003de5d0@socionext.com>
 <Z5Ju0DtNDwj_hO0F@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z5Ju0DtNDwj_hO0F@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,

On 2025/01/24 1:31, Russell King (Oracle) wrote:
> On Thu, Jan 23, 2025 at 02:25:15PM +0900, Kunihiko Hayashi wrote:
>> Hi Russell,
>>
>> Thank you for your comment.
>>
>> On 2025/01/21 19:25, Russell King (Oracle) wrote:
>>> On Tue, Jan 21, 2025 at 01:41:35PM +0900, Kunihiko Hayashi wrote:
>>>> This series includes patches that checks the devicetree properties,
>>>> the number of MTL queues and FIFO size values, and if these
> specified
>>>> values exceed the value contained in the hardware capabilities,
> limit to
>>>> the values from the capabilities.
>>>>
>>>> And this sets hardware capability values if FIFO sizes are not
> specified
>>>> and removes redundant lines.
>>>
>>> I think you also indeed to explain why (and possibly understand) - if
>>> there are hardware capabilities that describe these parameters - it
> has
>>> been necessary to have them in firmware as well.
>>>
>>> There are two scenarios I can think of why these would be duplicated:
>>>
>>> 1. firmware/platform capabilities are there to correct wrong values
>>>      provided by the hardware.
>>> 2. firmware/platform capabilities are there to reduce the parameters
>>>      below hardware maximums.
>>>
>>> Which it is affects whether your patch is correct or not, and thus
> needs
>>> to be mentioned.
>>
>> I think scenario 2 applies in this case.
> 
> In light of my other reply
> (https://lore.kernel.org/r/Z4_ZilVFKacuAUE8@shell.armlinux.org.uk) I
> don't think either of my two above applies, and the driver is designed
> to allow platform code to override the hardware value, or to provide
> the value if there is no hardware value.

I understand. Especially I realized that I had to care about some hardwares
not having these values.

> My suggestion, therefore, would be (e.g.):
> 
> 	if (priv->dma_cap.rx_fifo_size &&
> 	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
> 		dev_warn(priv->device,
> 			 "Rx FIFO size exceeds dma capability (%d)\n",
> 			 priv->plat->rx_fifo_size);
> 		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
> 	}
> 
> if we still want to limit it to the hardware provided capability, where
> that is provided.

Thank you for your suggestion. I also came up with the same code in:
https://lore.kernel.org/all/c2aa354d-1bd5-4fb0-aa8b8-48fcce3c1628@socionext.com/#t

I'll reflect this code to the next.

Thank you,

---
Best Regards
Kunihiko Hayashi

