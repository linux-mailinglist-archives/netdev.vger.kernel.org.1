Return-Path: <netdev+bounces-178761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC00A78C82
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1743AFB5E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD5236430;
	Wed,  2 Apr 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1aFb88F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0F2EB1D;
	Wed,  2 Apr 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590427; cv=none; b=Wu4VSEAqsbSRa6oa+cPlHM6kptfyKhsURpECiSPN7VXVNyqLdPWqHB3WLH6MO0HYfhE7IEg6zRWnocBh18mAu6qI22MxnX6yWhscShYeBXpaGKbsuGLq9ws6aAZeYGhDhI3BRKf0GU5ufRJxCk4SU2QiePHwTS6Ond+up0lF2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590427; c=relaxed/simple;
	bh=CoY9PcV0OuQT2I+HqoR9fOe7ZJeqTGaH6ofEwP5Qw60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOo6G4wrSbPVL4PUDLVua4UlLM+3SJkefkIX9ahKyxBtIxjE8mRe7sN2nuBJ9rQSFsTxr6QU8/J+5fTsrG/039djNxd6DcEyKVcJWWWdfz3ofOukYwyxARmFMEYno3cZa+Q56XEXDF1rPOz71PnEOifPl1/79ciK4qdRMX5p8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1aFb88F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743590426; x=1775126426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CoY9PcV0OuQT2I+HqoR9fOe7ZJeqTGaH6ofEwP5Qw60=;
  b=I1aFb88Fa5UK8nhzufZm3S8Ac0r3ZcDcqXv4jA/jVyKHNowAWIUo2nq9
   rXkgJ9jwYQLguJqakv+fY/exTgCmljIT5ONQcgjKlZiQKPz7XXFcbepA3
   zt6gmstIZQ6lSVo08YeO6c2jraP3tmgVjdRt2MB9vLRDhz8P+AytYAM0Y
   Ci+bG74UqXOeFF2rq6oM9FcZaq6khMODlZgPJccHcqFkSSy0maGSaYNFi
   EnNSEH0OeMq+QHch25jSKZDlryvTdfCTi5jgJC1wSdjV/aAiuXEQ0gxCL
   8irn2KBtO9DTrmBU8F2L6UG6i6pKPcom13aWP9H0OYYnDDl6EzFaKo6Ut
   Q==;
X-CSE-ConnectionGUID: NZMFY0DgSuO9XAMKSE+/Iw==
X-CSE-MsgGUID: J9wlQD62Q525x5hUNdqriQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44094637"
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="44094637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:40:25 -0700
X-CSE-ConnectionGUID: MYYHhJdkTrmZBOSTYrqHtg==
X-CSE-MsgGUID: XTbPLY+pQv61IgbZ7SJ4ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,182,1736841600"; 
   d="scan'208";a="126639518"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 03:40:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzvW8-00000008RM3-2kDU;
	Wed, 02 Apr 2025 13:40:20 +0300
Date: Wed, 2 Apr 2025 13:40:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, peterz@infradead.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-0UFCoxFRstPIBX@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 02, 2025 at 01:32:52PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> > Add auto_kfree macro that acts as a higher level wrapper for manual
> > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > well defined behavior also for the case code would lack other assignement.
> > 
> > Consider the following code:
> > int my_foo(int arg)
> > {
> > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > 
> > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > 	/* ... */
> > }
> > 
> > So far it is fine and even optimal in terms of not assigning when
> > not needed. But it is typical to don't touch (and sadly to don't
> > think about) code that is not related to the change, so let's consider
> > an extension to the above, namely an "early return" style to check
> > arg prior to allocation:
> > int my_foo(int arg)
> > {
> >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > +
> > +	if (!arg)
> > +		return -EINVAL;
> >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> >         /* ... */
> > }
> > Now we have uninitialized foo passed to kfree, what likely will crash.
> > One could argue that `= NULL` should be added to this patch, but it is
> > easy to forgot, especially when the foo declaration is outside of the
> > default git context.
> > 
> > With new auto_kfree, we simply will start with
> > 	struct my_dev_foo *foo auto_kfree;
> > and be safe against future extensions.
> > 
> > I believe this will open up way for broader adoption of Scope Based
> > Resource Management, say in networking.
> > I also believe that my proposed name is special enough that it will
> > be easy to know/spot that the assignement is hidden.
> 
> 
> I understand the issue and the problem it solves, but...
> 
> > +#define auto_kfree __free(kfree) = NULL
> 
> ...I do not like this syntax at all (note, you forgot to show the result
> in the code how it will look like).
> 
> What would be better in my opinion is to have it something like DEFINE_*()
> type, which will look more naturally in the current kernel codebase
> (as we have tons of DEFINE_FOO().
> 
> 	DEFINE_AUTO_KFREE_VAR(name, struct foo);

Maybe slightly better name is

	DEFINE_AUTO_KFREE_PTR()

as we expect this to be a pointer.

> with equivalent to
> 
> 	struct foo *name __free(kfree) = NULL

-- 
With Best Regards,
Andy Shevchenko



