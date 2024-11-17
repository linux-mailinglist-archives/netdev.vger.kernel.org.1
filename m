Return-Path: <netdev+bounces-145611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CA9D01D3
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D20C1F22E7D
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFABBB652;
	Sun, 17 Nov 2024 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGuHrdES"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611928F5;
	Sun, 17 Nov 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731806916; cv=none; b=lV/OVaS22wWKB8qdyhkaQbg7PrYW6Nlt+yAfrO8loixyqwSaAuTt6tnISJPpqHUz6/HzGECOiFwQYIsidRbGNTqi6ICQhoo922WXTZZgXUhr6GJ8EPwcY+UVBncot8kjVpux1a0FAzGrXIULSW1VM9T41gSRoEpY84MTx0NCiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731806916; c=relaxed/simple;
	bh=PCcdSgA/1OmuD7op38DOfI+lwyCKBvubLb11kK/+qzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY/T2Sg7640+6SfjYBavLxnrs3h57meSzlMvAQNivzc0vVhkruPB39etbS55ayBgSVOQ9HRpR3dM1WyD3V3wSug9GqshU6bBf0HNtt+Vj6rdhdB4oe2wTAfHDG5ehIMlZjboa4/ZKuQZ5BcmZ+wIv6QzFlgWNXKOWMH38aWrOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGuHrdES; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731806914; x=1763342914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PCcdSgA/1OmuD7op38DOfI+lwyCKBvubLb11kK/+qzU=;
  b=dGuHrdESBpBu22VX1gxz87t7qsF++E2U7atNxRLiwjrmxGfqdvFEl4f4
   IpU7nNnPvJZ8N0zlSkkvKrMKBv/SHYx9sGJBWy3TvbOnYu/yAHeecQV3N
   XgI5/wwfVxTyd9smPIko+h2H+5aH8HMd6KZY5mGbwvDr/RyIAfhy29CWY
   5zCWTEFwdENal3fqrMBPIpAUWjZNdpiPlS+/x5chcM5XTMy+pux1FArjV
   yLIRLrzdlLgSaDrGqXbDNlQVK3Z1Xjb/mN5sJsJdc6yD0/NcUlC6jo+wG
   HjFhr6AdGvrw1PDurtyj9c2gJv+zUnk5VjktgAc6ZJKVGU+LtbPm/g59i
   g==;
X-CSE-ConnectionGUID: xxStmAXxQI+a/kQ0rxbJHg==
X-CSE-MsgGUID: q198bREHSvi6PU3UDsIwjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="57193723"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="57193723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 17:28:33 -0800
X-CSE-ConnectionGUID: GL6swRqATFSUDV3BzVTWvg==
X-CSE-MsgGUID: 9HkT9VndSEiCBGuUTd1rzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93920878"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Nov 2024 17:28:29 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCU5R-0001DB-2v;
	Sun, 17 Nov 2024 01:28:25 +0000
Date: Sun, 17 Nov 2024 09:28:11 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <202411170906.mCmSa3oY-lkp@intel.com>
References: <20241114024928.60004-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114024928.60004-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc7 next-20241115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241114-105151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114024928.60004-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response ACK
config: x86_64-randconfig-161-20241117 (https://download.01.org/0day-ci/archive/20241117/202411170906.mCmSa3oY-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170906.mCmSa3oY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170906.mCmSa3oY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/acpi-cpufreq.c:31:
   In file included from include/acpi/cppc_acpi.h:17:
>> include/acpi/pcc.h:51:10: error: expected ';' after return statement
      51 |         return 0
         |                 ^
         |                 ;
>> include/acpi/pcc.h:49:5: warning: no previous prototype for function 'pcc_mbox_ioremap' [-Wmissing-prototypes]
      49 | int pcc_mbox_ioremap(struct mbox_chan *chan)
         |     ^
   include/acpi/pcc.h:49:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      49 | int pcc_mbox_ioremap(struct mbox_chan *chan)
         | ^
         | static 
   1 warning and 1 error generated.
--
   In file included from drivers/cpufreq/intel_pstate.c:30:
   In file included from include/trace/events/power.h:12:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/cpufreq/intel_pstate.c:48:
   In file included from include/acpi/cppc_acpi.h:17:
>> include/acpi/pcc.h:51:10: error: expected ';' after return statement
      51 |         return 0
         |                 ^
         |                 ;
>> include/acpi/pcc.h:49:5: warning: no previous prototype for function 'pcc_mbox_ioremap' [-Wmissing-prototypes]
      49 | int pcc_mbox_ioremap(struct mbox_chan *chan)
         |     ^
   include/acpi/pcc.h:49:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      49 | int pcc_mbox_ioremap(struct mbox_chan *chan)
         | ^
         | static 
   4 warnings and 1 error generated.


vim +51 include/acpi/pcc.h

    36	
    37	#ifdef CONFIG_PCC
    38	extern struct pcc_mbox_chan *
    39	pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
    40	extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
    41	extern int pcc_mbox_ioremap(struct mbox_chan *chan);
    42	#else
    43	static inline struct pcc_mbox_chan *
    44	pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
    45	{
    46		return ERR_PTR(-ENODEV);
    47	}
    48	static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
  > 49	int pcc_mbox_ioremap(struct mbox_chan *chan)
    50	{
  > 51		return 0
    52	};
    53	#endif
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

