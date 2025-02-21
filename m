Return-Path: <netdev+bounces-168407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77EA3ED58
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8833B77DD
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37F1D89E4;
	Fri, 21 Feb 2025 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBSprflo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1621FCFCE
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123210; cv=none; b=LrkNFnU9CRTSMy/woduYUoKPUEMmxB2QV/iiPt2RVy3l/UNTk0GcZ8vqST4enhstw/+cCTlsAKJl3P+UTgm0TdzSf7GUJ7ngvQ7MZciQgf2LPRDkvcuPbVNVn3t+Y+Yho6UzekU/xjQNvKCu12iNgeLgkZTQkpvYz6f0EzCdMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123210; c=relaxed/simple;
	bh=5FP/eBS7lGDumhr02aFKydBB7pfzPWOJwwdAwCYLHHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kka8S6JF2Z2yb79wozhAq7DiPA4/jnJfqeqCXg5gWBJOcArqb8GEQZpVTJTo0RRn+1WJNkdXPUQ+ZoUxz4Vt9TotpuP6YBfmAWY/u2QvctiMAh7lW86LYxutwI0OJJcMMw4OevxPioAutep7re4kJ090e4lDiybaD7vOutW9Jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBSprflo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740123209; x=1771659209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FP/eBS7lGDumhr02aFKydBB7pfzPWOJwwdAwCYLHHQ=;
  b=QBSprflouZy8QnfkVLcfupGvv5LO3gXCslB/UZ5p8nkgRWeaLBc80zg1
   iwdHtlPJPTLQWAsU737U9XIYsxb73W+yYf+C50bOAP78McrM3yFm7wzQP
   I+Q/96qhRTlUguBl+3yUcQ55uskJmoSPcOyylGF9Iu9YCXKRJyWC6vSYW
   eR/iSBIC7XxZgCvuS3SZpTDtIQxVv19/ggR2boHLXibPosd0NEu4Xba+f
   Xncha8d2/YFoX1obbSQoa/Op8hgGTHgI5WQ7J9kM7Oi0x2SDhsuNpXcYu
   h2umXyxiNtwRJ5AvuZSj2R5zlabmTt2y590GJqWbG6Gd5JPyB1ROnmckn
   Q==;
X-CSE-ConnectionGUID: XTRFHasSR+e/YioykeMIFQ==
X-CSE-MsgGUID: gN3OFCdWQoa3Crv6XgZ9LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40852336"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40852336"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:33:28 -0800
X-CSE-ConnectionGUID: yGKCJylvT5KUfXSbr4aR9A==
X-CSE-MsgGUID: T13jXwgkSCeJXm2BARMUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115294573"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 23:33:26 -0800
Date: Fri, 21 Feb 2025 08:29:50 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix Get Tx Topology AQ command error on E830
Message-ID: <Z7grbgy/g4cJTqYb@mev-dev.igk.intel.com>
References: <20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com>
 <Z7WmcXf8J5j/ksNX@mev-dev.igk.intel.com>
 <55fcbc58-fccb-4db5-afa2-21b53a89fdc3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fcbc58-fccb-4db5-afa2-21b53a89fdc3@intel.com>

On Thu, Feb 20, 2025 at 02:45:41PM -0800, Jacob Keller wrote:
> 
> 
> On 2/19/2025 1:37 AM, Michal Swiatkowski wrote:
> > On Tue, Feb 18, 2025 at 04:46:34PM -0800, Jacob Keller wrote:
> >> From: Paul Greenwalt <paul.greenwalt@intel.com>
> >>
> >> With E830 Get Tx Topology AQ command (opcode 0x0418) returns an error when
> >> setting the AQ command read flag, and since the get command is a direct
> >> command there is no need to set the read flag.
> >>
> >> Fix this by only setting read flag on set command.
> > 
> > Why it isn't true for other hw? I mean, why not:
> > if (set)
> > 	RD_FLAG
> > else 
> > 	NOT_RD_FLAG
> > Other hw needs RD flag in case of get too?
> > 
> 
> From what I understand, we didn't anticipate this flow changing. E810
> and E822 hardware require FLAG_RD for both get and set, while E825-C and
> E830 expect FLAG_RD only for set, but not for get.
> 

Thanks for explanation. Seems resonable from driver perspective and not
so reasonable from firmware, but maybe this difference is somehow
important.

Thanks,
Michal

> >>
> > 
> > Don't you need fixes tag?
> 
> You're correct. I'll add it in v2
> 
> >> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> index 03988be03729b76e96188864896527060c8c4d5b..49bd49ab3ccf36c990144894e887341459377a2d 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> >> @@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
> >>  			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
> >>  					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
> >>  
> >> -		if (ice_is_e825c(hw))
> >> -			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >>  	} else {
> >>  		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
> >>  		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
> >> -	}
> >>  
> >> -	if (!ice_is_e825c(hw))
> >> -		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825 &&
> >> +		    hw->mac_type != ICE_MAC_E830)
> >> +			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> >> +	}
> >>  
> >>  	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
> >>  	if (status)
> >>
> > 
> > In general looks fine, only one question.
> > 
> > Thanks,
> > Michal
> 
> Thanks for the review, I'll send a v2 with this cleaned up and include a
> fixes tag.
> 
> > 
> >> ---
> >> base-commit: f5da7c45188eea71394bf445655cae2df88a7788
> >> change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
> >>
> >> Best regards,
> >> -- 
> >> Jacob Keller <jacob.e.keller@intel.com>
> 

