Return-Path: <netdev+bounces-181499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFFA853BC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36B31B81D65
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6927D799;
	Fri, 11 Apr 2025 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MicvCk3q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CF27D790
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350776; cv=none; b=liGddUFKMHSu5VjZuj9rLaDEcna5Ms6uLjdo7TSGMOEiTOhs3Q38fTZB93gmd9EXBTiKeiufYd7NB8wigJEAo9w5gI9l8pfSGpMveNiuAr3dib0Crf4Ry4xJLWZwGnmMzy6EWLLUlqTMIUDnwNvs/Mbe+z7q/rcuiRISaB1CGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350776; c=relaxed/simple;
	bh=Ip8lJB4i+WtPdj6Dm47pbnmtnM9EE9gcx3B85Pupu8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLP/NsN/UpiF0jNktdmmgRfaQ6agN8UyT+SGwEuxOCs4JHO7UxQJMAiJuqfT7s+53ikm9GJsVdHv0FXIk/88LsEBADyze2JA8MfOD/2DFixK0AQyWby03fS+76/0jCswGri9fr0qMj+WdSjbxViJcxDvyJgXMrRgI5GehrqPfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MicvCk3q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744350775; x=1775886775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ip8lJB4i+WtPdj6Dm47pbnmtnM9EE9gcx3B85Pupu8I=;
  b=MicvCk3qxNF4/tvXhenAzF7bxZWUpvQx3sXMpO+AThyIJlJFmEvwvFU0
   xRf0YATsBN7KfnktXd/P4eVWrViW5yLCbIyOFhAMAaZc2qCTaFBk7RVFu
   N786+fLuIe28oc2cFrYA9dHnVnQx4kPTpUHX8FKNnPiGKTJ88zbqAdmYn
   /gtULMsT60DdAyN+0Ptl8iwSXIFZuLdfn9vi11/Uci1100BsBmxLf3dI2
   VjNimjQGrWVD4TzgCuDGnGMfNu2FqyEOMkwdBnoEl3aJcXSVjLP/uveLY
   sKr4AI3dpLSpLzXa2KcBF3Tl4aZUGamEtVzoIk0zCZEiUHj/5kAKWgVYx
   A==;
X-CSE-ConnectionGUID: EAfqXNJzQM6h8X3oitU++A==
X-CSE-MsgGUID: rxOaUlCyQT+C6MU3+N+h/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46032629"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="46032629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:52:54 -0700
X-CSE-ConnectionGUID: 0InnnB9sQYu1mkSOQmV8MA==
X-CSE-MsgGUID: 14FJqnjxTuSQEf/prDlGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133202782"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:52:53 -0700
Date: Fri, 11 Apr 2025 07:52:36 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net] ice: fix vf->num_mac count with port representors
Message-ID: <Z/iuJLZY1cwkxwxv@mev-dev.igk.intel.com>
References: <20250410-jk-fix-v-num-mac-count-v1-1-19b3bf8fe55a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-jk-fix-v-num-mac-count-v1-1-19b3bf8fe55a@intel.com>

On Thu, Apr 10, 2025 at 11:13:52AM -0700, Jacob Keller wrote:
> The ice_vc_repr_add_mac() function indicates that it does not store the MAC
> address filters in the firmware. However, it still increments vf->num_mac.
> This is incorrect, as vf->num_mac should represent the number of MAC
> filters currently programmed to firmware.
> 
> Indeed, we only perform this increment if the requested filter is a unicast
> address that doesn't match the existing vf->hw_lan_addr. In addition,
> ice_vc_repr_del_mac() does not decrement the vf->num_mac counter. This
> results in the counter becoming out of sync with the actual count.
> 
> As it turns out, vf->num_mac is currently only used in legacy made without
> port representors. The single place where the value is checked is for
> enforcing a filter limit on untrusted VFs.
> 
> Upcoming patches to support VF Live Migration will use this value when
> determining the size of the TLV for MAC address filters. Fix the
> representor mode function to stop incrementing the counter incorrectly.
> 
> Fixes: ac19e03ef780 ("ice: allow process VF opcodes in different ways")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> I am not certain if there is currently a way to trigger a bug from
> userspace due to this incorrect count, but I think it still warrants a net
> fix.
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index 7c3006eb68dd071ab76e62d8715dc2729610586a..6446d0fcc0528656054e506c9208880ce1e417ea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -4275,7 +4275,6 @@ static int ice_vc_repr_add_mac(struct ice_vf *vf, u8 *msg)
>  		}
>  
>  		ice_vfhw_mac_add(vf, &al->list[i]);
> -		vf->num_mac++;
>  		break;
>  	}
>  

Right, thanks for fixing it.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> ---
> base-commit: a9843689e2de1a3727d58b4225e4f8664937aefd
> change-id: 20250410-jk-fix-v-num-mac-count-55acd188162b
> 
> Best regards,
> -- 
> Jacob Keller <jacob.e.keller@intel.com>

