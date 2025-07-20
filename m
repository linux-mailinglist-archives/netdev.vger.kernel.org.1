Return-Path: <netdev+bounces-208460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5AB0B8E9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 00:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F9F189857D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380D21B182;
	Sun, 20 Jul 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9FfoDsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC313BB48;
	Sun, 20 Jul 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051120; cv=none; b=Rc3hiZ3SzEndshFELmC60wvbEfagU0FiayUUZDm9hMD/HqiGx6Z0qBSVT65+jZqvCNHxGAW/qSPaY6Pu1LTOmQiA5JEe5EfmOt2mBArbsy3pg9S/9LAk6ZXQK/GKmLU//+MF3pEkTqxS//Wil3T+kHmy7SOO2AF7UiNYCJ5LQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051120; c=relaxed/simple;
	bh=oqTA2ZEarT5JyUTl+x2+mKslIfG5nBTcCdmjL5quTSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV0KzEfKgU6ycG7nHsrYcO1Qt8weA6tkU6zB15991O9UX5/3BaQ6jJMlkB6EWG/JTIp3X+ex89fRKedfdFvAs2fgFxck7CrhSEQ1u4zbThMjft1OkdjGOX21juo1cxDI/ChOOKQJEFdW4hDO0s4L7WkvnjUdQ1JwPfRb4asxH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9FfoDsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55629C4CEE7;
	Sun, 20 Jul 2025 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051119;
	bh=oqTA2ZEarT5JyUTl+x2+mKslIfG5nBTcCdmjL5quTSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9FfoDsdjetl0yLpnmeMla7bxWQSWPKpixFkMkJHO/RvY6Svik5RTxjRFPVywpNaT
	 JKHS61qQrGaa4pj4URmmNg4YBf6XzRFwI4irN509Lg/brynDvVRMRr1oTIczhaWvNy
	 +pFKoJdJqKF6On7Avmv3zpNBhrZktM2irkHnH8aD30cYLfCImV50RS8DgPthWEJctZ
	 qB7Mjb6xTNGmPE5ul2Q34L5aiCxrGIQU/HkeQYuhBAN3+rKAFGqxo6dYRqStwHTZ/R
	 GM1uzAPrZu1I/Cwl5n27tMGTkZXzVgDJlRIAUBtXGFn7ni5Rf8PtO14oghweX4pa8s
	 UUQdwMj/Hcj/g==
Date: Sun, 20 Jul 2025 17:38:38 -0500
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
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: dsa: b53: Document
 brcm,gpio-ctrl property
Message-ID: <20250720223838.GA2949298-robh@kernel.org>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-4-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716002922.230807-4-kylehendrydev@gmail.com>

On Tue, Jul 15, 2025 at 05:29:02PM -0700, Kyle Hendry wrote:
> Add description for bcm63xx gpio-ctrl phandle

That's obvious. Please say why you need it. What is it used for?

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
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.0
> 

