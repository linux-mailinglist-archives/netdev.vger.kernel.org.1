Return-Path: <netdev+bounces-245070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2BCC69F9
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C783010A87
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92D30E0F6;
	Wed, 17 Dec 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W47vCtRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE0288D6;
	Wed, 17 Dec 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960625; cv=none; b=LxzLr9RufuZZsiL/uMCzDzH/wGc1yAd67fEcW4mia2nfW+W/cmHSZKWua6n20q0DHr97MhdTrYIdVhNiO6VMTpPzQwpNmv6UNYj7r93FEuJHQASlgqu0Vd5y9FXtQmZt2aeC7SC/CU1mK7OVUmxQc2oPQ2s1hufPw9fgCBeNaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960625; c=relaxed/simple;
	bh=KAQs8LiC0Yfd4rW28C195gtmvQ2iLTjhXonSSp4r1+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2WYlIIjKDoPcnRi70xQ7j9rqanSrFX3dlILdozpvIjcLpcD/AkGNECB6q1V0rFiQav5inAlE2d43am/ZFMPJmasuhHLNXjzyn1pmPLTq0dg4gkLI6QeqKcettx2EcQSzRKFiXMchX0Daa6Sf91/V4NqtYiXrNpQoPI5Epk65Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W47vCtRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6569BC4CEF5;
	Wed, 17 Dec 2025 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765960625;
	bh=KAQs8LiC0Yfd4rW28C195gtmvQ2iLTjhXonSSp4r1+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W47vCtRc2fjZpQe/DRm+pPSRqT8FgIjIIRf2fcHiNzSfRwfN9FSNmNhfSNsomcwSZ
	 shUz34HPQQt6QsrC72mdmgJ2kAOKPXTU5yvT2bf9EzQAoeKTAwi+8Z9q4l5/IyaHJE
	 w0dIZZ61skCOa1af9EcoK4jlfs4frthhbXwFQbcpYbmYBzCiUmU+0V7dpZFs2FhzY6
	 Ilw2aNq9h0FBq/T2glswF071hRUoOSkhuY6XwfXZcgpqHZYa1NLC9lrxsvdjf+MbsY
	 NZ7Hm3zKDEO1+/DWE3pz6PmJZOwopgc3zT/AoM7n9Uo3WbCAQBW0TGMgCLrxbFD0xn
	 VWQhHJVoQolrA==
Date: Wed, 17 Dec 2025 09:37:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linaro-s32@linaro.org
Subject: Re: [PATCH v2 3/4] dt-bindings: net: nxp,s32-dwmac: Use the GPR
 syscon
Message-ID: <20251217-elated-vicugna-of-whirlwind-23d6bc@quoll>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <1ecafee4bd7dc3577adfc4ada8bcc50b5eb3e863.1765806521.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ecafee4bd7dc3577adfc4ada8bcc50b5eb3e863.1765806521.git.dan.carpenter@linaro.org>

On Mon, Dec 15, 2025 at 05:41:57PM +0300, Dan Carpenter wrote:
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
> v2: Add the vendor prefix to the phandle
>     Fix the documentation
> 
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 2b8b74c5feec..a65036806d60 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> @@ -32,6 +32,15 @@ properties:
>        - description: Main GMAC registers
>        - description: GMAC PHY mode control register
>  
> +  nxp,phy-sel:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: phandle to the GPR syscon node
> +      - description: offset of PHY selection register
> +    description:
> +      This is a phandle/offset pair.  The phandle points to the
> +      GPR region and the offset is the GMAC_0_CTRL_STS register.

Do not repeat description twice. The GMAC_0_CTRL_STS should be explained
in description of individual item. This description should only say what
is the purpose of it, why the hardware needs to poke in other devices.

Best regards,
Krzysztof


