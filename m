Return-Path: <netdev+bounces-59973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20481CF69
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505DE1F22EC2
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43820B09;
	Fri, 22 Dec 2023 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GCubHF77"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C232E82B
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75305E0003;
	Fri, 22 Dec 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703278777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7r944Zbi4TzqG++nQ8HNJS4njdNtXNSHgQuYgRERic=;
	b=GCubHF77SPSRGGtnd/CO762um3dEfPljR4T6WrRoUp/annFO+NK7jYR+/emPBTYQKs5Fax
	8Lh2SImd55kO3mMGjkrrc+8zJRBQ0aCouZliD9bBF3EbqlSvxpmd1q58Ej0A69fGfxF5Fc
	72i/TJdNQ6WuyGK9kD22o9ohmkK5Aa3TnxVkpJK2HdwoGN84QPDYqAcN+cTXXHMS1B0PCp
	ieH9K0Jzq84Qw1lQxfq0d3cYvBzA2WgPujsKLCeAVQrBsGf0dIyPZoYPv+C3KR55R24yTV
	88FQcYBhSypOaNqA6JLpJXYOXOTZ8AcxZiwkkauXk2YL2WzRBsX7jYMeYS0G9Q==
Message-ID: <dc93d99f-eadf-41d2-b1a3-45ab44981638@arinc9.com>
Date: Fri, 22 Dec 2023 23:59:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
 <20231222104831.js4xiwdklazytgeu@skbuf>
 <hs5nbkipaunm75s3yyoa2it3omumxotyzdudyzrzxeqopmnwal@z5zpbrxwfsqi>
 <2cf4c7c0-603d-4c06-a677-69410b02019b@arinc9.com>
 <CAJq09z4LKwkumhR2CiLzczoFM1Ut-yAr9zHZLypopes8t_nrew@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAJq09z4LKwkumhR2CiLzczoFM1Ut-yAr9zHZLypopes8t_nrew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Hey Luiz.

On 22.12.2023 23:28, Luiz Angelo Daros de Luca wrote:
>> I was speaking in the sense of all switches with CPU ports, which is
>> controlled by the DSA subsystem on Linux.
>>
>> I am only stating the fact that if we don't take the literal approach with
>> hardware descriptions on the driver implementation, there will always be
>> cases where the drivers will fail to support certain hardware designs.
> 
> Hi Arinç,
> 
> The old code was already requiring a single switch child node
> describing the internal MDIO bus akin to binding docs. I believe what
> we use to match it, being the name or the compatible string property,
> wouldn't improve the diversity of HW we could support. This series
> doesn't want to solve all issues and limitations nor prepare the
> ground for different HWs. It's mostly a reorganization without nice
> new stuff.
> 
> After this series, we could easily turn the mdio node optional,
> skipping the MDIO bus when not found. Anyway, if such HW appears just
> now, I believe we could simply workaround it by declaring an empty
> mdio node.

I agree that there's no need to add new things to this patch series. Just
address Vladimir's suggestions on the next version. You got into this
rabbit hole because you were just trying to add reset controller support on
the rtl8365mb driver, no? Geez!

Arınç

