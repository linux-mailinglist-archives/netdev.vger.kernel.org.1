Return-Path: <netdev+bounces-185350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB705A99D46
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C047A9E0C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EC135963;
	Thu, 24 Apr 2025 00:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738841CD1F;
	Thu, 24 Apr 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455758; cv=none; b=U52l+uIUCpZpsHNo493CQBnnOAUe8BlNuA7hoo68FX4/uETEwi83ARM9gpKnNvbitsuyRu63gtkHFP0Ngs8LIvWAMTp9deyYgEf27hBA+Mf1i+smxT+WJnT+CprfLVfEbjXy+/1DjKNxkPz/DKMbjzVCVP/EKZF/z+UreicCpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455758; c=relaxed/simple;
	bh=zusig3qLBleVLe8c6TOyPoq3whGUoz030vo8nxvGgXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvanfhl7RLqnQq/MlC78DTFYEMvUESEgRk3oVgkqKfUk/r5cSgQSM95PmLGcx7DyYkIFmPQgr6N0CKPMDVJajnbmliGdSwDE/Not9oabSaB945Fi+gSarWTVdLkxVbRMdCslBsY1GKy918an69eI8W7N0znwmsoE5zJlHj6WcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D641063;
	Wed, 23 Apr 2025 17:49:11 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B7DD3F59E;
	Wed, 23 Apr 2025 17:49:14 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:48:14 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
Message-ID: <20250424014814.4f1d51f0@minigeek.lan>
In-Reply-To: <20250423-01-sun55i-emac0-v1-2-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-2-46ee4c855e0a@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 22:03:23 +0800
Yixun Lan <dlan@gentoo.org> wrote:

> Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
> MAC compatible to the A64 version.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

I can confirm that the register and DMA descriptor layout in the
manual looks the same as for the A64, and the driver also works, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 7fe0352dff0f8d74a08f3f6aac5450ad685e6a08..7b6a2fde8175353621367c8d8f7a956e4aac7177 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> @@ -23,6 +23,7 @@ properties:
>                - allwinner,sun20i-d1-emac
>                - allwinner,sun50i-h6-emac
>                - allwinner,sun50i-h616-emac0
> +              - allwinner,sun55i-a523-emac0
>            - const: allwinner,sun50i-a64-emac
>  
>    reg:
> 


