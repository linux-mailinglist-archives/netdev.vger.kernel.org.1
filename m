Return-Path: <netdev+bounces-101631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983428FFB3A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC0F1C255C5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0517582;
	Fri,  7 Jun 2024 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OipDHOip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272091BC57
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 05:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737069; cv=none; b=qLUkdK6hlYtonUxWvwo3qe16oviBdXthJ8a8Py2OJagbj1MVBcTNEe1Jdjup/gQLzejiArZ1X92E+yrKxUjaZhU3SSwq5WNOoW2oY6Ud/6ssS7X5r8qfu1BbdUzhaYCRfxIV6EndWOrC/f0o6EDNCW9MN/mL/g+LdqZ63x3Wal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737069; c=relaxed/simple;
	bh=rUJ4MMbZfULIIuSERv6dhLxq8IoMTckI/MPHugpGGYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+pg3AL+dw94M5FFqYFvIdlugNdpOGHkq9y3fLRMtnaMqLrYG0qon6AUA/gxi6GB/tC7YvZW+h+9nyvJRE6GJ4VqqXiDZcEJ9z4ysCn50bsNYorZX1wzE4BFa/RHHXs+NLiXni3PUhEmSpOUXyr//5fUXcoiafbn0mRol9NfbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OipDHOip; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717737067; x=1749273067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUJ4MMbZfULIIuSERv6dhLxq8IoMTckI/MPHugpGGYc=;
  b=OipDHOipgLYXkj11pAGelE62qL7XdwklAZKbPhAscD6UZlDX4WWCijnv
   9A9s0qYZAJYY9lJXFkOTh855eczoftv5DrL0q0CoIwwWBKlU4zADaEr8b
   iHjVf3PkULjZqH87as3DC3HNx3NtMBuLaGYBSI/fvK7is/5f0hkKtac9g
   FmMn0leL4WUbrQGUgUZRl6yYcaYBnjAiHu/nMGmVT0sgXRLQFFZqyZtqj
   GtPR5kmarKv44vacV4xGEyYM5kGRed/TmsbBgkkt9jJ7Pw512pAnqdr7n
   dqDUsFrq0gnD72GcAc4MqDoW/gCAta9hczr7V1eRrEzjnKivtMr/+cicv
   g==;
X-CSE-ConnectionGUID: t9Af3It9SW6CfuATQw4MrA==
X-CSE-MsgGUID: HEzjtJOwTxWxnASbQFYddg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31934246"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="31934246"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 22:11:07 -0700
X-CSE-ConnectionGUID: A1f9U6neRSisptxZQZYJxw==
X-CSE-MsgGUID: jpdJKNzCQnKA02mfPISskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38269332"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 22:11:05 -0700
Date: Fri, 7 Jun 2024 07:10:13 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v2 3/7] ice: move devlink locking outside the port
 creation
Message-ID: <ZmKWNbY1V+ZvP/qX@mev-dev>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
 <20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
 <20240606175634.2e42fca8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606175634.2e42fca8@kernel.org>

On Thu, Jun 06, 2024 at 05:56:34PM -0700, Jakub Kicinski wrote:
> On Wed, 05 Jun 2024 13:40:43 -0700 Jacob Keller wrote:
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> > In case of subfunction lock will be taken for whole port creation. Do
> > the same in VF case.
> 
> No interactions with other locks worth mentioning?
> 

You right, I could have mentioned also removing path. The patch is only
about devlink lock during port representor creation / removing.

> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index 704e9ad5144e..f774781ab514 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
> >  
> >  	tc_node = pi->root->children[0];
> >  	mutex_lock(&pi->sched_lock);
> > -	devl_lock(devlink);
> >  	for (i = 0; i < tc_node->num_children; i++)
> >  		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
> > -	devl_unlock(devlink);
> >  	mutex_unlock(&pi->sched_lock);
> 
> Like this didn't use to cause a deadlock?
> 
> Seems ice_devlink_rate_node_del() takes this lock and it's already
> holding the devlink instance lock.

ice_devlink_rate_init_tx_topology() wasn't (till now) called with
devlink lock, because it is called from port representor creation flow,
not from the devlink.

Thanks,
Michal

