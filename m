Return-Path: <netdev+bounces-140741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE09B7C7F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B6B21B09
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDF1A08B2;
	Thu, 31 Oct 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLp1GjMv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30E19FA8D
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383955; cv=none; b=UQRZfTYcYqQf3vYtY2fjcyF1bH5ihqPChuaQnUY/H62jwIqY28r9Qgngzy2uYIosK2EcDMv9NJTbLlr0X//6IW8/VNcHyqmrIjuuQCIaPsENIHZQ4KC0zb13FHY0t5E5BMtUugf89lQdb50S4jgx9iQHugOaUH3jdF6PJo4WV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383955; c=relaxed/simple;
	bh=mQzdoA6HITBooHuI8ytc1oMFxWv2X/pE16EJqC+j+h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTsQXOHuf0pxRQDprEfbsnTv4IuXs/9cFulrYAWwvBrOtntlCr7+eUAT4btfghQ8Hmzvx7qe0EYAFvZIC404MduEMcBBWRwV6bju+IWssdswzW8Y+BXQB2aJAsjaQwLdj8sQyLQsHEsosZDI+ExpZKacC/RxnPfXhCkOogEZbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLp1GjMv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730383954; x=1761919954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQzdoA6HITBooHuI8ytc1oMFxWv2X/pE16EJqC+j+h8=;
  b=cLp1GjMvUizaZKjwuZanZej3a64zJ2UJ9afFquM/idM+4t1Hj6/9GAXT
   EC/jsMJazN7k/3R1SwXI0gM6+h0Iz8OprgHZ5w1QP2hzw4JqjMtC6ngsS
   tqM5pqAjKvt3TMZRzsFy6ScgtvoGRMgDYnXB0aqqhc5KqOjEjjfKJBAyY
   oS0BgX8mSKkmB17MH7qcalHTMuwzlKEpJa44FYAdHQI3CnNl66D5pjDBF
   lJ5sR9umvFIdW62QnmKBhUB4xgJquDCOwGpXmXoCO+LAge6oTXxBCYldt
   f/fEZ1mqLEJJOes+dkkNuGA4Y1k6FgvRkoACq3zb44IijYxUxWP3hv/1w
   w==;
X-CSE-ConnectionGUID: vamPjTL1R06s3aO0QMkyQA==
X-CSE-MsgGUID: XZy3yFHRTXyqRBKoi5azPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47580739"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47580739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:12:33 -0700
X-CSE-ConnectionGUID: t79serrzTHyW7k5Cors6Bw==
X-CSE-MsgGUID: XiH28u6WRhanW3J1sEup0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87232153"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Oct 2024 07:12:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6VuR-000gH9-16;
	Thu, 31 Oct 2024 14:12:23 +0000
Date: Thu, 31 Oct 2024 22:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: qiang4.zhang@linux.intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Qiang Zhang <qiang4.zhang@intel.com>
Subject: Re: [PATCH] virtio: only reset device and restore status if needed
 in device resume
Message-ID: <202410312128.7ymyjL4j-lkp@intel.com>
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus mst-vhost/linux-next axboe-block/for-next herbert-cryptodev-2.6/master andi-shyti/i2c/i2c-host mkp-scsi/for-next jejb-scsi/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.12-rc5 next-20241031]
[cannot apply to herbert-crypto-2.6/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiang4-zhang-linux-intel-com/virtio-only-reset-device-and-restore-status-if-needed-in-device-resume/20241031-111315
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241031030847.3253873-1-qiang4.zhang%40linux.intel.com
patch subject: [PATCH] virtio: only reset device and restore status if needed in device resume
config: x86_64-buildonly-randconfig-003-20241031 (https://download.01.org/0day-ci/archive/20241031/202410312128.7ymyjL4j-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410312128.7ymyjL4j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312128.7ymyjL4j-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/i2c/busses/i2c-virtio.c:14:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/i2c/busses/i2c-virtio.c:256:8: error: call to undeclared function 'virtio_device_reset_and_restore_status'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |         ret = virtio_device_reset_and_restore_status(vdev);
         |               ^
   1 warning and 1 error generated.


vim +/virtio_device_reset_and_restore_status +256 drivers/i2c/busses/i2c-virtio.c

   251	
   252	static int virtio_i2c_restore(struct virtio_device *vdev)
   253	{
   254		int ret;
   255	
 > 256		ret = virtio_device_reset_and_restore_status(vdev);
   257		if (ret)
   258			return ret;
   259	
   260		return virtio_i2c_setup_vqs(vdev->priv);
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

