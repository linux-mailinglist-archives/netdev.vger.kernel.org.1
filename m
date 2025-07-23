Return-Path: <netdev+bounces-209324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06708B0F14A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4537B2D12
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED06A2E543A;
	Wed, 23 Jul 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kjcah5zH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF422E49BE;
	Wed, 23 Jul 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270510; cv=none; b=e2MQacE0WnrqsOoydjKkREqgWxcJKAthPb55OhkQJ1t8CTYK2FybYd0TCJoXIMwIVGMpbAOkRrLyCxLuMs/vC9CB4Rk446GO0v3G6Y3MMV5ebNuo+dKemcAjpHSiH/EsCbZX7nAig+t3xx6W5tDiJ1YNzQxL5lddjp2S6zhM96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270510; c=relaxed/simple;
	bh=NaqnBjwkXIQgRY6bvzvyQHA4TyoMVW07CLlzipyiNSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3RLFY5zMqv4qy2a57/h70YpJ+FGsV7m7KYa360rKT1EEBD+qFb9Q1GHSVU2Gv12oOyHNCI5IEOYSryCivz7KrD54axmabJaIUqlU451yHOutEKqyxyBVG58Uvw6aeuEOIeTS9G9dGASB4H85wYrWK7MmKG+n4RKbaW5gMSHZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kjcah5zH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753270510; x=1784806510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaqnBjwkXIQgRY6bvzvyQHA4TyoMVW07CLlzipyiNSc=;
  b=Kjcah5zHwh6bN0B6C76Q32zBPhG8lGgwHihSm0NyBRZncs0mk1oX9Tbt
   Ge2Xv20ykJYMR706t/9g00Ak6PxSvncOxLv/tGyj1Gf4jroSBAsPogOpQ
   6FX51/cfY6kJT2R1TXiIO/1Y2EA/AQHvmChmLxrjWruIRLf5i9h1F7A6b
   +DrrHkJSN0bDBJJS+OMmFGv+Hq9/Pe74wdorUhyalZEHuAhlfzg4W8sIs
   k4bHuz30ucRHbBwyqBIgIP6f6ebJuKwJxxgtnNmxJ2aaJlBt0zJX6HouH
   VwGKuaXP+4rstH/hQ2pCQC9PD7PXEUmKqzGV8sThaWp0xoPUaY/5d2RDe
   w==;
X-CSE-ConnectionGUID: 2IA6dQgcQPSsGx1rGoHlZw==
X-CSE-MsgGUID: O3Psr69OQc+rJ9x6diaTeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55505001"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55505001"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 04:35:09 -0700
X-CSE-ConnectionGUID: TR6FWWC9SVmfojcgdHvLRg==
X-CSE-MsgGUID: AsjbwzVhTyeUC7pzLlASzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164892580"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jul 2025 04:35:02 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueXkS-000JJx-17;
	Wed, 23 Jul 2025 11:35:00 +0000
Date: Wed, 23 Jul 2025 19:34:58 +0800
From: kernel test robot <lkp@intel.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Fu Guiming <fuguiming@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <202507231813.7ti3bdJj-lkp@intel.com>
References: <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>

Hi Fan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e95c0a3a55aea490420bd6994805edb050cc86b]

url:    https://github.com/intel-lab-lkp/linux/commits/Fan-Gong/hinic3-Async-Event-Queue-interfaces/20250722-152434
base:   5e95c0a3a55aea490420bd6994805edb050cc86b
patch link:    https://lore.kernel.org/r/bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1%40h-partners.com
patch subject: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250723/202507231813.7ti3bdJj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231813.7ti3bdJj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507231813.7ti3bdJj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:77:17: warning: variable 'cb_state' set but not used [-Wunused-but-set-variable]
      77 |         unsigned long *cb_state;
         |                        ^
   drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:91:17: warning: variable 'cb_state' set but not used [-Wunused-but-set-variable]
      91 |         unsigned long *cb_state;
         |                        ^
   drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:127:17: warning: variable 'cb_state' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long *cb_state;
         |                        ^
   3 warnings generated.


vim +/cb_state +77 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c

    71	
    72	int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
    73				   enum hinic3_aeq_type event,
    74				   hinic3_aeq_event_cb hwe_cb)
    75	{
    76		struct hinic3_aeqs *aeqs;
  > 77		unsigned long *cb_state;
    78	
    79		aeqs = hwdev->aeqs;
    80		cb_state = &aeqs->aeq_cb_state[event];
    81		aeqs->aeq_cb[event] = hwe_cb;
    82		spin_lock_init(&aeqs->aeq_lock);
    83	
    84		return 0;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

