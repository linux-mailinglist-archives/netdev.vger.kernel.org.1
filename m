Return-Path: <netdev+bounces-155492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23734A0282F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CA160A38
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50991DDC1A;
	Mon,  6 Jan 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJtJYgDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109D1DB951
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174347; cv=none; b=uoduxgucip+k8psj/87IWjlVVMCkmlqNHKw3WgTjpvqmD0CqW8yxkm+mY4nCesymXdu7/KkkDvnfTNeXASoBPaOoyAW/nL59Zqqc0G2+dmZDhux8rFS6txIy1NtJzJ0nsxaJXI8E2BU7ZDTMHOS2d0cxFVqbAkfaGs5TuZWyDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174347; c=relaxed/simple;
	bh=ViUj5vxDy9vA17JFA/G+NzO8PAPLFddSdnNSeiQrLMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMQNkFPr/+/OuHe9dxGX+Dzw5Veec5RaUtAllW+/0wmMnhFofjJhmRG6tfHILONP8PkIMxaxJCI8KgeIeESGgG202vJiQwY1g1AAmzVp78eeT5fz2vivKGoLQEbv/9p19r5nV67+l9CpF83Uvvsf9dkVVypIMpxJI9tGI6DuJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJtJYgDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2190BC4CED2;
	Mon,  6 Jan 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736174347;
	bh=ViUj5vxDy9vA17JFA/G+NzO8PAPLFddSdnNSeiQrLMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJtJYgDa+87K+ib6EXxI4AdurM7hT9IYUhpqrNnrovUjqtm9a14QenP76rCGAdBi/
	 E860HObcGBXunCpA8Q4eE3QgKaM7UWcYb4hW6qXPYo6e6qFaF2TSL5ed4T0scU8zvU
	 lTd/VyiVmxXeOU8MAkNP9KOPZeIaQ5yfo3altCOEmmrEiD3cTgwxIvw26p1b68+nTB
	 IYnI32aMb4Agp0sxPkup9uaIf0ipPM3NBIkRrEr7Gv6TbBuWOpx2Ptf4qQ2xM+AHTK
	 c1P/W/GZOEexA7uQ9dsXM7Dp0QqlWOjGbyc+DUGh2YRP8g0UOGjaKtycJhLUD4eqZJ
	 1EV9bFzstcJGQ==
Date: Mon, 6 Jan 2025 14:39:04 +0000
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix switchdev slow-path in LAG
Message-ID: <20250106143904.GA33144@kernel.org>
References: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102190751.7691-2-marcin.szycik@linux.intel.com>

On Thu, Jan 02, 2025 at 08:07:52PM +0100, Marcin Szycik wrote:
> Ever since removing switchdev control VSI and using PF for port
> representor Tx/Rx, switchdev slow-path has been working improperly after
> failover in SR-IOV LAG. LAG assumes that the first uplink to be added to
> the aggregate will own VFs and have switchdev configured. After
> failing-over to the other uplink, representors are still configured to
> Tx through the uplink they are set up on, which fails because that
> uplink is now down.
> 
> On failover, update all PRs on primary uplink to use the currently
> active uplink for Tx. Call netif_keep_dst(), as the secondary uplink
> might not be in switchdev mode. Also make sure to call
> ice_eswitch_set_target_vsi() if uplink is in LAG.
> 
> On the Rx path, representors are already working properly, because
> default Tx from VFs is set to PF owning the eswitch. After failover the
> same PF is receiving traffic from VFs, even though link is down.
> 
> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


