Return-Path: <netdev+bounces-42495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E57CEEED
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB38FB20E77
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E064667B;
	Thu, 19 Oct 2023 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcTZyYdn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6517C8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:18:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F266DA4
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697692733; x=1729228733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tfSi/T4VJvhJ/85obP0QG0Ut4JUkF78KROB9ye20UM=;
  b=dcTZyYdnGsTdKh4Tw+edZTb2zcJo8aoC4rYGr2Upj1ZBqA5Aof3kqYXz
   Evhdbj8AOsP3RhgLTRIqdqieILhOvdA+mkx5RXmvEcM5R3SH8FmEVIhqG
   syBUUtb+OJHGpp0ivK0E42iqK8yDtmEqrCtQeIa1sDxWiAxTP5l1Ob83t
   0MA4W04SI+9780Q/6SLODEvX6tYeK4XAsCTKEJcPYLu22dF3dmQAFhYf7
   jYSVZFupoOo6JEQ59AS8TjMXCQoNgbDKJtbOXYHI7LCK4XZPxfIHu/ZNo
   MPyjYeCtkxQQG/xyPQzSPxpgvQ8V8E2tfzcfLcx/Wc3raxjgviT9vnQUl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450396005"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="450396005"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004095964"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1004095964"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 22:18:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qtLQn-0001fe-1L;
	Thu, 19 Oct 2023 05:18:49 +0000
Date: Thu, 19 Oct 2023 13:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: Re: [net-next PATCH v5 03/10] ice: Add support in the driver for
 associating queue with napi
Message-ID: <202310191339.JfORBqdK-lkp@intel.com>
References: <169767397753.6692.15797121214738496388.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169767397753.6692.15797121214738496388.stgit@anambiarhost.jf.intel.com>

Hi Amritha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Amritha-Nambiar/netdev-genl-spec-Extend-netdev-netlink-spec-in-YAML-for-queue/20231019-082941
base:   net-next/main
patch link:    https://lore.kernel.org/r/169767397753.6692.15797121214738496388.stgit%40anambiarhost.jf.intel.com
patch subject: [net-next PATCH v5 03/10] ice: Add support in the driver for associating queue with napi
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310191339.JfORBqdK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191339.JfORBqdK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191339.JfORBqdK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_lib.c:2943:6: warning: no previous prototype for 'ice_queue_set_napi' [-Wmissing-prototypes]
    2943 | void ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
         |      ^~~~~~~~~~~~~~~~~~


vim +/ice_queue_set_napi +2943 drivers/net/ethernet/intel/ice/ice_lib.c

  2933	
  2934	/**
  2935	 * ice_queue_set_napi - Set the napi instance for the queue
  2936	 * @queue_index: Index of queue
  2937	 * @type: queue type as RX or TX
  2938	 * @napi: NAPI context
  2939	 * @locked: is the rtnl_lock already held
  2940	 *
  2941	 * Set the napi instance for the queue
  2942	 */
> 2943	void ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
  2944				struct napi_struct *napi, bool locked)
  2945	{
  2946		if (locked)
  2947			__netif_queue_set_napi(queue_index, type, napi);
  2948		else
  2949			netif_queue_set_napi(queue_index, type, napi);
  2950	}
  2951	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

