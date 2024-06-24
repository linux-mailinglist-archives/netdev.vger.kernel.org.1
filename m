Return-Path: <netdev+bounces-106006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A491430D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856111F23DBB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854272F870;
	Mon, 24 Jun 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="k5U//jms"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7D804;
	Mon, 24 Jun 2024 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212444; cv=none; b=drp8aWUBBuTNeqnf+7wttWDy9CSALhWlNZxEdaHSXb7Xuxa5frLFMv0WwHg42OtFJlI3enw/6K3ObLAudz+GHTuoj3RUmfmle7eGHOC+y6kLHtsbDNAA87A5wU048OwJsAwOOhYEcKdh70AI6UYGEDPHOHja2iFqkokeO0tCR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212444; c=relaxed/simple;
	bh=oyrEBVm3S1lEmozrtxvuovPMCO+zMUIMHBeaNvtY6vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUzZonZouPaidipR/FLztDgbt+dgjBgdBBlQ4dGs20/PnDY6KyTN0KSysoi2qA1nEhOQzX9oH7JDiagVRHJU+rLPZAfPH9x2e0bYwMwpiV5H6zv2ZYUIIMdHlEwmS+ZalSw5kjbhS4CCBXZoPRJmXz7zO96NMoMUK60csrYal+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=k5U//jms; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9A0640009;
	Mon, 24 Jun 2024 07:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719212432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b19k+/foFyMzoSDxq1RThplVOtb1XjVmJDOSBecBwtA=;
	b=k5U//jmsb7SQzA1xVwp91Vdb/6n0HBtyxVKJJnfrQ9T5e34PnwanYqHLLOLusY1LuDX9BI
	OBLtqjiyTLcxOXQNcHrNBuEWxFHgtGpN70z15/U6jRWZWqHpb1RhcoZYOBuHKiblzH/8e7
	pxTA0hZxYbN5TvTDvvrb42iG5Isdbu5eI6X63Ff6lBKdVZgNCkf/N71Y7IvgUt2Y5+WE/s
	yFI5aDKXeqoWnhMl69rXx6SqxejVebzQHOewlxSnw/yQFHyYNT8rEY+ZluEfZmZ/01NZQ3
	UCewzl47uimWeqszuqbL4ZGbyIHABNGZKQaXyzSxC3CmAY4W9DtTJkdSw5208Q==
Message-ID: <704f4b95-2aed-4b76-87cb-83002698471c@arinc9.com>
Date: Mon, 24 Jun 2024 10:00:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: Minor grammar
 fixes
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240624025812.1729229-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 24/06/2024 05.58, Chris Packham wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      I was referring to this dt binding and found a couple of places where
>      the wording could be improved. I'm not exactly a techical writer but
>      hopefully I've made things a bit better.
> 
>   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml        | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 1c2444121e60..6c0abb020631 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -22,16 +22,16 @@ description: |
>   
>     The MT7988 SoC comes with a built-in switch similar to MT7531 as well as four
>     Gigabit Ethernet PHYs. The switch registers are directly mapped into the SoC's
> -  memory map rather than using MDIO. The switch got an internally connected 10G
> +  memory map rather than using MDIO. The switch has an internally connected 10G
>     CPU port and 4 user ports connected to the built-in Gigabit Ethernet PHYs.
>   
> -  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs has got 10/100 PHYs
> +  MT7530 in MT7620AN, MT7620DA, MT7620DAN and MT7620NN SoCs have 10/100 PHYs

MT7530 is singular, the sentence is correct as it is.

>     and the switch registers are directly mapped into SoC's memory map rather than
>     using MDIO. The DSA driver currently doesn't support MT7620 variants.
>   
>     There is only the standalone version of MT7531.
>   
> -  Port 5 on MT7530 has got various ways of configuration:
> +  Port 5 on MT7530 supports various configurations:

This is a rewrite, not a grammar fix.

Arınç

