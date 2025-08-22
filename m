Return-Path: <netdev+bounces-216166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98297B32516
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E3D1B63CB5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3C328135B;
	Fri, 22 Aug 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgcbTPge"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF427587C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902122; cv=none; b=hPj26NBp9o6JujA71hm8SJm822xv4hvBCCwvLTz5C+3/xkGGKBYSZxOY51uK+Qv18xjGzmaRItKCmqoB5cczUvPTyuJsa7VdeFzmyNtP6pfdemlFPwFJdph47CwonO32P9j4BFfP3KevV8+IxZwdCwHKrcb+AMjx8atvA7oDLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902122; c=relaxed/simple;
	bh=R5PaTuYrgUIRNnUfVveRfz0LrC26l6MrG1wU0QZXikE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF7ZbvgLLlneJi6oHwBwOyuPWDLQLOIkGTrJTkeXk+ypyTfWTjmtWG8v1YVWPvqxltM8TMarLRY2lkA3INIM8aSo3aRLth3m7XANV4l1JH2aNCDXud2ShRGnmCGf2bXj5mdfhKCFmMO+y9sV8VbhL5zhj/H6s5dE2KS2Ksxx6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgcbTPge; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902120; x=1787438120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R5PaTuYrgUIRNnUfVveRfz0LrC26l6MrG1wU0QZXikE=;
  b=MgcbTPgeMC8NApcXWTIWRSNXhlJIsZMqv1q6ZozitdcZ/Edf02IMQmeL
   5kox5Na+H2PitjCsBZJSfZdvd64medANUeBzWWX+2GnRy+CkuRy4WpWvS
   paQ6AjGie3rVu/h22esw5hoyq2z7oTeBPb1FOEv3B/a9xUeo21rNecxk0
   cznOF5PYfPmUOEGUCrs6+EWHpKecCNaOC3BVVvA1cxDMwLNyvWCJQnJZV
   WwzH9fcEPYg8rTN0Z1OI0do6O/zZab+hKhevCiVCSYBskMEfPdeJhT0Bw
   wa9k/7IUps3Vm/WrlokEcuT5Cy6oNzztvKYaMXRhpJbcGLEAUT7mKcXlL
   w==;
X-CSE-ConnectionGUID: A757M9xyTtWM0mo1yqOyWg==
X-CSE-MsgGUID: gTaQpRh7QU6TvXtrfklqNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62046730"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62046730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:35:18 -0700
X-CSE-ConnectionGUID: 6jX73bC2T3Opq9Yjcn+fYQ==
X-CSE-MsgGUID: ILGDVUOPTqi4GxU0i/InIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173076860"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Aug 2025 15:35:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upaLp-000LtD-3C;
	Fri, 22 Aug 2025 22:35:13 +0000
Date: Sat, 23 Aug 2025 06:34:41 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <202508230602.GmZrkmas-lkp@intel.com>
References: <20250822-airoha-en7581-wlan-rx-offload-v2-2-8a76e1d3fec2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-airoha-en7581-wlan-rx-offload-v2-2-8a76e1d3fec2@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on a7bd72158063740212344fad5d99dcef45bc70d6]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-airoha-Rely-on-airoha_eth-struct-in-airoha_ppe_flow_offload_cmd-signature/20250822-151720
base:   a7bd72158063740212344fad5d99dcef45bc70d6
patch link:    https://lore.kernel.org/r/20250822-airoha-en7581-wlan-rx-offload-v2-2-8a76e1d3fec2%40kernel.org
patch subject: [PATCH net-next v2 2/3] net: airoha: Add airoha_ppe_dev struct definition
config: powerpc64-randconfig-003-20250823 (https://download.01.org/0day-ci/archive/20250823/202508230602.GmZrkmas-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230602.GmZrkmas-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230602.GmZrkmas-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/airoha/airoha_eth.h:16,
                    from drivers/net/ethernet/airoha/airoha_npu.c:15:
>> include/linux/soc/airoha/airoha_offload.h:31:15: error: unknown type name 'airoha_ppe_dev'
      31 | static inline airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
         |               ^~~~~~~~~~~~~~


vim +/airoha_ppe_dev +31 include/linux/soc/airoha/airoha_offload.h

    24	
    25	static inline int airoha_ppe_dev_setup_tc_block_cb(struct airoha_ppe_dev *dev,
    26							   void *type_data)
    27	{
    28		return dev->ops.setup_tc_block_cb(dev, type_data);
    29	}
    30	#else
  > 31	static inline airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
    32	{
    33		return NULL;
    34	}
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

