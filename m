Return-Path: <netdev+bounces-141136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B713D9B9B82
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 01:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D530B1C21356
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC1184F;
	Sat,  2 Nov 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCk66Rwj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56F23CB
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506336; cv=none; b=rZXW+X/PZ37JnQWxJEquhoN7evzQG6BTS1IM4JBXK3S0NwH97LmLthqvIUH1PaMllnAMQOLk0JHe81y8ONgw7HPJoTJz7J9K1gcu8avTg6diVOtiFRhc69XDrydhnjhNnQaSBZkA+HPF4/esIzRU6wToOfjDalmxypi1OaH+r/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506336; c=relaxed/simple;
	bh=xv+nykGXHVSjOSmJkCXOvxnP2m+hqI1dTS+fBxn4gvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYqWVZuopQnzxHA99hd6P3Jkv9KW3Kn+R8T+Uu8kM6Ybk9ygPXEbpyTfciTptpxiZyfH964takGdWn1c6UjtDmW5M8lSvi3/qXNAA8ahEvsysAHbC68WK9DvZ28PyVQNGqnVxILuVRUZ2WSsiRTTIIwxiURt37yy8OuaU/TFdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCk66Rwj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730506333; x=1762042333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xv+nykGXHVSjOSmJkCXOvxnP2m+hqI1dTS+fBxn4gvc=;
  b=oCk66RwjBNH4UpDfY9DN3J/PuaOfGhV86qLvPvSzlG17jYq0KQgDbLCy
   8VUMzSM2gUmjhLSVXy8eQX7wnGKWG4xja2OZa5fiHJnZe78qTn0SK0Ue/
   Q4Qn+C8IpPMwc8xQ5/CqMBPdz3dkWSRxBa1DGRD9nLNBplsCmXetuPNHx
   PKjcYBF2g5TOv4yMeOao2iJicpry1C8SM8y4g/Ut8XveXkw/wTE+/ZA9t
   ZuEOTBmH/u1gKNOQJs5lj50C40+bl8cAk7Co+px415hrBOxkZlEl6RdfU
   6njEifGWjM7Vep4GSgNiHjFFB2+Hu1Rh8U9XvyxKzoz1GUjrTSGUikcXJ
   w==;
X-CSE-ConnectionGUID: msNtNrjET3SYz4XLJ4Y/xw==
X-CSE-MsgGUID: NmpXJ797Qi2Umq3MBmB9Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29708503"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="29708503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 17:12:12 -0700
X-CSE-ConnectionGUID: SYcSZUb8SY2zz3VY3iFssg==
X-CSE-MsgGUID: B71jvY/mS+aLgDu8y++ckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83559994"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Nov 2024 17:12:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t71kJ-000iCJ-1u;
	Sat, 02 Nov 2024 00:12:03 +0000
Date: Sat, 2 Nov 2024 08:11:54 +0800
From: kernel test robot <lkp@intel.com>
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, David Arinzon <darinzon@amazon.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: Re: [PATCH v2 net-next 1/3] net: ena: Add PHC support in the ENA
 driver
Message-ID: <202411020715.L7KdiUt4-lkp@intel.com>
References: <20241031085245.18146-2-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031085245.18146-2-darinzon@amazon.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Arinzon/net-ena-Add-PHC-support-in-the-ENA-driver/20241031-165503
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241031085245.18146-2-darinzon%40amazon.com
patch subject: [PATCH v2 net-next 1/3] net: ena: Add PHC support in the ENA driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241102/202411020715.L7KdiUt4-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020715.L7KdiUt4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020715.L7KdiUt4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/amazon/ena/ena_com.c:6:
   In file included from drivers/net/ethernet/amazon/ena/ena_com.h:11:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
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
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/amazon/ena/ena_com.c:1703:7: error: expected ')'
    1703 |                                   ENA_ADMIN_PHC_CONFIG,
         |                                   ^
   drivers/net/ethernet/amazon/ena/ena_com.c:1701:27: note: to match this '('
    1701 |         ret = ena_com_get_feature(ena_dev,
         |                                  ^
   4 warnings and 1 error generated.


vim +1703 drivers/net/ethernet/amazon/ena/ena_com.c

  1691	
  1692	int ena_com_phc_config(struct ena_com_dev *ena_dev)
  1693	{
  1694		struct ena_com_phc_info *phc = &ena_dev->phc;
  1695		struct ena_admin_get_feat_resp get_feat_resp;
  1696		struct ena_admin_set_feat_resp set_feat_resp;
  1697		struct ena_admin_set_feat_cmd set_feat_cmd;
  1698		int ret = 0;
  1699	
  1700		/* Get device PHC default configuration */
  1701		ret = ena_com_get_feature(ena_dev,
  1702					  &get_feat_resp
> 1703					  ENA_ADMIN_PHC_CONFIG,
  1704					  0);
  1705		if (unlikely(ret)) {
  1706			netdev_err(ena_dev->net_device,
  1707				   "Failed to get PHC feature configuration, error: %d\n",
  1708				   ret);
  1709			return ret;
  1710		}
  1711	
  1712		/* Supporting only readless PHC retrieval */
  1713		if (get_feat_resp.u.phc.type != ENA_ADMIN_PHC_TYPE_READLESS) {
  1714			netdev_err(ena_dev->net_device, "Unsupported PHC type, error: %d\n",
  1715				   -EOPNOTSUPP);
  1716			return -EOPNOTSUPP;
  1717		}
  1718	
  1719		/* Update PHC doorbell offset according to device value,
  1720		 * used to write req_id to PHC bar
  1721		 */
  1722		phc->doorbell_offset = get_feat_resp.u.phc.doorbell_offset;
  1723	
  1724		/* Update PHC expire timeout according to device
  1725		 * or default driver value
  1726		 */
  1727		phc->expire_timeout_usec = (get_feat_resp.u.phc.expire_timeout_usec) ?
  1728					    get_feat_resp.u.phc.expire_timeout_usec :
  1729					    ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC;
  1730	
  1731		/* Update PHC block timeout according to device
  1732		 * or default driver value
  1733		 */
  1734		phc->block_timeout_usec = (get_feat_resp.u.phc.block_timeout_usec) ?
  1735					   get_feat_resp.u.phc.block_timeout_usec :
  1736					   ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC;
  1737	
  1738		/* Sanity check - expire timeout must not be above skip timeout */
  1739		if (phc->expire_timeout_usec > phc->block_timeout_usec)
  1740			phc->expire_timeout_usec = phc->block_timeout_usec;
  1741	
  1742		/* Prepare PHC config feature command */
  1743		memset(&set_feat_cmd, 0x0, sizeof(set_feat_cmd));
  1744		set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
  1745		set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
  1746		set_feat_cmd.u.phc.output_length = sizeof(*phc->virt_addr);
  1747		ret = ena_com_mem_addr_set(ena_dev,
  1748					   &set_feat_cmd.u.phc.output_address,
  1749					   phc->phys_addr);
  1750		if (unlikely(ret)) {
  1751			netdev_err(ena_dev->net_device, "Failed setting PHC output address, error: %d\n",
  1752				   ret);
  1753			return ret;
  1754		}
  1755	
  1756		/* Send PHC feature command to the device */
  1757		ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
  1758						    (struct ena_admin_aq_entry *)&set_feat_cmd,
  1759						    sizeof(set_feat_cmd),
  1760						    (struct ena_admin_acq_entry *)&set_feat_resp,
  1761						    sizeof(set_feat_resp));
  1762	
  1763		if (unlikely(ret)) {
  1764			netdev_err(ena_dev->net_device,
  1765				   "Failed to enable PHC, error: %d\n",
  1766				   ret);
  1767			return ret;
  1768		}
  1769	
  1770		phc->active = true;
  1771		netdev_dbg(ena_dev->net_device, "PHC is active in the device\n");
  1772	
  1773		return ret;
  1774	}
  1775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

