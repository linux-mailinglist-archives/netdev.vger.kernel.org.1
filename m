Return-Path: <netdev+bounces-126592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE80971EF5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BAB1F23737
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3E13C3DD;
	Mon,  9 Sep 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm7V0rmx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C313A879;
	Mon,  9 Sep 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898810; cv=none; b=FbL83yWmjr9hUXaYiuBygtLmwmOGXfUaI9dcESGp2d25W3g5j0ngTG1CUbbuWWbHRIQtYUnb0pfXLL0rT3tCodrM2+OK+ARWrs2Y+KI3jj5cXoN03/kSsCm/dbc0cmcP8GXohLx8ok8NKmco6i29aWOl2dzzTxmN3VjZ0jWsy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898810; c=relaxed/simple;
	bh=TS/pSz1uD3dN1/wXh7XIMM8S8qVOA+/r9H0LYbQw3Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoQqRND9FZET7vuHV7oKKz0PehICs7+gVonw1QWFu3pASy2O0CSYchshyT+9AMLdW8cr2I6JCLcs92SLwcPVtkC2XQCezx+fCg2x59uX8rPVxoqmu1Mg2ht0P8UXN9KanMclm3hQQHcYuIlgeMbAE3boU9AVlm6bLTg3HjWNKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm7V0rmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BC2C4CEC5;
	Mon,  9 Sep 2024 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898810;
	bh=TS/pSz1uD3dN1/wXh7XIMM8S8qVOA+/r9H0LYbQw3Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zm7V0rmxhwjWgkzWrThPJEsFRUDqWvq+1iX2K8gqArj2yYKcaWSZ/iSEzLx+829cf
	 uSvLFRpjPcofMUYkvhheUgVBHXiJl8cxbl0bBSopOM/WAxzMfBVnnb//ysEw0Ud/Oa
	 HtLsJy0AxBBHGFqqSQD7sTaGIREmQJ65ZO+SYq9l9zyQSoYpdGM07295TOTNdipeP8
	 +zRdjXCgCu1I7nnWQJoSds6af8lNvlqPJLGwcF7NRCaO1sJ1tdSM8gkGeOgoLp8fw7
	 WJo10TsVsiqAJzW19QeQbbLiubZmuOZqvOfaE9Ar8ZNEyPer3gJR2onSpgOpPrYTFk
	 tWe/WP1baRfoA==
Date: Mon, 9 Sep 2024 11:20:09 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-phy: Add
 master-slave role property for SPE PHYs
Message-ID: <20240909162009.GA339652-robh@kernel.org>
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
 <20240909124342.2838263-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909124342.2838263-2-o.rempel@pengutronix.de>

On Mon, Sep 09, 2024 at 02:43:40PM +0200, Oleksij Rempel wrote:
> Introduce a new `master-slave` string property in the ethernet-phy
> binding to specify the link role for Single Pair Ethernet
> (1000/100/10Base-T1) PHYs. This property supports the values
> `forced-master` and `forced-slave`, which allow the PHY to operate in a
> predefined role, necessary when hardware strap pins are unavailable or
> wrongly set.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - use string property instead of multiple flags
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index d9b62741a2259..025e59f6be6f3 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -158,6 +158,20 @@ properties:
>        Mark the corresponding energy efficient ethernet mode as
>        broken and request the ethernet to stop advertising it.
>  
> +  master-slave:

Outdated terminology and kind of vague what it is for...

The usual transformation to 'controller-device' would not make much
sense though. I think a better name would be "spe-link-role" or
"spe-link-mode".

> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - forced-master
> +      - forced-slave
> +    description: |
> +      Specifies the predefined link role for the PHY in Single Pair Ethernet
> +      (1000/100/10Base-T1).  This property is required for setups where the link
> +      role must be assigned by the device tree due to limitations in using
> +      hardware strap pins.
> +
> +      - 'forced-master': The PHY is forced to operate as a master.
> +      - 'forced-slave': The PHY is forced to operate as a slave.
> +
>    pses:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
> -- 
> 2.39.2
> 

