Return-Path: <netdev+bounces-58497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A679F816A7B
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4752FB22959
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494A12B9C;
	Mon, 18 Dec 2023 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJEimdCA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AE13FFA
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702893853; x=1734429853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xau6FfY6cJYcx74QeZNFilfaqFW7Wb7Ey39DkVPnAUs=;
  b=MJEimdCAW51V/bJvtgY9h2rrGSvM8DLJdYbxG1dwXvNhqffqWbtswf9D
   yrgnihiNuNY7/4fIXxF3ZPOoH/mrBipQ5Yosf56rrClYwx6xOyY3az5MB
   lW9+A82+nL1E5aYWCorjP2nOkqwKEd19XNKIqRtAb8NM2aotipSTfRWTK
   tzi5nV4nRS+m41qTvjAEWVKGsThpci7HinZQHEYbHFfO14ZCbVvhLtB6k
   noxRhu+BEwf53cS1tQnu0AoLcmA+dGdu3GN+YfpRBnKUEzzJrDTp71VXg
   DrB/OEI/5czy77UGUwSF02Em4RypS7FdHsjX53uStM/VNfkR8ydOGPuxg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2690674"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="2690674"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 02:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="17121598"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.249.146.117]) ([10.249.146.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 02:04:09 -0800
Message-ID: <ff8cfb1e-8a03-4a82-a651-3424bf9787a6@linux.intel.com>
Date: Mon, 18 Dec 2023 11:04:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 pabeni@redhat.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 idosch@nvidia.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, jiri@resnulli.us
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
 <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
 <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
 <20231215084924.40b47a7e@kernel.org>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20231215084924.40b47a7e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.12.2023 17:49, Jakub Kicinski wrote:
> On Fri, 15 Dec 2023 11:11:23 +0100 Alexander Lobakin wrote:
>> Ping? :s
>> Or should we resubmit?
> 
> Can you wait for next merge window instead?
> We're getting flooded with patches as everyone seemingly tries to get
> their own (i.e. the most important!) work merged before the end of 
> the year. The set of PRs from the bitmap tree which Linus decided
> not to pull is not empty. So we'd have to go figure out what's exactly
> is in that branch we're supposed to pull, and whether it's fine.
> It probably is, but you see, this is a problem which can be solved by
> waiting, and letting Linus pull it himself. While the 150 patches we're
> getting a day now have to be looked at.

Let's wait to the next window then.

Thanks,
Marcin

