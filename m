Return-Path: <netdev+bounces-195319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2289ACF865
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F816E9EB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDD27B4FA;
	Thu,  5 Jun 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYuvKPvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F625FEE6;
	Thu,  5 Jun 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153147; cv=none; b=DlpMhMTz17ovgU7BVkOH7WU4f37q7QaB3i36OfWyWHI8yDuquvyWpTwJsdnpFgMmt4ftgDWSJyniPBwZ/BW9KHN8Jsc2PKvUyeO9R/jqtlOuYnwqWBB8OF1KcK22HzgtkCP4Ozvniq7tbDkZ9OIQuZdU9tiOW903FVhG7w4z75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153147; c=relaxed/simple;
	bh=Vj+0V44ekQYgKo+tCVZdrvqXvAUHULz4OsWXB2zgv8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEzPrfmfzjbM/GWmu+sNBhbzGmi6nMZ4fgHyjByETwwQlVa1R5vIXNg6pcNzCltUAQlIv43UzprVj2fL9hxx0okifJINk4e7kyEp4vEIT09wYnMFdMpoUHsWixBFoJDUufhfhGTu4Nkqiai+NoNEpuRXkqjptKwgtcdgh2ZlMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYuvKPvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31406C4CEE7;
	Thu,  5 Jun 2025 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153147;
	bh=Vj+0V44ekQYgKo+tCVZdrvqXvAUHULz4OsWXB2zgv8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYuvKPvJjeLtnOBPVv1M8u7z7QvELFLiMhwk6qcoa+U39sytsxUO0OcR7KYkyfKTb
	 jTC/gwZruxvqALtrn1clBEQAoMq1WOMz/q98tvFOcZD0anrqNLVIoFuxAB/FHlpbPW
	 Mk+bXFaVUEdRo5Oqw7LLitoIQ1d2tTUN1tDyRTi1H2iGOe9cUWRjeGVfjQdApor79/
	 dXSQ87QGrHb3pniWWzENNM5yh1kai1lcla4WvDam9x3gBgEDnD4+oDWlACKxP63OBP
	 6M9Bvv6XsJmUfvPH+lKgaa1Vux9lsHU85u90NCcED4odhaxv3pdDABLthgdMSO3eIo
	 9lKPvKK139jxQ==
Date: Thu, 5 Jun 2025 14:52:25 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/2] dt-bindings: net: Document support for
 Airoha AN7583 MDIO Controller
Message-ID: <20250605195225.GA3119975-robh@kernel.org>
References: <20250527213503.12010-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527213503.12010-1-ansuelsmth@gmail.com>

On Tue, May 27, 2025 at 11:34:42PM +0200, Christian Marangi wrote:
> Airoha AN7583 SoC have 3 different MDIO Controller. One comes from
> the intergated Switch based on MT7530. The other 2 live under the SCU
> register and expose 2 dedicated MDIO controller.
> 
> Document the schema that expose the 2 dedicated MDIO controller.
> Each MDIO controller can be independently reset with the SoC reset line.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an7583-mdio.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
> new file mode 100644
> index 000000000000..2375f1bf85a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,an7583-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN7583 Dedicated MDIO Controller
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN7583 SoC have 3 different MDIO Controller.
> +
> +  One comes from the intergated Switch based on MT7530.
> +
> +  The other 2 (that this schema describe) live under the SCU
> +  register supporting both C22 and C45 PHYs.
> +
> +properties:
> +  compatible:
> +    const: airoha,an7583-mdio
> +

No registers? Looks to me like this middle node should go and the SCU 
node should have 2 mdio child nodes at 0xc8 and 0xcc.

It looks like you'll need to define the speed mode bit location somehow 
as well.

> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  '^mdio(-(bus|external))@[0-1]$':

Just '^mdio@[0-1]$'

If you need to distinguish external or something, use compatible or 
something.

> +    type: object
> +
> +    $ref: mdio.yaml#
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mdio-controller {
> +        compatible = "airoha,an7583-mdio";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mdio-bus@0 {
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ethernet-phy@1f {
> +                reg = <31>;
> +            };
> +        };
> +
> +        mdio-bus@1 {
> +            reg = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +    };
> -- 
> 2.48.1
> 

