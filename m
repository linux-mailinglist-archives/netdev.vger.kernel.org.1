Return-Path: <netdev+bounces-162612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E3A275F9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287011882812
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358B2144C2;
	Tue,  4 Feb 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGwolwsH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1225A659;
	Tue,  4 Feb 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683251; cv=none; b=GiCGiHl+OMOo7feNKXwq0swink+vLs6bs59t35x3MnUAHUncCT/gQL30YJ3SIrQdwFO8HlMvUUpjmISSmFUHn/sK2ocJZ5B2BumfYWAVxqIMAhhZZ4C4DLLpTxZUiDV4Iiyz3KlSCEjiUGUV6DHoTA0A+X22ut7M6kdKhMnSfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683251; c=relaxed/simple;
	bh=g/LfxlZKU/4g2zJNhw2PMNpPolCTDb+zhoBv0YRah7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KojdD+bCKENpt0Q1+TBN+PyS1Tp6eBuGRERvHL9KkpsvZBmA2wSIctMfqMxpn89KdJ3G/ysaqmFn2wmnDaL7chWzXBR6KaVyN4LxOf0fxkY9Q0JE4t+E0N3+gpah8UV+seYdDgsSH9Lnv7/46u5Lbkj+rpq4mM4KdMDUz/AJP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGwolwsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE002C4CEE2;
	Tue,  4 Feb 2025 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683251;
	bh=g/LfxlZKU/4g2zJNhw2PMNpPolCTDb+zhoBv0YRah7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGwolwsH4LA0TmfO+SdNxmBPT7szfYCrb/u9Gt6fIHPFGpopvj4/Opr582ozGvnmN
	 a1w14SsdJwMmrJMq6GN9AQnFqPFnbMiILgvW3qe2RrSl0jbkzRaDCtfC3RLU506Yv1
	 0ZcF/PwqrFzNlfrcAV8+wpykwlb691EY+ix7YbyDqfsRQSkMh6Gt9646qD9rGpzhdI
	 lMk6Z71TzSPHQyNrOpoGOqUf1NK4Vd7ukn4f/nSCWPndwXg8fX4xxzsVon9w1BGYRc
	 QkGvRQBt/JoMdp6hQwsFH60vh+jyUqoXmWOgXIqnGE+g/yCDwgctNLd23x8QNcl/AS
	 Y+ZTGofZQG5rw==
Date: Tue, 4 Feb 2025 09:34:09 -0600
From: Rob Herring <robh@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250204153409.GA2771999-robh@kernel.org>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>

On Tue, Feb 04, 2025 at 02:09:15PM +0100, Dimitri Fedrau wrote:
> Add property tx-amplitude-100base-tx-percent in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2c71454ae8e362e7032e44712949e12da6826070..04f42961035f273990fdf4368ad1352397fc3774 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -232,6 +232,13 @@ properties:
>        PHY's that have configurable TX internal delays. If this property is
>        present then the PHY applies the TX delay.
>  
> +  tx-amplitude-100base-tx-percent:
> +    description: |

Don't need '|' if no formatting to preserve.

> +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
> +      default will be left as is.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 100
> +
>    leds:
>      type: object
>  
> 
> -- 
> 2.39.5
> 

