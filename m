Return-Path: <netdev+bounces-112496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553F939864
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 04:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769091C21A05
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4713957B;
	Tue, 23 Jul 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gul9Ojrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2D134B6;
	Tue, 23 Jul 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702832; cv=none; b=MnfPp84rFdhPA+3ZYhb14ic5japMVtsZ9HpYMTZRQYHpDoVDzlMH+TEw/oifnNpxB0Y0ggec8JfYhHcM5WPoAQZuxV0TIT2h/JcuhqNlYuR1feKfAnfV5kMqYUd+DOzQMm9IhoNQLZbcM/IbUf/wVw6UTAi2azYQO59FKxLdQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702832; c=relaxed/simple;
	bh=MIMdnCy6yX2zuqekb7fQ2vPvHaFmS2xIlkV3aYtyUxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENvJXRY4ke0MFjO3ra4SIBNle+XpeJ4A4CGuaHZVn901rBx2X+aEJCbl6BxYC0/WexH2mh2eb/cMzsyOToh1o1k0I3OathzTiV8F2q+WHHOK8gTXJ2Lato9HLhPgn/rnyUzDAuQDy4voJ694plaFjPGtd7Ew0MplBgO11bgheD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gul9Ojrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BED7C116B1;
	Tue, 23 Jul 2024 02:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702831;
	bh=MIMdnCy6yX2zuqekb7fQ2vPvHaFmS2xIlkV3aYtyUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gul9OjrfrwQ13kkaqlqmBcpBWDbMPqd/2kwyWpHO+SMKNmluV+2dVmTJCn55kGNrB
	 ZJf4RdEJ+pqv4uFOwCDQShSjDijcMzW6fl813d9yAsEZu8Gw7B+JOIIChzBSLg5drI
	 OZfgNk1cTdeeD6LVQCwe/1BRU4xZu4F9kwi0HPFH+aql1QoymqoS0wNf4zhFYeeDG3
	 qJlsbFr7GmqfNKrZMKt+TTx2+UF7NztmWMge9Z6tfguC+wn7g/yx6Z8m0DK/g9xNSJ
	 1xoQxb29nthrjivBkA8y88tSLjI35jRwfZ3y/0uKDmurChOgil+Qs/A1pZ9yXLEaO1
	 ZM43Pai4WxKOQ==
Date: Mon, 22 Jul 2024 20:47:08 -0600
From: Rob Herring <robh@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: dsa: vsc73xx: add
 {rx,tx}-internal-delay-ps
Message-ID: <20240723024708.GA192141-robh@kernel.org>
References: <20240717212732.1775267-1-paweldembicki@gmail.com>
 <20240717212732.1775267-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717212732.1775267-2-paweldembicki@gmail.com>

On Wed, Jul 17, 2024 at 11:27:33PM +0200, Pawel Dembicki wrote:
> Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
> in the CPU port. Additionally, valid values for VSC73XX were defined,
> and a common definition for the RX and TX valid range was created.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ---
> v2:
>   - added info about default value when the rx/tx delay property
>     is missing
> ---
>  .../bindings/net/dsa/vitesse,vsc73xx.yaml     | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
> index b99d7a694b70..7022a6afde5c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
> @@ -52,6 +52,25 @@ properties:
>  allOf:
>    - $ref: dsa.yaml#/$defs/ethernet-ports
>  
> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@6$":
> +        allOf:
> +          - if:
> +              properties:
> +                phy-mode:
> +                  contains:
> +                    enum:
> +                      - rgmii
> +            then:
> +              properties:
> +                rx-internal-delay-ps:
> +                  $ref: "#/$defs/internal-delay-ps"
> +                tx-internal-delay-ps:
> +                  $ref: "#/$defs/internal-delay-ps"
> +
>  # This checks if reg is a chipselect so the device is on an SPI
>  # bus, the if-clause will fail if reg is a tuple such as for a
>  # platform device.
> @@ -67,6 +86,16 @@ required:
>    - compatible
>    - reg
>  
> +$defs:
> +  internal-delay-ps:
> +    description:
> +      Disable tunable delay lines using 0 ps, or enable them and select
> +      the phase between 1400 ps and 2000 ps in increments of 300 ps.
> +      When the property is missing, the delay value is set to 2000 ps
> +      by default.

       default: 2000

Not freeform text.

> +    enum:
> +      [0, 1400, 1700, 2000]
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -108,6 +137,8 @@ examples:
>              reg = <6>;
>              ethernet = <&gmac1>;
>              phy-mode = "rgmii";
> +            rx-internal-delay-ps = <0>;
> +            tx-internal-delay-ps = <0>;
>              fixed-link {
>                speed = <1000>;
>                full-duplex;
> @@ -150,6 +181,8 @@ examples:
>            ethernet-port@6 {
>              reg = <6>;
>              ethernet = <&enet0>;
> +            rx-internal-delay-ps = <0>;
> +            tx-internal-delay-ps = <0>;
>              phy-mode = "rgmii";
>              fixed-link {
>                speed = <1000>;
> -- 
> 2.34.1
> 

