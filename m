Return-Path: <netdev+bounces-151054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5219EC963
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CB9285CDD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0ED1C1F22;
	Wed, 11 Dec 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7X6lHEO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B3236FB6;
	Wed, 11 Dec 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910224; cv=none; b=KMTLZZ8RS6MLz1kogXCaomzLYx5js7zwG4y9B2j3U2SmTXJcVieMLpnpfZbOgV7xpyHpRgIb75PaTUQVwhLLXm13YQI49j7p19d7BGwQ/PHAigxvEzeHVxV4pLomXWS7JEpmGT3WdA7dmfIeupdIE2jJDxQwJ+XUPpZG6baG9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910224; c=relaxed/simple;
	bh=tjOJhShJ66gPvdzusOXZm8nsP45GFF+Q7mTgg0svbak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIK1925PMIatI66bEY7kHVN9NzHcIB37AGDEubkdT+VZoysCHPWtvbLrIfIZ26i13bysYxW5iTSsWcxsaFztSzVEUWS9l8ilrhx4jJCBHM7szGwyCbd0dJEFhW+KsdU71wqMx1w7aTe03T2M7eor+zZCZdOoM/V9Vb2cyjpoF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7X6lHEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915C7C4CED2;
	Wed, 11 Dec 2024 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733910224;
	bh=tjOJhShJ66gPvdzusOXZm8nsP45GFF+Q7mTgg0svbak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7X6lHEODmO/+HZAoQtCyAxhDgtNeqTn7aVWcCO42WLt6djAqz+m0CduwfC923irq
	 7abPownTqOz4DwomBvxUclphJr4TKJzqv0d1U7GZZ9FWv/YLmK7wN+Cld4v6Rxyllu
	 xnZxACkvIu5qip1AOLVCLKPDc9pdeOSJqKZPPQyShJ5+A45c7jUfqfWkwew2MfKcCJ
	 TVkm+qFQ54CSsbAC7Q+1aMzyMCV03H1gZd2qiENDko9bOXW0fg5Bc7XcLVs5t7HnwY
	 j9SPDHUvNMM91Rkxoc609AAJuDv+csAe/3IGJ32IP9ZHo7oUXQ0rZNQrswzBrrhYno
	 WZv8ftKoBu0yg==
Date: Wed, 11 Dec 2024 10:43:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dp83822: Add support
 for GPIO2 clock output
Message-ID: <hayqmsohcpdg43yh5obmkbxpw3stckxpmm3myhqfsf62jdpquh@ndwfhr3gqm3b>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
 <20241211-dp83822-gpio2-clk-out-v2-1-614a54f6acab@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-dp83822-gpio2-clk-out-v2-1-614a54f6acab@liebherr.com>

On Wed, Dec 11, 2024 at 09:04:39AM +0100, Dimitri Fedrau wrote:
> The GPIO2 pin on the DP83822 can be configured as clock output. Add
> binding to support this feature.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/net/ti,dp83822.yaml         |  7 +++++++
>  include/dt-bindings/net/ti-dp83822.h                | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> index 784866ea392b2083e93d8dc9aaea93b70dc80934..4a4dc794f21162c6a61c3daeeffa08e666034679 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -96,6 +96,13 @@ properties:
>        - master
>        - slave
>  
> +  ti,gpio2-clk-out:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +       DP83822 PHY only.
> +       Muxing option for GPIO2 pin. See dt-bindings/net/ti-dp83822.h for
> +       applicable values. When omitted, the PHY's default will be left as is.

1. Missing constraints, this looks like enum.
2. Missing explanation of values.
3. This should be most likely a string.
4. Extend your example with this. 

> +
>  required:
>    - reg
>  
> diff --git a/include/dt-bindings/net/ti-dp83822.h b/include/dt-bindings/net/ti-dp83822.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..d569c90618b7bcae9ffe44eb041f7dae2e74e5d1
> --- /dev/null
> +++ b/include/dt-bindings/net/ti-dp83822.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Device Tree constants for the Texas Instruments DP83822 PHY
> + *
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
> + * Author: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> + */
> +
> +#ifndef _DT_BINDINGS_TI_DP83822_H
> +#define _DT_BINDINGS_TI_DP83822_H
> +
> +/* IO_MUX_GPIO_CTRL - Clock source selection */
> +#define DP83822_CLK_SRC_MAC_IF			0x0
> +#define DP83822_CLK_SRC_XI			0x1
> +#define DP83822_CLK_SRC_INT_REF			0x2
> +#define DP83822_CLK_SRC_RMII_MASTER_MODE_REF	0x4
> +#define DP83822_CLK_SRC_FREE_RUNNING		0x6
> +#define DP83822_CLK_SRC_RECOVERED		0x7

These are not really bindings but some register values. Hex numbers
indicate that. Don't store register values as bindings, because this
is neither necessary nor helping.

Best regards,
Krzysztof


