Return-Path: <netdev+bounces-204339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B1AFA19B
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18261169DD1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E121858A;
	Sat,  5 Jul 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6BchwXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E881FC104
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744374; cv=none; b=gawOF1WCmpTJ5V7mG8/igFOk+58uKFPJ9x+Z5sVmt6zj62XytI64NOLSkSjsgm4Fewxqk78uPXsxU0uMOvuxtePfaruJ1JfUk9h+h8bn1/z1ihZKT9e6d2DEDIuBRgoqgQd38tlsofo2uXzUV4MxciYXWINFFhQ3Si75eqEhQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744374; c=relaxed/simple;
	bh=yeHuztYKX/J87YvswDe2bHMcYUEpJjESV2g0dxCOA3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQQ94LjJcOCQgpa85sS2cmQkBmAd7UPyBUup+XS/bbUapUUsPrsIeyW2pVQ6XsPLb0dX5FagCHH4QmR1rMyIPFvfQ/1sd2dyA+5Qzr7vdEZuQ884Hlldd0EyRofLQ+XmEuDcXvZgNR2zv0m4rg2xWYAZKVlVOqNKh7CKL69NMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6BchwXZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751744374; x=1783280374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yeHuztYKX/J87YvswDe2bHMcYUEpJjESV2g0dxCOA3w=;
  b=c6BchwXZARLFSigltHT75qotURBXabsbC8gqTQccO4sPTbXMfsqwiA/t
   Nm9SP8XJV3ZBnD5Rty8OFWgbnHYwSD2E3+SYqTp6QVIY+fQN5Da6u8EWu
   dkboxV8WlDPhGdlrD0jNQSZDNEa7nkTfyYF1MPtdZPVobeNV12TE8qy87
   d9wmCZLxjoqLiJhocKW27YaBgNzDG79WSU7kf6MOfA2jW9JYfUWYycFOi
   gdFP4zzkoy51UB7L8bp3bQH8sNUqiVBQqFtM2VJERJ+DL2bf2aMoo6ni0
   f3tccSat3mzZvX8tPXPt/otZ58t60ZWryyxJd9GXcXNW+Y/Xt43IJ568W
   g==;
X-CSE-ConnectionGUID: GVtChrt/T8WxgKLfVpWgpA==
X-CSE-MsgGUID: d/9/Jze+RvOFZki0R5PHFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="54138983"
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="54138983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 12:39:33 -0700
X-CSE-ConnectionGUID: D2buj6/PSK+QwWkOHwBSlA==
X-CSE-MsgGUID: zOQacUnnQ/GfQ+24ECwKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,290,1744095600"; 
   d="scan'208";a="192044663"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Jul 2025 12:39:30 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uY8jQ-0004gd-1b;
	Sat, 05 Jul 2025 19:39:28 +0000
Date: Sun, 6 Jul 2025 03:38:56 +0800
From: kernel test robot <lkp@intel.com>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH v4 iwl-next] ice: add recovery clock and clock 1588
 control for E825c
Message-ID: <202507060341.1fxNEfxg-lkp@intel.com>
References: <20250704155155.1976706-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704155155.1976706-1-grzegorz.nitka@intel.com>

Hi Grzegorz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6dbc64bfa1f08ecc3770d1c795ecdde25167fe63]

url:    https://github.com/intel-lab-lkp/linux/commits/Grzegorz-Nitka/ice-add-recovery-clock-and-clock-1588-control-for-E825c/20250704-235415
base:   6dbc64bfa1f08ecc3770d1c795ecdde25167fe63
patch link:    https://lore.kernel.org/r/20250704155155.1976706-1-grzegorz.nitka%40intel.com
patch subject: [PATCH v4 iwl-next] ice: add recovery clock and clock 1588 control for E825c
config: x86_64-randconfig-121-20250705 (https://download.01.org/0day-ci/archive/20250706/202507060341.1fxNEfxg-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250706/202507060341.1fxNEfxg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507060341.1fxNEfxg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:135:51: sparse: sparse: Using plain integer as NULL pointer
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:136:51: sparse: sparse: Using plain integer as NULL pointer
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:364:9: sparse: sparse: context imbalance in 'ice_ptp_exec_tmr_cmd' - wrong count at exit

vim +135 drivers/net/ethernet/intel/ice/ice_ptp_hw.c

   133	
   134	static const struct ice_cgu_pin_desc ice_e825c_inputs[] = {
 > 135		{ "CLK_IN_0",	 0, DPLL_PIN_TYPE_MUX, 0, 0},
   136		{ "CLK_IN_1",	 0, DPLL_PIN_TYPE_MUX, 0, 0},
   137	};
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

