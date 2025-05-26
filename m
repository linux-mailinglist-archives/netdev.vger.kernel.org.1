Return-Path: <netdev+bounces-193434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3AAC3FB8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BB018984D8
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6879202C26;
	Mon, 26 May 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMVJZhag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8971F8AD3;
	Mon, 26 May 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264138; cv=none; b=cyA1iZjj54Oys61qUmTtMOXgdQ+lpMQpZsCDDeGa/xdNRSRYnKLAU0JP7Rzx+0IAvbCdjOChcuPeZ3tJb5C8VPnfV5FjvEoFMUTOTi0Pd5RluZAF7OebERrBH9S6YdRiflAXbdkU26mSzvRT/Xte2KuHx9TnYmUcfKtkcvgn8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264138; c=relaxed/simple;
	bh=bExfwfw/4XWLYxbzMhE/s2vE70ANp/mcnfz5QFrmCek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlFjJYWeyGxtDW+pJlyNgc7c30eaurgr9kT8kBTrUrvAaE6z7Z0g5NQffnZciaVV18KPp6NOM6FGJIw3viKLLJKlB3XFQUtYP9go9OwXZEzdFbNn+Eu6y5IjhFjC14U9GdxywC1er42+dbRGmjB6az9OxtpDs83cIw4pT+xCLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMVJZhag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF7C4CEE7;
	Mon, 26 May 2025 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748264138;
	bh=bExfwfw/4XWLYxbzMhE/s2vE70ANp/mcnfz5QFrmCek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMVJZhagqDWLuK7twueF+MZeVg44ZGNrF5jWEgnH7K4epGjF5S0eXGhaeddjJw1ua
	 beXzya9wCrBY0gI2JUaN3aVHGInII8Q6rg6XTC38o2Uad3UZ5QUNiPIRjX60eief3C
	 ZmWSiRTNbgLTy91FIAYFeZ8MKW/34tAHzORqMtwoDCTgR5oDaHd52Qq2To0lBJldzU
	 G54NbcBBEJxCrmmQqDF9QrIsZAMXkLjUtkhKaEM5LcUGc+Kx9xXvdrBBqSwXJlX6Rd
	 AjDXhpww1+6Yc0EB1e/EQVwqUqV6DolffmhqzI7RgqV5SyEZiN6SdaoSpf8mBKODjF
	 bnVCcs2Y2+whg==
Message-ID: <9e00f85e-c000-40c8-b1b3-4ac085e5b9d1@kernel.org>
Date: Mon, 26 May 2025 14:55:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: net: qca,ar803x: Add IPQ5018 Internal GE
 PHY support
To: George Moussalem <george.moussalem@outlook.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-1-ddab8854e253@outlook.com>
 <aa3b2d08-f2aa-4349-9d22-905bbe12f673@kernel.org>
 <DS7PR19MB888328937A1954DF856C150B9D65A@DS7PR19MB8883.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <DS7PR19MB888328937A1954DF856C150B9D65A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2025 08:43, George Moussalem wrote:
>>> +  qca,dac:
>>> +    description:
>>> +      Values for MDAC and EDAC to adjust amplitude, bias current settings,
>>> +      and error detection and correction algorithm. Only set in a PHY to PHY
>>> +      link architecture to accommodate for short cable length.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    items:
>>> +      - items:
>>> +          - description: value for MDAC. Expected 0x10, if set
>>> +          - description: value for EDAC. Expected 0x10, if set
>>
>> If this is fixed to 0x10, then this is fully deducible from compatible.
>> Drop entire property.
> 
> as mentioned to Andrew, I can move the required values to the driver 
> itself, but a property would still be required to indicate that this PHY 
> is connected to an external PHY (ex. qca8337 switch). In that case, the 
> values need to be set. Otherwise, not..
> 
> Would qcom,phy-to-phy-dac (boolean) do?

Seems fine to me.

> 
>>
>>> +      - maxItems: 1
>>> +
>>> +  qca,eth-ldo-enable:
>>
>> qcom,tcsr-syscon to match property already used.
> 
> to make sure I understand correctly, rename it to qcom,tcsr-syscon?

Yes

> 
>>
>>> +    description:
>>> +      Register in TCSR to enable the LDO controller to supply
>>> +      low voltages to the common ethernet block (CMN BLK).
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      - items:
>>> +          - description: phandle of TCSR syscon
>>> +          - description: offset of TCSR register to enable the LDO controller
>>> +      - maxItems: 1
>> You listed two items, but second is just one item? Drop.
> 
> What is expected is one item that has two values, in this case: <&tcsr 
> 0x019475c4>

I know.

> 
> I could move the offset to the driver itself as it's a fixed offset, so 
> ultimately the property would become:
> 
> qcom,tcsr-syscon = <&tscr>;
> 
> agreed?
No. Just fix the syntax.

Best regards,
Krzysztof

