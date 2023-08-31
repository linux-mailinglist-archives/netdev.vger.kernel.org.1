Return-Path: <netdev+bounces-31633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E32D78F25B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D3F1C20B1D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BE19893;
	Thu, 31 Aug 2023 18:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344068F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 18:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF99C433C8;
	Thu, 31 Aug 2023 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693505798;
	bh=XeZVeiYpBVcPEbHL4neQaU/M5IGVLY/U/Mj6DQ6GalA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqnDV9Oczcpv+5UwkALr3OsvzNOZZJhiZzRapdSmN3ePWjI0ztjUyQ42UFFLib/UI
	 mnpfFfAVYbqLCExTU39BH0HKS4ALEnhyq5tGWxqQxAmFLZtA3vzoVti6K1QqwyYB//
	 Pwv2zsXslmdJX6pHVfqoHYfF5hsBoDvReiJQyfn0IdGFWBB3HOnIAxIPP2JBghJF/O
	 x1dKf/cX/wjJBiHcv+4oBfmmvWENJt4n/0fhQbS3tWCYvrelh8BhvvEEs30hNM7lCh
	 janYTlSKR3mvk32K+yv0d2eUVYpi2khOzMYNat+rUkg4ayABGmCQAgnjRrj+djCFMv
	 mtTYeyjqjDIDA==
Received: (nullmailer pid 2536101 invoked by uid 1000);
	Thu, 31 Aug 2023 18:16:36 -0000
Date: Thu, 31 Aug 2023 13:16:36 -0500
From: Rob Herring <robh@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <20230831181636.GA2484338-robh@kernel.org>
References: <20230830113134.1226970-1-danishanwar@ti.com>
 <20230830113134.1226970-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830113134.1226970-2-danishanwar@ti.com>

On Wed, Aug 30, 2023 at 05:01:33PM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation at
> that port.

I take it the GPIO here is not visble to the OS and that's why it's not 
described in DT?
 
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 13371159515a..59da9aeaee7e 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -107,6 +107,13 @@ properties:
>                phandle to system controller node and register offset
>                to ICSSG control register for RGMII transmit delay
>  
> +          ti,half-duplex-capable:

capable or...

> +            type: boolean
> +            description:
> +              Enable half duplex operation on ICSSG MII port. This requires

enable the mode?

Maybe too late if it's already been assumed not supported, but shouldn't 
supporting half duplex be the default? I guess half duplex isn't too 
common any more.

Rob

