Return-Path: <netdev+bounces-163383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11BA2A190
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B3916980E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C2224B03;
	Thu,  6 Feb 2025 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT2+bh6K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63E224AE9;
	Thu,  6 Feb 2025 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824581; cv=none; b=Tqs/WfCzSh/C9QaK7phYsWxgc77cJRQsF82eTtE5Pp1Zzs20AgjPSQdC2jHjR6pYIY52Rf/nPHIO1gFy5PpfN3Vu4sGJKaZUeBKiPZlyb6WczSC9jatcbcuzTO6lbZzdrPsRfs52cNkbycU2cAr1Gz70WDoMyhZZifd4TBDK3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824581; c=relaxed/simple;
	bh=v1Uq0ArCQZi2SYzNDPugTKvvEHz/QhanShBOFyH5rdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlKimXpT0lvMDqm9ulSMIb+Tsfa3xMEavod/48YSuroLaL3JddW8siBfU3cfJY5fWU1DvSjEbmNx1vP2/9jjkek04TR0cGWe6ig0U/z0OqigvWQmSRz3GXG+iNUe5C19vsa4c8d5XILw5jSG/LinWCrEep5a8eRA21uL7GyseCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT2+bh6K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738824579; x=1770360579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v1Uq0ArCQZi2SYzNDPugTKvvEHz/QhanShBOFyH5rdU=;
  b=dT2+bh6KvkKr1x6ed483WVij9Y4HqCfn/3j2bJ2dl5FBbzIpZhSHUVPT
   +0IZM6R+xxM/UHXfhprwWZOrQTk+HnglZNSvmCrap/GLL8osI7jrrWEek
   zkOvCqrpP1HOP7eiAVttktFlAMtAT5Yh34zeZBUvl5e5G9PXG6ULcnBZJ
   v9dTXGtCpW5N6xg9DbIjla4XkosadmQqMawtW/jg1+CB01vXHEa0gIcE4
   4Hi2qqRIAxkZP6vURTDrTJvBC6q5EGq3VbBzdXNt/Aaju61iqCUz6YAvL
   UCdVCRJ39scfQOSx3IGF7kXlL9RtTvxS9oKyNvVbFrST88N8YLu81Mqaj
   Q==;
X-CSE-ConnectionGUID: mdSALZYrTiuLi2V5qnGJng==
X-CSE-MsgGUID: cIJFYpKjT3uJ+M8ZPCEQjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38615734"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="38615734"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 22:49:38 -0800
X-CSE-ConnectionGUID: lepeyWM5QFaK99kODWG8ng==
X-CSE-MsgGUID: Y1SfbRy9R+KI/D8ZU4zY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115731181"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2025 22:49:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfvhe-000wXP-0O;
	Thu, 06 Feb 2025 06:49:34 +0000
Date: Thu, 6 Feb 2025 14:49:29 +0800
From: kernel test robot <lkp@intel.com>
To: Liang Jie <buaajxlj@163.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind
 identifier length
Message-ID: <202502061416.GZjhJTOs-lkp@intel.com>
References: <20250205060653.2221165-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205060653.2221165-1-buaajxlj@163.com>

Hi Liang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Jie/af_unix-Refine-UNIX-domain-sockets-autobind-identifier-length/20250205-141123
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250205060653.2221165-1-buaajxlj%40163.com
patch subject: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind identifier length
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250206/202502061416.GZjhJTOs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250206/202502061416.GZjhJTOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502061416.GZjhJTOs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/unix/af_unix.c: In function 'unix_autobind':
>> net/unix/af_unix.c:1227:48: warning: 'sprintf' writing a terminating nul past the end of the destination [-Wformat-overflow=]
    1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
         |                                                ^
   net/unix/af_unix.c:1227:9: note: 'sprintf' output 6 bytes into a destination of size 5
    1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +1227 net/unix/af_unix.c

  1195	
  1196	static int unix_autobind(struct sock *sk)
  1197	{
  1198		struct unix_sock *u = unix_sk(sk);
  1199		unsigned int new_hash, old_hash;
  1200		struct net *net = sock_net(sk);
  1201		struct unix_address *addr;
  1202		u32 lastnum, ordernum;
  1203		int err;
  1204	
  1205		err = mutex_lock_interruptible(&u->bindlock);
  1206		if (err)
  1207			return err;
  1208	
  1209		if (u->addr)
  1210			goto out;
  1211	
  1212		err = -ENOMEM;
  1213		addr = kzalloc(sizeof(*addr) +
  1214			       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_KERNEL);
  1215		if (!addr)
  1216			goto out;
  1217	
  1218		addr->len = offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
  1219		addr->name->sun_family = AF_UNIX;
  1220		refcount_set(&addr->refcnt, 1);
  1221	
  1222		old_hash = sk->sk_hash;
  1223		ordernum = get_random_u32();
  1224		lastnum = ordernum & 0xFFFFF;
  1225	retry:
  1226		ordernum = (ordernum + 1) & 0xFFFFF;
> 1227		sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
  1228	
  1229		new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
  1230		unix_table_double_lock(net, old_hash, new_hash);
  1231	
  1232		if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
  1233			unix_table_double_unlock(net, old_hash, new_hash);
  1234	
  1235			/* __unix_find_socket_byname() may take long time if many names
  1236			 * are already in use.
  1237			 */
  1238			cond_resched();
  1239	
  1240			if (ordernum == lastnum) {
  1241				/* Give up if all names seems to be in use. */
  1242				err = -ENOSPC;
  1243				unix_release_addr(addr);
  1244				goto out;
  1245			}
  1246	
  1247			goto retry;
  1248		}
  1249	
  1250		__unix_set_addr_hash(net, sk, addr, new_hash);
  1251		unix_table_double_unlock(net, old_hash, new_hash);
  1252		err = 0;
  1253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

