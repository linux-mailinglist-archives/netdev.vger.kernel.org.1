Return-Path: <netdev+bounces-131012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E0398C60D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAEF1F226A0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0851CCEFD;
	Tue,  1 Oct 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG/s2VU4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DC1CC174
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811162; cv=none; b=gf0kM8L8fFhdbfOy00kQw17Rzy8C3MakZGTfUboj0xbaVhE7f32XQzpR0pW6OwqZED8APWJgzx5MfuIL4aR/SJzBm36xKhe+WnobFswwQtZeCb97tE8QBP9coERGt9Jr/PEh6J9ebrTTvZnpkrn5ORDA4TrhkHWHjDPuvFcfOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811162; c=relaxed/simple;
	bh=XQphB0fQXyUbHkXTg2+GtyhboKN0s6dA0sD5GcIBfcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwGNcczGRuTusBL4CmxnwqBEB83IX2TC8Xjzn9wdg0hj27w5KJnrcV73NK53wPzQ+4cnbvHxqbI3LAUG23ZAMULSLrnqkdLztbcVxe4PiXpIxUYsMrPPRBavW5PWB8+2Lox8EvWKPvObkvSIr2GOe7c8nlvkC2DkFwO92ZPXn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG/s2VU4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727811161; x=1759347161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQphB0fQXyUbHkXTg2+GtyhboKN0s6dA0sD5GcIBfcI=;
  b=MG/s2VU4VVYYuW9qEHDNajAZEec4XeFgutxWueS8O1lPLAzy3EHCXx0o
   CaGY5SQZrnoCjxvGUk0tQ0vorxsmpybqqjTDijBF+cB2Y/jDDqaJhfZll
   sFbO1yMiaJMR698a0U+WbzgVVwDQO/90D2llOQevLqmd7nIZITJfRH5ia
   AhgmTh6m8uD2RMrN4T6zpSIr4XP8Wevk7rvkbuHGh4QE4BVDq1H9lsAwe
   ngpbdCDFptiXo4M2ponBuHHXTzNy/JvWUzaoufibjHxVaRbjZyJZ9bNou
   Vv8I97KlgN4z4iRK9ut0ws2j4w73FpqH7dKVlnkrzcVLACzsw1Ve/GLDt
   A==;
X-CSE-ConnectionGUID: 58p9QSQ3Su+VxIl+exf/sQ==
X-CSE-MsgGUID: /Vz/rOnwRSW4iNEaZZck3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27140487"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27140487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 12:32:40 -0700
X-CSE-ConnectionGUID: C4Kq/ybPSmCXJ8T3awZTyQ==
X-CSE-MsgGUID: 6dogTQ44T2GlId277Cclyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73438000"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Oct 2024 12:32:38 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svibr-000R6D-2X;
	Tue, 01 Oct 2024 19:32:35 +0000
Date: Wed, 2 Oct 2024 03:32:30 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 4/5] ipv4: Retire global IPv4 hash table
 inet_addr_lst.
Message-ID: <202410020334.VOgHq3VG-lkp@intel.com>
References: <20241001024837.96425-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001024837.96425-5-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv4-Link-IPv4-address-to-per-net-hash-table/20241001-105607
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241001024837.96425-5-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 4/5] ipv4: Retire global IPv4 hash table inet_addr_lst.
config: x86_64-randconfig-122-20241001 (https://download.01.org/0day-ci/archive/20241002/202410020334.VOgHq3VG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020334.VOgHq3VG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020334.VOgHq3VG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/devinet.c:124:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] addr @@
   net/ipv4/devinet.c:124:24: sparse:     expected unsigned int [usertype] val
   net/ipv4/devinet.c:124:24: sparse:     got restricted __be32 [usertype] addr

vim +124 net/ipv4/devinet.c

   121	
   122	static u32 inet_addr_hash(const struct net *net, __be32 addr)
   123	{
 > 124		return hash_32(addr, IN4_ADDR_HSIZE_SHIFT);
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

