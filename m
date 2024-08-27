Return-Path: <netdev+bounces-122341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C6960C04
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D282A1C23877
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A41BFDFF;
	Tue, 27 Aug 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcfj0qq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8231BDA91;
	Tue, 27 Aug 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765196; cv=none; b=UKahUVfGaCT9mGTqrceH7uXVLRoCg0vx7QH6cOClt5wCsi7oUg9/IhqWQBlB8LxQkEYcJ5bYXUzhYDJF3Me4kiR4HDW9c8Y1mXnl9lIBhEpbgSXJmwgDMLkSPz+L41Ei4Q6n/RRs2VLutpVqH6uIOJqq8YqfBwnfs9lQLLgW/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765196; c=relaxed/simple;
	bh=u4z5qLnK1EK6ZGkMqlc3/WGYYmJ8sJ9ck8hZhjxvPsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdhfg8KOWQIrtrCbqMfO4EEs8Htj8W1LEwfJkqL1htRCzpcPbAMB2VuYZBqbr5IC5tWT8RJSl5ZPOujVKz3MdVWn5yr4ZVzeTNHI/lYzSGISb1cAJ2RTNBLfUKE/VMt5+2Ge1t+YQq1D1nnePe7akj77BuniJbIb4WN+qR/Yr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcfj0qq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AC0C4DDF3;
	Tue, 27 Aug 2024 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724765196;
	bh=u4z5qLnK1EK6ZGkMqlc3/WGYYmJ8sJ9ck8hZhjxvPsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dcfj0qq9C0B7m91buNrKF2ffA0D2voocoBupPcCgbLyAlKfL+1xHnLFVOlrhCkqD2
	 PKI+f3HfMCgyT8rldsN3LlheExZzGsZzIiNWfyX7uLbvMAra7pjO5/zxzST3Xf+q3J
	 ZMAFWm2e5c1Ak4UbLeQkwAawXNpIevJ4qWdZz8RdsxNOmAAJAjQoJX9W+gDsd40dCP
	 sXvl3Pvy3yjbLS/u6v6vEnsceeMkk7l5XIMiFgSewRkr8IKXF4EKIprQ/YLLOBgypV
	 A96Op0+ET75sVwjLhiIIn5IgMRKFTDW2gI3S15Agj125zj8wUimOc+bdJGt5xpnRzZ
	 1GLrg3LcWut8w==
Message-ID: <31058f49-bac5-49a9-a422-c43b121bf049@kernel.org>
Date: Tue, 27 Aug 2024 15:26:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
To: Wei Fang <wei.fang@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20240826052700.232453-1-wei.fang@nxp.com>
 <20240826052700.232453-2-wei.fang@nxp.com>
 <20240826154958.GA316598-robh@kernel.org>
 <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2024 05:25, Wei Fang wrote:
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: 2024年8月26日 23:50
>> To: Wei Fang <wei.fang@nxp.com>
>> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; krzk+dt@kernel.org; conor+dt@kernel.org;
>> andrew@lunn.ch; f.fainelli@gmail.com; hkallweit1@gmail.com;
>> linux@armlinux.org.uk; Andrei Botila (OSS) <andrei.botila@oss.nxp.com>;
>> netdev@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; imx@lists.linux.dev
>> Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
>> "nxp,phy-output-refclk" property
>>
>> On Mon, Aug 26, 2024 at 01:26:59PM +0800, Wei Fang wrote:
>>> Per the RMII specification, the REF_CLK is sourced from MAC to PHY or
>>> from an external source. But for TJA11xx PHYs, they support to output
>>> a 50MHz RMII reference clock on REF_CLK pin. Previously the
>>> "nxp,rmii-refclk-in" was added to indicate that in RMII mode, if this
>>> property present, REF_CLK is input to the PHY, otherwise it is output.
>>> This seems inappropriate now. Because according to the RMII
>>> specification, the REF_CLK is originally input, so there is no need to
>>> add an additional "nxp,rmii-refclk-in" property to declare that
>>> REF_CLK is input.
>>> Unfortunately, because the "nxp,rmii-refclk-in" property has been
>>> added for a while, and we cannot confirm which DTS use the TJA1100 and
>>> TJA1101 PHYs, changing it to switch polarity will cause an ABI break.
>>> But fortunately, this property is only valid for TJA1100 and TJA1101.
>>> For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is invalid
>>> because they use the nxp-c45-tja11xx driver, which is a different
>>> driver from TJA1100/TJA1101. Therefore, for PHYs using nxp-c45-tja11xx
>>> driver, add "nxp,phy-output-refclk" property to support outputting
>>> RMII reference clock on REF_CLK pin.
>>>
>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>> ---
>>> V2 changes:
>>> 1. Change the property name from "nxp,reverse-mode" to
>>> "nxp,phy-output-refclk".
>>> 2. Simplify the description of the property.
>>> 3. Modify the subject and commit message.
>>> V3 changes:
>>> 1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
>>> 2. Rephrase the commit message and subject.
>>> ---
>>>  Documentation/devicetree/bindings/net/nxp,tja11xx.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>
>> This binding is completely broken. I challenge you to make it report any errors.
>> Those issues need to be addressed before you add more properties.
>>
> Sorry, I'm not sure I fully understand what you mean, do you mean I need

Make an intentional error in your DTS and then validate that the schema
catches it. That's the challenge.

Best regards,
Krzysztof


