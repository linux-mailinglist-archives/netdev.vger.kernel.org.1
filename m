Return-Path: <netdev+bounces-171644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77DA4DF7B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5515E189C896
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF97204873;
	Tue,  4 Mar 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFK7dlAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF22040A7;
	Tue,  4 Mar 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095688; cv=none; b=M5C6DSb9tV+80A+BZyERGSC9KcY4psib8bwcUssWZOp8Ol+pby0sWW58uRGklogJvYgalSSqI0vItxf5lHWpBhT3ggloCtVb4z0R4tc/DTu088J48K1q+wIsTJyc4nru47rQOkcj9EpgtIaA2Gtex/jo9HpszfRq5OaRmU8yPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095688; c=relaxed/simple;
	bh=wc1UNrJsxGJ6+Qe6X4SKbbXboJB4eQoAwk0XLhcY4D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5NsZnNI1Saqnj/3j0GrgfQYlSVJymPNHJDgY7T6do6vCm2x+QR749vQUHS0WiUnexUB/PEDcZhnG4y4NM5dcB4qce/0yhjWw2Dc0erSjbEP9CkPCEkJjyfClwasGILtDIFr4MJeFXwED5g3yXzx4DM+ssxzxRExD7lOESLH480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFK7dlAJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741095686; x=1772631686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wc1UNrJsxGJ6+Qe6X4SKbbXboJB4eQoAwk0XLhcY4D8=;
  b=nFK7dlAJwKWoMckdYkjs8ELDaulB2uXoqIkpqDLtfgHMYIY6t3lt556q
   92KaRpbKe4SIOwp3gi1zJ4lsisBT65Wauy0B/2TM6KkPGiJeCKbAM/TZ5
   zsIDR52bk8tmuBsdCxgnNS2NzkcUQhQMr66jeHxeYN6wJIh+uosheNMpF
   5gW2yfAM10eVkwC6Rtgl4ZJLGfXmv003ChYr/bEGoDwLfPBsXMn5Y8gGj
   48ZAp1iHA8eRWZw07aZJVCjts9Qquwbogw8TpG8C/pq/ZMjnbYXsHrl9O
   rkl2OZhu7kwm2U5K2eTBxU4jrBx/+aX8LpGFPWgQTvyCRS8PE3MDs7I9s
   A==;
X-CSE-ConnectionGUID: 1E2yZxjuQnSmdKNcdU6V0w==
X-CSE-MsgGUID: Rb9KHYqOTpKws14zfvVDIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59561880"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59561880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:41:25 -0800
X-CSE-ConnectionGUID: splVJdNjS5iU0bheBNU5xA==
X-CSE-MsgGUID: leBTF+YQQAG4vlUBpHMb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118897735"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:41:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpSWN-0000000H8XD-2zrL;
	Tue, 04 Mar 2025 15:41:19 +0200
Date: Tue, 4 Mar 2025 15:41:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org>
 <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
 <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 01:58:33PM +0200, Andy Shevchenko wrote:
> + Marek/Christoph (for the clarification/commenting on the below)
> 
> On Tue, Mar 04, 2025 at 12:39:40PM +0100, Paolo Abeni wrote:
> > On 3/4/25 11:56 AM, Andy Shevchenko wrote:
> > > On Mon, Mar 03, 2025 at 05:21:14PM -0800, Jakub Kicinski wrote:
> > >> On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
> > >>> In some configuration, compilation raises warnings related to unused
> > >>> data. Indeed, depending on configuration, those data can be unused.
> > >>>
> > >>> Mark those data as __maybe_unused to avoid compilation warnings.
> > >>
> > >> Will making dma_unmap_addr access the first argument instead of
> > >> pre-processing down to nothing not work?
> > > 
> > > I looked at the implementation of those macros and I have no clue
> > > how to do that in a least intrusive way. Otherwise it sounds to me
> > > quite far from the scope of the small compilation error fix that
> > > I presented here.
> 
> > I *think* Jakub is suggesting something alike:
> 
> I see. Perhpas we need Marek's/Christoph's opinion on this...
> 
> > ---
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index b79925b1c433..927884f10b0f 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -629,7 +629,7 @@ static inline int dma_mmap_wc(struct device *dev,
> >  #else
> >  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
> >  #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> > -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> > +#define dma_unmap_addr(PTR, ADDR_NAME)           (((PTR)->ADDR_NAME), 0)
> >  #define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> >  #define dma_unmap_len(PTR, LEN_NAME)             (0)
> >  #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> > ---
> > 
> > Would that work?

Actually it won't work because the variable is under the same ifdeffery.
What will work is to spreading the ifdeffery to the users, but it doesn't any
better than __maybe_unsused, which is compact hack (yes, I admit that it is not
the nicest solution, but it's spread enough in the kernel).

> I do not know. Not my area of expertise.

-- 
With Best Regards,
Andy Shevchenko



