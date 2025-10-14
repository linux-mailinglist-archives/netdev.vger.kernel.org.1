Return-Path: <netdev+bounces-229054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA3BD792B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B14E236E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92025A353;
	Tue, 14 Oct 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqBjH/Kn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7B1DA62E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423615; cv=none; b=T1AgPsWSqL2LzJZHbi9Y8GWQBPg+JFXTmglcqiBmYdk3LtA+Jny4ZbP1PssjZ8Bb6CCeSw799Fiw/6CXf+qG9PfDYhROXQrK8VpgiXjdlI+yysTX7+kilh/qwvV0jx8Z0I1E1QtromEF4GhAs8c1CW0uNborrw1ItFH8bAwEm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423615; c=relaxed/simple;
	bh=bItmwAuM1kJCIqmjLQgrg55Hiv1GTpbgngNNX+tPC80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnPsfC8HwCXshL5/yb2n7iCDooCOiqpDfSqD+cnLvUKIvpzpf8nHWt2ZSpMo6gNEsFELlitaKnjfRsESFZWPtispeNpfMAgwnTwtUYHgWg7WE5s6FQz4NxTffiTrwbgvFd8HsoZ6nkbr0J2PjsHvbWz0QRw3Pvva/qLTVu0iAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqBjH/Kn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760423614; x=1791959614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bItmwAuM1kJCIqmjLQgrg55Hiv1GTpbgngNNX+tPC80=;
  b=mqBjH/KniBNUu0+duBXV06HQ/DeS+5vVTGp9VnL2Jxqj0nO6IqcQD8wC
   Lx6HsS15najqsY76VtvbPPDLjTfH5nW018PObxKGINxL8lUaTyeY+x3zv
   RVgoeOwyc/pGESfMFOiZDDou6idj7nVMlXqyxXfckqwMxk2HDNQENXY1N
   JGs2c5WUq7miu7PYQrYDpOR9i0j9T3uml3+qZDfz4pwNr75+a3oVmJ4Dj
   /6zcEWGTjCgQZYOO8iXwa4e3p59r8VfNf7JwbgcvQjLTPe2iCzOMOxdxI
   dSMuC1+VreWaXTp+Hut/SUm8QHPuYFUXj/u7vozpt0Q4W6fO6jltGrXhT
   A==;
X-CSE-ConnectionGUID: 4MXmXYSORTmrJkfc4VkZgg==
X-CSE-MsgGUID: +qloASd3TSW1IFYJAjjsnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73678264"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="73678264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:33:33 -0700
X-CSE-ConnectionGUID: 6EuriOAgTJuvDYz/dmx8Pw==
X-CSE-MsgGUID: cVO5Mr4bTZKkNcO4avyV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="181756438"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2025 23:33:26 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8Yb0-0002Tb-1V;
	Tue, 14 Oct 2025 06:33:19 +0000
Date: Tue, 14 Oct 2025 14:32:52 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v4 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <202510141423.IeIhJgQG-lkp@intel.com>
References: <20251013152742.619423-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013152742.619423-6-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20251014-004146
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251013152742.619423-6-danielj%40nvidia.com
patch subject: [PATCH net-next v4 05/12] virtio_net: Query and set flow filter caps
config: i386-buildonly-randconfig-003-20251014 (https://download.01.org/0day-ci/archive/20251014/202510141423.IeIhJgQG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141423.IeIhJgQG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141423.IeIhJgQG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/virtio_net.c:6868:32: error: called object type 'unsigned int' is not a function or function pointer
    6868 |                 if (sel->length > MAX_SEL_LEN()) {
         |                                   ~~~~~~~~~~~^
   1 error generated.


vim +6868 drivers/net/virtio_net.c

  6788	
  6789	static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
  6790	{
  6791		size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
  6792				      sizeof(struct virtio_net_ff_selector) *
  6793				      VIRTIO_NET_FF_MASK_TYPE_MAX;
  6794		struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
  6795		struct virtio_net_ff_selector *sel;
  6796		int err;
  6797		int i;
  6798	
  6799		cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
  6800		if (!cap_id_list)
  6801			return;
  6802	
  6803		err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
  6804		if (err)
  6805			goto err_cap_list;
  6806	
  6807		if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
  6808					 VIRTIO_NET_FF_RESOURCE_CAP) &&
  6809		      VIRTIO_CAP_IN_LIST(cap_id_list,
  6810					 VIRTIO_NET_FF_SELECTOR_CAP) &&
  6811		      VIRTIO_CAP_IN_LIST(cap_id_list,
  6812					 VIRTIO_NET_FF_ACTION_CAP)))
  6813			goto err_cap_list;
  6814	
  6815		ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
  6816		if (!ff->ff_caps)
  6817			goto err_cap_list;
  6818	
  6819		err = virtio_admin_cap_get(vdev,
  6820					   VIRTIO_NET_FF_RESOURCE_CAP,
  6821					   ff->ff_caps,
  6822					   sizeof(*ff->ff_caps));
  6823	
  6824		if (err)
  6825			goto err_ff;
  6826	
  6827		/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
  6828		for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
  6829			ff_mask_size += get_mask_size(i);
  6830	
  6831		ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
  6832		if (!ff->ff_mask)
  6833			goto err_ff;
  6834	
  6835		err = virtio_admin_cap_get(vdev,
  6836					   VIRTIO_NET_FF_SELECTOR_CAP,
  6837					   ff->ff_mask,
  6838					   ff_mask_size);
  6839	
  6840		if (err)
  6841			goto err_ff_mask;
  6842	
  6843		ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
  6844						VIRTIO_NET_FF_ACTION_MAX,
  6845						GFP_KERNEL);
  6846		if (!ff->ff_actions)
  6847			goto err_ff_mask;
  6848	
  6849		err = virtio_admin_cap_get(vdev,
  6850					   VIRTIO_NET_FF_ACTION_CAP,
  6851					   ff->ff_actions,
  6852					   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
  6853	
  6854		if (err)
  6855			goto err_ff_action;
  6856	
  6857		err = virtio_admin_cap_set(vdev,
  6858					   VIRTIO_NET_FF_RESOURCE_CAP,
  6859					   ff->ff_caps,
  6860					   sizeof(*ff->ff_caps));
  6861		if (err)
  6862			goto err_ff_action;
  6863	
  6864		ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
  6865		sel = &ff->ff_mask->selectors[0];
  6866	
  6867		for (i = 0; i < ff->ff_mask->count; i++) {
> 6868			if (sel->length > MAX_SEL_LEN()) {
  6869				err = -EINVAL;
  6870				goto err_ff_action;
  6871			}
  6872			ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
  6873			sel = (void *)sel + sizeof(*sel) + sel->length;
  6874		}
  6875	
  6876		err = virtio_admin_cap_set(vdev,
  6877					   VIRTIO_NET_FF_SELECTOR_CAP,
  6878					   ff->ff_mask,
  6879					   ff_mask_size);
  6880		if (err)
  6881			goto err_ff_action;
  6882	
  6883		err = virtio_admin_cap_set(vdev,
  6884					   VIRTIO_NET_FF_ACTION_CAP,
  6885					   ff->ff_actions,
  6886					   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
  6887		if (err)
  6888			goto err_ff_action;
  6889	
  6890		ff->vdev = vdev;
  6891		ff->ff_supported = true;
  6892	
  6893		kfree(cap_id_list);
  6894	
  6895		return;
  6896	
  6897	err_ff_action:
  6898		kfree(ff->ff_actions);
  6899	err_ff_mask:
  6900		kfree(ff->ff_mask);
  6901	err_ff:
  6902		kfree(ff->ff_caps);
  6903	err_cap_list:
  6904		kfree(cap_id_list);
  6905	}
  6906	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

