Return-Path: <netdev+bounces-102139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAE90188B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 00:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871A71F21005
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE41DDCE;
	Sun,  9 Jun 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwj1EMnu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2A20DF4;
	Sun,  9 Jun 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717972482; cv=none; b=Tt2LMaE0Tvi+AHhx/J3JQb7dnU/DcuktRf/pyxCuw+ixLrlE0TtHK1/wCOnRFNK07IIx4Ig+WVv86zoHwVBrcrk0kv3r9YcDYuELXadZIuttP2FjSGY3yd4dNAYVVjrQw5LlpMsIcwxU0oqa+MGPDOkrJG+fVxchzTIplurDQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717972482; c=relaxed/simple;
	bh=7POtHIFBnIfQvUggHgsCUgRA8D1KL4yajWsmoQaTe9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEJW8AOiUVUdVUrr0Jenvf5W8fOaxyRljzDOUntFWwdBkdPlbLoOzKTvRWdYeUmgqnt4OA0LV7qVllK7XoKTFX0PHPLFxmdpUgiaThfhR5ZL+u+vpBukN1GOZdreyJAj/9uz5okjE7LTJmBxVnL3qV+/HFbvb1xTmy5lT/i0Te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwj1EMnu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717972481; x=1749508481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7POtHIFBnIfQvUggHgsCUgRA8D1KL4yajWsmoQaTe9k=;
  b=Bwj1EMnujoVnMIOHsZqXcqyQCvmbW3rbi919qut6P8dT1GiKhGdOQQrO
   ybc4K/iBXuEyKBv1K/jTSmFICmH/2tbdOyM70i367C5dLqjIFwNbGOanR
   M0P8rFhhUkiUeVNEChGCa1X5iUGf+CUDYvlViavn7o36C02Z8evW1IJn/
   WVwrGJ+JV4eIui+avKvqg7ZOehBuLTcu2pAG+xtko4zeNmIvpmYhLz8R7
   I4yTygOHJJlt8SVwlUYAtFnqp0whSpE1TRjJ0nveYNnlANr2Dl8DjwH3R
   fdM0jJ/9ItJZDG/R03oszbDh79xGTxGLEG/GaGhnW3MHozhaK3p4AKFtB
   Q==;
X-CSE-ConnectionGUID: yANDYUxSS++20z62wf6HVw==
X-CSE-MsgGUID: FTyfXxfvTS6MzoZgix08BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14803232"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="14803232"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:34:40 -0700
X-CSE-ConnectionGUID: RfCIc2f5TkCYoaPUy7JXMw==
X-CSE-MsgGUID: 4VQrmob1R6GwaE0Sbl6IBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="43314180"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2024 15:34:37 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGR7T-0001eE-0g;
	Sun, 09 Jun 2024 22:34:35 +0000
Date: Mon, 10 Jun 2024 06:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Richard chien <m8809301@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Richard chien <richard.chien@hpe.com>
Subject: Re: [PATCH] ixgbe: Add support for firmware update
Message-ID: <202406100635.nORK1Xs0-lkp@intel.com>
References: <20240609085735.6253-1-richard.chien@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609085735.6253-1-richard.chien@hpe.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]
[also build test WARNING on linus/master v6.10-rc3 next-20240607]
[cannot apply to tnguy-next-queue/dev-queue]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-chien/ixgbe-Add-support-for-firmware-update/20240609-170239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20240609085735.6253-1-richard.chien%40hpe.com
patch subject: [PATCH] ixgbe: Add support for firmware update
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240610/202406100635.nORK1Xs0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406100635.nORK1Xs0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406100635.nORK1Xs0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1104:9: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1104 |         default:
         |         ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1104:9: note: insert 'break;' to avoid fall-through
    1104 |         default:
         |         ^
         |         break; 
   1 warning generated.


vim +1104 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c

  1005	
  1006	static int ixgbe_nvmupd_validate_offset(struct ixgbe_adapter *adapter,
  1007	                                        u32 offset)
  1008	{
  1009	        struct net_device *netdev = adapter->netdev;
  1010	
  1011	        switch (offset) {
  1012	        case IXGBE_STATUS:
  1013	        case IXGBE_ESDP:
  1014	        case IXGBE_MSCA:
  1015	        case IXGBE_MSRWD:
  1016	        case IXGBE_EEC_8259X:
  1017	        case IXGBE_FLA_8259X:
  1018	        case IXGBE_FLOP:
  1019	        case IXGBE_SWSM_8259X:
  1020	        case IXGBE_FWSM_8259X:
  1021	        case IXGBE_FACTPS_8259X:
  1022	        case IXGBE_GSSR:
  1023	        case IXGBE_HICR:
  1024	        case IXGBE_FWSTS:
  1025	                return 0;
  1026	        default:
  1027	                if ((offset >= IXGBE_MAVTV(0) && offset <= IXGBE_MAVTV(7)) ||
  1028	                    (offset >= IXGBE_RAL(0) && offset <= IXGBE_RAH(15)))
  1029	                        return 0;
  1030	        }
  1031	
  1032	        switch (adapter->hw.mac.type) {
  1033	        case ixgbe_mac_82599EB:
  1034	                switch (offset) {
  1035	                case IXGBE_AUTOC:
  1036	                case IXGBE_EERD:
  1037	                case IXGBE_BARCTRL:
  1038	                        return 0;
  1039	                default:
  1040	                        if (offset >= 0x00020000 &&
  1041	                            offset <= ixgbe_get_eeprom_len(netdev))
  1042	                                return 0;
  1043	                }
  1044	                break;
  1045	        case ixgbe_mac_X540:
  1046	                switch (offset) {
  1047	                case IXGBE_EERD:
  1048	                case IXGBE_EEWR:
  1049	                case IXGBE_SRAMREL:
  1050	                case IXGBE_BARCTRL:
  1051	                        return 0;
  1052	                default:
  1053	                        if ((offset >= 0x00020000 &&
  1054	                             offset <= ixgbe_get_eeprom_len(netdev)))
  1055	                                return 0;
  1056	                }
  1057	                break;
  1058	        case ixgbe_mac_X550:
  1059	                switch (offset) {
  1060	                case IXGBE_EEWR:
  1061	                case IXGBE_SRAMREL:
  1062	                case IXGBE_PHYCTL_82599:
  1063	                case IXGBE_FWRESETCNT:
  1064	                        return 0;
  1065	                default:
  1066	                        if (offset >= IXGBE_FLEX_MNG_PTR(0) &&
  1067	                            offset <= IXGBE_FLEX_MNG_PTR(447))
  1068	                                return 0;
  1069	                }
  1070	                break;
  1071	        case ixgbe_mac_X550EM_x:
  1072	                switch (offset) {
  1073	                case IXGBE_PHYCTL_82599:
  1074	                case IXGBE_NW_MNG_IF_SEL:
  1075	                case IXGBE_FWRESETCNT:
  1076	                case IXGBE_I2CCTL_X550:
  1077	                        return 0;
  1078	                default:
  1079	                        if ((offset >= IXGBE_FLEX_MNG_PTR(0) &&
  1080	                             offset <= IXGBE_FLEX_MNG_PTR(447)) ||
  1081	                            (offset >= IXGBE_FUSES0_GROUP(0) &&
  1082	                             offset <= IXGBE_FUSES0_GROUP(7)))
  1083	                                return 0;
  1084	                }
  1085	                break;
  1086	        case ixgbe_mac_x550em_a:
  1087	                switch (offset) {
  1088	                case IXGBE_PHYCTL_82599:
  1089	                case IXGBE_NW_MNG_IF_SEL:
  1090	                case IXGBE_FWRESETCNT:
  1091	                case IXGBE_I2CCTL_X550:
  1092	                case IXGBE_FLA_X550EM_a:
  1093	                case IXGBE_SWSM_X550EM_a:
  1094	                case IXGBE_FWSM_X550EM_a:
  1095	                case IXGBE_SWFW_SYNC_X550EM_a:
  1096	                case IXGBE_FACTPS_X550EM_a:
  1097	                case IXGBE_EEC_X550EM_a:
  1098	                        return 0;
  1099	                default:
  1100	                        if (offset >= IXGBE_FLEX_MNG_PTR(0) &&
  1101	                            offset <= IXGBE_FLEX_MNG_PTR(447))
  1102	                                return 0;
  1103	                }
> 1104	        default:
  1105	                break;
  1106	        }
  1107	
  1108	        return -ENOTTY;
  1109	}
  1110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

