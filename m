Return-Path: <netdev+bounces-95455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E88C24C9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BD81F218DD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6915491;
	Fri, 10 May 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOhntd2n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0D134BD
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343984; cv=none; b=KVmX6C9im9IdtYqgquu7jycwK2OskXe/znux+LTa6aKSjJVezbsBEeBKLGE55W0FlLSiuaeIBbCSooAenkIAtKJft5bUfvl8oB6gFI/0EUes43arYjV4wFcACAx9U9svD/F4/xUmUBbg5+G2sX1dLQCD44dVT5RkLS77k7P0XWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343984; c=relaxed/simple;
	bh=Hnq+191h8FhyyUIpxrV6q5jxz+UIi9bgn2as7lK3+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ234pdH/WnQuCAol/59miwnadysj0VitMp55rD0AlhnY9Zi+eqJD5wrpW6R6UvywmYhAzVQCqYrvSavjRCrNYn8c2HRgqp2e311NDcsWB/DlH+17oyIA4KfQTPvxa3SqY4STjYBQ9yCnFwPDssC54T6IFQx2Pi6QmDV9ae0L54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOhntd2n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715343983; x=1746879983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hnq+191h8FhyyUIpxrV6q5jxz+UIi9bgn2as7lK3+F0=;
  b=BOhntd2n6qkgR4kXmEMmflr+kZhoAYI0FWeXMN6TPSKyy28OjHa15Tov
   UoQM2+hidtaEY9IS5D/aHUiXjQle+4fgGHIROcR7ZKOc5nEuhclNsrS7Q
   9lgkUT5lcbvWyfh0uikN7axPdGoQpLTe1nN6Tiie3Pg5fftnMd+GzHbT9
   hsJQKabgnlti1JcenlClV2Qs2D7OdLNIFOuKLp+BXTGao/a6VtNRPCCML
   6VQ2NdlZ/my9L2kzdGFrogTziFhWRRN/y4K0SLKYU/wjfB7Mp2FFYmeKP
   lM68L/W5dNAnx7KaGeW+/9rlTgAHkB4p1OToUsD6vLMDbe93mLkCj7xwo
   w==;
X-CSE-ConnectionGUID: 7SY7FtVCS4uW49X1LY4qWw==
X-CSE-MsgGUID: h5twnn3tQ0mpOxFizKhJgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="36701486"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="36701486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:26:22 -0700
X-CSE-ConnectionGUID: 4Zyxxi2eSjmg5/RJNmA1EA==
X-CSE-MsgGUID: wTAdXrR5RYiLfbXSmP8ISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29988170"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:26:19 -0700
Date: Fri, 10 May 2024 14:25:47 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
	mateusz.polchlopek@intel.com, netdev@vger.kernel.org,
	jiri@nvidia.com, michal.kubiak@intel.com,
	intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 08/14] ice: create port
 representor for SF
Message-ID: <Zj4SS6hPPDEhvBCX@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>
 <ZjywddcaIae0W_w3@nanopsycho.orion>
 <Zj3NQw1BxqtOS9VG@mev-dev>
 <Zj4AAFwZudmyOWTm@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4AAFwZudmyOWTm@nanopsycho.orion>

On Fri, May 10, 2024 at 01:07:44PM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 09:31:15AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, May 09, 2024 at 01:16:05PM +0200, Jiri Pirko wrote:
> >> Tue, May 07, 2024 at 01:45:09PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >Store subfunction and VF pointer in port representor structure as an
> >> >union. Add port representor type to distinguish between each of them.
> >> >
> >> >Keep the same flow of port representor creation, but instead of general
> >> >attach function create helpers for VF and subfunction attach function.
> >> >
> >> >Type of port representor can be also known based on VSI type, but it
> >> >is more clean to have it directly saved in port representor structure.
> >> >
> >> >Create port representor when subfunction port is created.
> >> >
> >> >Add devlink lock for whole VF port representor creation and destruction.
> >> >It is done to be symmetric with what happens in case of SF port
> >> >representor. SF port representor is always added or removed with devlink
> >> >lock taken. Doing the same with VF port representor simplify logic.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > .../ethernet/intel/ice/devlink/devlink_port.c |   6 +-
> >> > .../ethernet/intel/ice/devlink/devlink_port.h |   1 +
> >> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 +++++++++---
> >> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> >> > drivers/net/ethernet/intel/ice/ice_repr.c     | 124 +++++++++++-------
> >> > drivers/net/ethernet/intel/ice/ice_repr.h     |  21 ++-
> >> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> >> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> >> > 8 files changed, 187 insertions(+), 80 deletions(-)
> >> 
> >> This calls for a split to at least 2 patches. One patch to prepare and
> >> one to add the SF support?
> >
> >Is 187 insertions and 80 deletions too many for one patch? Or the
> >problem is with number of files changed?
> 
> The patch is hard to follow, that's the problem.
> 

Ok, I will do my best to make it easier to read in next version.

> 
> >
> >I don't see what here can be moved to preparation part as most changes
> >depends on each other. Do you want me to have one patch with unused
> >functions that are adding/removing SF repr and another with calling
> >them?
> >
> >Thanks,
> >Michal

