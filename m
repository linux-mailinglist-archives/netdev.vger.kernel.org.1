Return-Path: <netdev+bounces-207022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305AB054AA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5514A493B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03792750F1;
	Tue, 15 Jul 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cp7TDbXy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2B2749CF
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567640; cv=none; b=mEQBLj8zhTTUvxCEIXg75rQU2IgLfz/0bBwoBSNH15sU9LfL46W3EQktUHFYVUtK1W/p6bsP0I0dWToF4/6yVWqio3bLvZfm8PSSfvqXvDJb2wDQUojDFF6W8TC9PwdrEu4yXn8cQ/5TW/oYDCBqfQ8twrmTdqVm/3KNQ2BqRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567640; c=relaxed/simple;
	bh=uof8zg9bOsut9HtWSzkZbkOmWYz0QWIMSB/79kCYUeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeqaLKRAZqfgb3GDmtNOUZC3izeWqDALHWeJf6wVo30L6vxY4rcQr4nR467hTo2a0GWaAQz23C/GrzRvpTleDunmJCsH8AjKB6kR3Mtm+J9s8WWc0wnDakC9uOODDEU0Gd/uhNFU5ovz35fHJl+KzejWUbbcNY1F3xCliKQdAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cp7TDbXy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752567639; x=1784103639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uof8zg9bOsut9HtWSzkZbkOmWYz0QWIMSB/79kCYUeY=;
  b=Cp7TDbXy5bC19+bMLQKH4w+iP6YZLAHrcakGQlpFAf9469epQNBnNZOe
   LZS3hb+ocCkSjGwlRvBsl3fvyMslmxNoMQ6xQxtcS7JZLk4YLk5Eit6fZ
   HYqOMPwFmHG6Z47dvd3Bt3AwPXs4Wlft9kcuM2Uvrgao42pTJQ74te+p4
   9AOqhQ6s5dDy8S0ii/fwo4i+kwOmpMCzw/ddBz9I7IMWv3DbfD3ORGUgL
   AzA4pCD6QjSbzmN+15Wy60MEjsKKZF8ZcNeSM67qoTuZWXJW1CglYs7wp
   ci/0PfOZDq+kUaqrQKW2PFegoDEPEJVf02vOVYJjmfS2LxEpGmj1PZh/Z
   w==;
X-CSE-ConnectionGUID: dZHjsdXcQcGkiqwNS33KpQ==
X-CSE-MsgGUID: 51oVjlMKTNWz7OeFe1qfXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77314717"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="77314717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:20:38 -0700
X-CSE-ConnectionGUID: Ez6S255mQqu5RBz7l9VprA==
X-CSE-MsgGUID: KiRzjuaESsuC6DLTZkp7xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157697370"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jul 2025 01:20:35 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubatt-0009qt-0y;
	Tue, 15 Jul 2025 08:20:33 +0000
Date: Tue, 15 Jul 2025 16:19:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hramamurthy@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	willemb@google.com, pabeni@redhat.com,
	Joshua Washington <joshwash@google.com>,
	Jeroen de Borst <jeroendb@google.com>
Subject: Re: [PATCH net-next 2/5] gve: merge xdp and xsk registration
Message-ID: <202507151501.qOw1iRWI-lkp@intel.com>
References: <20250714160451.124671-3-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714160451.124671-3-jeroendb@google.com>

Hi Jeroen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeroen-de-Borst/gve-deduplicate-xdp-info-and-xsk-pool-registration-logic/20250715-001243
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250714160451.124671-3-jeroendb%40google.com
patch subject: [PATCH net-next 2/5] gve: merge xdp and xsk registration
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250715/202507151501.qOw1iRWI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507151501.qOw1iRWI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507151501.qOw1iRWI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/google/gve/gve_main.c: In function 'gve_reg_xsk_pool':
>> drivers/net/ethernet/google/gve/gve_main.c:1181:29: warning: variable 'napi' set but not used [-Wunused-but-set-variable]
    1181 |         struct napi_struct *napi;
         |                             ^~~~


vim +/napi +1181 drivers/net/ethernet/google/gve/gve_main.c

013df4b1b64282 Joshua Washington 2025-07-14  1177  
013df4b1b64282 Joshua Washington 2025-07-14  1178  static int gve_reg_xsk_pool(struct gve_priv *priv, struct net_device *dev,
013df4b1b64282 Joshua Washington 2025-07-14  1179  			    struct xsk_buff_pool *pool, u16 qid)
013df4b1b64282 Joshua Washington 2025-07-14  1180  {
013df4b1b64282 Joshua Washington 2025-07-14 @1181  	struct napi_struct *napi;
013df4b1b64282 Joshua Washington 2025-07-14  1182  	struct gve_rx_ring *rx;
013df4b1b64282 Joshua Washington 2025-07-14  1183  	u16 tx_qid;
013df4b1b64282 Joshua Washington 2025-07-14  1184  	int err;
013df4b1b64282 Joshua Washington 2025-07-14  1185  
013df4b1b64282 Joshua Washington 2025-07-14  1186  	rx = &priv->rx[qid];
013df4b1b64282 Joshua Washington 2025-07-14  1187  	napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
5f1e1cdb9ff911 Joshua Washington 2025-07-14  1188  	err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
013df4b1b64282 Joshua Washington 2025-07-14  1189  					 MEM_TYPE_XSK_BUFF_POOL, pool);
013df4b1b64282 Joshua Washington 2025-07-14  1190  	if (err) {
013df4b1b64282 Joshua Washington 2025-07-14  1191  		gve_unreg_xsk_pool(priv, qid);
013df4b1b64282 Joshua Washington 2025-07-14  1192  		return err;
013df4b1b64282 Joshua Washington 2025-07-14  1193  	}
013df4b1b64282 Joshua Washington 2025-07-14  1194  
013df4b1b64282 Joshua Washington 2025-07-14  1195  	rx->xsk_pool = pool;
013df4b1b64282 Joshua Washington 2025-07-14  1196  
013df4b1b64282 Joshua Washington 2025-07-14  1197  	tx_qid = gve_xdp_tx_queue_id(priv, qid);
013df4b1b64282 Joshua Washington 2025-07-14  1198  	priv->tx[tx_qid].xsk_pool = pool;
013df4b1b64282 Joshua Washington 2025-07-14  1199  
013df4b1b64282 Joshua Washington 2025-07-14  1200  	return 0;
013df4b1b64282 Joshua Washington 2025-07-14  1201  }
013df4b1b64282 Joshua Washington 2025-07-14  1202  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

