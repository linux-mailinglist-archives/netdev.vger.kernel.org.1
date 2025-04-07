Return-Path: <netdev+bounces-179662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4FA7E08A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA78A17E873
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C621C2443;
	Mon,  7 Apr 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sktWr8vf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16491B87CE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034566; cv=none; b=AtphIG6g22sEjmypOrXenixPJsKCg4eq5KYCEExCegwU8+/IwVqwfMC/Ty+Gku9ol9uu1H6jUXAKf4VBZHmRYfeJC0MA/bz46ylimzum7hv/BECx52FkIZe3EcoUH5CFh2ytpxPVoCepGK1hEg8RBSC8UBE+cLQdvS9Hh2jKh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034566; c=relaxed/simple;
	bh=fR7PBr6tXm57kWHmOH6/mTwC1BYD8urfsW/j3fAdi+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5IASY7O7PiYWe1e6xCXTvyoPOSKti5KPtXP/mJFlgA3gPfK+XIc5rdw9UFtKRUbQId1fDYlWgCYtUU6tIB5fJKXxfJdU/7QXa8o1czqOR+mkMwmQ1cAJbXXHAz0Gyzq1lDB5o4p0ZIj4j8/6H9HI7hLwq6t3842y7MMAA1FvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sktWr8vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9351BC4CEDD;
	Mon,  7 Apr 2025 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744034566;
	bh=fR7PBr6tXm57kWHmOH6/mTwC1BYD8urfsW/j3fAdi+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sktWr8vfZzwR4iCxq07Y3isgrQymVdA1eK1vTdZIH01p+zpcGhsWAlsZSdD5jTfWC
	 r3BMISYilhgVeeSnQMhpE9ENTOKOR7cCRU04HRN1htlhrvAbdEVdpUu2TsG5PHgvAy
	 BjKKzoIo2LR9men2Rmi4Vfdxe6MnjwX2pmGtO1871I2fhqymPGKEbnwvplma9RIK9n
	 UzRo7DVEtEk8vvEqVOWswqzhd9sO/QGeheGfjFjO/4ij+mrj5yq5hSpMccZYTnMaLd
	 hiT8AVXpXT8BLnA5FTd3C/1QorD/mTFFIqCFyzjEqbyzxquLSvBPxncsHWO2NIzZwm
	 uzVo6vxjg9Fhw==
Date: Mon, 7 Apr 2025 15:02:42 +0100
From: Simon Horman <horms@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH iwl-net v2] ice: Check VF VSI Pointer Value in
 ice_vc_add_fdir_fltr()
Message-ID: <20250407140242.GK395307@horms.kernel.org>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>

On Tue, Mar 25, 2025 at 10:01:49AM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
> pointer values"), we need to perform a null pointer check on the return
> value of ice_get_vf_vsi() before using it.
> 
> v2: Add "iwl-net" to the subject and modify the name format.
> 
> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> index 14e3f0f89c78..53bad68e3f38 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
>  	dev = ice_pf_to_dev(pf);
>  	vf_vsi = ice_get_vf_vsi(vf);
>  

nit, but not need to repost because of this: it's seems nicer
not to have not to have a blank line here. And instead, if one is
really wanted, put it above the ice_get_vf_vsi() line.

> +	if (!vf_vsi) {
> +		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +		goto err_exit;
> +	}
> +
>  #define ICE_VF_MAX_FDIR_FILTERS	128
>  	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>  	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
> -- 
> 2.27.0
> 
> 

