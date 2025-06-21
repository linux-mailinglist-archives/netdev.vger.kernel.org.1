Return-Path: <netdev+bounces-199953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1196AE286C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682A5189A06C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BAA1EDA3A;
	Sat, 21 Jun 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUcwW4WG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113891DED42;
	Sat, 21 Jun 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499570; cv=none; b=lGlawxDIHmsJZ16+LHgjTGuNAfxZVDiY2/KmSl+XxI/igxhU4lWGYMoB16GIJw+0+9P4QK1QsXJeXzMeP2DngYKI+TAC+GEMab9uuJZ+YZPYOvp7I3jchUQiwfd4JIwNZZBISHvXm7CMC5fxeBgnhriVxbVaBFscx2J/EmmzFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499570; c=relaxed/simple;
	bh=0as3/AxkSush5g7M4Ma1/6ifwK1z3Cyl7OStmn8JdFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2f31iN60YP9dBbLq2L0lxHb5XGurm7PAI7gCXOF9MBY4wexwrefXwm1MpArx3bRtPxyz11V9sUHw0P7hkI/1AMwyvrjvX4M0lGvLxHj5Z2bPfYp/37KHzz9NJEfDnp9buf0WGj0HhguYcxyXlHJIUCuYHuzQQe/jTF9G/c/3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUcwW4WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404BFC4CEE7;
	Sat, 21 Jun 2025 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750499569;
	bh=0as3/AxkSush5g7M4Ma1/6ifwK1z3Cyl7OStmn8JdFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUcwW4WGImpJRWd/yXvwaFPWZX588CBP93zUjt3gSfYl84eu0jsj6RjzTWTqsY34m
	 MwJPWOJfitwlvU8sBA3L/IQKJQgoAW0y049UV5XLPdcZwpcKYDZVtKaw/p6BWcmzqf
	 6iw+w0CwDsdmohGvpbKqnBClJGr8QLaEzTVQ2/fOOzJSk6FUm+Gh8axNjab7V4thh4
	 RF8xYZoV0Dcatrc6bcASIAsQGuQgY8VcyOuzS6mCcc+e7q5zMRBTLB8dWuvrDx/Cye
	 Zuwu9KiVEWkeL+N8zUAxuMjv6AjtQ8QVzz+08579IzaTknhg39KRMqhRzg+CUHzhaw
	 4QtNBLWKFaLJA==
Date: Sat, 21 Jun 2025 10:52:45 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 1/3] net: enetc: change the statistics of ring
 to unsigned long type
Message-ID: <20250621095245.GA71935@horms.kernel.org>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620102140.2020008-2-wei.fang@nxp.com>

On Fri, Jun 20, 2025 at 06:21:38PM +0800, Wei Fang wrote:
> The statistics of the ring are all unsigned int type, so the statistics
> will overflow quickly under heavy traffic. In addition, the statistics
> of struct net_device_stats are obtained from struct enetc_ring_stats,
> but the statistics of net_device_stats are all unsigned long type.
> Considering these two factors, the statistics of enetc_ring_stats are
> all changed to unsigned long type.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.h | 22 ++++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 872d2cbd088b..62e8ee4d2f04 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -96,17 +96,17 @@ struct enetc_rx_swbd {
>  #define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
>  
>  struct enetc_ring_stats {
> -	unsigned int packets;
> -	unsigned int bytes;
> -	unsigned int rx_alloc_errs;
> -	unsigned int xdp_drops;
> -	unsigned int xdp_tx;
> -	unsigned int xdp_tx_drops;
> -	unsigned int xdp_redirect;
> -	unsigned int xdp_redirect_failures;
> -	unsigned int recycles;
> -	unsigned int recycle_failures;
> -	unsigned int win_drop;
> +	unsigned long packets;
> +	unsigned long bytes;
> +	unsigned long rx_alloc_errs;
> +	unsigned long xdp_drops;
> +	unsigned long xdp_tx;
> +	unsigned long xdp_tx_drops;
> +	unsigned long xdp_redirect;
> +	unsigned long xdp_redirect_failures;
> +	unsigned long recycles;
> +	unsigned long recycle_failures;
> +	unsigned long win_drop;
>  };

Hi Wei fang,

If the desire is for an unsigned 64 bit integer, then
I think either u64 or unsigned long long would be good choices.

unsigned long may be 64bit or 32bit depending on the platform.

