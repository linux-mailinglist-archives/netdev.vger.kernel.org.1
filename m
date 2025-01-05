Return-Path: <netdev+bounces-155261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF65A018C3
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAAB7A14B9
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F113CA8A;
	Sun,  5 Jan 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKXsY95T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1B3D3B3;
	Sun,  5 Jan 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067997; cv=none; b=VbKrGJn7KCeNukkiB1SqAKRimQICA61QuoHFHJZs1I97dO6pHSV+1Xu7mFUxq15y5qPG+zPqhdyIsUFUJTpMuMoRzS1QU5HG1bXS1izZSCt98xd7nQqk4r1XBfbIodofqrEjQ2wOkVfti3HRkIvgH96jzHhzlrKk1G2Tonq3TnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067997; c=relaxed/simple;
	bh=QHEtrtWehZrXxi4O0ZwprOmoYuiHhgDbbAm2XllazSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsP4n5WWhf9bkYZ4sU8F2b4KlhKpNyxyLTqQxgsndkNuuJzalGDYKb0k98maFWePMexLGRlth/9Pw9uYU2s9po43LaZbpH0ZxWRmZD5RavDlZwWtkj9wGCib5Iuwuzrl7e5tx426Ebl9IQPHxl65fDTWPMoAtlrBmD3/10UxwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKXsY95T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC3C4CED0;
	Sun,  5 Jan 2025 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736067997;
	bh=QHEtrtWehZrXxi4O0ZwprOmoYuiHhgDbbAm2XllazSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kKXsY95TEAsopYp9HoWUdjVZqubBr7zrSF+kpXGL7zI8b5ssakBN7djodVKlbPig2
	 2RkASTA5et5vqACsHk82s6DVx7LnO/1MzTJkFs0NIdgM6GiqXLinpjCSm6OmkQMAg9
	 YtlZEHBGW++cK574MNiZqqNZgd6J9No/Apb4aW+accN73KRFUhpGCflcOSZCDbVsOn
	 pRFDvvms7MiUmtGSQH6NdEaN+BvpflWsa1UPDYa8YRc0Uv2J6ZdBSpiJ7LklRRJ7P5
	 lCqreYhSM4wQAqWVT/b/OL0NVeSbxFbu8JhiwtvqdiB1207/71ncIjrOmvFXT3ieed
	 UXSSuICpJBArw==
Message-ID: <c47cdecb-a618-4e7b-8334-5892170f012b@kernel.org>
Date: Sun, 5 Jan 2025 10:06:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
 <mjtwntmupclvy2dvc66zxxob3py47lew47vq37hfi6v6pmbpne@nr62lnuilzya>
 <20250104165056.749da353@kmaincent-XPS-13-7390>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250104165056.749da353@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2025 16:50, Kory Maincent wrote:
> On Sat, 4 Jan 2025 10:42:32 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Fri, Jan 03, 2025 at 10:13:07PM +0100, Kory Maincent wrote:
>>> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>>>
>>> Introduce a new property to describe the power budget of the regulator.
>>> This property will allow power management support for regulator consumers
>>> like PSE controllers, enabling them to make decisions based on the
>>> available power capacity.
>>>
>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Add type.
>>> - Add unit in the name.
>>>
>>> Changes in v2:
>>> - new patch.
>>> ---
>>>  Documentation/devicetree/bindings/regulator/regulator.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml
>>> b/Documentation/devicetree/bindings/regulator/regulator.yaml index
>>> 1ef380d1515e..c5a6b24ebe7b 100644 ---
>>> a/Documentation/devicetree/bindings/regulator/regulator.yaml +++
>>> b/Documentation/devicetree/bindings/regulator/regulator.yaml @@ -34,6
>>> +34,11 @@ properties: regulator-input-current-limit-microamp:
>>>      description: maximum input current regulator allows
>>>  
>>> +  regulator-power-budget-miniwatt:  
>>
>> What sort of quantity prefix is a "mini"? How much is a mini?
> 
> Oops, that is a brain fart sorry for this. Of course it is milliwatt.
> 
>>
>>> +    description: power budget of the regulator
>>> +    $ref: /schemas/types.yaml#/definitions/uint32  
>>
>> This should not be needed. Use proper unit from dtschema.
> 
> Ok, I was mistaken. There are bindings with this ref in this file, so I thought
> it was needed. I will remove it.
If the unit is not in the property-units of dtschema, you will have a
warning, but then please send a pull request (patch could work as well
probably) to dtschema adding it... but I am sure that milliwatt is there.

Best regards,
Krzysztof

