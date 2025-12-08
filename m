Return-Path: <netdev+bounces-244037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5BCAE0DC
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 20:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 549353009B4B
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C39A2E5437;
	Mon,  8 Dec 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd6oN/FF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10927281E;
	Mon,  8 Dec 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221122; cv=none; b=UftCheOUsxqWWidMvJm8t4MV2omJKQbbhIAGdEvSzQo8InypR6YSQUlmaRJZagqU9tMW4ncGgkY34+60yC2lDDF04pKS+jcow3Jan7ZiilkIE/DQdWIqbd6QLReVrJHXReamZWDn5sX89ckz3Nw42bdEH5Q8YZPIpXvwJE2KUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221122; c=relaxed/simple;
	bh=BcyozwH7NgDwI7TQtVWFYjur9swQgcvjB9tEt5qXq5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCxt8hX8c15fuMA1D4tGwazskJu4gYWXPAOtIlg1LV+NQZnvYnyYgCQk3+lcVc8mw1J+NVMo/jVefQbINgb4YhWZjYnvYjvNboUR/jDMc3E8aZBIOR+VNXxCufl9Ss5xAWuKTzJ1/xT9ytHPwxOYCb+zgB+Jt0xN4x6QhgzPVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd6oN/FF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765221120; x=1796757120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BcyozwH7NgDwI7TQtVWFYjur9swQgcvjB9tEt5qXq5w=;
  b=bd6oN/FFwK92/1dFqbWt20XBGIxH9lYDu39/YVmNOwIZfPAd/+fh1Jjd
   k/OBw9P1FqNg4Vj/En2KUEvV1PTcu49756kT0kCC7qKbM1A794xHI1cDT
   c5/jzFzRhf6IWfZoqStMLy8ia+esPxdzb9dako6aK0gsvBXw8CzCWTh56
   ZPRJmPTV8ZmbXzuwSzPrvRG4rfTgwYivFtJzr7OPlBcDer4PPBI5Y53dB
   KTuMdhZ3hE0vl61u8dlmJLiKJQC+EId57Dq+by5a68TlS6baDeDJgpk97
   NLIxawjmXQW5Yvf5B2klMd1qAmX077NUhyuWvKwrYI9lIw453qEIAQHfr
   Q==;
X-CSE-ConnectionGUID: 1DmDYhcVT3uLUjJZc6svyQ==
X-CSE-MsgGUID: momoApFHR1+x9fG8FlrWJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="66354233"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="66354233"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 11:11:59 -0800
X-CSE-ConnectionGUID: ueVOmlBLT1Sbkg1ZpG/25A==
X-CSE-MsgGUID: FufcWZKWSO6nR8D9PNTMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="195296859"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Dec 2025 11:11:58 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSgeJ-000000000kP-0DrJ;
	Mon, 08 Dec 2025 19:11:55 +0000
Date: Tue, 9 Dec 2025 03:11:31 +0800
From: kernel test robot <lkp@intel.com>
To: Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: Re: [PATCH] net: atm: lec: add pre_send validation to avoid
 uninitialized
Message-ID: <202512090202.P59kzmhm-lkp@intel.com>
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
[also build test WARNING on net-next/main linus/master v6.18 next-20251208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharanitharan-R/net-atm-lec-add-pre_send-validation-to-avoid-uninitialized/20251207-121647
base:   net/main
patch link:    https://lore.kernel.org/r/20251207041453.8302-1-dharanitharan725%40gmail.com
patch subject: [PATCH] net: atm: lec: add pre_send validation to avoid uninitialized
config: x86_64-randconfig-r072-20251208 (https://download.01.org/0day-ci/archive/20251209/202512090202.P59kzmhm-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090202.P59kzmhm-lkp@intel.com/

New smatch warnings:
net/atm/lec.c:503 lec_atm_pre_send() warn: inconsistent indenting
net/atm/lec.c:506 lec_atm_pre_send() warn: curly braces intended?

Old smatch warnings:
net/atm/lec.c:507 lec_atm_pre_send() warn: inconsistent indenting

vim +503 net/atm/lec.c

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
 > 503	   if (!pskb_may_pull(skb, msg_size))
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

