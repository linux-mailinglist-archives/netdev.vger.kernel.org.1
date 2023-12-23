Return-Path: <netdev+bounces-60097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCC81D532
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4D61C20FA3
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253C10961;
	Sat, 23 Dec 2023 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cathwpfz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675510798
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703351095; x=1734887095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kEFd7MhTmJumlNW/XsckxCIHQkiQQHT0Q8nvzk57iQk=;
  b=cathwpfzosvWnfJo/bTkodgsthtuZrggO3vrS+nYCWwadPTLH9ccKi5Y
   XS/UTwCc5iTiE1sV8pXKIOCL9NHR0rGiu9D/PqY9npPW4mcJuz8jlXs71
   K6o+YKrgan+lHCkGvjlBUt+PyBD04bM7UQcU8uuL+q3o+dZ4dH6Y0ubg+
   UCFf8gdM/7LHEjknLNNBMZakG2rDlVfDAqAvce/y1Sy8dXYnmp8au33O1
   iXTpyd1hVRI0poXgHmoi/oBNQrnG4NMi6p32W/7WzDHNE4zGBzBuNmanH
   5yTh6mnwkj4fbahOpN6eBMdQTKzSYLtZ7qoYRiY3REC6sS0DyMRfk1pWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="395095584"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="395095584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 09:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="727163995"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="727163995"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Dec 2023 09:04:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH5QU-000BEF-26;
	Sat, 23 Dec 2023 17:04:43 +0000
Date: Sun, 24 Dec 2023 01:03:11 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 3/6] virtio_net: support device stats
Message-ID: <202312240041.YOiIXVkG-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231224/202312240041.YOiIXVkG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240041.YOiIXVkG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240041.YOiIXVkG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio_net.c:224:2: warning: shift count >= width of type [-Wshift-count-overflow]
           VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:215:3: note: expanded from macro 'VIRTNET_DEVICE_STATS_MAP_ITEM'
                   VIRTIO_NET_STATS_TYPE_##TYPE,                   \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:61:1: note: expanded from here
   VIRTIO_NET_STATS_TYPE_CVQ
   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/virtio_net.h:419:45: note: expanded from macro 'VIRTIO_NET_STATS_TYPE_CVQ'
   #define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
                                               ^  ~~
   1 warning generated.


vim +224 drivers/net/virtio_net.c

   212	
   213	#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)	\
   214		{							\
   215			VIRTIO_NET_STATS_TYPE_##TYPE,			\
   216			sizeof(struct virtio_net_stats_ ## type),	\
   217			ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
   218			VIRTNET_STATS_Q_TYPE_##queue_type,		\
   219			VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
   220			&virtnet_stats_##type##_desc[0]			\
   221		}
   222	
   223	static struct virtnet_stats_map virtio_net_stats_map[] = {
 > 224		VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
   225	
   226		VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
   227		VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
   228		VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
   229		VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
   230	
   231		VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
   232		VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
   233		VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
   234		VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
   235	};
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

