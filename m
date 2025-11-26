Return-Path: <netdev+bounces-241915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86176C8A4F7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A2E4E18D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441B2FCC04;
	Wed, 26 Nov 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k0ooTJYI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE69258CDC;
	Wed, 26 Nov 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167117; cv=none; b=qdPbgONKLIaWrNheJZCDBmNsrhbTbL0q9S/tibwoQ33GAtuZMvl7EMPNEm4fPE+O6mCGGwT/iPNLXgPLugVOVPAksORfjZGWqD8CSR/pQAhxl4z3nb1ByBQYZ8bnKrDpKmHcR96sKUnyGlzx1L4/YFEM0TpEQg4YN+gEOwxyj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167117; c=relaxed/simple;
	bh=Ocfwjie9+FicOOaIBzOuGpVUjaUpRkYlK9kIutmZR7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OU8Hzxd8T9cEWpEQwnFKjE9ny1Ng6Nx1D53nXPkoSp9YZAOBrQLePSwIhcXQ9nNa9ABFShH69AlYJVqYkMaxc9iE4Ye8k1i+ivAMgc0kjjAZerHGGNY9hC7FlJE7VDQH6iZPlsh3AjCXHREKU/YTHUMvX+OJPcT56ya0YdD75DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k0ooTJYI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8725A4E418F3;
	Wed, 26 Nov 2025 14:25:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 578AB60721;
	Wed, 26 Nov 2025 14:25:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64B5A102F08EF;
	Wed, 26 Nov 2025 15:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764167111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Sbs0A8qAYuq+r/+1fjxriavvnUhEfhMgY7SBF5X8V08=;
	b=k0ooTJYIYW0FYBMVhrgVBpA7A6kXMyqERAgQSrzwOurSlWfmkbqR/cAmccU11VWLC5YJEI
	n6WrPplsAi0/qCeWTP5rC5r6OVtJarSahnvu8/ytGNtL2IhjV2o4qcZLK1BKZ9REOhbIne
	GpHwbaHF7/xV6QP11Em8OqvJQxr/vpKrq/B/xhMU6iRCotsKbsvezuDAlSdbcWdLA7WkHY
	PgHtTABkVp75O1gL9djdWOv4/kvWgJGTXQQtoWevSW4VHF0gnednfaSxWzHACT5hKJnynF
	DcFAau2f9LPmwhjE9ZTrqGuSx7982EfRtb9Sv1Y9Gy4TO0KRoTFUYh71zTNEkA==
Message-ID: <9c2518d8-a0ea-46ba-9069-999c2574cd24@bootlin.com>
Date: Wed, 26 Nov 2025 15:25:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?B?TWFyZWsgQmVo4oia4oirbg==?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251126072638.wqwbhhab3afxvm7x@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 26/11/2025 08:26, Vladimir Oltean wrote:
> +Maxime, Holger
> thread at https://lore.kernel.org/netdev/20251122193341.332324-2-vladimir.oltean@nxp.com/
> 
> On Tue, Nov 25, 2025 at 11:33:09PM +0100, Andrew Lunn wrote:
>>> Yeah, although as things currently stand, I'd say that is the lesser of
>>> problems. The only user (mv88e6xxx) does something strange: it says it
>>> wants to configure the TX amplitude of SerDes ports, but instead follows
>>> the phy-handle and applies the amplitude specified in that node.
>>>
>>> I tried to mentally follow how things would work in 2 cases:
>>> 1. PHY referenced by phy-handle is internal, then by definition it's not
>>>    a SerDes port.
>>> 2. PHY referenced by phy-handle is external, then the mv88e6xxx driver
>>>    looks at what is essentially a device tree description of the PHY's
>>>    TX, and applies that as a mirror image to the local SerDes' TX.
>>>
>>> I think the logic is used in mv88e6xxx through case #2, i.e. we
>>> externalize the mv88e6xxx SerDes electrical properties to an unrelated
>>> OF node, the connected Ethernet PHY.
>>
>> My understanding of the code is the same, #2. Although i would
>> probably not say it is an unrelated node. I expect the PHY is on the
>> other end of the SERDES link which is having the TX amplitudes
>> set. This clearly will not work if there is an SFP cage on the other
>> end, but it does for an SGMII PHY.
> 
> It is unrelated in the sense that the SGMII PHY is a different kernel
> object, and the mv88e6xxx is polluting its OF node with properties which
> it then interprets as its own, when the PHY driver may have wanted to
> configure its SGMII TX amplitude too, via those same generic properties.
> 
>> I guess this code is from before the time Russell converted the
>> mv88e6xxx SERDES code into PCS drivers. The register being set is
>> within the PCS register set.  The mv88e6xxx also does not make use of
>> generic phys to represent the SERDES part of the PCS. So there is no
>> phys phandle to follow since there is no phy.
> 
> In my view, the phy-common-props.yaml are supposed to be applicable to either:
> (1) a network PHY with SerDes host-side connection (I suppose the media
>     side electrical properties would be covered by Maxime's phy_port
>     work - Maxime, please confirm).

True, but we could definitely conceive applying phy-common-props.yaml on
the media-side as well :) I don't have a use-case for it right now
though, and we don't yet have detailed descriptions of the electrical
properties.

Maxime


