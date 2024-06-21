Return-Path: <netdev+bounces-105532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A091197A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89FBB23AA5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD04127B57;
	Fri, 21 Jun 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYP+UunB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB0EBE
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944400; cv=none; b=mIGaXxoT4tCUlSEgsGa4ExODc91FTD+5jKw5XgcmV3z2BnKKTAizSEDeFPeNc0E2XiZQ7i8bX1y1D5eqi0e06MBYwMI/381GhaPFEFx7/3ON1wF6KaCpMOZM0u8h8TW+U2oTYKmXOkhQko4mLQMLB7nNwgeFNCNjpIDLIXTLcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944400; c=relaxed/simple;
	bh=kZMB1YVWSak8ImEcfDH3eBwm6zBqZaDvpEvvowcYei8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0B9k0kT1Sb8HyzocFfGstSWhsX9FQhj8o/iiKXcaDgBb0lUCaDJSJ+pyS9JiWTFE6FyEqNbPtXbsD6DZ+R1ohYBtC5rwOQuQSi6LTZ9L3M+9jNeElTfGSJ5x4y6pH/AOc0p+AzNOZwsN2Aql/RUWmD3OgPAFb0+gAvzkk4J8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYP+UunB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718944399; x=1750480399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZMB1YVWSak8ImEcfDH3eBwm6zBqZaDvpEvvowcYei8=;
  b=TYP+UunByL0jPmmJvSaFUqY8zX/ojMg5+3H7akeYNHrTFNTd1s3d1iXM
   xzULeq9DhKkNUk04/8neLQYXHyOKOgFrxrtVf4IMxFxczN4XoUkHIA8O2
   yTbRo5O+SC7bVQQF0zmz6xZ1nic+S3IHTK1uSMrnsDaFHrFcGLkbm/2x6
   P/183NLcYCjRKqmOiwT2P1rSfvmDl1IeFpJmXq9kAIWB2NAygDYWWpPWR
   eGTD5pMG3IhP4vQRlbU1WmVY1yF4n+/Zbiq36YQLlYijpIaSJ9kuA9aEs
   XvJGJxuN3GTUESeR+hfV2qhz8+DC83lGjDjmPnk3wDL8E07LvMAbxjABW
   w==;
X-CSE-ConnectionGUID: Ir5l8Hz4QGW51UNTCiCHow==
X-CSE-MsgGUID: ut5D9HkDQSe09AnIzTXdew==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16079978"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="16079978"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:33:18 -0700
X-CSE-ConnectionGUID: iNVrNyrnQeqhSfcDMYu0/w==
X-CSE-MsgGUID: 3PWE9hVRQhaF4pYOe4z1Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42917840"
Received: from mev-dev.igk.intel.com (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:33:15 -0700
Date: Fri, 21 Jun 2024 06:32:10 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 4/4] ice: update representor when VSI is ready
Message-ID: <ZnUCSoXc8GyCOm2I@mev-dev>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-5-michal.swiatkowski@linux.intel.com>
 <20240614124716.GN8447@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614124716.GN8447@kernel.org>

On Fri, Jun 14, 2024 at 01:47:16PM +0100, Simon Horman wrote:
> On Mon, Jun 10, 2024 at 09:44:34AM +0200, Michal Swiatkowski wrote:
> > In case of reset of VF VSI can be reallocated. To handle this case it
> > should be properly updated.
> > 
> > Reload representor as vsi->vsi_num can be different than the one stored
> > when representor was created.
> > 
> > Instead of only changing antispoof do whole VSI configuration for
> > eswitch.
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Thanks Michal,
> 
> My comment below notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_eswitch.c | 21 +++++++++++++-------
> >  drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++--
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
> >  3 files changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > index 3f73f46111fc..4f539b1c7781 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > @@ -178,16 +178,16 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> >   * @repr_id: representor ID
> >   * @vsi: VSI for which port representor is configured
> >   */
> > -void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
> > +void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi)
> >  {
> >  	struct ice_pf *pf = vsi->back;
> >  	struct ice_repr *repr;
> > -	int ret;
> > +	int err;
> >  
> >  	if (!ice_is_switchdev_running(pf))
> >  		return;
> >  
> > -	repr = xa_load(&pf->eswitch.reprs, repr_id);
> > +	repr = xa_load(&pf->eswitch.reprs, *repr_id);
> >  	if (!repr)
> >  		return;
> >  
> > @@ -197,12 +197,19 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
> >  	if (repr->br_port)
> >  		repr->br_port->vsi = vsi;
> >  
> > -	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
> > -	if (ret) {
> > -		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
> > -					       ICE_FWD_TO_VSI);
> > +	err = ice_eswitch_cfg_vsi(vsi, repr->parent_mac);
> > +	if (err)
> >  		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
> >  			repr->id);
> > +
> > +	/* The VSI number is different, reload the PR with new id */
> > +	if (repr->id != vsi->vsi_num) {
> > +		xa_erase(&pf->eswitch.reprs, repr->id);
> > +		repr->id = vsi->vsi_num;
> > +		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
> > +			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
> > +				repr->id);
> > +		*repr_id = repr->id;
> >  	}
> >  }
> 
> FWIIW, I think it would be nicer if ice_eswitch_decfg_vsi returned
> the repr_id rather than passing repr_id by reference. This is because,
> in general, I think it's nicer to reduce side-effects of functions.
> 

I wanted to change repr->id and the vf (or sf) repr id in the same
place. But in general I agree with your comment.

Thanks,
Michal

> ...

