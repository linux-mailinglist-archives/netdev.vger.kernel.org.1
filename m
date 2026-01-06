Return-Path: <netdev+bounces-247435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29560CFA547
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 613853044203
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A42FFFA8;
	Tue,  6 Jan 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvWl1oMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD012FF66B;
	Tue,  6 Jan 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724482; cv=none; b=QYLLTEX4fATZk5r+nMK49IPAiPpneX/6rAAVYorV+1DsEr+F6rAPw2EwzalMlTBb4BTNegvTPOg673ePpzoCkgkmMSmGS9J/a9C7ih5cgQwqY5ZQ1THFU2ID0Nidc4pZ+O5Xp0x3Xsoo6bIsyC0nl7CSgklsa7c0QwaJ9oQWag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724482; c=relaxed/simple;
	bh=H2v0nUt8N0vGGdbmlYiAAvAo4Pe4F33fRgeEAFY94/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZH0vKXHEbAKXuLQjpuopDYaMRs8LgZrFdiVr+H6OKmMDXc3wVm8xQfWKtiBseLgUWFuAs19OgYOTCemdNh9hDiAFaMtXLRVyl9WzN4zNYKIFHsRl2HBN7KQdC5n7beo+Dx2aqoCcXj1QyKKlWTA9vtmKiipZHXpb/+CxSQ009Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvWl1oMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152C5C19423;
	Tue,  6 Jan 2026 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724482;
	bh=H2v0nUt8N0vGGdbmlYiAAvAo4Pe4F33fRgeEAFY94/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvWl1oMzdgHT/lp0TV4rEcJ8KSAX5uz4aKUNJUZM/9Fw2AhxQvWxlDCsW9dkPhYuG
	 kGtfrzLYii0Dcs1IFsDE/r35PWpspaWSHEmpmKHAfQJqfDhPXGzXN+AcQX8FhIqlLr
	 S2GlvwkqAR3eWJn5OSXGBcUlSVjtK1ySUFYR4Kgo65YrR5qEKgsHgrkkR2f7wo7gAc
	 NZkIgfrl/22DVK+m33EFyTZD7ElvUBBegC0B1jErirr8Pd+5OcPFoF8AW/bmY+Xn3F
	 +Cdh7YwsMaezrL2EGPygsauQDaw4lqwaPo/WVcRONNnDOBN1dCWVBK8U4GCSoWgqiD
	 dMz6zwvCP1HZA==
Date: Tue, 6 Jan 2026 12:34:41 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Message-ID: <20260106183441.GA2514063-robh@kernel.org>
References: <20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org>
 <20260105-airoha-ba-memory-region-v1-1-5b07a737c7a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-airoha-ba-memory-region-v1-1-5b07a737c7a7@kernel.org>

On Mon, Jan 05, 2026 at 10:02:56AM +0100, Lorenzo Bianconi wrote:
> Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..b3a2b36f6a121f90acf88a07b0f1733fa6da08a8 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -50,6 +50,12 @@ properties:
>            - description: NPU wlan offload RX buffers region
>            - description: NPU wlan offload TX buffers region
>            - description: NPU wlan offload TX packet identifiers region
> +      - items:
> +          - description: NPU firmware binary region
> +          - description: NPU wlan offload RX buffers region
> +          - description: NPU wlan offload TX buffers region
> +          - description: NPU wlan offload TX packet identifiers region
> +          - description: NPU wlan Block Ack buffers region

This oneOf can be simplified to just this last entry plus 'minItems: 1'. 
Sure that allows 2 or 3 entries, but nothing defines when 1, 4, or 5 
entries is valid or not.

>  
>    memory-region-names:
>      items:
> @@ -57,6 +63,7 @@ properties:
>        - const: pkt
>        - const: tx-pkt
>        - const: tx-bufid
> +      - const: ba
>  
>  required:
>    - compatible
> @@ -93,7 +100,7 @@ examples:
>                       <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>          memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
> -                        <&npu_txbufid>;
> -        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid";
> +                        <&npu_txbufid>, <&npu_ba>;
> +        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid", "ba";
>        };
>      };
> 
> -- 
> 2.52.0
> 

