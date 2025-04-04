Return-Path: <netdev+bounces-179336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B918FA7C074
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A51189BD88
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299131F543F;
	Fri,  4 Apr 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEdwwrAv"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D241F5413
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779979; cv=none; b=u/F06D6PfvRLL/GSMoENqpDObGPi8wlaT1NIcEbw9Ugr5Xcn2Kxs9XK+NIbmEA/YOa9DK257pNiz4OBC6OpXc4QhlexNHnM0zC5R0BWMOH99nW5iayO9WLYJviHhcpefZUWCjJDLtxSmlU3EIKFAtmlX6yXwvQ/UF++HqlOkBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779979; c=relaxed/simple;
	bh=eBQ9nNxE6lSXQIeYzj1Cau9JY6Jgqp7mRdU8CLlxMig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/TboGuHsSiq5RZxiQLUrkwSu9tW1xMaiF95OQxJgA5HDd+6VZ7iwWq4qPmT1u6dfp5+icpFxp5/s5/cr3fidWwecGFG/8Gz9fj6ggmLtODhKEyzJwZkIbKR/omAKJtV+Na/0Sz2jGH8ndwuNT41M9oJSMiO8jtN8+TZeEwocs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEdwwrAv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9a69eda-e066-49e1-979a-b6ec5ef115ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743779964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWX0HTz4vZa+tHFvj8jM2lcjDzCYW7m/OUMpzGk+52s=;
	b=TEdwwrAv1AvChzcWpwOAmY9TNVC9ryZeMsF2AhYAiE/SgE2zWcHO8rgoiPlQPfmHpm4vZJ
	Y1GrWAgWka1x006GeZk12ELJxehJ/BhINMU6qRe05vINZ1hdeBV6jC6Y4yd516v/7ToMd2
	6HZ7ZSJdudDFrdTfrWqn+5cOVYysmC8=
Date: Fri, 4 Apr 2025 11:19:18 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next PATCH 01/13] dt-bindings: net: Add binding for
 Xilinx PCS
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 devicetree@vger.kernel.org
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-2-sean.anderson@linux.dev>
 <20250404-tench-of-heavenly-beauty-fb4ed1@shite>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250404-tench-of-heavenly-beauty-fb4ed1@shite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/4/25 06:37, Krzysztof Kozlowski wrote:
> On Thu, Apr 03, 2025 at 02:18:55PM GMT, Sean Anderson wrote:
>> This adds a binding for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII
> 
> Incomplete review, since this is an RFC.

Only an RFC due to netdev's rules. I consider this patchset complete.

> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
>> LogiCORE IP. This device is a soft device typically used to adapt
>> between GMII and SGMII or 1000BASE-X (possbilty in combination with a
>> serdes). pcs-modes reflects the modes available with the as configured
>> when the device is synthesized. Multiple modes may be specified if
>> dynamic reconfiguration is supported.
>> 
>> One PCS may contain "shared logic in core" which can be connected to
>> other PCSs with "shared logic in example design." This primarily refers
>> to clocking resources, allowing a reference clock to be shared by a bank
>> of PCSs. To support this, if #clock-cells is defined then the PCS will
>> register itself as a clock provider for other PCSs.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  .../devicetree/bindings/net/xilinx,pcs.yaml   | 129 ++++++++++++++++++
>>  1 file changed, 129 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/net/xilinx,pcs.yaml b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
>> new file mode 100644
>> index 000000000000..56a3ce0c4ef0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
>> @@ -0,0 +1,129 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/xilinx,pcs.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE IP
>> +
>> +maintainers:
>> +  - Sean Anderson <sean.anderson@seco.com>
>> +
>> +description:
>> +  This is a soft device which implements the PCS and (depending on
>> +  configuration) PMA layers of an IEEE Ethernet PHY. On the MAC side, it
>> +  implements GMII. It may have an attached SERDES (internal or external), or
>> +  may directly use LVDS IO resources. Depending on the configuration, it may
>> +  implement 1000BASE-X, SGMII, 2500BASE-X, or 2.5G SGMII.
>> +
>> +  This device has a notion of "shared logic" such as reset and clocking
>> +  resources which must be shared between multiple PCSs using the same I/O
>> +  banks. Each PCS can be configured to have the shared logic in the "core"
>> +  (instantiated internally and made available to other PCSs) or in the "example
>> +  design" (provided by another PCS). PCSs with shared logic in the core are
>> +  reset controllers, and generally provide several resets for other PCSs in the
>> +  same bank.
>> +
>> +allOf:
>> +  - $ref: ethernet-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    contains:
> 
> From where did you get such syntax? What do you want to express?

The compatible should contain this value, but we don't really care what else it
contains. This aligns with how the kernel matches drivers to devices.

>> +      const: xilinx,pcs-16.2
> 
> What does the number mean?

It's the version of the IP. 

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 0
>> +    description:
>> +      Register a clock representing the clocking resources shared with other
>> +      PCSs.
> 
> Drop description, redundant.
> 
>> +
>> +  clocks:
>> +    items:
>> +      - description:
>> +          The reference clock for the PCS. Depending on your setup, this may be
>> +          the gtrefclk, refclk, clk125m signal, or clocks from another PCS.
>> +
>> +  clock-names:
>> +    const: refclk
>> +
>> +  done-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the reset-done output, if present.
>> +
>> +  interrupts:
>> +    items:
>> +      - description:
>> +          The an_interrupt autonegotiation-complete interrupt.
>> +
>> +  interrupt-names:
>> +    const: an
>> +
>> +  pcs-modes:
>> +    description:
>> +      The interfaces that the PCS supports.
>> +    oneOf:
>> +      - const: sgmii
>> +      - const: 1000base-x
>> +      - const: 2500base-x
>> +      - items:
>> +          - const: sgmii
>> +          - const: 1000base-x
> 
> This is confusing. Why fallbacks? Shouldn't this be just enum? And
> where is the type or constraints about number of items?

As stated in the commit message, multiple modes may be specified if
dynamic reconfiguration is supported. So I want to allow

	pcs-modes = "sgmii"
	pcs-modes = "1000base-x"
	pcs-modes = "2500base-x"
	pcs-modes = "sgmii", "1000base-x"

>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the reset input.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - pcs-modes
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pcs0: ethernet-pcs@0 {
>> +            #clock-cells = <0>;
> 
> Follow DTS coding style. clock-cells are never the first property.

Where is this documented?

>> +            compatible = "xlnx,pcs-16.2";
>> +            reg = <0>;
>> +            clocks = <&si570>;
>> +            clock-names = "refclk";
>> +            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "an";
>> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
>> +            done-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
>> +            pcs-modes = "sgmii", "1000base-x";
>> +        };
>> +
>> +        pcs1: ethernet-pcs@1 {
>> +            compatible = "xlnx,pcs-16.2";
>> +            reg = <1>;
>> +            clocks = <&pcs0>;
>> +            clock-names = "refclk";
>> +            interrupts-extended = <&gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "an";
>> +            reset-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
>> +            done-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
>> +            pcs-modes = "sgmii", "1000base-x";
> 
> Drop example, basically the same as previous.
> 
> Best regards,
> Krzysztof
> 

