Return-Path: <netdev+bounces-125153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39496C176
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A1C288528
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F61DCB00;
	Wed,  4 Sep 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slYBU2hT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B71DC1AA;
	Wed,  4 Sep 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461841; cv=none; b=V7WCFOOnDHRcYWiaWQ/W4/mtE0GRrVADU+3XsFz8H2cs5B8LhgbymODW5UgLVNMJPwpQ4tgCI8Pd4L14M0eSe5oJOPTGBO/C9e4SzEh6pQiUtfJl52IoZB2SGKQKok/cIvbZbWuz9QjqDk18uRyANeWrOZo9izH1PfsUCXOqBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461841; c=relaxed/simple;
	bh=TAz7vuE1pT0x1essE0kvodzC3Y7fNz6Qr5sydvrjB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxMcw3X9jxlDDNYTROpaSYotC0TNsaJ2u//k7zmTmJkFObMzd9vRJ+6c0hdSWr/KGUdBlItvgG0rdJND8oNreUk8rWxFDG8vuEGUS3eJUoUt4jjzRSPWpnK3eVpIxPENIXRYRkVQMDs3OD4Mc4kQfH/7gN06IfHYl82NSekqncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slYBU2hT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E0C4CEC2;
	Wed,  4 Sep 2024 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461841;
	bh=TAz7vuE1pT0x1essE0kvodzC3Y7fNz6Qr5sydvrjB1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slYBU2hTNBNhpCwj0R5h5E77GQxvONIOzrNx2Ub/f5/XGZYVtOGCWUnp0P3Izl9Tl
	 Is1zq2HIDY0ABfQZwzfbypqHhdFBiHkmhkQzTxpwy8cOtPz9M2Cu96DNiS7KTYNlDu
	 lmXBAo3aNblYqJG00zl6O1HptKd6VVr9tCNONf+iXGU85XyrAxXdIhJPeIlFolbI40
	 hcrOeqgAp6s471Cb6mi41e8cYKGCeyxSwM3T5Jh332u7hphrBVnl6x5fBov1zHx4gF
	 IpBFbfpa8Uf67cCuwQZ4+bXr1/VhBpMhzADIu6J5334X0vj3C4fPfq31z+4hhx3N6d
	 d22NQNXTG++Mg==
Date: Wed, 4 Sep 2024 09:57:20 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Message-ID: <20240904145720.GA2552590-robh@kernel.org>
References: <20240902063352.400251-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902063352.400251-1-wei.fang@nxp.com>

On Mon, Sep 02, 2024 at 02:33:52PM +0800, Wei Fang wrote:
> As Rob pointed in another mail thread [1], the binding of tja11xx PHY
> is completely broken, the schema cannot catch the error in the DTS. A
> compatiable string must be needed if we want to add a custom propety.
> So extract known PHY IDs from the tja11xx PHY drivers and convert them
> into supported compatible string list to fix the broken binding issue.
> 
> [1]: https://lore.kernel.org/netdev/31058f49-bac5-49a9-a422-c43b121bf049@kernel.org/T/
> 
> Fixes: 52b2fe4535ad ("dt-bindings: net: tja11xx: add nxp,refclk_in property")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml  | 50 +++++++++++++------
>  1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> index 85bfa45f5122..c2a1835863e1 100644
> --- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> @@ -14,8 +14,41 @@ maintainers:
>  description:
>    Bindings for NXP TJA11xx automotive PHYs
>  
> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id0180.dc40
> +      - ethernet-phy-id0180.dd00
> +      - ethernet-phy-id0180.dc80
> +      - ethernet-phy-id001b.b010
> +      - ethernet-phy-id001b.b031
> +
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ethernet-phy-id0180.dc40
> +              - ethernet-phy-id0180.dd00
> +    then:
> +      properties:
> +        nxp,rmii-refclk-in:
> +          type: boolean
> +          description: |
> +            The REF_CLK is provided for both transmitted and received data
> +            in RMII mode. This clock signal is provided by the PHY and is
> +            typically derived from an external 25MHz crystal. Alternatively,
> +            a 50MHz clock signal generated by an external oscillator can be
> +            connected to pin REF_CLK. A third option is to connect a 25MHz
> +            clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
> +            as input or output according to the actual circuit connection.
> +            If present, indicates that the REF_CLK will be configured as
> +            interface reference clock input when RMII mode enabled.
> +            If not present, the REF_CLK will be configured as interface
> +            reference clock output when RMII mode enabled.
> +            Only supported on TJA1100 and TJA1101.
>  
>  patternProperties:
>    "^ethernet-phy@[0-9a-f]+$":
> @@ -32,22 +65,6 @@ patternProperties:
>          description:
>            The ID number for the child PHY. Should be +1 of parent PHY.
>  
> -      nxp,rmii-refclk-in:
> -        type: boolean
> -        description: |
> -          The REF_CLK is provided for both transmitted and received data
> -          in RMII mode. This clock signal is provided by the PHY and is
> -          typically derived from an external 25MHz crystal. Alternatively,
> -          a 50MHz clock signal generated by an external oscillator can be
> -          connected to pin REF_CLK. A third option is to connect a 25MHz
> -          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
> -          as input or output according to the actual circuit connection.
> -          If present, indicates that the REF_CLK will be configured as
> -          interface reference clock input when RMII mode enabled.
> -          If not present, the REF_CLK will be configured as interface
> -          reference clock output when RMII mode enabled.
> -          Only supported on TJA1100 and TJA1101.
> -
>      required:
>        - reg
>  
> @@ -60,6 +77,7 @@ examples:
>          #size-cells = <0>;
>  
>          tja1101_phy0: ethernet-phy@4 {
> +            compatible = "ethernet-phy-id0180.dc40";
>              reg = <0x4>;
>              nxp,rmii-refclk-in;

Are child phy devices optional? Either way, would be good to show a 
child device. IOW, make examples as complete as possible showing 
optional properties/nodes.

Rob

