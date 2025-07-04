Return-Path: <netdev+bounces-203964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE2AF8603
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116EE7A2873
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D771E25EB;
	Fri,  4 Jul 2025 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0GYfyIO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953B1DF265
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751599441; cv=none; b=SP8CyF1WNXPYaNhWX7N3hOkWj64m0Vbn6whtR+AoF2ZOC8mAeDTi2Htl1iUcCSdrO8mYboplYh4N6uH9hQ+1KnxEEq/UXXVYDG8xFVDWmxuv4+AisHCTc6NcyCwI/sM9I1iU56QWG0l+rx7pR95NT58OEYGNDnO6BeShhOvPp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751599441; c=relaxed/simple;
	bh=4S8wpH5Pnq6+MDR8tFUxzEncIxuZveMK0y+6Kselt/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0fVe3qUOGLQxM1tQ3kWy5aVE0twv2MBjmhUn3FQtMg0MPvs8Oj6aF/a75VV2xe3XHHEEcRCnPSv6hrUWlKVOkm1QSEL3xr2INLuvrznJUztfaX7YtpbyiBu2IIjrTVcXGzZKHjqDLqIC2KiDyaRCXqcs6nqI1Pe4B6Qwm2H09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0GYfyIO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751599440; x=1783135440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4S8wpH5Pnq6+MDR8tFUxzEncIxuZveMK0y+6Kselt/s=;
  b=e0GYfyIOYyYfz2IMcOZDN44AU+IJtDjOqokPRVKNsTN9DRc90faVsjBk
   McDvIJ9L5pwOvozPQEUD9eSu1LAXT6EAEGM3TdoVt0+Ii4oHv6j+w77EG
   jotRheQhf2NABdOBo4wiX5oaMaSsO/43FSNJemOb2TaXc6c0dkmY3ynW5
   PY/fEFe5dYCIl9VDVwMAQEDa/4fqwSEdq18HX3Gaxn369higKkT71k/Ho
   son3bH1lLkKWwjToa0Y+P9Gqe64TE6/LfBMKyeBqKBVvhnSpai5ZhdmK2
   habGt260gU1irLAWsgd2fYQozsaE00fFvszpTTyhrqEw2Jp2RpSvzcvc/
   w==;
X-CSE-ConnectionGUID: IOMalOCIRIuh0z47DnJiMQ==
X-CSE-MsgGUID: 71TdpH9PTk6z6TQQoiPgPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53156686"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53156686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 20:23:59 -0700
X-CSE-ConnectionGUID: qFWY1a8FRO2YmJC8FwbL4Q==
X-CSE-MsgGUID: FPE2/dhAReqiHf7j0Vun/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154617835"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jul 2025 20:23:57 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXX1n-0003Gx-0N;
	Fri, 04 Jul 2025 03:23:55 +0000
Date: Fri, 4 Jul 2025 11:23:50 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net 2/2] atm: clip: Fix potential null-ptr-deref in
 to_atmarpd().
Message-ID: <202507041113.tpHgxTvk-lkp@intel.com>
References: <20250702020437.703698-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702020437.703698-3-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/atm-clip-Fix-infinite-recursive-call-of-clip_push/20250702-100652
base:   net/main
patch link:    https://lore.kernel.org/r/20250702020437.703698-3-kuniyu%40google.com
patch subject: [PATCH v1 net 2/2] atm: clip: Fix potential null-ptr-deref in to_atmarpd().
config: i386-randconfig-063-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041113.tpHgxTvk-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041113.tpHgxTvk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041113.tpHgxTvk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/atm/clip.c:64:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/atm/clip.c:64:15: sparse:    struct atm_vcc [noderef] __rcu *
   net/atm/clip.c:64:15: sparse:    struct atm_vcc *
   net/atm/clip.c:625:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/atm/clip.c:625:9: sparse:    struct atm_vcc [noderef] __rcu *
   net/atm/clip.c:625:9: sparse:    struct atm_vcc *
   net/atm/clip.c:658:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/atm/clip.c:658:9: sparse:    struct atm_vcc [noderef] __rcu *
   net/atm/clip.c:658:9: sparse:    struct atm_vcc *

vim +64 net/atm/clip.c

    52	
    53	static int to_atmarpd(enum atmarp_ctrl_type type, int itf, __be32 ip)
    54	{
    55		struct sock *sk;
    56		struct atmarp_ctrl *ctrl;
    57		struct atm_vcc *vcc;
    58		struct sk_buff *skb;
    59		int err = 0;
    60	
    61		pr_debug("(%d)\n", type);
    62	
    63		rcu_read_lock();
  > 64		vcc = rcu_dereference(atmarpd);
    65		if (!vcc) {
    66			err = -EUNATCH;
    67			goto unlock;
    68		}
    69		skb = alloc_skb(sizeof(struct atmarp_ctrl), GFP_ATOMIC);
    70		if (!skb) {
    71			err = -ENOMEM;
    72			goto unlock;
    73		}
    74		ctrl = skb_put(skb, sizeof(struct atmarp_ctrl));
    75		ctrl->type = type;
    76		ctrl->itf_num = itf;
    77		ctrl->ip = ip;
    78		atm_force_charge(vcc, skb->truesize);
    79	
    80		sk = sk_atm(vcc);
    81		skb_queue_tail(&sk->sk_receive_queue, skb);
    82		sk->sk_data_ready(sk);
    83	unlock:
    84		rcu_read_unlock();
    85		return err;
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

