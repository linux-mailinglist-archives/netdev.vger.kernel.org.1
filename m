Return-Path: <netdev+bounces-235352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2CC2EFD1
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0570818980A6
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4D24469E;
	Tue,  4 Nov 2025 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wzkJVWFw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249C24466B;
	Tue,  4 Nov 2025 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223962; cv=none; b=Ho1W7D/oZONUKa8I1BQlLrblSK8fx6DTjU3J7DIHsfG+unPMfxyzJv6K4Gsc2/fPlhlp1fhK8szPfImzOZy/uOOOSwHzNqQWmoD3EwUW09F4z1BGrrsLs8JMn/55bdnRcaG3OrBWqBwV8IgOHoE5uC0+R+Vn2PIyeCff2z2Blfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223962; c=relaxed/simple;
	bh=Ssge7uihD80WDLx+qQHZ2sams1eS72XGBuVXonViGUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osabqDeZOksv+GfIpk/aeKZg/YHISL5CIqt0WQGhGNL15SP/cvJUE/tduY4r6NmT3oczvNUSniifLTIDOQoo/GgL4Y4bEKgPdzx0i08OFsYsmQmZcWZ9B6njSTuZ6i/ZrpBCak2VERvG8iwqJstdyAByhD3NLhk9BG8XZ6zDRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wzkJVWFw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8gU4iu/jxMJVno8QaMCLdahHidjmz5hXR/hIiNJxZ5Q=; b=wzkJVWFwzWwRQDtieVeeWxvCTY
	N+AVdOv9y4J3HJ14l+7IfSo/8GyV3CWeLDyPv/tzevlhm4ggiJ7lt7q8cYRnsp67nL4cgromDXfZC
	0yE0P+zw8htEIQ4gZxOGG/tsE+54jXt0uNMLWeHNXowHaz9BfZhRgB8mk/hi39eZT8zA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG6we-00Cqbf-KO; Tue, 04 Nov 2025 03:38:52 +0100
Date: Tue, 4 Nov 2025 03:38:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <2424e7e9-8eef-43f4-88aa-054413ca63fe@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:16PM +0800, Jacky Chou wrote:
> Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
>   with 45ps step.
> - For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
>   with 250ps step.
> - Both require the "scu" property.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..de646e7e3bca 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -19,6 +19,12 @@ properties:
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac
>            - const: faraday,ftgmac100
> +      - items:
> +          - enum:
> +              - aspeed,ast2600-mac01
> +              - aspeed,ast2600-mac23
> +          - const: aspeed,ast2600-mac
> +          - const: faraday,ftgmac100
>  
>    reg:
>      maxItems: 1
> @@ -69,6 +75,12 @@ properties:
>    mdio:
>      $ref: /schemas/net/mdio.yaml#
>  
> +  scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
> +      This reference is used by the MAC controller to configure the RGMII delays.
> +
>  required:
>    - compatible
>    - reg
> @@ -88,6 +100,44 @@ allOf:
>      else:
>        properties:
>          resets: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac01
> +    then:
> +      properties:
> +        rx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 1395
> +          multipleOf: 45

I would add a default: 0

> +        tx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 1395
> +          multipleOf: 45

and also here.

> +      required:
> +        - scu
> +        - rx-internal-delay-ps
> +        - tx-internal-delay-ps

and then these are not required, but optional.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac23
> +    then:
> +      properties:
> +        rx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 7750
> +          multipleOf: 250
> +        tx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 7750
> +          multipleOf: 250
> +      required:
> +        - scu
> +        - rx-internal-delay-ps
> +        - tx-internal-delay-ps

Same again here.

	Andrew

