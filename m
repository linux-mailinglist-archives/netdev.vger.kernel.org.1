Return-Path: <netdev+bounces-199387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FBAE01F9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD617F17D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C6220F4F;
	Thu, 19 Jun 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JO6oj8V/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330C21B9C0;
	Thu, 19 Jun 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326404; cv=none; b=a4OJv/PpunmKLGf0330tjSoy/wGh/dbnqfGjQv2HuHpe3an6IiPDSkd+CyQ0XXjZSZ/EgI73xDouAL2GTsFRazxSDnm2XtzXS5/7b0paQuggohqCMfyLe+EG4uy3RxSgbkY6SHuaC36an9LS4BBSoSTsC3qb8xcsQEES61jQDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326404; c=relaxed/simple;
	bh=r1Ar8ZQ4D9/WtFd5hRo45kEmZ+WsfRpMNPKRKqGWvds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taQkVGVbmaSNzKL9IwHlbIZC4N6mF+2bbUHKZJoNvRUB+Kot2dwub+uBYN+yM8DcIupPrfdEgPYGxac4BKMCg/AaxJwaV/GmwDCcivD9cV/VuhD3mAPkd9JJiXtwC23lcrtjD+tG+rwIznA87ORy99OkUjjIPMjz7QUa+cse/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JO6oj8V/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750326403; x=1781862403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1Ar8ZQ4D9/WtFd5hRo45kEmZ+WsfRpMNPKRKqGWvds=;
  b=JO6oj8V/whTjyaNd2C/242GD7d0Co+VO7OK/VKTr9CKtg86YyEwy5yal
   oIAvfKOzc1r6WN2ENZFCpXK/rYk6e1j5e+4QHWsQwJs3777vUPE3vOvNy
   i+A2de6iXsJTzOF32b63FA6l1Nc3WLUeUl57ybCbJW7i704sJGmjwxVgI
   NiLBw/Vje1jvfK2KwUVW4M9ftTrFDaD9O3EDwDPaoD3c63TFn0GvxPPEt
   Avtg8NfGCN55BKd6hZxi7OwxikOn0MNO41goP5U9pMC0UuClDKWygTJwN
   ofmrMMjoFcQyyUo1MK5tB7mYx9CdfhtLhOXouG64OSlysdwgwZtpKwtq1
   w==;
X-CSE-ConnectionGUID: Ks/UGMX5Q3OoHDYdyzfwPw==
X-CSE-MsgGUID: STOgO8BRQ4qXG5swJvLPKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51683409"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="51683409"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 02:46:42 -0700
X-CSE-ConnectionGUID: I0Y4y6uZTQuwsbi+3UEesg==
X-CSE-MsgGUID: fAsgOCE5RpuNzUuUl2Do/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="151080205"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2025 02:46:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSBqu-000Kd4-1R;
	Thu, 19 Jun 2025 09:46:36 +0000
Date: Thu, 19 Jun 2025 17:46:09 +0800
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
Subject: Re: [net-next, 03/10] bng_en: Add firmware communication mechanism
Message-ID: <202506191741.1C9E7i3x-lkp@intel.com>
References: <20250618144743.843815-4-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618144743.843815-4-vikas.gupta@broadcom.com>

Hi Vikas,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc2 next-20250618]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-4-vikas.gupta%40broadcom.com
patch subject: [net-next, 03/10] bng_en: Add firmware communication mechanism
config: parisc-randconfig-r073-20250619 (https://download.01.org/0day-ci/archive/20250619/202506191741.1C9E7i3x-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506191741.1C9E7i3x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506191741.1C9E7i3x-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: hppa-linux-ld: DWARF error: could not find abbrev number 1754059
   drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `__hwrm_req_init':
>> bnge_hwrm.c:(.text+0x96c): multiple definition of `__hwrm_req_init'; hppa-linux-ld: DWARF error: could not find abbrev number 179644068
   drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0xccc): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_timeout':
>> bnge_hwrm.c:(.text+0xa90): multiple definition of `hwrm_req_timeout'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0xdf0): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_alloc_flags':
>> bnge_hwrm.c:(.text+0xac8): multiple definition of `hwrm_req_alloc_flags'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0xe28): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_flags':
>> bnge_hwrm.c:(.text+0xb00): multiple definition of `hwrm_req_flags'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0xf9c): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_hold':
>> bnge_hwrm.c:(.text+0xb48): multiple definition of `hwrm_req_hold'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0xfe4): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_drop':
>> bnge_hwrm.c:(.text+0xbd0): multiple definition of `hwrm_req_drop'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0x106c): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_send':
>> bnge_hwrm.c:(.text+0xc10): multiple definition of `hwrm_req_send'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0x12f0): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_send_silent':
>> bnge_hwrm.c:(.text+0xc50): multiple definition of `hwrm_req_send_silent'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0x1330): first defined here
   hppa-linux-ld: drivers/net/ethernet/broadcom/bnge/bnge_hwrm.o: in function `hwrm_req_dma_slice':
>> bnge_hwrm.c:(.text+0xca8): multiple definition of `hwrm_req_dma_slice'; drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.o:bnxt_hwrm.c:(.text+0x1388): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

