Return-Path: <netdev+bounces-36890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3627B2119
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B021328306F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCCF4F121;
	Thu, 28 Sep 2023 15:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247138DF9;
	Thu, 28 Sep 2023 15:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EADC433C8;
	Thu, 28 Sep 2023 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695914584;
	bh=rcZ+yPGU6okKYD+rLigRTLFj0SWxtD4Qs2tvWAkbLxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iY4F9BLerOAK76UmoDcIZx4ZmZUfptcUF+XovFro9utaD7rc1RloVIF/jGr4J1gfN
	 CKfbjowpbgX57d8+QhMSqFQjRIbTtnzwvNr90NGJ2C5W0h/bFd7P8bJpq9M7eSp4oH
	 3X9HKU3h+yBrY5IhhP2gelS7q9UxYHBnwE5WA3SqCDpg6H2t5zKy2rYossxo/Ib7Vw
	 bKdcgvuLZZK293u2iI86/TCrF/H/bd38+Wr6y4GsED51zkNUWbKaBoAPe/Ak406EHA
	 LYgsQc95936b4A/IH7ystFKFnH77SvrGMnAqSUOUx+6rjh7FLSGpROJqChxf6OU43w
	 s+YJTtBOMnH+g==
Received: (nullmailer pid 532633 invoked by uid 1000);
	Thu, 28 Sep 2023 15:23:01 -0000
Date: Thu, 28 Sep 2023 10:23:01 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] dt-bindings: net: add new property
 st,ext-phyclk in documentation for stm32
Message-ID: <20230928152301.GA512899-robh@kernel.org>
References: <20230928122427.313271-1-christophe.roullier@foss.st.com>
 <20230928122427.313271-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928122427.313271-3-christophe.roullier@foss.st.com>

On Thu, Sep 28, 2023 at 02:24:17PM +0200, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock

typo

> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel

Certainly 1 property is better than 2 for me, but carrying 3 is not 
great. I don't understand why the we need a new property. What can't be 
supported with the existing properties?

> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index ca976281bfc22..54fda8b052abc 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -78,12 +78,21 @@ properties:
>        encompases the glue register, the offset of the control register and
>        the mask to set bitfield in control register
>  
> +  st,ext-phyclk:
> +     description:
> +      set this property in RMII mode when you have PHY without crystal 50MHz and want to
> +      select RCC clock instead of ETH_REF_CLK. or in RGMII mode when you want to select
> +      RCC clock instead of ETH_CLK125.
> +    type: boolean

It's not clear to me what 'external' (assuming that's what 'ext' is 
short for) means. A crystal is external to the PHY too. So it means 'the 
PHY has no crystal'? That's a property of the PHY though, so it should 
be in the PHY's node. If you want this in the MAC node, then name the 
property and make the description primarily about the MAC modes.

> +
>    st,eth-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
>      type: boolean
>  
>    st,eth-ref-clk-sel:
> +    deprecated: true
>      description:
>        set this property in RMII mode when you have PHY without crystal 50MHz and want to
>        select RCC clock instead of ETH_REF_CLK.
> -- 
> 2.25.1
> 

