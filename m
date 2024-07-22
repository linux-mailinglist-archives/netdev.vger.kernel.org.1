Return-Path: <netdev+bounces-112438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B8939146
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343FB1F21D94
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F4116D4E2;
	Mon, 22 Jul 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBYhwxf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4E16CD1D
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660629; cv=none; b=cP9xv0h2jBmJfjk/6hg0w83BGUq5HdEOQWB1IniNoICiPU9qW9UvcqkIKxDJcybjS2nWa2oCbqDBYAaqGaA4ZfKr6DSCIh53qKDEz/Pxu4ZyIse6lrPbJxeEwuSZe74OGoMsuohjxDPJIBxfhuV+gmN9G0kpbQ5EhxVIZsjBdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660629; c=relaxed/simple;
	bh=aKtTRE0gYv4JNiizTWmrDHB3lYg1AYIXuFIN/d6fECQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr51QiRMhOweofcb2+ntywwo5yKMFVj6K0M3ej81kv1LGSJ05a8s6JEN/rUTALB9CPrpeZLWLRww1CuHrWgMyA/RVqH3Rd3+aWClu/+1GkXYuM+mXdPEoD79obOzMUMJ2yRqbK7dOODrW6wtfMAPgFQIz7fzPNtHAqCSvjpmaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBYhwxf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C00C4AF0D;
	Mon, 22 Jul 2024 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660629;
	bh=aKtTRE0gYv4JNiizTWmrDHB3lYg1AYIXuFIN/d6fECQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBYhwxf+OXuj7lAa5wXanBgAwzi6v3zM36wr+8IkiEsMghAMlGDs1ZsJPsi4wWTdD
	 9NAAdA8uJyvydGvfuhUGbftMxBhb93bc2KTdgDj+iJJaDZDqebtSzzASFrw4LwieyS
	 5YavRO9TCE1lg6rzfzA4QUE7Xs2mqbck5x8zGPwTiBYNGarB3EpGZQCUqTyDFBod4v
	 EvzkM9G9z+AtXK0WXO47TROrK7pDADMDDkTN6kUv5Z0NkWbyih9yEIyO/cGRfxCB9P
	 2kNHWc+AwOjWnTes9znZAqtlWx40T3zBvsOx4xr7PzHOBHp6h1pPiMMSbLTYWTyVj/
	 qi8DisEhnCk/Q==
Date: Mon, 22 Jul 2024 16:03:45 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Message-ID: <20240722150345.GJ715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-12-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-12-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:13PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Enable VFs to create FDIR filters from raw binary patterns.
> The corresponding processes for raw flow are added in the
> Parse / Create / Destroy stages.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c

...

> +/**
> + * ice_vc_fdir_is_raw_flow

nit: The short description is missing from the line above

> + * @proto: virtchnl protocol headers
> + *
> + * Check if the FDIR rule is raw flow (protocol agnostic flow) or not.
> + * Note that common FDIR rule must have non-zero proto->count.
> + * Thus, we choose the tunnel_level and count of proto as the indicators.
> + * If both tunnel_level and count of proto are zeros, this FDIR rule will
> + * be regarded as raw flow.
> + *
> + * Returns: true if headers describe raw flow, false otherwise.
> + */
> +static bool
> +ice_vc_fdir_is_raw_flow(struct virtchnl_proto_hdrs *proto)
> +{
> +	return (proto->tunnel_level == 0 && proto->count == 0);
> +}
> +
> +/**
> + * ice_vc_fdir_parse_raw

Likewise here.

> + * @vf: pointer to the VF info
> + * @proto: virtchnl protocol headers
> + * @conf: FDIR configuration for each filter
> + *
> + * Parse the virtual channel filter's raw flow and store it in @conf
> + *
> + * Return: 0 on success or negative errno on failure.
> + */

...

