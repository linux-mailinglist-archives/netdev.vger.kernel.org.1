Return-Path: <netdev+bounces-29358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62663782DB0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DD91C208C7
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E28824;
	Mon, 21 Aug 2023 16:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB14A31
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C7DC433C8;
	Mon, 21 Aug 2023 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692633683;
	bh=aX4uOZqx4fuKGR4vLazYSCKmLEo9pLv6Ch7nrty5dEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYKpyWrsAwMxX28B1d1pdBPaZQ2kJZQGINDkwdh1aUmJj0Trs/jhyB6SlUfbeGwq6
	 X9Ivl9Pj+IC/EEMghk/YeV6VC7xygOyYqcEwkVSYXZLRbMm74ARf7SOYKeXuKavTlU
	 qI3JW9qOa3Vm3kecdy2KaIskEVhHGBi3uu+TUH5bkRXX3RdAHNysR4ZRhFvXhyTFOe
	 BC2LjPM4VspI3JCz9U4Ro8M7StLxXxEH6bIKLUV386YUQotI2x5/5ZG80pV8uYETOd
	 q0fZFSJXpJUcdfXkBCK2vX7SNrOdn/QewNx9spqsQ7xoeX2VlWndtpnnxmLJsOa/4e
	 TZ0s/b51DPXAw==
Received: (nullmailer pid 1743429 invoked by uid 1000);
	Mon, 21 Aug 2023 16:01:20 -0000
Date: Mon, 21 Aug 2023 11:01:20 -0500
From: Rob Herring <robh@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add iep property in ICSSG dt
 binding
Message-ID: <20230821160120.GA1734560-robh@kernel.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110048.2611456-3-danishanwar@ti.com>

On Mon, Aug 07, 2023 at 04:30:45PM +0530, MD Danish Anwar wrote:
> Add iep node in ICSSG driver dt binding document.

Why?

Bindings are for h/w, not drivers. You are adding a property, not a 
node. Would be nice to know what 'iep' is without having to look at the 
diff (e.g. when running 'git log').

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 8ec30b3eb760..36870238f92f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -52,6 +52,12 @@ properties:
>      description:
>        phandle to MII_RT module's syscon regmap
>  
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

phandle-array really means matrix, so you need to fully describe the 
items constraints.

> +    maxItems: 2

2 phandles or 1 phandle and 1 arg? Looks like the former from the 
example, so:

maxItems: 2
items:
  maxItems: 1

> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
> +
>    interrupts:
>      maxItems: 2
>      description:
> @@ -155,6 +161,7 @@ examples:
>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>                      "rx0", "rx1";
>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>          interrupt-parent = <&icssg2_intc>;
>          interrupts = <24 0 2>, <25 1 3>;
>          interrupt-names = "tx_ts0", "tx_ts1";
> -- 
> 2.34.1
> 

