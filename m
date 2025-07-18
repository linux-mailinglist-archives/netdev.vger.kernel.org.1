Return-Path: <netdev+bounces-208098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B419B09CF2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97223A5FC2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39C291882;
	Fri, 18 Jul 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/yuIYu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0C1BC3F;
	Fri, 18 Jul 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825032; cv=none; b=Evbstnf+b063pinDpn2LM1gmErg+gEbWSaKAEXym0WdRYxkL5hTKx5akUqILUf2fEBRPEdxxgnLQX5KWvKhEbWeSk2YJzxjAM0YijEF0qp3MIwzfQQJxP/a3Oxzg1YdRquJaiygbbTXfBkzq9gBYNP2j9J1EJH/afiusCg4RuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825032; c=relaxed/simple;
	bh=8ipV0NoSWDyzyTACs+2WmaxExih69IxxoJtY0zLKEmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dc+1qmPe4XKWRxiPNULVuDZTCrJn5Lw4mnjc6wHMR0ZTaFOi8GR72oHAkKSb4avLIFbwI3P0VP5anYDsXsDYBsJTIh9YseoXvU4tfAUXnEpawrtdaLi0CK7WXiW2HQulrSS4ya27Vr+4p0ZkpnW2PGZuUqYj1POsMoHK5++c4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/yuIYu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F62C4CEEB;
	Fri, 18 Jul 2025 07:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752825031;
	bh=8ipV0NoSWDyzyTACs+2WmaxExih69IxxoJtY0zLKEmw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=R/yuIYu46SjJxXDqtU6zjC4MKxqn/0RLwoiWE4VVhJqV6b0KuHHIPJOsPPz7Cxzsh
	 N63t6QC8ym3E2AuL1UGPVYPxmvmZbU5RqPzIDTiNQG6GqvnEMDylw85qRbWtV7fIln
	 gumFX73PKAQd09jyDagkP937H+kBVgFLEQ6EfVgbwvHaKAXyYvS/61YneaPp2GIstN
	 GISPrSPV4F0wswqwEGzWhH7YvzLEjoe81CavNdbdg654EkH5KskyGMN8uieay3AYJn
	 xhf7AH9nLvbHQuLcKtE1k5i42nlVvQLgf/lzLQRHbjR2nU+oujbzrrwu6VSzl+l/bi
	 HxQE2Tf2TE50w==
Message-ID: <50cdc52b-b0e6-4448-a35d-b033671bb623@kernel.org>
Date: Fri, 18 Jul 2025 09:50:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, Frank Li <frank.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
 <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250718-enchanted-cornflower-llama-f7baea@kuoka>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250718-enchanted-cornflower-llama-f7baea@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 09:46, Krzysztof Kozlowski wrote:
> On Thu, Jul 17, 2025 at 10:26:28AM +0000, Wei Fang wrote:
>>>> timestamper:	provides control node reference and
>>>> 			the port channel within the IP core
>>>>
>>>> The "timestamper" property lives in a phy node and links a time
>>>> stamping channel from the controller device to that phy's MII bus.
>>>>
>>>> But for NETC, we only need the node parameter, and this property is
>>>> added to the MAC node.
>>>
>>> I think we do not understand each other. I ask if this is the
>>> timestamper and you explain about arguments of the phandle. The
>>> arguments are not relevant.
>>>
>>> What is this purpose/role/function of the timer device?
>>
>> The timer device provides PHC with nanosecond resolution, so the
>> ptp_netc driver provides interfaces to adjust the PHC, and this PHC
>> is used by the ENETC device, so that the ENECT can capture the
>> timestamp of the packets.
>>
>>>
>>> What is the purpose of this new property in the binding here?
>>>
>>
>> This property is to allow the ENETC to find the timer device that is
>> physically bound to it. so that ENETC can perform PTP synchronization
>> with other network devices.
> 
> 
> Looks exactly how existing timestamper property is described.
> 
> If this is not timestamper then probably someone with better domain
> knowledge should explain it clearly, so I will understand why it is not
> timestamper and what is the timestamper property. Then you should think
> if you need new generic binding for it, IOW, whether this is typical
> problem you solve here or not, and add such binding if needed.
> 
> Maybe there is another property describing a time provider in the
> kernel or dtschema. Please look for it. This all looks like you are
> implementing typical use case in non-typical, but vendor-like, way.


BTW, I am also very disappointed that we had exactly that talk in v1,
for 10 or 20 emails (!!!) and then you send the same.

I feel like you do not want to actually solve this problem, but just
push whatever you have. Otherwise why unresolved comments in v1 would
result in the same code in v2 leading to the same lengthy discussion?

If you send the same v3, I will just NAK it without even discussing,
because 20 emails in v1 and 20 emails in v2 is way too much wasting my time.

Best regards,
Krzysztof

