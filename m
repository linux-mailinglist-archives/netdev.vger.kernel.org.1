Return-Path: <netdev+bounces-218028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273FB3AD82
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050713B36DD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457526E6F2;
	Thu, 28 Aug 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxw32h12"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485C7404E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420133; cv=none; b=m3ylkRbKG6ZUwWxHLPknpkoze0rgjdANBeVFUL4TCQLIyaFAP0QX0zDuW+zGW+1gDqVEtEXg5sT4e7pn8rB4g5b37ryfYZFhSI/hfuU42N3ope/rPUk+xkg0lCdWasrPUtKOnGX/GiI1JqLMqAnO647zMEdJhP1vL7VKUflHDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420133; c=relaxed/simple;
	bh=4zmcrVeF4hx4MElfYUEC86Mh2OHXVyrr9SZZkseSnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn8bST5LmnSQuKKJjYwrBSyj05ZrFUS090Ojj6eQAgd41PKRWjxrQoq4yrfZ7OQT2RSVKdN5cFumAfwGjcwgWXxLPjmxMn0u5sksT8ReaiENM8OVOTd3a8ali7dzHfbKQxExqqwV6E9ip9sBVQlDexJF83vDxCoyLs3roejtOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxw32h12; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756420132; x=1787956132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zmcrVeF4hx4MElfYUEC86Mh2OHXVyrr9SZZkseSnZM=;
  b=mxw32h12i5W/YyPWgXfb11yQICVCSZf4ZcqzoH7pGh+qnuWpxE7uVvpQ
   mWffv6WRSVzFCR94EiUaSLiGnbsgNnhJajRpMy7H4i90uNNcYw0qHAj+p
   a0V1K4ut+fy1YWKRwD1EbeeVBrvkWAUxqc+zr/JtJPgm1kpOtmw3DtCk1
   wSbx2M0N2MmKc9HNSSpukZUKtGpoNpKsrJMEWlgiy/9vE+Bil+O7yhYV4
   BIPZWPVahgidmO5XE2fG/iiRr1tvn3w/s2DpB0i9Un+h0La3lB0vefUiX
   3mf1yYefcbqn8yDH14XPegNbWzIyRZm4H+Pe1VaimkJlGfUfTTJUlg87B
   w==;
X-CSE-ConnectionGUID: viFFJmDWRuenuog8EjoJmQ==
X-CSE-MsgGUID: I+NveS3ZRdeKx7wnQCoLaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58556191"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58556191"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:28:52 -0700
X-CSE-ConnectionGUID: l8mcJ2OuSB6Y4HOeOKLwtA==
X-CSE-MsgGUID: 77yDYW8MTZK9ZTJsoXvp3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169753428"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 28 Aug 2025 15:28:48 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1url6M-000U8N-1S;
	Thu, 28 Aug 2025 22:28:33 +0000
Date: Fri, 29 Aug 2025 06:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <202508290631.baVQplwA-lkp@intel.com>
References: <20250827183852.2471-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183852.2471-7-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250828-024128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827183852.2471-7-danielj%40nvidia.com
patch subject: [PATCH net-next 06/11] virtio_net: Implement layer 2 ethtool flow rules
config: x86_64-randconfig-121-20250828 (https://download.01.org/0day-ci/archive/20250829/202508290631.baVQplwA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250829/202508290631.baVQplwA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508290631.baVQplwA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net/virtio_net_ff.c: note: in included file (through include/linux/virtio_admin.h):
   include/uapi/linux/virtio_net_ff.h:47:48: sparse: sparse: array of flexible structures
   include/uapi/linux/virtio_net_ff.h:67:48: sparse: sparse: array of flexible structures
   drivers/net/virtio_net/virtio_net_ff.c:113:24: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/virtio_net/virtio_net_ff.c:189:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vq_index @@     got unsigned long long @@
   drivers/net/virtio_net/virtio_net_ff.c:189:27: sparse:     expected restricted __le16 [usertype] vq_index
   drivers/net/virtio_net/virtio_net_ff.c:189:27: sparse:     got unsigned long long
   drivers/net/virtio_net/virtio_net_ff.c:380:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/virtio_net/virtio_net_ff.c:509:13: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/virtio_net/virtio_net_ff.c:509:13: sparse: sparse: cast to restricted __le32
   drivers/net/virtio_net/virtio_net_ff.c:513:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] groups_limit @@     got int @@
   drivers/net/virtio_net/virtio_net_ff.c:513:35: sparse:     expected restricted __le32 [usertype] groups_limit
   drivers/net/virtio_net/virtio_net_ff.c:513:35: sparse:     got int

vim +189 drivers/net/virtio_net/virtio_net_ff.c

   163	
   164	static int insert_rule(struct virtnet_ff *ff,
   165			       struct virtnet_ethtool_rule *eth_rule,
   166			       u32 classifier_id,
   167			       const u8 *key,
   168			       size_t key_size)
   169	{
   170		struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
   171		struct virtio_net_resource_obj_ff_rule *ff_rule;
   172		int err;
   173	
   174		ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
   175		if (!ff_rule) {
   176			err = -ENOMEM;
   177			goto err_eth_rule;
   178		}
   179		/*
   180		 * Intentionally leave the priority as 0. All rules have the same
   181		 * priority.
   182		 */
   183		ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
   184		ff_rule->classifier_id = cpu_to_le32(classifier_id);
   185		ff_rule->key_length = (u8)key_size;
   186		ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
   187						     VIRTIO_NET_FF_ACTION_DROP :
   188						     VIRTIO_NET_FF_ACTION_RX_VQ;
 > 189		ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
   190						       fs->ring_cookie : 0;
   191		memcpy(&ff_rule->keys, key, key_size);
   192	
   193		err = virtio_device_object_create(ff->vdev,
   194						  VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
   195						  fs->location,
   196						  ff_rule,
   197						  sizeof(*ff_rule) + key_size);
   198		if (err)
   199			goto err_ff_rule;
   200	
   201		eth_rule->classifier_id = classifier_id;
   202		ff->ethtool.num_rules++;
   203		kfree(ff_rule);
   204	
   205		return 0;
   206	
   207	err_ff_rule:
   208		kfree(ff_rule);
   209	err_eth_rule:
   210		xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
   211		kfree(eth_rule);
   212	
   213		return err;
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

