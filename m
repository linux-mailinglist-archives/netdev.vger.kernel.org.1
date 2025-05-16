Return-Path: <netdev+bounces-191044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339CAB9DA7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FAF7B3CCF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBBF72619;
	Fri, 16 May 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfWQl+ND"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48A2A1AA;
	Fri, 16 May 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402676; cv=none; b=feL/Ni6823a/QXYn4j6d1obqAm1Y8AOHNsykzUOT+w15q5fD3mX6SV9hIzgTRRqOwAZcPfrt6XYC+ukAFJX7NDjcJ7OisOi35eTomU78+fHBUiDZVLo+suhr68OxBjGguQ9nmDfcmdtxn/w9sa9Cngiq0/QV65h9L4gnhi8OFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402676; c=relaxed/simple;
	bh=tfffhHByX5llwjU88/l6Be44Wo41qF7tcM+s9T2He5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eqz4PTRzR7SIh42Yhy/TPLaDZLZuLgEJyn/mlhnxnyLS3GtjiAu0nMOgrtdto9PeqitKgWQGEngEb3fD/YPlgvGDpqEmPAqzJw1eTVH5JtlePIT4hPDIoeKqNadYngr1vR71M5cvqTVr0LL4nGhg0LuEAifOVZxhTOrq2FKI9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfWQl+ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE23C4CEE4;
	Fri, 16 May 2025 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747402675;
	bh=tfffhHByX5llwjU88/l6Be44Wo41qF7tcM+s9T2He5A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gfWQl+ND0oH81toVcQZ2tJEi6WZaERY7bPhNjhT9QiSs4zThOhvU22YGsJMLo8N07
	 J8+jdWLARZR4APAaG9eIN6xBu4EAdASj6D7GBkLyWuaSbsoMjkf92yr9Xpkl1pMGJg
	 yXY7ZXVYX8rbUOjCWbPiRUo7Vi6xt9WI69yz5hX0eGN7TDHkSeR9GjYGXuBkFMDhOU
	 CPPcH6HxH2NYnbBX4+NxK1Iiyl7QHGZlb0vp9fVbLWkkeHfvsZzhJcuk1Q7Hl1KM9e
	 nc1Y4ml0J/GIDTeHHhK9+YDcoDtXnHxfpGKDXPeHWL5ip9G2cOza+qJjIMc0FhrUOr
	 MAptzn8rCo3oA==
Message-ID: <b3db09da-72f0-465f-b177-ff14fd53608b@kernel.org>
Date: Fri, 16 May 2025 15:37:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL]Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add
 bindings for Si3474 PSE controller
To: Piotr Kubik <piotr.kubik@adtran.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <259ad93b-9cc2-4b5d-8323-b427417af747@adtran.com>
 <f8eb7131-5a5d-47ec-8f3b-d30cdb1364b5@kernel.org>
 <dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2025 17:20, Piotr Kubik wrote:
> On 5/13/25 10:24, Krzysztof Kozlowski wrote:
>> On 13/05/2025 00:05, Piotr Kubik wrote:
>>> +
>>> +maintainers:
>>> +  - Piotr Kubik <piotr.kubik@adtran.com>
>>> +
>>> +allOf:
>>> +  - $ref: pse-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - skyworks,si3474
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: main
>>> +      - const: slave
>>
>> s/slave/secondary/ (or whatever is there in recommended names in coding
>> style)
>>
> 
> Well I was thinking about it and decided to use 'slave' for at least two reasons:
> - si3474 datasheet calls the second part of IC (we configure it here) this way


This could be a reason, but specs are changing over time (see I2C, I3C)
to include different namings. If this annoys certain government sending
their executive directives, then even better.


> - description of i2c_new_ancillary_device() calls this device explicitly slave multiple times

Old driver code should not be an argument. If code changes, which it can
anytime, are you going to change binding? No, because such change in the
binding would not be allowed.

> 
>>> +
>>> +  reg:
>>
>> First reg, then reg-names. Please follow other bindings/examples.
>>
>>> +    maxItems: 2
>>> +
>>> +  channels:
>>> +    description: The Si3474 is a single-chip PoE PSE controller managing
>>> +      8 physical power delivery channels. Internally, it's structured
>>> +      into two logical "Quads".
>>> +      Quad 0 Manages physical channels ('ports' in datasheet) 0, 1, 2, 3
>>> +      Quad 1 Manages physical channels ('ports' in datasheet) 4, 5, 6, 7.
>>> +      This parameter describes the relationship between the logical and
>>> +      the physical power channels.
>>
>> How exactly this maps here logical and physical channels? You just
>> listed channels one after another...
> 
> yes, here in this example it is 1 to 1 simple mapping, but in a real world,
> depending on hw connections, there is a possibility that 
> e.g. "pse_pi0" will use "<&phys0_4>, <&phys0_5>" pairset for lan port 3.
> 

Ack, I see that's actually common for pse-pd. It's fine.


Best regards,
Krzysztof

