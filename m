Return-Path: <netdev+bounces-123478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B48965059
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719211F22B31
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06731BA865;
	Thu, 29 Aug 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHup4ZAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472E1B81DF;
	Thu, 29 Aug 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961196; cv=none; b=Wa0L5MnKOTauqwHquT1aOXBjFtoH6tFU3MNI8Q7WeZnil9ksLyMzdFi6YvB3uMUj6eGo99zA/SBWWfOBDLhyPQ2MhwiF1RyVcSAbBokDC/SjFC6BEaZUiAFHzeOpAauqr7/nYEVVqg9/JUscDU0D3QTZT9Sbhb4VYHwGB6IkfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961196; c=relaxed/simple;
	bh=Uhx4a7Uk/gjBqwkYG9zbgHA+zupE9eLvr42o54btdDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHmy0YOl347B7f7senahkcYdyje9BmGBW7+chetZlRDqjYphHAbwGTpqvn/QaGeXk18iLxIwBYsloXShOs5vtf4LRIdGOFjb6Ct501ampXVdiS4R25L5++tmyYMaHR+WE60OZt5R6FhjR7f1ZX9m2/N3XYp3Q3MnOhw5A/N1wKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHup4ZAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF792C4CEC2;
	Thu, 29 Aug 2024 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961196;
	bh=Uhx4a7Uk/gjBqwkYG9zbgHA+zupE9eLvr42o54btdDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHup4ZAbQIDszLesnjFkYonoXAAftcq6rYOyspG92WaM2EGDWuUulXiOwWmnHKBrj
	 befMozd3bzj1DGALLm9cBef/F1q3NXtlPG3eG9BAFiDNFGbdwqzvJw3Gjcs27yjjWr
	 v8AjqcwRbBrycdt3sSWfpbrXxTB5hyZM22LaWSSW3f+4Kp1pULbPBbXRjniMTdUPhA
	 j5vz+N6Q3pIFAvYvD1/klmf4IhUgBewiL7Md2HWT1HhvCxpAftRm9et1xXkHpWsn/E
	 nqU3rplNQbiLrzmcpr3jSx3FT3eRZpO8fH2acDn64WnjO/HPq1GMv3eqhBh4t2yB2i
	 ZEQPejuJrD8dw==
Date: Thu, 29 Aug 2024 14:53:14 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <20240829195314.GA916906-robh@kernel.org>
References: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>

On Wed, Aug 28, 2024 at 11:51:49PM +0100, Daniel Golle wrote:
> Usually the MDI pair order reversal configuration is defined by
> bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> pair order and force either normal or reverse order.
> 
> Add mutually exclusive properties 'marvell,force-mdi-order-normal' and
> 'marvell,force-mdi-order-reverse' for that purpose.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: enforce mutually exclusive relationship of the two new properties in
>     dt-schema.
> 
>  .../bindings/net/marvell,aquantia.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> index 9854fab4c4db0..03b0cff239f70 100644
> --- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -22,6 +22,12 @@ description: |
>  
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      required:
> +        - marvell,force-mdi-order-normal
> +    then:
> +      properties:
> +        marvell,force-mdi-order-reverse: false
>  
>  select:
>    properties:
> @@ -48,6 +54,16 @@ properties:
>    firmware-name:
>      description: specify the name of PHY firmware to load
>  
> +  marvell,force-mdi-order-normal:
> +    type: boolean
> +    description:
> +      force normal order of MDI pairs, overriding MDI_CFG bootstrap pin.
> +
> +  marvell,force-mdi-order-reverse:
> +    type: boolean
> +    description:
> +      force reverse order of MDI pairs, overriding MDI_CFG bootstrap pin.

Why 2 properties for 1 setting? Just do something like this:

marvell,mdi-cfg-order = <0|1>;

1 means reverse, 0 means normal (or vise-versa). Not present then means 
use MDI_CFG setting. Then the binding naturally avoids nonsensical 
combinations of properties without the schema having to enforce it.

Feel free to tweak the naming/values. I would make 0 and 1 align with 
MDI_CFG states, but I don't know what those are.

Rob

