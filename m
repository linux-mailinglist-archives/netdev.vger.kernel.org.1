Return-Path: <netdev+bounces-141406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739C9BACEF
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D96E1F220BB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAE18BC06;
	Mon,  4 Nov 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG6ZOmY3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05717583
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703959; cv=none; b=hBnCBhRKUnwTYkUVwdER8X65py7RSkH+N1JHKqzXKGkSp/reQZ7nUDZmxlND/PaGVP2R5vtjYUe07DYF26Vc+clOJhp7z6VvCUkAOwtjYJznjjFNI73WhBZEzBY7aC/tBw7zXTKOSbNSl8ifnwXqjS79CkxaUNHOTn/xmDfJQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703959; c=relaxed/simple;
	bh=azFTpuczehSXJyqxDMebUsmcImEct5dony72l2EVluo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Ez2wwQ5G4KeU4+u2Xs1j+iQmXzXjCx3K7O0OzO8e6Ey+r9UXI6ddfrMl2QPhuQpBdPKIewUULkJl0oNHGjOXlTE+t/ZO3uK6mJHXYzyZAAFvl1i+wy4WCOZTTB03kmqWQlEim09tvLv6BZMT4TaWX1HSdaRNO6PRWmV7+Wq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG6ZOmY3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730703957; x=1762239957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=azFTpuczehSXJyqxDMebUsmcImEct5dony72l2EVluo=;
  b=FG6ZOmY3CxcRK2dyDnbIR1ciuhFYctMDXJiGqAlwy7mBytxMa0N+sMl/
   YfQ5ACmfUUNq/uz5emkd19jTCYzi2H2/N8wdq4BsLt24Fyz6epa+HOUv3
   lO58k9GpIC7pfyggHilRwU7MmHYtT0t4m+hH1rK17a7AF8vleE1YuZat+
   gCqgJfrLtFaRQFm+SWidoKyjtCtLuI+rP1hr5X4OR0ExsZHwdjJetcXU4
   pj3oyghkjuqaznL2YT4u6eIdfdhGa7an8xlM9okdRB/3Go6saC/SZanMb
   ha9yaXCyECsH0xyk0LivzFUWCuReZ0r+4UzzjsX2eZNcMcfmrMuoRtAtF
   Q==;
X-CSE-ConnectionGUID: p7tEIAE/TFWcQ+tr6fmUMw==
X-CSE-MsgGUID: OKuAsOUoTnOfnjJOfned3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29802997"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29802997"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:05:55 -0800
X-CSE-ConnectionGUID: gEFhI0EtToa9+XMJ4dXerw==
X-CSE-MsgGUID: OXWA+pODR1e8c9O+B0vUfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83694153"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:05:52 -0800
Date: Mon, 4 Nov 2024 08:02:51 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com
Subject: Re: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max
 and min parameter
Message-ID: <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>

On Thu, Oct 31, 2024 at 10:48:37PM +0100, Michal Schmidt wrote:
> On Mon, Oct 28, 2024 at 11:04 AM Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > range.
> >
> > Add notes about this parameters into ice devlink documentation.
> >
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  Documentation/networking/devlink/ice.rst      | 11 +++
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
> >  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
> >  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
> >  4 files changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> > index e3972d03cea0..792e9f8c846a 100644
> > --- a/Documentation/networking/devlink/ice.rst
> > +++ b/Documentation/networking/devlink/ice.rst
> > @@ -69,6 +69,17 @@ Parameters
> >
> >         To verify that value has been set:
> >         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
> > +   * - ``msix_vec_per_pf_max``
> > +     - driverinit
> > +     - Set the max MSI-X that can be used by the PF, rest can be utilized for
> > +       SRIOV. The range is from min value set in msix_vec_per_pf_min to
> > +       2k/number of ports.
> > +   * - ``msix_vec_per_pf_min``
> > +     - driverinit
> > +     - Set the min MSI-X that will be used by the PF. This value inform how many
> > +       MSI-X will be allocated statically. The range is from 2 to value set
> > +       in msix_vec_per_pf_max.
> > +
> >  .. list-table:: Driver specific parameters implemented
> >      :widths: 5 5 90
> >
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index d1b9ccec5e05..29c1fec4fa93 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1198,6 +1198,25 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
> >         return status;
> >  }
> >
> > +static void ice_set_min_max_msix(struct ice_pf *pf)
> > +{
> > +       struct devlink *devlink = priv_to_devlink(pf);
> > +       union devlink_param_value val;
> > +       int err;
> > +
> > +       err = devl_param_driverinit_value_get(devlink,
> > +                                             DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> > +                                             &val);
> > +       if (!err)
> > +               pf->msix.min = val.vu16;
> > +
> > +       err = devl_param_driverinit_value_get(devlink,
> > +                                             DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> > +                                             &val);
> > +       if (!err)
> > +               pf->msix.max = val.vu16;
> > +}
> > +
> >  /**
> >   * ice_devlink_reinit_up - do reinit of the given PF
> >   * @pf: pointer to the PF struct
> > @@ -1207,6 +1226,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
> >         struct ice_vsi *vsi = ice_get_main_vsi(pf);
> >         int err;
> >
> > +       /* load MSI-X values */
> > +       ice_set_min_max_msix(pf);
> > +
> >         err = ice_init_hw(&pf->hw);
> >         if (err) {
> >                 dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
> > @@ -1526,6 +1548,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
> >         return 0;
> >  }
> >
> > +static int
> > +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> > +                                union devlink_param_value val,
> > +                                struct netlink_ext_ack *extack)
> > +{
> > +       struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +       if (val.vu16 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> > +           val.vu16 < pf->msix.min) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int
> > +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> > +                                union devlink_param_value val,
> > +                                struct netlink_ext_ack *extack)
> > +{
> > +       struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +       if (val.vu16 <= ICE_MIN_MSIX || val.vu16 > pf->msix.max) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  enum ice_param_id {
> >         ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> >         ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> > @@ -1543,6 +1596,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
> >                               ice_devlink_enable_iw_validate),
> >  };
> >
> > +static const struct devlink_param ice_dvl_msix_params[] = {
> > +       DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
> > +                             BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> > +                             NULL, NULL, ice_devlink_msix_max_pf_validate),
> > +       DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
> > +                             BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> > +                             NULL, NULL, ice_devlink_msix_min_pf_validate),
> > +};
> > +
> >  static const struct devlink_param ice_dvl_sched_params[] = {
> >         DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> >                              "tx_scheduling_layers",
> > @@ -1644,6 +1706,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
> >  int ice_devlink_register_params(struct ice_pf *pf)
> >  {
> >         struct devlink *devlink = priv_to_devlink(pf);
> > +       union devlink_param_value value;
> >         struct ice_hw *hw = &pf->hw;
> >         int status;
> >
> > @@ -1652,11 +1715,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
> >         if (status)
> >                 return status;
> >
> > +       status = devl_params_register(devlink, ice_dvl_msix_params,
> > +                                     ARRAY_SIZE(ice_dvl_msix_params));
> > +       if (status)
> > +               return status;
> > +
> >         if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >                 status = devl_params_register(devlink, ice_dvl_sched_params,
> >                                               ARRAY_SIZE(ice_dvl_sched_params));
> > +       if (status)
> > +               return status;
> >
> > -       return status;
> > +       value.vu16 = pf->msix.max;
> > +       devl_param_driverinit_value_set(devlink,
> > +                                       DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> > +                                       value);
> > +       value.vu16 = pf->msix.min;
> > +       devl_param_driverinit_value_set(devlink,
> > +                                       DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> > +                                       value);
> > +
> > +       return 0;
> >  }
> 
> 
> The type of the devlink parameters msix_vec_per_pf_{min,max} is
> specified as u32, so you must use value.vu32 everywhere you work with
> them, not vu16.
> 

I will change it.

> Michal
> 

