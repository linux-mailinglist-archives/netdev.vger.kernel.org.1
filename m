Return-Path: <netdev+bounces-244179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D957CB19A4
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D0F30B3A14
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7D221FDA;
	Wed, 10 Dec 2025 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngZplvnY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827021348;
	Wed, 10 Dec 2025 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330593; cv=none; b=Bmn3f/zuW50AtlcPimov/btpaiIqdFlHvMyNOOvaz2WlJ2EVCRr4qf73CVLqhSg+xas8S45upFJDBDYTwDyVyIplG/Sd3zdYQtgSmz+bdgSVHDaC8NPZMfnVb0E+1vmhRvPW3IeUDlIiup6knXj+mpkoLJy5cdCTM8F9uo5Plyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330593; c=relaxed/simple;
	bh=K5odEHdQx6AReGW+bBKxgqCvZEHkimJ7Bft2ZBOGO04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX4OZPDPFspLiJ7lucN4/YLF6BUQPlsWfuRqwlaeMcPc7tlF6j7jXtjaKy9csPpJ/UPys6LvmgYdMIFnvlWzak+0ii6KKW4CALSVtYXR8PgsM3Neo5owiBM9cUP/lvvbbDhLwWzotJKV0y8AsDDQcET5Ay2LDAwQMiw088y+Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngZplvnY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765330592; x=1796866592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K5odEHdQx6AReGW+bBKxgqCvZEHkimJ7Bft2ZBOGO04=;
  b=ngZplvnYu5qEV3cF/a+P8g4XZt87o6ScddjE9JZYAl/Wm3C1eLWbxqT9
   KQ3wH6pe0sv3QyrWUGNeVMgDt/5+w7qkbjmELSCMOCqUFEzlc9C2tQK1e
   AgLDlWGLfU9PSG+1mymZ+eUN3JNpEb/cJR9AYO7HKsCyWEpoub6EgAoIE
   sqz4YI/ZVcsYrKuTDWPb+H2EAbWfa6fR2aruhLa8txZVCkgyScqBszqQb
   x08tnHz1+e1E7DRm1yhz/wmI3MldKnTh+ZOGwCmRU95hqsPBhBZidGhnE
   TsojI9PaGV/P1EANKBMAL71oUxsCbt406iu2JSKIuH5Rbiq5Yo30jt4G0
   Q==;
X-CSE-ConnectionGUID: F/fLMcsMTHSKy9sQkhXszw==
X-CSE-MsgGUID: G6+NtLQSQvysGs76/xRwcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="84711125"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="84711125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 17:36:31 -0800
X-CSE-ConnectionGUID: Fx1f0ymTQfWL7CWfi6FUOg==
X-CSE-MsgGUID: kGC7calUTMCwMTiPO6GqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="201303730"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Dec 2025 17:36:27 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT97x-000000002Uv-1ixI;
	Wed, 10 Dec 2025 01:36:25 +0000
Date: Wed, 10 Dec 2025 09:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: Wang Liang <wangliang74@huawei.com>, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, brauner@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, wangliang74@huawei.com
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in
 handshake_complete()
Message-ID: <202512100952.cr9q1lGr-lkp@intel.com>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209115852.3827876-1-wangliang74@huawei.com>

Hi Wang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Liang/net-handshake-Fix-null-ptr-deref-in-handshake_complete/20251209-194006
base:   net/main
patch link:    https://lore.kernel.org/r/20251209115852.3827876-1-wangliang74%40huawei.com
patch subject: [PATCH net] net/handshake: Fix null-ptr-deref in handshake_complete()
config: arm-mps2_defconfig (https://download.01.org/0day-ci/archive/20251210/202512100952.cr9q1lGr-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6ec8c4351cfc1d0627d1633b02ea787bd29c77d8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100952.cr9q1lGr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100952.cr9q1lGr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/handshake/netlink.c:110:3: error: cannot jump from this goto statement to its label
     110 |                 goto out_status;
         |                 ^
   net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
     114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
         |                    ^
   net/handshake/netlink.c:104:3: error: cannot jump from this goto statement to its label
     104 |                 goto out_status;
         |                 ^
   net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
     114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
         |                    ^
   net/handshake/netlink.c:100:3: error: cannot jump from this goto statement to its label
     100 |                 goto out_status;
         |                 ^
   net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
     114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
         |                    ^
   3 errors generated.


vim +110 net/handshake/netlink.c

    89	
    90	int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
    91	{
    92		struct net *net = sock_net(skb->sk);
    93		struct handshake_net *hn = handshake_pernet(net);
    94		struct handshake_req *req = NULL;
    95		struct socket *sock;
    96		int class, err;
    97	
    98		err = -EOPNOTSUPP;
    99		if (!hn)
   100			goto out_status;
   101	
   102		err = -EINVAL;
   103		if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_ACCEPT_HANDLER_CLASS))
   104			goto out_status;
   105		class = nla_get_u32(info->attrs[HANDSHAKE_A_ACCEPT_HANDLER_CLASS]);
   106	
   107		err = -EAGAIN;
   108		req = handshake_req_next(hn, class);
   109		if (!req)
 > 110			goto out_status;
   111	
   112		sock = req->hr_sk->sk_socket;
   113	
   114		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
   115		if (fdf.err) {
   116			err = fdf.err;
   117			goto out_complete;
   118		}
   119	
   120		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
   121		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
   122		if (err)
   123			goto out_complete; /* Automatic cleanup handles fput */
   124	
   125		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
   126		fd_publish(fdf);
   127		return 0;
   128	
   129	out_complete:
   130		handshake_complete(req, -EIO, NULL);
   131	out_status:
   132		trace_handshake_cmd_accept_err(net, req, NULL, err);
   133		return err;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

