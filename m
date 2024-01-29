Return-Path: <netdev+bounces-66666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E40C840346
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591A52837D9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3E5A786;
	Mon, 29 Jan 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq8GLyxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8875A0F7
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525746; cv=none; b=rG6NOiPD6L3gLcwf/H3f72uHDd6xW89sTsAfDdmuQp/C2mF/gDDS2M+E/KNEcdnRuc0JYZYog3HS5AdYtdpokmafUs488MQ+Tu/GUkJccewNKCEDLOY8qmj1Fm5scWlnbxaXbxbhlQgX8OqGpd9qxwewjrPI+lYTZKJeZOX7Co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525746; c=relaxed/simple;
	bh=8T8pTki2cBRkv1Ls62f1/Lkua7FBs03HkkD51F+WL44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpbrZNrcGptDk/AxFAXsVsLoeoXnCYdqETkfV5XRq7fOkitxXMfcQHpAtKtQ9FxWyu+3zru3T7FVDNQmuNNs1cmg+LgwIJ0xHRNzt/wBXYnjOmiK2yOp3DHafiLGUnfTmixQpeiP8WycWEV5J0ZMkihXpcJEqp1D0hFx9XZ4I1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq8GLyxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8EDC433C7;
	Mon, 29 Jan 2024 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525745;
	bh=8T8pTki2cBRkv1Ls62f1/Lkua7FBs03HkkD51F+WL44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq8GLyxKYAx0vbFdAxXiBvLLvv+4wjlAAFsWEq1lpXaLtv8h9taxNzg3Q2F4vVlUd
	 SyppyWK51uRy3vRSATXM0pusJ5OXG1bWRQioQGqWwcoFd+ruJZ1rE0EiehSLIVaD4x
	 eY96AaWo7poe8tTtabrLrJBQrK2OoNecSZERG1ba2AxPiml8w0/9/dNSF7pb4eQBRq
	 v5c4oK3pSNFfZI6Ge8iasRetyT6rMqb7qEc9NbgnbSnjL3u0Ifmq6yYeVzRFRol+vF
	 EsmW/fHaqHCZYlqlx07cW73kO9wEGanl4ioOYc3X7uyzG0WSyRLNRblzN2VVn1znz/
	 JsHYIh24m7Csg==
Date: Mon, 29 Jan 2024 10:55:41 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [iwl-next v1 4/8] ice: control default Tx rule in lag
Message-ID: <20240129105541.GH401354@kernel.org>
References: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
 <20240125125314.852914-5-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125125314.852914-5-michal.swiatkowski@linux.intel.com>

On Thu, Jan 25, 2024 at 01:53:10PM +0100, Michal Swiatkowski wrote:
> Tx rule in switchdev was changed to use PF instead of additional control
> plane VSI. Because of that during lag we should control it. Control
> means to add and remove the default Tx rule during lag active/inactive
> switching.
> 
> It can be done the same way as default Rx rule.

Hi Michal,

Can I confirm that LAG TX/RX works both before and after this patch?

> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 39 ++++++++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c

...

> @@ -266,9 +274,22 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
>  {
>  	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
>  		ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
> +	int err;
> +
> +	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
> +			       ICE_FLTR_RX, add);
> +	if (err)
> +		return err;
> +
> +	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_tx_rule_id,
> +			       ICE_FLTR_TX, add);
> +	if (err) {
> +		ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
> +				 ICE_FLTR_RX, !add);
> +		return err;
> +	}
>  
> -	return ice_lag_cfg_fltr(lag, act, lag->pf_recipe,
> -				&lag->pf_rule_id, add);
> +	return 0;
>  }

nit: perhaps this could be more idiomatically written using a
     goto to unwind on error.

...

