Return-Path: <netdev+bounces-103590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD2908BF2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E4C2877DE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CD01991D2;
	Fri, 14 Jun 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8uwoXuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8F1991C3
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369016; cv=none; b=W3tIcUUOvP6ZhPRH4WX3jg+kx39GgEULQ7W/mvS8w0AJ24aRzDO1vajqgtqKITv0Bh7BGcqaBl35sFMaQOga/GLqIFeCu6uewlL2MdnqqxSSGs7ck2+bVJtdvxo1AvOWKdXFM5U0tlAoiM3s6UaVwIEzzg+pFNdvJ9Aemc41Occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369016; c=relaxed/simple;
	bh=uDzve8H3dCkfmELZWZLzl/N50oTljXg6cmrTDCRiAg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm5E7+vI7XzbtcDlMHEIr8ttuupuuGS+3VeXyW5b0BQVgBtw/KOuF7FEraS4qdzX2l0z7qF8XlNgqbl7uG7nDJfnAw3m/AAHSXeLtq3sLOZGpmWV1XM+b53wQt0+pOuf7/13mn9aMD7l1XUwD+XkPp5PoFeEBxa2NnwZo/MSnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8uwoXuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C4FC2BD10;
	Fri, 14 Jun 2024 12:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718369016;
	bh=uDzve8H3dCkfmELZWZLzl/N50oTljXg6cmrTDCRiAg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8uwoXucf1fwVkVi307nyKhhdTzCq4AHD5QRmjBGM3iLnf9eFT0mxyP7ZuK9i+/jO
	 S1HGT3eRqly1Xt5Ce30MYr49SiqoVLMRyLphbrxpN9dLwQRuzUnM9mbU+vr8xLU7P/
	 j6dfw/oZzIBk96b3E0f/s8xci/fbDlZrheQYMqqTTfZpcOjYqTn8a/aQlYLDw+JpKU
	 14BdAW8XL3EzB+xh84p5NnStwqIhTfMH5O7HiVKIQoQcvwfbb/WWSxI25UZhmhq8Ma
	 7VKOp5gmIDGzLHv2S62Ozqv9UF6tzFjki4bIJxm8nwEpnUJjweI7fRRhX6gyZmaJBh
	 ugRLPSJ35DtSQ==
Date: Fri, 14 Jun 2024 13:43:31 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 3/4] ice: move VSI configuration outside repr setup
Message-ID: <20240614124331.GL8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-4-michal.swiatkowski@linux.intel.com>

On Mon, Jun 10, 2024 at 09:44:33AM +0200, Michal Swiatkowski wrote:
> It is needed because subfunction port representor shouldn't configure
> the source VSI during representor creation.
> 
> Move the code to separate function and call it only in case the VF port
> representor is being created.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Hi Michal,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 55 ++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 ++++
>  drivers/net/ethernet/intel/ice/ice_repr.c    |  7 +++
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 7b57a6561a5a..3f73f46111fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -117,17 +117,10 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>  	struct ice_vsi *vsi = repr->src_vsi;
>  	struct metadata_dst *dst;
>  
> -	ice_remove_vsi_fltr(&pf->hw, vsi->idx);
>  	repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
>  				       GFP_KERNEL);
>  	if (!repr->dst)
> -		goto err_add_mac_fltr;
> -
> -	if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof))
> -		goto err_dst_free;
> -
> -	if (ice_vsi_add_vlan_zero(vsi))
> -		goto err_update_security;
> +		return -ENOMEM;
>  
>  	netif_keep_dst(uplink_vsi->netdev);
>  
> @@ -136,16 +129,48 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
>  	dst->u.port_info.lower_dev = uplink_vsi->netdev;
>  
>  	return 0;
> +}
>  
> -err_update_security:
> +/**
> + * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
> + * @vsi: VSI structure of representee
> + * @mac: representee MAC
> + *
> + * Return: 0 on success, non-zero on error.
> + */
> +int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> +{
> +	int err;
> +
> +	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
> +
> +	err = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
> +	if (err)
> +		goto err_update_security;
> +
> +	err = ice_vsi_add_vlan_zero(vsi);
> +	if (err)
> +		goto err_vlan_zero;
> +
> +	return 0;
> +
> +err_vlan_zero:
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);

nit: Please consider continuing the practice, that is used for the labels
     removed by this patch, of naming labels after what they do rather
     than what jumps to them.

> -err_dst_free:
> -	metadata_dst_free(repr->dst);
> -	repr->dst = NULL;
> -err_add_mac_fltr:
> -	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac, ICE_FWD_TO_VSI);
> +err_update_security:
> +	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
>  
> -	return -ENODEV;
> +	return err;
> +}
> +

...

