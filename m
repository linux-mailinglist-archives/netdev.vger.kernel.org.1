Return-Path: <netdev+bounces-182096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2DA87C15
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12793A7029
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D9261381;
	Mon, 14 Apr 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEHudgZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F271ACECD;
	Mon, 14 Apr 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623715; cv=none; b=dH9MhWhVwa0lr15Nfpre4QqtQs8AVwFKo3rWgR3OhTMAeJMpF1sG/+nScEormt2O1KjmIYH1c8JSq4pi10EGW1FPuUWrHRNZswRnUu3f3+pZy0lGF41MGNDlb3VNz7xTRk4EYRX4KMz9daJ+Y4pSLn09hkyJa8/ump6kp4FZbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623715; c=relaxed/simple;
	bh=HESKiQDsGmkF6MyUv/is1NIBBgXIVGAlmjj3/sqJxdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwlDmhpsxmU8+J8XqtocDkC1PBQQGTQXdBAboOliFBnl0gdCKCDH/kxPOvv7H9YaEhpGCkxS8zrAorR8ZAESTWhhuAZrv/ZboHGMY9E6P75H1bTwxL51ObFF2C1/tUdEUJgl0C/Izei29r5hR2j4KIOt1pLlmEG8ZIQa+kXLbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEHudgZN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744623714; x=1776159714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HESKiQDsGmkF6MyUv/is1NIBBgXIVGAlmjj3/sqJxdc=;
  b=SEHudgZNlGmKDkEfL1yXHaxLxuNdhjIgn3GZeKTTaHJGSbElZuN7gbRp
   UZf19ErBX6FqDYILWBGf1OCttMD6whLfNyy0GYfKvnOSQw9zOvU1K+bF6
   U5objI1YgtkIsXzF4zV9T2IgTEZ3KWDxvKJ1w33E4iB/wChxgMjxgQ5Kl
   4Ugg+YZlpxOm0YtXjaIck0JZfyChptCvnHHtvk9IemABLwKie5t+EDfV3
   utUJuBnOWWyknQuMxqzUTJDqJ62Rpr9InVYskyr2khDiG3blpWOSEyH8M
   yRt68lxAwx501MHxKuGtujBOrs6jc35BbHExo721SwEzkTeTzTFObckPL
   g==;
X-CSE-ConnectionGUID: b83k9IILRn+6ppILhZfGYQ==
X-CSE-MsgGUID: xtlvsXquQDu03nqgiXr4FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57451976"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57451976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:41:53 -0700
X-CSE-ConnectionGUID: QILs7P9hT2GdVjR+dt2dVQ==
X-CSE-MsgGUID: ecnqt37XRxCTiivTMBJTZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="133871789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 14 Apr 2025 02:41:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F35AC8A2; Mon, 14 Apr 2025 12:41:48 +0300 (EEST)
Date: Mon, 14 Apr 2025 12:41:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pu1193r.fsf@trenco.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > This changeset contains the kernel-doc.py script to replace the verable
> > kernel-doc originally written in Perl. It replaces the first version and the
> > second series I sent on the top of it.
> 
> OK, I've applied it, looked at the (minimal) changes in output, and
> concluded that it's good - all this stuff is now in docs-next.  Many
> thanks for doing this!
> 
> I'm going to hold off on other documentation patches for a day or two
> just in case anything turns up.  But it looks awfully good.

This started well, until it becomes a scripts/lib/kdoc.
So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
"disgusting turd" )as said by Linus) in the clean tree.

*) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.

-- 
With Best Regards,
Andy Shevchenko



