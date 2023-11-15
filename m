Return-Path: <netdev+bounces-48065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4407EC6BB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7141C20869
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DD35F14;
	Wed, 15 Nov 2023 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKcoMZvO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAAD2EAF3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:08:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB27121
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700060934; x=1731596934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FYUli/nV859yPXetHfjK/XHs5rsvuoBd4z816qvLNrk=;
  b=AKcoMZvOLLwblY8CLq410wTnvzPJBO75lpq0Seq4nD6Js0Z5QEmuI8ST
   tbREi7TmiDPyYTzfQ9od1G4wkg1NMt0sKKY8iZixGiouj3nDzgljjr/3M
   Zk6Vh6I9+ma7QbiUu14uDi071VswiFTmpUaZ5lMJKSWEJ21WGWfUhVomz
   V2kVNEvaCjpayVZa7jlo43mVk26vbi6H0yZuqTU95sxb3eM42F6PGfyNg
   t8AC6HAzs6PuHRe/4pABvAeuyJx7R/7ZQJtkId+x834b5y8a+UqD+ItPN
   FDXblkoIN1plAIpgYEgSzoWF228KUatdZBdSVj2EvPBnZn3oKG2BP1kbl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394810583"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="394810583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758514928"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="758514928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:08:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r3HVX-0000000ELTm-1BWa;
	Wed, 15 Nov 2023 17:08:47 +0200
Date: Wed, 15 Nov 2023 17:08:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 8/8] devlink: extend multicast filtering by port
 index
Message-ID: <ZVTe_nJ_0N4KnDkd@smile.fi.intel.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115141724.411507-9-jiri@resnulli.us>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 15, 2023 at 03:17:24PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Expose the previously introduced notification multicast messages
> filtering infrastructure and allow the user to select messages using
> port index.

...

>  	struct {
>  		__u32 bus_name_len;
>  		__u32 dev_name_len;
> +		__u32 port_index:1;

From this context is not clear why others are not bitfields.

>  	} _present;
>  
>  	char *bus_name;
>  	char *dev_name;
> +	__u32 port_index;

-- 
With Best Regards,
Andy Shevchenko



