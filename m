Return-Path: <netdev+bounces-243972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95ACABD0C
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 03:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE96B3005B95
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 02:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212126ED29;
	Mon,  8 Dec 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D49afARq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116691A3178;
	Mon,  8 Dec 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160044; cv=none; b=UzELoSovs1QWknHxq19Oy+T5h+k3HdCAHk2/sIuKPOEeIB/HAsnp9dL6cQtD9GNxZnkTQsPyEzgEEg8LX9F8H1iU3w7VAwIAb9V0wfRm62ygg1OsuaAXfhfbXf8UsvGr56jdnZvjKwg7eR9HzCktvDM5+/kpAT3Ej2LYH2YET+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160044; c=relaxed/simple;
	bh=1sgJ1779GC9fTCfnXBvDi8nlZT8Mu3mSnAOkAoby3zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyWqaYjZ/K5+9hHLLoJuY+8r5ogsbPPSb2vbNdOrz6Xs2n1KyW0Njqjg44Nb9CEHoHzF94id2wciDLV6fdYmosv7MNI3uVMHRSdu97HZWhgge5/y0+LSJ91fJXkAlrOVpZu/jE4fGc3acgT/yXBTcjmvrKlURlB32Q6PFUS0pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D49afARq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765160043; x=1796696043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sgJ1779GC9fTCfnXBvDi8nlZT8Mu3mSnAOkAoby3zs=;
  b=D49afARqYRPM7Yr5bsIh9KtzPB3gEWHcOlP8Y25w7HBLirXfbRs3vfq2
   kU2Bf35imCpiVy0eIWmmar5yuBFvB2/BaBMbUc7Xf17YTBN2SRWfMbwNY
   mGSmry+WDBJBPjvk7aqfYFnVATH6lA0/WaQgWoVgpBjr1HGQNG44ent6S
   YZGgSiSGt5DCjJLMv0jCeZgSUh9btKlusQQ810Tv/mgHGa9ARi8UM2ewh
   U/pWPC8aiMa0SC/vsq7/Gu0u05anFdCO93vphoV1B9Bxfag7++r4gyUUy
   ZBUSXWxP7E/Pk1fXnIO2B80EEs347ERd33Bl+5kExUxlAl9R9qQ2vEeg/
   w==;
X-CSE-ConnectionGUID: 0R6KYxMvQlWUT/Qb+Yq0ew==
X-CSE-MsgGUID: C7tYQYa/QJe+Vvx45YBMgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66996394"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="66996394"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:14:02 -0800
X-CSE-ConnectionGUID: NjMSOeOsTxKuPkK+5XbvJw==
X-CSE-MsgGUID: LIX5ylSPTiO1PfKFvrVFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="196272597"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Dec 2025 18:13:50 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSQkw-00000000Jph-1zHJ;
	Mon, 08 Dec 2025 02:13:42 +0000
Date: Mon, 8 Dec 2025 10:12:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: Re: [PATCH] net: atm: lec: add pre_send validation to avoid
 uninitialized
Message-ID: <202512080911.BLjFHfAd-lkp@intel.com>
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
config: nios2-randconfig-002-20251208 (https://download.01.org/0day-ci/archive/20251208/202512080911.BLjFHfAd-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512080911.BLjFHfAd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512080911.BLjFHfAd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/atm/lec.c: In function 'lec_atm_pre_send':
>> net/atm/lec.c:503:4: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     503 |    if (!pskb_may_pull(skb, msg_size))
         |    ^~
   net/atm/lec.c:506:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     506 |         mesg = (struct atmlec_msg *)skb->data;
         |         ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=m]
   Selected by [m]:
   - CAN [=m] && NET [=y]


vim +/if +503 net/atm/lec.c

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
   506		mesg = (struct atmlec_msg *)skb->data;
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

