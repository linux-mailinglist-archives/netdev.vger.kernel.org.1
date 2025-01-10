Return-Path: <netdev+bounces-156946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3AA085BD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 04:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E41F7A25E9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD471A4F1F;
	Fri, 10 Jan 2025 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2V4sMB/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF6502B1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478084; cv=none; b=uTmyfeaoS5ZbezPnZxfL72pYLhthasCdmfcQk3udgPFcbpB/D+QGQxn+KedrZSRIjSTf6tLIuT2QU/Oi7/ipXWZ+xF01pH6QH+HHcCpN88Y7mhtAVkFluMHloQvQKU4JkCcChb0JGIsG/38w0DZXPejlnVm5E9JrEpNc7xxqbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478084; c=relaxed/simple;
	bh=OxkOxjTS3fWMLwihl4/17Mf9luvPmMspJ48TJAbinbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgWdeQ/5fcPe+Cvm/r5U+mfANwkAmb7bZpO1E6/bBHMJ9XhklRydOBGQBpbqW1R8W+yMdTawyW8BKcsaY3EkV4CvFzp3fu9BiHVKXdZB9nC9N0jObokMeQAKmEP/M5hJf/S9Kl5VanUXsohXnUmOzRli5PgmwT4SpmPXLSP+eIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2V4sMB/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736478083; x=1768014083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OxkOxjTS3fWMLwihl4/17Mf9luvPmMspJ48TJAbinbQ=;
  b=P2V4sMB/W3cl9G3SS9itQcH++hHA4vPWILXs6y60pQYHtfXCLw3gQWlD
   P9tMT92+XAiDO5sEcCGIrGr8Ap9tn1Ca/40G3CjwNLlf9IzJFapxrAG9Y
   HCDeQovmam7eLU0QeZZ4ORvtZK5xUtEgqfTiOxKi79o/3G3x0CvdQMuhP
   c0e/NCSMKjGcloZzDPsJqJ+/4erVak6kd0W91IXVg2FWmhRBmuncJaO1d
   fhypyS4tah46jWNe0KsgzzfIpY/SzLgEiJ/EkBrh3qLlFG8Ls6AbDTuJi
   0R1yt8EAWxRfq1u7+InKZt0k54v7B5TDUrfav+9ZdR6peeSs7Xe5N5nFP
   A==;
X-CSE-ConnectionGUID: Jb64aDv+Soil8oG6bzJing==
X-CSE-MsgGUID: HiGmgjIoQRKGzxPH+wq6Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54306661"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="54306661"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 19:01:22 -0800
X-CSE-ConnectionGUID: 6w9N8g2pRayk35v4Gfiu1A==
X-CSE-MsgGUID: qGCggdHAT+CYpiYMF0jpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="104128428"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jan 2025 19:01:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW5Gu-000IRn-00;
	Fri, 10 Jan 2025 03:01:16 +0000
Date: Fri, 10 Jan 2025 11:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 3/6] net: napi: add CPU
 affinity to napi_config
Message-ID: <202501101047.KVl1kI5I-lkp@intel.com>
References: <20250109233107.17519-4-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109233107.17519-4-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-move-ARFS-rmap-management-to-core/20250110-073339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250109233107.17519-4-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v4 3/6] net: napi: add CPU affinity to napi_config
config: arm-randconfig-003-20250110 (https://download.01.org/0day-ci/archive/20250110/202501101047.KVl1kI5I-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501101047.KVl1kI5I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501101047.KVl1kI5I-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/dev.c:6795:37: error: no member named 'rx_cpu_rmap' in 'struct net_device'
    6795 |         struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
         |                                 ~~~~~~~~~  ^
>> net/core/dev.c:6797:18: error: no member named 'napi_rmap_idx' in 'struct napi_struct'
    6797 |         rmap->obj[napi->napi_rmap_idx] = NULL;
         |                   ~~~~  ^
   2 errors generated.


vim +6795 net/core/dev.c

064d6072cac4f4 Ahmed Zaki 2025-01-09  6789  
064d6072cac4f4 Ahmed Zaki 2025-01-09  6790  static void
064d6072cac4f4 Ahmed Zaki 2025-01-09  6791  netif_napi_affinity_release(struct kref *ref)
064d6072cac4f4 Ahmed Zaki 2025-01-09  6792  {
064d6072cac4f4 Ahmed Zaki 2025-01-09  6793  	struct napi_struct *napi =
064d6072cac4f4 Ahmed Zaki 2025-01-09  6794  		container_of(ref, struct napi_struct, notify.kref);
064d6072cac4f4 Ahmed Zaki 2025-01-09 @6795  	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
064d6072cac4f4 Ahmed Zaki 2025-01-09  6796  
064d6072cac4f4 Ahmed Zaki 2025-01-09 @6797  	rmap->obj[napi->napi_rmap_idx] = NULL;
064d6072cac4f4 Ahmed Zaki 2025-01-09  6798  	cpu_rmap_put(rmap);
064d6072cac4f4 Ahmed Zaki 2025-01-09  6799  }
064d6072cac4f4 Ahmed Zaki 2025-01-09  6800  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

