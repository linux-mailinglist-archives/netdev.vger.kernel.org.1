Return-Path: <netdev+bounces-160479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A608A19DFB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13B71889C5B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618B1BBBC8;
	Thu, 23 Jan 2025 05:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE39629;
	Thu, 23 Jan 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609926; cv=none; b=sMQC1J/l9H18QCPRt7SiR6QvMrDjCmmkgOtu6Ib7jGcFEoN2jir2aRg6G/SRBRaKSiLgkALMyo9DKgqMQ9p4UQOVekv7t5OccEL6iF2n56w690weUG9IXDlGZbOIbI8QuGCUNr5WafdWE3ohxCXHonyvuwzlaD60K/NqOmiIPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609926; c=relaxed/simple;
	bh=hZX4f1C3IKcT+RDgudSeFXkumcxovMK1N2gWB8bgits=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1bHuCL69VToXWnpfzhly48It4WcNBQUJUz4EA0XeAOoCPXG69y5lCurBtYJZWO92hJpOX39Mf4IJNt+Vv7Rgp/jWngqhUjrqSLeHNCkqOhl0PZh+DEkNgwPaA8N5MjJGR4hZhdDPnHou6735HK7je28zGXE/1Lg/w4w4ZT/UJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Jan 2025 14:25:16 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 37B5F200847D;
	Thu, 23 Jan 2025 14:25:16 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 23 Jan 2025 14:25:16 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id A448CAB183;
	Thu, 23 Jan 2025 14:25:15 +0900 (JST)
Message-ID: <ea845c58-ee2a-4660-bc13-7e05003de5d0@socionext.com>
Date: Thu, 23 Jan 2025 14:25:15 +0900
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
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Vince Bridgers <vbridger@opensource.altera.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <Z492Mvw-BxLBR1eZ@shell.armlinux.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z492Mvw-BxLBR1eZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Russell,

Thank you for your comment.

On 2025/01/21 19:25, Russell King (Oracle) wrote:
> On Tue, Jan 21, 2025 at 01:41:35PM +0900, Kunihiko Hayashi wrote:
>> This series includes patches that checks the devicetree properties,
>> the number of MTL queues and FIFO size values, and if these specified
>> values exceed the value contained in the hardware capabilities, limit to
>> the values from the capabilities.
>>
>> And this sets hardware capability values if FIFO sizes are not specified
>> and removes redundant lines.
> 
> I think you also indeed to explain why (and possibly understand) - if
> there are hardware capabilities that describe these parameters - it has
> been necessary to have them in firmware as well.
> 
> There are two scenarios I can think of why these would be duplicated:
> 
> 1. firmware/platform capabilities are there to correct wrong values
>     provided by the hardware.
> 2. firmware/platform capabilities are there to reduce the parameters
>     below hardware maximums.
> 
> Which it is affects whether your patch is correct or not, and thus needs
> to be mentioned.

I think scenario 2 applies in this case.

The queue values specified in devicetree bindings are defined as the
amount to be "used."

     number of TX queues to be used in the driver

And the fifo sizes specified in devicetree bindings are defined as a
"configurable" size.

     This is used for components that can have configurable receive fifo
     sizes, ...

If the amounts of hardware resources are available from the hardware
capabilities, it must be limited to these amounts because exceeding
that values will cause issues.

Otherwise, since there is no values to show hardware resources, specify
these values to be used directly in devicetree. In this case, the values
will be referenced without checking.

> Finally, as you are submitting to the net tree, you really need to
> describe what has regressed in the driver. To me, this looks like a new
> "feature" to validate parameters against the hardware.

Actually, I think that specifyin an arbitrary (too big) value might 
result in unexcepted behavior, and the limit of these parameters is
determined by:
- the max number that can be managed by software, or
- the amount of hardware resources.

> Please answer these points in this email thread. Please also include
> the explanation in future postings.

I'll pay attention next.

Thank you,

---
Best Regards
Kunihiko Hayashi

