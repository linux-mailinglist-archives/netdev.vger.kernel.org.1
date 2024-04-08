Return-Path: <netdev+bounces-85769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98B89C11E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BF7282AB0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB97F7D0;
	Mon,  8 Apr 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXwba+uT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6887F7C6
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581976; cv=none; b=o75Q+8kOKy/V5Jmzr5VQ+Sqr6ZVVp8B6fAksvFxXdJrZIf0vGJFXK0Lnq84JGleGz6zRkoqqtrC7vKVG9Jt1YX07YnLjdoZE6ZGYPeXq27cHnDceokuaVNU7H5VNsj1kpjg4la2ewULy7aJejaetrgHdeLyISew3luh59ER1jiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581976; c=relaxed/simple;
	bh=Sb6bM+qlkD/qFXaxa2HUiMg6jcQjS83Bd8qYCQGG/tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcu4j/vbgji1+2vN7AJFAqbZbYdtzmCRoHiYA1Ddm28QvJAB4M0YstRis+BrKwshIpQGerG1FWwrnbddBTxBT6MVjGYFbkPYZxNfCwtpoaPRYZz2PigUg1IoUEDd2LNYmE/geHE8WiiDGNG0e8BKlquhFznw2kotGUN1GmdDx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXwba+uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57092C433F1;
	Mon,  8 Apr 2024 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581976;
	bh=Sb6bM+qlkD/qFXaxa2HUiMg6jcQjS83Bd8qYCQGG/tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXwba+uT9CYQgfg1Be3M17w16+DIAF79SzalO2D8S4E9z6iYOvD3wRqj1/8sfYw44
	 n+ov7noONlEkD9QPf0v9NqqricYU622QI5eUl4z+D+ISPAzrg32IekEI8PSWmvQIWY
	 wWdu+sVgjk6FQUNoATGvxmUEIyeaT+8i+qhH++4Eh8W+WbUfTKfQITH9udhKR7w7XB
	 /PPpWQiMmDb+SyNUsotDaGC6y9penKyNwdFNrvE7gVzNO4gR6S7VH8jr51DGx+TqMH
	 p3hkx2tCK6t7Q2YkJ3KU13iPowjqdvdIQwWOo3/ZmlyXGXti0vZQzfaprGOqSKejLI
	 EpBTZCJCJCbnQ==
Date: Mon, 8 Apr 2024 14:12:51 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com, Tal Gilboa <talgi@nvidia.com>
Subject: Re: [PATCH net-next v4 3/4] dim: introduce a specific dim profile
 for better latency
Message-ID: <20240408131251.GD26556@kernel.org>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-4-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405081547.20676-4-louis.peens@corigine.com>

+ Tal Gilboa

On Fri, Apr 05, 2024 at 10:15:46AM +0200, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The current profile is not well-adaptive to NFP NICs in
> terms of latency, so introduce a specific profile for better
> latency.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Noting that this is consistent of review of v1 [1], this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/all/20240131085426.45374-3-louis.peens@corigine.com/

> ---
>  include/linux/dim.h |  2 ++
>  lib/dim/net_dim.c   | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/dim.h b/include/linux/dim.h
> index f343bc9aa2ec..edd6d7bceb28 100644
> --- a/include/linux/dim.h
> +++ b/include/linux/dim.h
> @@ -119,11 +119,13 @@ struct dim {
>   *
>   * @DIM_CQ_PERIOD_MODE_START_FROM_EQE: Start counting from EQE
>   * @DIM_CQ_PERIOD_MODE_START_FROM_CQE: Start counting from CQE (implies timer reset)
> + * @DIM_CQ_PERIOD_MODE_SPECIFIC_0: Specific mode to improve latency
>   * @DIM_CQ_PERIOD_NUM_MODES: Number of modes
>   */
>  enum dim_cq_period_mode {
>  	DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
>  	DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
> +	DIM_CQ_PERIOD_MODE_SPECIFIC_0 = 0x2,
>  	DIM_CQ_PERIOD_NUM_MODES
>  };
>  
> diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
> index 4e32f7aaac86..2b5dccb6242c 100644
> --- a/lib/dim/net_dim.c
> +++ b/lib/dim/net_dim.c
> @@ -33,6 +33,14 @@
>  	{.usec = 64, .pkts = 64,}               \
>  }
>  
> +#define NET_DIM_RX_SPECIFIC_0_PROFILES { \
> +	{.usec = 0,   .pkts = 1,},   \
> +	{.usec = 4,   .pkts = 32,},  \
> +	{.usec = 64,  .pkts = 64,},  \
> +	{.usec = 128, .pkts = 256,}, \
> +	{.usec = 256, .pkts = 256,}  \
> +}
> +
>  #define NET_DIM_TX_EQE_PROFILES { \
>  	{.usec = 1,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
>  	{.usec = 8,   .pkts = NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,},  \
> @@ -49,16 +57,26 @@
>  	{.usec = 64, .pkts = 32,}   \
>  }
>  
> +#define NET_DIM_TX_SPECIFIC_0_PROFILES { \
> +	{.usec = 0,   .pkts = 1,},   \
> +	{.usec = 4,   .pkts = 16,},  \
> +	{.usec = 32,  .pkts = 64,},  \
> +	{.usec = 64,  .pkts = 128,}, \
> +	{.usec = 128, .pkts = 128,}  \
> +}
> +
>  static const struct dim_cq_moder
>  rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
>  	NET_DIM_RX_EQE_PROFILES,
>  	NET_DIM_RX_CQE_PROFILES,
> +	NET_DIM_RX_SPECIFIC_0_PROFILES,
>  };
>  
>  static const struct dim_cq_moder
>  tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
>  	NET_DIM_TX_EQE_PROFILES,
>  	NET_DIM_TX_CQE_PROFILES,
> +	NET_DIM_TX_SPECIFIC_0_PROFILES,
>  };
>  
>  struct dim_cq_moder
> -- 
> 2.34.1
> 
> 

