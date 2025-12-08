Return-Path: <netdev+bounces-243973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDBCABEC9
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 04:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 999F4302D5CC
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE85274FE8;
	Mon,  8 Dec 2025 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iowg71T9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263C257829;
	Mon,  8 Dec 2025 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163092; cv=none; b=FMT9vvVBv+96QIISTbROMdtug4Z2oqWeiK7kqRFs764Or6/48d+lZGi0fWE5pv/AiUNLEeDcIyyoJ1op66td7uOvN4QHVDjh3S5Xlk3qNAFhHqbgi75Qa00ozOCLo5/0NansMpnff4ChFf0nvH0THDXSzTQ4l0tkSxH87L73514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163092; c=relaxed/simple;
	bh=VtOK1EBRkJsxGXnW4s7lGPtINpp/sA1eK4PYbFO1fwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTARnDVOycaShwUVSjAEBWhAHrr5yT2wvXWF7t1fnks0btotK8QQapv/tCkWIuTZCZ1vZCEO4iTxJai4fX8zHdZja6Oty9P1DaKbS1xewsFkDE1cBIeXRuuIyh7VYqir++885NzG0oisWgj6xJlpeyv7l8qMfuchS56lUGkaDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iowg71T9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765163090; x=1796699090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VtOK1EBRkJsxGXnW4s7lGPtINpp/sA1eK4PYbFO1fwc=;
  b=iowg71T9YgBNYlp7bw4YTUk3oC8HoZdqgeefR/K7NDLc4lsedMrsbibC
   LGFZg5SunjrX4SrN4CSRiRj5i27R9NQnMeLql63VKhGvH8vID6QvwVqju
   B3Mdn/8V4yatys+zm8ePFcFRiSPStMCF6VTwynfEV7wnDwZVQQlaHoEuI
   8ADRa0ur8wAs0cym9q4CuyJRfKxH804uFYtr1ykCPpYeQjcVkjvDyG5TW
   fG5IQNQMwsvDvTRnbqgVxSD2OIWXPAS33hC6q2QCKoIL+xwOdPJ8x2rLx
   rOqGNvCAeRfjdsPfueNe+ihA2ZdgoB8eXssR5H9onM2/PTBYpMuy2rFrv
   A==;
X-CSE-ConnectionGUID: 33sUWcpwTS6R3trTDDV9rA==
X-CSE-MsgGUID: GccyFmZHS9OSWyyNfxhJYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="92581805"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="92581805"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 19:04:49 -0800
X-CSE-ConnectionGUID: KDECnqanSV+libfVdYMICw==
X-CSE-MsgGUID: 4YeACLpgS/WcCJF93mXHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="196091344"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Dec 2025 19:04:47 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSRYK-00000000JsT-3nW5;
	Mon, 08 Dec 2025 03:04:44 +0000
Date: Mon, 8 Dec 2025 11:04:22 +0800
From: kernel test robot <lkp@intel.com>
To: Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: Re: [PATCH] net: atm: lec: add pre_send validation to avoid
 uninitialized
Message-ID: <202512081042.Zx4NasDJ-lkp@intel.com>
References: <20251207041453.8302-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207041453.8302-1-dharanitharan725@gmail.com>

Hi Dharanitharan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.18 next-20251205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharanitharan-R/net-atm-lec-add-pre_send-validation-to-avoid-uninitialized/20251207-121647
base:   net/main
patch link:    https://lore.kernel.org/r/20251207041453.8302-1-dharanitharan725%40gmail.com
patch subject: [PATCH] net: atm: lec: add pre_send validation to avoid uninitialized
config: arm64-randconfig-002-20251208 (https://download.01.org/0day-ci/archive/20251208/202512081042.Zx4NasDJ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512081042.Zx4NasDJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512081042.Zx4NasDJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/atm/lec.c:506:2: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     506 |         mesg = (struct atmlec_msg *)skb->data;
         |         ^
   net/atm/lec.c:503:4: note: previous statement is here
     503 |    if (!pskb_may_pull(skb, msg_size))
         |    ^
   1 warning generated.


vim +/if +506 net/atm/lec.c

   491	
   492	static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
   493	{
   494		struct atmlec_msg *mesg;
   495		u32 sizeoftlvs;
   496		unsigned int msg_size = sizeof(struct atmlec_msg);
   497	
   498		/* Must contain the base message */
   499		if (skb->len < msg_size)
   500			return -EINVAL;
   501	
   502	   /* Must have at least msg_size bytes in linear data */
   503	   if (!pskb_may_pull(skb, msg_size))
   504	   	return -EINVAL;
   505	
 > 506		mesg = (struct atmlec_msg *)skb->data;
   507	   sizeoftlvs = mesg->sizeoftlvs;
   508	
   509	   /* Validate TLVs if present */
   510	   if (sizeoftlvs && !pskb_may_pull(skb, msg_size + sizeoftlvs))
   511	       return -EINVAL;
   512	
   513	   return 0;
   514	}
   515	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

