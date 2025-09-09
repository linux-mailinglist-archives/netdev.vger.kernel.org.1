Return-Path: <netdev+bounces-221064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E0B4A096
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 06:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56733A5B88
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB422E0B73;
	Tue,  9 Sep 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpqBSn5h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7522C3257;
	Tue,  9 Sep 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391711; cv=none; b=o9BHxd0N7qbvRfzNjc4Nk0TGgeLSW+DsyXKiRjjP4dBob7X3GkTYPy80Wa7dtKsW0b2ngbF8lp6ykkdqLthCXYwm/W8aHSMLE7akBf02YbxpjvByEx4En8f55+bIjE1WAOyCsraawPZQ4aYifpS5n1963q3agjGkguvT+4z/Gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391711; c=relaxed/simple;
	bh=u2eWVDfOjZ/eUZU18XVmgcF0dNk+tPxSOkUryUdg0+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJc/8j7Xt/vNXHjIhCOzBNZ445I534pPOPVa6oACJTObRAbcarLzfebm344pmC4d3vAfDbW8u30VEFIqlzHjEd5kBVoeqhnhbirjjBO9McMJ6FvsatEaH8t1VFhLH1a1OVkrN9YlNv+Oxs11R3/cY7qti+TKrwDR7YyOHs6m8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpqBSn5h; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757391709; x=1788927709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2eWVDfOjZ/eUZU18XVmgcF0dNk+tPxSOkUryUdg0+k=;
  b=FpqBSn5hwkPZVYmI5XKFDCmp73o8rH4ztJbkJocgi5N6BxV8HxmoeK5s
   fzYqFTppRp9i2EZNGEWkFXFHWkLVKqsK0TA2Raja8YkTWDVBfNwMrl8+Q
   YiLyYRwhXjb4db1Y7LHG7XkhkjFHy6k+XuMlowbX0SCA7W00W4dEY9A+9
   LZwdc+cdH10ljKjAKjeiqdFH5vCqe1bcjhotQ/TsBHlR2sLVbZ3Gnc/HX
   zPIWciPZRUWr4KN71k0zC47RALvpPTngls6mZxuHQNlj1fLFa3EYXQ/7B
   La4Y5XA5rq1fw88XbEuQYJOXn7YDnUuX3DKOUqvNVWmEaXTiyQ2VdjE61
   Q==;
X-CSE-ConnectionGUID: 3egONS/oTpWYkpyTIBFt2w==
X-CSE-MsgGUID: ySm2J2+cSKu48PKxqPaNog==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="69920328"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="69920328"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 21:21:49 -0700
X-CSE-ConnectionGUID: rCcz4ynoSY2VL8BqXW/FiQ==
X-CSE-MsgGUID: 2PP/FEzCTmSJGEBnXH18aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="196622451"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Sep 2025 21:21:44 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvprR-0004Qf-1j;
	Tue, 09 Sep 2025 04:21:41 +0000
Date: Tue, 9 Sep 2025 12:20:46 +0800
From: kernel test robot <lkp@intel.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH net-next v10 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <202509091137.JnioPegN-lkp@intel.com>
References: <20250908-net-k1-emac-v10-2-90d807ccd469@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-net-k1-emac-v10-2-90d807ccd469@iscas.ac.cn>

Hi Vivian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 062b3e4a1f880f104a8d4b90b767788786aa7b78]

url:    https://github.com/intel-lab-lkp/linux/commits/Vivian-Wang/dt-bindings-net-Add-support-for-SpacemiT-K1/20250908-203917
base:   062b3e4a1f880f104a8d4b90b767788786aa7b78
patch link:    https://lore.kernel.org/r/20250908-net-k1-emac-v10-2-90d807ccd469%40iscas.ac.cn
patch subject: [PATCH net-next v10 2/5] net: spacemit: Add K1 Ethernet MAC
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250909/202509091137.JnioPegN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509091137.JnioPegN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509091137.JnioPegN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'emac_get_stat_tx_dropped',
       inlined from 'emac_get_stats64' at drivers/net/ethernet/spacemit/k1_emac.c:1234:24:
>> drivers/net/ethernet/spacemit/k1_emac.c:1218:24: warning: 'result' is used uninitialized [-Wuninitialized]
    1218 |                 result += READ_ONCE(per_cpu(*priv->stat_tx_dropped, cpu));
         |                        ^~
   drivers/net/ethernet/spacemit/k1_emac.c: In function 'emac_get_stats64':
   drivers/net/ethernet/spacemit/k1_emac.c:1214:13: note: 'result' was declared here
    1214 |         u64 result;
         |             ^~~~~~


vim +/result +1218 drivers/net/ethernet/spacemit/k1_emac.c

  1211	
  1212	static u64 emac_get_stat_tx_dropped(struct emac_priv *priv)
  1213	{
  1214		u64 result;
  1215		int cpu;
  1216	
  1217		for_each_possible_cpu(cpu) {
> 1218			result += READ_ONCE(per_cpu(*priv->stat_tx_dropped, cpu));
  1219		}
  1220	
  1221		return result;
  1222	}
  1223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

