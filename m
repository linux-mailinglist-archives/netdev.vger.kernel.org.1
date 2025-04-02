Return-Path: <netdev+bounces-178799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A28A78F3E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79D3169C9F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDB238D5A;
	Wed,  2 Apr 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6J81XOe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70E238D2B;
	Wed,  2 Apr 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598681; cv=none; b=pyCkUiD/5QGVg3AoZHC9oWAioeBjpz65nZUAtVByOTnz7c297hql5ml9OaW2tO0LZWUQ5sygW+Pbu8/roBL3rNB/0GmAvI9pFl1pniMEIGCkusagI9Q7mIudi5QwHazn5JiTLs8QxfxJFdpk6g7VGNZm0KKrMZ4ws6fToHdc6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598681; c=relaxed/simple;
	bh=9PaKlNBLrieA3abOkdoYAAKdlkNEcWYYrdczTHWO80Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDrA7rq8eW/H5ZR2wiGS8XYRyqGfasi0i6AYI1PTL5gYTpOkGCK7R7Kvs+lNsXlLpoawSfNyDOEx8vyIvLbF2eGZJxZo7cVKx2vzV5ripfnmCI7tuMo/niI5zvCWvUV/HgkMdKzWbJS6XYg+XI0feLNXAPW0SBJDsBciOIvOCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6J81XOe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743598680; x=1775134680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PaKlNBLrieA3abOkdoYAAKdlkNEcWYYrdczTHWO80Q=;
  b=W6J81XOe8CrL8iI/ldQGmNDrsZb+tB2zqWhfo8GfJ9hpWmuA3IvTOmZS
   xVe/EiysQawI3IL/mSjCJ2RHb7u71NVeAHYR+x6Aaaw6XL0tmG7gXiAOL
   5bM1peRYaZ7TcphpYui/w2Vtldsv5nTYJjPDKLDMW36m58F8GuveMyoML
   +E0HzZYQvufNaJnumKhhBXzM84aC9XfLY6xIX3IhOMQNTY94A0Caqt9H6
   R1a3P8RmItSBk3WANO5fDWsQmouqF+gwdItGs3uFfLJM1mdZYlUU6/FVq
   VdFz4wtL/rO9cC3waBJG1DhMFEZ1rVGa/B69SqPSp9b7Atf9ADSvmuHHb
   w==;
X-CSE-ConnectionGUID: 7CumzsYTQpG5jOOCS5TiPQ==
X-CSE-MsgGUID: bDEEc/8STciODFy9poPBhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48750387"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="48750387"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:58:00 -0700
X-CSE-ConnectionGUID: /xJdOPYHT0W4RBku5oc+fw==
X-CSE-MsgGUID: md2FkTnQT4etxJfUUnTQ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149880473"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:57:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzxfG-00000008Tqt-2q8U;
	Wed, 02 Apr 2025 15:57:54 +0300
Date: Wed, 2 Apr 2025 15:57:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-00UkrBC1TRnoqA@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
 <20250402121935.GJ25239@noisy.programming.kicks-ass.net>
 <20250402122224.GB25719@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402122224.GB25719@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 02, 2025 at 02:22:24PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 02, 2025 at 02:19:35PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 02, 2025 at 01:32:51PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> > > > Add auto_kfree macro that acts as a higher level wrapper for manual
> > > > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > > > well defined behavior also for the case code would lack other assignement.
> > > > 
> > > > Consider the following code:
> > > > int my_foo(int arg)
> > > > {
> > > > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > > 
> > > > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > > 	/* ... */
> > > > }
> > > > 
> > > > So far it is fine and even optimal in terms of not assigning when
> > > > not needed. But it is typical to don't touch (and sadly to don't
> > > > think about) code that is not related to the change, so let's consider
> > > > an extension to the above, namely an "early return" style to check
> > > > arg prior to allocation:
> > > > int my_foo(int arg)
> > > > {
> > > >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > > +
> > > > +	if (!arg)
> > > > +		return -EINVAL;
> > > >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > >         /* ... */
> > > > }
> > > > Now we have uninitialized foo passed to kfree, what likely will crash.
> > > > One could argue that `= NULL` should be added to this patch, but it is
> > > > easy to forgot, especially when the foo declaration is outside of the
> > > > default git context.
> > 
> > The compiler *should* complain. But neither GCC nor clang actually
> > appear to warn in this case.
> > 
> > I don't think we should be making dodgy macros like you propose to work
> > around this compiler deficiency. Instead I would argue we ought to get
> > both compilers fixed asap, and then none of this will be needed.
> 
> Ah, I think the problem is that the cleanup function takes a pointer to
> the object, and pointers to uninitialized values are generally
> considered okay.
> 
> The compilers would have to explicitly disallow this for the cleanup
> functions.

Hmm... What I have heard is that the cleanup is basically a port of
C++ destructor code to C, and it might be related to the virtual functions
that are may be absent for the basic classes. But not an expert here,
just speculating based on my poor knowledge of C++.

-- 
With Best Regards,
Andy Shevchenko



