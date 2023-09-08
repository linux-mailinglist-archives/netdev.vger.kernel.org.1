Return-Path: <netdev+bounces-32537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F2798346
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDA01C20A34
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC15187A;
	Fri,  8 Sep 2023 07:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A51867
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 07:33:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648431BEA
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694158383; x=1725694383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Etmp+CTx9TVZadnjzpwQCuEhPOcR9fs7Az2JkylUmr0=;
  b=R2rLKElJj3XKpQiA/Ki3U2a1F1vz6szWfjPb8XaYZJFKlVzpTDc4FEJr
   XGX3RMKfgUucThcRPAttawgqh/GpWd+ZNhepyJW3YRTcc/EutWr5nkd57
   hDcnLbXnwPJgtxKFJssPr/3Gjp9+GNz6EEGdK6SbRKuWmLlMG7igBN7aK
   s1IRoObWhG2mzTj9wXhLS/MgDTRETJWK4dULhSVhTo/rCj/4+/rBv41Sj
   MZyfjJW4RqDebJbNbOpIZGkQeTKZLSwoOQ/WK3vth1e22F3GLGYOovSTC
   Txzg0wcM2+disyRnrZR8bota6HJvcW+Bi8sI01OYEf/KYpAhPLNeArKyP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="374966057"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="374966057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 00:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="745531353"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="745531353"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Sep 2023 00:32:55 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qeVz1-00021X-30;
	Fri, 08 Sep 2023 07:32:51 +0000
Date: Fri, 8 Sep 2023 15:32:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc: oe-kbuild-all@lists.linux.dev, ruanjinjie@huawei.com
Subject: Re: [PATCH net 4/5] net: microchip: sparx5: Fix possible memory
 leaks in test_vcap_xn_rule_creator()
Message-ID: <202309081527.MUW3tfqy-lkp@intel.com>
References: <20230908040011.2620468-5-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908040011.2620468-5-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/net-microchip-sparx5-Fix-memory-leak-for-vcap_api_rule_add_keyvalue_test/20230908-120533
base:   net/main
patch link:    https://lore.kernel.org/r/20230908040011.2620468-5-ruanjinjie%40huawei.com
patch subject: [PATCH net 4/5] net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230908/202309081527.MUW3tfqy-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309081527.MUW3tfqy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309081527.MUW3tfqy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:3584:
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:246:6: warning: no previous prototype for 'test_vcap_xn_rule_creator' [-Wmissing-prototypes]
     246 | void test_vcap_xn_rule_creator(struct kunit *test, int cid, enum vcap_user user,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/test_vcap_xn_rule_creator +246 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c

   244	
   245	/* Helper function to create a rule of a specific size */
 > 246	void test_vcap_xn_rule_creator(struct kunit *test, int cid, enum vcap_user user,
   247				       u16 priority,
   248				       int id, int size, int expected_addr)
   249	{
   250		struct vcap_rule *rule;
   251		struct vcap_rule_internal *ri;
   252		enum vcap_keyfield_set keyset = VCAP_KFS_NO_VALUE;
   253		enum vcap_actionfield_set actionset = VCAP_AFS_NO_VALUE;
   254		int ret;
   255	
   256		/* init before testing */
   257		memset(test_updateaddr, 0, sizeof(test_updateaddr));
   258		test_updateaddridx = 0;
   259		test_move_addr = 0;
   260		test_move_offset = 0;
   261		test_move_count = 0;
   262	
   263		switch (size) {
   264		case 2:
   265			keyset = VCAP_KFS_ETAG;
   266			actionset = VCAP_AFS_CLASS_REDUCED;
   267			break;
   268		case 3:
   269			keyset = VCAP_KFS_PURE_5TUPLE_IP4;
   270			actionset = VCAP_AFS_CLASSIFICATION;
   271			break;
   272		case 6:
   273			keyset = VCAP_KFS_NORMAL_5TUPLE_IP4;
   274			actionset = VCAP_AFS_CLASSIFICATION;
   275			break;
   276		case 12:
   277			keyset = VCAP_KFS_NORMAL_7TUPLE;
   278			actionset = VCAP_AFS_FULL;
   279			break;
   280		default:
   281			break;
   282		}
   283	
   284		/* Check that a valid size was used */
   285		KUNIT_ASSERT_NE(test, VCAP_KFS_NO_VALUE, keyset);
   286	
   287		/* Allocate the rule */
   288		rule = vcap_alloc_rule(&test_vctrl, &test_netdev, cid, user, priority,
   289				       id);
   290		KUNIT_EXPECT_PTR_NE(test, NULL, rule);
   291	
   292		ri = (struct vcap_rule_internal *)rule;
   293	
   294		/* Override rule keyset */
   295		ret = vcap_set_rule_set_keyset(rule, keyset);
   296	
   297		/* Add rule actions : there must be at least one action */
   298		ret = vcap_rule_add_action_u32(rule, VCAP_AF_ISDX_VAL, 0);
   299	
   300		/* Override rule actionset */
   301		ret = vcap_set_rule_set_actionset(rule, actionset);
   302	
   303		ret = vcap_val_rule(rule, ETH_P_ALL);
   304		KUNIT_EXPECT_EQ(test, 0, ret);
   305		KUNIT_EXPECT_EQ(test, keyset, rule->keyset);
   306		KUNIT_EXPECT_EQ(test, actionset, rule->actionset);
   307		KUNIT_EXPECT_EQ(test, size, ri->size);
   308	
   309		/* Add rule with write callback */
   310		ret = vcap_add_rule(rule);
   311		KUNIT_EXPECT_EQ(test, 0, ret);
   312		KUNIT_EXPECT_EQ(test, expected_addr, ri->addr);
   313		vcap_free_rule(rule);
   314	}
   315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

