Return-Path: <netdev+bounces-86647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3D89FB6A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4945285212
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C316F0CE;
	Wed, 10 Apr 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IO/8lLbB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773616EC18
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762598; cv=none; b=QP+D0E30FufdHBZUMEo+vCgGWuk9Ms7cqW4M8SoNA2DDDRtylnHOzzwUp9EmxOK2reQ38De/uuac7/IjPtAZmCVyq0Et2F/j62XTlcHxtFUZvZkX2VsMYPL/PyrdCy7H7NtG+bjQEOdq/vRz5b2nNEXiMZIN0xF6aPl+x5bIhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762598; c=relaxed/simple;
	bh=VQ/GfqrL5AkxSHgXkurKnOzHHPNc6m9XV9Z986Z9VD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRnFw1iuSzfGwRpkGzn7en1uIzWFFIVwx21eiEb+++BSWOZzKmyAqs+PQndyUd9AInD2v7Z7EYCKcYa6aiUWpsJ1doeynlsB0aaAvgQb121DL+100pjNRuA9i7sAiHdzlNdPorUe5FlJKuEstcm8sjsy+6rZF/DuW87IuM9TpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IO/8lLbB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712762597; x=1744298597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VQ/GfqrL5AkxSHgXkurKnOzHHPNc6m9XV9Z986Z9VD8=;
  b=IO/8lLbBdZR0E0jJSgdtPjzoXk1+SAuLG7TbPsAL/67bNk9BIdFFkOOM
   p/8wHUOiQFw9SpOlDb7ru5URyF4YVUAx66EUBTbHIuX2Vx0lg+9pHNFMk
   wy+vXoStE5swd9TATg8KOzesocgFYURvOxzOMwcTeM9okX+7J9IxFX1Ll
   h/7Fm24bYc6XeXzCaYcPRAkhLYOqW6uM43lXsZzmXt6iDpN6GnzK+SlZB
   hltgm09sTYTfLYT1O29oNQ5zwvwZXJLKFozF/4q3abHKmxOxspA0BNAB/
   qXMmLUfqWJi7m9R0FV31Apt3+h+WIjYCPypFwRQZn71zL149VWkBXlpxm
   Q==;
X-CSE-ConnectionGUID: gfP63ZerSm60DeNvRj7q2w==
X-CSE-MsgGUID: yPqbqHwkQJe9PG2WkKMyww==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19559866"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19559866"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 08:23:17 -0700
X-CSE-ConnectionGUID: 2uwP0iojTkqWn19aDX7hDw==
X-CSE-MsgGUID: to1heVCeToGWFx305hCQGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43852820"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2024 08:23:13 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruZn5-0007WS-2A;
	Wed, 10 Apr 2024 15:23:11 +0000
Date: Wed, 10 Apr 2024 23:22:14 +0800
From: kernel test robot <lkp@intel.com>
To: zijianzhang@bytedance.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	kuba@kernel.org, cong.wang@bytedance.com, xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
Message-ID: <202404102247.qzN9N0Il-lkp@intel.com>
References: <20240409205300.1346681-2-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409205300.1346681-2-zijianzhang@bytedance.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/zijianzhang-bytedance-com/sock-add-MSG_ZEROCOPY_UARG/20240410-045616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240409205300.1346681-2-zijianzhang%40bytedance.com
patch subject: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
config: x86_64-randconfig-r081-20240410 (https://download.01.org/0day-ci/archive/20240410/202404102247.qzN9N0Il-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404102247.qzN9N0Il-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404102247.qzN9N0Il-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/un.h:5:
>> usr/include/linux/socket.h:45:2: error: unknown type name '__u32'
      45 |         __u32 lo;
         |         ^
   usr/include/linux/socket.h:46:2: error: unknown type name '__u32'
      46 |         __u32 hi;
         |         ^
>> usr/include/linux/socket.h:47:2: error: unknown type name '__u8'
      47 |         __u8 zerocopy;
         |         ^
   3 errors generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/socket.h:45:2: error: unknown type name '__u32'
      45 |         __u32 lo;
         |         ^
   ./usr/include/linux/socket.h:46:2: error: unknown type name '__u32'
      46 |         __u32 hi;
         |         ^
>> ./usr/include/linux/socket.h:47:2: error: unknown type name '__u8'
      47 |         __u8 zerocopy;
         |         ^
   3 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

