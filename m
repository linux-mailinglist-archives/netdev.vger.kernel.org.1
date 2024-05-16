Return-Path: <netdev+bounces-96661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218088C6F7C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 02:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8194B22CAD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 00:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3E3C39;
	Thu, 16 May 2024 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ayMHRsU9"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29217E1;
	Thu, 16 May 2024 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819048; cv=none; b=e9R1koynFzTaE+50EcKg8TKOKhfVDe3Pm45KCnO8wr18MkF/d+xxMHvBf32zWVG7MmqkP2XN/NoQSi6iOOY9SR2Vs4Et74g5awhaK7cbA5zX9qy9agVrFUycan1idmRZ4PGXaevCbvuaw9BLkuGidGgT5DnrXnLbP9ENhEy0HKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819048; c=relaxed/simple;
	bh=LQrgsqIByN2f+qZpuZYvsf4zHse06e3f1SdS7MR9PyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkAEbvM2YjjZ0eova3+6OGPzXtIM6oAKx/WM7ENAucLWnTu4jKLFgegaYxVdQL5oM7Ke7wUz6BJhGIVtBRzK3nUWLPAvsFpv4/bL5UD3jAAjDx007ahYc29r0XQzHALlZYr6uyafyiVctil5Ur9GT5uyM6B3qpNXQ0Aq9hF4gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ayMHRsU9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4250B87EF7;
	Thu, 16 May 2024 02:23:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715819038;
	bh=jG1kyEHStM/G4Bx69cnZ9ynPKSC8S8yZPDjm5wi4i4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayMHRsU9bOUstMRI7s2hcFPlwsAQONW2aXEHzKPB8nCX3D6FtQMDFRMmx1mxxi+BP
	 5ky2+jR2Jr3j7N0oAkQuIMB+5Gl5K26MjsPPaWL7KqmRCLUOMfwxgfCTPMONCIvkqL
	 SqGAcXwUuRuUAmMzIxvfEr7IXpjwl7iDxtsZw+IJPQOcqufFWg/DUrlpKxNbAkGhJ0
	 aN6/aP1dRQ5VlfzYKYii3cU7PolA1UvwvCtDYMZNtnquw2M7qcDXLoe0wBC6ECr1QU
	 FdLw9aAbGx587PlLFTMQT5i+kTGmfznpVsaumkZFEwNZ0Aa56qrto+S+bHv6g0/6WD
	 1TfGLe9G7saKw==
Message-ID: <9c1d80eb-03e7-4d39-b516-cbcae0d50e4a@denx.de>
Date: Thu, 16 May 2024 02:23:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for
 STM32MP135F-DK board
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
 <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
 <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 6:01 PM, Alexandre TORGUE wrote:
> Hi Marek

Hi,

> On 4/26/24 17:44, Marek Vasut wrote:
>> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>>> Add dual Ethernet:
>>> -Ethernet1: RMII with crystal
>>> -Ethernet2: RMII without crystal
>>> PHYs used are SMSC (LAN8742A)
>>>
>>> With Ethernet1, we can performed WoL from PHY instead of GMAC point
>>> of view.
>>> (in this case IRQ for WoL is managed as wakeup pin and configured
>>> in OS secure).
>>
>> How does the Linux PHY driver process such a PHY IRQ ?
>>
>> Or is Linux unaware of the PHY IRQ ? Doesn't that cause issues ?
> 
> In this case, we want to have an example to wakeup the system from 
> Standby low power mode (VDDCPU and VDD_CORE off) thanks to a magic 
> packet detected by the PHY. The PHY then assert his interrupt output 
> signal.
> On MP13 DK platform, this PHY signal is connected to a specific GPIO
> aka "Wakeup pins" (only 6 wakeup pins an MP13). Those specific GPIOs are 
> handled by the PWR peripheral which is controlled by the secure OS.

What does configure the PHY for this wakeup mode ?

> On WoL packet, the Secure OS catches the PHY interrupt and uses 
> asynchronous notification mechanism to warn Linux (on our platform we 
> use a PPI). On Linux side, Optee core driver creates an irq 
> domain/irqchip triggered on the asynchronous notification. Each device 
> which use a wakeup pin need then to request an IRQ on this "Optee irq 
> domain".
> 
> This OPTEE irq domain will be pushed soon.

I suspect it might make sense to add this WoL part separately from the 
actual ethernet DT nodes, so ethernet could land and the WoL 
functionality can be added when it is ready ?

