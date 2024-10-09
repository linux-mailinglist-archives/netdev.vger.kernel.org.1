Return-Path: <netdev+bounces-133757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE4996F8A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEDF1C21716
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9C1A0B06;
	Wed,  9 Oct 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEjTCNDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C72AD1C;
	Wed,  9 Oct 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486746; cv=none; b=PrxaJ7q0TZZhhCvPa18CnFDojYBGj0MR+q+5h/MhXVtzF0cqQwq2B0/3BH+ybPVobIOm0E7XdpL0AXjpMlGp6zdao+MtSmvkbBAcq7aZn0JM5bmXbGlorSf00YJMbX/8Z21u3OmsIwk+rSI/sp5SPW4V/iMcvoGKG2RIXQj/SaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486746; c=relaxed/simple;
	bh=Nm+qU5w3dxZgTOqL/lq95V9u3ynP5UfvFPdgv/Ekz+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI/YpWm5iEhg6dvHzwXNXoUlKap1QbP6XkiJtAsEKgl0Zg53CBVVwKpRHveVvjB0VWsqd+n8VZJVQOi/YaWlUmXes+aqDIvO/xq5tYixE7NMGd9YHa+mxn8lI7B5JJOieCkY4rNGbcXMFalsl5FGkcy3aqXK+z4/6iHoe7dJAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEjTCNDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC2C4CEC3;
	Wed,  9 Oct 2024 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486745;
	bh=Nm+qU5w3dxZgTOqL/lq95V9u3ynP5UfvFPdgv/Ekz+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEjTCNDylhVEyIt4djWXFTall6q8pE6U3D3idS7nQeL+nKUZhZLqlyXUXuMLxaeHc
	 O+dBMvk9iIjzXVcR5p+FTMx0ydzvjXnRRxDL/KFALcLm2LsxsDn0hPVGzl4XqML15D
	 T2pan7yiSkN9gUSQmbx9wtZ41/XG5w63RpambP84NCRR/SoAJIB0jhoddeYluB78Dg
	 U8J0KjkgPQ1LW20ZUI9xBsBsesE2V5eYSjMvm1g9vC52o9uAvVPqECtwjFxk+EhJ1W
	 9S38zVNF5v+vZQTyEAmHkkTMP1OGb9n5nLbGQ7Won5ZxgilwqCAGCJmD7GXLfLSIRC
	 zlv6L+Bi8LYww==
Date: Wed, 9 Oct 2024 10:12:23 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,rmii-refclk-out" property
Message-ID: <20241009151223.GA522364-robh@kernel.org>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008070708.1985805-2-wei.fang@nxp.com>

On Tue, Oct 08, 2024 at 03:07:07PM +0800, Wei Fang wrote:
> Per the RMII specification, the REF_CLK is sourced from MAC to PHY
> or from an external source. But for TJA11xx PHYs, they support to
> output a 50MHz RMII reference clock on REF_CLK pin. Previously the
> "nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
> this property is present, REF_CLK is input to the PHY, otherwise
> it is output. This seems inappropriate now. Because according to
> the RMII specification, the REF_CLK is originally input, so there
> is no need to add an additional "nxp,rmii-refclk-in" property to
> declare that REF_CLK is input.
> 
> Unfortunately, because the "nxp,rmii-refclk-in" property has been
> added for a while, and we cannot confirm which DTS use the TJA1100
> and TJA1101 PHYs, changing it to switch polarity will cause an ABI
> break. But fortunately, this property is only valid for TJA1100 and
> TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
> invalid because they use the nxp-c45-tja11xx driver, which is a
> different driver from TJA1100/TJA1101. Therefore, for PHYs using
> nxp-c45-tja11xx driver, add "nxp,rmii-refclk-out" property to
> support outputting RMII reference clock on REF_CLK pin.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> 1. Change the property name from "nxp,reverse-mode" to
> "nxp,phy-output-refclk".
> 2. Simplify the description of the property.
> 3. Modify the subject and commit message.
> V3 changes:
> 1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
> 2. Rephrase the commit message and subject.
> V3 changes:
> 1. Change the property name from "nxp,phy-output-refclk" to
> "nxp,rmii-refclk-out", which means the opposite of "nxp,rmii-refclk-in".
> 2. Refactor the patch after fixing the original issue with this YAML.
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> index a754a61adc2d..1e688c7a497d 100644
> --- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> @@ -62,6 +62,24 @@ allOf:
>              reference clock output when RMII mode enabled.
>              Only supported on TJA1100 and TJA1101.
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ethernet-phy-id001b.b010
> +              - ethernet-phy-id001b.b013
> +              - ethernet-phy-id001b.b030
> +              - ethernet-phy-id001b.b031
> +
> +    then:
> +      properties:
> +        nxp,rmii-refclk-out:
> +          type: boolean
> +          description: |

Don't need '|' if no formatting.

> +            Enable 50MHz RMII reference clock output on REF_CLK pin. This
> +            property is only applicable to nxp-c45-tja11xx driver.

Reword this to not be about some driver.

> +
>  patternProperties:
>    "^ethernet-phy@[0-9a-f]+$":
>      type: object
> -- 
> 2.34.1
> 

