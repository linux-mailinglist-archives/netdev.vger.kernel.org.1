Return-Path: <netdev+bounces-89185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0378A9A63
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F10B20C47
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317E15DBD6;
	Thu, 18 Apr 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgXctarZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426537165
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444560; cv=none; b=Xb48RdfnLS2JNFV/ZXeyIsQGA3Oznt7l5uDfuElSXUPxmzzmRIOhcgdjAq3fomvHE5Y5ltgpSYyGxmoiR9kKpzWOIhzWnVJBHX3JgSHCvFjodeuOGAuaJxYVU0idckf+hYdOA5aAjNPxMSkaMkVetqjL1zG0DrGHTDy6hEn3zBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444560; c=relaxed/simple;
	bh=It5CVBJBDHmvLdbhevY3rpHcqCEKRwZ84y+s65qBu+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjMzjiixsLEr3RFbUKUNcRWjx9WgINYDzrJck1PLIzqu9CP6HgX6gQolyPUZsp+1t5xpuUYgrY1vOaJsWZKtn1HKg611rm5TqM9C2KGQsh88pqMWkciuEBzFg7bb4i+khAOdJiTNPqq5SmgegEniP1RoW9pam7roJn4hwb9Q2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgXctarZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713444559; x=1744980559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=It5CVBJBDHmvLdbhevY3rpHcqCEKRwZ84y+s65qBu+s=;
  b=JgXctarZ+j8867g2/hSIy6zzg93eep/4mw4KH4p+tnC6v2S3XauvOcfu
   sHHDa5llsUfLHh7HtHlSl6tFJT3H6vag5RkmrZIkgDb8WTaf4QEYnMAU2
   AbliV7HWpNwKzItr6fItR5p3dFFVfklHlXyuc/O2SitFfB0rQ6ZP26/3j
   NNO2iSx32v6Q2bS7LV9l5ZJkE8fPDl4H/gJc/25VGwPc4hmddp/cuPJhE
   IpkM4KGaLXc4NOi+jdAZYxejbEYHQ+YfGm/xI9fMK2rWJgPA71zPT1fbR
   JB1QBxzra6vH/0pq3mHhldlfKXj5zpNiepsbUyPJrISlYWXhzmtUFdtmA
   w==;
X-CSE-ConnectionGUID: +IrZvwZtQsqsm76Jbnw+Lg==
X-CSE-MsgGUID: 2BuNJN2NRm29otmq3NnzoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12824973"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12824973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 05:49:18 -0700
X-CSE-ConnectionGUID: gBTlaMjdS/KV7woqN3338A==
X-CSE-MsgGUID: 0Gjiugo8Q4evX45T9Z8L8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23049434"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 05:49:15 -0700
Date: Thu, 18 Apr 2024 14:48:53 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiEWtQ2bnfSO6Da7@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEMRcP7QN5zVd8Z@nanopsycho>

On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> [...]
> 
> >+/**
> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >+ * @dev: the device to allocate for
> >+ *
> >+ * Allocate a devlink instance for SF.
> >+ *
> >+ * Return: void pointer to allocated memory
> >+ */
> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> 
> This is devlink instance for SF auxdev. Please make sure it is properly
> linked with the devlink port instance using devl_port_fn_devlink_set()
> See mlx5 implementation for inspiration.
> 
> 

I am going to do it in the last patchset. I know that it isn't the best
option to split patchesets like that, but it was hard to do it differently.

Thanks,
Michal

> >+{
> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> >+				 &ice_sf_devlink_ops);
> >+}
> >+
> 
> [...]

