Return-Path: <netdev+bounces-210634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EDB14163
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B2A5425FD
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF125C711;
	Mon, 28 Jul 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FsHhCp3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3C219A89
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724896; cv=none; b=ULDC1s2PPCinoFzWGzStr40ZNUAbaRHvYLxrOTBg2Q9XN51vudW2pRme9u4hASFmqTz+HGfe8z4vJD4KgbMpZgeRioZA2FNep73KI3rArsqlqRkLM4u67UEiccaSt7x3Zoxvt3+2WsEgC4QGEgIsHz29MBm6cE1GoegZGl4Asq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724896; c=relaxed/simple;
	bh=hh6zViyTLFJ5MZJcb9GHpRrQp8Vl4Gt/wvCtOdiR/NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExA96VEeeMXwLmLwCsAJI9rJK4LjXeFAwrBtIFPnF2U7KLMK0SULdU66s0imDkE9lGEdfzkzEYriCHM5TjlGnbAapfwv16wOWOXmQ1xEddNyNHn1u8gtHGD1Ud3A3uIlCgBdt3q8PDA8jE2RDfyj0mxqfpo5J4VXviCMOF0Z+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FsHhCp3y; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753724893;
 bh=CoB5tasYH7GrZPehMHvuHgB7MplGLckmtYJLeYrDXq4=;
 b=FsHhCp3yRtLLtoRqlbXEX8Q5rFzEEh9QRCR/7Le8sdw5zLwuTuEbXHWurxoX/2ha7byTfyilU
 CjOcGDZ6/yeLPUb/KLfOJriqfflAd+J3dx0ey+XrASe5slFmUkQ0evgcMUBXzVfw7mKRXOSt+Xg
 LNKy+7kAhNfMcw7ANedoc0v01k8RZFD8FAQ4ATtM/AJEk7tX0ML5DXysH53gK2wx9/m6t34ymWK
 141VK7mIwCDaPW0nG14AsbaPvKXFKolGz8xNS1qE58ONYqqMIeUQPoJoPKVDPFiRAb6UUZBLkrp
 9OhLmSXKpa4P7tYBhEr/QgKsS3i353CTP4tEoAunqCOw==
X-Forward-Email-ID: 6887b7c8351ec66b15a2df24
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
Date: Mon, 28 Jul 2025 19:47:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, conor+dt@kernel.org,
 davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com,
 heiko@sntech.de, krzk+dt@kernel.org, kuba@kernel.org,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
 robh@kernel.org, ziyao@disroot.org
References: <20250727180305.381483-4-jonas@kwiboo.se>
 <20250728143020.1007374-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250728143020.1007374-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/28/2025 4:30 PM, Chukun Pan wrote:
> Hi,
> 
>> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
>> and only around ~1-2 Mbits/sec in the other direction.
> 
>> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
>> seem to resolve this speed issue, however dropping snps,tso seems to fix
>> that issue.
> 
> Have you tried setting phy-mode to rgmii? (just for testing)
> Usually this problem is caused by incorrect rx/tx delay.

The issue is with TSO and RX checksum offload, with those disabled on
the conduit interface (gmac1/eth0) my issues disappeared.

Use of rgmii-id "RX and TX delays are not provided by the PCB." as
defined by the dt-bindings seem to most correctly describe the HW.

Describing switches is new to me, so I could be wrong :-)

> 
>> +	ethernet-switch@1d {
>> +		compatible = "realtek,rtl8365mb";
>> +		reg = <0x1d>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&rtl8367rb_eint>;
> 
> Shouldn't this pinctrl be written in interrupts?

Not necessarily, in my mind the pinctrl is applied for the switch
interface to the SoC, not the internal workings of the switch.

> 
>> +			ethernet-port@6 {
>> +				reg = <6>;
>> +				ethernet = <&gmac1>;
>> +				label = "cpu";
> 
> No need for label = "cpu":
> https://github.com/torvalds/linux/commit/567f38317054e66647fd59cfa4e261219a2a21db

Thanks, will drop in v2.

> 
>> This series relaxes the realtek dsa drivers requirement of having a mdio
>> child OF node to probe and instead have it register a user_mii_bus to
>> make it function when a mdio child OF node is missing.
> 
> This is weird, the switch is connected to the gmac via mdio.
> Can you try the following and see if it works? I tried it on
> a rk3568 + rtl8367s board and it worked:

With a 'mdio' child node 'make CHECK_DTBS=y' report something like:

   rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
         from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#

With a mdio node the driver is happy and dtschema is sad, and without
the mdio node it was the other way around.

The plan is to drop this patch and instead modify the dt-binding to
allow describing a mdio node when the switch node has a reg prop in v2.

Regards,
Jonas

> 
> ```
> &mdio1 {
> 	switch@29 {
> 		compatible = "realtek,rtl8365mb";
> 		reg = <29>;
> 		reset-gpios = ...
> 
> 		switch_intc: interrupt-controller {
> 			interrupt-parent = ...
> 			interrupts = ...
> 			interrupt-controller;
> 			#address-cells = <0>;
> 			#interrupt-cells = <1>;
> 		};
> 
> 		mdio {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			phy0: ethernet-phy@0 {
> 				reg = <0>;
> 				interrupt-parent = <&switch_intc>;
> 				interrupts = <0>;
> 			};
> 
> 			phy1: ethernet-phy@1 {
> 				reg = <1>;
> 				interrupt-parent = <&switch_intc>;
> 				interrupts = <1>;
> 			};
> 
> 			phy2: ethernet-phy@2 {
> 				reg = <2>;
> 				interrupt-parent = <&switch_intc>;
> 				interrupts = <2>;
> 			};
> 
> 			phy3: ethernet-phy@3 {
> 				reg = <3>;
> 				interrupt-parent = <&switch_intc>;
> 				interrupts = <3>;
> 			};
> 		};
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
> 				label = "wan";
> 				phy-handle = <&phy0>;
> 			};
> 
> 			port@1 {
> 				reg = <1>;
> 				label = "lan1";
> 				phy-handle = <&phy1>;
> 			};
> 
> 			port@2 {
> 				reg = <2>;
> 				label = "lan2";
> 				phy-handle = <&phy2>;
> 			};
> 
> 			port@3 {
> 				reg = <3>;
> 				label = "lan3";
> 				phy-handle = <&phy3>;
> 			};
> 
> 			port@x {
> 				reg = <x>;
> 				ethernet = <&gmac1>;
> 				phy-mode = "rgmii";
> 
> 				fixed-link {
> 					speed = <1000>;
> 					full-duplex;
> 				};
> 			};
> 		};
> 	};
> };
> ```
> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 


