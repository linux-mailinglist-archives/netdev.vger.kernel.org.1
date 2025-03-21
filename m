Return-Path: <netdev+bounces-176750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A14A6BFAA
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EDD3AD8BC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAA22CBE3;
	Fri, 21 Mar 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiIGkNKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F719938D;
	Fri, 21 Mar 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573894; cv=none; b=lHYDBVzOFyGLVh/pIh4BRil+Gq5lYPTbf9AIW5p1+9ia46gpwcoDgLya0Ep/dYHwSm7R1yiVqoSgcId3VEffXqJqVcsMttqW+ujO7aprERc04EMcl0nNut9KZy48/gOp0KWUso7ZpLcM4VH3U1gURzuyg+6ljRcyDBAFggIM4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573894; c=relaxed/simple;
	bh=3F1jIy5v0t3SdVAgghqO/ik97He3ue6vAk0iAk9b8+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1NucxDVBCHW56JAvE+T8GqAIEP/EEPHPFFlcStt+17FhDwYLOSC2Yt2EqzfkdEu6nbbhAtNjZsh4NGVat0hKkfYJVu2YZsCdom9MOgvO/6WEW1Mxwl1fOoNLHa4sloTJ8dJmPd0f3JjRw286a2fcVxWsb/N/jyd3t/yn732mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiIGkNKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA56C4CEE3;
	Fri, 21 Mar 2025 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573893;
	bh=3F1jIy5v0t3SdVAgghqO/ik97He3ue6vAk0iAk9b8+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiIGkNKKtJCW+DBwOlSA8QAawq09/UynZMFTmW3wqMZMJkkgDWqdxEBOEzq2eLa6A
	 rAOcbY1tXx03NioAXrY8Oa0dt2jd4c+6C8aqe26wsJyo9KzP3Gr+qEMYFCqpBR+S+x
	 Sa7eQ3jOnLhUzuRQY073ObZnGxp+Rg3S7xA3ErW5zphHXhVeTV1gg5P8DDnGVSuB+r
	 Zank0zWfDZaRgJy7HW19bcwpglAtJBJ+1eTk4L/Vy2lzC6FvoKCvewRwI3ORDIyWk/
	 95Prm+rl2iY/9iTUrmpdqQkxOouxa4+Q1Yg+zWWxdREbDqb1YvwaDU6VCKIO9cMrCk
	 PXjmDgSTJV+NA==
Date: Fri, 21 Mar 2025 11:18:12 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 4/6] dt-bindings: net: ethernet-controller:
 permit to define multiple PCS
Message-ID: <20250321161812.GA3466720-robh@kernel.org>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-5-ansuelsmth@gmail.com>

On Wed, Mar 19, 2025 at 12:58:40AM +0100, Christian Marangi wrote:
> Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
> can be defined for an ethrnet-controller node to support various PHY

typo

> interface mode type.

What limitation? It already supports multiple PCS phandles. It doesn't 
support arg cells. If you want that, either you have to fix the number 
of cells or define a #pcs-handle-cells property. You've done neither 
here.

Adding #pcs-handle-cells will also require some updates to the dtschema 
tools.

> 
> It's very common for SoCs to have a dedicated PCS for SGMII mode and one
> for USXGMII mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b235800..a260ab8e056e 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -110,8 +110,6 @@ properties:
>  
>    pcs-handle:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      maxItems: 1
>      description:
>        Specifies a reference to a node representing a PCS PHY device on a MDIO
>        bus to link with an external PHY (phy-handle) if exists.
> -- 
> 2.48.1
> 

