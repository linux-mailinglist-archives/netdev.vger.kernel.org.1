Return-Path: <netdev+bounces-96078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDA8C43C2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB68283FC8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996355E4F;
	Mon, 13 May 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kUpaXSXm"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F71DDC5;
	Mon, 13 May 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612812; cv=none; b=OZsuWz7SeX8QefoCnop1sdgU9tTU+k9YSAIwLOf/e7vP2uX+D9KhInr9QLMiWQPANGBAo9WB9N3miRWVj7Sn0E7X71hDqhgLe4uEIBj3ng/oyB5re+KE5UGAwCDqJdXpxByhOYXJlPIesDW25wntykJlXXuNsRZpvRlX4FZxmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612812; c=relaxed/simple;
	bh=aWv4uhjr6Nqh1WTQMG3pOFjP+s2H/GrHjZ+pXgW3x7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qafXu10Svqa8X8H5wo5xQ21MH+rYoVXRfHwuz+aaTxVU6poJG27hFisOO3mJ7gTjQz4W03vTlM2Lh3FAWRSj6abLWFPpBEAFCk/a9Jk9kdfPaQFNWs3BaL5jMRUEzuA024M0vYszuF3bFp1KsufxFhEFm0EEFj8uPim3y9vnc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kUpaXSXm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 42D9A882D8;
	Mon, 13 May 2024 17:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715612808;
	bh=dFRl+UyXsb6ZN6/Bsy1gYor7t7lvZznQLrqAhOOp/wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kUpaXSXm2V5tAqWUzWOnUcr30a32u+LYIZ6BxWf97mYO/7FVS+xv7W5J0mELzqbg4
	 v9aD/SOgXFxAb+RcLQxhgY3RzO8SA+TsV9IGSMWS3+HHKDNibtO0/nTCTxIY3/pDtb
	 XYdMzRV2J96o6C2jwFSEoZgPdsdRhkHf3MNi06StgLhEL54ZUk7in+6CcnyngPGZTV
	 tLbb+VdnVXOOSOWF2ffkr1LSL1pe0XQ5n6uf5D1qiKWTo+eoyYMGgzcuSAMl7bMAb3
	 TL66NN8EzfcplXm6VcYiCgwoll9/7q0KYdFGD4vM13tEHN8kc5dcAix3Ch2WYxqaqN
	 9DbYTedQtlvOg==
Message-ID: <601550a5-da3b-4311-965d-ce65f6fdd337@denx.de>
Date: Mon, 13 May 2024 16:20:10 +0200
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
 Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
 <20240426153010.GA1910161-robh@kernel.org>
 <a2a631a0-9a16-4068-aed2-6bdaa71e3953@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a2a631a0-9a16-4068-aed2-6bdaa71e3953@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 4:06 PM, Christophe ROULLIER wrote:
> Hi
> 
> On 4/26/24 17:30, Rob Herring wrote:
>> On Fri, Apr 26, 2024 at 02:56:58PM +0200, Christophe Roullier wrote:
>>> Phandle to a regulator that provides power to the PHY. This
>>> regulator will be managed during the PHY power on/off sequence.
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>>> ---
>>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml 
>>> b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> index b901a432dfa9..7c3aa181abcb 100644
>>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> @@ -84,6 +84,9 @@ properties:
>>>             - description: offset of the control register
>>>             - description: field to set mask in register
>>> +  phy-supply:
>>> +    description: PHY regulator
>> This is for which PHY? The serdes phy or ethernet phy? This only makes
>> sense here if the phy is part of the MAC. Otherwise, it belongs in the
>> phy node.
>>
>> Rob
> 
> You are right, normally it should be managed in Ethernet PHY (Realtek, 
> Microchip etc...)
> 
> Lots of glue manage this like this. Does it forbidden now ? if yes need 
> to update PHY driver to manage this property.

If the regulator is connected to the PHY, then the supply should be 
described in the PHY node and you wouldn't even need these PHY patches 
(also see my comment that you should split the PHY regulator part of 
this patchset into separate series).

