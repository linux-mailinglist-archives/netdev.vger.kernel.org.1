Return-Path: <netdev+bounces-186955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46938AA432F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EBD16FC77
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E061E832E;
	Wed, 30 Apr 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0+8I6l1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849571EEF9;
	Wed, 30 Apr 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994924; cv=none; b=DObCrepu5dr5K585BxqpXvAB1wq8e9SgilRaMG0aXHedfCs4+Sv8/aDan/Jh+3JCA8jnXVhStFu/Dcn7PV1XOZDfGaWnAJhMe7sKpB4uPMHwoowJ57EgYrO84S/y3Tk7g23i0vm5tmCiYj90l5re00U0bAL1DkHS+Y88AxKfqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994924; c=relaxed/simple;
	bh=2GBR4Hi5ao4ZWwIgFEL+gg6kKOZ4jKqEx1gxgiu8CSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoULwLFp4WTXH8DNwhnah0YMrGlus2xI+IACE4Kf7nyV4rqXuUm33QXI5laa1N5hHHczU8di1FzQ/FkqMBGeoWo+Avv++kv6H7qUyOQPQG+iIv08LJ2ZhRZ9eJGK5Hm3wqmgcPqpZv/L7UsGpWPpAHTjDlOQkbfeo8KJcOh7WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0+8I6l1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F98C4CEE9;
	Wed, 30 Apr 2025 06:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745994924;
	bh=2GBR4Hi5ao4ZWwIgFEL+gg6kKOZ4jKqEx1gxgiu8CSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0+8I6l1mbFthpT1IzvMzXEMZJBe9cGpkyteul4sP/gD+CZQaFXc/Prp03BYRz3Ac
	 K2ac5c2s5IgBLnnVzfufMhZR8sqYGMvXrS3qkKzH+4XiggLLbNNxaXiCJYTzNP+3O4
	 RW8Ga767/nq9NsK8m8E0qD6W8OgR1VnsL4elc4srXSbuKUBUD1ATLJxWVB90P0Abal
	 gIL6jFKZHNNoij/zg/gDVt9PvQsKxyg4LUJumX0eIXbeUZnuNH97Yo+C2TMTpQ+6D/
	 8tDtpWmqF6qWj6tC2ArxMcgV9F/1NoJOQG9uX0yucecjDVB+OgPNOS+HZYvRcRUjMo
	 fzrhEQmSw/4IQ==
Date: Wed, 30 Apr 2025 08:35:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Przywara <andre.przywara@arm.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: sram: sunxi-sram: Add A523 compatible
Message-ID: <20250430-fanatic-singing-terrier-68acbb@kuoka>
References: <20250430-01-sun55i-emac0-v3-0-6fc000bbccbd@gentoo.org>
 <20250430-01-sun55i-emac0-v3-1-6fc000bbccbd@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430-01-sun55i-emac0-v3-1-6fc000bbccbd@gentoo.org>

On Wed, Apr 30, 2025 at 01:32:03PM GMT, Yixun Lan wrote:
> The Allwinner A523 family of SoCs have their "system control" registers
> compatible to the A64 SoC, so add the new SoC specific compatible string.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml     | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


