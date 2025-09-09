Return-Path: <netdev+bounces-221386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADCB50667
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDBC4E8449
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE43375D0;
	Tue,  9 Sep 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNinnesY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C011531F9
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446114; cv=none; b=LC3NqfGqsnc2BOapeMX35OO2OMmzq3UE3y4/CZHfO79xtdfayMYRNXoQcpE7rlHI+Q5nPOMr9ov2fwEppd8fXnOtuB0aLXk31Gsif1oAWNGNKdmTA5x+JAxQpeuylPllfVSLv/SNL+5xU7XNotxgs4Pa44AMgP5/JAmn/kwAB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446114; c=relaxed/simple;
	bh=1x5zVn7ZOm1nIU/0RB7M0zUuhGSlS6lEQ7GWNHTQbXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLtZnyyU0k3s9mI6pUwmh2gorI3Wik4UkAj5xwpYVWsKwfcer8gA0thB67oCb4oe7s3ijDi9iT30OzRt/YA9ZLPJl/iX3E5Y3yp5J2oqPs2E6mc3loYTvypH+9npsEl41JHPRdW51q/yAGA+jAAB/x0enl7xF6e9lWmZgpWIrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNinnesY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757446111; x=1788982111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1x5zVn7ZOm1nIU/0RB7M0zUuhGSlS6lEQ7GWNHTQbXI=;
  b=RNinnesYFFw6tIlrv5tg5tIg1uGgPYHgkFFqr6FoWPsCyAl3jsQWC4I2
   OBM1kM613aHBCIjskria4eym+GLj83Bjap94hoNk60ZvK8CTEz+OMkcO5
   kkLbJ48cXD8IKHGzGEuEtvLdTkwg17MYSvpmuPwD1zj5D0dhkho3aJEfX
   hQaIlB0UiJXbXs0xVtXq7xVVhZu/pcF9bEtGLiA0Pu2/OESzl/X+jVX0A
   WSaWzqXp8wuKdHzHD6kxkc/nDRqkNXwXqXhfAYpUrW0vEUg2QIL5X/Rnt
   QlE6ed4hzg+XGSy+noExU1xEANzv0xEO6tnmy4wXtWOe2l3rUyrIGITYl
   A==;
X-CSE-ConnectionGUID: +6cFOZMFQrSOQ9PjVndZtg==
X-CSE-MsgGUID: nVrpGG1QTduaDe5GVziiew==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70359875"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="70359875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 12:28:30 -0700
X-CSE-ConnectionGUID: u+EuR4iZQHeXx/u+g8SYqg==
X-CSE-MsgGUID: PTgf0DMoQeS+TgPl5h+8XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173040704"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Sep 2025 12:28:28 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uw40v-0005D9-1D;
	Tue, 09 Sep 2025 19:28:25 +0000
Date: Wed, 10 Sep 2025 03:27:27 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v2 03/11] virtio_net: Create virtio_net directory
Message-ID: <202509100236.iFI48Aer-lkp@intel.com>
References: <20250908164046.25051-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908164046.25051-4-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250909-005006
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250908164046.25051-4-danielj%40nvidia.com
patch subject: [PATCH net-next v2 03/11] virtio_net: Create virtio_net directory
config: sparc-randconfig-002-20250910 (https://download.01.org/0day-ci/archive/20250910/202509100236.iFI48Aer-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509100236.iFI48Aer-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509100236.iFI48Aer-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net/virtio_net_main.c: In function 'virtnet_probe':
>> drivers/net/virtio_net/virtio_net_main.c:6487:36: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
      sprintf(vi->rq[i].name, "input.%u", i);
                                       ^
   drivers/net/virtio_net/virtio_net_main.c:6487:3: note: 'sprintf' output between 8 and 17 bytes into a destination of size 16
      sprintf(vi->rq[i].name, "input.%u", i);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/virtio_net/virtio_net_main.c:6488:35: warning: '%u' directive writing between 1 and 10 bytes into a region of size 9 [-Wformat-overflow=]
      sprintf(vi->sq[i].name, "output.%u", i);
                                      ^~
   drivers/net/virtio_net/virtio_net_main.c:6488:27: note: directive argument in the range [0, 2147483647]
      sprintf(vi->sq[i].name, "output.%u", i);
                              ^~~~~~~~~~~
   drivers/net/virtio_net/virtio_net_main.c:6488:3: note: 'sprintf' output between 9 and 18 bytes into a destination of size 16
      sprintf(vi->sq[i].name, "output.%u", i);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +6487 drivers/net/virtio_net/virtio_net_main.c

d85b758f72b05a drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-09  6446  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6447  static int virtnet_find_vqs(struct virtnet_info *vi)
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6448  {
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6449  	struct virtqueue_info *vqs_info;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6450  	struct virtqueue **vqs;
e3fe8d28c67bf6 drivers/net/virtio_net.c Zhu Yanjun         2024-01-04  6451  	int ret = -ENOMEM;
e3fe8d28c67bf6 drivers/net/virtio_net.c Zhu Yanjun         2024-01-04  6452  	int total_vqs;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6453  	bool *ctx;
e3fe8d28c67bf6 drivers/net/virtio_net.c Zhu Yanjun         2024-01-04  6454  	u16 i;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6455  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6456  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6457  	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6458  	 * possible control vq.
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6459  	 */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6460  	total_vqs = vi->max_queue_pairs * 2 +
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6461  		    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6462  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6463  	/* Allocate space for find_vqs parameters */
6396bb221514d2 drivers/net/virtio_net.c Kees Cook          2018-06-12  6464  	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6465  	if (!vqs)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6466  		goto err_vq;
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6467  	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6468  	if (!vqs_info)
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6469  		goto err_vqs_info;
192f68cf35f5ee drivers/net/virtio_net.c Jason Wang         2017-07-19  6470  	if (!vi->big_packets || vi->mergeable_rx_bufs) {
6396bb221514d2 drivers/net/virtio_net.c Kees Cook          2018-06-12  6471  		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6472  		if (!ctx)
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6473  			goto err_ctx;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6474  	} else {
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6475  		ctx = NULL;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6476  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6477  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6478  	/* Parameters for control virtqueue, if any */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6479  	if (vi->has_cvq) {
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6480  		vqs_info[total_vqs - 1].name = "control";
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6481  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6482  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6483  	/* Allocate/initialize parameters for send/receive virtqueues */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6484  	for (i = 0; i < vi->max_queue_pairs; i++) {
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6485  		vqs_info[rxq2vq(i)].callback = skb_recv_done;
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6486  		vqs_info[txq2vq(i)].callback = skb_xmit_done;
e3fe8d28c67bf6 drivers/net/virtio_net.c Zhu Yanjun         2024-01-04 @6487  		sprintf(vi->rq[i].name, "input.%u", i);
e3fe8d28c67bf6 drivers/net/virtio_net.c Zhu Yanjun         2024-01-04 @6488  		sprintf(vi->sq[i].name, "output.%u", i);
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6489  		vqs_info[rxq2vq(i)].name = vi->rq[i].name;
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6490  		vqs_info[txq2vq(i)].name = vi->sq[i].name;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6491  		if (ctx)
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6492  			vqs_info[rxq2vq(i)].ctx = true;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6493  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6494  
6c85d6b653caeb drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6495  	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, vqs_info, NULL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6496  	if (ret)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6497  		goto err_find;
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6498  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6499  	if (vi->has_cvq) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6500  		vi->cvq = vqs[total_vqs - 1];
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6501  		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
f646968f8f7c62 drivers/net/virtio_net.c Patrick McHardy    2013-04-19  6502  			vi->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6503  	}
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6504  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6505  	for (i = 0; i < vi->max_queue_pairs; i++) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6506  		vi->rq[i].vq = vqs[rxq2vq(i)];
d85b758f72b05a drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-09  6507  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6508  		vi->sq[i].vq = vqs[txq2vq(i)];
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6509  	}
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6510  
2fa3c8a8b23041 drivers/net/virtio_net.c Tonghao Zhang      2018-05-31  6511  	/* run here: ret == 0. */
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6512  
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6513  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6514  err_find:
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6515  	kfree(ctx);
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  6516  err_ctx:
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6517  	kfree(vqs_info);
c2c6325e1645b5 drivers/net/virtio_net.c Jiri Pirko         2024-07-08  6518  err_vqs_info:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6519  	kfree(vqs);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6520  err_vq:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6521  	return ret;
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  6522  }
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  6523  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

