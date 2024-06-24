Return-Path: <netdev+bounces-106212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDCB9154E5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CD31C211D4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80F19E834;
	Mon, 24 Jun 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="WaByuFDk"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1019DF63;
	Mon, 24 Jun 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248407; cv=none; b=dv9Ea6cWfcFWOYRBtRQSVVlWHHQTtNqf2t0tIxnx34Bi3/abVw1Ur3fmJfDvViQjugN5F8vi9brXWlB1hj1SfXVm2XIZ5RAM26IkhqQMGDZqSDn6AM7hXTXjes7z8SZ1zcMrGHC7vhFiJM60krWhZLuzr+Mi6ELTZBsOpCqZvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248407; c=relaxed/simple;
	bh=Hmoar99WJgIcAtnd+WAt/THVlxlRjSv4TgbbqULAsV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWXnYSmvoogpErm20QM18qsaMOOdn5+H7rktnW267FUmZZo8vAHLc8hSIeIM6hC2SIsdZ06RtDO0cNOxi56pNcEKSzleSHAIufrlVY1/EBcmGAPhGfjzAXHmLiNJMY0cS1VITZgYbsZpFoeo1Dezi0FuJisfhLjWd+HDuCiooTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=WaByuFDk; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D95E0E0003;
	Mon, 24 Jun 2024 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719248397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ4G9gHer+vGikuMMCqTObACnz6EiIwEffwORvVea34=;
	b=WaByuFDkkhlrEUniTJL8/4WDvdgswAlaHd8tSxvOr2wDMPKTIA40qJExeDYTH24tp9b/n3
	1sZtfv/v29UJVa4jLCbqZr1t/fjSQ70b7XMeZfWua+cU3Ompcsk7wNfzuXu/awfKgYhLS3
	R/Bvd/okJC8y63AbOWE9oMHYoODqFDxqkOoCgeg9T5xjFbKy8iqlXiRk8n+/Om1Fg+bt2X
	FAhPcorxp3rV9QZdpdQki3zHm4sKjMvfNqlGAmjTMH8oKz1M5DptG/LR8ufUxPLilBMVaU
	8Bm28divy2PghoSiFXl3tV7nT27G4ou/ZF8v++BWdOF39p7BEn+HZ3H3IHyFEQ==
Message-ID: <68961d4f-10d8-4769-94d3-92ce709aa00a@arinc9.com>
Date: Mon, 24 Jun 2024 19:59:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: Minor grammar
 fixes
To: Conor Dooley <conor@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
 <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
 <20240624-radiance-untracked-29369921c468@spud>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240624-radiance-untracked-29369921c468@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 24/06/2024 19.29, Conor Dooley wrote:
> On Mon, Jun 24, 2024 at 10:00:25AM +0300, Arınç ÜNAL wrote:
>> On 24/06/2024 05.58, Chris Packham wrote:
>>> Update the mt7530 binding with some minor updates that make the document
>>> easier to read.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>       I was referring to this dt binding and found a couple of places where
>>>       the wording could be improved. I'm not exactly a techical writer but
>>>       hopefully I've made things a bit better.
>>>
>>>    .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml        | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> index 1c2444121e60..6c0abb020631 100644
>>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> @@ -22,16 +22,16 @@ description: |
>>>      The MT7988 SoC comes with a built-in switch similar to MT7531 as well as four
>>>      Gigabit Ethernet PHYs. The switch registers are directly mapped into the SoC's
>>> -  memory map rather than using MDIO. The switch got an internally connected 10G
>>> +  memory map rather than using MDIO. The switch has an internally connected 10G
>>>      CPU port and 4 user ports connected to the built-in Gigabit Ethernet PHYs.
>>> -  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs has got 10/100 PHYs
>>> +  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs have 10/100 PHYs
>>
>> MT7530 is singular, the sentence is correct as it is.
> 
> Actually, the sentence is missing a definite article, so is not correct
> as-is.

The definite article is omitted for the sake of brevity. I don't believe
omitting the definite article renders the sentence incorrect.

> 
>>
>>>      and the switch registers are directly mapped into SoC's memory map rather than
>>>      using MDIO. The DSA driver currently doesn't support MT7620 variants.
>>>      There is only the standalone version of MT7531.
>>> -  Port 5 on MT7530 has got various ways of configuration:
>>> +  Port 5 on MT7530 supports various configurations:
>>
>> This is a rewrite, not a grammar fix.
> 
> In both cases "has got" is clumsy wording,

We don't use "have/has" on the other side of the Atlantic often.

Arınç

