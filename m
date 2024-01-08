Return-Path: <netdev+bounces-62340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9E826B16
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A261F20FD0
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09E125DE;
	Mon,  8 Jan 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="nZqG+MxH"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CB12B6B
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A557040003;
	Mon,  8 Jan 2024 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704707315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpNNywnRnw+56QHyvKQN19iRJaBTEV7iLGpuLYVJtmU=;
	b=nZqG+MxHbmt4JILeh6E1mhwL7TiW3WEOXPPU2VOJROrXQJE+ur4sO0wlgkUEDWm8p/IL2O
	3ba6Zb1epIWPBtF1VdTII5Kn2bKYTNzO6foX876Zf2UQTE2p8Pq9RQK61+BV0m1RqyEJ1C
	dxcj7Dv6u0T8SKY/+dvHE9nQqeZ/+c2of4GZcnWWdgOMuQK4KBFy/uPoevC3JaLoPaIWC5
	3I7c13HcRnIZvz+zXIZUk/19Fv+rjVlK7d0zZyFaxsG/NFdOdU77kv9px6QbCinroZhDJM
	3P82UW70bVfW6E4B1HLYE7n3iWUaFWtHJpbyN0C9EtP5Nwm3cSoRORKCqrhB9w==
Message-ID: <11ea1885-9ee3-46c6-92e5-487df27bebc3@arinc9.com>
Date: Mon, 8 Jan 2024 12:48:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-9-luizluca@gmail.com>
 <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com>
 <7385ca39-182e-42c1-80bf-fd2d0c0aabdd@arinc9.com>
 <92fe7016-8c01-4f82-b7ec-a23f52348059@arinc9.com>
 <CAJq09z46T+uySp7DOLSpmh-Zouk2_CwvdMSmyuqB14bKSYf+jg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAJq09z46T+uySp7DOLSpmh-Zouk2_CwvdMSmyuqB14bKSYf+jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 8.01.2024 07:44, Luiz Angelo Daros de Luca wrote:
> Hi Arinç,
> 
>> It looks like this patch will cause the MDIO bus of the switches probed on
>> OF which are controlled by these subdrivers to only be registered
>> non-OF-based.
>>
>> drivers/net/dsa/b53/b53_common.c
>> drivers/net/dsa/lan9303-core.c
>> drivers/net/dsa/vitesse-vsc73xx-core.c
>>
>> These subdrivers let the DSA driver register the bus OF-based or
>> non-OF-based:
>> - ds->ops->phy_read() and ds->ops->phy_write() are present.
>> - ds->user_mii_bus is not populated.
> 
> I checked the changes on those drivers since
> fe7324b932222574a0721b80e72c6c5fe57960d1 and nothing indicates that
> they were changing anything related to the user mii bus. I also
> checked bindings for the mdio node requirement. None of them mentioned
> the mdio node.

Ok, we need to specifically mention the latter on the patch log.

> 
>> Not being able to register the bus OF-based may cause issues. There is an
>> example for the switch on the MT7988 SoC which is controlled by the MT7530
>> DSA subdriver. Being able to reference the PHYs on the switch MDIO bus is
>> mandatory on MT7988 as calibration data from NVMEM for each PHY is
>> required.
>>
>> I suggest that we hold off on this patch until these subdrivers are made to
>> be capable of registering the MDIO bus as OF-based on their own.
> 
> We might be over cautious keeping this for more time after the realtek
> refactoring gets merged. The using OF with the generic user mii bus
> driver is just a broken design and probably not in use. Anyway, it is
> not a requirement for the series. If there is no objection, I can drop
> it.

Sounds good to me. I'd like to take this patch off your hands.

> 
> I would like to send v4 with the OF node handling simplified by the
> change in the MDIO API. However, I'm reluctant to send mostly the same
> code without any reviews.

I suppose our conversation here will remind Vladimir and Alvin to review.

Arınç

