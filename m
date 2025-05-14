Return-Path: <netdev+bounces-190530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F80AB766A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41713BCDFD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E472951C9;
	Wed, 14 May 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3TDn86s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDA1E9B0C;
	Wed, 14 May 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253301; cv=none; b=hkehWmH9cIEjip9QSWP3w0ODKyk7g5UJv8UWa/8tt/kis7WVW/RWS56yf5ZpcOqiVQWTJjUdw5gEPkH6LxL8UQ0cOdUPmR0S/RhdtK3BlOnhII8eIjSwXyBdQqWPZwaDlPgYllD/RWrSXWtFLs2XBlu/U+l+rfEyPC4+8FbDDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253301; c=relaxed/simple;
	bh=3WUxiz74QfrEkVVFQDowE0+qUL29wRFq5sAQpUVQaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkDk3fVYfEbSW1gEPujeQ9f+aW6jiXoIqOWSG67W4HR2lv9/d4rK1iLgbxHpqDsN9xkohw+jmdK8ScSnnmMwInxKCZ+W29rKWIhe2hNGAOFUCQoiyLrF3NjDbxPj5TaZfWO0Iz7BY9GOC8pCJvDcilL++IszYbUvuohs+kct5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3TDn86s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C649C4CEE3;
	Wed, 14 May 2025 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253298;
	bh=3WUxiz74QfrEkVVFQDowE0+qUL29wRFq5sAQpUVQaOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3TDn86sJuOiIpUlS3N/aQHf1Vundgo9YCoc+bwdDkKux/jkXJacNmbXRTiW7WvdO
	 DjSdaW+j2jJcRyK+RUx9PiHIZ0gdg90lmLKjTeaLslXtsqlPvzTTE0IG9rhB5rgot4
	 pChbLMyxVHy46X/c90eDi5gqQ/DIz7IBBSe3bmtOl+LN9hnkJJfIWISIkmnuRMQ+Eb
	 kuhYO8iXV1cjbYmyl55NeBqz818v1WYcoyPdGGACtrksGSMZsfSyUFiLMHoJD6HA9m
	 aJbU1sh4FbaTyCUC7756UVtI5klo1RjldtCXLaj6gvWgtLam3ar89RAdL3oOpvvEau
	 9wu/mJwzdA+zA==
Date: Wed, 14 May 2025 15:08:16 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: Add EN7581
 memory-region property
Message-ID: <20250514200816.GA2934563-robh@kernel.org>
References: <20250509-airopha-desc-sram-v2-0-9dc3d8076dfb@kernel.org>
 <20250509-airopha-desc-sram-v2-1-9dc3d8076dfb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-airopha-desc-sram-v2-1-9dc3d8076dfb@kernel.org>

On Fri, May 09, 2025 at 04:51:33PM +0200, Lorenzo Bianconi wrote:
> Introduce the memory-region and memory-region-names properties for the
> ethernet node available on EN7581 SoC. In order to improve performances,
> EN7581 SoC supports allocating buffers for hw forwarding queues in SRAM
> instead of DRAM if available on the system.

But 'reserved-memory' is generally for system memory which is DRAM 
though we unfortunately don't enforce that. For small onchip SRAM, you 
should be using the mmio-sram binding and the 'sram' property.

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index 0fdd1126541774acacc783d98e4c089b2d2b85e2..6d22131ac2f9e28390b9e785ce33e8d983eafd0f 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -57,6 +57,16 @@ properties:
>        - const: hsi-mac
>        - const: xfp-mac
>  
> +  memory-region:
> +    items:
> +      - description: QDMA0 buffer memory
> +      - description: QDMA1 buffer memory
> +
> +  memory-region-names:
> +    items:
> +      - const: qdma0-buf
> +      - const: qdma1-buf
> +
>    "#address-cells":
>      const: 1
>  
> @@ -140,6 +150,9 @@ examples:
>                       <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>  
> +        memory-region = <&qdma0_buf>, <&qdma1_buf>;
> +        memory-region-names = "qdma0-buf", "qdma1-buf";
> +
>          airoha,npu = <&npu>;
>  
>          #address-cells = <1>;
> 
> -- 
> 2.49.0
> 

