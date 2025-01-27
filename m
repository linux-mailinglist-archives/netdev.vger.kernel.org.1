Return-Path: <netdev+bounces-161177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A221FA1DC6E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39F77A05C3
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752AF18F2EF;
	Mon, 27 Jan 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfiWs/Cr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5A18A924;
	Mon, 27 Jan 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004856; cv=none; b=k/HU3j/XKsTwPLE9y7TOzta29zLEGNyfWefTYT3cNxwCRZfX02h2w5bHWZeys7s4djDpV7AMlBF+htjzSU48BXWhDU2gLadwtUt9IauCRporG8ZmUdm1IcFYZ84+mZoXINZvWS2fizCpo/3HZH4t2b0PSYVOnKwnUX158lHqDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004856; c=relaxed/simple;
	bh=nOgE1Xm78sYrNXodpnGbC8FTPluHnfJLmlj0zh7LwTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i91TdpAqtBlHF9BGldHLODdbKw+ZwxkNTXJRyhSE/p/rlGk3xYHho0YkFP6wYYs5uhI2jOQ4pzkkg2/X149hpGe7Fn/wjl7um89BsMBAveI/3s6dB0W7DyjdZZq5KsOL3yHiQBRiV5s3+N6oC0aOBBU+18UR0g18gHEKbM+H7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfiWs/Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9162FC4CED2;
	Mon, 27 Jan 2025 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738004855;
	bh=nOgE1Xm78sYrNXodpnGbC8FTPluHnfJLmlj0zh7LwTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfiWs/CrIrIPUXoBn9u859lQhtBX3yvkqmHKjO8DqTUw2A6DT8EKBjR9sMR5sF1KX
	 mW1MfJ24szzFYquhahIAE3Ay+4oCDnKw4Y8F8W5dclgq7/JGONRhTxTDcGYl29OEyk
	 IJrolWWpz1n3/7idwKXg51IwpjiYKLGJn0Iw3n2H2LQaUi02vpaeCdsQ7bA+IKKEB7
	 g9FQntEBAhwfeHo8AhT+6eafPqQ1nPqzqYjUPyrEmmFLDzYwVgA/3cX6Q7ReVlh2tu
	 o90wgm5w3JDYpj52WASkq1T11KU3UTBReF+12Z/P7qhHYJPrUDFEX1vtv668TD3kfK
	 iTz0dWpyVDN+g==
Date: Mon, 27 Jan 2025 13:07:34 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 6/6] dt-bindings: net: Introduce the
 phy-port description
Message-ID: <20250127190734.GA635780-robh@kernel.org>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
 <20250122174252.82730-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122174252.82730-7-maxime.chevallier@bootlin.com>

On Wed, Jan 22, 2025 at 06:42:51PM +0100, Maxime Chevallier wrote:
> The ability to describe the physical ports of Ethernet devices is useful
> to describe multi-port devices, as well as to remove any ambiguity with
> regard to the nature of the port.
> 
> Moreover, describing ports allows for a better description of features
> that are tied to connectors, such as PoE through the PSE-PD devices.

Seems like we need a connector binding like we've ended up needing in 
other cases.

> 
> Introduce a binding to allow describing the ports, for now with 2
> attributes :
> 
>  - The number of lanes, which is a quite generic property that allows
>    differentating between multiple similar technologies such as BaseT1
>    and "regular" BaseT (which usually means BaseT4).
> 
>  - The media that can be used on that port, such as BaseT for Twisted
>    Copper, BaseC for coax copper, BaseS/L for Fiber, BaseK for backplane
>    ethernet, etc. This allows defining the nature of the port, and
>    therefore avoids the need for vendor-specific properties such as
>    "micrel,fiber-mode" or "ti,fiber-mode".
> 
> The port description lives in its own file, as it is intended in the
> future to allow describing the ports for phy-less devices.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> RFC V2: New patch
> 
>  .../devicetree/bindings/net/ethernet-phy.yaml | 18 +++++++
>  .../bindings/net/ethernet-port.yaml           | 47 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ethernet-port.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2c71454ae8e3..950fdacfd27d 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -261,6 +261,17 @@ properties:
>  
>      additionalProperties: false
>  
> +  mdi:
> +    type: object
> +
> +    patternProperties:
> +      '^port-[a-f0-9]+$':

'port' is already a node name for graphs. It's also the deprecated name 
for 'ethernet-port' in the switch/DSA bindings.

> +        $ref: /schemas/net/ethernet-port.yaml#

A confusing name considering we already have 'ethernet-port'.

Rob

