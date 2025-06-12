Return-Path: <netdev+bounces-196929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36DAD6EE7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDDB1BC01E6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999E23A566;
	Thu, 12 Jun 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7mFikYx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CB205AA3;
	Thu, 12 Jun 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727315; cv=none; b=GD/wu5aMMfnTQplAuizq36rAz4btasNQou5jfIMZuDJedmabl/LxlaiWC/lHTzSb2nt7XPqK7xECi9Ld1jFYXXCL6en09SpspBDQkGwDlEmZJ9JW6cVjf2HA3IrdomRWLwOtaknjocctWFw/jerFUiYvejPpf0AuVLS1cFcGWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727315; c=relaxed/simple;
	bh=kTC8uxKsbrWlLLBTcToPBHyavEBjAw+eccYqlwX55zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjmKYxJY59TjRle4IOHRd6ZBlVJbhzcEgD8NzZF0qIZVLfNAWztNDjnsXqtPd9JUM6eeS2QNBUxgBHKZ5hi4qCdlfhW8PXEZS87R7xNSufXwIoDVMKZxJ8uN/VZrWBT0MW60zDwXCKuk10vEdS0/eOixgjSJ/i00oA7noXkjy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7mFikYx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749727314; x=1781263314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTC8uxKsbrWlLLBTcToPBHyavEBjAw+eccYqlwX55zg=;
  b=Y7mFikYxdM2S1chsnzZOOBvLz0slNwXuATVtSeHkwqEY4rAK671uwNtN
   fGQY/JyjMgHKbYi8SEJJAkj1x9U6ZCYAZV1+uDtB1rDXk9loy/2wtkE4V
   bJ/hjpF9EkbrAHPZbo9Y793DQ0HLohh5LKiOFDXqnQWAt2arkph5aR9i/
   XAJOACri9Fa7rY0lve73xkI8FnsN3xF6tTdEQ6LYn5ecDWx08dJjnuOMH
   xfPXIKu0yFwDTptmuncT7F9VuuhoPuURN96n6UWxgcLAHyPIT9q+15kxy
   KWZeoMLXSxeA9MKNj1dogfX3OATgfZ5XSkpsliu0bttNiOIChI/LOPz99
   w==;
X-CSE-ConnectionGUID: 7QDp+TCIQt69PCGZ+JWQ9w==
X-CSE-MsgGUID: ndJlTq1zSQKy4nGUERQT1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51772510"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51772510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:21:53 -0700
X-CSE-ConnectionGUID: yjU+GwBtSeiWKbbg4H/Wdw==
X-CSE-MsgGUID: XRvoAchPSPKNFrd3CIVNGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147337288"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:21:50 -0700
Date: Thu, 12 Jun 2025 13:21:02 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] net: hns3: add the hns3_get_ops() helper
Message-ID: <aEq4Hvg4aaxnn7m0@mev-dev.igk.intel.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
 <20250612021317.1487943-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612021317.1487943-4-shaojijie@huawei.com>

On Thu, Jun 12, 2025 at 10:13:12AM +0800, Jijie Shao wrote:
> This patch introduces a hns3_get_ops() helper to reduce the unnecessary
> middle layer conversion. Apply it to the whole HNS3 driver.
> The former discusstion can be checked from the link.
> 
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Like with previous patch, not introducing, but using. Still the linked
discussion is about sth else. If you can, please rephrase commit message
to reflect what it is really doing.

Thanks

[...]

