Return-Path: <netdev+bounces-177145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7351A6E09F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13687A5D4F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ECD263F3E;
	Mon, 24 Mar 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDt5jIm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E02638AD;
	Mon, 24 Mar 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836178; cv=none; b=F5WJGDJSNxsXsMehXGAc9WQKjJXRYT4YyZ1BuahgAYRhdZp+oynOI36rn3HC7ss3hsYz7iRR2P/1hY5ocVszN49wwe3WGwTW1NPPa+90UeXL7H/3Nz1gnoS+5sJMy69mVI8tMGQW3a6B1FYseHFuH993qydrRAcVbRSUibBLV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836178; c=relaxed/simple;
	bh=oS/jVNiBr+Qb2HZtLsR6LBU3TK7KODsBV2+Ozy0ozVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFOQlRHHUU3VPq5xZH1vDyw0waBuVI1NrlFaIr8QXMKYTcrAoiXLvmZPHaBHz6KCLdlZ1yN6lEbZCXA84o0CJHPanobPWfOH/IMsE7sbu7L0z93isryOlyH5kFhlEgXf2uZ2Vs6Tg5CQa3N32dFsjBd/BWxeK2NzMxO+cT+9OQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDt5jIm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B52BC4CEDD;
	Mon, 24 Mar 2025 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742836177;
	bh=oS/jVNiBr+Qb2HZtLsR6LBU3TK7KODsBV2+Ozy0ozVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDt5jIm/fSyr45MFjY+aw3XjhcUNk6TRMOuOfey2/9+sRdJ3QD0bhFAiNUi02mMc5
	 ZbGSHNncsx7pctqwGTQwHyrum7EYESiq/lrkP+I67l4iJvwOUGQW2/ONEFlEBNJxb+
	 WpKlm8IOtR0r6URfwrsVcwAir6X8fWPBPzBLB7TaOMQ4pY6x3BtuVkT1fFwGkNLwnW
	 +pdtWamuMT+1G1wg5cXBhDM/tsCBe5tRWwLG92bbycPTXpAhy0pp99Sn2eiLp/ojck
	 rTixPqR1BRonNMBVnpwu1awZQgIUhTQ0rmsl+AH10E1ussO74fCJdR+Ic0RNXDAKpk
	 OKDEgEuj9ELWA==
Date: Mon, 24 Mar 2025 12:09:36 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] dt-bindings: net: Document support for
 Aeonsemi PHYs
Message-ID: <20250324170936.GA584083-robh@kernel.org>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <20250323225439.32400-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323225439.32400-2-ansuelsmth@gmail.com>

On Sun, Mar 23, 2025 at 11:54:27PM +0100, Christian Marangi wrote:
> Document support for Aeonsemi PHYs and the requirement of a firmware to
> correctly work. Also document the max number of LEDs supported and what
> PHY ID expose when no firmware is loaded.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/aeonsemi,as21xxx.yaml        | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
> new file mode 100644
> index 000000000000..0549abcd3929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/aeonsemi,as21xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aeonsemi AS21XXX Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Aeonsemi AS21xxx Ethernet PHYs requires a firmware to be loaded to actually
> +  work. The same firmware is compatible with various PHYs of the same family.
> +
> +  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
> +  0x7500 0x7500
> +
> +  This can be done and is implemented by OEM in 2 different way:
> +    - Attached SPI flash directly to the PHY with the firmware. The PHY
> +      will self load the firmware in the presence of this configuration.
> +    - Manually provided firmware loaded from a file in the filesystem.
> +
> +  Each PHY can support up to 5 LEDs.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id7500.7500
> +  required:
> +    - compatible
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: specify the name of PHY firmware to load

maxItems: 1

as I think we allow more than 1. 

Not required? Then what is the default name (default: ???)?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy@1f {
> +            compatible = "ethernet-phy-id7500.7500",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg = <31>;
> +            firmware-name = "as21x1x_fw.bin";
> +
> +            leds {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                    reg = <0>;
> +                    color = <LED_COLOR_ID_GREEN>;
> +                    function = LED_FUNCTION_LAN;
> +                    function-enumerator = <0>;
> +                    default-state = "keep";
> +                };
> +
> +                led@1 {
> +                    reg = <1>;
> +                    color = <LED_COLOR_ID_GREEN>;
> +                    function = LED_FUNCTION_LAN;
> +                    function-enumerator = <1>;
> +                    default-state = "keep";
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a2df6d221bd..59a863dd3b70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -649,6 +649,7 @@ AEONSEMI PHY DRIVER
>  M:	Christian Marangi <ansuelsmth@gmail.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
>  F:	drivers/net/phy/as21xxx.c
>  
>  AF8133J THREE-AXIS MAGNETOMETER DRIVER
> -- 
> 2.48.1
> 

