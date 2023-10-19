Return-Path: <netdev+bounces-42490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5F7CEDDD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D0B281D66
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E8656;
	Thu, 19 Oct 2023 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTM4/5lK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184D7FD
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 02:12:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BF113
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697681562; x=1729217562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOlkFAbzprunBZ2pGKl8rivWu6KuXxX+L0G5r/zMN/g=;
  b=DTM4/5lKS8fDvQSpGkelhMT1EO97CQqgoQEd1CtdZKbA0/st0dUxHRrY
   86OxD6ASmDMs0WWM86ET+VP403kkIbsqrebd/XY0+xkNl8odsV6dDOXVB
   qco3ML/EynbLaZ1jFSuGhwQiKuusWIspPofGGPVVAzKS3Qb30yNzrXJ43
   b8b7E6e7p3rBY3TMbhb8C5W0aFa/jsSUwWgjrGA4BHWKBy1lxhGrgUw78
   zKfYVetEvkZJuxivG8WiwhdxURqAeXlPpVRk/LMczIalwvZMPSUk3df+i
   yhNyiL4GxkzLIA+bV1q+ZZaQqcFdzLnRAHIv07HhGSse54y0p/k5KmOlT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417266998"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417266998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 19:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4780165"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 19:12:43 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qtIWc-0001Qc-12;
	Thu, 19 Oct 2023 02:12:38 +0000
Date: Thu, 19 Oct 2023 10:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <202310190900.9Dzgkbev-lkp@intel.com>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>

Hi Amritha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Amritha-Nambiar/netdev-genl-spec-Extend-netdev-netlink-spec-in-YAML-for-queue/20231019-082941
base:   net-next/main
patch link:    https://lore.kernel.org/r/169767396671.6692.9945461089943525792.stgit%40anambiarhost.jf.intel.com
patch subject: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev netlink spec in YAML for queue
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190900.9Dzgkbev-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190900.9Dzgkbev-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#547: FILE: tools/net/ynl/generated/netdev-user.h:181:
+	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

