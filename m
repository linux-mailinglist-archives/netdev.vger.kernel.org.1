Return-Path: <netdev+bounces-149304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18F9E5135
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D382883C1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41A1D5144;
	Thu,  5 Dec 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfDFSIX1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB91D0DEC;
	Thu,  5 Dec 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390623; cv=none; b=C5tjg6ULfjJ9OxwHKgM+BRaxvQjbMUMpusOE1Udjua7UdflJzhP46KwpNGjMZBG3KBO8gmoXPTT04ylP3LCpcpsjQm0TiF3ei0foO7yN8aymy5U98P3BF5vBQ8U2jbCqqyTXUDL6lxVk6D8kfJnv7M8hPTW+ynlfduSjdN3LiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390623; c=relaxed/simple;
	bh=1v+FSRruErk4XRJW66g3EC+VfUxZxTPUrNCqkYSZJJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/OyTf806QK9j2gmAQ0iqwWqfYmVsmHr0d6C3KKJ67JA3AVM8EYCyWXG4+LgRqDzwYIrsIuV3YMHrbtxOLm9+wFAZhBKIyQna4egSagikafE+l1cfG1IX1QzhrMpR75jo4SlGIyGDoNkNIf2NbxxMTrdN3bQC7ccCb1Utm1Ecl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfDFSIX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5BC4CED1;
	Thu,  5 Dec 2024 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390623;
	bh=1v+FSRruErk4XRJW66g3EC+VfUxZxTPUrNCqkYSZJJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfDFSIX1oIHVqeM5yTg+AZwLeHHxW/jlPQKW2U6nhRuHJX40dlMX+VunZg3nxhGp8
	 VDFAS+N12D3ZAodM6b6s+Kvpzopxk4lPQxvP16+xoQwhdFGIQDgL4wxSeOExKWQsgs
	 wi4j0iniwaaQt74xJhtg3WEeEZ2lac2bJrxGoZM0EsVMBsVEOxMMkuyYBrj8e3P/1a
	 K1AYXVvI6m4Aj6vxg+AEEZLmonLR2NwKQARnh+BBv9PJjp7HZnludAX4lMi58Ed3fj
	 74vvhfcHIL9E1qSgMkB07Vv4y8sGzR0dARmvVw9uwkgxaaNkTeCKY70IzrqTAqbqDc
	 OjE/Aps+JuW1A==
Date: Thu, 5 Dec 2024 10:23:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Message-ID: <e6hwuf5mtr5vwm7d2jn4raewinkwpswyceimahur3xnpi2zyqs@t4cqgdqilerq>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205072048.1397570-2-jacky_chou@aspeedtech.com>

On Thu, Dec 05, 2024 at 03:20:42PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support and resets property for AST2700 in
> yaml.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>


Your changelog in cover letter does not mention received ack. When did
it happen?

> ---
>  .../bindings/net/faraday,ftgmac100.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 9bcbacb6640d..3bba8eee83d6 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -21,6 +21,7 @@ properties:
>                - aspeed,ast2400-mac
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>            - const: faraday,ftgmac100
>  
>    reg:
> @@ -33,7 +34,7 @@ properties:
>      minItems: 1
>      items:
>        - description: MAC IP clock
> -      - description: RMII RCLK gate for AST2500/2600
> +      - description: RMII RCLK gate for AST2500/2600/2700
>  
>    clock-names:
>      minItems: 1
> @@ -73,6 +74,20 @@ required:
>  
>  unevaluatedProperties: false
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: aspeed,ast2700-mac

1. That's a signigicant change. *Drop ack.*

2. Test your bindings.
3. Put if: block under allOf: and move entire allOf just above your
unevaluatedProperties... if this stays.
4. But you cannot define properties in if:then. They must be defined in
top level. You can disallow them for variants in if:then: with :false"

Even exmaple schema has exactly this case:
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212

Best regards,
Krzysztof


