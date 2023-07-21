Return-Path: <netdev+bounces-19862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00F75C9D9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6B71C216E0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177471ED20;
	Fri, 21 Jul 2023 14:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C21E535
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97CDC433CB;
	Fri, 21 Jul 2023 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689949476;
	bh=f5CmuKxpJu9jR+oixBzVmJVKyjN2Z5YWoED2/Oqe//8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGgQ/hDou9SKGtlP/OvopQ6cIKkLxeRwlf02RcsRiUj6Hx7Hpm/YVg9dyxwGboy9X
	 01nmDjExuidnMQQlZ41rLyyK4dSrbo4RQ/GJQYzKqK36AIewcUCkzct5UtgC87U3RK
	 CTD5tseiGBR6IoyoOn0WMc1Bqj+pawVctnpJp3ui0HzwkIJdib2mydJYbhOf3rrYS3
	 /zhwvXN1LssqjfFrqXKseCy3MmbFHU4/djIn9sjdI2G4c2eYvCOJemRES5ry1bkRoq
	 KcPTomxYUs2rw3LqEc2wzwzv/pwJO6bQlYENadqB3ME3eIB5NC8ZjtrLWjIRHDyRgr
	 2IKqlCN0zsZpA==
Received: (nullmailer pid 1079108 invoked by uid 1000);
	Fri, 21 Jul 2023 14:24:33 -0000
Date: Fri, 21 Jul 2023 08:24:33 -0600
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: snps,dwmac: add
 phy-supply support
Message-ID: <20230721142433.GA1012219-robh@kernel.org>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721110345.3925719-1-m.felsch@pengutronix.de>

On Fri, Jul 21, 2023 at 01:03:43PM +0200, Marco Felsch wrote:
> Document the common phy-supply property to be able to specify a phy
> regulator.

What common property? I don't see any such property in 
ethernet-controller.yaml.

> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changelog:
> v4:
> - no changes
> v3:
> - no changes
> v2
> - add ack-by
> 
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc23..847ecb82b37ee 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -160,6 +160,9 @@ properties:
>        can be passive (no SW requirement), and requires that the MAC operate
>        in a different mode than the PHY in order to function.
>  
> +  phy-supply:
> +    description: PHY regulator

Is this for an serdes, sgmii, etc. type phy or ethernet phy? Either way, 
this property belongs in the PHY's node because it is the PHY that has 
supply connection. I'm guessing you put this here for the latter case 
because ethernet PHYs on MDIO are "discoverable" except for the small 
problem that powering them on is not discoverable. 

Rob

