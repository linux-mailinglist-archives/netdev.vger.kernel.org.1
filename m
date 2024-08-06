Return-Path: <netdev+bounces-116101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB294918E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8881C22E92
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D51D2F5B;
	Tue,  6 Aug 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrYDECWk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700B1D1F7A;
	Tue,  6 Aug 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951080; cv=none; b=VEpRuC8CQ07lQ70sIz9TRGOstuzmdFNKWnouyhbmeJIXdn+n/Gs5BZcSSxct3tkNrcNfqu8MT9LBdd1A3tImoQuhq7B3GHREp86v94rdKlTr0tmrZTiRZd89X7KXUV8KXtFajwZv77KFUdpNXHcBIYJbR/2ADskjud/qvvYZO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951080; c=relaxed/simple;
	bh=iedWgHU/R9gV4BNKU4jNeA5Lu3KR3ChJ1u6WabxWCuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdqyXXMKnzWiXIdW8rXFKjwoq1GgU0rYee+3oZzb9qWKd9XtOaYUGFHQCq/gjOoh1FhxNWxzGkXb0tjiOrHTzb88JlVaUTflR8WSHwTK1TfTFUHH5K1Hnk2yVYoyMmQPIEgnJIZYoZ0848ngnVlBwPkX+W+MXdJbT9bQWImAcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrYDECWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2BDC32786;
	Tue,  6 Aug 2024 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951080;
	bh=iedWgHU/R9gV4BNKU4jNeA5Lu3KR3ChJ1u6WabxWCuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HrYDECWkWFb5g5nNXhYNiJGTmlqII2o/kc01WNYPYbAiZg+DlILn5nrYX7UcmI3v9
	 fH3pSs+YpXfQqagn72CDEXHhghbjEYQ2uBs0NkWi0jHEc3RLZA9+th+CLUr42ZzCCq
	 EcsEv7lxWoQeC0Vi5V55T0RuX1uxOMzpjkvoNHhWJxlVO/jbyM6HAyENQm9KSQh8hC
	 wtiO2MStZWQQFqyqM6zHKwRGaJOV7bzteZiJ8tq7jH0M0Fe4WiBvw40fxXHhLYYaXm
	 wu93+BYZVZizDPhVy/PokPFKAWN2ZZzBFB3MmBHhFEprM/OsiZVWFzI22/fLpCgYnR
	 71mEaYwRy6faw==
Message-ID: <17c21be3-5bdc-48e5-b005-be6018a49106@kernel.org>
Date: Tue, 6 Aug 2024 15:31:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: st: Add MECIO1 and MECT1S board variants
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Jander <david@protonic.nl>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240806120332.405064-1-o.rempel@pengutronix.de>
 <ae46118f-a692-4362-8e6b-4ef8c6369541@kernel.org>
 <ZrIiCX89nRDLvXtC@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZrIiCX89nRDLvXtC@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 15:15, Oleksij Rempel wrote:
> On Tue, Aug 06, 2024 at 02:39:31PM +0200, Krzysztof Kozlowski wrote:
>> On 06/08/2024 14:03, Oleksij Rempel wrote:
>>> From: David Jander <david@protonic.nl>
>>>
>>> Introduce device tree support for the MECIO1 and MECT1S board variants.
>>> MECIO1 is an I/O and motor control board used in blood sample analysis
>>> machines. MECT1S is a 1000Base-T1 switch for internal machine networks
>>> of blood sample analysis machines.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>  .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
>>>  arch/arm/boot/dts/st/Makefile                 |   3 +
>>>  arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts |  48 ++
>>>  arch/arm/boot/dts/st/stm32mp151c-mect1s.dts   | 297 ++++++++++
>>>  arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts |  48 ++
>>>  .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 533 ++++++++++++++++++
>>>  6 files changed, 937 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
>>>  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
>>>  create mode 100644 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
>>>  create mode 100644 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> index 58099949e8f3a..703d4b574398d 100644
>>> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> 
> Ack, I see. stm32.yaml should be in separate patch.

Yes

> 
>> Some warnings can be ignored, especially from --strict run, but the code
>> here looks like it needs a fix. Feel free to get in touch if the warning
>> is not clear.
> 
> What should be done with "ethernet-phy-id2000.a284" appears
> un-documente warnings? Should it be handled by
> Documentation/devicetree/bindings/net/ethernet-phy.yaml?


I think it is documented. checkpatch is not accurate for this one.

Best regards,
Krzysztof


