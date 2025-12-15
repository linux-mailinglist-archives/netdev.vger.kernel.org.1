Return-Path: <netdev+bounces-244832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A4CBF7B9
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4302B300D64D
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A73318140;
	Mon, 15 Dec 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niOxzK0R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140D30C611;
	Mon, 15 Dec 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825690; cv=none; b=kVNMXdxBy3rTJ13DYMeUc+YJlumxCigkgSm5hS7DaLNXJemN4smJfUeJBA5C0dNmC+DK2hI4lQzipn5OFkWWyS4GIQ7PSlO6V92RYwfetcq0F7k4irmYfUBT/82JXS6qLH90Ecy/Gg0sg7THIIOD+tclFJ/gp8dcYkTliKiKAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825690; c=relaxed/simple;
	bh=1JDNfp0Z5+nrp/ObFicZ4XwSPUDiATXg/OEvzD6472Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqAB2QuQ3E2AQEL80cE4JeqPJ3oPedByGHoS+cRoK3mXj4FicUB3J7I9UwIND/1YqZHhKO2v62FdYzm66p35i6HlwbH3f2M9Xk5Cl4gQqFfi7PVDe4SCRiJwrjryYFpTD1/ev2FhjtdxgHHw8JzLVGXofeROvtRx3WIAMfHfaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niOxzK0R; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765825688; x=1797361688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1JDNfp0Z5+nrp/ObFicZ4XwSPUDiATXg/OEvzD6472Y=;
  b=niOxzK0RP93PZsK6PXFG3PlJ/6GKpWNen7BHVVWDrRnO7P3o6Pg2OTbO
   ja57CNDs9pGh4peFUT6HdhIFm/O9LuekdxK3VjN5Bqx5Geavq1I21KPSG
   ff/av+FgeE8A2d4zQU91BNzjNRnx9X8Dl/AjXvHH4X4ZtGvwnbYDceN8o
   FAlGNXrcxkUdJAwJepNWMvbo0Bt0RhW3lCakTKIkD8mMFKisQN+B0X2a8
   DTzK8NeBAIFN8mn734RCFD/D9N3bMp6np+L8mU2K1eBvHixFZjt4DFj7t
   UsZvpxnbMZiDX4lzibdeGxlwwC2OC9CkRPEw6R+0FiAHhUKw59ZPYLbzi
   A==;
X-CSE-ConnectionGUID: 87tCdgv8SWeCSu574WabmA==
X-CSE-MsgGUID: upy9i0b1R0ClmxtjJJDM9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66921503"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="66921503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 11:08:07 -0800
X-CSE-ConnectionGUID: mM3qZZf/QHyrBDdX5VBDKw==
X-CSE-MsgGUID: zlwDi811Sa2s2GleHZKjPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="198626807"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 15 Dec 2025 11:08:01 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVDvL-000000002kO-0LU9;
	Mon, 15 Dec 2025 19:07:59 +0000
Date: Mon, 15 Dec 2025 20:07:47 +0100
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm, netmem: remove the page pool members in struct
 page
Message-ID: <202512152043.rdzLcS1a-lkp@intel.com>
References: <20251215071001.78263-3-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215071001.78263-3-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on d0a24447990a9d8212bfb3a692d59efa74ce9f86]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/mm-introduce-a-new-page-type-for-page-pool-in-page-type/20251215-151232
base:   d0a24447990a9d8212bfb3a692d59efa74ce9f86
patch link:    https://lore.kernel.org/r/20251215071001.78263-3-byungchul%40sk.com
patch subject: [PATCH 2/2] mm, netmem: remove the page pool members in struct page
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251215/202512152043.rdzLcS1a-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251215/202512152043.rdzLcS1a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512152043.rdzLcS1a-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ethtool.c: In function 'ice_lbtest_receive_frames':
>> drivers/net/ethernet/intel/ice/ice_ethtool.c:1254:36: error: 'struct page' has no member named 'pp'
    1254 |                                page->pp->p.offset;
         |                                    ^~


vim +1254 drivers/net/ethernet/intel/ice/ice_ethtool.c

0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1223  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1224  #define ICE_LB_FRAME_SIZE 64
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1225  /**
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1226   * ice_lbtest_receive_frames - receive and verify test frames
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1227   * @rx_ring: pointer to the receive ring
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1228   *
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1229   * Function receives loopback packets and verify their correctness.
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1230   * Returns number of received valid frames.
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1231   */
e72bba21355dbb Maciej Fijalkowski     2021-08-19  1232  static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1233  {
93f53db9f9dc4a Michal Kubiak          2025-09-25  1234  	struct libeth_fqe *rx_buf;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1235  	int valid_frames, i;
93f53db9f9dc4a Michal Kubiak          2025-09-25  1236  	struct page *page;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1237  	u8 *received_buf;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1238  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1239  	valid_frames = 0;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1240  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1241  	for (i = 0; i < rx_ring->count; i++) {
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1242  		union ice_32b_rx_flex_desc *rx_desc;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1243  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1244  		rx_desc = ICE_RX_DESC(rx_ring, i);
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1245  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1246  		if (!(rx_desc->wb.status_error0 &
283d736ff7c7e9 Maciej Fijalkowski     2022-07-07  1247  		    (cpu_to_le16(BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S)) |
283d736ff7c7e9 Maciej Fijalkowski     2022-07-07  1248  		     cpu_to_le16(BIT(ICE_RX_FLEX_DESC_STATUS0_EOF_S)))))
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1249  			continue;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1250  
93f53db9f9dc4a Michal Kubiak          2025-09-25  1251  		rx_buf = &rx_ring->rx_fqes[i];
93f53db9f9dc4a Michal Kubiak          2025-09-25  1252  		page = __netmem_to_page(rx_buf->netmem);
93f53db9f9dc4a Michal Kubiak          2025-09-25  1253  		received_buf = page_address(page) + rx_buf->offset +
93f53db9f9dc4a Michal Kubiak          2025-09-25 @1254  			       page->pp->p.offset;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1255  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1256  		if (ice_lbtest_check_frame(received_buf))
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1257  			valid_frames++;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1258  	}
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1259  
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1260  	return valid_frames;
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1261  }
0e674aeb0b7790 Anirudh Venkataramanan 2019-04-16  1262  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

