Return-Path: <netdev+bounces-187770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B20AA9909
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D3188E69E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EE25569;
	Mon,  5 May 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRPxO1Ra"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F417A31E;
	Mon,  5 May 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462689; cv=none; b=bCxsIUjgksIF5sfUR3hKWmYCirRUUV6s7xYdOlN16a9WuWc4edHW+AbIRs0jEaiWMhZIQFvK8Bg5zp6KImvv8gYtjwASqK0pYhUDIIzvB4rtsOeZX3VSTGLAyCtR0EIJuqpsZ/MeFoqPA9EdtkbpgMHausXRYe+qx1oo9pvuHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462689; c=relaxed/simple;
	bh=GGN8QETHcZRFOO8bpP+cXy4314XVQKERq6Zjgu2d8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcB1Lbwya3P68NO6r9usFsBRJn2MZxClS/Zb5I7bZT7BTFgQ2fpqxNgiviq5gG8KBHn5u0ZzdI5nyFjeqwUgmkrMaXUd5+OblOdsKCE0ZoEu5mzqcTtxVhUsb0jfP1DEHsvaOL3CmTvyM/M7nIR+azxtvLqg4WqcubJvNIcr9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kRPxO1Ra; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X7FMx28lK/ahTWV6ZrHO9gUh/RVWuQWXyCZAc0RCGQI=; b=kRPxO1Rag37SzAsTjIrnihdtEG
	OsFyVKnjiOEVQPNtXd0fi+jnPcFK58/quIKYhs/BJnPd489YuJQ4xmHIzx/zsi9ygkwIGgEjjoeFW
	zEcGwI9RsssH5mRQb1V88nmjY0tQKZyACiY1tDYpy5VL6H4p9aFgwaPFUWYN+6LDrfIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uByis-00Bc8Z-1z; Mon, 05 May 2025 18:31:18 +0200
Date: Mon, 5 May 2025 18:31:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] dt-bindings: vertexcom-mse102x: Fix IRQ
 type in example
Message-ID: <b361a420-4f97-4c33-ad71-632c400239ff@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-2-wahrenst@gmx.net>

On Mon, May 05, 2025 at 04:24:23PM +0200, Stefan Wahren wrote:
> According to the MSE102x documentation the trigger type is a
> high level.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> index 4158673f723c..8359de7ad272 100644
> --- a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> +++ b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> @@ -63,7 +63,7 @@ examples:
>              compatible = "vertexcom,mse1021";
>              reg = <0>;
>              interrupt-parent = <&gpio>;
> -            interrupts = <23 IRQ_TYPE_EDGE_RISING>;
> +            interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;

This is a common problem with anything connected over some sort of
serial bus, I2C, SPI, MDIO.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

