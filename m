Return-Path: <netdev+bounces-154344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B59FD250
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2699318818F3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1E15532A;
	Fri, 27 Dec 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KclY7O/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA51876;
	Fri, 27 Dec 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289910; cv=none; b=r1Zey+brrsIvoMTtgAVfw53MFAo+8p6x/z6r8RmWqWgPikKWaqDMZaRIvviq2kNDMhxQMHRFYMcDsqu19Y9sUl+HqbBjcGZowGJLSkswvGHfUW4aOdq8O19UZRKjuaipmJ4P6oyYehycik4IpY2+0UWZdLBdKJzZFU/isBoDQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289910; c=relaxed/simple;
	bh=KWMos2seUO4wodgxGzGoi9Slnj20nfEtA0FL5awPNbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTlqPigK+cVQkFB70F82aliKS1KjYtBwhZVZeu/dBCDVJzgS8owCOzm00016/3qZNALOkh80mjaCi55mhKiPfUuC1x7d8uCw2efcjDihv++lWUnMywNXdU2sOVbT0uGEtgwJLGNQISakcHNwmFdmgacPtNdXcXS6YFegH+/fWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KclY7O/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CCC4CED0;
	Fri, 27 Dec 2024 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735289909;
	bh=KWMos2seUO4wodgxGzGoi9Slnj20nfEtA0FL5awPNbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KclY7O/q7tB23uWCBoKsyLOFXRuS+0KzOGCZPrAwAxCf6dDNwRlZSo+x0Q0SzegHg
	 16B9aZsqjnrNJ1Lv/V7BN12xFtU1TBZVwaCywHpXfOS+en5aefdsFinB3lWPY4WgPT
	 sWOAEwzbLP2F26gfp3hJAFg7DUNshlCL3hjEax/DuYRZqg5f4bd6Yf0OBC65Ed9bXi
	 H8YdDSwwn96IppLHjQats/i8Z2szP4mVM+Wyzf2g+OCQGGkbjKiW3E3MtphhPnnLZu
	 0v2wRft79H15UKBwz4p4PeuQOyMOn5meb0CfXC7mGk/Jm06IvIe9aTu11sSqZyS5HB
	 0NdbtIEf9qEGA==
Date: Fri, 27 Dec 2024 09:58:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Wu <david.wu@rock-chips.com>, 
	Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: Add support for rk3562 dwmac
Message-ID: <rfkjixkwira6lko62qpl5mlnwq5swzbqtaxwdjoavdt4as6uxb@wqa5er4dtl3n>
References: <20241224094124.3816698-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094124.3816698-1-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:41:22PM +0800, Kever Yang wrote:
> Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
> devices on the rk3562.

Usual comments... we see what you did here. No need to repeat it in
commit msg.

> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index f8a576611d6c..02b7d9e78c40 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -24,6 +24,7 @@ select:
>            - rockchip,rk3366-gmac
>            - rockchip,rk3368-gmac
>            - rockchip,rk3399-gmac
> +          - rockchip,rk3562-gmac
>            - rockchip,rk3568-gmac
>            - rockchip,rk3576-gmac
>            - rockchip,rk3588-gmac
> @@ -49,9 +50,11 @@ properties:
>                - rockchip,rk3366-gmac
>                - rockchip,rk3368-gmac
>                - rockchip,rk3399-gmac
> +              - rockchip,rk3562-gmac
>                - rockchip,rv1108-gmac
>        - items:
>            - enum:
> +              - rockchip,rk3562-gmac
>                - rockchip,rk3568-gmac
>                - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac
> @@ -59,7 +62,7 @@ properties:
>            - const: snps,dwmac-4.20a
>  
>    clocks:
> -    minItems: 5
> +    minItems: 4

So all devices now can have 4 clocks? No, constrain all variants.

Best regards,
Krzysztof


