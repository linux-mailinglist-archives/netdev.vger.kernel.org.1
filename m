Return-Path: <netdev+bounces-60629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D482070B
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B541E281F04
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D38F71;
	Sat, 30 Dec 2023 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Syy4KysW"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD89461
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D52D9C0004;
	Sat, 30 Dec 2023 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703951814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tQIsanVDq6tiMKLaUiWGbKy0amt9tYKA1Sa2MeFlqA=;
	b=Syy4KysWCLndejplhk19USnnX/vmqCEtDsiqXSuZRBmJRetDaC9HDspX3lx9HDVSzLs7j+
	Ad/PtAQIYwXdpwlb2QPAzEKzaBhU4ZMjbSb6tKfypMY0VjFiJieSIsDVEeYN/hFVgOslXS
	njOzFU0ByhJZa4aREUWNWC4HUa2U6PrvNldXrW8ljXtGCBoOVcLHutr+gxSlWkyTsHdpiC
	0DUTjQEY5bso1cUU72TFvNTl5T3VUmf+fTwGtTACYIZizRUuMeY81Gx00db7n8018RtR3m
	9a7FfS9CkGX0iy40XiuibPeVl+Im66VEVUNhP7hj3XPlwEZd/irp3dewRNH+cg==
Message-ID: <7385ca39-182e-42c1-80bf-fd2d0c0aabdd@arinc9.com>
Date: Sat, 30 Dec 2023 18:56:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-9-luizluca@gmail.com>
 <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com>
Content-Language: en-US
In-Reply-To: <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 30.12.2023 10:18, Arınç ÜNAL wrote:
> On 23.12.2023 03:46, Luiz Angelo Daros de Luca wrote:
>> This reverts commit fe7324b932222574a0721b80e72c6c5fe57960d1.
>>
>> The use of user_mii_bus is inappropriate when the hardware is described
>> with a device-tree [1].
>>
>> Since all drivers currently implementing ds_switch_ops.phy_{read,write}
>> were not updated to utilize the MDIO information from OF with the
>> generic "dsa user mii", they might not be affected by this change.
>>
>> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> 
> This doesn't make sense to me: "The use of user_mii_bus is inappropriate
> when the hardware is described with a device-tree." I think this is the
> correct statement: "The use of user_mii_bus is inappropriate when the MDIO
> bus of the switch is described on the device-tree."
> 
> The patch log is also not clear on why this leads to the removal of
> OF-based registration from the DSA core driver.
> 
> I would change the patch log here to something like this:
> 
> net: dsa: do not populate user_mii_bus when switch MDIO bus is described
> 
> The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
> switch is described on the device-tree [1].
> 
> To keep things simple, make [all subdrivers that control a switch [with
> MDIO bus] probed on OF] register the bus on the subdriver.
> 
> The subdrivers that control switches [with MDIO bus] probed on OF must
> follow this logic to support all cases properly:
> 
> No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if "interrupt-controller" is defined at
> the switch node.
> 
> Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
> the switch node and "interrupts" is defined at the PHY nodes under the
> switch MDIO bus node].
> 
> There can be a case where ds->user_mii_bus is not populated, but
> ds_switch_ops.phy_{read,write} is. That would mean the subdriver controls a
> switch probed on OF, and it lets the DSA core driver to populate
> ds->user_mii_bus and register the bus. We don't want this to happen.
> Therefore, ds_switch_ops.phy_{read,write} should be only used on the
> subdrivers that control switches probed on platform_data.
> 
> With that, the "!ds->user_mii_bus && ds->ops->phy_read" check under
> dsa_switch_setup() remains in use only for switches probed on
> platform_data. Therefore, remove OF-based registration as it's useless now.
> 
> ---
> 
> I think we should do all this in a single patch. I've done it on the MT7530
> DSA subdriver which I maintain.

Actually, there's no need to drag this patch further by including the
improvement of handling the MDIO bus on all relevant subdrivers.

That said, I'd like to submit this patch myself, if it is OK by everyone
here.

Here's the patch log I've prepared:

net: dsa: do not populate user_mii_bus when switch MDIO bus is described

The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
switch is described on the device-tree [1].

To keep things simple, make [all subdrivers that control switches [with
MDIO bus] probed on OF] register the bus on the subdriver. This is already
the case on all of these subdrivers.

There can be a case where ds->user_mii_bus is not populated, but
ds_switch_ops.phy_{read,write} is. That would mean the subdriver controls
switches probed on OF, and it lets the DSA core driver to populate
ds->user_mii_bus and register the bus. We don't want this to happen.
Therefore, ds_switch_ops.phy_{read,write} should be only used on the
subdrivers that control switches probed on platform_data.

With that, the "!ds->user_mii_bus && ds->ops->phy_read" check under
dsa_switch_setup() remains in use only for switches probed on
platform_data. Therefore, remove OF-based registration as it's useless now.

Currently, none of the subdrivers that control switches [with MDIO bus]
probed on OF implements ds_switch_ops.phy_{read,write} so no subdriver will
be affected by this patch.

The subdrivers that control switches [with MDIO bus] probed on OF must
follow this logic to support all cases properly:

No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if "interrupt-controller" is defined at
the switch node. This case should only be covered for the switches which
their dt-bindings documentation didn't document the MDIO bus from the
start. This is to keep supporting the device trees that do not describe the
MDIO bus on the device tree but the MDIO bus is being used nonetheless.

Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
the switch node and "interrupts" is defined at the PHY nodes under the
switch MDIO bus node].

Let's leave the improvement of handling the MDIO bus on relevant subdrivers
to future patches.

Arınç

