Return-Path: <netdev+bounces-60099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966A81D53C
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0222028304D
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEC1094E;
	Sat, 23 Dec 2023 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khN6mjZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5812E4C
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703352319; x=1734888319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Gmznqo30uZrkAtxT6dU+7NcE2umT81kQB26aiSA/wU=;
  b=khN6mjZJAuUUVpExwhDCutqsTT30dsp2ifQHRuttmKrqjcZMdSoYwYei
   GqAQNAncPYV8zJFHi0db4F1LkEuEoTTdsUq9O35bxa7tTAkxFX2FVdl4W
   4hIBi2GfS6bQE6pkm/oEQaViWyQcBZXWyWVra89kwLHMl9+FU7l6CY++m
   6DjNPo2vLLZFOtRT0G9ZR9txXLUVo1movPSDdXEPxM6E79KkjFW3GX47S
   gyP5mOVYJ6M5QKuTLtjDYiBJN1dme5Hr8mWQrSMbQDmlvwvdby29Y5MTn
   5LKAzh2/PD8J9jagdjjYtk7U7iwKD6+48gP06v+BD3BtTxD7OJ1xQRwjx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="3452130"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="3452130"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 09:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="753581772"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="753581772"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Dec 2023 09:25:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH5jv-000BGJ-2D;
	Sat, 23 Dec 2023 17:24:54 +0000
Date: Sun, 24 Dec 2023 01:23:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 3/6] virtio_net: support device stats
Message-ID: <202312240155.ow7kvQZO-lkp@intel.com>
References: <20231222033021.20649-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222033021.20649-4-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.7-rc6]
[cannot apply to net-next/main horms-ipvs/master next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231222-175505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231222033021.20649-4-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next 3/6] virtio_net: support device stats
config: arc-haps_hs_defconfig (https://download.01.org/0day-ci/archive/20231224/202312240155.ow7kvQZO-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240155.ow7kvQZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240155.ow7kvQZO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/virtio_net.h:8,
                    from drivers/net/virtio_net.c:12:
>> include/uapi/linux/virtio_net.h:419:45: warning: left shift count >= width of type [-Wshift-count-overflow]
     419 | #define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
         |                                             ^~
   drivers/net/virtio_net.c:215:17: note: in expansion of macro 'VIRTIO_NET_STATS_TYPE_CVQ'
     215 |                 VIRTIO_NET_STATS_TYPE_##TYPE,                   \
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:224:9: note: in expansion of macro 'VIRTNET_DEVICE_STATS_MAP_ITEM'
     224 |         VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +419 include/uapi/linux/virtio_net.h

ba106d1c676c80 Xuan Zhuo 2023-12-22  418  
ba106d1c676c80 Xuan Zhuo 2023-12-22 @419  #define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
ba106d1c676c80 Xuan Zhuo 2023-12-22  420  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

