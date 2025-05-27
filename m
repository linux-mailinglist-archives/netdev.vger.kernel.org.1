Return-Path: <netdev+bounces-193567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E2AC4848
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A553B93DE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E201EA7DF;
	Tue, 27 May 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4iBIAnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F61DF247;
	Tue, 27 May 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326868; cv=none; b=kQuqXcWJShazwfSeLmPMdS9eKdW32m+j4ss7t6zgt9sYACTesjYjaZwqZ+1gaTLBImo3tW3D4ii+WMoQ0nemK28kJoVmkvLWCIyjn6nsItMmmhcfyVw7jvealLP4WmzbO8IB/bCeD0lRb1Tv8bWUh38DTU3A5tuCCCDMPM3mJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326868; c=relaxed/simple;
	bh=z62MIO2YE57jNih9u88PmAjAzV6PvjH+SCz4KoKZxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPZo1iYmEenmrzNvcWY4a+8yWXO5Wg990yUliorIfGYHPAAw3xfZ9Q6QNVSGQx0KgDGw+Sw1Ie5CVoSafY532dPiFL8il6m2PCo9kAg733hVP65tNYgux4au4jVGHlr/jzq6cSa0ZnVejI45E7CxCQUxqxX7k06wLLUMtRzvOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4iBIAnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF551C4CEEA;
	Tue, 27 May 2025 06:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748326867;
	bh=z62MIO2YE57jNih9u88PmAjAzV6PvjH+SCz4KoKZxVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4iBIAnbNg7XXb9oX4eAc93qYgmFMoNXrw3Np3x4BjzH48GyZ/ycs1kkXNTnChGfa
	 4BwmJd3s2TCHg8eyg6S38gac3MplcoyEpY8ZerDfS0hH5ERjSYr5f3t3QXd1tFCogP
	 0jODfA8F5RZsE9RS57DEzjFAF16yntUEXR5PigEUWkBMrOh5O+AY3Gpmk2Mtt2+2Kq
	 QqprwjCgVG0ylDMKgxrpO+iib7VUTqGWik0XxNJSzfo79xTMxGVYyZGwDa+ex+vLgA
	 VJkOIJRKUFrTIUFSEdzsNbX/EWJkuwYVUcmzA6WMkbAGTKImxzI5nxYtk8dz9oo8NW
	 X0MZBH933OwHQ==
Date: Tue, 27 May 2025 08:21:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
Message-ID: <20250527-loutish-shaggy-starling-f558fb@kuoka>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250526182939.2593553-3-james.hilliard1@gmail.com>

On Mon, May 26, 2025 at 12:29:36PM GMT, James Hilliard wrote:
> The Allwinner H616 EMAC1 can be connected to an on-die AC200 or AC300
> PHY depending upon the silicon variant.
> 
> Add a new allwinner,sun50i-h616-emac1 compatible and example, support
> for the allwinner,sun50i-h616-emac1 will be added later on.
> 
> Add nvmem-cells and nvmem-cell-names properties for the ac300 efuse
> based phy selection.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 7fe0352dff0f..b6bf1718dba1 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> @@ -18,6 +18,7 @@ properties:
>        - const: allwinner,sun8i-r40-gmac
>        - const: allwinner,sun8i-v3s-emac
>        - const: allwinner,sun50i-a64-emac
> +      - const: allwinner,sun50i-h616-emac1
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-emac
> @@ -28,6 +29,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  nvmem-cells:
> +    maxItems: 1
> +    description: NVMEM cell with the ac300 efuse.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: ac300
> +
>    interrupts:
>      maxItems: 1
>  
> @@ -321,4 +330,37 @@ examples:
>          };
>      };
>  
> +  - |
> +    ethernet@5030000 {
> +        compatible = "allwinner,sun50i-h616-emac1";
> +        reg = <0x05030000 0x10000>;

No need for new example for every soc.

But if you ever decide to add new example, it must work. Please test
your patches prior to sending them.

Best regards,
Krzysztof


