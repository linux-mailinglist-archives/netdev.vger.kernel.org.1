Return-Path: <netdev+bounces-196927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE727AD6ECF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD813B0C04
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731E23C8A0;
	Thu, 12 Jun 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTeNHWI8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA423C8A2;
	Thu, 12 Jun 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727052; cv=none; b=rNDTVezN64vWywKx7gzJxN9lkVSlBF53CuGyq5XSPH8uC0bo86cW8QCl6ZWxNk4FKYi4x3JmytZUWa6zOSkRICChoMY4NEPXKwrwzaK4P9Wbse+yJAVpOHIgTUD8NcwuTtwxVzYBDzIF/egLIrA6WD23km+w8dG0Z7NtkpUn74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727052; c=relaxed/simple;
	bh=J7EL3QnNAKukoLuyoJlhpJD+AaPlG8WwN7b2S8bSQIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcRBL2tJdphVMlo5A11LtWR6pvLeNz9c1L2UZjj577FR0Z8C2/XlCfR/cGreFPqhOZRUZMzJX4CjumBmCGDkKSyXkhOP3BODA/Rj/znt3C5EpQJFcVSJ9lHdTSH+/jibAdPIsZPU6F1Q+R19LNaRENln2IpukGguH+PfHb1OwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTeNHWI8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749727051; x=1781263051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7EL3QnNAKukoLuyoJlhpJD+AaPlG8WwN7b2S8bSQIw=;
  b=bTeNHWI8H7R/P3mXpYNCR2IG6tGjtjkmg/eWCnSfEjTn/9l7XBFOKYqu
   Sdt+nQAT8MdvHvbKsyqCyFG+hOuFkI4JQF87dp0wZUpF6rENyE6A040u8
   Ww9twvz7NeiVNEiip7pP4RUzT1DloVjE0C5Wkv1rqjLoyy+NRQgQEMwOn
   0i94M9QYzvqgoFNTUjBWm1b9n/MR08pxSAjoCJ7Pg9YvRKeSdG6uncfmv
   jENFSOwC9Dqx/sQ6PpjxkaWIC8xs/llrk4cYyDpfK6IEP+s+DQxKAtBjt
   zcSOui2fekD4/kcyXnrpF/v/fUv6lD7ruKu4xpGyG8W9dZZhhrhW/xgk7
   Q==;
X-CSE-ConnectionGUID: pL3W6hnOSj2TbAJEY3jbGA==
X-CSE-MsgGUID: ivzmyMCiR16DzK8gmS+bjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69339250"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="69339250"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:17:30 -0700
X-CSE-ConnectionGUID: aBx8WJv+S6aJxmTcStNovw==
X-CSE-MsgGUID: UW9u77CSQiusClo9fiarIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148387209"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:17:26 -0700
Date: Thu, 12 Jun 2025 13:16:40 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] net: hns3: add the hns3_get_ae_dev() helper
Message-ID: <aEq3DgCDh98Deidl@mev-dev.igk.intel.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
 <20250612021317.1487943-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612021317.1487943-3-shaojijie@huawei.com>

On Thu, Jun 12, 2025 at 10:13:11AM +0800, Jijie Shao wrote:
> This patch introduces a hns3_get_ae_dev() helper to reduce the unnecessary
> middle layer conversion. Apply it to the whole HNS3 driver.
> The former discusstion can be checked from the link.

The definition already exist, so more like "use hns3_get_ae_dev()
wherever possible".

> 
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/

I think the comment is about going from netdev to your private
hnae3_ae_dev. You need hnae3_netdev_to_dev/pf/whatever().

Using already defined helper is fine, just please change the commit
message/title.

> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

[...]

