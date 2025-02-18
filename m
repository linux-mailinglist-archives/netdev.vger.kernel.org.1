Return-Path: <netdev+bounces-167228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42391A393D2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DB8188871E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40431B85DF;
	Tue, 18 Feb 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0a8AMSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFB182BD;
	Tue, 18 Feb 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864122; cv=none; b=VRxfIRA2l+v+rmdrEAgnWql3igqf47j6hMBkmgj57wM03iTndYRH6AHkkx2RncPIaojOBdDHLI2xzUUNzO+mioMwdpT+OCtwScaxGCB+CjIa88iVCLvFzHeniNoVbe+htfYgy2CPpkvbVxMKLmNeeXz1DHodsxUzVCDPsEJHIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864122; c=relaxed/simple;
	bh=Sgy5q+4uhLggtzYVrIERv0e63cBiHocC6TBqgwZQm0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClDqXDzxcTtsKb5cDj6nXLIjeJ0QLqK3YqiNhiz7BUWxUS6tKlGUJpAOPuid9U70SMS7zRbknLePEc/u3oo6i0C2bBViW2WK0dKur0RFipB9sFXjBvwrhra3kqGwf0M59+PvvCUFOeuPMD+UbLAmC06CqrdOsAZHCCjD+Y07448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0a8AMSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F3C4CEE2;
	Tue, 18 Feb 2025 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739864121;
	bh=Sgy5q+4uhLggtzYVrIERv0e63cBiHocC6TBqgwZQm0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0a8AMStt2thyGJAQ6qKC66ZI62l8N0TwL8jSQUbglAPxVw2zcz1pvEij9ZcxKR3M
	 6KjmHa8gqzm3FLIfQ/uUjdyykWXGdg+qAxhELWK3o4R8TgJEzMo1VJ2B0eNfLa+ddZ
	 VFTQmwhq47Oo8MkLSGIXg15erGX1+U+AeCVT6ft/dHgwpeRFgTg2/vQJnWyaOWtvTJ
	 WfjJMlUYxQdgwUN/8NuB47Pylmrj1m+AvVLCfnP7H3rptyucSu+rvssw36RlPI40WZ
	 0M4/Y9Fl+Rb2gZj5pgg6Rb+tdp6Zhsr0k+7zXhLsDMt0qPgdVPTL3fUkOIme/EQw/6
	 LCU3LxrNVaQbg==
Date: Tue, 18 Feb 2025 08:35:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?Q?Fern=C3=A1ndez?= Rojas <noltari@gmail.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: mfd: brcm: add gphy controller to
 BCM63268 sysctl
Message-ID: <20250218-fearless-statuesque-zebra-3e79a8@krzk-bin>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-6-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218013653.229234-6-kylehendrydev@gmail.com>

On Mon, Feb 17, 2025 at 05:36:44PM -0800, Kyle Hendry wrote:
> Add documentation for BCM63268 gphy controller in the
> bcm63268-gpio-sysctl register range.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
> index 9c2a04829da5..99610a5f2912 100644
> --- a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
> @@ -50,6 +50,15 @@ patternProperties:
>        should follow the bindings specified in
>        Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml.
>  
> +  "^gphy_ctrl@[0-9a-f]+$":

Read DTS coding style.

> +    # Child node
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml

No, not really... how is syscon a child of other syscon? Isn't the other
device the syscon?

This looks really fake hardware description, like recent bootlin claim that
"one register in syscon is device".

> +    description:
> +      Control register for GPHY modes. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/mfd/syscon.yaml
> +
>  required:
>    - "#address-cells"
>    - compatible
> @@ -191,4 +200,8 @@ examples:
>            pins = "dsl_gpio9";
>          };
>        };
> +      gphy_ctrl: gphy_ctrl@54 {
> +      compatible = "brcm,bcm63268-gphy-ctrl", "syscon";

Messed indentation.

Best regards,
Krzysztof


