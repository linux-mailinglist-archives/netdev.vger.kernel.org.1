Return-Path: <netdev+bounces-124156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42816968545
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F911F25795
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39A18453F;
	Mon,  2 Sep 2024 10:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1718453E;
	Mon,  2 Sep 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274180; cv=none; b=Hgl7NMHeSViKOHGoaDBkzvksqGkG9y58V7S6aeaTD3Nr2VB44xwNkif5y5hV1Cm13pLTlYdSxzboeLwvTz519dvhViUI22UrkUac8DpnwlARBX1w7JUDKL7JtUVkuOVw9NVUqDBRDg0FDYnqh72yRlk4W7+Cu1uegM1HvSqKDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274180; c=relaxed/simple;
	bh=4qo7eUTb/ms9n952NasE1nZfFMCDySAeQvHv0tBkAXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guj55T2DWnSL57O68lllnH0wj1yE1kMtdprpu7ShZw9gfAaFhC5KmekkeCQg3eSf+l3HOKuJLIakZJ8Pnc+q/vEVxWFoJBWckO1nfS82IDsvz7OUocR75LhliwNs9A26u7AVuWx54vc86ZBB+ILe1ktkvRmuR2siGHMV+vGvHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: zLOrOyAMQoWMCoSt+wwxsQ==
X-CSE-MsgGUID: oRRKfw3pRmOYU0+EBtrIFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41350232"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41350232"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:49:37 -0700
X-CSE-ConnectionGUID: z2YZOsV+QOSHt+7yVBwuQQ==
X-CSE-MsgGUID: M1PbC1uaQA68058osujaZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69445533"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:49:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sl4cl-00000004KVH-2dzm;
	Mon, 02 Sep 2024 13:49:31 +0300
Date: Mon, 2 Sep 2024 13:49:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, kees@kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Message-ID: <ZtWYO-atol0Qx58h@smile.fi.intel.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831130741.768da6da@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 01:07:41PM -0700, Jakub Kicinski wrote:
> On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
> > Use str_disabled_enabled() helper instead of open
> > coding the same.

...

> >  		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
> > -			   arg ? "disabled" : "enabled");
> > +			   str_disabled_enabled(arg));
> 
> You don't explain the 'why'. How is this an improvement?
> nack on this and 2 similar networking changes you sent

Side opinion: This makes the messages more unified and not prone to typos
and/or grammatical mistakes. Unification allows to shrink binary due to
linker efforts on string literals deduplication.

That said, I see an improvement here, however it might be not recognised
as a Big Win.

And yes, I agree on the commit message poor explanations.

-- 
With Best Regards,
Andy Shevchenko



