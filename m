Return-Path: <netdev+bounces-100792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37648FC0D4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218161C208CE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE2B640;
	Wed,  5 Jun 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgXHt5SF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D3944D;
	Wed,  5 Jun 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547375; cv=none; b=O/E7Sf66mT1kzTF8Sx4rWpbGZVzos2wazU+gzNw7HJWS0tlX4BAFklFhoCC/VN0p4FhY5SLq4xnTl9nKIRcN5RKKAccE8seGOMrGyEloKEzX4L6HIVjU8j9wFhvpKhfXk54i1Tq9dIYO0W+dhfwrazxVZrv+pYTUC5KVw67+2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547375; c=relaxed/simple;
	bh=TY+ZzDSLxMX2DBv+6OsKEQ4VA6EI1NW1sVZ8duIxLtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR0953QmxXQ1qqGImHVAigNm8TQq3LCPWebIzo6MJoy/YBQGYIriu2jSrenPkgZgBzBS9xbRc6EBTI7stIDRBdwdr3Vwi7djBBrMLVz0XtdGXq4MkUgJK4OWxzzdas5cgXj7AMholSeqYCc+N1NMKkyKDckDmmKH16lJ1C57nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgXHt5SF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717547373; x=1749083373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TY+ZzDSLxMX2DBv+6OsKEQ4VA6EI1NW1sVZ8duIxLtU=;
  b=QgXHt5SFu8NgDx9ro6RVl627Lx0E+UoWQv2LXZmoDgM0zeaxS3LiWLye
   2rC+wagk/psUFDg0JFYZtRg7lLGBlvt/coCTZBNtQLtlIBD3v+odTMINk
   cCjAfkuWqeIc5vUTj1AQX0YL/ZZEhOmXAKgfbXr2Tfs4LqxRS0abRDNb6
   upfgVb0pSRzCrF5n/BJmHlGDiFV1PlSUmSQ3afhaTEg3Dom+Gf8AeSu6g
   WcL3ODFPbnw+kBtdZWjreiGi6ROZI0SD11hgLs/csPgmg1jnppTmjwDwP
   LGyU9PN83KUTkBxdcSS7uG+UqxgeEeTSCxAiu/nuUVzb7yIY48lYnXGfy
   g==;
X-CSE-ConnectionGUID: XnFhLHNrRtG+crDYZMaI3g==
X-CSE-MsgGUID: J/HZ2jAzSmijeQ4bHcJhgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25534139"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25534139"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 17:29:32 -0700
X-CSE-ConnectionGUID: K5YfX7b3Qc+yFqaiCZCwPQ==
X-CSE-MsgGUID: 9rNNaSDJSJ+98vPxqvq9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="60598970"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2024 17:29:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEeWs-0000iL-05;
	Wed, 05 Jun 2024 00:29:26 +0000
Date: Wed, 5 Jun 2024 08:29:22 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, aconole@redhat.com,
	echaudro@redhat.com, horms@kernel.org, i.maximets@ovn.org,
	dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
Message-ID: <202406050852.hDtfskO0-lkp@intel.com>
References: <20240603185647.2310748-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-6-amorenoz@redhat.com>

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240603185647.2310748-6-amorenoz%40redhat.com
patch subject: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
config: s390-randconfig-002-20240605 (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050852.hDtfskO0-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
>> actions.c:(.text+0x1d5c): undefined reference to `psample_sample_packet'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

