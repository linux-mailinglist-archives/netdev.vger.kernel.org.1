Return-Path: <netdev+bounces-183128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AFA8AF49
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEC13BF786
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB622FAD3;
	Wed, 16 Apr 2025 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNSDeQp5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D322A4E4;
	Wed, 16 Apr 2025 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778656; cv=none; b=IEJKCLmBtZ3AJRHDp5WKdLJnFG357ofs9KQgZTTEy7N9iKaq8RQx8iJegK1jEqJSH994NNg2TE//zDUNP3jJXhTDK0zx0LWH9YwWq+/KZGP8knYARv6amwPq2MDK0gZaTAP32UlKfkh2B5qL7iusz0ds+omLGeWxBnfxQ+XFRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778656; c=relaxed/simple;
	bh=rjVokRe+EkFmCr20yzifNHs8HzweMFkRx0cDcllxlxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+K3OrwSoACclVZ/iQ3RtHxTtvshvvveZFVI0E+flsMmFCIqh9iT/08Qg2E2VFJ5vkdIbx3kfSLt7ewb2PVJZ7iS5NtX9UMg8GJ/UlkPXAf3+rxDVRqdh519fCipMlc1xh/Sl5ZZXWGmgdVn9hlvS9R0DBnJryRFm4FqCDOadiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNSDeQp5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744778649; x=1776314649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjVokRe+EkFmCr20yzifNHs8HzweMFkRx0cDcllxlxI=;
  b=CNSDeQp5xDUOQ2McqSOuEZ3rMpX/xzHaaINj3UCRetzaFytXeYVlDuPs
   FP8Y4U9c3Txta/jRz8+lQmvTpiu6++M9I8BVGTyR+KYPC9Y5yJjoFuaXQ
   upP+NNwBqjt8la5k5v3hYS7g94SgBLiS/6MoQkHd7j1SekKbbmOGgmJAg
   8GCsMcjDp+sbwaZ36s0TB3hSMx2ZLfLU/9jSgPxiUuRI32GWHjTVWEhOX
   MB2CSlxRfyx1dMicRu4j7uhCv5ytssMIT1srxK3JMPglpHTlEz2EISHZd
   rbyyRZ4rv5DFYVXermI1eQRtur5eAEXzzCIBT/tqveBmDJTDCuVaAfAte
   A==;
X-CSE-ConnectionGUID: +bRayGHBQX+p8YduL4AitA==
X-CSE-MsgGUID: UhbrvY1pQ8W5ZJL2IL2Ksg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45445473"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="45445473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 21:44:07 -0700
X-CSE-ConnectionGUID: xX/cq0xHSu+tm7D4S3iOdA==
X-CSE-MsgGUID: XFPuRhmRTzCpQT6bydmmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="134426648"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2025 21:44:02 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4jwt-000Gmi-2x;
	Tue, 15 Apr 2025 17:19:51 +0000
Date: Wed, 16 Apr 2025 01:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 13/22] cxl: define a driver interface for DPA
 allocation
Message-ID: <202504160058.DWk5ApNJ-lkp@intel.com>
References: <20250414151336.3852990-14-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tq/RMBE+tvB0OCVI"
Content-Disposition: inline
In-Reply-To: <20250414151336.3852990-14-alejandro.lucero-palau@amd.com>


--tq/RMBE+tvB0OCVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 73c117c17b562213242f432db2ddf1bcc22f39dd]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20250414-233241
base:   73c117c17b562213242f432db2ddf1bcc22f39dd
patch link:    https://lore.kernel.org/r/20250414151336.3852990-14-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v13 13/22] cxl: define a driver interface for DPA allocation
config: csky-randconfig-002-20250415
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build):

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504160058.DWk5ApNJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/hdm.c:6:
>> include/cxl/cxl.h:153:22: error: field 'dpa_range' has incomplete type
     153 |         struct range dpa_range;
         |                      ^~~~~~~~~
>> include/cxl/cxl.h:227:30: error: field 'range' has incomplete type
     227 |                 struct range range;
         |                              ^~~~~


vim +/dpa_range +153 include/cxl/cxl.h

04ccf61aaf26953 Alejandro Lucero 2025-04-14  144  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  145  /**
04ccf61aaf26953 Alejandro Lucero 2025-04-14  146   * struct cxl_dpa_perf - DPA performance property entry
04ccf61aaf26953 Alejandro Lucero 2025-04-14  147   * @dpa_range: range for DPA address
04ccf61aaf26953 Alejandro Lucero 2025-04-14  148   * @coord: QoS performance data (i.e. latency, bandwidth)
04ccf61aaf26953 Alejandro Lucero 2025-04-14  149   * @cdat_coord: raw QoS performance data from CDAT
04ccf61aaf26953 Alejandro Lucero 2025-04-14  150   * @qos_class: QoS Class cookies
04ccf61aaf26953 Alejandro Lucero 2025-04-14  151   */
04ccf61aaf26953 Alejandro Lucero 2025-04-14  152  struct cxl_dpa_perf {
04ccf61aaf26953 Alejandro Lucero 2025-04-14 @153  	struct range dpa_range;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  154  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
04ccf61aaf26953 Alejandro Lucero 2025-04-14  155  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
04ccf61aaf26953 Alejandro Lucero 2025-04-14  156  	int qos_class;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  157  };
04ccf61aaf26953 Alejandro Lucero 2025-04-14  158  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  159  enum cxl_partition_mode {
04ccf61aaf26953 Alejandro Lucero 2025-04-14  160  	CXL_PARTMODE_RAM,
04ccf61aaf26953 Alejandro Lucero 2025-04-14  161  	CXL_PARTMODE_PMEM,
04ccf61aaf26953 Alejandro Lucero 2025-04-14  162  };
04ccf61aaf26953 Alejandro Lucero 2025-04-14  163  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  164  /**
04ccf61aaf26953 Alejandro Lucero 2025-04-14  165   * struct cxl_dpa_partition - DPA partition descriptor
04ccf61aaf26953 Alejandro Lucero 2025-04-14  166   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
04ccf61aaf26953 Alejandro Lucero 2025-04-14  167   * @perf: performance attributes of the partition from CDAT
04ccf61aaf26953 Alejandro Lucero 2025-04-14  168   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
04ccf61aaf26953 Alejandro Lucero 2025-04-14  169   */
04ccf61aaf26953 Alejandro Lucero 2025-04-14  170  struct cxl_dpa_partition {
04ccf61aaf26953 Alejandro Lucero 2025-04-14  171  	struct resource res;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  172  	struct cxl_dpa_perf perf;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  173  	enum cxl_partition_mode mode;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  174  };
04ccf61aaf26953 Alejandro Lucero 2025-04-14  175  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  176  #define CXL_NR_PARTITIONS_MAX 2
04ccf61aaf26953 Alejandro Lucero 2025-04-14  177  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  178  /**
04ccf61aaf26953 Alejandro Lucero 2025-04-14  179   * struct cxl_dev_state - The driver device state
04ccf61aaf26953 Alejandro Lucero 2025-04-14  180   *
04ccf61aaf26953 Alejandro Lucero 2025-04-14  181   * cxl_dev_state represents the CXL driver/device state.  It provides an
04ccf61aaf26953 Alejandro Lucero 2025-04-14  182   * interface to mailbox commands as well as some cached data about the device.
04ccf61aaf26953 Alejandro Lucero 2025-04-14  183   * Currently only memory devices are represented.
04ccf61aaf26953 Alejandro Lucero 2025-04-14  184   *
04ccf61aaf26953 Alejandro Lucero 2025-04-14  185   * @dev: The device associated with this CXL state
04ccf61aaf26953 Alejandro Lucero 2025-04-14  186   * @cxlmd: The device representing the CXL.mem capabilities of @dev
04ccf61aaf26953 Alejandro Lucero 2025-04-14  187   * @reg_map: component and ras register mapping parameters
04ccf61aaf26953 Alejandro Lucero 2025-04-14  188   * @regs: Parsed register blocks
04ccf61aaf26953 Alejandro Lucero 2025-04-14  189   * @cxl_dvsec: Offset to the PCIe device DVSEC
04ccf61aaf26953 Alejandro Lucero 2025-04-14  190   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
04ccf61aaf26953 Alejandro Lucero 2025-04-14  191   * @media_ready: Indicate whether the device media is usable
04ccf61aaf26953 Alejandro Lucero 2025-04-14  192   * @dpa_res: Overall DPA resource tree for the device
04ccf61aaf26953 Alejandro Lucero 2025-04-14  193   * @part: DPA partition array
04ccf61aaf26953 Alejandro Lucero 2025-04-14  194   * @nr_partitions: Number of DPA partitions
04ccf61aaf26953 Alejandro Lucero 2025-04-14  195   * @serial: PCIe Device Serial Number
04ccf61aaf26953 Alejandro Lucero 2025-04-14  196   * @type: Generic Memory Class device or Vendor Specific Memory device
04ccf61aaf26953 Alejandro Lucero 2025-04-14  197   * @cxl_mbox: CXL mailbox context
04ccf61aaf26953 Alejandro Lucero 2025-04-14  198   * @cxlfs: CXL features context
04ccf61aaf26953 Alejandro Lucero 2025-04-14  199   */
04ccf61aaf26953 Alejandro Lucero 2025-04-14  200  struct cxl_dev_state {
04ccf61aaf26953 Alejandro Lucero 2025-04-14  201  	/* public for Type2 drivers */
04ccf61aaf26953 Alejandro Lucero 2025-04-14  202  	struct device *dev;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  203  	struct cxl_memdev *cxlmd;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  204  
04ccf61aaf26953 Alejandro Lucero 2025-04-14  205  	/* private for Type2 drivers */
04ccf61aaf26953 Alejandro Lucero 2025-04-14  206  	struct cxl_register_map reg_map;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  207  	struct cxl_regs regs;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  208  	int cxl_dvsec;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  209  	bool rcd;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  210  	bool media_ready;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  211  	struct resource dpa_res;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  212  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
04ccf61aaf26953 Alejandro Lucero 2025-04-14  213  	unsigned int nr_partitions;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  214  	u64 serial;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  215  	enum cxl_devtype type;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  216  	struct cxl_mailbox cxl_mbox;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  217  #ifdef CONFIG_CXL_FEATURES
04ccf61aaf26953 Alejandro Lucero 2025-04-14  218  	struct cxl_features_state *cxlfs;
04ccf61aaf26953 Alejandro Lucero 2025-04-14  219  #endif
04ccf61aaf26953 Alejandro Lucero 2025-04-14  220  };
04ccf61aaf26953 Alejandro Lucero 2025-04-14  221  
dd50535762e809d Alejandro Lucero 2025-04-14  222  #define CXL_NR_PARTITIONS_MAX 2
dd50535762e809d Alejandro Lucero 2025-04-14  223  
dd50535762e809d Alejandro Lucero 2025-04-14  224  struct cxl_dpa_info {
dd50535762e809d Alejandro Lucero 2025-04-14  225  	u64 size;
dd50535762e809d Alejandro Lucero 2025-04-14  226  	struct cxl_dpa_part_info {
dd50535762e809d Alejandro Lucero 2025-04-14 @227  		struct range range;
dd50535762e809d Alejandro Lucero 2025-04-14  228  		enum cxl_partition_mode mode;
dd50535762e809d Alejandro Lucero 2025-04-14  229  	} part[CXL_NR_PARTITIONS_MAX];
dd50535762e809d Alejandro Lucero 2025-04-14  230  	int nr_partitions;
dd50535762e809d Alejandro Lucero 2025-04-14  231  };
dd50535762e809d Alejandro Lucero 2025-04-14  232  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--tq/RMBE+tvB0OCVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

reproduce (this is a W=1 build):
        git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
        git checkout 73c117c17b562213242f432db2ddf1bcc22f39dd
        b4 shazam https://lore.kernel.org/r/20250414151336.3852990-14-alejandro.lucero-palau@amd.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-14.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-14.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

--tq/RMBE+tvB0OCVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/csky 6.15.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="csky-linux-gcc (GCC) 14.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=140200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24200
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24200
CONFIG_LLD_VERSION=0
CONFIG_RUSTC_VERSION=0
CONFIG_RUSTC_LLVM_VERSION=0
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY=y
CONFIG_PAHOLE_VERSION=130
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_LZO=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_LZO is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_MAY_HAVE_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
# CONFIG_SPARSE_IRQ is not set
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_NEED_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=2
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
CONFIG_RCU_LAZY=y
# CONFIG_RCU_LAZY_DEFAULT_OFF is not set
# CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_INDEX=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_SLAB_OBJ_EXT=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
CONFIG_MEMCG=y
# CONFIG_MEMCG_V1 is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_DMEM=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
# CONFIG_BUG is not set
# CONFIG_BASE_SMALL is not set
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_KCMP is not set
CONFIG_CACHESTAT_SYSCALL=y
CONFIG_PC104=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_SELFTEST=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
# end of Kexec and crash features
# end of General setup

CONFIG_CSKY=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_CPU_HAS_HILO=y
CONFIG_CPU_NEED_TLBSYNC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_MMU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_TIME_LOW_RES=y
CONFIG_CPU_ASID_BITS=8
CONFIG_L1_CACHE_SHIFT=5
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=17

#
# Processor type and features
#
# CONFIG_CPU_CK610 is not set
CONFIG_CPU_CK810=y
# CONFIG_CPU_CK807 is not set
# CONFIG_CPU_CK860 is not set
# CONFIG_PAGE_OFFSET_80000000 is not set
CONFIG_PAGE_OFFSET_A0000000=y
CONFIG_PAGE_OFFSET=0xa0000000
# CONFIG_CPU_PMU_NONE is not set
CONFIG_CSKY_PMU_V1=y
CONFIG_CPU_PM_NONE=y
# CONFIG_CPU_PM_WAIT is not set
# CONFIG_CPU_PM_DOZE is not set
# CONFIG_CPU_PM_STOP is not set
# CONFIG_CPU_HAS_FPU is not set
CONFIG_CPU_HAS_TEE=y
# CONFIG_HIGHMEM is not set
CONFIG_DRAM_BASE=0x0
CONFIG_HAVE_EFFICIENT_UNALIGNED_STRING_OPS=y
# end of Processor type and features

#
# Platform drivers selection
#
CONFIG_ARCH_CSKY_DW_APB_ICTL=y
# end of Platform drivers selection

# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_CPU_MITIGATIONS=y

#
# General architecture-dependent options
#
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_LOCK_EVENT_COUNTS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_FUNCTION_ALIGNMENT=0
CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT=y
CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT=y
CONFIG_ARCH_NEED_CMPXCHG_1_EMU=y
# end of General architecture-dependent options

CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
CONFIG_MODULE_DEBUG=y
CONFIG_MODULE_STATS=y
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS=y
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_COMPRESS_ALL is not set
CONFIG_MODULE_DECOMPRESS=y
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_WRITE_MOUNTED is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_CGROUP_IOPRIO=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=m
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# Slab allocator options
#
CONFIG_SLUB=y
CONFIG_KVFREE_RCU_BATCHED=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLAB_BUCKETS=y
# CONFIG_SLUB_STATS is not set
CONFIG_RANDOM_KMALLOC_CACHES=y
# end of Slab allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_FLATMEM=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_PAGE_MAPCOUNT=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=8
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CPU_CACHE_ALIASING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_DMAPOOL_TEST=y
# CONFIG_MEMFD_CREATE is not set
CONFIG_USERFAULTFD=y
# CONFIG_LRU_GEN is not set
CONFIG_LOCK_MM_AND_FIND_VMA=y
CONFIG_EXECMEM=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_DEBUG=y
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_PCIE_TPH is not set
CONFIG_PCI_DYNAMIC_OF_NODES=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_OCTEONEP=y
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
# CONFIG_PCIE_ALTERA is not set
# CONFIG_PCIE_APPLE is not set
# CONFIG_PCI_VERSATILE is not set
# CONFIG_PCIE_BRCMSTB is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCI_LOONGSON is not set
# CONFIG_PCIE_MEDIATEK is not set
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
# CONFIG_PCIE_MT7621 is not set
# CONFIG_PCI_TEGRA is not set
# CONFIG_PCIE_RCAR_HOST is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
# CONFIG_PCI_V3_SEMI is not set
# CONFIG_PCI_XGENE is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_DMA_PL is not set
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCIE_XILINX_CPM is not set

#
# Cadence-based PCIe controllers
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_DEBUGFS=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_AMD_MDB is not set
CONFIG_PCI_MESON=m
# CONFIG_PCIE_ARTPEC6_HOST is not set
# CONFIG_PCIE_BT1 is not set
# CONFIG_PCI_IMX6_HOST is not set
# CONFIG_PCI_LAYERSCAPE is not set
# CONFIG_PCI_HISI is not set
# CONFIG_PCIE_KIRIN is not set
# CONFIG_PCIE_HISI_STB is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_TEGRA194_HOST is not set
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_QCOM is not set
# CONFIG_PCIE_RCAR_GEN4_HOST is not set
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
# CONFIG_PCI_EXYNOS is not set
# CONFIG_PCIE_FU740 is not set
# CONFIG_PCIE_UNIPHIER is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
# CONFIG_PCIE_VISCONTI_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
# end of Mobiveil-based PCIe controllers

#
# PLDA-based PCIe controllers
#
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_STARFIVE_HOST is not set
# end of PLDA-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCI_PWRCTL=y
CONFIG_PCI_PWRCTL_SLOT=y
CONFIG_CXL_BUS=y
# CONFIG_CXL_PCI is not set
CONFIG_CXL_PORT=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_MOXTET is not set
# CONFIG_IMX_WEIM is not set
# CONFIG_INTEL_IXP4XX_EB is not set
# CONFIG_QCOM_EBI2 is not set
# CONFIG_STM32_FIREWALL is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=m
CONFIG_MHI_BUS_EP=y
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_FW_CS_DSP=m
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_CBMEM is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=m
# CONFIG_IMX_SCMI_MISC_DRV is not set

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_FWCTL=m
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
# CONFIG_MTD_BCM63XX_PARTS is not set
# CONFIG_MTD_BRCM_U_BOOT is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
# CONFIG_MTD_OF_PARTS_BCM4908 is not set
# CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
# CONFIG_MTD_PARSER_IMAGETAG is not set
# CONFIG_MTD_PARSER_TPLINK_SAFELOADER is not set
# CONFIG_MTD_PARSER_TRX is not set
# CONFIG_MTD_SHARPSL_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_PCI=m
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=m
CONFIG_MTD_MCHP48L640=m
CONFIG_MTD_SPEAR_SMI=m
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_AMS_DELTA=m
# CONFIG_MTD_NAND_SHARPSL is not set
CONFIG_MTD_NAND_CAFE=m
# CONFIG_MTD_NAND_ATMEL is not set
# CONFIG_MTD_NAND_MARVELL is not set
# CONFIG_MTD_NAND_SLC_LPC32XX is not set
# CONFIG_MTD_NAND_MLC_LPC32XX is not set
# CONFIG_MTD_NAND_BRCMNAND is not set
# CONFIG_MTD_NAND_VF610_NFC is not set
# CONFIG_MTD_NAND_MXC is not set
# CONFIG_MTD_NAND_SH_FLCTL is not set
# CONFIG_MTD_NAND_TXX9NDFMC is not set
# CONFIG_MTD_NAND_FSMC is not set
# CONFIG_MTD_NAND_SUNXI is not set
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_QCOM is not set
CONFIG_MTD_NAND_MXIC=m
# CONFIG_MTD_NAND_TEGRA is not set
# CONFIG_MTD_NAND_STM32_FMC2 is not set
# CONFIG_MTD_NAND_MESON is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
CONFIG_MTD_NAND_INTEL_LGM=m
# CONFIG_MTD_NAND_RENESAS is not set
# CONFIG_MTD_NAND_NUVOTON_MA35 is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_SPI_NAND=m

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# CONFIG_MTD_NAND_ECC_MEDIATEK is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
# CONFIG_SPI_HISI_SFC is not set
# CONFIG_SPI_NXP_SPIFI is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_UBI_NVMEM is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_1284 is not set
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
CONFIG_RPMB=m
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=m
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_SMPRO_ERRMON is not set
# CONFIG_SMPRO_MISC is not set
# CONFIG_GEHC_ACHC is not set
CONFIG_HI6421V600_IRQ=m
# CONFIG_HP_ILO is not set
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_OPEN_DICE=y
CONFIG_NTSYNC=y
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_TPS6594_ESM=y
CONFIG_TPS6594_PFSM=y
# CONFIG_NSM is not set
CONFIG_MCHP_LAN966X_PCI=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ECHO=m
# CONFIG_BCM_VK is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=m
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
CONFIG_PVPANIC_PCI=m
CONFIG_GP_PCI1XXXX=y
# CONFIG_KEBA_LAN9252 is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=y
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=3
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_BRCM is not set
# CONFIG_AHCI_DA850 is not set
# CONFIG_AHCI_DM816 is not set
CONFIG_AHCI_DWC=m
# CONFIG_AHCI_ST is not set
# CONFIG_AHCI_IMX is not set
CONFIG_AHCI_CEVA=m
# CONFIG_AHCI_MTK is not set
# CONFIG_AHCI_MVEBU is not set
# CONFIG_AHCI_SUNXI is not set
# CONFIG_AHCI_TEGRA is not set
# CONFIG_AHCI_XGENE is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_FSL is not set
# CONFIG_SATA_GEMINI is not set
# CONFIG_SATA_AHCI_SEATTLE is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_IXP4XX_CF is not set
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_BITMAP_FILE=y
CONFIG_MD_LINEAR=m
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID10=m
# CONFIG_MD_RAID456 is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
CONFIG_DM_DUST=m
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
CONFIG_LOOPBACK_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_REMOTE_TARGET is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_EMU10K1=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_PPDEV is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_AIROHA=y
CONFIG_HW_RANDOM_ATMEL=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_BCM74110=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_MXC_RNGA=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_INGENIC_RNG=y
CONFIG_HW_RANDOM_INGENIC_TRNG=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_HISI=y
# CONFIG_HW_RANDOM_HISTB is not set
# CONFIG_HW_RANDOM_ST is not set
CONFIG_HW_RANDOM_XGENE=y
CONFIG_HW_RANDOM_STM32=y
# CONFIG_HW_RANDOM_PIC32 is not set
# CONFIG_HW_RANDOM_MESON is not set
# CONFIG_HW_RANDOM_MTK is not set
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_HW_RANDOM_JH7110 is not set
CONFIG_HW_RANDOM_ROCKCHIP=y
CONFIG_APPLICOM=m
CONFIG_DEVMEM=y
CONFIG_TCG_TPM=m
CONFIG_TCG_TPM2_HMAC=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_SYNQUACER is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
CONFIG_XILLYBUS_OF=m
# end of Character devices

#
# I2C support
#
# CONFIG_I2C is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y
CONFIG_SPI_OFFLOAD=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_AIROHA_SNFI is not set
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_CORE is not set
# CONFIG_SPI_AMLOGIC_SPIFC_A1 is not set
# CONFIG_SPI_APPLE is not set
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
# CONFIG_SPI_ARMADA_3700 is not set
# CONFIG_SPI_ASPEED_SMC is not set
# CONFIG_SPI_ATMEL is not set
# CONFIG_SPI_ATMEL_QUADSPI is not set
CONFIG_SPI_AXI_SPI_ENGINE=m
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
# CONFIG_SPI_BCM_QSPI is not set
# CONFIG_SPI_BCMBCA_HSSPI is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CLPS711X is not set
# CONFIG_SPI_DAVINCI is not set
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
# CONFIG_SPI_DW_BT1 is not set
# CONFIG_SPI_EP93XX is not set
CONFIG_SPI_FSI=m
# CONFIG_SPI_FSL_LPSPI is not set
# CONFIG_SPI_FSL_QUADSPI is not set
# CONFIG_SPI_GXP is not set
# CONFIG_SPI_HISI_KUNPENG is not set
# CONFIG_SPI_HISI_SFC_V3XX is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_IMG_SPFI is not set
# CONFIG_SPI_IMX is not set
# CONFIG_SPI_INGENIC is not set
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_JCORE is not set
# CONFIG_SPI_KSPI2 is not set
CONFIG_SPI_LM70_LLP=m
# CONFIG_SPI_LOONGSON_PCI is not set
# CONFIG_SPI_LOONGSON_PLATFORM is not set
# CONFIG_SPI_LP8841_RTC is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
CONFIG_SPI_MICROCHIP_CORE=m
CONFIG_SPI_MICROCHIP_CORE_QSPI=m
# CONFIG_SPI_MT65XX is not set
# CONFIG_SPI_MT7621 is not set
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_WPCM_FIU is not set
# CONFIG_SPI_NPCM_FIU is not set
# CONFIG_SPI_NPCM_PSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PCI1XXXX=m
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_REALTEK_SNAND is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
# CONFIG_SPI_RZV2M_CSI is not set
# CONFIG_SPI_QCOM_QSPI is not set
# CONFIG_SPI_QPIC_SNAND is not set
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_S3C64XX is not set
# CONFIG_SPI_SH_MSIOF is not set
# CONFIG_SPI_SH is not set
# CONFIG_SPI_SH_HSPI is not set
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SN_F_OSPI=m
# CONFIG_SPI_SG2044_NOR is not set
# CONFIG_SPI_SPRD is not set
# CONFIG_SPI_SPRD_ADI is not set
# CONFIG_SPI_STM32 is not set
# CONFIG_SPI_STM32_OSPI is not set
# CONFIG_SPI_STM32_QSPI is not set
# CONFIG_SPI_ST_SSC4 is not set
# CONFIG_SPI_SUN4I is not set
# CONFIG_SPI_SUN6I is not set
# CONFIG_SPI_SUNPLUS_SP7021 is not set
# CONFIG_SPI_SYNQUACER is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TEGRA210_QUAD is not set
# CONFIG_SPI_TEGRA114 is not set
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_UNIPHIER is not set
CONFIG_SPI_XILINX=m
# CONFIG_SPI_XLP is not set
# CONFIG_SPI_XTENSA_XTFPGA is not set
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y

#
# SPI Offload triggers
#
# CONFIG_SPI_OFFLOAD_TRIGGER_PWM is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
# CONFIG_SPMI_MTK_PMIF is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m
CONFIG_PPS_GENERATOR=m
CONFIG_PPS_GENERATOR_DUMMY=m

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AMDISP is not set
# CONFIG_PINCTRL_AT91PIO4 is not set
# CONFIG_PINCTRL_BM1880 is not set
# CONFIG_PINCTRL_DA850_PUPD is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_EYEQ5 is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_K230 is not set
# CONFIG_PINCTRL_LOONGSON2 is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SCMI is not set
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_TPS6594=y
# CONFIG_PINCTRL_TH1520 is not set
# CONFIG_PINCTRL_MLXBF3 is not set
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
# CONFIG_PINCTRL_NSP_GPIO is not set
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
# CONFIG_PINCTRL_IMX1 is not set
# CONFIG_PINCTRL_IMX27 is not set
# CONFIG_PINCTRL_IMX25 is not set
# CONFIG_PINCTRL_IMX35 is not set
# CONFIG_PINCTRL_IMX50 is not set
# CONFIG_PINCTRL_IMX51 is not set
# CONFIG_PINCTRL_IMX53 is not set
# CONFIG_PINCTRL_IMX6Q is not set
# CONFIG_PINCTRL_IMX6SL is not set
# CONFIG_PINCTRL_IMX6SLL is not set
# CONFIG_PINCTRL_IMX6SX is not set
# CONFIG_PINCTRL_IMX6UL is not set
# CONFIG_PINCTRL_IMX7D is not set
# CONFIG_PINCTRL_IMX7ULP is not set
# CONFIG_PINCTRL_IMX8MM is not set
# CONFIG_PINCTRL_IMX8MN is not set
# CONFIG_PINCTRL_IMX8MP is not set
# CONFIG_PINCTRL_IMX8MQ is not set
# CONFIG_PINCTRL_IMX8QM is not set
# CONFIG_PINCTRL_IMX8QXP is not set
# CONFIG_PINCTRL_IMX8DXL is not set
# CONFIG_PINCTRL_IMX8ULP is not set
# CONFIG_PINCTRL_IMXRT1050 is not set
# CONFIG_PINCTRL_IMX93 is not set
# CONFIG_PINCTRL_VF610 is not set
# CONFIG_PINCTRL_IMXRT1170 is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_METEORPOINT is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# CONFIG_PINCTRL_MERRIFIELD is not set
# CONFIG_PINCTRL_MOOREFIELD is not set
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_AIROHA is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7981 is not set
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT7988 is not set
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8188 is not set
# CONFIG_PINCTRL_MT8192 is not set
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_NOMADIK is not set
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
# CONFIG_PINCTRL_NPCM8XX is not set
# CONFIG_PINCTRL_MA35D1 is not set
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
# CONFIG_PINCTRL_MSM is not set
# CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
# CONFIG_PINCTRL_PFC_R8A77990 is not set
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A779H0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SOPHGO_CV1800B is not set
# CONFIG_PINCTRL_SOPHGO_CV1812H is not set
# CONFIG_PINCTRL_SOPHGO_SG2000 is not set
# CONFIG_PINCTRL_SOPHGO_SG2002 is not set
# CONFIG_PINCTRL_SOPHGO_SG2042 is not set
# CONFIG_PINCTRL_SOPHGO_SG2044 is not set
# CONFIG_PINCTRL_SPACEMIT_K1 is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
# CONFIG_PINCTRL_STARFIVE_JH7100 is not set
# CONFIG_PINCTRL_STARFIVE_JH7110_SYS is not set
# CONFIG_PINCTRL_STARFIVE_JH7110_AON is not set
# CONFIG_PINCTRL_STM32F429 is not set
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_STM32MP257 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
CONFIG_PINCTRL_UNIPHIER=y
# CONFIG_PINCTRL_UNIPHIER_LD4 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
# CONFIG_PINCTRL_UNIPHIER_LD6B is not set
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
# CONFIG_PINCTRL_UNIPHIER_LD20 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
# CONFIG_PINCTRL_UNIPHIER_NX1 is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BRCMSTB is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DAVINCI is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EIC_SPRD is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_GE_FPGA is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRANITERAPIDS is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_LOONGSON_64BIT is not set
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
# CONFIG_GPIO_MVEBU is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_NOMADIK is not set
# CONFIG_GPIO_NPCM_SGPIO is not set
# CONFIG_GPIO_OMAP is not set
# CONFIG_GPIO_POLARFIRE_SOC is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SNPS_CREG is not set
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VF610 is not set
# CONFIG_GPIO_VISCONTI is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_AMD_FCH is not set
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# MFD GPIO expanders
#
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
# CONFIG_GPIO_SL28CPLD is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_WM831X=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
# CONFIG_GPIO_MLXBF3 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=m
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

#
# GPIO Debugging utilities
#
# CONFIG_GPIO_VIRTUSER is not set
# end of GPIO Debugging utilities

# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SEQUENCING is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=m
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_XILINX_WINDOW_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_AIROHA_WATCHDOG is not set
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_ASM9260_WATCHDOG is not set
# CONFIG_AT91RM9200_WATCHDOG is not set
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_FTWDT010_WATCHDOG is not set
# CONFIG_S3C2410_WATCHDOG is not set
# CONFIG_SA1100_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_EP93XX_WATCHDOG is not set
# CONFIG_OMAP_WATCHDOG is not set
# CONFIG_PNX4008_WATCHDOG is not set
# CONFIG_DAVINCI_WATCHDOG is not set
# CONFIG_K3_RTI_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
# CONFIG_NPCM7XX_WATCHDOG is not set
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS4800_WATCHDOG is not set
# CONFIG_TS72XX_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_IMX2_WDT is not set
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_MOXART_WDT is not set
# CONFIG_ST_LPC_WATCHDOG is not set
# CONFIG_TEGRA_WATCHDOG is not set
# CONFIG_QCOM_WDT is not set
# CONFIG_MESON_GXBB_WATCHDOG is not set
# CONFIG_MESON_WATCHDOG is not set
# CONFIG_MEDIATEK_WATCHDOG is not set
# CONFIG_DIGICOLOR_WATCHDOG is not set
# CONFIG_LPC18XX_WATCHDOG is not set
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
# CONFIG_RENESAS_RZV2HWDT is not set
# CONFIG_ASPEED_WATCHDOG is not set
CONFIG_STM32_WATCHDOG=y
# CONFIG_UNIPHIER_WATCHDOG is not set
# CONFIG_RTD119X_WATCHDOG is not set
# CONFIG_REALTEK_OTTO_WDT is not set
# CONFIG_SPRD_WATCHDOG is not set
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_MSC313E_WATCHDOG is not set
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_SC520_WDT is not set
CONFIG_I6300ESB_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_RDC321X_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_BCM47XX_WDT is not set
# CONFIG_JZ4740_WDT is not set
# CONFIG_BCM2835_WDT is not set
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM_KONA_WDT_DEBUG is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
# CONFIG_LOONGSON1_WDT is not set
# CONFIG_GXP_WATCHDOG is not set
# CONFIG_MT7621_WDT is not set
# CONFIG_MPC5200_WDT is not set
CONFIG_MEN_A21_WDT=m
# CONFIG_STARFIVE_WATCHDOG is not set
# CONFIG_UML_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_MIPS is not set
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_OCELOT=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SPMI_PMIC is not set
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RK8XX=m
CONFIG_MFD_RK8XX_SPI=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_RZ_MTU3 is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS6594=y
CONFIG_MFD_TPS6594_SPI=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_STM32_LPTIMER is not set
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_CS40L50_CORE=m
CONFIG_MFD_CS40L50_SPI=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_SPI=y
CONFIG_MFD_QNAP_MCU=m
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_REFGEN is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RK808=m
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SUN20I is not set
CONFIG_REGULATOR_TPS6594=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_RZG2L_VBCTRL is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=m
# CONFIG_RADIO_SI4713 is not set
CONFIG_RADIO_SI470X=m
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
CONFIG_VIDEO_CADENCE_CSI2RX=y
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

#
# Chips&Media media platform drivers
#
# CONFIG_VIDEO_E5010_JPEG_ENC is not set

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# Nuvoton media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#
# CONFIG_VIDEO_IMX7_CSI is not set
# CONFIG_VIDEO_IMX8MQ_MIPI_CSI2 is not set
# CONFIG_VIDEO_IMX_MIPI_CSIS is not set

#
# Qualcomm media platform drivers
#
# CONFIG_VIDEO_QCOM_IRIS is not set

#
# Raspberry Pi media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#
CONFIG_VIDEO_SYNOPSYS_HDMIRX=m
CONFIG_VIDEO_SYNOPSYS_HDMIRX_LOAD_DEFAULT_EDID=y

#
# Texas Instruments drivers
#
# CONFIG_VIDEO_TI_J721E_CSI2RX is not set

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera ISPs
#
# end of Camera ISPs

#
# Lens drivers
#
# end of Lens drivers

#
# Flash devices
#
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# end of RDS decoders

#
# Video decoders
#

#
# Video and audio decoders
#
# end of Video decoders

#
# Video encoders
#
# end of Video encoders

#
# Video improvement chips
#
# end of Video improvement chips

#
# Audio/Video compression chips
#
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# end of Miscellaneous helper chips

#
# Video serializers and deserializers
#
# end of Video serializers and deserializers

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_MSI001=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_TEGRA_HOST1X is not set
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_KTD2801=m
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=m
# CONFIG_BACKLIGHT_APPLE_DWI is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_COMPRESS_ACCEL=y
CONFIG_SND_JACK=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_CTL_FAST_LOOKUP is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_CTL_DEBUG=y
CONFIG_SND_JACK_INJECTION_DEBUG=y
# CONFIG_SND_UTIMER is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_UMP=y
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_SCODEC_CS35L56_SPI is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_SENARYTECH=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
# CONFIG_SND_OXFW is not set
# CONFIG_SND_ISIGHT is not set
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
# CONFIG_SND_FIREWIRE_TASCAM is not set
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
# CONFIG_SND_SOC_ADI is not set
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_AMD_ACP_CONFIG=m
CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL=m
# CONFIG_SND_SOC_APPLE_MCA is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM2835_SOC_I2S is not set
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
# CONFIG_SND_EP93XX_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=m
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=m
# CONFIG_SND_SOC_FSL_EASRC is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_FSL_AUD2HTX is not set
CONFIG_SND_SOC_FSL_UTILS=m
# CONFIG_SND_SOC_FSL_LPC3XXX is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
# CONFIG_SND_IMX_SOC is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_SOC_CHV3_I2S=m
# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_JZ4740_SOC_I2S is not set
# CONFIG_SND_KIRKWOOD_SOC is not set

#
# SoC Audio for Loongson CPUs
#
# CONFIG_SND_SOC_LOONGSON_CARD is not set
# CONFIG_SND_SOC_LOONGSON_I2S_PCI is not set
# CONFIG_SND_SOC_LOONGSON_I2S_PLATFORM is not set
# end of SoC Audio for Loongson CPUs

# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
# CONFIG_SND_SOC_INTEL_KEEMBAY is not set
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
# CONFIG_SND_SOC_MT8186 is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_MT8188 is not set
# CONFIG_SND_SOC_MT8195 is not set
# CONFIG_SND_SOC_MT8365 is not set

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
# CONFIG_SND_MESON_AXG_FRDDR is not set
# CONFIG_SND_MESON_AXG_TODDR is not set
# CONFIG_SND_MESON_AXG_TDMIN is not set
# CONFIG_SND_MESON_AXG_TDMOUT is not set
# CONFIG_SND_MESON_AXG_SOUND_CARD is not set
# CONFIG_SND_MESON_AXG_SPDIFOUT is not set
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
# CONFIG_SND_MESON_AXG_PDM is not set
# CONFIG_SND_MESON_GX_SOUND_CARD is not set
# CONFIG_SND_MESON_G12A_TOACODEC is not set
# CONFIG_SND_MESON_G12A_TOHDMITX is not set
# CONFIG_SND_SOC_MESON_T9015 is not set
# end of ASoC support for Amlogic platforms

# CONFIG_SND_MXS_SOC is not set
# CONFIG_SND_PXA2XX_SOC is not set
# CONFIG_SND_SOC_QCOM is not set

#
# SoC Audio support for Renesas SoCs
#
# CONFIG_SND_SOC_SH4_FSI is not set
# CONFIG_SND_SOC_RCAR is not set
# CONFIG_SND_SOC_RZ is not set
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_ROCKCHIP is not set
# CONFIG_SND_SOC_SAMSUNG is not set
CONFIG_SND_SOC_SDCA_OPTIONAL=m
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=m
# CONFIG_SND_SOC_SOF_ACPI is not set
# CONFIG_SND_SOC_SOF_OF is not set
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
# CONFIG_SND_SOC_SPRD is not set
# CONFIG_SND_SOC_STARFIVE is not set
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_STM32_SAI is not set
# CONFIG_SND_SOC_STM32_I2S is not set
# CONFIG_SND_SOC_STM32_SPDIFRX is not set
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
# CONFIG_SND_SUN4I_CODEC is not set
# CONFIG_SND_SUN8I_CODEC is not set
# CONFIG_SND_SUN8I_CODEC_ANALOG is not set
# CONFIG_SND_SUN50I_CODEC_ANALOG is not set
# CONFIG_SND_SUN4I_I2S is not set
# CONFIG_SND_SUN4I_SPDIF is not set
# CONFIG_SND_SUN50I_DMIC is not set
# end of Allwinner SoC Audio support

# CONFIG_SND_SOC_TEGRA is not set

#
# Audio support for Texas Instruments SoCs
#

#
# Texas Instruments DAI support for:
#
# CONFIG_SND_SOC_DAVINCI_ASP is not set
# CONFIG_SND_SOC_DAVINCI_MCASP is not set
# CONFIG_SND_SOC_OMAP_DMIC is not set
# CONFIG_SND_SOC_OMAP_MCBSP is not set
# CONFIG_SND_SOC_OMAP_MCPDM is not set

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP_HDMI is not set
# end of Audio support for Texas Instruments SoCs

# CONFIG_SND_SOC_UNIPHIER is not set
# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_ALL_CODECS is not set
CONFIG_SND_SOC_WM_ADSP=m
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_SPI=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4554=m
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AW8738=m
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CHV3_CODEC=m
CONFIG_SND_SOC_CPCAP=m
CONFIG_SND_SOC_CS_AMP_LIB=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_SPI=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
CONFIG_SND_SOC_CS35L56_SPI=m
CONFIG_SND_SOC_CS40L50=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS4341=m
# CONFIG_SND_SOC_JZ4740_CODEC is not set
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_IDT821034=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_SPI=m
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_PEB2466=m
# CONFIG_SND_SOC_RK3308 is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RK817=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
CONFIG_SND_SOC_SIMPLE_MUX=m
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
CONFIG_SND_SOC_UDA1334=m
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_SPI=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
# CONFIG_SND_SOC_MT6357 is not set
# CONFIG_SND_SOC_MT6358 is not set
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
CONFIG_SND_SOC_LPASS_VA_MACRO=m
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_CARD2=m
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=m
CONFIG_SND_TEST_COMPONENT=m
# CONFIG_SND_VIRTIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SUNPLUS is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_UHS2 is not set
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_OF_ARASAN=m
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_ESDHC is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_OF_SPARX5 is not set
# CONFIG_MMC_SDHCI_OF_MA35D1 is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
# CONFIG_MMC_SDHCI_ESDHC_IMX is not set
# CONFIG_MMC_SDHCI_DOVE is not set
# CONFIG_MMC_SDHCI_TEGRA is not set
# CONFIG_MMC_SDHCI_S3C is not set
# CONFIG_MMC_SDHCI_PXAV3 is not set
# CONFIG_MMC_SDHCI_PXAV2 is not set
# CONFIG_MMC_SDHCI_SPEAR is not set
# CONFIG_MMC_SDHCI_BCM_KONA is not set
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=m
# CONFIG_MMC_SDHCI_IPROC is not set
# CONFIG_MMC_SDHCI_NPCM is not set
# CONFIG_MMC_MESON_GX is not set
# CONFIG_MMC_MESON_MX_SDHC is not set
# CONFIG_MMC_MESON_MX_SDIO is not set
# CONFIG_MMC_MOXART is not set
# CONFIG_MMC_SDHCI_ST is not set
# CONFIG_MMC_OMAP_HS is not set
# CONFIG_MMC_ALCOR is not set
# CONFIG_MMC_SDHCI_MSM is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_DAVINCI is not set
CONFIG_MMC_SPI=m
# CONFIG_MMC_SDHCI_SPRD is not set
# CONFIG_MMC_SDHI is not set
# CONFIG_MMC_UNIPHIER is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
# CONFIG_MMC_DW_BLUEFIELD is not set
CONFIG_MMC_DW_EXYNOS=m
# CONFIG_MMC_DW_HI3798CV200 is not set
CONFIG_MMC_DW_HI3798MV200=m
# CONFIG_MMC_DW_K3 is not set
CONFIG_MMC_DW_PCI=m
# CONFIG_MMC_SH_MMCIF is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_BCM2835 is not set
CONFIG_MMC_MTK=m
# CONFIG_MMC_SDHCI_BRCMSTB is not set
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
# CONFIG_MMC_OWL is not set
# CONFIG_MMC_LITEX is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=y
CONFIG_LEDS_EXPRESSWIRE=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_ARIEL is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_CPCAP=m
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_SUN50I_A100 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_QNAP_MCU=m
CONFIG_LEDS_WM831X_STATUS=m
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_NS2=m
CONFIG_LEDS_NETXBIG=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
# CONFIG_LEDS_IP30 is not set
# CONFIG_LEDS_BCM63138 is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
CONFIG_LEDS_GROUP_MULTICOLOR=m
CONFIG_LEDS_PWM_MULTICOLOR=m
CONFIG_LEDS_QCOM_LPG=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set

#
# Simatic LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_APPLE_ADMAC is not set
# CONFIG_AXI_DMAC is not set
# CONFIG_DMA_JZ4780 is not set
# CONFIG_DMA_SA11X0 is not set
# CONFIG_DMA_SUN6I is not set
CONFIG_DW_AXI_DMAC=m
# CONFIG_EP93XX_DMA is not set
# CONFIG_FSL_EDMA is not set
# CONFIG_HISI_DMA is not set
# CONFIG_IMG_MDC_DMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_K3_DMA is not set
# CONFIG_LOONGSON1_APB_DMA is not set
# CONFIG_LOONGSON2_APB_DMA is not set
# CONFIG_MCF_EDMA is not set
# CONFIG_MILBEAUT_HDMAC is not set
# CONFIG_MILBEAUT_XDMAC is not set
# CONFIG_MMP_PDMA is not set
# CONFIG_MMP_TDMA is not set
# CONFIG_MV_XOR is not set
# CONFIG_MXS_DMA is not set
# CONFIG_NBPFAXI_DMA is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PXA_DMA is not set
CONFIG_PLX_DMA=m
# CONFIG_SPRD_DMA is not set
# CONFIG_TEGRA20_APB_DMA is not set
# CONFIG_TEGRA210_ADMA is not set
# CONFIG_TIMB_DMA is not set
# CONFIG_UNIPHIER_MDMAC is not set
# CONFIG_UNIPHIER_XDMAC is not set
# CONFIG_XGENE_DMA is not set
CONFIG_XILINX_DMA=m
CONFIG_XILINX_XDMA=y
# CONFIG_XILINX_ZYNQMP_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=m
# CONFIG_AMD_QDMA is not set
# CONFIG_MTK_HSDMA is not set
# CONFIG_MTK_CQDMA is not set
# CONFIG_QCOM_ADM is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_RZN1_DMAMUX is not set
CONFIG_DW_DMAC_PCI=m
CONFIG_DW_EDMA=m
CONFIG_DW_EDMA_PCIE=m
CONFIG_SF_PDMA=m
CONFIG_RENESAS_DMA=y
CONFIG_SH_DMAE_BASE=y
# CONFIG_SH_DMAE is not set
# CONFIG_RCAR_DMAC is not set
# CONFIG_RENESAS_USB_DMAC is not set
# CONFIG_RZ_DMAC is not set
CONFIG_TI_EDMA=y
CONFIG_DMA_OMAP=y
CONFIG_TI_DMA_CROSSBAR=y
# CONFIG_INTEL_LDMA is not set
# CONFIG_STM32_DMA is not set
# CONFIG_STM32_MDMA is not set
# CONFIG_STM32_DMA3 is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
# CONFIG_VFIO_NOIOMMU is not set
# CONFIG_VFIO_DEBUGFS is not set

#
# VFIO support for PCI devices
#
# CONFIG_VFIO_PCI is not set
# end of VFIO support for PCI devices

#
# VFIO support for platform devices
#
# CONFIG_VFIO_PLATFORM is not set
# CONFIG_VFIO_AMBA is not set
# end of VFIO support for platform devices

# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_BEAGLEPLAY=m
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_MESON_VDEC is not set
# CONFIG_VIDEO_ROCKCHIP_VDEC is not set

#
# StarFive media platform drivers
#
# CONFIG_VIDEO_SUNXI is not set
CONFIG_STAGING_MEDIA_DEPRECATED=y

#
# Atmel media platform drivers
#
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_VIDEO is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_GREYBUS_AUDIO=m
# CONFIG_GREYBUS_AUDIO_APB_CODEC is not set
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_FIRMWARE is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_PWM=m
# CONFIG_GREYBUS_SDIO is not set
CONFIG_GREYBUS_SPI=m
# CONFIG_GREYBUS_ARCHE is not set
CONFIG_BCM_VIDEOCORE=y
# CONFIG_BCM2835_VCHIQ is not set
# CONFIG_SND_BCM2835 is not set
# CONFIG_VIDEO_BCM2835 is not set
CONFIG_XIL_AXIS_FIFO=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Device Drivers
#
# CONFIG_VME_USER is not set
# CONFIG_GPIB is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_CZNIC_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_ARM64_PLATFORM_DEVICES=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
# CONFIG_COMMON_CLK_BM1880 is not set
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_EP93XX is not set
# CONFIG_COMMON_CLK_EYEQ is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_NPCM8XX is not set
# CONFIG_COMMON_CLK_LOONGSON2 is not set
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_COMMON_CLK_SP7021 is not set
# CONFIG_CLK_ACTIONS is not set
# CONFIG_CLK_BAIKAL_T1 is not set
# CONFIG_CLK_BCM2711_DVP is not set
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM63268_TIMER is not set
# CONFIG_CLK_BCM_KONA is not set
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
# CONFIG_COMMON_CLK_HI3798CV200 is not set
# CONFIG_COMMON_CLK_HI6220 is not set
# CONFIG_RESET_HISI is not set
# CONFIG_COMMON_CLK_BOSTON is not set
# CONFIG_MXC_CLK is not set
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
# CONFIG_CLK_IMX8MP is not set
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set
# CONFIG_CLK_IMX95_BLK_CTL is not set
# CONFIG_CLK_IMXRT1050 is not set

#
# Ingenic SoCs drivers
#
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4755 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
# CONFIG_COMMON_CLK_MEDIATEK_FHCTL is not set
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6735 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7981 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT7988 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8188 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_CPUPLL is not set
# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_COMMON_CLK_NUVOTON=y
CONFIG_CLK_MA35D1=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_MTMIPS is not set
# CONFIG_CLK_RENESAS is not set
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_CLK_SIFIVE is not set
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_CLK_SOPHGO_CV1800 is not set
# CONFIG_CLK_SOPHGO_SG2042_PLL is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_STARFIVE_JH7110_PLL is not set
# CONFIG_CLK_STARFIVE_JH7110_SYS is not set
CONFIG_CLK_SUNXI=y
CONFIG_CLK_SUNXI_CLOCKS=y
CONFIG_CLK_SUNXI_PRCM_SUN6I=y
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
CONFIG_CLK_SUNXI_PRCM_SUN9I=y
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_STM32MP=y
CONFIG_COMMON_CLK_STM32MP135=y
CONFIG_COMMON_CLK_STM32MP157=y
CONFIG_COMMON_CLK_STM32MP257=y
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
CONFIG_DW_APB_TIMER=y
CONFIG_DW_APB_TIMER_OF=y
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_REALTEK_OTTO_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_TEGRA186_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_TI_32K is not set
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_CLKSRC_MPS2 is not set
# CONFIG_ARC_TIMERS is not set
# CONFIG_ARM_TIMER_SP804 is not set
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_MTK_CPUX_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_LOONGSON1_PWM is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_CSKY_MP_TIMER is not set
# CONFIG_GX6605S_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_RALINK_TIMER is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
# CONFIG_ASPEED_LPC_SNOOP is not set
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# Hisilicon SoC drivers
#
# end of Hisilicon SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# CONFIG_SOC_IMX9 is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_LOONGSON2_GUTS is not set

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
# CONFIG_MTK_INFRACFG is not set
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_REGULATOR_COUPLER is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

CONFIG_WPCM450_SOC=y

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_PMIC_PDCHARGER_ULOG=m
# CONFIG_QCOM_RAMP_CTRL is not set
# CONFIG_QCOM_RMTFS_MEM is not set
# CONFIG_QCOM_RPM_MASTER_STATS is not set
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_ICC_BWMON is not set
# CONFIG_QCOM_PBS is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
# CONFIG_SOC_SAMSUNG is not set
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_TI_PRUSS is not set
# CONFIG_UX500_SOC_ID is not set
# CONFIG_SOC_INTEGRATOR_CM is not set
# CONFIG_SOC_REALVIEW is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

CONFIG_ARM_SCMI_PERF_DOMAIN=y
CONFIG_ARM_SCMI_POWER_DOMAIN=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y

#
# Broadcom PM Domains
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_BCM_PMB is not set
# CONFIG_BCM63XX_POWER is not set
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# MediaTek PM Domains
#
# CONFIG_MTK_SCPSYS is not set
# end of MediaTek PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains

# CONFIG_UX500_PM_DOMAIN is not set
# end of PM Domains

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_APPLE is not set
# CONFIG_PWM_ATMEL is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=m
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_AXI_PWMGEN is not set
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
CONFIG_PWM_CLK=y
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_EP93XX is not set
CONFIG_PWM_FSL_FTM=m
# CONFIG_PWM_GPIO is not set
# CONFIG_PWM_HIBVT is not set
# CONFIG_PWM_IMG is not set
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MICROCHIP_CORE is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SIFIVE is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SOPHGO_SG2042 is not set
# CONFIG_PWM_SPEAR is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STI is not set
# CONFIG_PWM_STM32 is not set
# CONFIG_PWM_STM32_LP is not set
CONFIG_PWM_STMPE=y
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_SUNPLUS is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
# CONFIG_PWM_VT8500 is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_DW_APB_ICTL=y
CONFIG_LAN966X_OIC=m
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_RENESAS_RZV2H_ICU is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_STM32MP_EXTI is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
CONFIG_CSKY_APB_INTC=y
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_IMX_MU_MSI is not set
# CONFIG_STARFIVE_JH8100_INTC is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SOPHGO_SG2042_MSI is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_BRCMSTB is not set
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_EYEQ is not set
# CONFIG_RESET_GPIO is not set
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_IMX8MP_AUDIOMIX is not set
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_NUVOTON_MA35D1 is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
# CONFIG_RESET_QCOM_PDC is not set
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_SCMI is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
# CONFIG_RESET_UNIPHIER_GLUE is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_ZYNQMP is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUX is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_STIH407_RESET is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set
# CONFIG_RESET_TEGRA_BPMP is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_CAN_TRANSCEIVER=m
# CONFIG_PHY_AIROHA_PCIE is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
# CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
# CONFIG_PHY_BCM_SR_PCIE is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=m
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=m
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_IMX8QM_HSIO is not set
# CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_XFI_TPHY is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_CSI_0_5 is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_MTK_DP is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_MA35_USB is not set
# CONFIG_PHY_ATH79_USB is not set
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_SNPS_EUSB2 is not set
# CONFIG_PHY_QCOM_EUSB2_REPEATER is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
# CONFIG_PHY_QCOM_SGMII_ETH is not set
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_R8A779F0_ETHERNET_SERDES is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SAMSUNG_DCPHY is not set
# CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_COMBOPHY is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_STARFIVE_JH7110_DPHY_RX is not set
# CONFIG_PHY_STARFIVE_JH7110_DPHY_TX is not set
# CONFIG_PHY_STARFIVE_JH7110_PCIE is not set
# CONFIG_PHY_SUNPLUS_USB is not set
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_ARM_NI is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
# CONFIG_HNS3_PMU is not set
# CONFIG_DWC_PCIE_PMU is not set
# CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is not set
# CONFIG_MESON_DDR_PMU is not set
CONFIG_CXL_PMU=y
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_DEBUGFS_MARGINING=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_LAYOUTS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=m
CONFIG_NVMEM_LAYOUT_ONIE_TLV=y
CONFIG_NVMEM_LAYOUT_U_BOOT_ENV=y
# end of Layout Types

# CONFIG_NVMEM_APPLE_EFUSES is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_IMX_OCOTP_ELE is not set
# CONFIG_NVMEM_JZ4780_EFUSE is not set
# CONFIG_NVMEM_LAN9662_OTPC is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_MTK_EFUSE is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_NVMEM_QCOM_QFPROM is not set
# CONFIG_NVMEM_QCOM_SEC_QFPROM is not set
# CONFIG_NVMEM_RCAR_EFUSE is not set
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_SC27XX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
CONFIG_NVMEM_SPMI_SDAM=m
# CONFIG_NVMEM_SPRD_EFUSE is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_U_BOOT_ENV is not set
# CONFIG_NVMEM_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_NVMEM_QORIQ_EFUSE is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_FPGA_MGR_SOCFPGA is not set
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
# CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
CONFIG_FPGA_MGR_XILINX_CORE=m
CONFIG_FPGA_MGR_XILINX_SELECTMAP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=m
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
# CONFIG_FPGA_MGR_VERSAL_FPGA is not set
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_ASPEED=m
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=m
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
# CONFIG_PECI_NPCM is not set
CONFIG_HTE=y
# CONFIG_HTE_TEGRA194 is not set
# CONFIG_HTE_TEGRA194_TEST is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_EXPERIMENTAL=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_F2FS_UNFAIR_RWSEM=y
CONFIG_BCACHEFS_FS=m
CONFIG_BCACHEFS_QUOTA=y
# CONFIG_BCACHEFS_ERASURE_CODING is not set
# CONFIG_BCACHEFS_POSIX_ACL is not set
# CONFIG_BCACHEFS_DEBUG is not set
CONFIG_BCACHEFS_TESTS=y
# CONFIG_BCACHEFS_LOCK_TIME_STATS is not set
# CONFIG_BCACHEFS_NO_LATENCY_ACCT is not set
# CONFIG_BCACHEFS_PATH_TRACEPOINTS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
CONFIG_NTFS_FS=m
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_NLS_UCS2_UTILS=m
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_PROC_MEM_ALWAYS_FORCE is not set
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
CONFIG_PROC_MEM_NO_FORCE=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,ipe,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Bounds checking
#
# CONFIG_HARDENED_USERCOPY is not set
# end of Bounds checking

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_KRB5ENC=m
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
# end of Random number generation

#
# Userspace interface
#
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM is not set
# CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
# CONFIG_CRYPTO_DEV_S5P is not set
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
# CONFIG_CRYPTO_DEV_MARVELL_CESA is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_420XX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
# CONFIG_CRYPTO_DEV_SA2UL is not set
# CONFIG_CRYPTO_DEV_ASPEED is not set
# CONFIG_CRYPTO_DEV_JH7110 is not set
# CONFIG_CRYPTO_DEV_EIP93 is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
CONFIG_FIPS_SIGNATURE_SELFTEST=y
CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_CRYPTO_KRB5=m
CONFIG_CRYPTO_KRB5_SELFTESTS=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_AESCFB=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_INTERNAL=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519_INTERNAL=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305_INTERNAL=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_CRC_OPTIMIZATIONS=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_ARM64 is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_RISCV is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_CLOSURES=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
CONFIG_DMA_NEED_SYNC=y
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_DIRECT_REMAP=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=10
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_FORCE_NR_CPUS=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
CONFIG_LWQ_TEST=y
# end of Library routines

CONFIG_GENERIC_IOREMAP=y
CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_MULDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_ASN1_ENCODER=m
CONFIG_FIRMWARE_TABLE=y
CONFIG_MIN_HEAP=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_ULEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=0
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VFS is not set
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_DETECT_HUNG_TASK_BLOCKER=y
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CLOSURES=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_CPU_STALL_NOTIFIER is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_RCU_STRICT_GRACE_PERIOD=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# csky Debugging
#
# end of csky Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=m
CONFIG_LKDTM=y
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_DIV64=y
CONFIG_TEST_MULDIV64=m
CONFIG_BACKTRACE_SELF_TEST=m
CONFIG_TEST_REF_TRACKER=y
CONFIG_RBTREE_TEST=m
# CONFIG_REED_SOLOMON_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
CONFIG_TEST_HEXDUMP=m
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_IDA=y
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
CONFIG_TEST_VMALLOC=m
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KALLSYMS is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_OBJPOOL is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

#
# Documentation
#
# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Documentation

--tq/RMBE+tvB0OCVI--

