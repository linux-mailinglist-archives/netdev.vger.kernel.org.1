Return-Path: <netdev+bounces-204481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB2AFACA9
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E46162012
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05E1FBEBE;
	Mon,  7 Jul 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvVog57e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5B946C;
	Mon,  7 Jul 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871924; cv=none; b=NEXRSVvaR8xu84zAeq46pLqVD3WZeNkhDQhqrOGotclgz7w8/AaQql/EjTgwMD0j4zYZ+n4qqGw4BIXX/w549L4TPnuJJrIFSnMVQFn+oteduXLDXzeShaxjnKIVQUNnJiihsJKnPvFcm/TcTvy0VZBSerTArtLQ5LJ3W7v8SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871924; c=relaxed/simple;
	bh=PGd9A/5X3od+Z3ffVuEq/O0FzpECV5LP8wKFT6Fvjms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqwX5RBxcdIAblN346ZyavER6U4pT7+0nXF/XtT2osqkFegfaexdNDlorx9uQl8Ce+v08vTZ5cxg0H180f29tU9eTwN+THZoBqp7A1OiEOC0yIH5FXYPDi5KWntsN9A1xBHvM+Iu4nL7AE1BjDp2uKMoIRJ7gEm2zEatSquz3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvVog57e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB729C4CEE3;
	Mon,  7 Jul 2025 07:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751871924;
	bh=PGd9A/5X3od+Z3ffVuEq/O0FzpECV5LP8wKFT6Fvjms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvVog57eSaJ7QWXH8nmeb4XuVlKZryiU7ZDpRGgHKMWBPpORbIA4VvVU4UjYEO6NZ
	 QVCRtXiPnoW61uFvKUy5XyExVtoUlttp9QbU+jBFqCgUZMVLP+TTZHPX3XUNzynoXL
	 UnIyEH9ch4evzaTB/JVTGpSjYIVDc/VneTCzKuOdTPqMlxW0Et6/Dobd7VM50eyRU0
	 wtEFQ0mR7Sc13PlbzNAsFHa2k2eYrkcXrPaecBEPZve2zpln3yCSGHj2E7G8HXw5rj
	 VBftwCkKF0AltFaSzuyVnXTOwIJ5zMCmVmKecigiDHo2sRuL0U2bmQZsBbtGqUEpVL
	 7b70fNU/wqDVA==
Date: Mon, 7 Jul 2025 09:05:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <20250707-topaz-pillbug-of-fame-859822@krzk-bin>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-1-3cf32785e381@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-1-3cf32785e381@kernel.org>

On Sat, Jul 05, 2025 at 11:09:45PM +0200, Lorenzo Bianconi wrote:
> Document memory regions used by Airoha EN7581 NPU for wlan traffic
> offloading.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..db9269d1801bafa9be3b6c199a9e30cd23f4aea9 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -41,15 +41,25 @@ properties:
>        - description: wlan irq line5
>  
>    memory-region:
> -    maxItems: 1
> -    description:
> -      Memory used to store NPU firmware binary.
> +    items:
> +      - description: NPU firmware binary region
> +      - description: NPU wlan offload RX buffers region
> +      - description: NPU wlan offload TX buffers region
> +      - description: NPU wlan offload TX packet identifiers region
> +
> +  memory-region-names:
> +    items:
> +      - const: binary

Rather: firmware

> +      - const: pkt
> +      - const: tx-pkt
> +      - const: tx-bufid
>  
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - memory-region
> +  - memory-region-names

That's ABI break.

Best regards,
Krzysztof


