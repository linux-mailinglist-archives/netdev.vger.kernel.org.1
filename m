Return-Path: <netdev+bounces-204132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C303AF91EF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 13:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A401C807AC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAC2D3A91;
	Fri,  4 Jul 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwY037d4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB92BFC80
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630151; cv=none; b=iSOaTNipsElM10wuqB1YNdLABH5eFBZHUumFo7VycGDYmJ1ge12V5AMKic3jIwlJIlRgNPWvrkPF/oyLqMFZWNScq/KxFDbEuV3Nl02mcw+6rgshlUhatCjEXINGxlpuzQESSgNbBS9AKqM7daGG9a/lyaXZsgYlV6izWgOVTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630151; c=relaxed/simple;
	bh=Xmy7q3NVSgh8uO9N856HZBsWMg9T8BiaUlKDGm3xUiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcsQ6pgw2pId3q77KPxI72AhsRdz3EURtWSEaj/r/vvamNP5Sx4/sPkckKHiF43LwE/Tu9ha3T/jvPwjFawS7emwnAaW383dhHIdYNdVmTNj3NIYcs5R3hTxX5jU1eSrIJMa2MxqS1gdygDO9vV3shuPDG4mvl1LDOEmu2jfIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwY037d4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751630149; x=1783166149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xmy7q3NVSgh8uO9N856HZBsWMg9T8BiaUlKDGm3xUiQ=;
  b=LwY037d4XJMenfnERu7Lh0yHr3VNDXsBKEF+NvhOgLu3KlA5BFynWH8O
   5N/msXHEphHX7JaYEg+3y4BE8EoQBmvOFuxnFS4RffnZ5jbUDomPPgrwe
   PnMXvz6yopiHLgKTQr74++bf1Kul30CKz4d06lx4YaY6mnEjdGuP1+e84
   K+lEp57uognNWu+rnMMXOTLPE7ua4QPalHd7DkAc0kDukaHtXhLnJcKJR
   oM3tiffEaducX0SHxQhivRuZsP0a2FVrgm77e90oZS8WXUpX9+Yg1C2E1
   bl7SRDieaN7tafAdivGtJnMtP+Lq6idKOrLlOFochVCHSmiI/KanUQzsn
   w==;
X-CSE-ConnectionGUID: eyIcUHG1T5akNB666S1Lng==
X-CSE-MsgGUID: pBh1F2XWSKahTldv/XiKdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79404686"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="79404686"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 04:55:49 -0700
X-CSE-ConnectionGUID: h3d1krEoRkWCaF0DpnlAkg==
X-CSE-MsgGUID: AXHSdGV9TfqLq0Whrun0ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="185644638"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Jul 2025 04:55:46 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXf16-0003fL-1Z;
	Fri, 04 Jul 2025 11:55:44 +0000
Date: Fri, 4 Jul 2025 19:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH net-next 3/7] net: mctp: Add test for conflicting bind()s
Message-ID: <202507041923.SYifiPF1-lkp@intel.com>
References: <20250703-mctp-bind-v1-3-bb7e97c24613@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-mctp-bind-v1-3-bb7e97c24613@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8b98f34ce1d8c520403362cb785231f9898eb3ff]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/net-mctp-Prevent-duplicate-binds/20250703-171427
base:   8b98f34ce1d8c520403362cb785231f9898eb3ff
patch link:    https://lore.kernel.org/r/20250703-mctp-bind-v1-3-bb7e97c24613%40codeconstruct.com.au
patch subject: [PATCH net-next 3/7] net: mctp: Add test for conflicting bind()s
config: sparc-randconfig-001-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041923.SYifiPF1-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041923.SYifiPF1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041923.SYifiPF1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mctp/route.c:1538:
>> net/mctp/test/route-test.c:1254:65: warning: 'type1' defined but not used [-Wunused-const-variable=]
    1254 | static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
         |                                                                 ^~~~~
>> net/mctp/test/route-test.c:1254:42: warning: 'bind_addr8_netdefault' defined but not used [-Wunused-const-variable=]
    1254 | static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~


vim +/type1 +1254 net/mctp/test/route-test.c

  1253	
> 1254	static const struct mctp_test_bind_setup bind_addr8_netdefault, type1 = {
  1255		.bind_addr = 8, .bind_net = MCTP_NET_ANY, .bind_type = 1,
  1256	};
  1257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

