Return-Path: <netdev+bounces-206974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07845B04F8C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 05:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F5F188E3F8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE222D12E4;
	Tue, 15 Jul 2025 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtQOE/I0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC61B4F1F;
	Tue, 15 Jul 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551661; cv=none; b=XN0hw7bVWo7A0Sfq1aEIn4Zhq9Gdnl6HmoOcXyT9pF0yuUN0OBQmWFdnDL9l+TSANPAsECIbq0W8FtWb9AiXhS8Qhb05lWX56x1qrhc1Z3T0qJygLYPBhocwAGL63/cgM7pxnbIWWcDfCzLt2gAZmxRHbHAMO/t3Ea2Q4ALsdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551661; c=relaxed/simple;
	bh=R2NhqYJcsbfnwkDNnCnNVLiCMS9BTr1YY+cvgm42Mvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK8N2AIwl681yqDBEdlKcwhb1zjo1ub+VRweo2tRFcRw05oQNoDcUnuYSxzcl/lLJef2C6svslTw8ziUh7UlyDomtlW02GYJzWnYZtYgfJ3fW1nQSuXRwq56hvcnZHhX1NpzrR8tJQ0Q1Kjd8ExMbl2uHZV6PWD4N68Rchla+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtQOE/I0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE79C4CEE3;
	Tue, 15 Jul 2025 03:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551660;
	bh=R2NhqYJcsbfnwkDNnCnNVLiCMS9BTr1YY+cvgm42Mvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtQOE/I0sXT8utigzhHgXqTEOL3H7XlIUhkOTwDww2ZoRXAn0dS1ueUXDmLz3NYq1
	 ek37yiFG8NEZIi5+/29nMezHyKEYJZxwMxM/LBI4YtasXZFEwbLTRvpprg7rl7Nf5Z
	 xjop+gXI5FuaG/5xo2ZNtafgYDtOPHXDQeJhFHjhBNCCctj0t+JAHUBzdQtPIzjoHf
	 HGlU3w4UjPuCuezFH6hNHZf+TUINu/z1Docgsumb8XejYJepCi8+SG5kLw/w53OsXT
	 405VnH2SQOc6CdPbn9bU2l5v+d4JgVAs4uFaSDm5ps2JS4MeFzFm8zx3QgrwIJ/UqF
	 BSJ+OaMQW6HxA==
Date: Mon, 14 Jul 2025 22:54:19 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <20250715035419.GA11704-robh@kernel.org>
References: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
 <20250714-airoha-en7581-wlan-offlaod-v3-1-80abf6aae9e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-airoha-en7581-wlan-offlaod-v3-1-80abf6aae9e4@kernel.org>

On Mon, Jul 14, 2025 at 05:25:14PM +0200, Lorenzo Bianconi wrote:
> Document memory regions used by Airoha EN7581 NPU for wlan traffic
> offloading.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..f99d60f75bb03931a1c4f35066c72c709e337fd2 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> @@ -41,9 +41,18 @@ properties:
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

1 entry was valid before, but not anymore? If so, justify it in the 
commit message.

> +
> +  memory-region-names:
> +    items:
> +      - const: firmware
> +      - const: pkt
> +      - const: tx-pkt
> +      - const: tx-bufid
>  
>  required:
>    - compatible
> @@ -79,6 +88,8 @@ examples:
>                       <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> -        memory-region = <&npu_binary>;
> +        memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
> +                        <&npu_txbufid>;
> +        memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid";
>        };
>      };
> 
> -- 
> 2.50.1
> 

