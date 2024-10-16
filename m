Return-Path: <netdev+bounces-136098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98F9A04CD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46C1287F1D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBFF204F7C;
	Wed, 16 Oct 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqhy/7mI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27B204959;
	Wed, 16 Oct 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068954; cv=none; b=Fl1I6jOk+i0BwRVmQH6gq4wce0rhlwtvqxIP465zRBDPoKZyCuDs68i+F1toZBTOCdbxt0SKF4ip9tKQVei/Pym7ToMiPGNdPV53Qwzy6nqHa1fSRLluMa+AHJ0x4ouHdWSOvnoywx/7L2gxVVV83LXIWR+pQnEPPc2dcLJ2v14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068954; c=relaxed/simple;
	bh=4Djsh/XKHn1ysqUqOiytXqTEGO8sI6c/hzSMgetUGcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiS70Fv4GbYaXCX+4GOpRs76Uf59V4jQC4CMKzhXqyZkRwR6X3S9WpDbvk5IScqh2gGKpjQrbMl3CIFDu+U8A1WWqjzzF1dYYt2P7Q743N+6ZttWg+LoUvIdGF3DZ9tYUeKPgYn47100dOEDNgYLX/JCNzkFwag0AsftQX+Ustw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqhy/7mI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729068953; x=1760604953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Djsh/XKHn1ysqUqOiytXqTEGO8sI6c/hzSMgetUGcs=;
  b=iqhy/7mI79SMFSvf/aAVLapQzrPhIgj2YPMLeUS2CATamLeKkvb1MiM+
   VwqP0H23Wcp3nHjV2PTAZygBgGqy0HOJjBAJzW43QC6OfB2EQh0e/NtSx
   WR+uxb0Tt5FwAZAZrBap5QsOSFqWL3JV3Uxk4hn3hQily+uYELb9nQB2E
   ayG21boNsElkJD8tBewzDgCbm+zNJ2kk07W9RdhRNdNvD4Y03/b6eQhqQ
   xTqUVH+Z20ruQUlfX4CDtxDmJQ0yE6Jl+LpTHe/zl29vkh5oeZ+FZhBxb
   TZ62TdW5BLvCEZdyUJGF1MH4kDB2D6GJWkXi+P/GEbbmlZhcoiPUiASqm
   Q==;
X-CSE-ConnectionGUID: VwjCpZ60Q5OdXjeJOqSYjg==
X-CSE-MsgGUID: jgdRF/GKRPChgs2h1aLocQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39893813"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="39893813"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 01:55:52 -0700
X-CSE-ConnectionGUID: dUhHDUN1SvSt8subDfpfWw==
X-CSE-MsgGUID: 39KKPkUnQnub3BYDZ5vfEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78618168"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 01:55:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t0zop-00000003hJ6-2Ws1;
	Wed, 16 Oct 2024 11:55:47 +0300
Date: Wed, 16 Oct 2024 11:55:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] tg3: Increase buffer size for IRQ label
Message-ID: <Zw9_kzsxy5npUNXk@smile.fi.intel.com>
References: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>
 <20241015081621.7bea8cd7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015081621.7bea8cd7@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 15, 2024 at 08:16:21AM -0700, Jakub Kicinski wrote:
> On Mon, 14 Oct 2024 13:38:10 +0300 Andy Shevchenko wrote:
> > While at it, move the respective buffer out from the structure as
> > it's used only in one caller. This also improves memory footprint
> > of struct tg3_napi.
> 
> It's passed to request_irq(), I thought request_irq() dups the string
> but I can't see it now. So please include in the commit message a
> reference to the function where the strdup (or such) of name happens 
> in the request_irq() internals.

Hmm... you are right, the name should be kept as long as device instance alive
(more precisely till calling free_irq() for the IRQ handler in question).

I will redo this part (currently I'm choosing between leaving the name in the
structure or using devm_kasprintf()for it, I'll check which one looks better
at the end).

-- 
With Best Regards,
Andy Shevchenko



