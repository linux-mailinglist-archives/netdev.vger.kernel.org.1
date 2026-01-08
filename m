Return-Path: <netdev+bounces-248007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DECD01F8F
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF863300794A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97F33D6CF;
	Thu,  8 Jan 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnbQJI6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEB349AEE;
	Thu,  8 Jan 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862434; cv=none; b=a0ymHoM5ErFwLGYn5YHP1pDmoYStV9mjahNrrCF4x+b0z4v8WcSVRQw86xNzuJiXUjx/7qAeOLWLDuSXdJrhIM5zXzhX5BCQyuwAxNFGpdHld9B0qYk+HYDj2EBjVfoGKljdXiezHyDwG/p8ovIj2WSeosgjLD2F3g3Msxw5lgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862434; c=relaxed/simple;
	bh=+Y3pmCrSWmzwJE7Z9VU/gWsBpMcei7lqxHoCxpXUJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqFa9uZj8OMyDLYUMI5IFPlfoR0mjBVXPQPVsUZm6DJB4JbyamE/ZqngdTowexFD5eXetJSGhGjF+LkoJCCMt/IoeRyLtsfuxTnixZfDYRpz2BteYupx1AqREw3ACHMhxmm3RC/PaEEwmJstkLoJ5jEbZ/mUwkfeuzcZF+uCcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnbQJI6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1858FC116C6;
	Thu,  8 Jan 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767862432;
	bh=+Y3pmCrSWmzwJE7Z9VU/gWsBpMcei7lqxHoCxpXUJ88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnbQJI6GX0z9Bph2xDSMz7Es6JYAT1Nyholi12t4kaW7FSFRxe4wFpZ7uDVhJGHnu
	 EaC/592YAPLbcZYi1BsmhhqAD87ndt8AhRD7iDTMYp8JlRcM2lxuszvPxsCJSxaaIh
	 03PIoWPd7SnH6vg0hrZoLTdzYhqSMruJhsgP/kKwkqe5N+DI7jvh7cuoY+kgzJM/eY
	 46EurBV3G9UzXMpMUNQGix9UWimERDGX8WadNA+i7ay4c4kaA1QLgMyU7Y+4UW8N6H
	 68Nu9UTA/RIJwPE7U9Jkq1zbockXKCJA5ZU/kf53U4NzgbKN8JFU+B4FqnLckh9e2z
	 E3dhJxOd6+5Kg==
Date: Thu, 8 Jan 2026 09:53:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Message-ID: <20260108-shaggy-smart-okapi-efd3b7@quoll>
References: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
 <20260107-airoha-ba-memory-region-v2-1-d8195fc66731@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107-airoha-ba-memory-region-v2-1-d8195fc66731@kernel.org>

On Wed, Jan 07, 2026 at 09:29:34AM +0100, Lorenzo Bianconi wrote:
> Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..42bc0f2a42a91236c858241ca76aa0b0ddac8d54 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -42,14 +42,13 @@ properties:
>        - description: wlan irq line5
>  
>    memory-region:
> -    oneOf:
> -      - items:
> -          - description: NPU firmware binary region
> -      - items:
> -          - description: NPU firmware binary region
> -          - description: NPU wlan offload RX buffers region
> -          - description: NPU wlan offload TX buffers region
> -          - description: NPU wlan offload TX packet identifiers region
> +    items:
> +      - description: NPU firmware binary region
> +      - description: NPU wlan offload RX buffers region
> +      - description: NPU wlan offload TX buffers region
> +      - description: NPU wlan offload TX packet identifiers region
> +      - description: NPU wlan Block Ack buffers region
> +    minItems: 1
>  
>    memory-region-names:

missing minItems here.

Best regards,
Krzysztof


