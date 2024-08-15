Return-Path: <netdev+bounces-118901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2595373E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CCB1F22108
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18111B0123;
	Thu, 15 Aug 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmckYDFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6371AED38;
	Thu, 15 Aug 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735722; cv=none; b=POtA9ldKEamq6lLbW9pFw8klAnTeGdlnV8GZv9lGvVkyQcUtHI6ZaHzDT63ce8981LOTppXbC5RvVfTJi7tHytgGb3CpYro5tfp6yAs2Hw05RuIgvf1Gbr9UEwn0PGGQ99eM5PHJa2BsFsEvl8atpjPwX/y69dQj9RNSn6eLKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735722; c=relaxed/simple;
	bh=aU7GONG7+wdh9Cvq+jMv1PVglb/zFWUeoCL51NGnd9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLGVgu6mx3m40Gok1no32YyU18fA1Zd+Y384LqXTxnHpDjS+KAtC/ORawGt4vShbCH6chLoYeZPqU4bC/6Ti84qCwH66wyhGsrjWT5uFLjlTSvBr4oyF9hcTF5GzYdTJHMi9fCqKDmV4s3L3CTclD7saY5LQIVSK+vw7fTH+pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmckYDFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43D8C32786;
	Thu, 15 Aug 2024 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735722;
	bh=aU7GONG7+wdh9Cvq+jMv1PVglb/zFWUeoCL51NGnd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmckYDFbKyRbsHxnQj8xCA1kuO7Q4d0vNyo22LbnsGtLRjE1eMv/zsscUQyYUa/Xz
	 5+VcPgerJJM7ziE+az3MChN30JEzEBgOXdX9Z0gIhLNI1XjUMtexrkbVpGv797lyDA
	 LTUluYs/tZLTx0eq2IH4zIxebMtqJD2R6wuN6uQzyZwx55xqMG8nEwpAQoO76YAzaj
	 e4ZMC9uKcJygiiqXTkACsw54dribRz9NtPbQXdxSmmqnGbUfYO8J9eeN5/bj/sWV4U
	 bi8nDMpdjbdnw4rXfZhmXwq+vzGAfyJt5bfcbgmkmZvIqXrOcUj73D7nIlUC7Ad2KH
	 IMLuv6zJnBeKQ==
Date: Thu, 15 Aug 2024 09:28:41 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: net: mdio: change nodename match
 pattern
Message-ID: <20240815152841.GA1903517-robh@kernel.org>
References: <20240814170322.4023572-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814170322.4023572-1-Frank.Li@nxp.com>

On Wed, Aug 14, 2024 at 01:03:21PM -0400, Frank Li wrote:
> Change mdio.yaml nodename match pattern to
> 	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 
> Fix mdio.yaml wrong parser mdio controller's address instead phy's address
> when mdio-mux exist.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
>         mdio@20 {
> 		reg = <0x20>;
> 		       ^^^ This is mdio controller register
> 
> 		ethernet-phy@2 {
> 			reg = <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };
> 
> Only phy's address is limited to 31 because MDIO bus definition.
> 
> But CHECK_DTBS report below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> 
> The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
> mdio.yaml.
> 
> Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))$' to avoid wrong match
> mdio mux controller's node.
> 
> Also change node name mdio to mdio-0 in example of mdio-gpio.yaml to avoid
> warning.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - update mdio-gpio.yaml node name mdio to mdio-0 to fix dt_binding_check
> error foud by rob's bot.
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-gpio.example.dtb: mdio: $nodename:0: 'mdio' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 	from schema $id: http://devicetree.org/schemas/net/mdio-gpio.yaml#
> 
> Change from v1 to v2
> - use rob's suggest to fix node name pattern.
> ---
>  Documentation/devicetree/bindings/net/mdio-gpio.yaml | 2 +-
>  Documentation/devicetree/bindings/net/mdio.yaml      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mdio-gpio.yaml b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
> index eb4171a1940e4..3be4f94638e61 100644
> --- a/Documentation/devicetree/bindings/net/mdio-gpio.yaml
> +++ b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
> @@ -44,7 +44,7 @@ examples:
>          mdio-gpio0 = &mdio0;
>      };
>  
> -    mdio0: mdio {

Just 'mdio' should be accepted. There's a lot of those.

> +    mdio0: mdio-0 {
>        compatible = "virtual,mdio-gpio";
>        #address-cells = <1>;
>        #size-cells = <0>;
> diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
> index a266ade918ca7..2ed787e4fbbf2 100644
> --- a/Documentation/devicetree/bindings/net/mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> @@ -19,7 +19,7 @@ description:
>  
>  properties:
>    $nodename:
> -    pattern: "^mdio(@.*)?"
> +    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))$'

Needs a '?' on the end:

'^mdio(-(bus|external))?(@.+|-([0-9]+))?$'

>  
>    "#address-cells":
>      const: 1
> -- 
> 2.34.1
> 

