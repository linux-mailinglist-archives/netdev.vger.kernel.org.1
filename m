Return-Path: <netdev+bounces-110010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD092AAD2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3791283186
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933514D702;
	Mon,  8 Jul 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGJApps5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3021EA74;
	Mon,  8 Jul 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472338; cv=none; b=kPIIloaAyNkk6J4/rMfYuCrHTVZoSvXjdy2qNFAVlKVwlewd9GRnfVV95Douc/x/jCI+r29cCCxX/otP6DWQ46pRxB9H14Ts4La77+55PNW7CsznFjpN8DuZ38Wjs+SPxFMmNDsItUNUiAvsM7DZS6bA4LmCcxoywyWMnLAPn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472338; c=relaxed/simple;
	bh=wxLwQcBxOGi+KEPgw1dhpPRqW2v9/uLDaH3R4WblSLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtoijKKdmHd0olnEMNUPJgY/oOOG4QeG1C5Lj28kturDGXG3gRvPL0DTdHPKDemGOryL109Y8F2W+2NrBrzE9sAyYwj60tAc/tADuwoiOo7xbkTFKkPjzYpfbbzwtoessOA2mIuRAOncL/4xVXdvVehj3FPP70h6BW+q/BE9Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGJApps5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B95C116B1;
	Mon,  8 Jul 2024 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720472337;
	bh=wxLwQcBxOGi+KEPgw1dhpPRqW2v9/uLDaH3R4WblSLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGJApps5trd66OaohZreX/5Q72O9xVhSrBP3D/llHKab0d0jzyTvOwfVOBgmWTUrG
	 EzUxMBiQMgKRtTMXnkRc1LpVmIKV9/NKB3JKtdDdrbySlGP0FHvvdCOtVpIPTtbKEc
	 vauHHakedM6G4xNtL09dLyUk95R1fE+qoWFrEI0wNn1LTBLtXE7al5uJTdpBRu7KUs
	 l7wMdE/0NNY/+Wdf950LrKbzpEHsJthAqBR+OE1wy1q3sKsv3ycFxZS3qOYpZfW7mk
	 ICazoCw0o3yJ2P3BipWUT2kmDthhj00jjpEgaqrq8Ie6Yps1p2dmcPhHDY8WnhvTYi
	 UOeSk5GfR0cwg==
Date: Mon, 8 Jul 2024 14:58:56 -0600
From: Rob Herring <robh@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, kernel@dh-electronics.com,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 RTL8211F LED support
Message-ID: <20240708205856.GA3874098-robh@kernel.org>
References: <20240705215207.256863-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705215207.256863-1-marex@denx.de>

On Fri, Jul 05, 2024 at 11:51:46PM +0200, Marek Vasut wrote:
> The RTL8211F PHY does support LED configuration, document support
> for LEDs in the binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  .../devicetree/bindings/net/realtek,rtl82xx.yaml   | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index 18ee72f5c74a8..28c048368073b 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -14,9 +14,6 @@ maintainers:
>  description:
>    Bindings for Realtek RTL82xx PHYs
>  
> -allOf:
> -  - $ref: ethernet-phy.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -54,6 +51,17 @@ properties:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ethernet-phy-id001c.c916
> +    then:
> +      properties:
> +        leds: true

This has no effect. 'leds' node is already allowed with the ref to 
ethernet-phy.yaml. I suppose you could negate the if and then, but I'm 
not really that worried if someone defines LEDs for a device with no 
LEDs. 

Rob

