Return-Path: <netdev+bounces-141067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4D9B9596
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B521F22FC6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7A1A2562;
	Fri,  1 Nov 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRO7P6XL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C31C2456
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479077; cv=none; b=L8VYvQHqKRf/GSStriy4fepLqiQnfnE74BZowmDd7t1/Fn8sREjk7fDrJCoTlEu9oyGVuM6vKZgdSRh5kgIB9NeC/tVB4inmxAy7MtancdSy5+akhTFlE9456NhF92r9x3fOlON79lIi+YEsQB5RaaUWjo7TDILPmKy84WA5zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479077; c=relaxed/simple;
	bh=I7oORcEtGj/iiaA43PSLCnPafGuurwysB9AtbJETIaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5qUyFvis2Ri5Ajq3PNxS0DxzNrtsqKGeUMuFFrNhcZ7DeHpHG7MPDAJCQFwvzebuVP+hraMMuKzvqEVSr1QA0hn3FV1mBQc0K2OiGgibkgB5nHeZVbglFcI8SLoNHFNLiya+CKGtV/DYTvXQWZt8S0nFvQA0v8NPwnr1iFGxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRO7P6XL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730479074; x=1762015074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7oORcEtGj/iiaA43PSLCnPafGuurwysB9AtbJETIaw=;
  b=nRO7P6XLnlSo7txLwHAQe771UBHTdZtwPNCJbr5LR0soS0JpRjRr5Ui9
   yj6lrPsWqq/XAQUxjS/s2BPHaN44yWxP3VnITGdd8CWEJXkyWbEwP1YfG
   AH2Y8C2MltLrktYZnZg++C33UBWewBvJhnOI7tfbusZy7sBMBsDjb+k6i
   tCIUQreNATJ3wvOWuhEz0lb4tlErW9gAg3t3ZX1nSwK3pgZ68jxJk4CPw
   tkKN438B5uc16BE3RxbTtbRz0tTvRJ476nkGhq/wrEDv4XUqsiOO40GPs
   koR+i2AVkZRS7DTPGcrN48y/xUY4nkCN/AWDrUE8lwemiQA3DHAOYItJo
   g==;
X-CSE-ConnectionGUID: 6cWyVbQgQmSSWQ685aEY5g==
X-CSE-MsgGUID: jH/IwG94Qv2OZy3C7qEeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30205785"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30205785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:37:54 -0700
X-CSE-ConnectionGUID: 4puZEzRERSmf4D4rpDD9Mw==
X-CSE-MsgGUID: cqmxMK7EQO23CzQ3GCm8vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82891481"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Nov 2024 09:37:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6uef-000hlh-1v;
	Fri, 01 Nov 2024 16:37:45 +0000
Date: Sat, 2 Nov 2024 00:37:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	David Arinzon <darinzon@amazon.com>,
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
Message-ID: <202411020050.npvLNJ7N-lkp@intel.com>
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
config: arm64-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020050.npvLNJ7N-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020050.npvLNJ7N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020050.npvLNJ7N-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/amazon/ena/ena_com.c: In function 'ena_com_phc_config':
>> drivers/net/ethernet/amazon/ena/ena_com.c:1702:49: error: expected ')' before 'ENA_ADMIN_PHC_CONFIG'
    1702 |                                   &get_feat_resp
         |                                                 ^
         |                                                 )
    1703 |                                   ENA_ADMIN_PHC_CONFIG,
         |                                   ~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/amazon/ena/ena_com.c:1701:34: note: to match this '('
    1701 |         ret = ena_com_get_feature(ena_dev,
         |                                  ^
>> drivers/net/ethernet/amazon/ena/ena_com.c:1701:15: error: too few arguments to function 'ena_com_get_feature'
    1701 |         ret = ena_com_get_feature(ena_dev,
         |               ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/amazon/ena/ena_com.c:1037:12: note: declared here
    1037 | static int ena_com_get_feature(struct ena_com_dev *ena_dev,
         |            ^~~~~~~~~~~~~~~~~~~


vim +1702 drivers/net/ethernet/amazon/ena/ena_com.c

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
> 1701		ret = ena_com_get_feature(ena_dev,
> 1702					  &get_feat_resp
  1703					  ENA_ADMIN_PHC_CONFIG,
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

