Return-Path: <netdev+bounces-271832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIWQO1O6xGnG2wQAu9opvQ
	(envelope-from <netdev+bounces-271832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:47:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63B32F23C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9F0301A153
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541C33065D;
	Thu, 26 Mar 2026 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gfn5UoLb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF31F30AD;
	Thu, 26 Mar 2026 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774500431; cv=none; b=s1k/dHyowTJ/lOpexYB1oVN86oa8wll4W9MmoGiqGlE653oW/JJkS/wpdxOsTrWvP37CyuS8+0e/DwT8LeyarcRKDe+QPekLLUX35F7m19Z7mStDOaRMV3NOylyZAYOBlgz2+GCl8UGs+m1iTp4CIWKsaJJ9KTq8rk/PhAsvqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774500431; c=relaxed/simple;
	bh=4kecC/ZYRctGwc1EBoI2M9d2EI/JOraZdYPDLhVU7N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3p0AlBtsEldhdtWdQlrZGsTZGF/XRRvxWbWrarPxo1/YhTRhZYZZlI367yuRB+Z3c5o3pXgIK2rZbKH261DlFExyfBGI/wnOzG7dHBpJvzsoN/orGz4vhPgiH86dxnjhjmLTajbZdLn2StXic7F3BAosX9LQGCTWHw4agsZDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gfn5UoLb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774500429; x=1806036429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kecC/ZYRctGwc1EBoI2M9d2EI/JOraZdYPDLhVU7N4=;
  b=Gfn5UoLbyToofK5u3ca6EyVoPXuEj5aT1kM0mZmVTT1/P9m4TFd5yBrt
   4pilbMuf01Gy2K07VaWjtD10I9jaVYhei8MLhSgsPsCZxAQ/pExEGoQlM
   Ww3zXPDHa16WVV9K6XREeSaXcqtnwjcR7s+uRsOuWvrJKQ74G6YftC50S
   jUIRIUQrZJSqp70e/RCwNJDAzX38c7Hasq18/1YIpgotO7KR6rwb58i+F
   vXiGpsFTz7zgPbtWerYCn1bgKda1a40xvmm1okdKVQrRd7Qu4ki/L/2sd
   wWRzLKuFk0dMRqUAVdR+XJqmcnX4xxC4APVjUInHwZDwcElv3SP5zUndx
   w==;
X-CSE-ConnectionGUID: osJ6xDHGSAGHoXBTbo3ELA==
X-CSE-MsgGUID: 9T7/eciLRtGJbBywAzGibw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="79405915"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="79405915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 21:47:07 -0700
X-CSE-ConnectionGUID: pA6lh0FbS1ic8TAYZDDWng==
X-CSE-MsgGUID: o8y9BNqDTqGu83pX6I8NFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221996191"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Mar 2026 21:47:05 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5ccY-000000008Aj-0QEX;
	Thu, 26 Mar 2026 04:47:02 +0000
Date: Thu, 26 Mar 2026 12:46:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, dong100@mucse.com
Subject: Re: [PATCH net-next 4/4] net: rnpgbe: Add link status handling
 support
Message-ID: <202603261216.IjF1gt9b-lkp@intel.com>
References: <20260325091204.94015-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325091204.94015-5-dong100@mucse.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271832-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 6A63B32F23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dong-Yibo/net-rnpgbe-Add-interrupt-handling/20260326-025137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260325091204.94015-5-dong100%40mucse.com
patch subject: [PATCH net-next 4/4] net: rnpgbe: Add link status handling support
config: x86_64-randconfig-002-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261216.IjF1gt9b-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261216.IjF1gt9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261216.IjF1gt9b-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c:233 function parameter 'is_report' not described in 'mucse_mbx_link_report'
>> Warning: drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c:313 function parameter 'hw' not described in 'mucse_mbx_fw_req_handler'
>> Warning: drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c:233 function parameter 'is_report' not described in 'mucse_mbx_link_report'
>> Warning: drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c:313 function parameter 'hw' not described in 'mucse_mbx_fw_req_handler'
--
>> Warning: drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c:1888 expecting prototype for mucse_watchdog_subtask(). Prototype was for rnpgbe_watchdog_subtask() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

