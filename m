Return-Path: <netdev+bounces-32869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A86179AA4E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B11C209FF
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFDC1171A;
	Mon, 11 Sep 2023 16:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8F33EE
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753EC433C8;
	Mon, 11 Sep 2023 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694450791;
	bh=bXMZzVKRSbTQ/tVE5TIgh9LKsYdFg9X0N5cunHPB9j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrqRAapx6rfpDgr5AfSPR8MVEVwBkQnvoEqOhbj/VqqcDUUHpXzpCz59YYlSENlkg
	 iKlMdjuQ6siqk7FSEfPNa4BF3WsSjYi7qAfv4ADi5fOlSHNvm9QQQHmFLQwHGcS5UJ
	 qV0xoww4MfjFOp1xTtat3YZ9FsEJG5s+qu7gUbqGYhQGNvE2ZUxFVswowCpZB+/XJZ
	 J3rG73eCRzjZ/ZH4ULRiTkPPGpy2seiTnLAQjUC1VS6yE3S47F5O81nkjIZiDr/icy
	 1iZh+v1Kk9bZYbHlzKr05hmnughsJ7XcwcwrSBf8pjrWvRyqEM7qrAeZnRhDGRISmR
	 +6G53cx1f4Dxw==
Received: (nullmailer pid 1357324 invoked by uid 1000);
	Mon, 11 Sep 2023 16:46:28 -0000
Date: Mon, 11 Sep 2023 11:46:28 -0500
From: Rob Herring <robh@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Vignesh Raghavendra <vigneshr@ti.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <20230911164628.GA1295856-robh@kernel.org>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911060200.2164771-2-danishanwar@ti.com>

On Mon, Sep 11, 2023 at 11:31:59AM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation at
> that port.
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 311c570165f9..bba17d4d5874 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -106,6 +106,13 @@ properties:
>                phandle to system controller node and register offset
>                to ICSSG control register for RGMII transmit delay
>  
> +          ti,half-duplex-capable:
> +            type: boolean
> +            description:
> +              Enable half duplex operation on ICSSG MII port. This requires

Still have capable vs. enable confusion. Please reword the description.

> +              PHY output pin (COL) to be routed to ICSSG GPIO pin
> +              (PRGx_PRU0/1_GPIO10) as input.
> +
>          required:
>            - reg
>      anyOf:
> -- 
> 2.34.1
> 

