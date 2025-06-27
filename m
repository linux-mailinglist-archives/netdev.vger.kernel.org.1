Return-Path: <netdev+bounces-202021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519EFAEC07B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7753A4A6718
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E222EA491;
	Fri, 27 Jun 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0KlnfpA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A32E92DE;
	Fri, 27 Jun 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054228; cv=none; b=gBrN3QfzVS21qb2kJI9iig2mJXEoyIO3c1cnnrnKp4OZloFtI8La0v9EFTaeKvw6xTcLyl8sTeMeyELjkGgOUPoHjPxaq6aeI/f/n2B63fgbyzOtE7TCQ8/nvBEXd5xHatM/2Qxba76qTB2O4PL9tfH4LVlDjtG9FhTsL1inwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054228; c=relaxed/simple;
	bh=52RIw6noQLlbTckB9hEH3eigLjcCeFsGu7yQ+rD9Iyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMvB766ULB2HUpiVmmBfiLWbAnylLPyUbqe+VJIKIrT058h20XObfaXyCK0oK1+B/0SE+rzjaeeaJQNcBhVW7r8BtFt/u76ljqvTh663wg9DuBIjhoo+A6blBok2DqmMIjnlyu8K19x7e0s9ozUB1BfGRyDSgGiDDII6TBOn0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0KlnfpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505CC4CEEB;
	Fri, 27 Jun 2025 19:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054228;
	bh=52RIw6noQLlbTckB9hEH3eigLjcCeFsGu7yQ+rD9Iyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0KlnfpAmh157gMJwfnjdUKE6NE6pF+FX2VU4RCzk7grvCcKcW7sOII36K6qGPo/S
	 GeMy+sFZszKY/DVgSQpXObGGzjpztEnWYP+pMGeFXPCRXZ1nQXCsvAcul1XFIh7dQ0
	 T+MLpNPAQlcx51BMue+yS+CYIU5Y0NnGvDqNa/ttGTAShxID8BubGW/6+bj8nSg+5c
	 U0Zn/0H6CGzejK3rgLShmwo5B0Pt20va+HEJTHBR2kg2L6NfuGxMmll60V624BUhcP
	 uCZsy10dFPpBOzOCfBaDHP5V4h7d1gbNme0EKbwP8OAraSsFjlQ8TM1X7Zwq5TmaKs
	 qdwLeSwEr9Y4g==
Date: Fri, 27 Jun 2025 14:57:07 -0500
From: Rob Herring <robh@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, noltari@gmail.com,
	jonas.gorski@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 3/6] dt-bindings: net: dsa: b53: Document
 brcm,gpio-ctrl property
Message-ID: <20250627195707.GA4075889-robh@kernel.org>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
 <20250620134132.5195-4-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620134132.5195-4-kylehendrydev@gmail.com>

On Fri, Jun 20, 2025 at 06:41:18AM -0700, Kyle Hendry wrote:
> Add description for bcm63xx gpio-ctrl phandle
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> index d6c957a33b48..c40ebd1ddffb 100644
> --- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> @@ -66,6 +66,11 @@ properties:
>                - brcm,bcm63268-switch
>            - const: brcm,bcm63xx-switch
>  
> +  brcm,gpio-ctrl:
> +    description:
> +      A phandle to the syscon node of the bcm63xx gpio controller
> +    $ref: /schemas/types.yaml#/definitions/phandle

GPIO? Why aren't you using the GPIO binding?

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.0
> 

