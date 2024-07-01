Return-Path: <netdev+bounces-108216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0291E698
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB11B20FB1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC616E88C;
	Mon,  1 Jul 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ4cA+tR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D9F4ED;
	Mon,  1 Jul 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854789; cv=none; b=gfdr3lb8y52eIGS3g8S2OHn8u5GD4jg9ZtDcGPqE6u8K9JRWNQr/0B2Enny2rfW8WBdnLKirSMOdfDMIwmhFkENbD84ACGairRhp71R70WeNbrOxw06gT1cN7gs0zfK/ObToEwEokoZfyG9UfOaZboTi19q55VMJdjY+J//xPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854789; c=relaxed/simple;
	bh=/tGI0wDh0FZOcJPLb7Y56quvwZ87KDaB9YsD6KJsBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1okmCaR+mi2UKefBF/QjcGu9M2b6dN7I3GWhWwaurkGfyCXHqi9zHEDMIP2Ar0qJoZv0IUYxR2oHZUBplnKecz0JDZd9ed3SxD5bruJFh5/Epy3AuqwBi9Fk6tL2p6iRT/GWDCoj8Sh1l/dtQRVDDoOf0/Et7n75gF/xOGU/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ4cA+tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABB8C116B1;
	Mon,  1 Jul 2024 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854788;
	bh=/tGI0wDh0FZOcJPLb7Y56quvwZ87KDaB9YsD6KJsBJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ4cA+tRy28Qy+mS8NDV3R/k/RPTtjTv0F1HTGXrMq4iEJK4KKHTRd7GoRYgwX5lG
	 uLaMdo0so/hPvkU6S6sY/5sc9b7ENF50WanUfPN61ywgAl0pq78R48Le2owseps3bK
	 CpHbNjmCdx3Jw45NAiUKdFugGMl/S2dm/aS3t8qIYx1aeJOsq67lxmxzKW2WJ/Ua0B
	 UmoobqynglxyVQ6nUigLQKEm9eWIvib/nS46anIph1bAXhWKF2RY7uX9qEXNWKavYe
	 9Z8oYTWCSZurGIi0/5sXgeLuuPhB9SDmSNLfcPo8sXSnlh8xkDVZq5Mmd0GcC/pBS1
	 dwbHG0/fSxrUA==
Date: Mon, 1 Jul 2024 11:26:27 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE QORIQ DPAA FMAN DRIVER" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fman: allow dma-coherence
 property
Message-ID: <20240701172627.GA141559-robh@kernel.org>
References: <20240628213711.3114790-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628213711.3114790-1-Frank.Li@nxp.com>

On Fri, Jun 28, 2024 at 05:37:10PM -0400, Frank Li wrote:
> Add dma-coherence property to fix below warning.

'dma-coherent property' or 'DMA coherence property'.

> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: dma-controller@8380000: '#dma-cells' is a required property

That doesn't look related...

>         from schema $id: http://devicetree.org/schemas/dma/fsl-qdma.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,fman.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> index 7908f67413dea..f0261861f3cb2 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> @@ -78,6 +78,8 @@ properties:
>        - description: The first element is associated with the event interrupts.
>        - description: the second element is associated with the error interrupts.
>  
> +  dma-coherent: true
> +
>    fsl,qman-channel-range:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description:
> -- 
> 2.34.1
> 

