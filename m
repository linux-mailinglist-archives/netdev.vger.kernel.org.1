Return-Path: <netdev+bounces-223212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54355B58540
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213144867BC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB8281509;
	Mon, 15 Sep 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI+9acgi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBF280334;
	Mon, 15 Sep 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964208; cv=none; b=kLG+gDMq+c0BFBB6HjoR6D1NxdUnP2YPHd/YVgn7M34OM8n1wwOJkjepIRnejz8aq8nM58wh8aMS+ULKcgL2CxGv/s1tfOPsGuSmMOyQ0LXbUXwfARqAQpAXzWWMJ3B0gT4vUFRfo9rv/BQC+Q9AIGVho53jjE6IRL4+4yt8Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964208; c=relaxed/simple;
	bh=0wgdASjQ8+qDJ79gn/NuVPOeE4bNUVFLO8UtfwxeGVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCdHg9zo/eRSyeFi45tG9i1uYXlYVHx+Hr46C0KlO+1yvF8dg1gtNUungt+zctitJ3lmqHCTb2T8ey2Y6qQt81uww0vdEMBVfNpSc69gr8Ow1UcFYgSiiLBhxccLQ00qEZA2Az1xi2+QXWWWJyspfmUAncuvE5xeMPfV21lp5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI+9acgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81A3C4CEF7;
	Mon, 15 Sep 2025 19:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757964207;
	bh=0wgdASjQ8+qDJ79gn/NuVPOeE4bNUVFLO8UtfwxeGVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI+9acgiP6WXqQyvH3870s+EQuPE3FRAzxwJsd0aa6K04KAM/Mt/17qm2MtmTVOsz
	 3OZQJkwpbm2815yS21+T4NM9Ovp5xQfhEtH7sstIkx/65axdj5gaAz/pT6uzEjOJH2
	 rXFDqdpyrvmZLrBcl9c72pYJg8wY2x4eIrw46PB2s0nt5uQt7z7QW71UqTno/gQJ0E
	 P75SbBo4i8eKKqCLxOxEKBYPTkZFbHTeMT7pBspFrHWjYiVTi529rRxtAWfxyQ/Sfp
	 V7999w8IbTuEcxNseeyUHX/7aq4xSgQwP4p6jjc6yJ2ljNnbKFlcDDMo9F898K/oI6
	 CovY+eYXxaOrg==
Date: Mon, 15 Sep 2025 14:23:26 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v6 1/6] dt-bindings: net: sun8i-emac: Add A523
 GMAC200 compatible
Message-ID: <20250915192326.GA3089483-robh@kernel.org>
References: <20250913101349.3932677-1-wens@kernel.org>
 <20250913101349.3932677-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913101349.3932677-2-wens@kernel.org>

On Sat, Sep 13, 2025 at 06:13:44PM +0800, Chen-Yu Tsai wrote:
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
> Changes since v4:
> - Move clock-names list to main schema (Rob)
> Changes since v2:
> - Added "select" to avoid matching against all dwmac entries
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../net/allwinner,sun8i-a83t-emac.yaml        | 95 ++++++++++++++++++-
>  1 file changed, 93 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

