Return-Path: <netdev+bounces-166430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE0A35FB8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B5D3AB599
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB657081C;
	Fri, 14 Feb 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZaRIbiO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C720FA9E
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541744; cv=none; b=WT0lfvDdDOdPwRQ6KriRhetvyc0SjrKcGOFnhMqlOIfq9bJKuWyiR9Xm5FdP6gXHqxKBEXonPpgF4a0kJaWGg9YoZydtWAk6gGRA1K11e6w/lrjZm/EtgQYPmLbiD0b17O9t7dvJcwmW26oy9+wq6/PBupxMrf2a5pDdqRSHeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541744; c=relaxed/simple;
	bh=+XOvsBPEExIFFP1osKY+2SXJ8otMNgD4O/BXm2G1Ohk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww2UDa9nekOOdFjERtH8MEK9CftnTq9aEZ+OjcvJkk7KQWrZG4ERUCjov0okXjyFITO7kCL7u1GRv4d690P8IkZCAhvFc+7vr151qMYPmfBJ7ieo2+xOnmdj9Aji6pmoIch1Dan+BNLvN3I3rKfrpMTZeIe6WiDFoC/gFM+sfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZaRIbiO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739541743; x=1771077743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XOvsBPEExIFFP1osKY+2SXJ8otMNgD4O/BXm2G1Ohk=;
  b=JZaRIbiOSF8lg1mVk9VhLIhCfebAze7u0HgWWuM2TM4gErC+kX5OA1Ho
   3Ro/2ze6sjugWyj4kT24Z17QFRP+HJFV/76yE5xqMDMol8vSpCkq1RvQv
   rQHhdanbv1+oII5G2SLBqKLzawOlZB6bQ4q2ubm94A4LHcU3+TvKLETmM
   s1qGh/skRdsluSM1BsDJ/jFsJLnHOuthe/vPDdOaSeZ/WPDkHShIPXPmX
   k+w3aWRPbY3fbjGaw4ZLHxtvk+Pa3Fvdjvu9rQU8VRDPqHTV5A8Lr5W/t
   4YbIzbcOkLlgAAqLT5IuWQgPLT/CZyGEN3R25521OS0yJuvGkNET+Lp8Z
   Q==;
X-CSE-ConnectionGUID: HtbvPTYqRiOG8k4zOT0PhA==
X-CSE-MsgGUID: THfX2S9WR0Ov5fcId7Bfuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="39520925"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="39520925"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:02:22 -0800
X-CSE-ConnectionGUID: q3y0rG5JTLKUsHcOl514NQ==
X-CSE-MsgGUID: 9TnUw5xUQ7+mE43XiUoD+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144321800"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:02:19 -0800
Date: Fri, 14 Feb 2025 14:58:41 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>

On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > devlink_rel_alloc().
> 
> If the same bug exists twice it might exist more times. Did you find
> this instance by searching the whole tree? Or just networking?
> 
> This is also something which would be good to have the static
> analysers check for. I wounder if smatch can check this?
> 
> 	Andrew
> 

You are right, I checked only net folder and there are two usage like
that in drivers. I will send v2 with wider fixing, thanks.

It can be not so easy to check. What if someone want to treat wrapping
as an error (don't know if it is valid)? If one of the caller is
checking err < 0 it will be fine.

Thanks,
Michal

> > 
> > In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
> > be returned, which will cause IS_ERR() to be false. Which can lead to
> > dereference not allocated pointer (rel).
> > 
> > Fix it by checking if err is lower than zero.
> > 
> > This wasn't found in real usecase, only noticed. Credit to Pierre.
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  net/devlink/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/devlink/core.c b/net/devlink/core.c
> > index f49cd83f1955..7203c39532fc 100644
> > --- a/net/devlink/core.c
> > +++ b/net/devlink/core.c
> > @@ -117,7 +117,7 @@ static struct devlink_rel *devlink_rel_alloc(void)
> >  
> >  	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
> >  			      xa_limit_32b, &next, GFP_KERNEL);
> > -	if (err) {
> > +	if (err < 0) {
> >  		kfree(rel);
> >  		return ERR_PTR(err);
> >  	}
> > -- 
> > 2.42.0
> > 
> > 

