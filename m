Return-Path: <netdev+bounces-114455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF6942A58
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A64B23217
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE81AB50E;
	Wed, 31 Jul 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSYW7iBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73F1AAE38
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417850; cv=none; b=OXNkpkjEPP4j477S7+2KcG7xoQ7OKV+FMekMrXPkUfbJkIlvaXsfYGyALvlpkTS/AwDIOete6MGyQVVncBpqHVvxmN+h1Jwp0AthNqLXixwOh13PE7Fhei+cWl/QrvPwe6gnwL444xKWe9KiVaN9GnSynlfcKXCEKVSr0YIZ7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417850; c=relaxed/simple;
	bh=ZLB+X0MuclA0/c4BIX3Y2yEJHGOn3Y6dSl1qQ62XHiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjSLf73Lm06Vf6FcmV0hcTVlgMR4OFUvmBrx+3j6MamLhLYENVWNGJxgup8BiwhfLQC6uUWklgmUmcATK/F3Pjnx0uMU1MqRMod+PRTqxDG2psGcz4joYdqlFmkwLf4UGG1GcEL5zJqZSn2x9viCWFvRBFPpXyuHP9B3oYGfF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSYW7iBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A131FC116B1;
	Wed, 31 Jul 2024 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722417850;
	bh=ZLB+X0MuclA0/c4BIX3Y2yEJHGOn3Y6dSl1qQ62XHiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSYW7iBlRnEqzDG0tJwGwxiWPMeA8TUY0/VhZ0eR7Px5XINLNomp/mGU/gPfWY1Bd
	 nJdF33tEJfygnG/grPpj9v+tEA0fVV/kY4fkiZ+O/AqkgQN/kLaSrIletXuGn7Y20l
	 EyEee+CFJZEwEG85smmKNV/DZnUbgQi6BUdCLSct002wKPDKueSFJI01T5ZhbGqNCl
	 OHKgXdBlc+mnvyVekCb9CaItq5P6baFSGWv7MwlAhNBAlqVsn2RfZ8uMS7YUArBYvs
	 pnHv+tMenkHKUXSzH8v8SnsJIE3p+C9It0jdg8BpBwKAML8283ChX39qhc1C7DTSUX
	 3bpnBwVM2UP+w==
Date: Wed, 31 Jul 2024 10:24:06 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH iwl-next] ice: Implement ethtool reset support
Message-ID: <20240731092406.GQ1967603@kernel.org>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730105121.78985-1-wojciech.drewek@intel.com>

On Tue, Jul 30, 2024 at 12:51:21PM +0200, Wojciech Drewek wrote:
> Enable ethtool reset support. Each ethtool reset
> type is mapped to the CVL reset type:
> ETH_RESET_MAC - ICE_RESET_CORER
> ETH_RESET_ALL - ICE_RESET_GLOBR
> ETH_RESET_DEDICATED - ICE_RESET_PFR
> 
> Multiple reset flags are not supported.
> Calling any reset type on port representor triggers VF reset.
> 
> Command example:
> GLOBR:
> $ ethtool --reset enp1s0f0np0 all
> CORER:
> $ ethtool --reset enp1s0f0np0 mac
> PFR:
> $ ethtool --reset enp1s0f0np0 dedicated
> VF reset:
> $ ethtool --reset $port_representor mac
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 64 ++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 39d2652c3ee1..00b8ac3f1dff 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -4794,6 +4794,68 @@ static void ice_get_ts_stats(struct net_device *netdev,
>  	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
>  }
>  
> +/**
> + * ice_ethtool_reset - triggers a given type of reset
> + * @dev: network interface device structure
> + * @flags: set of reset flags
> + *
> + * Note that multiple reset flags are not supported
> + */
> +static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
> +{

nit: Please include a "Return:" or "Returns:" section in the Kernel doc
     of new functions that return a value.
     (i.e. also for ice_repr_ethtool_reset)

     Flagged by ./scripts/kernel-doc -none -Wall

...

