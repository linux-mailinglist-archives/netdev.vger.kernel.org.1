Return-Path: <netdev+bounces-59945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4F81CD74
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B45C1C20993
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA32554E;
	Fri, 22 Dec 2023 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="K95WPd53"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4A28DAE
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BC2640005;
	Fri, 22 Dec 2023 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703264676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mX0s0cjF1WpVnPF54K/BTuGonIeqLRmPb8+Gqk7wA68=;
	b=K95WPd533r/JzM2JbJxqB7NosmYYky6pAyKZINNP8BdfWXex9yPYmnkSYGpHJ3ZYNfyy3C
	JVRdpamotGD1g2GmYd4RsT0OcFlsuyndBdzW9BYfE2cPB9eqFjytpIBGVS+PyOfH2h5C6G
	BbpKEitc3v1eYE4s6VrfHnhqUV35b2dmDH301Aud/u99N5irqtSgvI1VWsJf89iyfNUn1G
	Js3kyi+DCTbJFR/A12zWVdZWIFFJ9bNhsgY6Lw4ZX6IG37CEoKZhnbnKH0uwNIwenI5Adi
	50nr+w1m4wlhGLax7n4IXN0pIhbJu2HTUKhdsoe8GskVpSHgBJ5ShrLtwA2i4A==
Message-ID: <2cf4c7c0-603d-4c06-a677-69410b02019b@arinc9.com>
Date: Fri, 22 Dec 2023 20:04:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
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
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <hs5nbkipaunm75s3yyoa2it3omumxotyzdudyzrzxeqopmnwal@z5zpbrxwfsqi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 22.12.2023 14:13, Alvin Šipraga wrote:
> On Fri, Dec 22, 2023 at 12:48:31PM +0200, Vladimir Oltean wrote:
>> On Thu, Dec 21, 2023 at 09:34:52PM +0300, Arınç ÜNAL wrote:
>>> On 21.12.2023 20:47, Vladimir Oltean wrote:
>>>> ds->user_mii_bus helps when
>>>> (1) the switch probes with platform_data (not on OF), or
>>>> (2) the switch probes on OF but its MDIO bus is not described in OF
>>>>
>>>> Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
>>>> if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
>>>> assignment is only ever executed when the bus has an OF node, aka when
>>>> it is not useful.
>>>
>>> I don't like the fact that the driver bails out if it doesn't find the
>>> "mdio" child node. This basically forces the hardware design to use the
>>> MDIO bus of the switch. Hardware designs which don't use the MDIO bus of
>>> the switch are perfectly valid.
>>>
>>> It looks to me that, to make all types of hardware designs work, we must
>>> not use ds->user_mii_bus for switch probes on OF. Case (2) is one of the
>>> cases of the ethernet controller lacking link definitions in OF so we
>>> should enforce link definitions on ethernet controllers. This way, we make
>>> sure all types of hardware designs work and are described in OF properly.
>>>
>>> Arınç
>>
>> The bindings for the realtek switches can be extended in compatible ways,
>> e.g. by making the 'mdio' node optional. If we want that to mean "there
>> is no internal PHY that needs to be used", there is no better time than
>> now to drop the driver's linkage to ds->user_mii_bus, while its bindings
>> still strictly require an 'mdio' node.
>>
>> If we don't drop that linkage _before_ making 'mdio' optional, there
>> is no way to disprove the existence of device trees which lack a link
>> description on user ports (which is now possible).
> 
> I strongly agree and I think that the direction you have suggested is
> crystal clear, Vladimir. Nothing prohibits us from relaxing the bindings
> later on to support whatever hardware Arınç is describing.
> 
> But for my own understanding - and maybe this is more a question for
> Arınç since he brought it up up - what does this supposed hardware look
> like, where the internal MDIO bus is not used? Here are my two (probably
> wrong?) guesses:
> 
> (1) you use the MDIO bus of the parent Ethernet controller and access
>      the internal PHYs directly, hence the internal MDIO bus goes unused;
> 
> (2) none of the internal PHYs are actually used, so only the so-called
>      extension ports are available.
> 
> I don't know if (1) really qualifies. And (2) is also a bit strange,
> because this family of switches has variants with up to only three
> extension ports, most often two, which doesn't make for much of a
> switch.
> 
> So while I agree in theory with your remark Arınç, I'm just wondering if
> you had something specific in mind.

I was speaking in the sense of all switches with CPU ports, which is
controlled by the DSA subsystem on Linux.

I am only stating the fact that if we don't take the literal approach with
hardware descriptions on the driver implementation, there will always be
cases where the drivers will fail to support certain hardware designs.

Arınç

