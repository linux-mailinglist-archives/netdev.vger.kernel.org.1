Return-Path: <netdev+bounces-27369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13077BACD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353651C20A5C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97DC132;
	Mon, 14 Aug 2023 14:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195FBE68
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:00:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B710F7
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692021618; x=1723557618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ejv5hEf5eTJPWbPYhLKVJ6OdJcC5J7Oaww5h4B8uP5s=;
  b=MzbO71wzzG98VrvBdfS9kfgVLv061jBY+fuuxQBrNVoMnKeJQYVBzKVN
   RasyPeKYH3fwV9bzSMuU97xedXx/un2yuYaBQya580okZcu1bPXSIyRuj
   lu6zrm0kq79oSbGHw0IG+hWZM2YwPLHKPsY6qz/FniYVw3E7bdKWSHm3M
   SedoOIrnUSKUz5Cl5LODJYQO4xsGIF7T4C28tOwpzfLP+LA/xC2myM8/5
   KGCWuFNnXdLl7raBLhIg5DlpFBVkNvl8oPyzABIE3PFolZldXuGfwe855
   6z9t2JVvOABL5Y9XKuA1sL6QmwSQXdQD+EvcHCOpsjauIji601Msm9Seb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438374677"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438374677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683315128"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="683315128"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 06:59:59 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qVY6h-0000Aj-1O;
	Mon, 14 Aug 2023 13:59:49 +0000
Date: Mon, 14 Aug 2023 21:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 6/8] virtio-net: support rx netdim
Message-ID: <202308142100.l4cN4g6z-lkp@intel.com>
References: <20230811065512.22190-7-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811065512.22190-7-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-initially-change-the-value-of-tx-frames/20230811-150529
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230811065512.22190-7-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next 6/8] virtio-net: support rx netdim
config: microblaze-randconfig-r081-20230814 (https://download.01.org/0day-ci/archive/20230814/202308142100.l4cN4g6z-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308142100.l4cN4g6z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308142100.l4cN4g6z-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
>> drivers/net/virtio_net.c:3269: undefined reference to `net_dim_get_rx_moderation'
   microblaze-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_update':
>> drivers/net/virtio_net.c:1985: undefined reference to `net_dim'


vim +3269 drivers/net/virtio_net.c

  3258	
  3259	static void virtnet_rx_dim_work(struct work_struct *work)
  3260	{
  3261		struct dim *dim = container_of(work, struct dim, work);
  3262		struct receive_queue *rq = container_of(dim,
  3263				struct receive_queue, dim);
  3264		struct virtnet_info *vi = rq->vq->vdev->priv;
  3265		struct net_device *dev = vi->dev;
  3266		struct dim_cq_moder update_moder;
  3267		int qnum = rq - vi->rq, err;
  3268	
> 3269		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
  3270		err = virtnet_send_rx_notf_coal_vq_cmd(vi, qnum,
  3271						       update_moder.usec,
  3272						       update_moder.pkts);
  3273		if (err)
  3274			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
  3275				 dev->name, (int)(rq - vi->rq));
  3276	
  3277		dim->state = DIM_START_MEASURE;
  3278	}
  3279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

