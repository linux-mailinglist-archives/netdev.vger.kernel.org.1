Return-Path: <netdev+bounces-103801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38969098C3
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B5A1F217EB
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3E49638;
	Sat, 15 Jun 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN/oVbqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF203BBD7
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464498; cv=none; b=g6OImTyv+BpLmJ0ntpLQgbf+9zLNZ+Zs31W8ZiOsbiTALQlcx6tb//T8lXjzytL9tdvQ5P4bo9zuMYJxf+9ezsHFy1HHppZh2lQKwJXLIh3lnHdM7tVpm3pCAi8froVknYeK9RnjDVG9khkbb1kCmiZlWihKZk2vi1dizmYCH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464498; c=relaxed/simple;
	bh=6Flv7sO4NCz0GEPAl1v5f8xlU/046ZJIoigiJajNMRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKjrqIHBABtl2+VEzYB+u73rf5qxZ/80AsdcO9iZIPQLdv3ibA/tvndWj7Ql5wuIT22PoCO6V4zO9uJ/a8WJdoSnruVJpdz81fSiygugQF4DYwQfToN44Uf11ukKJNtofU/praHcpT9AYTgQWUObchgzdDX00k2hf4MapR4VJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN/oVbqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B2CC116B1;
	Sat, 15 Jun 2024 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718464497;
	bh=6Flv7sO4NCz0GEPAl1v5f8xlU/046ZJIoigiJajNMRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN/oVbqn/8PN3UpnnFhG9LSJRJU4OpfGeV+yLiuWv0LXJQCdfdOhA99icL+XRS/yC
	 M3AplzqgZEugzGzhy9DEgm2FEO+ahCxQxG43Gl/Eyz1UAiBtOBHHWYaGZ8hcKFugmV
	 X8FTA2OhtEYnxv1K66zpmsOp2yoNZ3NR0q8TsyQBeNM/a+B34TxlxwnLjS2clOuAuG
	 4GtWf+wlMDiwaJfadNMaqWNgTJ1lelA/9OGNtfgrCYOD8SUvXgiCabHw1s4fXz6OVf
	 fg64koafTnovOAEOgPkxkUuiI76fnlKSTLsDoObafRGqay4kTM23TddbG5iBlh6Zym
	 e+kzo6DsQT9Tw==
Date: Sat, 15 Jun 2024 16:14:54 +0100
From: Simon Horman <horms@kernel.org>
To: Karen Ostrowska <karen.ostrowska@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Eric Joyner <eric.joyner@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [iwl-next v2] ice: Check all ice_vsi_rebuild() errors in function
Message-ID: <20240615151454.GF8447@kernel.org>
References: <20240614094435.4777-1-karen.ostrowska@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094435.4777-1-karen.ostrowska@intel.com>

On Fri, Jun 14, 2024 at 11:44:35AM +0200, Karen Ostrowska wrote:
> From: Eric Joyner <eric.joyner@intel.com>
> 
> Check the return value from ice_vsi_rebuild() and prevent the usage of
> incorrectly configured VSI.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
> On v1 there was no goto done line added after ice_vsi_open(vsi).
> It's needed to skip printing error message when is on success.
> 
> Original patch was introduced as implementation change not because of
> fixing something, so I will skip adding here Fixes tag.
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 7d9a4e856f61..1222e8a175d9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4155,15 +4155,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)

Hi Karen,

This patch seems to be mangled.
The context above should be:

@@ -4155,15 +4155,24 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)

i.e. 23 -> 24

>  
>  	/* set for the next time the netdev is started */
>  	if (!netif_running(vsi->netdev)) {
> -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		if (err)
> +			goto rebuild_err;
>  		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
>  		goto done;
>  	}
>  
>  	ice_vsi_close(vsi);
> -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	if (err)
> +		goto rebuild_err;
> +
>  	ice_pf_dcb_recfg(pf, locked);
>  	ice_vsi_open(vsi);
> +       goto done;

The line above should be indented using a tab.

> +
> +rebuild_err:
> +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
>  done:
>  	clear_bit(ICE_CFG_BUSY, pf->state);
>  	return err;
> -- 
> 2.39.3
> 
> 

