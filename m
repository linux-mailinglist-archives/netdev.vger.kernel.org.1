Return-Path: <netdev+bounces-121930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710B95F585
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AAB1F223F5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A431925A1;
	Mon, 26 Aug 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJow60lk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393249631;
	Mon, 26 Aug 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687400; cv=none; b=g6SzxMyynRfSfXxe5TgV68HPI4ZZM2HeqhH/exz1UjMN/WNB570QVNT2VG8nkVWtuM45FrCK/LduD+tQP5hgAwxNXB1eoRqgTMOiV6lAt99rpb/w0EfpXE0WrKYf0Ob8ibFLwjAqRHW4DZdXDRGBcytdGiKYXVzIm7+uexJYcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687400; c=relaxed/simple;
	bh=Ix7gG+0vm0lVLIBVJQKChz8QDT/cbVX6+rxLO0aJ+Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEKTekpcItQvq3z81jp0m1vX6J05Om4jdKKoZQS8BPPr0o8ZFx9kq7+7j59O1mJlKIJF+EN+eT6AGhOHzcJDABbg8sViKddlNLCanc52ABwgjo/gV1jOp5S6HWTMYLNwgUjIrLwlPRUWkFnC8dKtFZyY+dH6w+Dl3TTBpBzTqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJow60lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCDFC4FEE4;
	Mon, 26 Aug 2024 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687400;
	bh=Ix7gG+0vm0lVLIBVJQKChz8QDT/cbVX6+rxLO0aJ+Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJow60lkASvRmQi4+EoOIL2KjoiqrTDGlKthDN7/dwFQXWvG1n9R2mfTjFw5xrD38
	 syEmNpnoXlIRUu3acvC1jq/Q+PYCE/WODMxXftDuPZBMYRuYNk8e94dn3xozaFkXJ3
	 I9wRbw+6yfqWLCEllY1l1EULNclQzrYaoeoHpdTwg2xFs+YF3dSXpTz185FoTbAzRK
	 QbBoFF2HwtNEuIGRfElqSMvtTqEhAHINVqVIC7v4utHfvKZ2CH+HbAP5pHGk4cK3y+
	 EtgeuwFhUlUj1UaCgKvcwotsTO2CQj919FSan581A2RlVZChVAguzzlZLWGG6UHDcD
	 oIpQgqAi1BlrQ==
Date: Mon, 26 Aug 2024 10:49:58 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, andrei.botila@oss.nxp.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Message-ID: <20240826154958.GA316598-robh@kernel.org>
References: <20240826052700.232453-1-wei.fang@nxp.com>
 <20240826052700.232453-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826052700.232453-2-wei.fang@nxp.com>

On Mon, Aug 26, 2024 at 01:26:59PM +0800, Wei Fang wrote:
> Per the RMII specification, the REF_CLK is sourced from MAC to PHY
> or from an external source. But for TJA11xx PHYs, they support to
> output a 50MHz RMII reference clock on REF_CLK pin. Previously the
> "nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
> this property present, REF_CLK is input to the PHY, otherwise it
> is output. This seems inappropriate now. Because according to the
> RMII specification, the REF_CLK is originally input, so there is
> no need to add an additional "nxp,rmii-refclk-in" property to
> declare that REF_CLK is input.
> Unfortunately, because the "nxp,rmii-refclk-in" property has been
> added for a while, and we cannot confirm which DTS use the TJA1100
> and TJA1101 PHYs, changing it to switch polarity will cause an ABI
> break. But fortunately, this property is only valid for TJA1100 and
> TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
> invalid because they use the nxp-c45-tja11xx driver, which is a
> different driver from TJA1100/TJA1101. Therefore, for PHYs using
> nxp-c45-tja11xx driver, add "nxp,phy-output-refclk" property to
> support outputting RMII reference clock on REF_CLK pin.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> 1. Change the property name from "nxp,reverse-mode" to
> "nxp,phy-output-refclk".
> 2. Simplify the description of the property.
> 3. Modify the subject and commit message.
> V3 changes:
> 1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
> 2. Rephrase the commit message and subject.
> ---
>  Documentation/devicetree/bindings/net/nxp,tja11xx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

This binding is completely broken. I challenge you to make it report any 
errors. Those issues need to be addressed before you add more 
properties.

If you want/need custom properties, then you must have a compatible 
string.

> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> index 85bfa45f5122..f775036a7521 100644
> --- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> @@ -48,6 +48,12 @@ patternProperties:
>            reference clock output when RMII mode enabled.
>            Only supported on TJA1100 and TJA1101.
>  
> +      nxp,phy-output-refclk:

Why not "nxp,rmii-refclk-out" if this is just the reverse of the 
existing property.

> +        type: boolean
> +        description: |
> +          Enable 50MHz RMII reference clock output on REF_CLK pin. This
> +          property is only applicable to nxp-c45-tja11xx driver.
> +
>      required:
>        - reg
>  
> -- 
> 2.34.1
> 

