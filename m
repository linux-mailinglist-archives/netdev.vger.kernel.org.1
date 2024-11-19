Return-Path: <netdev+bounces-146328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4AA9D2DC4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99D41F2350F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88ED1D1506;
	Tue, 19 Nov 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwmhcXO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79B1CDFCA;
	Tue, 19 Nov 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040315; cv=none; b=nO/8sx5oBe8m2m/F+rxPdcz5kaM//5L+8oIuCoX2rTlqRZzqNxfehu7YUbowGqZ9tTvDC7sGvA+NmaBvKN0TOC0fUu7dMr65jBDvzm0WilWTlE83crU6UKPD3srLCsrHy27OJlzsoj0YNftGSKHlqWefnxojU/90X43RfjoLWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040315; c=relaxed/simple;
	bh=Wo4rlPhE92EUOyHR0Tl4T39RGOZr5gNuIEk4zdKuEZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBm8OXNkbl+g7tyehwwy+mFW3qOF/snftAoHfJPTJXhLnqIkwQ4ztNe7fyD5wubmvtJu8tuIG/Go0s2Mc8CR40gz8CrJHJaaDcx8XrB86FuKUAeSsKDcZC5wd3z5JR9KZ+naiJteu5d5bq7w4SmgZ5fd9iWn4qJqBadzJmvCupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwmhcXO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E83EC4CECF;
	Tue, 19 Nov 2024 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040313;
	bh=Wo4rlPhE92EUOyHR0Tl4T39RGOZr5gNuIEk4zdKuEZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwmhcXO/6k1UcIam0xMjM1Bj2G4s8Y6JCdeSx+YAWiqCkcXJrcEc5cSgLkNR6gkI7
	 eeL//YJ4Is8fMMrnmo9FjX4Ok/juwuu6/WTdREYITGLr4P3DZNHrtjKZlh8jucI7nS
	 jxDwm7oTzxVUBrEKYbxH6zAGr/JxLAq2XR4Tae0tdpZ5hYQpkUNRKgNprRa8HJmngY
	 13LDCxnEadBe7ID+0QWW32zivGv2fo5XJwVuUr7d5CcXS1OgOzvx6zUjjepz/1ebVI
	 pLh5gdB2rDfbpAxOVDIgghZLrgHWzT/mrsDObonlwGmi9EhbPDRo4DAUDBAyR1SOzi
	 0BxaSD++w77WQ==
Date: Tue, 19 Nov 2024 12:18:31 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/3] dt-bindings: net: add support for AST2700
Message-ID: <20241119181831.GA1962443-robh@kernel.org>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118104735.3741749-2-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:33PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support for AST2700 in yaml.

"Add compatible..." is obvious from the diff. Add something about why 
the diff is how it is. For example, it is not compatible with AST2600 
because...

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index d6ef468495c5..6dadca099875 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -19,7 +19,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: aspeed,ast2600-mdio
> +    enum:
> +      - aspeed,ast2600-mdio
> +      - aspeed,ast2700-mdio
>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 

