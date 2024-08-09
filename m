Return-Path: <netdev+bounces-117162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C199D94CF31
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BFD1F22347
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CC191F7F;
	Fri,  9 Aug 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liyaUCUk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FF18B488
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201605; cv=none; b=GTwCmn/WfR+V/en1CTKx+lnz8Qx/GC4xvNBACCbbZ5wpkuAQsFjs7RfJWnrWDq+/i4vUKHWqO0aa+5LRvoeHv3eaFyp/ljUQx1aFMdyuYuqN+p/A9gJsPWkwkgZLor1BCPsK5qbTFH9wz86Ne1Y74EhXoPwyYgpz74aK/P/gPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201605; c=relaxed/simple;
	bh=7j7aiex4pUHkol2G5hAC5NE81ydXu6grurgiexwUqrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUKR4H9UC1Lyc9CT0y3gj92MCRLVvExgFNAYM0RT+NVVEZaVpdBtpKhOGlYJXvk0W1tVMNFsKF2Jx+Arf9rpyy1ig/MI9Lw4oZ+OKVSIZXcxROMQfzpQOjpeRqqG8XqDEaDFj9OAEdL7j+6ZSQStNzL7iEpXrzWAbSx2vTBYRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liyaUCUk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723201603; x=1754737603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7j7aiex4pUHkol2G5hAC5NE81ydXu6grurgiexwUqrQ=;
  b=liyaUCUkCAMlf2wHNj8wD1Wo1kO3mXJ3zdPh4rLU37W8JdESmQQDW5cg
   j7Qd5jwag0m3xx3p0Vqo7BjLlKnoTU2QwyCVKGFcNeHXvxuOLOc9O22Aw
   xirJtdw2ZNpreB2gdAbxF5vuL68PMCDxRWKGsSnVLtQrpxSGYS+Q24D8c
   0NpnwXHAtiNOevtHibceExK7BR5xN5Pyz3DMXiYiyDkR6B4LvaNxOXNu4
   xHn/P1Zy7b3X0vbc8PbPWqFNCCmD7jeW6PAIQpW31d2ZjN+0qJ2oDsgQ2
   9A+epQ5sVIEoM8opOIXL3xe2n3FCelj5oBKlocX8Z+NH+Eshn4Vg5ATXC
   w==;
X-CSE-ConnectionGUID: LYBdwwuZT7uaYdYh88/ftw==
X-CSE-MsgGUID: BPeBdBpfSkWHfD+40PI7bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25138308"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25138308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:06:43 -0700
X-CSE-ConnectionGUID: i3u/Z4/GSvWPZSTuWiJJkQ==
X-CSE-MsgGUID: bgZJKb4GTF2JXZ9sbO562Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57197732"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:06:40 -0700
Date: Fri, 9 Aug 2024 13:05:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v3 1/8] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZrX33DvUqXGB2ork@mev-dev.igk.intel.com>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion>
 <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
 <ZrX0znOhHFzafIuB@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX0znOhHFzafIuB@nanopsycho.orion>

On Fri, Aug 09, 2024 at 12:51:58PM +0200, Jiri Pirko wrote:
> Fri, Aug 09, 2024 at 07:13:34AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
> >> Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> >> >range.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
> >> > drivers/net/ethernet/intel/ice/ice.h          |  8 +++
> >> > drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
> >> > 3 files changed, 76 insertions(+), 2 deletions(-)
> >> >
> >> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >index 29a5f822cb8b..bdc22ea13e0f 100644
> >> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >@@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
> >> > 	return 0;
> >> > }
> >> > 
> >> >+static int
> >> >+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> >> >+				 union devlink_param_value val,
> >> >+				 struct netlink_ext_ack *extack)
> >> >+{
> >> >+	if (val.vu16 > ICE_MAX_MSIX) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
> >> 
> >> No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
> >> That is the name of the param.
> >> 
> >
> >Ok, will change both, thanks.
> >
> >> 
> >> 
> >> >+		return -EINVAL;
> >> >+	}
> >> >+
> >> >+	return 0;
> >> >+}
> >> >+
> >> >+static int
> >> >+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> >> >+				 union devlink_param_value val,
> >> >+				 struct netlink_ext_ack *extack)
> >> >+{
> >> >+	if (val.vu16 <= ICE_MIN_MSIX) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "PF min MSI-X is too low");
> >> 
> >> Same comment as for max goes here.
> >> 
> >> 
> >> >+		return -EINVAL;
> >> >+	}
> >> >+
> >> >+	return 0;
> >> >+}
> >> >+
> >> > enum ice_param_id {
> >> > 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> >> > 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> >> >@@ -1535,6 +1561,15 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
> >> > 			      ice_devlink_enable_iw_validate),
> >> > };
> >> > 
> >> >+static const struct devlink_param ice_dvl_msix_params[] = {
> >> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
> >> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> >> >+			      NULL, NULL, ice_devlink_msix_max_pf_validate),
> >> >+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
> >> >+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> >> >+			      NULL, NULL, ice_devlink_msix_min_pf_validate),
> >> >+};
> >> >+
> >> > static const struct devlink_param ice_dvl_sched_params[] = {
> >> > 	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
> >> > 			     "tx_scheduling_layers",
> >> >@@ -1637,6 +1672,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
> >> > int ice_devlink_register_params(struct ice_pf *pf)
> >> > {
> >> > 	struct devlink *devlink = priv_to_devlink(pf);
> >> >+	union devlink_param_value value;
> >> > 	struct ice_hw *hw = &pf->hw;
> >> > 	int status;
> >> > 
> >> >@@ -1645,11 +1681,27 @@ int ice_devlink_register_params(struct ice_pf *pf)
> >> > 	if (status)
> >> > 		return status;
> >> > 
> >> >+	status = devl_params_register(devlink, ice_dvl_msix_params,
> >> >+				      ARRAY_SIZE(ice_dvl_msix_params));
> >> >+	if (status)
> >> >+		return status;
> >> >+
> >> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >> > 		status = devl_params_register(devlink, ice_dvl_sched_params,
> >> > 					      ARRAY_SIZE(ice_dvl_sched_params));
> >> >+	if (status)
> >> >+		return status;
> >> > 
> >> >-	return status;
> >> >+	value.vu16 = pf->msix.max;
> >> >+	devl_param_driverinit_value_set(devlink,
> >> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> >> >+					value);
> >> >+	value.vu16 = pf->msix.min;
> >> >+	devl_param_driverinit_value_set(devlink,
> >> >+					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> >> >+					value);
> >> >+
> >> >+	return 0;
> >> > }
> >> > 
> >> > void ice_devlink_unregister_params(struct ice_pf *pf)
> >> >@@ -1659,6 +1711,8 @@ void ice_devlink_unregister_params(struct ice_pf *pf)
> >> > 
> >> > 	devl_params_unregister(devlink, ice_dvl_rdma_params,
> >> > 			       ARRAY_SIZE(ice_dvl_rdma_params));
> >> >+	devl_params_unregister(devlink, ice_dvl_msix_params,
> >> >+			       ARRAY_SIZE(ice_dvl_msix_params));
> >> > 
> >> > 	if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
> >> > 		devl_params_unregister(devlink, ice_dvl_sched_params,
> >> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> >> >index d6f80da30dec..a67456057c77 100644
> >> >--- a/drivers/net/ethernet/intel/ice/ice.h
> >> >+++ b/drivers/net/ethernet/intel/ice/ice.h
> >> >@@ -95,6 +95,7 @@
> >> > #define ICE_MIN_LAN_TXRX_MSIX	1
> >> > #define ICE_MIN_LAN_OICR_MSIX	1
> >> > #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
> >> >+#define ICE_MAX_MSIX		256
> >> > #define ICE_FDIR_MSIX		2
> >> > #define ICE_RDMA_NUM_AEQ_MSIX	4
> >> > #define ICE_MIN_RDMA_MSIX	2
> >> >@@ -545,6 +546,12 @@ struct ice_agg_node {
> >> > 	u8 valid;
> >> > };
> >> > 
> >> >+struct ice_pf_msix {
> >> >+	u16 cur;
> >> >+	u16 min;
> >> >+	u16 max;
> >> >+};
> >> >+
> >> > struct ice_pf {
> >> > 	struct pci_dev *pdev;
> >> > 	struct ice_adapter *adapter;
> >> >@@ -615,6 +622,7 @@ struct ice_pf {
> >> > 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
> >> > 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> >> > 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
> >> >+	struct ice_pf_msix msix;
> >> > 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> >> > 	u16 num_lan_tx;		/* num LAN Tx queues setup */
> >> > 	u16 num_lan_rx;		/* num LAN Rx queues setup */
> >> >diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> >> >index ad82ff7d1995..4e559fd6e49f 100644
> >> >--- a/drivers/net/ethernet/intel/ice/ice_irq.c
> >> >+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> >> >@@ -252,7 +252,19 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
> >> > int ice_init_interrupt_scheme(struct ice_pf *pf)
> >> > {
> >> > 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
> >> >-	int vectors, max_vectors;
> >> >+	union devlink_param_value value;
> >> >+	int vectors, max_vectors, err;
> >> >+
> >> >+	/* load default PF MSI-X range */
> >> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
> >> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
> >> >+					      &value);
> >> 
> >> If err is not 0, you have a bug in the driver. Perhaps it a about the
> >> time to make this return void and add some WARN_ONs inside the function?
> >> 
> >
> >err is not 0 when this param isn't found (not registered yet). It is a
> >case when driver is probing, I want to have here default values and
> >register it later. Instead of checking if it is probe context or reload
> >context I am checking if param already exists. The param doesn't exist in
> >probe, but exists in reload.
> 
> No, you have to make sure that you are using these values after they are
> set. Please fix.
> 

I am not using value if this function returns error. If function returns
error default values are set. The function
devl_param_driverinit_value_get() is already checking if parameter
exists. Why do you want me to check it before calling this function? Do
you mean that calling it with not registered parameters is a problem? I
don't see why it can be a problem.

> 
> >
> >> 
> >> >+	pf->msix.min = err ? ICE_MIN_MSIX : value.vu16;
> >> >+
> >> >+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
> >> >+					      DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
> >> >+					      &value);
> >> >+	pf->msix.max = err ? total_vectors / 2 : value.vu16;
> >> > 
> >> > 	vectors = ice_ena_msix_range(pf);
> >> > 
> >> >-- 
> >> >2.42.0
> >> >

