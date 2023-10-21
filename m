Return-Path: <netdev+bounces-43255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72737D1E1F
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165FB1C20953
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2612B7C;
	Sat, 21 Oct 2023 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcgoCBBJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46641107A0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 16:05:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535351BF
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697904315; x=1729440315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XIgsp7wdLjE6ch2OzIGi0HF/Vl+KNyDTETpL2hHqCHM=;
  b=GcgoCBBJL4vzx8+sESNomHgAqgXFIma0lCGWwBW1/53bHX2fkmFWPTlN
   VIrq8+B0TURiG8rsTarE90tN+JkJqmANErmNiJU0uLNlX1i8Gjg1hk6jk
   8/1hShD6ynB6rJHlwn7JmPUYXC6ij/GEduvaPt2EfJkB8o8OkUXhjhesr
   ol38t364tb/vzY5LRBVNT7mv7mAl9m2q3n7URXioudfSF70NQXQvpCGRs
   wdiIuw12tV+DiwJXOiIHt3X4HPK8VA84VZO05bJnaSwUks+BHPsAFuUNX
   GzkIG8EjTPwgzmImLI31ohrLU9qHD/mXyRHY8eWyrd5ptFS+mbaDQTEDX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="365983059"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="365983059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 09:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="931284783"
X-IronPort-AV: E=Sophos;i="6.03,241,1694761200"; 
   d="scan'208";a="931284783"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Oct 2023 09:05:13 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quETP-0004ze-1G;
	Sat, 21 Oct 2023 16:05:11 +0000
Date: Sun, 22 Oct 2023 00:04:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [patch net-next v3 08/10] netlink: specs: devlink: add the
 remaining command to generate complete split_ops
Message-ID: <202310212326.u0Z0O9Hx-lkp@intel.com>
References: <20231021112711.660606-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021112711.660606-9-jiri@resnulli.us>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Pirko/genetlink-don-t-merge-dumpit-split-op-for-different-cmds-into-single-iter/20231021-192916
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231021112711.660606-9-jiri%40resnulli.us
patch subject: [patch net-next v3 08/10] netlink: specs: devlink: add the remaining command to generate complete split_ops
reproduce: (https://download.01.org/0day-ci/archive/20231021/202310212326.u0Z0O9Hx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310212326.u0Z0O9Hx-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4155: FILE: tools/net/ynl/generated/devlink-user.c:1244:
+		if (type == DEVLINK_ATTR_RELOAD_STATS_ENTRY) {
+			n_reload_stats_entry++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4222: FILE: tools/net/ynl/generated/devlink-user.c:1311:
+		if (type == DEVLINK_ATTR_DPIPE_MATCH) {
+			n_dpipe_match++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4272: FILE: tools/net/ynl/generated/devlink-user.c:1361:
+		if (type == DEVLINK_ATTR_DPIPE_ACTION) {
+			n_dpipe_action++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4322: FILE: tools/net/ynl/generated/devlink-user.c:1411:
+		if (type == DEVLINK_ATTR_DPIPE_MATCH_VALUE) {
+			n_dpipe_match_value++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4372: FILE: tools/net/ynl/generated/devlink-user.c:1461:
+		if (type == DEVLINK_ATTR_DPIPE_ACTION_VALUE) {
+			n_dpipe_action_value++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4422: FILE: tools/net/ynl/generated/devlink-user.c:1511:
+		if (type == DEVLINK_ATTR_DPIPE_FIELD) {
+			n_dpipe_field++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4471: FILE: tools/net/ynl/generated/devlink-user.c:1560:
+		if (type == DEVLINK_ATTR_RESOURCE) {
+			n_resource++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4754: FILE: tools/net/ynl/generated/devlink-user.c:1843:
+		if (type == DEVLINK_ATTR_RELOAD_ACTION_INFO) {
+			n_reload_action_info++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4803: FILE: tools/net/ynl/generated/devlink-user.c:1892:
+		if (type == DEVLINK_ATTR_DPIPE_TABLE) {
+			n_dpipe_table++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4852: FILE: tools/net/ynl/generated/devlink-user.c:1941:
+		if (type == DEVLINK_ATTR_DPIPE_ENTRY) {
+			n_dpipe_entry++;
+		}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#4901: FILE: tools/net/ynl/generated/devlink-user.c:1990:
+		if (type == DEVLINK_ATTR_DPIPE_HEADER) {
+			n_dpipe_header++;
+		}

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#9828: FILE: tools/net/ynl/generated/devlink-user.h:999:
+	struct devlink_sb_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#9991: FILE: tools/net/ynl/generated/devlink-user.h:1129:
+	struct devlink_sb_pool_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#10218: FILE: tools/net/ynl/generated/devlink-user.h:1356:
+	struct devlink_sb_port_pool_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#10458: FILE: tools/net/ynl/generated/devlink-user.h:1596:
+	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#11435: FILE: tools/net/ynl/generated/devlink-user.h:2573:
+	struct devlink_param_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#11641: FILE: tools/net/ynl/generated/devlink-user.h:2779:
+	struct devlink_region_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#11928: FILE: tools/net/ynl/generated/devlink-user.h:3066:
+	struct devlink_region_read_rsp_dump obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#12011: FILE: tools/net/ynl/generated/devlink-user.h:3149:
+	struct devlink_port_param_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#12144: FILE: tools/net/ynl/generated/devlink-user.h:3282:
+	struct devlink_info_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#12294: FILE: tools/net/ynl/generated/devlink-user.h:3426:
+	struct devlink_health_reporter_get_rsp obj __attribute__ ((aligned (8)));

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#12719: FILE: tools/net/ynl/generated/devlink-user.h:3739:
+	struct devlink_health_reporter_dump_get_rsp_dump obj __attribute__ ((aligned (8)));

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

