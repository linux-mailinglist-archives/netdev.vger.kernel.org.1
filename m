Return-Path: <netdev+bounces-205073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7BAAFD065
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D76C3A3BF7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B82E0902;
	Tue,  8 Jul 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHkDMXpm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45021B199;
	Tue,  8 Jul 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991390; cv=none; b=GHj671il38FS2Zrcr9RUc+6dekQ4NvRKWgLQQZpKiTtQ/c+AP4nfEOoJU9yL8CIkLt42xd97Qu1peWvtNZGUiHCpw8w6PyTQBLB48ELwqMilA3zIUNNKxZOzGcUIWm5T5wUEKF4M2vah0v9KZUoY/kxGlMQqvja/XENJYswnvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991390; c=relaxed/simple;
	bh=MlvZZ4a52AP4+QDRvUm5hDSogr1vDDiw9bguTeqre4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NccFFEyXZOxZIcbzWgtPX1xRdUDtQnfnn+di6RswOUqM5TXZgzXxXUhT8yQ//qFQ+Zk/ff4GVLZzdZ81qtE9xgpZhfY7Z4uN+IO4pDZKlv0JYTQopDwe0QjAiJFMhD0cCjLVGnGWn8C2OQdn30M1NowpHfunpU7hdTGDf/kTcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHkDMXpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4BEC4CEED;
	Tue,  8 Jul 2025 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991390;
	bh=MlvZZ4a52AP4+QDRvUm5hDSogr1vDDiw9bguTeqre4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHkDMXpma6mUHWY1TvjLFbvGC4viBk4MR8OV9MrwZ/dTNKgT07LJpTY/NtXTCDXrZ
	 dLjEZd/2stfi0fb8CD8B0SfIzQ6PTtunA4hOdl0neEM346rL6WymLLAFpuM3/xZ6Gt
	 QO9DkRI4enn0lmHhspykXYqEdWOWahdODkBNZ0jylxzCe7tU8dP/VwqS6CGmJWrNjv
	 EAETLzByJ4JTzHbGr3uk4fmxiyz8y26a7mwrercqkQST5xUubduncf9Zx5ya/jTpl+
	 AsCll8GNnqL7PMZs3WvYXratllAkSary35yho11OgaklEU601N3wuM3bez/8naSIX0
	 JoFLA4S0GU+Ww==
Date: Tue, 8 Jul 2025 11:16:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Eric Dumazet <edumazet@google.com>,
	Andre Przywara <andre.przywara@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH RFT net-next 01/10] dt-bindings: net: sun8i-emac: Add
 A523 GMAC200 compatible
Message-ID: <175199138810.517400.11158407408233098308.robh@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
 <20250701165756.258356-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701165756.258356-2-wens@kernel.org>


On Wed, 02 Jul 2025 00:57:47 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.
> 
> Add a compatible string entry for it, and work in the requirements for
> a second clock and a power domain.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 68 ++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


