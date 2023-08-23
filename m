Return-Path: <netdev+bounces-30024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E3785A69
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E879C1C20C7A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25C6C2CC;
	Wed, 23 Aug 2023 14:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6DC152
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:25:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27CE68
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692800737; x=1724336737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8M71VJrSbLzKBZg9sAwgwdKtrVieXpAwftdg1mgIcQ=;
  b=DvtyJBOiQZLWt6ewTbGbFHD/9p8vb/egdlOOOK6ucsCyBDg7jMaDnFS8
   NaH9i27rXFrS57JT3Imv7HsbxTKLwxvAAMwyoSxF7IDAC0agLqBGGOoYM
   W3ptvveiLazZwOz5OKcfDWhaLriHqkqODuC2zch0N28S3L2LZabGrihDk
   6EUmEQOdVlPAfKBbWfjFZR6hmDF0RJ7VxqntAYcjxtBGI/JrOtyWs/f/1
   lqfPVBM2O2QNQb2O8uXlxld94kenlVvP7LVfuoSLb5wVBFxZb+D+YkRr5
   f6/kpUQMe1ykjBeLXeWkUp9/HVxm51cu3WKovQvOQtTwFHJPKejCjvxnI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="377931642"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="377931642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="730227755"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730227755"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2023 07:25:34 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYond-0001H0-1q;
	Wed, 23 Aug 2023 14:25:33 +0000
Date: Wed, 23 Aug 2023 22:25:24 +0800
From: kernel test robot <lkp@intel.com>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH net-next 5/6] sfc: introduce pedit add actions on the
 ipv4 ttl field
Message-ID: <202308232244.jYYwKnlV-lkp@intel.com>
References: <20230823111725.28090-6-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823111725.28090-6-pieter.jansen-van-vuuren@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pieter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pieter-Jansen-van-Vuuren/sfc-introduce-ethernet-pedit-set-action-infrastructure/20230823-192051
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230823111725.28090-6-pieter.jansen-van-vuuren%40amd.com
patch subject: [PATCH net-next 5/6] sfc: introduce pedit add actions on the ipv4 ttl field
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308232244.jYYwKnlV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232244.jYYwKnlV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232244.jYYwKnlV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/tc.c:1073: warning: expecting prototype for efx_tc_mangle(). Prototype was for efx_tc_pedit_add() instead


vim +1073 drivers/net/ethernet/sfc/tc.c

  1056	
  1057	/**
  1058	 * efx_tc_mangle() - handle a single 32-bit (or less) pedit
  1059	 * @efx: NIC we're installing a flow rule on
  1060	 * @act: action set (cursor) to update
  1061	 * @fa:          FLOW_ACTION_MANGLE action metadata
  1062	 * @mung:        accumulator for partial mangles
  1063	 * @extack:      netlink extended ack for reporting errors
  1064	 *
  1065	 * Identify the fields written by a FLOW_ACTION_MANGLE, and record
  1066	 * the partial mangle state in @mung.  If this mangle completes an
  1067	 * earlier partial mangle, consume and apply to @act by calling
  1068	 * efx_tc_complete_mac_mangle().
  1069	 */
  1070	static int efx_tc_pedit_add(struct efx_nic *efx, struct efx_tc_action_set *act,
  1071				    const struct flow_action_entry *fa,
  1072				    struct netlink_ext_ack *extack)
> 1073	{
  1074		switch (fa->mangle.htype) {
  1075		case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
  1076			switch (fa->mangle.offset) {
  1077			case offsetof(struct iphdr, ttl):
  1078				/* check that pedit applies to ttl only */
  1079				if (fa->mangle.mask != ~EFX_TC_HDR_TYPE_TTL_MASK)
  1080					break;
  1081	
  1082				/* Adding 0xff is equivalent to decrementing the ttl.
  1083				 * Other added values are not supported.
  1084				 */
  1085				if ((fa->mangle.val & EFX_TC_HDR_TYPE_TTL_MASK) != U8_MAX)
  1086					break;
  1087	
  1088				/* check that we do not decrement ttl twice */
  1089				if (!efx_tc_flower_action_order_ok(act,
  1090								   EFX_TC_AO_DEC_TTL)) {
  1091					NL_SET_ERR_MSG_MOD(extack, "Unsupported: multiple dec ttl");
  1092					return -EOPNOTSUPP;
  1093				}
  1094				act->do_ttl_dec = 1;
  1095				return 0;
  1096			default:
  1097				break;
  1098			}
  1099			break;
  1100		default:
  1101			break;
  1102		}
  1103	
  1104		NL_SET_ERR_MSG_FMT_MOD(extack,
  1105				       "Unsupported: ttl add action type %x %x %x/%x",
  1106				       fa->mangle.htype, fa->mangle.offset,
  1107				       fa->mangle.val, fa->mangle.mask);
  1108		return -EOPNOTSUPP;
  1109	}
  1110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

