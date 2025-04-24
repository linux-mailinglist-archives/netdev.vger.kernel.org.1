Return-Path: <netdev+bounces-185349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC509A99D40
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BF2446586
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3932FC23;
	Thu, 24 Apr 2025 00:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737718035;
	Thu, 24 Apr 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455672; cv=none; b=u5oCY2PzP375h89BPxoXNDWJ9/WYpXPXJQ0Wa0bD/DonlxUQ+CKkZJqtKYxvk0DxkyPIWKChUspN5k/DTbAVs902Lwvgj7RerZ8nWORLRUkUpB90Y4V3H6ttrt0fD6bQejRDdCVKrEfXiXfL92EGAqE4SmfE9NX1pLEGEfUPDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455672; c=relaxed/simple;
	bh=ok6GdHj13IWtzTTZmP7tdotz1A+I8om9d4rsjicjIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiRStp2ie2oRz4okKeBQt3ZIQpG9M8aVA3OHT8b6LxUsUZOaJ4pnpt1iIDhYf/3TwKslNKPxUYJs8a9cy16tJzM3CvVXQUrgnYLN7H5LTSPzvDLJCUYOR0srLkJ0LzCEa+C9/M4WRfaEbV7t6eAuPVG6hBrb14KhlCAB9hNmC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED101063;
	Wed, 23 Apr 2025 17:47:42 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F07A3F59E;
	Wed, 23 Apr 2025 17:47:45 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:46:41 +0100
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
Subject: Re: [PATCH 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Message-ID: <20250424014641.50c15efc@minigeek.lan>
In-Reply-To: <20250423-01-sun55i-emac0-v1-1-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-1-46ee4c855e0a@gentoo.org>
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

On Wed, 23 Apr 2025 22:03:22 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Add new compatible for A527/T527 chips which using same die
> as the A523 SoC.

this reads a bit confusing, what about:
The Allwinner A523 family of SoCs have their "system control" registers
compatible to the A64 SoC, so just add the new SoC specific compatible
string.

Regardless:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index a7236f7db4ec34d44c4e2268f76281ef8ed83189..e7f7cf72719ea884d48fff69620467ff2834913b 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -50,6 +50,7 @@ properties:
>            - enum:
>                - allwinner,sun50i-a100-system-control
>                - allwinner,sun50i-h6-system-control
> +              - allwinner,sun55i-a523-system-control
>            - const: allwinner,sun50i-a64-system-control
>  
>    reg:
> 


