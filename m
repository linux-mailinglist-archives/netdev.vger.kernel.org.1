Return-Path: <netdev+bounces-164346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5FBA2D752
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 17:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB64416753A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61F22DFF3;
	Sat,  8 Feb 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aY0K0x9F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0C22DFE8;
	Sat,  8 Feb 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032050; cv=none; b=Egtz6OkTwtdLgQ0gOGFlRqa+PbDjRc5hf23LICj5eF7RGLxkY3GzEw24KCTbWActLS2ohBQFMIHp3ZX2ppYESetvxj6apCis8zzCWhxSy2q6/zBJ+SSzJABrvpSwRzOiQfk4///6yBavzrL3BlFQumWM7e3ND7lr963KhL+Pjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032050; c=relaxed/simple;
	bh=KBpgtQSp3QDzHOeIRxUev1T7WAZQkiUIz/zQq6o8N4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMgQZEv341njmfXyzBPqZPEKsOFiWwKLObfySTBqxnEyg7zYAdUabp1GCVxXtftFdP/YO+Ittq5y5gWA1XZZXzFu0QCdCTPUGMzAoQ0SI0r4M6n8evZ3REhJkZ7tb9M2Kalj5aiWYYdR5PiyvQjeztj4yXUCIEXq6UYF22czBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aY0K0x9F; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739032048; x=1770568048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBpgtQSp3QDzHOeIRxUev1T7WAZQkiUIz/zQq6o8N4Q=;
  b=aY0K0x9FNpA3Lr5TQPuIsjCrMkTj8SKXYDux7w3mAePV0fWNhmh04UJv
   fuXbSiCaN06D750dPelF4H8noBMeFnBABTdRSqBr2Vy/HGEiez8cLGP2k
   f40HzxfBJ6e0BpiGT3AWw9BNrC5R214/U6NU/mAc43ZOLlNM+c8dEgJz7
   /jpUZnh6YwqCvvp4y/vPBWqX7cMW9Qe23GBpCBXGTz+VWV4ABPV5BeKAo
   /6ITicQlqzIHQaKqBFZj9aVfsnCnuDfj1A6VTBLE8AiJLi4jbG+N7ClAa
   k6CyJm0CEa+fOPL6sfAJtJ4gBRA9nZGG4tYRewTVN63tLRWrJy9vQfNKT
   w==;
X-CSE-ConnectionGUID: TYvg5/uhSqOIaysol5WKpg==
X-CSE-MsgGUID: AJjWaMcCQzuJCf+NhD179g==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="49898092"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="49898092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 08:27:27 -0800
X-CSE-ConnectionGUID: PkU26892TG6nlvbPTbz4fw==
X-CSE-MsgGUID: sHqAQLdmQaym2sXLhJDMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117003985"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2025 08:27:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgnft-0010Kn-1j;
	Sat, 08 Feb 2025 16:27:21 +0000
Date: Sun, 9 Feb 2025 00:26:31 +0800
From: kernel test robot <lkp@intel.com>
To: Liang Jie <buaajxlj@163.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets
 autobind identifier length
Message-ID: <202502090056.Rl1rtpr5-lkp@intel.com>
References: <20250206054451.4070941-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054451.4070941-1-buaajxlj@163.com>

Hi Liang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Jie/af_unix-Refine-UNIX-pathname-sockets-autobind-identifier-length/20250206-134846
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250206054451.4070941-1-buaajxlj%40163.com
patch subject: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
config: hexagon-randconfig-001-20250207 (https://download.01.org/0day-ci/archive/20250209/202502090056.Rl1rtpr5-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 6807164500e9920638e2ab0cdb4bf8321d24f8eb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090056.Rl1rtpr5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090056.Rl1rtpr5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/unix/af_unix.c:1222:2: warning: 'snprintf' will always be truncated; specified size is 5, but format string expands to at least 6 [-Wformat-truncation]
    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
         |         ^
   1 warning generated.


vim +/snprintf +1222 net/unix/af_unix.c

  1190	
  1191	static int unix_autobind(struct sock *sk)
  1192	{
  1193		struct unix_sock *u = unix_sk(sk);
  1194		unsigned int new_hash, old_hash;
  1195		struct net *net = sock_net(sk);
  1196		struct unix_address *addr;
  1197		u32 lastnum, ordernum;
  1198		int err;
  1199	
  1200		err = mutex_lock_interruptible(&u->bindlock);
  1201		if (err)
  1202			return err;
  1203	
  1204		if (u->addr)
  1205			goto out;
  1206	
  1207		err = -ENOMEM;
  1208		addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
  1209				UNIX_AUTOBIND_LEN, GFP_KERNEL);
  1210		if (!addr)
  1211			goto out;
  1212	
  1213		addr->len = offsetof(struct sockaddr_un, sun_path) + UNIX_AUTOBIND_LEN;
  1214		addr->name->sun_family = AF_UNIX;
  1215		refcount_set(&addr->refcnt, 1);
  1216	
  1217		old_hash = sk->sk_hash;
  1218		ordernum = get_random_u32();
  1219		lastnum = ordernum & 0xFFFFF;
  1220	retry:
  1221		ordernum = (ordernum + 1) & 0xFFFFF;
> 1222		snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
  1223	
  1224		new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
  1225		unix_table_double_lock(net, old_hash, new_hash);
  1226	
  1227		if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
  1228			unix_table_double_unlock(net, old_hash, new_hash);
  1229	
  1230			/* __unix_find_socket_byname() may take long time if many names
  1231			 * are already in use.
  1232			 */
  1233			cond_resched();
  1234	
  1235			if (ordernum == lastnum) {
  1236				/* Give up if all names seems to be in use. */
  1237				err = -ENOSPC;
  1238				unix_release_addr(addr);
  1239				goto out;
  1240			}
  1241	
  1242			goto retry;
  1243		}
  1244	
  1245		__unix_set_addr_hash(net, sk, addr, new_hash);
  1246		unix_table_double_unlock(net, old_hash, new_hash);
  1247		err = 0;
  1248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

