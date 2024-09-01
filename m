Return-Path: <netdev+bounces-124002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F396751A
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 07:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57C01C20D1B
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795A2E416;
	Sun,  1 Sep 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f19Zxdf1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E082BAE2
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725167616; cv=none; b=U5aw+mFRlH5uIU39CFYjozd4HnkUP53dvGD37DxNgBsk9v5qy2TmMATjfLCCsJ8ggoMLQQcp/ywifp7zmHTcQLjsO/KGc6cL4bWhljVvOlznUacibhePrVnKfFdac6KO7/Z31esFHqdqoWYMBrMTpZfcEffGIcZRQ+VyvE2gD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725167616; c=relaxed/simple;
	bh=vBLzOaeArm23O3B1rz9IGCO8vmF7nDSf1SXwJh0JR2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIv1jGWmF7s1ISqbvbA/sB3ulvhgpzc9tugli5A386l3A+DLXVAEcvxyg5uAWW0Pzd1jj0Vk1xUrrT/g07VrhMAUrndrqS441NEgV0AebdWrNoF0Ro3GuxLaG7KglBm6IwTXxpsTEur+ulKZrVnmLck1OsXAVLV2TEgHhCqq6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f19Zxdf1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725167614; x=1756703614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vBLzOaeArm23O3B1rz9IGCO8vmF7nDSf1SXwJh0JR2o=;
  b=f19Zxdf1ui/dF9GOzdR6e3rej3rR5a1OKpL+qBmc+aHtPoc3s064U4X4
   uXanyExAEKvprpJRgMaAkt9Nev56I8Tw8PaBZya66syypm+q+8ybKPSuW
   BgNB1dQnvSoAo1vqh5aKFOsgMA/Z+wZPDAnBGmGkih8docNAKzeJBI3wn
   YH0TKJCC4ogjbKAzMzjP3kkr2FfvGCh7kK1W6Z75hODtC9ss1/YmtfIEE
   B4JHFDneKHItt+pgF/Fqy3AUXZ4ikyAs03FB1hgh3BzBJfp9ngUEKuKIN
   OKJ59fsInuO72x6StQo5LQXS2FN7Rbgnzj20gtnjufVAHB3mTZJJR0UD+
   w==;
X-CSE-ConnectionGUID: 8N+GLEHoS96hT3x48XT1xQ==
X-CSE-MsgGUID: y/NVZtvvQeOdGoyr/uCx0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23345203"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="23345203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 22:13:34 -0700
X-CSE-ConnectionGUID: 112NS9kOT2WXM4E8URbPfQ==
X-CSE-MsgGUID: xpOLMG2yQr6NN1I48c7Tgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64771248"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Aug 2024 22:13:32 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skcu1-0003QW-1U;
	Sun, 01 Sep 2024 05:13:29 +0000
Date: Sun, 1 Sep 2024 13:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Tom Herbert <tom@herbertland.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alphonse Kurian <alkurian@amazon.com>
Subject: Re: [PATCH v1 net] fou: Fix null-ptr-deref in GRO.
Message-ID: <202409011200.8BUYJYDh-lkp@intel.com>
References: <20240830234348.16789-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830234348.16789-1-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/fou-Fix-null-ptr-deref-in-GRO/20240831-074603
base:   net/main
patch link:    https://lore.kernel.org/r/20240830234348.16789-1-kuniyu%40amazon.com
patch subject: [PATCH v1 net] fou: Fix null-ptr-deref in GRO.
config: x86_64-randconfig-121-20240901 (https://download.01.org/0day-ci/archive/20240901/202409011200.8BUYJYDh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409011200.8BUYJYDh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409011200.8BUYJYDh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/fou_core.c:53:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/fou_core.c:53:16: sparse:    void [noderef] __rcu *
   net/ipv4/fou_core.c:53:16: sparse:    void *
>> net/ipv4/fou_core.c:53:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/fou_core.c:53:16: sparse:    void [noderef] __rcu *
   net/ipv4/fou_core.c:53:16: sparse:    void *
>> net/ipv4/fou_core.c:53:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/fou_core.c:53:16: sparse:    void [noderef] __rcu *
   net/ipv4/fou_core.c:53:16: sparse:    void *
>> net/ipv4/fou_core.c:53:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/fou_core.c:53:16: sparse:    void [noderef] __rcu *
   net/ipv4/fou_core.c:53:16: sparse:    void *
>> net/ipv4/fou_core.c:53:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/ipv4/fou_core.c:53:16: sparse:    void [noderef] __rcu *
   net/ipv4/fou_core.c:53:16: sparse:    void *

vim +53 net/ipv4/fou_core.c

    50	
    51	static inline struct fou *fou_from_sock(struct sock *sk)
    52	{
  > 53		return rcu_dereference(sk->sk_user_data);
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

