Return-Path: <netdev+bounces-149410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510269E5807
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B32F16BF7E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB74219A73;
	Thu,  5 Dec 2024 13:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57E219A6B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407093; cv=none; b=Hw3DfiPl1jmnTbG9wyxU3egcjumGkFLYtR+UbLEb2POnBFwXGEiYe2/ZVFg1YckqG9mTNrhqhiQm6/hn/AdTlXkYoC+jGyWZImR2OgYz9hvedA1VdutKbsyvcv4EGT1iBdYzPHwFd7Dprfw9D1nl/segHMRkPW2L146WWeeGV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407093; c=relaxed/simple;
	bh=Whztqzqhd31DO6J1pWBJGbIcubmLvvZmURKz55fjQck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj66ajrysOxDd3p3oWRxua9hYwpT3AHWmhooFZK1l438bOa7SbeFk/SMMrTzY8BCOCyhNOhCWYG0eZZft9nqW/3JiLbA58VUSt/5oPNt49uvw6Z00R9MPl7zYjbQewguF90KQU3fD00nN0yC8MQLVKvq8nPtB7gb1ts4SXzSIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tJCMh-0000kQ-S9; Thu, 05 Dec 2024 14:57:59 +0100
Message-ID: <361b3a14-db86-4c3c-9f07-4ebc1dd40d0e@pengutronix.de>
Date: Thu, 5 Dec 2024 14:57:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240806120517.406714-1-o.rempel@pengutronix.de>
 <20dc2cd4-7684-4894-9db3-23c3f4abd661@pengutronix.de>
 <a483fb50-f978-4e48-b38e-6d79632540f1@foss.st.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <a483fb50-f978-4e48-b38e-6d79632540f1@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Alex,

On 29.10.24 16:39, Alexandre TORGUE wrote:
> On 8/7/24 11:38, Ahmad Fatoum wrote:
>> Hello Oleksij,
>>
>> On 06.08.24 14:05, Oleksij Rempel wrote:
>> There's bias-disable in stm32mp15-pinctrl.dtsi. You may want to add
>> a /delete-property/ for that to make sure, it's not up to the driver
>> which one has priority.
>>
>>>           drive-push-pull;
>>>           slew-rate = <1>;
>>
>> These are already in qspi_bk1_pins_a. If repeating those is ok, why
>> not go a step further and just duplicate the pinmux property and stay
>> clear of this issue altogether, provided Alex is amenable to changing
>> his mind regarding pinctrl groups in board device trees.
> 
> I still prefer to have pin configuration defined in pinctrl dtsi file and I'll continue like this for ST board. The reason is that we try to reuse as much as possible pins when we create a new board and so it is easier to maintain if we declare them only one time.

I can see the point for ST evaluation kits as ST customer hardware
will often copy the reference designs.

> But, I'm not blocked for "other" boards based on STM32 SoC. I mean, if it is simpler for you and above all if it avoid issues/complexities then, you can declare some pin groups in your board dts file. In this case we need to take care of the IO groups label name.

That's good to hear and what I wanted to clarify. Especially for things like
ADCs, there are so many possible permutations that there is no point for
boards to add their pinctrl group to the main DTSI instead of just listing
their specific pin configuration in the board DTS.

Thanks,
Ahmad

> 
> regards
> alex
> 
>>
>>
>> Cheers,
>> Ahmad
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

