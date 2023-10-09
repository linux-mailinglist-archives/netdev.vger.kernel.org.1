Return-Path: <netdev+bounces-38951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914D7BD27A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 06:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07924281446
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 04:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791E8F77;
	Mon,  9 Oct 2023 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVW0u9W3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5E2F39
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 04:02:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D2A3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696824158; x=1728360158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DVJYAAVrUFElS08ip355YEmMBb7NLcoYt75fK/Nr8oI=;
  b=gVW0u9W3cKsN+rSXD+59qdMjuWBY2wLbOVihFz7Xo9tZxde4ZcY5Dano
   HDO0UcAovw6DvDt2lGQZotEp9T6/n9GS5N+oMwLaSAd5ErGtKGVxEnN6r
   Bd6hCBhKb7zhwvD0jfTBxQbrYm+hEH/evy98tZMeXUSeQrYK54Ch7jYnJ
   leDcO2E6D7lvtDi36tFdjUuIoet7PpFzKech3abl19sn7Ow/hgUAKbE05
   QOfQ4cRDn1Gn4FZ8ZdC1CWMJeMhgZTBukhqn5HTb5gssDBygdghVS9aCK
   4UbIZdOWb11L4+VvInOC3zYX+yxk3lcKM1HnnyKBf9wO1ClJfu9eHmzHE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="415054679"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="415054679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 21:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="729525843"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="729525843"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2023 21:02:34 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qphTU-00061B-1d;
	Mon, 09 Oct 2023 04:02:32 +0000
Date: Mon, 9 Oct 2023 12:01:33 +0800
From: kernel test robot <lkp@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, alexander.duyck@gmail.com,
	fw@strlen.de, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 1/3] net: add skb_segment kunit test
Message-ID: <202310091154.3StA08FY-lkp@intel.com>
References: <20231008201244.3700784-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008201244.3700784-2-willemdebruijn.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Willem,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-de-Bruijn/net-add-skb_segment-kunit-test/20231009-041424
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231008201244.3700784-2-willemdebruijn.kernel%40gmail.com
patch subject: [PATCH net-next v2 1/3] net: add skb_segment kunit test
config: i386-randconfig-001-20231009 (https://download.01.org/0day-ci/archive/20231009/202310091154.3StA08FY-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310091154.3StA08FY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310091154.3StA08FY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/gso_test.c:10:32: error: initializer element is not constant
    static const int payload_len = (2 * gso_size) + last_seg_size;
                                   ^


vim +10 net/core/gso_test.c

     8	
     9	/* default: create 3 segment gso packet */
  > 10	static const int payload_len = (2 * gso_size) + last_seg_size;
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

