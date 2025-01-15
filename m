Return-Path: <netdev+bounces-158438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4661A11D77
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A36E7A123F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999C248177;
	Wed, 15 Jan 2025 09:23:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C8248171;
	Wed, 15 Jan 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933020; cv=none; b=Cp+DYNFgPM9VLscaEJwBqi6G87eH7drIiqXOy8ZwEd1ih8Au4Xb0+emA8Fa6de38hMVOm5HdBUqwGcln8Z6keOfig2Gr90o04VdvA85p9T54/lf2SZLzVOjxq1btpGZN5niD3eWJhzv9MNJmuX675U92AxIsk7k7lq+uuWYPPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933020; c=relaxed/simple;
	bh=u9nQ62Cqws90qRdvAbxG1Lsc7wDKsH8xbteVuDu2FWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx83A8XmHhbv1Q4/98Ftr0JxLb+D4MhoYyuL8hm+3/bMwl7TumNAOu4C79W8WJP+XoYo7aH0pOkahksJMGa85pvZUXOX6o6V7OKJ4RzZJMlzOJOGoN7YYcOlgTqtqsJztID+zOK+BZFZDdS1cOZvhCQgJjoRpmF2zVwjS901nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af1b4.dynamic.kabel-deutschland.de [95.90.241.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D6D261E64783;
	Wed, 15 Jan 2025 10:22:10 +0100 (CET)
Message-ID: <990a3fc9-7fd6-49b6-8918-d5bf4ae48953@molgen.mpg.de>
Date: Wed, 15 Jan 2025 10:22:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com,
 Andrew Lunn <andrew@lunn.ch>, schung@nuvoton.com, peppe.cavallaro@st.com,
 yclu4@nuvoton.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
 <2cf758f2-529e-4ccd-9dc1-18fc29ad5ac0@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2cf758f2-529e-4ccd-9dc1-18fc29ad5ac0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Joey,


Thank you for your prompt reply.


Am 15.01.25 um 10:03 schrieb Joey Lu:

> Paul Menzel 於 1/14/2025 9:49 AM 寫道:

[…]

>> Am 13.01.25 um 00:54 schrieb Joey Lu:
>>> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac 
>>> driver.

[…]

>> Also, please document how tested the driver. Maybe even paste new log 
>> messages.
> 
> These are the kernel configurations for testing the MA35D1 GMAC driver: 
> ARCH_MA35, STMMAC_PLATFORM, DWMAC_NUVOTON.
> 
> I'm not sure if this information is sufficient, so please provide some 
> guidance on what else I should include to meet your requirements.

I’d be interested on what hardware you tested it. Probably some 
evaluation or customer reference board.

> I will include the log messages at the end of the email.

Awesome. Thank you. Personally, I also like to see those in the commit 
message.

>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>
>> As you use your company email address in the AUTHOR line below, please 
>> also add that email address to the commit message (and maybe even as 
>> the author).
>
> I will update the AUTHOR to use my personal email address instead of the 
> company email.

Understood. (yclu4@nuvoton.com is also personal, but the Gmail address 
is private, I guess. ;-)).

For statistics, how companies contribute to the Linux kernel, having the 
company address somewhere would be nice though, as you are doing this as 
your work at Nuvoton, right?

>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
>>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>>>   .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 179 ++++++++++++++++++
>>>   3 files changed, 191 insertions(+)
>>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

[…]

> log:
> 
> [    T0] Booting Linux on physical CPU 0x0000000000 [0x411fd040]

Out of curiosity, how do you get these timestamps T0, T1, …?

[…]


Thank you and kind regards,

Paul

