Return-Path: <netdev+bounces-155145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C35A013BE
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 10:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B763A3FAC
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444014D6F6;
	Sat,  4 Jan 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxAbPgf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417E1494A6;
	Sat,  4 Jan 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735983894; cv=none; b=YMUMYlf8k/rcFOnZm7JLGZdO0hrf2GW3OzepXf3WJsDrIleobOSEpKvYmDO6IbPEC8GmBdBm/KjnXgIde+7UtgBzralXm7ouUMX4mJ+3FtAvNIauvSXXhfEQbnmLpJuulJDH4wGCXNr5cAuc3G2y3dqz2mj3SeBWBV0sT3vfL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735983894; c=relaxed/simple;
	bh=1/121DkU8bgMdVN5mOj89KarZwidjAxnOAB1PDIASDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH0AY7kkvkkb4vOfwBC7WBMJ1NExkGWYhv+AHfk2jYXiPcP1u5iW/EDdpsjbOP7OdlZRXAZ+8dBrbmvhrqu5uT2xqWQ+P66ei6D2qlUGyVW8K2qeXLGM6ajVSbPlI9GgQ/VQVYa0C0BIFHmpFSw0Fubz0TqWPLFZD+lbMi9KV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxAbPgf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A39C4CED1;
	Sat,  4 Jan 2025 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735983892;
	bh=1/121DkU8bgMdVN5mOj89KarZwidjAxnOAB1PDIASDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxAbPgf+iA+lR/K1eEXuOEbfgNTyJ723nPwWt8d5PQwjQKagqE4OsGgRUeCTVunn6
	 ntQM+AypVPth/9LZhh32Dxm7+PQ4BPM34NOk+evbKS4r5MOot/yCNUZzykp3mFWE35
	 pBW8Jua9YZOzYsuioNcR/aUYuDw5xK2zWwtmgLN86i5N1Bdb7/M4WZWm7LlpBaXeMg
	 nFWuvA8bjiHiMD41Vo+t9oAP8OvUjI1BoXp96LRjRTe727IwitzSd64Z3xmAJYpFQ4
	 2YM5LrEvfGN7FM7FeWn1cOiFpyQ5Uel4ikq5DG6Xc4bESlLDPEWiITpmijBPyLD0kE
	 2exwABHfa233Q==
Date: Sat, 4 Jan 2025 10:44:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	Kyle Swenson <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>, 
	kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 27/27] dt-bindings: net: pse-pd: ti,tps23881:
 Add interrupt description
Message-ID: <uv2grnchczucf4vxxzaprfkc6ap56z6uqzaew3qtjqpvmtaqbb@kuv62yntqyfr>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-27-dc91a3c0c187@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-feature_poe_port_prio-v4-27-dc91a3c0c187@bootlin.com>

On Fri, Jan 03, 2025 at 10:13:16PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add an interrupt property to the device tree bindings for the TI TPS23881
> PSE controller. The interrupt is primarily used to detect classification
> and disconnection events, which are essential for managing the PSE
> controller in compliance with the PoE standard.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v3:
> - New patch
> ---
>  Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> index d08abcb01211..19d25ded4e58 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> @@ -20,6 +20,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    maxItems: 1
> +
>    '#pse-cells':
>      const: 1
>  
> @@ -62,6 +65,7 @@ unevaluatedProperties: false
>  required:
>    - compatible
>    - reg
> +  - interrupts

Why? That's an ABI change. Commit msg mentions something like "essential
for standard" so are you saying nothing here was working according to
standard before?

>  
>  examples:
>    - |
> @@ -72,6 +76,8 @@ examples:
>        ethernet-pse@20 {
>          compatible = "ti,tps23881";
>          reg = <0x20>;
> +        interrupts = <8 0>;

This looks like standard flag, so use standard define and then note that
NONE is usually not a correct interrupt type.

Best regards,
Krzysztof


