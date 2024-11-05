Return-Path: <netdev+bounces-142001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B979BCEE3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3E2846DE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D71D63C4;
	Tue,  5 Nov 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW4/qWqh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB31D54F4;
	Tue,  5 Nov 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816157; cv=none; b=UTn2RFcG1wq+TEZcuOBX/3gFBz3Lty40EG4W/We6reHIMgPHjGsNvhuft1nUZjZkqfI+NQIsidlVPt2x0ecvZdh1yAHjo7X8RPkiDsDevSDFVUnqJbnz2d0vvL+/pOpWze9Aa+V54AQj8KjaNvL9hvnEP4LTV6z9l89IKllxMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816157; c=relaxed/simple;
	bh=UwUee+AJ5IsJhO3fm3A0MDvNU56xubXQY38rELKG15w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDFxkmxt03vk7avbW0BENwaYgmIwIWvY4IGoQ7s28Koa94+elNr6x7JMKgTk1FxuGib0YkVF2bytsiJzMCW8Ercx/Hy7i6vBk8cyef9iwk903OQZaS79vv39H7U4Z8XE+w1uSl9NuMQ5BC7Sd7KIw3bqeITKStnEnVYuaWFxHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW4/qWqh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730816156; x=1762352156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UwUee+AJ5IsJhO3fm3A0MDvNU56xubXQY38rELKG15w=;
  b=bW4/qWqhdPHzQbs3Ms0XIEcgBwqWR+5gaAgoToXl0N+6+NQqtMGEfvqg
   DikRkpT7z+8cJ/CjipbsRP4heHIOsjpEnF5ceDKacESgOH7w3bbQsDApa
   /a72VFaMr3U8AfZ/JVHwt8UtBu/88sHZY64hAZeG0QlzlETdc3+vyyXco
   YLq5jiK7QLIzdxY6wnTY5EOGPU5fkrujAFwiaGtt4BM9573+Hgc1H81E+
   oiRqoogSZ7/YINNikz7SQvroSFfs+Pjs0BXtxMSty8W9OABHlXYy7yeqg
   wsMLl/+fB5ayg49TcpOEYEwpcCilPD3928WIrpUeXf72aBs6LlXPHVGeV
   Q==;
X-CSE-ConnectionGUID: kyp6rP1ARFqtb0ab/ckyGg==
X-CSE-MsgGUID: fSmwV0IrR0SkIcXoWd1s1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30415132"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30415132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:15:56 -0800
X-CSE-ConnectionGUID: zojLoOgPTVa/8rTxwMe0KQ==
X-CSE-MsgGUID: bf8+OHs/QBa1yWseXVvYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84158056"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:15:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8KLX-0000000BQUO-2vQG;
	Tue, 05 Nov 2024 16:15:51 +0200
Date: Tue, 5 Nov 2024 16:15:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Message-ID: <Zyool7zZtcfOvy8h@smile.fi.intel.com>
References: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
 <20241103081740.7bc006c1@kernel.org>
 <ZyiChsS_zrHlet3E@smile.fi.intel.com>
 <20241104182941.342c3b7a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104182941.342c3b7a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 04, 2024 at 06:29:41PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Nov 2024 10:15:02 +0200 Andy Shevchenko wrote:
> > So, you are welcome to help developing such a tool.
> 
> FTR I find saying such things to maintains very, very rude.

Sorry, it wasn't meant to be that. Let me elaborate. The tool is really
what we need, but seems nobody is ready to invest time into its appearance.
It would great and appreciated to have a consolidated work towards that.

> > Can we have this being applied meanwhile, please? It's a showstopper for
> > getting rid of of_gpio.h rather sooner than later.
> 
> Doing this cleanup as part of deleting a deprecated header seems legit.
> But you need to say that in the commit message.

Thanks for review, I will address then in next version.

-- 
With Best Regards,
Andy Shevchenko



