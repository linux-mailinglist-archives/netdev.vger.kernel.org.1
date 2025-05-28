Return-Path: <netdev+bounces-194018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE04AC6D47
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547601BC7BBE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAFA28CF45;
	Wed, 28 May 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EW3dVrLt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5928C864;
	Wed, 28 May 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447911; cv=none; b=Yh+7uPSDYxElEsjSWjl659pjSWbQz1C9xjvyC9fAGO/g2CskW4smmfi7Mv4xm6NE6zsRjDfNH3Y+wtaBjtKt0y+LUB5XokcQpRn877AoPwOBAqfuWvSzSt3EqU78JAAZHadhO2b5LJ1/rLNP7sVz3UrsjnKN56lP/SZ/9SKv6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447911; c=relaxed/simple;
	bh=jQ1GOT+yh1Z61cRE9ycQmcM+5PDeTXfT6DSI9iMG7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7WTWVTS8Y5CI6NPMM1yJ293604tPtaXuqA8Q38vOv+b34EnG86Nxk8mFpEZxOJAGyPI71+wRaSidV8TZ4H/N7pRjkGhnVzPzbMvJ1kJ2gKpjanCfaDgqxs9nh8tITYHERqTy0hgh5vUb2u9jb9fpwsLpFCBdTRUT1U0VQKxgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EW3dVrLt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447910; x=1779983910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQ1GOT+yh1Z61cRE9ycQmcM+5PDeTXfT6DSI9iMG7MA=;
  b=EW3dVrLtbpUPzSO7v+1XHiRsjEIiMuOAztH+3s07Y+nnrIdE/QDAtNEi
   yVutIGP7eXbWheH2dOlTFcMsKEsEojriyrHZYIxXO7a4Qh3AkagxlHEM9
   Bb+uZcL4M0exKq2bHp7DKxr1Cu0ADi5M6eRX2FJCKfC5uGjVU8cMO1jEo
   htSLDkJ+59MQJm2Jdhh37PmHpRYWsIAFS4Q/H2KmqpVGbQdMu8yWUonbq
   y+z/kA20UHF+VuLTwIziP+Czo5HcUUy2UZgws7AsBMe6c5uyhfHuINMvQ
   9GrdEPlDrnEEfF51leDkVj2SeGH4z1Gu9H+iczukRBx3uW+6mfrDJKDiw
   w==;
X-CSE-ConnectionGUID: E6DM9eaWQaG1g0v4kDV0QA==
X-CSE-MsgGUID: ex8vJjGCS3iTnI23eUpEiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="60740128"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="60740128"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:58:29 -0700
X-CSE-ConnectionGUID: 7vNOD3ErRAaVAEJcQ5OGBA==
X-CSE-MsgGUID: DTfw/s/YRguYfCNhsp5rkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148140975"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2025 08:58:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKJAZ-000Vow-2h;
	Wed, 28 May 2025 15:58:19 +0000
Date: Wed, 28 May 2025 23:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page
 pool
Message-ID: <202505282311.lZqpYSc9-lkp@intel.com>
References: <20250528022911.73453-17-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528022911.73453-17-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on d09a8a4ab57849d0401d7c0bc6583e367984d9f7]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-struct_group_tagged-ed-on-struct-net_iov/20250528-103136
base:   d09a8a4ab57849d0401d7c0bc6583e367984d9f7
patch link:    https://lore.kernel.org/r/20250528022911.73453-17-byungchul%40sk.com
patch subject: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page pool
config: i386-buildonly-randconfig-004-20250528 (https://download.01.org/0day-ci/archive/20250528/202505282311.lZqpYSc9-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505282311.lZqpYSc9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505282311.lZqpYSc9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/sdio_txrx.c:74:3: error: must use 'struct' tag to refer to type 'page'
      74 |                 page = netmem_compound_head(virt_to_netmem(data));
         |                 ^
         |                 struct 
>> drivers/net/wireless/mediatek/mt76/sdio_txrx.c:74:8: error: expected identifier or '('
      74 |                 page = netmem_compound_head(virt_to_netmem(data));
         |                      ^
   2 errors generated.


vim +74 drivers/net/wireless/mediatek/mt76/sdio_txrx.c

    58	
    59	static struct sk_buff *
    60	mt76s_build_rx_skb(void *data, int data_len, int buf_len)
    61	{
    62		int len = min_t(int, data_len, MT_SKB_HEAD_LEN);
    63		struct sk_buff *skb;
    64	
    65		skb = alloc_skb(len, GFP_KERNEL);
    66		if (!skb)
    67			return NULL;
    68	
    69		skb_put_data(skb, data, len);
    70		if (data_len > len) {
    71			netmem_ref netmem;
    72	
    73			data += len;
  > 74			page = netmem_compound_head(virt_to_netmem(data));
    75			skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
    76					       netmem, data - netmem_address(netmem),
    77					       data_len - len, buf_len);
    78			get_netmem(netmem);
    79		}
    80	
    81		return skb;
    82	}
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

