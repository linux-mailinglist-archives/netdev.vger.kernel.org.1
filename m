Return-Path: <netdev+bounces-80473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBF87F005
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555811C21173
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1556442;
	Mon, 18 Mar 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDmCrTsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D555E63
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788164; cv=none; b=gg/YcLC8dRf6aPOEQUVlMcmdWgsnR3PNRPvZubVFfgLeIBTDmSMpOyRcmI1CMY1N7/qp0pcUMz+6x2VTQZz91xhI+ls9co0HeXDzCNaOwamzi5P5428XmUuEO0LJtHB56jlELLEl5/5wA9E1Sb7ObPMVtjUyzxj8cL1bFjjzCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788164; c=relaxed/simple;
	bh=kYvnPw14h8YwaEiRVbmaKUb01aCbhWa/d3miwMevjjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+yNjijLA3zQrrIEqlFnHWjEZimqruOuAI1JBp/h43wssW93lY0NZ90KOw7HYEz2km/t/Gqy4kvU16doN1CQkDvi5j+ImkYQyCUcooEWDfCh27fBYDYLRPRDz7ycDW2971SFi0PUtx6YF53G496s83+gC8jltg5G0AS/gzrXIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDmCrTsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01EC433F1;
	Mon, 18 Mar 2024 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710788163;
	bh=kYvnPw14h8YwaEiRVbmaKUb01aCbhWa/d3miwMevjjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDmCrTskdIiTzZR1A9vrrHmKD2qUtg/MwBGgCcND7gvMiXbKsNPRDajX5L5J+Evvj
	 c4NQDzAc1rOzd4sxeYQYX64MIl3ARqhxyMOcBh3TCK297FKAn7lr4O3LU2vNzIzS19
	 CaBjqT8EEW6+0Ow7XxrcFb7Wa1ayZjRs82dsO6Kp3GXjoxQyY4LME+iUvdeal5Y9ae
	 nd4gvC0kJtAA3qMUUXJ+XxEISdG1yejZCPUPjcmFedxmfqblQQfgmvVVeiM0c3wVut
	 N0/8N8gEH54/3O+bsya6N+2rdYfuXSX9cgQ+dqrJf9PjdnKNbJqmpJU780Ui+BgKJI
	 06QYZowBGDGzQ==
Date: Mon, 18 Mar 2024 18:55:59 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [iwl-net v1] ice: tc: do default match on all profiles
Message-ID: <20240318185559.GF1623@kernel.org>
References: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>

On Tue, Mar 12, 2024 at 11:52:59AM +0100, Michal Swiatkowski wrote:
> A simple non-tunnel rule (e.g. matching only on destination MAC) in
> hardware will be hit only if the packet isn't a tunnel. In software
> execution of the same command, the rule will match both tunnel and
> non-tunnel packets.
> 
> Change the hardware behaviour to match tunnel and non-tunnel packets in
> this case. Do this by considering all profiles when adding non-tunnel rule
> (rule not added on tunnel, or not redirecting to tunnel).
> 
> Example command:
> tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
> 	egress redirect dev pr0
> 
> It should match also tunneled packets, the same as command with skip_hw
> will do in software.
> 
> Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


