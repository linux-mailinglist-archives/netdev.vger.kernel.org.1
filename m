Return-Path: <netdev+bounces-123768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A5966761
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8E1F25B92
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BB1B9B29;
	Fri, 30 Aug 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgLdHIte"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FC1B8E84;
	Fri, 30 Aug 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036686; cv=none; b=HbBbCwZSRNoB4XMST5ytr1HbjqaxqlXu+jCrBoJ09CuMSBtPjXxmH3kdmQDvkMvlWRUcspolAxS52nndtQoiVkd3SSdIOkXW+HRSdpTz7QoFdirzpxN846FPCi7Sc56iaB1t4CJprvvDaL+6CQ5ewHv+JlDwHgbRv/QQHEFYwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036686; c=relaxed/simple;
	bh=+myL1WenBFtiJ4CShQ4fOJ404kckTowZXne0BXsaq5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0YIqe45EDPlScKw8Zl3FvPtmrP6N2WIcLX4+FRJnnxrzSHMyVwe9jVLhyk+frW9YSQ2MQtEhh8jSrD2HSJMC84mEZyQez0MtTEZUF/dROYYvlyhaCTcWcTnybZR+ur2S7jI+gE1Gu7B4KRE/mfCrc1MlZMDvxnGIpg9Lb7Tirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgLdHIte; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036685; x=1756572685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+myL1WenBFtiJ4CShQ4fOJ404kckTowZXne0BXsaq5Y=;
  b=hgLdHIteD92ytk7+KkON0zAiwUqsDB+Adlmy5PzkLqqq0IBIndJ9xOoo
   U9EAF6p8siUON+MOilyJJqDQM8BXeKwRJGg8Udq3OVDiqphU1poKOIiHc
   ciZmm5qOwlJxUNiKsA4fDrQVay1i7lbubAu4mETDG1QdPftB+rJl6aMyb
   bjrBeOP8ACIPDX1LwK2stJ9jmTySarCVsqkruivzsmBiU3EAzhhQBuPIj
   uDhrNEgQLz2r5ex6iNbia8t/OI6eJh812VRmKpB09Z2pqrLJHZpvDsMf+
   mdJ/bjexgPV3oTaTRhAb+sG1ub4Z9mgJnPbXdsr0LAu8vwNyY6YUOFC1K
   A==;
X-CSE-ConnectionGUID: uqD4aUTTTvWylIxwGRJoyg==
X-CSE-MsgGUID: Txud8P0dRdW9UolDrhqgJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23870852"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23870852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:51:24 -0700
X-CSE-ConnectionGUID: J5hQuGrzQIaRUtKnO0c9mw==
X-CSE-MsgGUID: QGgyDBk7QLiFRYtUHLHV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63649943"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Aug 2024 09:51:19 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4qC-0001fk-2L;
	Fri, 30 Aug 2024 16:51:16 +0000
Date: Sat, 31 Aug 2024 00:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <202408310038.VztWz8YR-lkp@intel.com>
References: <20240829131214.169977-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829131214.169977-2-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/net-napi-Make-napi_defer_hard_irqs-per-NAPI/20240829-211617
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240829131214.169977-2-jdamato%40fastly.com
patch subject: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs per-NAPI
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408310038.VztWz8YR-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310038.VztWz8YR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310038.VztWz8YR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/idpf/idpf_dev.c:4:
   In file included from drivers/net/ethernet/intel/idpf/idpf.h:22:
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: error: static assertion failed due to requirement '__builtin_offsetof(struct idpf_q_vector, __cacheline_group_end__read_write) - (__builtin_offsetof(struct idpf_q_vector, __cacheline_group_begin__read_write) + sizeof ((((struct idpf_q_vector *)0)->__cacheline_group_begin__read_write))) == (424 + 2 * sizeof(struct dim))': offsetof(struct idpf_q_vector, __cacheline_group_end__read_write) - offsetofend(struct idpf_q_vector, __cacheline_group_begin__read_write) == (424 + 2 * sizeof(struct dim))
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     476 |                             424 + 2 * sizeof(struct dim),
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     477 |                             8 + sizeof(cpumask_var_t));
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:62:2: note: expanded from macro 'libeth_cacheline_set_assert'
      62 |         libeth_cacheline_group_assert(type, read_write, rw);                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:17:16: note: expanded from macro 'libeth_cacheline_group_assert'
      17 |         static_assert(offsetof(type, __cacheline_group_end__##grp) -          \
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |                       offsetofend(type, __cacheline_group_begin__##grp) ==    \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |                       (sz))
         |                       ~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: note: expression evaluates to '768 == 760'
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     476 |                             424 + 2 * sizeof(struct dim),
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     477 |                             8 + sizeof(cpumask_var_t));
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:62:2: note: expanded from macro 'libeth_cacheline_set_assert'
      62 |         libeth_cacheline_group_assert(type, read_write, rw);                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:18:59: note: expanded from macro 'libeth_cacheline_group_assert'
      17 |         static_assert(offsetof(type, __cacheline_group_end__##grp) -          \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |                       offsetofend(type, __cacheline_group_begin__##grp) ==    \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      19 |                       (sz))
         |                       ~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   1 error generated.
--
   In file included from drivers/net/ethernet/intel/idpf/idpf_main.c:4:
   In file included from drivers/net/ethernet/intel/idpf/idpf.h:22:
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: error: static assertion failed due to requirement '__builtin_offsetof(struct idpf_q_vector, __cacheline_group_end__read_write) - (__builtin_offsetof(struct idpf_q_vector, __cacheline_group_begin__read_write) + sizeof ((((struct idpf_q_vector *)0)->__cacheline_group_begin__read_write))) == (424 + 2 * sizeof(struct dim))': offsetof(struct idpf_q_vector, __cacheline_group_end__read_write) - offsetofend(struct idpf_q_vector, __cacheline_group_begin__read_write) == (424 + 2 * sizeof(struct dim))
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     476 |                             424 + 2 * sizeof(struct dim),
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     477 |                             8 + sizeof(cpumask_var_t));
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:62:2: note: expanded from macro 'libeth_cacheline_set_assert'
      62 |         libeth_cacheline_group_assert(type, read_write, rw);                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:17:16: note: expanded from macro 'libeth_cacheline_group_assert'
      17 |         static_assert(offsetof(type, __cacheline_group_end__##grp) -          \
         |         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |                       offsetofend(type, __cacheline_group_begin__##grp) ==    \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      19 |                       (sz))
         |                       ~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: note: expression evaluates to '768 == 760'
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     476 |                             424 + 2 * sizeof(struct dim),
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     477 |                             8 + sizeof(cpumask_var_t));
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:62:2: note: expanded from macro 'libeth_cacheline_set_assert'
      62 |         libeth_cacheline_group_assert(type, read_write, rw);                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:18:59: note: expanded from macro 'libeth_cacheline_group_assert'
      17 |         static_assert(offsetof(type, __cacheline_group_end__##grp) -          \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      18 |                       offsetofend(type, __cacheline_group_begin__##grp) ==    \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      19 |                       (sz))
         |                       ~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   drivers/net/ethernet/intel/idpf/idpf_main.c:167:39: warning: shift count >= width of type [-Wshift-count-overflow]
     167 |         err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
         |                                              ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 1 error generated.


vim +475 drivers/net/ethernet/intel/idpf/idpf_txrx.h

4930fbf419a72d Pavan Kumar Linga 2023-08-07  412  
4930fbf419a72d Pavan Kumar Linga 2023-08-07  413  /**
4930fbf419a72d Pavan Kumar Linga 2023-08-07  414   * struct idpf_q_vector
1c325aac10a82f Alan Brady        2023-08-07  415   * @vport: Vport back pointer
5a816aae2d463d Alexander Lobakin 2024-06-20  416   * @num_rxq: Number of RX queues
d4d5587182664b Pavan Kumar Linga 2023-08-07  417   * @num_txq: Number of TX queues
5a816aae2d463d Alexander Lobakin 2024-06-20  418   * @num_bufq: Number of buffer queues
e4891e4687c8dd Alexander Lobakin 2024-06-20  419   * @num_complq: number of completion queues
5a816aae2d463d Alexander Lobakin 2024-06-20  420   * @rx: Array of RX queues to service
1c325aac10a82f Alan Brady        2023-08-07  421   * @tx: Array of TX queues to service
5a816aae2d463d Alexander Lobakin 2024-06-20  422   * @bufq: Array of buffer queues to service
e4891e4687c8dd Alexander Lobakin 2024-06-20  423   * @complq: array of completion queues
5a816aae2d463d Alexander Lobakin 2024-06-20  424   * @intr_reg: See struct idpf_intr_reg
5a816aae2d463d Alexander Lobakin 2024-06-20  425   * @napi: napi handler
5a816aae2d463d Alexander Lobakin 2024-06-20  426   * @total_events: Number of interrupts processed
c2d548cad1508d Joshua Hay        2023-08-07  427   * @tx_dim: Data for TX net_dim algorithm
1c325aac10a82f Alan Brady        2023-08-07  428   * @tx_itr_value: TX interrupt throttling rate
1c325aac10a82f Alan Brady        2023-08-07  429   * @tx_intr_mode: Dynamic ITR or not
1c325aac10a82f Alan Brady        2023-08-07  430   * @tx_itr_idx: TX ITR index
3a8845af66edb3 Alan Brady        2023-08-07  431   * @rx_dim: Data for RX net_dim algorithm
95af467d9a4e3b Alan Brady        2023-08-07  432   * @rx_itr_value: RX interrupt throttling rate
95af467d9a4e3b Alan Brady        2023-08-07  433   * @rx_intr_mode: Dynamic ITR or not
95af467d9a4e3b Alan Brady        2023-08-07  434   * @rx_itr_idx: RX ITR index
5a816aae2d463d Alexander Lobakin 2024-06-20  435   * @v_idx: Vector index
bf9bf7042a38eb Alexander Lobakin 2024-06-20  436   * @affinity_mask: CPU affinity mask
4930fbf419a72d Pavan Kumar Linga 2023-08-07  437   */
4930fbf419a72d Pavan Kumar Linga 2023-08-07  438  struct idpf_q_vector {
5a816aae2d463d Alexander Lobakin 2024-06-20  439  	__cacheline_group_begin_aligned(read_mostly);
1c325aac10a82f Alan Brady        2023-08-07  440  	struct idpf_vport *vport;
1c325aac10a82f Alan Brady        2023-08-07  441  
5a816aae2d463d Alexander Lobakin 2024-06-20  442  	u16 num_rxq;
d4d5587182664b Pavan Kumar Linga 2023-08-07  443  	u16 num_txq;
5a816aae2d463d Alexander Lobakin 2024-06-20  444  	u16 num_bufq;
e4891e4687c8dd Alexander Lobakin 2024-06-20  445  	u16 num_complq;
5a816aae2d463d Alexander Lobakin 2024-06-20  446  	struct idpf_rx_queue **rx;
e4891e4687c8dd Alexander Lobakin 2024-06-20  447  	struct idpf_tx_queue **tx;
5a816aae2d463d Alexander Lobakin 2024-06-20  448  	struct idpf_buf_queue **bufq;
e4891e4687c8dd Alexander Lobakin 2024-06-20  449  	struct idpf_compl_queue **complq;
e4891e4687c8dd Alexander Lobakin 2024-06-20  450  
5a816aae2d463d Alexander Lobakin 2024-06-20  451  	struct idpf_intr_reg intr_reg;
5a816aae2d463d Alexander Lobakin 2024-06-20  452  	__cacheline_group_end_aligned(read_mostly);
5a816aae2d463d Alexander Lobakin 2024-06-20  453  
5a816aae2d463d Alexander Lobakin 2024-06-20  454  	__cacheline_group_begin_aligned(read_write);
5a816aae2d463d Alexander Lobakin 2024-06-20  455  	struct napi_struct napi;
5a816aae2d463d Alexander Lobakin 2024-06-20  456  	u16 total_events;
5a816aae2d463d Alexander Lobakin 2024-06-20  457  
c2d548cad1508d Joshua Hay        2023-08-07  458  	struct dim tx_dim;
1c325aac10a82f Alan Brady        2023-08-07  459  	u16 tx_itr_value;
1c325aac10a82f Alan Brady        2023-08-07  460  	bool tx_intr_mode;
1c325aac10a82f Alan Brady        2023-08-07  461  	u32 tx_itr_idx;
1c325aac10a82f Alan Brady        2023-08-07  462  
3a8845af66edb3 Alan Brady        2023-08-07  463  	struct dim rx_dim;
95af467d9a4e3b Alan Brady        2023-08-07  464  	u16 rx_itr_value;
95af467d9a4e3b Alan Brady        2023-08-07  465  	bool rx_intr_mode;
95af467d9a4e3b Alan Brady        2023-08-07  466  	u32 rx_itr_idx;
5a816aae2d463d Alexander Lobakin 2024-06-20  467  	__cacheline_group_end_aligned(read_write);
95af467d9a4e3b Alan Brady        2023-08-07  468  
5a816aae2d463d Alexander Lobakin 2024-06-20  469  	__cacheline_group_begin_aligned(cold);
5a816aae2d463d Alexander Lobakin 2024-06-20  470  	u16 v_idx;
bf9bf7042a38eb Alexander Lobakin 2024-06-20  471  
bf9bf7042a38eb Alexander Lobakin 2024-06-20  472  	cpumask_var_t affinity_mask;
5a816aae2d463d Alexander Lobakin 2024-06-20  473  	__cacheline_group_end_aligned(cold);
4930fbf419a72d Pavan Kumar Linga 2023-08-07  474  };
5a816aae2d463d Alexander Lobakin 2024-06-20 @475  libeth_cacheline_set_assert(struct idpf_q_vector, 104,
5a816aae2d463d Alexander Lobakin 2024-06-20  476  			    424 + 2 * sizeof(struct dim),
5a816aae2d463d Alexander Lobakin 2024-06-20  477  			    8 + sizeof(cpumask_var_t));
0fe45467a1041e Pavan Kumar Linga 2023-08-07  478  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

