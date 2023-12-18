Return-Path: <netdev+bounces-58520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A4816BC3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C22B21D4F
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C8182AE;
	Mon, 18 Dec 2023 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWZIFjtg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766171944E
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702897289; x=1734433289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p81cZZI5JVaAXSCoMB8hlc4nBFfaT21CuWf9TjinyFI=;
  b=IWZIFjtgxelQen2sjHQJBXd9ZI723qoQHTncpq0LiWnCkVaX37pI5gPF
   npbWa1EqeYO1vbDqc+XcY+E7euNfr5N2LFA7J8EmGbXrG9mhIGHc+7ILQ
   olttAw0FbncbbrxhEgWrwv8oRkDiLRnp2eN0S3ObQj5b5MWOLzAd7droS
   JN6wiuS7dpmYCHWtcxaZ2IaasLU9zfmNJSBR1cr6dLbwrfCZKkVLeJLVX
   Wq3Mw5Qgb9LS3r3VlQQrSN5OgCg80uVrSjpTqr/pr8IguiO4wiQaa+djn
   k385f29DSj1vOYcDhzh5ynBkjRHmzbaVzXo2LmnXtc3MgToyDlPWlSW5O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="392659383"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="392659383"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="1106897029"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="1106897029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:01:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFBMz-00000006u9n-3drX;
	Mon, 18 Dec 2023 13:01:09 +0200
Date: Mon, 18 Dec 2023 13:01:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v8 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZYAmdSSos_lIjAxH@smile.fi.intel.com>
References: <20231216123001.1293639-1-jiri@resnulli.us>
 <20231216123001.1293639-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216123001.1293639-6-jiri@resnulli.us>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 16, 2023 at 01:29:57PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce an xarray for Generic netlink family to store per-socket
> private. Initialize this xarray only if family uses per-socket privs.
> 
> Introduce genl_sk_priv_get() to get the socket priv pointer for a family
> and initialize it in case it does not exist.
> Introduce __genl_sk_priv_get() to obtain socket priv pointer for a
> family under RCU read lock.
> 
> Allow family to specify the priv size, init() and destroy() callbacks.

...

> +	void			(*sock_priv_init)(void *priv);

Can in some cases init fail? Shouldn't we allow to propagate the error code
and fail the flow?

> +	void			(*sock_priv_destroy)(void *priv);

...

P.S> I'm fine with either, just consider above as a material to think about.

-- 
With Best Regards,
Andy Shevchenko



