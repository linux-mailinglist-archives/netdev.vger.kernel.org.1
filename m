Return-Path: <netdev+bounces-124594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030E96A1B4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3ECB21182
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44B189BAE;
	Tue,  3 Sep 2024 15:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE71885A0;
	Tue,  3 Sep 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376149; cv=none; b=bPw8yI31ptXxtfg2qrGUSQkT6PhNIu+7Iqv2RMUnHwcs7z5+bTNvA6IfOoE85zBNLaIAaQbgIMtwIokJIBLwPtxBlXTNJlJ8fb8xCE/UDIz5OlaOFZmF0OgIF0B2E8qttkBEIPv5Y13/DlE8MF6NHlx9COYAvb/96MqaGSrJHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376149; c=relaxed/simple;
	bh=B7aDdTXMk0Qrpb0aFrz/n4ezzXaHtINJL0/Z/0t08V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGB9YWwHjEyrXWR2CS8BJukQY10gdGf1mZpdAFZYeqIBUjq5vAllSgZ2If9TYcJNNXJlppha1UQj/4PBgAU+wTx8ZrdS6uBm2XieutRRg/kVYMwoB3Cn828W93LaesQwjVe5jjMzrt6OvPgOpr8F5BZPlSp/MRjr07SObLEB7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: aup8Ek5GTbCDBo8JO6asxA==
X-CSE-MsgGUID: gs842ZGaThSZv7XL86bSrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41453772"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41453772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:09:07 -0700
X-CSE-ConnectionGUID: iVinaASRSkSiO4U2LiTn/g==
X-CSE-MsgGUID: FvYmrQO5SBWgR1VrURNeQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69799370"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:09:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1slV9R-00000004kPt-0R69;
	Tue, 03 Sep 2024 18:09:01 +0300
Date: Tue, 3 Sep 2024 18:09:00 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, kees@kernel.org,
	jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Message-ID: <ZtcmjI-C3zfqjooc@smile.fi.intel.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org>
 <ZtWYO-atol0Qx58h@smile.fi.intel.com>
 <66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
 <9d844c72-bda6-4e28-b48c-63c4f8855ae7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d844c72-bda6-4e28-b48c-63c4f8855ae7@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 02:25:53PM +0800, Hongbo Li wrote:
> On 2024/9/2 22:30, Willem de Bruijn wrote:
> > Andy Shevchenko wrote:
> > > On Sat, Aug 31, 2024 at 01:07:41PM -0700, Jakub Kicinski wrote:
> > > > On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:

...

> > > > >   		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
> > > > > -			   arg ? "disabled" : "enabled");
> > > > > +			   str_disabled_enabled(arg));
> > > > 
> > > > You don't explain the 'why'. How is this an improvement?
> > > > nack on this and 2 similar networking changes you sent
> > > 
> > > Side opinion: This makes the messages more unified and not prone to typos
> > > and/or grammatical mistakes. Unification allows to shrink binary due to
> > > linker efforts on string literals deduplication.
> > 
> > This adds a layer of indirection.
> > 
> > The original code is immediately obvious. When I see the new code I
> > have to take a detour through cscope to figure out what it does.
> If they have used it once, there is no need for more jumps, because it's
> relatively simple.
> 
> Using a dedicated function seems very elegant and unified, especially for
> some string printing situations, such as disable/enable. Even in today's
> kernel tree, there are several different formats that appear:
> 'enable/disable', 'enabled/disabled', 'en/dis'.

Not to mention that the longer word is the more error prone the spelling.

> > To me, in this case, the benefit is too marginal to justify that.

Hongbo, perhaps you need to add a top comment to the string_choices.h to
explain the following:
1) the convention to use is str_$TRUE_$FALSE(), where $TRUE and $FALSE the
respective words printed;
2) the pros of having unified output,
3) including but not limited to the linker deduplication facilities, making
the binary smaller.

With that you may always point people to the ad-hoc documentation.

-- 
With Best Regards,
Andy Shevchenko



