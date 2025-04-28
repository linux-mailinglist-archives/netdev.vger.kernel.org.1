Return-Path: <netdev+bounces-186348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058DA9E92A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487B13B5753
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F341DF26F;
	Mon, 28 Apr 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn7zweaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F61DF267;
	Mon, 28 Apr 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824921; cv=none; b=iXiBrQka0idGBiqKy7U+9OzYp7JhcaPnvPkWkwY4qDYbdqYfMQ4LlggzIMnSKM4IO7jj6B59yXw0eukfa6FX9o+5MXhQDLTdAIB2BaGCdY6Mxh4yBJi0csiDZKVMzbs+ybWbW0PFiWgD6xPAe8yf68d3dLgP15uA/8hXQpq4fLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824921; c=relaxed/simple;
	bh=lRQiEbQpx7U8/3WtfWFOwT8LyXiXIfna8PPJezfTB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7xf07eiJV2KgxI+naeQ5B5A4CeVH+NcA2D9r4hxU9kFUbcEOtDIh+ARW3J9pSNQoJfLYiOLJ9X4bjN8Mphr9wBhloxY4wegLZ77bp3VJX+44PExqrljkz5odCqIqE6wPQ5GST3H/+Uki9wtrT8hapF03IGduTFhvLJrcM6QWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn7zweaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A9C4CEF1;
	Mon, 28 Apr 2025 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745824920;
	bh=lRQiEbQpx7U8/3WtfWFOwT8LyXiXIfna8PPJezfTB5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nn7zweaZPy8ychArCeB3fYc2ZUOl+4VZ4+gnyTnQq55xjOU29vKvT804qzRRf0lx3
	 qM3Rloz1QLn3Igy7DLLnabjLF/4GjJZHnYn2+abes1EdxjEk7jmA2QOo8vmijgOZf7
	 x1q/W13EOHSdgVAF6lfsG53w+9Ny8p/BpbpOaz94tg8/mGMxu2W5lWN2/AiQ6Hzmni
	 Mr7gZtURFX2OQrrY5gehZybWOYncZcfU95hvGWXVSpdGH/l2ekmUj6G0xt/IUiXkyT
	 HDcyfV3wHJVhesMwlI4FNiw+Culk1dLbYsvFgGLx9d3kAB2LaSdaaWB0WpQuWNe7vs
	 8RMxvFRpD4JvA==
Date: Mon, 28 Apr 2025 09:21:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Przywara <andre.przywara@arm.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Message-ID: <20250428-vegan-stoic-flamingo-1d1a2a@kuoka>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-1-833f04d23e1d@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424-01-sun55i-emac0-v2-1-833f04d23e1d@gentoo.org>

On Thu, Apr 24, 2025 at 06:08:39PM GMT, Yixun Lan wrote:
> The Allwinner A523 family of SoCs have their "system control" registers
> compatible to the A64 SoC, so add the new SoC specific compatible string.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index a7236f7db4ec34d44c4e2268f76281ef8ed83189..e7f7cf72719ea884d48fff69620467ff2834913b 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -50,6 +50,7 @@ properties:
>            - enum:
>                - allwinner,sun50i-a100-system-control
>                - allwinner,sun50i-h6-system-control
> +              - allwinner,sun55i-a523-system-control
>            - const: allwinner,sun50i-a64-system-control

No update for the children (sram)?

Best regards,
Krzysztof


