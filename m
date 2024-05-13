Return-Path: <netdev+bounces-96077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB78C43BF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7559E1F225B5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4256AC2;
	Mon, 13 May 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="nVAyY1V/"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834E4C7B;
	Mon, 13 May 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612810; cv=none; b=XOgw8ynchpoawp3sy9X/Dk4mm//QUlBqCmEbssMyPg5xdb/BGPulurY7EPLZH6OZ7nQ8szzWEDywYno2JILfGxC23uur8r7PcVGzY+OdiJRJNwUzR6tO34UrItHtfeZtZZ4L1RlRlkdZqNW/bOqHQJWehyhr/04c+1uGED/BrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612810; c=relaxed/simple;
	bh=8aYhnyESUx91UbZYjQFvpNe164Hwg9vkCST5TzdH/Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5riNHkIgQF3WOGOp9ijPUQ9fY/vENU18EeaBPw/esfNM8zaf0GOoyuXepmqhTQPvFOJ/C7It7r73lKFqtS95FhTwOKYvAuhAFngeVY01FDqOSS0zuQK6l5tfl1eb0fkRm97SfHS781stsNx+BHF/LWJerM52KzZ1yF5zI1JV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=nVAyY1V/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 587A987E50;
	Mon, 13 May 2024 17:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715612807;
	bh=D+kDYWZibEUugDcn49CQ+F1gtNp7/FJaDN/c69YDh5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVAyY1V/Ba0HWbriExYe4dZLigqzqJP6GhBUECrwmBSYFXv4/UB//Cnsh7o9Eje1S
	 FXLepTguU4p51QYDmAQGyLOSRczHQwmgbkJKoCJfcf32zQNlNs5hPrM6DMx0hQ5hgM
	 dj0eHocM6PtpQmeLleEYPMQGoVxh3ysE3hzOlLZWC3kuPvUSgdXCL6uBAykn46wINk
	 0xSxBLXt6izu1N5J27TjgAJokl5CRDudBrfymJtSJp0ACA9aClRnbMaIw94tHSheZ/
	 SO3Wtb9gs0rTdBYVHTRKwaejQpU2bSbV8oAWj88qjoNLPHEIE+bnOTTdJwlJ6mVKfK
	 mcjCcBwWUaCmg==
Message-ID: <4096ae14-bbb7-446b-bd96-2498c7ee4057@denx.de>
Date: Mon, 13 May 2024 16:16:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for
 stm32
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
 <4e03e7a4-c52b-4c68-b7e5-a03721401cdf@denx.de>
 <0ef43ed5-24f5-4889-abb2-d01ee445a02d@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0ef43ed5-24f5-4889-abb2-d01ee445a02d@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 1:45 PM, Christophe ROULLIER wrote:
> Hi,

Hi,

> On 4/26/24 16:47, Marek Vasut wrote:
>> On 4/26/24 2:56 PM, Christophe Roullier wrote:
>>> Phandle to a regulator that provides power to the PHY. This
>>> regulator will be managed during the PHY power on/off sequence.
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>>
>> Maybe this entire regulator business should be separate series from 
>> the MP13 DWMAC ethernet series ?
> I prefer push it with MP13 Ethernet series if possible.

This is separate functionality, independent of the MP13 support and not 
required for the MP13 support, correct ?

If yes, move it into separate patch(set) to make both series easier to 
review.

