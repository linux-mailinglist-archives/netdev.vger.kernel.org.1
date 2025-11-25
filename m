Return-Path: <netdev+bounces-241479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CEAC84689
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1999E4E2634
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EB1A3160;
	Tue, 25 Nov 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY21c5SC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEC185B48
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065762; cv=none; b=uhW/l4ZxffW82FtQ4YOwNeoU8lAa5iH2JL0G+mmEguDH4nI2SBA60Nl+AJI3S7uNz5e3aiHaYvtVJzg26UwJtzIzbtdOU1cON51WnyIS/Di6O3ry4VdqSDgmGtutWT3HMxzQmr0u4v1qjWfzjzBuhtmm5q40u/Zw5KAna2dVxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065762; c=relaxed/simple;
	bh=QVNvIfUz7nh22wuooB424hyrwiQk6yRN/L7qvJoCRU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaitHAxX7385nfGiXhD1DHEx6T535YpVBhWyHCuA+FS3+9WgPSLeLeqGGDQRtxA9WlTAv2qNpaObwfXtn1nix4xpugg6Q0PFSUorZ3VPlbT+I2fL/gXzrg2lnp83u6DQRcxUeSbWarCSubsoAAjnGtaCTJtizOOa3x9jUeVE8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY21c5SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A596C4CEF1;
	Tue, 25 Nov 2025 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065762;
	bh=QVNvIfUz7nh22wuooB424hyrwiQk6yRN/L7qvJoCRU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY21c5SCI/cHhErH77J/QwEGqZMiviEDLf8S2MRwos99LtDy38QifbLC2Qghfo+b7
	 xcZvIxj5zkNnbx1aMvwS9t8hDzDamlVjcIi6VOYwGhYgsUnlxEYuc4nsKIyTcv745J
	 m4ZyNAc+hivwfMyIsnff2Ettq8Vw2qcYimq3/F5nDc54kjRpYD03jLEs/uQMilBaNP
	 Qd4B1WV5RvGQi83bkL7SHHN85JyAknaAfbblkXCd7ASLIkia9Ldt7L2ua+mJRkb3k8
	 /N5rwWY9IH4e6l7Ch/Rt9TVmNDXGCvme53IhY7/1tmT/qJva9zl7FZxCy5G8mwQPk+
	 kDkdJE+oCvR4A==
Date: Tue, 25 Nov 2025 10:15:58 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 1/6] ice: initialize ring_stats->syncp
Message-ID: <aSWB3gsh4KpDZae9@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:41PM -0800, Jacob Keller wrote:
> The u64_stats_sync structure is empty on 64-bit systems. However, on 32-bit
> systems it contains a seqcount_t which needs to be initialized. While the
> memory is zero-initialized, a lack of u64_stats_init means that lockdep
> won't get initialized properly. Fix this by adding u64_stats_init() calls
> to the rings just after allocation.
> 
> Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")

I think that either this patch should be routed via net.  Or the Fixes tag
should be removed, and optionally something about commit 2b245cb29421
("ice: Implement transmit and NAPI support") included in the commit message
above the tags.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 44f3c2bab308..116a4f4ef91d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -400,7 +400,10 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
>  			if (!ring_stats)
>  				goto err_out;
>  
> +			u64_stats_init(&ring_stats->syncp);
> +
>  			WRITE_ONCE(tx_ring_stats[i], ring_stats);
> +

nit: perhaps adding this blank line is unintentional.

>  		}
>  
>  		ring->ring_stats = ring_stats;
> @@ -419,6 +422,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
>  			if (!ring_stats)
>  				goto err_out;
>  
> +			u64_stats_init(&ring_stats->syncp);
> +
>  			WRITE_ONCE(rx_ring_stats[i], ring_stats);
>  		}

The above comments not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


