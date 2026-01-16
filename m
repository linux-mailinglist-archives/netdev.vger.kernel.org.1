Return-Path: <netdev+bounces-250591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC6D37B13
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2729C3110AAC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF7399A66;
	Fri, 16 Jan 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca/v6IWm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E482396B66;
	Fri, 16 Jan 2026 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586235; cv=none; b=eGNqiBqdKlgY1YjblVtkaWmvFpUyq/ydQYSDzSxfSGSgYkGw8QayE1Toob3Ji/qe7I4slJdGHcte+rHwDNbrzQ1Oe1Pe9HrEpGy/thL2TbIPtyJqihb936SxEmKzAhi8jg3sE14ADSoRVn3xRjd0PnUvrWYX+mSGIaCfbBFYy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586235; c=relaxed/simple;
	bh=T8eZiFJ/5yVjaFj6/LiudB7PdaI+HTyLS7R7wYWynDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=updtXlHnnTNw4TsxZhNWO0dcTfFlSVF+jZnI6WwM7lPvHk/kIqkOCN8Jah2VRKgjyH2HHDaHIJXnmdgb32kZQxCTNy+j74+PZHoNkUN1tDeFTdXYPKpZpVw0G/bKIJVVibvEcXJKDSwZyXIJcCN3IY/RfbCjfKbD7csrS8v0kpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca/v6IWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6FBC116C6;
	Fri, 16 Jan 2026 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768586234;
	bh=T8eZiFJ/5yVjaFj6/LiudB7PdaI+HTyLS7R7wYWynDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ca/v6IWmr5qB3qeHHkWjIOHZbQzZLtUxZp0NRcaL0qqvsMnVVIBk60au5GAlSmuua
	 RvihOmjy8lCTF2eBT0qHHtUGSK7SFUKjHpiUKJpy6qo3aG87/7cJJA+RoGUioJLE5a
	 608O4ACO2vyvVCNRX9AKMqMSIgEuUvDZtSczNsqNkbBEtSIWZ5mu2C6jrgMcC2wlup
	 voITTEH1uck0lJLKQy2VXk0HTkVyfI8Fx0p1kXVQVuwtquJP6czfj1nQwFjbaAiHct
	 lDhOYXXAv0TsUubMiR8uOX7xEarsuf51OQJRSUvPrB1I4FpJQR3qm+qUELbpt78Lmj
	 RliY3SOnV0nXA==
Date: Fri, 16 Jan 2026 11:57:13 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, Frank Li <Frank.li@nxp.com>,
	s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR
 syscon
Message-ID: <20260116175713.GA1801161-robh@kernel.org>
References: <cover.1768311583.git.dan.carpenter@linaro.org>
 <7662931f7cbafe29fc94c132afce07ba44b09116.1768311583.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7662931f7cbafe29fc94c132afce07ba44b09116.1768311583.git.dan.carpenter@linaro.org>

On Tue, Jan 13, 2026 at 05:13:32PM +0300, Dan Carpenter wrote:
> The S32 chipsets have a GPR region which has a miscellaneous registers
> including the GMAC_0_CTRL_STS register.  Originally, this code accessed
> that register in a sort of ad-hoc way, but it's cleaner to use a
> syscon interface to access these registers.
> 
> We still need to maintain the old method of accessing the GMAC register
> but using a syscon will let us access other registers more cleanly.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v3: Better documentation about what GMAC_0_CTRL_STS register does.
> v2: Add the vendor prefix to the phandle
>     Fix the documentation
> 
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 2b8b74c5feec..cc0dd3941715 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> @@ -32,6 +32,17 @@ properties:
>        - description: Main GMAC registers
>        - description: GMAC PHY mode control register
>  
> +  nxp,phy-sel:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: phandle to the GPR syscon node
> +      - description: offset of PHY selection register

It should be:

items:
  - items:
      - description: ...
      - description: ...

Because it is 1 phandle+args entry of 2 cells.

Rob

