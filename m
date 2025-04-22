Return-Path: <netdev+bounces-184671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51EA96CCC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05D517C174
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356C28A3F3;
	Tue, 22 Apr 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONrsyMpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C28280A38;
	Tue, 22 Apr 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328516; cv=none; b=P+6HMVWFO7WsNYDuOYmCtxzCqHPSjlQVYJVNELNeLw/SWZNDxAQzst+WwE5qGo8kpxcesSFaE9zsETPAFvpVmHQJVBGD/Zvh3EybDlyv70kldJ4AupfinOHUok9CA7X0cKBM5bfwkqAHcMlY1K4PNDyxHWJMrsChEO//v59IKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328516; c=relaxed/simple;
	bh=dLXcRB/G/Ji0x4++XcAw2dvj/d2F8U/NvXO42ZHV6iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnAQXulX93unPxYyHEp2D+0mu2HaidUbVClJ18OoSUIhxotNFDU4l1r3vCF4MixLw8hUQC79nK8HNV9/qXHUC9znd5JGaLcwzGGJftwiCCGehO/4tVIE2qFuaI2g2HtxwxH7PpViJkAS7RrB3nfk3D4mx/ku1KVLoxVGtwaP5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONrsyMpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80EAC4CEE9;
	Tue, 22 Apr 2025 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328516;
	bh=dLXcRB/G/Ji0x4++XcAw2dvj/d2F8U/NvXO42ZHV6iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONrsyMpx9rGFRyJxq00IrqarfqVDTXRBblDWpY/BLB1HoBfjLC6O6CtmVDz43QWaN
	 9Rp8VOKYydLusWySu9z4gE5Q7b6bzrdxZpg44FU6ioCvT4SknOblZnk0FsiJQ0YEtm
	 hNEJi8ILkzsHDPCo/uOf5N+pQAM3qGc9nHQU1hV0OoaoXiMZxdtnZC7UER1emU4zf0
	 76OvRfs756wB1NVa0L2szb/l+/i0mAWsG12XU7MCTXjpEsmMO96gw6fyOub77EHWzk
	 KyrgroZTmNTpKKaLKrn9RT3BrLYr2Xs+afiZHTqiBLf/Q34JqemnqIJRzL3MajTVYG
	 qGzbyko82Xg7A==
Date: Tue, 22 Apr 2025 14:28:31 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com,
	Andrew Lunn <andrew@lunn.ch>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Message-ID: <20250422132831.GH2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-4-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417085659.5740-4-justinlai0215@realtek.com>

+ David Laight

On Thu, Apr 17, 2025 at 04:56:59PM +0800, Justin Lai wrote:
> Fix a type error in min_t.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 55b8d3666153..bc856fb3d6f3 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
>  	u8 msb, time_count, time_unit;
>  	u16 int_miti;
>  
> -	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
> +	time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);

Hi Justin, Andrew, David, all,

I may be on the wrong track here, but near the top of minmax.h I see:

/*
 * min()/max()/clamp() macros must accomplish several things:
 *
 * - Avoid multiple evaluations of the arguments (so side-effects like
 *   "x++" happen only once) when non-constant.
 * - Perform signed v unsigned type-checking (to generate compile
 *   errors instead of nasty runtime surprises).
 * - Unsigned char/short are always promoted to signed int and can be
 *   compared against signed or unsigned arguments.
 * - Unsigned arguments can be compared against non-negative signed constants.
 * - Comparison of a signed argument against an unsigned constant fails
 *   even if the constant is below __INT_MAX__ and could be cast to int.
 */

So, considering the 2nd last point, I think we can simply use min()
both above and below. Which would avoid the possibility of
casting to the wrong type again in future.

Also, aside from which call is correct. Please add some colour
to the commit message describing why this is a bug if it is
to be treated as a fix for net rather than a clean-up for net-next.

>  
>  	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
>  		msb = fls(time_us);
> @@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
>  	u8 msb, pkt_num_count, pkt_num_unit;
>  	u16 int_miti;
>  
> -	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> +	pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
>  
>  	if (pkt_num > 60) {
>  		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
> -- 
> 2.34.1
> 

