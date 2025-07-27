Return-Path: <netdev+bounces-210407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3387B13207
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED633173471
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE62397BF;
	Sun, 27 Jul 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="bLkNCHs2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B58635D
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653150; cv=none; b=pzxrwRFaU6QnXjmb29Wy39jeLCbAs19o7UHfnGfrc4Her3NuO7FMpztJYS7Hq5ugsqeH6r7QtoLw9T7T0BZaO4CRtYyzn8lDknoFC80cXYvulkX+AaSn7hns1gITJdf/rUCKgrqFL3taTLSjTaDu26yRebFRrJDO5PxI07ffMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653150; c=relaxed/simple;
	bh=N0APxAeG9t37xZ9G+TVThe0V8aH45UEZqv6kQFu+QrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeUkyTR7PupS/TEteO4XDl4MwiDm1khJxbismQeKWSYUuxOvRvFRaFD4J40h3oR+TRGgOZu5M5JSv0Xypf1Awwtk1XIe457hOlq35dytQ+u1ahcGBRpBJrEFDMff5wHPf/Nmfvu7MeESLouQZcvoD0RFo4CGqzjYGilqJBNAq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=bLkNCHs2; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753653146;
 bh=gG+K+EvdGySBaqP3c+lFA0pUt8fKLg2/x4AVyg5jhrc=;
 b=bLkNCHs26Crr11KwXC2k9BQBj4u2cFKhnRwUF99mbTPqYiyRDZTO7IgBvdNGApPUYEbgRjLpv
 GredDDt3N1RbOrwZB0WUzW6CgwYAQfm7Lbbk0FUh9sJutWGTw/eAYjLLlTJnbUPJOLs85qUnjLH
 p6onbca3vfjtnnuA2cELmb+jt7U8dbjZ2WOqTwqcaDeeudBtSIrHQ5rEQBwf4N2doqZFYgJ38cs
 rvJsRWIjP4cyylthMr5B7fNFeqmeua7U7nOqJSJIUNclbRqvkI3AkRbGloE9NyjE4Kpsai1IgAL
 M6DfRrMBnpL2mVzA2q8U3U1txBbIq1tIJubIiOS3dN8g==
X-Forward-Email-ID: 68869f8dc509b9ee169d35e6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>
Date: Sun, 27 Jul 2025 23:52:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of an
 optional mdio node
To: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
 <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/27/2025 9:09 PM, Andrew Lunn wrote:
> On Sun, Jul 27, 2025 at 06:02:59PM +0000, Jonas Karlman wrote:
>> The dt-bindings schema for Realtek switches for unmanaged switches
>> contains a restriction on use of a mdio child OF node for MDIO-connected
>> switches, i.e.:
>>
>>   if:
>>     required:
>>       - reg
>>   then:
>>     not:
>>       required:
>>         - mdio
>>     properties:
>>       mdio: false
>>
>> However, the driver currently requires the existence of a mdio child OF
>> node to successfully probe and properly function.
>>
>> Relax the requirement of a mdio child OF node and assign the dsa_switch
>> user_mii_bus to allow a MDIO-connected switch to probe and function
>> when a mdio child OF node is missing.
>  
> I could be getting this wrong.... Maybe Linus knows more.
> 
> It could be the switch does not have its own separate MDIO bus just
> for its internal PHYs. They just appear on the parent mdio bus. So
> you represent this with:
> 
> &mdio0 {
> 	reset-delay-us = <25000>;
> 	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> 	reset-post-delay-us = <100000>;
> 
> 	phy0: ethernet-phy@0 {
> 		reg = <0>;
> 	};
> 
> 	phy1: ethernet-phy@1 {
> 		reg = <0>;
> 	};
> 
> 
>         ethernet-switch@1d {
>                compatible = "realtek,rtl8365mb";
>                reg = <0x1d>;
>                pinctrl-names = "default";
>                pinctrl-0 = <&rtl8367rb_eint>;
> 
>                ethernet-ports {
>                        #address-cells = <1>;
>                        #size-cells = <0>;
> 
>                        ethernet-port@0 {
>                                reg = <0>;
>                                label = "wan";
> 			       phy-handle = <phy0>;
>                        };
> 
>                        ethernet-port@1 {
>                                reg = <1>;
>                                label = "lan1";
> 			       phy-handle = <phy1>;
>                        };
> 
> If this is correct, you should not need any driver or DT binding
> changes.

Something like above does not seem to work, I get following:

  mdio_bus stmmac-0: MDIO device at address 0 is missing.
  mdio_bus stmmac-0: MDIO device at address 1 is missing.
  mdio_bus stmmac-0: MDIO device at address 2 is missing.
  mdio_bus stmmac-0: MDIO device at address 3 is missing.

  rtl8365mb-mdio stmmac-0:1d: found an RTL8367RB-VB switch
  rtl8365mb-mdio stmmac-0:1d: configuring for fixed/rgmii link mode
  rtl8365mb-mdio stmmac-0:1d wan (uninitialized): failed to connect to PHY: -ENODEV
  rtl8365mb-mdio stmmac-0:1d: Link is Up - 1Gbps/Full - flow control off
  rtl8365mb-mdio stmmac-0:1d wan (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 0
  rtl8365mb-mdio stmmac-0:1d lan1 (uninitialized): failed to connect to PHY: -ENODEV
  rtl8365mb-mdio stmmac-0:1d lan1 (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 1
  rtl8365mb-mdio stmmac-0:1d lan2 (uninitialized): failed to connect to PHY: -ENODEV
  rtl8365mb-mdio stmmac-0:1d lan2 (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 2
  rtl8365mb-mdio stmmac-0:1d lan3 (uninitialized): failed to connect to PHY: -ENODEV
  rtl8365mb-mdio stmmac-0:1d lan3 (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 3

And without an explicit 'mdio' child node the driver currently fails to
load and the switch is never registered:

  rtl8365mb-mdio stmmac-0:1d: found an RTL8367RB-VB switch
  rtl8365mb-mdio stmmac-0:1d: no MDIO bus node
  rtl8365mb-mdio stmmac-0:1d: could not set up MDIO bus
  rtl8365mb-mdio stmmac-0:1d: error -ENODEV: unable to register switch

With a 'mdio' child node 'make CHECK_DTBS=y' report something like:

  rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
        from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#

So something should probably be changed, the driver, dt-bindings or
possible both.

With this patch the last example in net/dsa/realtek.yaml can be made to
work. The example the ethernet-switch node in next patch is based on,
and something that closely matches how mediatek,mt7530 is described.

Please let me know if you want me to drop this and instead try to update
the dt-bindings and use a more verbose ethernet-switch node.

Regards,
Jonas

> 
> 	Andrew


