Return-Path: <netdev+bounces-181492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76673A852E0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75430465A40
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399A27CB0B;
	Fri, 11 Apr 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTwMWjCA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF527BF7B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348173; cv=none; b=TuA7kMmVuQXu3o/2ZjHCUcAA/W8vyIvxGjCHTk7CVtOAhlAEcO8qAqJxYTNMs0xl5l9qAyg7F5uRmcOKc4q3Z8SEA0yfkGUz+OaA+QVOl500EZptAiVCPaBu2Vtq5YesVSzsnScuRFg2QesLr6L7UFMmubYV0wQFILSMlQGGM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348173; c=relaxed/simple;
	bh=W9K3wPIr+quSoJsa97ROeiE6HtNrnj6DEIPQ+cSgm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmUORzJfw9dn8aMxycvKzbuWz7YyWENOPWPhdDPyAx7cep0m1kAA4MdlRvoo+/k/K/dnA94V5DMqol10MYGzfKyx96Pj7pfrrzZ06nab61YjPcfs2HfWPoQ+dtOMfMj13COsMthUiLNrrcxcYWQnhMXQqDiZraIjdDmILV1NgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTwMWjCA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744348172; x=1775884172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9K3wPIr+quSoJsa97ROeiE6HtNrnj6DEIPQ+cSgm/I=;
  b=cTwMWjCAIlbQepGH+HJYWwuHDg7WScgPTMX5J0H44Xu87GLuWCaI/L6Y
   a/lUDfvV9z9NzBuCAVRZ53MWL4DxLnQOeHiOJZ6RiEnq4hcqIrGCPb11c
   AdfdcGT2GBgquYAQ9EIto1jLQpqIsKD6neoaFPerqRkbjAAlBKhV+YtV9
   6xihHdlok5hFh/SX3ctBbk/aRSKokr5MNvv5GQtHSbfzu3ozYnZFOM3Rm
   4MtpwZh4pPlTA6pgWa2fGzuRhBZqU9mEMpq/AuGgKyqVZ/nsB17OAwmSD
   tVr+7SmREu1LQf1/Toz7kKORjDSQlaFJ89IzLQweBfbtSpjEZX0mnJSPN
   g==;
X-CSE-ConnectionGUID: qQQglPhYSVKzpzti06pkxw==
X-CSE-MsgGUID: Xd2b7jPURR6eRF7tTLclLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45600033"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45600033"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:09:31 -0700
X-CSE-ConnectionGUID: Uyo2DFClSYO3H/e2tlzVZQ==
X-CSE-MsgGUID: zQrGO42KT1izZMEOj5pBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133963928"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:09:29 -0700
Date: Fri, 11 Apr 2025 07:09:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] idpf: fix potential memory leak on kcalloc()
 failure
Message-ID: <Z/ij+J8kGYM5ezC/@mev-dev.igk.intel.com>
References: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
 <20250407104350.GA395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407104350.GA395307@horms.kernel.org>

On Mon, Apr 07, 2025 at 11:43:50AM +0100, Simon Horman wrote:
> On Fri, Apr 04, 2025 at 12:54:21PM +0200, Michal Swiatkowski wrote:
> > In case of failing on rss_data->rss_key allocation the function is
> > freeing vport without freeing earlier allocated q_vector_idxs. Fix it.
> > 
> > Move from freeing in error branch to goto scheme.
> > 
> > Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> 
> Hi Michal,
> 
> WRT leaking q_vector_indxs, that allocation is not present at
> the commit cited above, so I think the correct Fixes tag for
> that problem is the following, where that allocation was added:
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")

Thanks for checking that. I agree, my fixes is wrong.

> 
> I do note that adapter->vport_config[idx] may be allocated but
> not freed on error in idpf_vport_alloc(). But I assume that this
> is not a leak as it will eventually be cleaned up by idpf_remove().

Right, it will be better to free it directly for better readable.
Probably candidate for net-next changes.

> 
> So the Fixes tag not withstanding this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Thanks for review.

> > Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Suggested-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> ...

