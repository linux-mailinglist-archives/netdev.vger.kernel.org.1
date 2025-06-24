Return-Path: <netdev+bounces-200468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA5AE58C4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69847A3572
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53B13B5A9;
	Tue, 24 Jun 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P17eV58J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600533594B;
	Tue, 24 Jun 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725837; cv=none; b=jHpE/Ip9t3clE05c6jBfwRxWZjn5EhCAgpx/iiANqpKXCtI5Nm9V9dKvmKmtmc+/lD5QUy2gObV+Hjy329jBeZUNRSBXBchbwNKXnZcRJAuKhQMCFS3P8OLfzPMh2k4pvCicx4GxYZre1k3V2Mdtca1eyS3erdZ7MN5ja7/QhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725837; c=relaxed/simple;
	bh=4v5jeSRvczwqwtWBtgX+6yxvBIBymneR13YVpaJS88s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spCcNh8Y8hFecZebOmygftGPkL2IBes203rSlcnQx5zCEGw27LdjIWbayWShMYaMJozDq0VkHE8eGVN9O0O/eQV4x75JGysvM1jrikAmD0F+AvyiXtW7kCDPs/U+/icxTx9hg+0jwqeyoRnc9P0yv8/le2F2LzBLN6le9QH+qAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P17eV58J; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725837; x=1782261837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4v5jeSRvczwqwtWBtgX+6yxvBIBymneR13YVpaJS88s=;
  b=P17eV58JT/hnYWkLXbEB+QXbL1XUbceM5bgWIPJdaRs7d91pCILnyjla
   gNAelXMh4RJoufXQKK6VewDwSdxv0nmf92aT21J7eNtIDEdLbLBQftgov
   GnYrUtnRpSaN+IlgT0BNfjUq+4GSJsFR2+XTeDF6uIsnhQkGvuAY/99F7
   6tIJ3JbAKWloA+PMoa5LtnditQMXEg8hx+udJk0QuHHrjmyGH1nYy03aI
   YpTG7RayxqUWpQoCJbtgwJwvhVs/jdwD+Sgzt4ost38NDiV14R5mpvgnd
   vVgbsxxBz2ifz9I6DjXkZf2X+hNRofXiuyQDFEzSxcu2euW4420T4yzpA
   Q==;
X-CSE-ConnectionGUID: H7teInt1RfuJfizLyLE85g==
X-CSE-MsgGUID: HZOXtTZPQqCYeBhf4nNFYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52069597"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52069597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:43:56 -0700
X-CSE-ConnectionGUID: U0JSscOKQk2HxGUrroruAA==
X-CSE-MsgGUID: XQ6fHgNQRnmUOq4v5liCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151174974"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 23 Jun 2025 17:43:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTrlN-000RYo-1r;
	Tue, 24 Jun 2025 00:43:49 +0000
Date: Tue, 24 Jun 2025 08:42:57 +0800
From: kernel test robot <lkp@intel.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, 10/10] bng_en: Add a network device
Message-ID: <202506240834.02LQ6IMr-lkp@intel.com>
References: <20250618144743.843815-11-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618144743.843815-11-vikas.gupta@broadcom.com>

Hi Vikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250623]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-11-vikas.gupta%40broadcom.com
patch subject: [net-next, 10/10] bng_en: Add a network device
config: i386-randconfig-061-20250621 (https://download.01.org/0day-ci/archive/20250624/202506240834.02LQ6IMr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240834.02LQ6IMr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506240834.02LQ6IMr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c:26:26: sparse: sparse: symbol 'bnge_ethtool_ops' was not declared. Should it be static?

vim +/bnge_ethtool_ops +26 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

    25	
  > 26	const struct ethtool_ops bnge_ethtool_ops = {
    27		.get_drvinfo		= bnge_get_drvinfo,
    28	};
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

