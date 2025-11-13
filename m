Return-Path: <netdev+bounces-238196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7809C55B87
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70FB3AF341
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAA302769;
	Thu, 13 Nov 2025 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eactovy9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26A3016F3;
	Thu, 13 Nov 2025 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009667; cv=none; b=TWiCCJwq1bVU2qI8zj8sv9aOP+GkueBpbJjmuEvvSD+SNMzhfLD8uyTKVEtOzuXuTKiNmu6x3p7Z7+SU5AAMse9OHuJwR6j9frxa9s4DizG1xukNehIuKIIMtnAnnJ/iI6imxOyPlGI6nbe6Sm5kTxwI5Ayyf1mBcvHc/v4wD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009667; c=relaxed/simple;
	bh=c000Mp0KufLdK+efL1V7k6e8Ls1vyJ/S+kmTktGDTxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+6yDfmXXumuaJvXrGlFgAm31MPoMzUzhbNtBU6MoejGkyaAexrTAnrkyH/QMVomp09qsBWZJraS+4L1MjWgxs2nCNhNDIylc3uDvOpOLhf2cEqWLhNoJMyhojvsJBBKONJpQU9jn2yMiUFkmlD2HZf12cEavlrS2hWXKZd+Kpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eactovy9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009667; x=1794545667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c000Mp0KufLdK+efL1V7k6e8Ls1vyJ/S+kmTktGDTxA=;
  b=eactovy9r90EEBEItrlvUlJY//ShslZy/vkP2y9uBRMRXYKTrV7PbaPo
   8WoU1fGzx7sISYsJ55IyBE+UhqUcX3TbQR6XjISk0N79XPE8b9ZCzE2e0
   u1H0ht2E4lm/Tgar1/8SbXbFdKCkwE8dWQb0mHSuOCtv0JYtDO2YFWvYM
   Gudlp3fLCuVwczCoEcy4uzmd8RD8Xl5iE5zZjX8XK+Wag5y2XcuOMhhDN
   TZGTFPX986/4wNwxJqWTjPtOtWIcSZuoNhDmqEg3VqcoPdJ4Xyf/L61E+
   CUJ4q5xUQiGyubgXaMQVKzDzY/MNM+1NQKDAi2tLPbsUbrB5D5ltAUEm3
   A==;
X-CSE-ConnectionGUID: NDRa5qngRJe5Oxn915ncWg==
X-CSE-MsgGUID: d2cpW5WaRIaYEvZvhMpBgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82480174"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82480174"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:54:26 -0800
X-CSE-ConnectionGUID: gjl0XeHTT22N/5+EdfNq0A==
X-CSE-MsgGUID: p2MImfxWRcmaOQ69F4l0EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189415501"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 20:54:22 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPLf-0004uh-27;
	Thu, 13 Nov 2025 04:54:19 +0000
Date: Thu, 13 Nov 2025 12:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 05/12] bng_en: Add TX support
Message-ID: <202511131255.uExsPeUo-lkp@intel.com>
References: <20251111205829.97579-6-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111205829.97579-6-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Query-PHY-and-report-link-status/20251112-050616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251111205829.97579-6-bhargava.marreddy%40broadcom.com
patch subject: [net-next 05/12] bng_en: Add TX support
config: arc-randconfig-r122-20251113 (https://download.01.org/0day-ci/archive/20251113/202511131255.uExsPeUo-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131255.uExsPeUo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131255.uExsPeUo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:717:11: sparse: sparse: symbol 'bnge_lhint_arr' was not declared. Should it be static?
   drivers/net/ethernet/broadcom/bnge/bnge_txrx.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h):
   include/linux/skbuff.h:2888:28: sparse: sparse: unsigned value that used to be signed checked against zero?
   include/linux/skbuff.h:2888:28: sparse: signed value source

vim +/bnge_lhint_arr +717 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c

   716	
 > 717	const u16 bnge_lhint_arr[] = {
   718		TX_BD_FLAGS_LHINT_512_AND_SMALLER,
   719		TX_BD_FLAGS_LHINT_512_TO_1023,
   720		TX_BD_FLAGS_LHINT_1024_TO_2047,
   721		TX_BD_FLAGS_LHINT_1024_TO_2047,
   722		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   723		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   724		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   725		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   726		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   727		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   728		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   729		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   730		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   731		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   732		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   733		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   734		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   735		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   736		TX_BD_FLAGS_LHINT_2048_AND_LARGER,
   737	};
   738	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

