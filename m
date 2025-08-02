Return-Path: <netdev+bounces-211452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00855B18B61
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 10:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BD9167BFD
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F031F1302;
	Sat,  2 Aug 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dllTNh1A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852871DDA1E
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754123751; cv=none; b=Wzu92HjWcm+EoVBr1cWT35z4z5AqYO8f4dMkrg2rDgKcLMQhYeTrqDk0ZwSx7nLrIulVD9arnlVYtnis3YRwHV1ziPsg1BYmO8YoodlIYTLa7my1oOyowa0/+nP/WQfokCIZo7u8OMg0Q0/kgM0VtMXppGykvOjBDO++MFRej7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754123751; c=relaxed/simple;
	bh=8bfVxE+mhdN5sUT9N7F8IdeU8CaCWVjVoBf4PN2G9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei2IEXs+DvNBnmwCQ5YNFB3R+yS94sEl3kFA8mNfwfObtzvabzxKIeq0R/Cpik/A+1e1bwfDvj414wajW7zqWWnjWkOKYi22GkVsdNPkS1TDpd9pDNhvlHVhthUkH4j4yIf75wBVYhO3B6sudXsS52xsR/3az1fLYAc/RMbCyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dllTNh1A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754123749; x=1785659749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8bfVxE+mhdN5sUT9N7F8IdeU8CaCWVjVoBf4PN2G9gM=;
  b=dllTNh1AjMoqD/awS9qJ9ShRo6MJbiZlZxshDb92XxKCYn9rkcOQow6E
   d2lj+ZAxQcT2Br4beYBIxcyFpqpHJ7ovk6RzTSkHKL3e3+GstH7AZ61xF
   Q8Wfe8yL1xkw6FMAz0BVIn+RaC6mulXFi3GdS6u8eb4ZDVLhZa/5kWtWv
   V/C+wxi63dKPv4UtvA2a1bLncfdAUkeW5+35wsJtWURZKXNwZtbzgrZY3
   FTykk5gVBFCPbWffVGNGQr1Ag78rlqki3SGYohd8mivBCUJPtMf9T1PCI
   L47UiMfTCSflJr9oUsERfLaU2fkX/eFMF/ShK7V9yP+6QfJz5DR5pM0J/
   Q==;
X-CSE-ConnectionGUID: 776Fn4TzTUOOBZYYxSLciA==
X-CSE-MsgGUID: jnkUQG2aROePjy/ccc1V9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67033659"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67033659"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 01:35:49 -0700
X-CSE-ConnectionGUID: uxvYRkJ4Sy2XCx4wbUaHAA==
X-CSE-MsgGUID: e6qkSG7rSjiRQh7UjGZI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="169052769"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Aug 2025 01:35:46 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ui7iS-0005GG-0O;
	Sat, 02 Aug 2025 08:35:44 +0000
Date: Sat, 2 Aug 2025 16:35:21 +0800
From: kernel test robot <lkp@intel.com>
To: David Hill <dhill@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, David Hill <dhill@redhat.com>
Subject: Re: [PATCH] PATCH: i40e Improve trusted VF MAC addresses logging
 when limit is reached
Message-ID: <202508021646.pWqgToeU-lkp@intel.com>
References: <20250801133017.2107083-1-dhill@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801133017.2107083-1-dhill@redhat.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on tnguy-net-queue/dev-queue horms-ipvs/master linus/master v6.16 next-20250801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Hill/PATCH-i40e-Improve-trusted-VF-MAC-addresses-logging-when-limit-is-reached/20250801-213326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250801133017.2107083-1-dhill%40redhat.com
patch subject: [PATCH] PATCH: i40e Improve trusted VF MAC addresses logging when limit is reached
config: x86_64-buildonly-randconfig-003-20250802 (https://download.01.org/0day-ci/archive/20250802/202508021646.pWqgToeU-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508021646.pWqgToeU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508021646.pWqgToeU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2957:77: error: use of undeclared identifier 'num_ports'
    2957 |           mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,num_ports)));
         |                                                                             ^
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2957:77: error: use of undeclared identifier 'num_ports'
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2957:88: error: extraneous ')' before ';'
    2957 |           mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,num_ports)));
         |                                                                                        ^
   3 errors generated.


vim +/num_ports +2957 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  2870	
  2871	#define I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(vf_num, num_ports)		\
  2872	({	typeof(vf_num) vf_num_ = (vf_num);				\
  2873		typeof(num_ports) num_ports_ = (num_ports);			\
  2874		((I40E_MAX_MACVLAN_PER_PF(num_ports_) - vf_num_ *		\
  2875		I40E_VC_MAX_MAC_ADDR_PER_VF) / vf_num_) +			\
  2876		I40E_VC_MAX_MAC_ADDR_PER_VF; })
  2877	/**
  2878	 * i40e_check_vf_permission
  2879	 * @vf: pointer to the VF info
  2880	 * @al: MAC address list from virtchnl
  2881	 *
  2882	 * Check that the given list of MAC addresses is allowed. Will return -EPERM
  2883	 * if any address in the list is not valid. Checks the following conditions:
  2884	 *
  2885	 * 1) broadcast and zero addresses are never valid
  2886	 * 2) unicast addresses are not allowed if the VMM has administratively set
  2887	 *    the VF MAC address, unless the VF is marked as privileged.
  2888	 * 3) There is enough space to add all the addresses.
  2889	 *
  2890	 * Note that to guarantee consistency, it is expected this function be called
  2891	 * while holding the mac_filter_hash_lock, as otherwise the current number of
  2892	 * addresses might not be accurate.
  2893	 **/
  2894	static inline int i40e_check_vf_permission(struct i40e_vf *vf,
  2895						   struct virtchnl_ether_addr_list *al)
  2896	{
  2897		struct i40e_pf *pf = vf->pf;
  2898		struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
  2899		struct i40e_hw *hw = &pf->hw;
  2900		int mac2add_cnt = 0;
  2901		int i;
  2902	
  2903		for (i = 0; i < al->num_elements; i++) {
  2904			struct i40e_mac_filter *f;
  2905			u8 *addr = al->list[i].addr;
  2906	
  2907			if (is_broadcast_ether_addr(addr) ||
  2908			    is_zero_ether_addr(addr)) {
  2909				dev_err(&pf->pdev->dev, "invalid VF MAC addr %pM\n",
  2910					addr);
  2911				return -EINVAL;
  2912			}
  2913	
  2914			/* If the host VMM administrator has set the VF MAC address
  2915			 * administratively via the ndo_set_vf_mac command then deny
  2916			 * permission to the VF to add or delete unicast MAC addresses.
  2917			 * Unless the VF is privileged and then it can do whatever.
  2918			 * The VF may request to set the MAC address filter already
  2919			 * assigned to it so do not return an error in that case.
  2920			 */
  2921			if (!i40e_can_vf_change_mac(vf) &&
  2922			    !is_multicast_ether_addr(addr) &&
  2923			    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
  2924				dev_err(&pf->pdev->dev,
  2925					"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
  2926				return -EPERM;
  2927			}
  2928	
  2929			/*count filters that really will be added*/
  2930			f = i40e_find_mac(vsi, addr);
  2931			if (!f)
  2932				++mac2add_cnt;
  2933		}
  2934	
  2935		/* If this VF is not privileged, then we can't add more than a limited
  2936		 * number of addresses. Check to make sure that the additions do not
  2937		 * push us over the limit.
  2938		 */
  2939		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
  2940			if ((i40e_count_filters(vsi) + mac2add_cnt) >
  2941			    I40E_VC_MAX_MAC_ADDR_PER_VF) {
  2942				dev_err(&pf->pdev->dev,
  2943					"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
  2944				return -EPERM;
  2945			}
  2946		/* If this VF is trusted, it can use more resources than untrusted.
  2947		 * However to ensure that every trusted VF has appropriate number of
  2948		 * resources, divide whole pool of resources per port and then across
  2949		 * all VFs.
  2950		 */
  2951		} else {
  2952			if ((i40e_count_filters(vsi) + mac2add_cnt) >
  2953			    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
  2954							       hw->num_ports)) {
  2955				dev_err(&pf->pdev->dev,
  2956					"Cannot add more MAC addresses, trusted VF %d uses %d out of %d MAC addresses\n", vf->vf_id, i40e_count_filters(vsi) +
> 2957	          mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,num_ports)));
  2958				return -EPERM;
  2959			}
  2960		}
  2961		return 0;
  2962	}
  2963	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

