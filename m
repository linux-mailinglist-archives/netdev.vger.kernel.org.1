Return-Path: <netdev+bounces-60102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9881D575
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2451F21B33
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890D11C8A;
	Sat, 23 Dec 2023 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShZG86xi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAC15E81
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703354179; x=1734890179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHooJR/cUNFJYIbiIdxX4l/G+Qo7iSORCh9uZSLuUNQ=;
  b=ShZG86xiJBZ1u0XHeKpCeqZhYhmal0Sbgm0PI2q9OVau4+9h9PMmOgMR
   vWYWujDKOz/YtkvFxWnmejIGd/PrxA+R42jPgYdhRjhjaFxPIV3SuIgYW
   bwSBtZsYXEyVCry4V1OwFqsDAFh5thHtTrz+tFu9zIOveNP0I53ZDTXSr
   042NtXZZYRBAXK9M8RjOxQA7z5yd/yCLVSO9Ek91Olu6gJST2Ru6iENEp
   ww6LcHe6cVOh4v/OhIv24QXtfh7TzeBf5qcXrT0Iwt7M+7wZPQPzwn79O
   puy3Ff3juiouO5bEeyEp5Cdx6MKBOHGK8ccveVH0LJ8qu3YDRJaVaKUQt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="482383889"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="482383889"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 09:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="950622648"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="950622648"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Dec 2023 09:56:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH6EN-000BHu-0H;
	Sat, 23 Dec 2023 17:56:11 +0000
Date: Sun, 24 Dec 2023 01:55:03 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 1/6] virtio_net: introduce device stats feature
 and structures
Message-ID: <202312240125.00z3nxGY-lkp@intel.com>
References: <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.7-rc6 next-20231222]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231222-175505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231222033021.20649-2-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next 1/6] virtio_net: introduce device stats feature and structures
config: x86_64-buildonly-randconfig-002-20231223 (https://download.01.org/0day-ci/archive/20231224/202312240125.00z3nxGY-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240125.00z3nxGY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240125.00z3nxGY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/virtio_net.h:454:2: error: unknown type name 'u8'
           u8 type;
           ^
   ./usr/include/linux/virtio_net.h:455:2: error: unknown type name 'u8'
           u8 reserved;
           ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

