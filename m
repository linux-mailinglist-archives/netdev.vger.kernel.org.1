Return-Path: <netdev+bounces-170970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9CA4AE5E
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0443188B536
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347351D6DDA;
	Sat,  1 Mar 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8t4w7qf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F770808
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740871420; cv=none; b=XjXHAd0rRFuXWaddkwKu82iTjyvcDtjHaiUWIftQWCF8no7cW4iIxyPPzZsumL+sbQlSfapm2IwaMXssQJISj+Rrh69XSN83G8BMelfBQea027nZC1wHOhQNIWS2CIlB4AKyTr43C9EHADdSJD30siH5DT5vxW1yom+fKh2NIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740871420; c=relaxed/simple;
	bh=UyQgb+vzNU+0SZNfCmTAUHgtsZQ2K1rcC30RYOtUNKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdXaZaqlrWowucIl+29BXqXa79zalVlR7cfMnD7rrkglDIDQIydUpYMVa2sU/QLZNTXog9n6oVpWxiZWpN05DJNUPZF/TxmGwENcq03MlAlhFixWITQxn8eNLurKfUthYL/p99TvvHdO3MkXeLgFMNyMa/qyV20lwkgVKZf6LHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8t4w7qf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740871418; x=1772407418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UyQgb+vzNU+0SZNfCmTAUHgtsZQ2K1rcC30RYOtUNKU=;
  b=m8t4w7qflQ+F263afb6VOB5Z3qchC1h6jiiGWDCapGydwnFvYj8BCmdp
   LBCCBICtIYYEHSLLoWOYNnMGqaPnwF6JR8e4YEOU6g1hI0pLV4dkvEPe7
   O4tPoVgGJxvkyfUmTfF/fzpQgUohh1jbEuhNnYxnX56y7DhbI1uC/JyAs
   pKjWtAghO4uE5fYNhD/yuClCxVKhkrrvR/aQMYFrqQKQb4jFXurx6wwTh
   MYRFPbMVjYc1ySs9MGxwVMWNtBqItGmXf6nEboN5Fb79RjJz5J5s6jd30
   H0TpbAx0AMsri+VbT37POGUNRX6GTuuTcBvVlQy6z6DK766ZEcK58rXqP
   Q==;
X-CSE-ConnectionGUID: smpeZYnYQo2a4npDMn4roA==
X-CSE-MsgGUID: 9/HRPk7ySGC0BMKyJoa0ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="59318488"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="59318488"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 15:23:37 -0800
X-CSE-ConnectionGUID: OeXhvlmlTjyfZuukmC1FKA==
X-CSE-MsgGUID: vAyTAKFUTSirOg0xc41NMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118186861"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2025 15:23:36 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toWBB-000GpS-1i;
	Sat, 01 Mar 2025 23:23:33 +0000
Date: Sun, 2 Mar 2025 07:22:37 +0800
From: kernel test robot <lkp@intel.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Message-ID: <202503020739.xWWyG7zO-lkp@intel.com>
References: <20250227042638.82553-6-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227042638.82553-6-allison.henderson@oracle.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/allison-henderson-oracle-com/net-rds-Avoid-queuing-superfluous-send-and-recv-work/20250227-123038
base:   net/main
patch link:    https://lore.kernel.org/r/20250227042638.82553-6-allison.henderson%40oracle.com
patch subject: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard messages
config: riscv-randconfig-002-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020739.xWWyG7zO-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020739.xWWyG7zO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020739.xWWyG7zO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/rds/tcp_listen.c:137:6: warning: variable 'inet' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!new_sock) {
               ^~~~~~~~~
   net/rds/tcp_listen.c:179:19: note: uninitialized use occurs here
                    my_addr, ntohs(inet->inet_sport),
                                   ^~~~
   include/linux/byteorder/generic.h:142:27: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                             ^
   include/linux/byteorder/generic.h:137:35: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                                     ^
   include/uapi/linux/byteorder/little_endian.h:43:59: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                                                             ^
   include/uapi/linux/swab.h:105:31: note: expanded from macro '__swab16'
           (__u16)(__builtin_constant_p(x) ?       \
                                        ^
   net/rds/tcp_listen.c:137:2: note: remove the 'if' if its condition is always true
           if (!new_sock) {
           ^~~~~~~~~~~~~~~
   net/rds/tcp_listen.c:115:24: note: initialize the variable 'inet' to silence this warning
           struct inet_sock *inet;
                                 ^
                                  = NULL
   1 warning generated.


vim +137 net/rds/tcp_listen.c

   108	
   109	int rds_tcp_accept_one(struct rds_tcp_net *rtn)
   110	{
   111		struct socket *listen_sock = rtn->rds_tcp_listen_sock;
   112		struct socket *new_sock = NULL;
   113		struct rds_connection *conn;
   114		int ret;
   115		struct inet_sock *inet;
   116		struct rds_tcp_connection *rs_tcp = NULL;
   117		int conn_state;
   118		struct rds_conn_path *cp;
   119		struct in6_addr *my_addr, *peer_addr;
   120		struct proto_accept_arg arg = {
   121			.flags = O_NONBLOCK,
   122			.kern = true,
   123		};
   124	#if !IS_ENABLED(CONFIG_IPV6)
   125		struct in6_addr saddr, daddr;
   126	#endif
   127		int dev_if = 0;
   128	
   129		mutex_lock(&rtn->rds_tcp_accept_lock);
   130	
   131		if (!listen_sock)
   132			return -ENETUNREACH;
   133	
   134		new_sock = rtn->rds_tcp_accepted_sock;
   135		rtn->rds_tcp_accepted_sock = NULL;
   136	
 > 137		if (!new_sock) {
   138			ret = sock_create_lite(listen_sock->sk->sk_family,
   139					       listen_sock->sk->sk_type,
   140					       listen_sock->sk->sk_protocol,
   141					       &new_sock);
   142			if (ret)
   143				goto out;
   144	
   145			ret = listen_sock->ops->accept(listen_sock, new_sock, &arg);
   146			if (ret < 0)
   147				goto out;
   148	
   149			/* sock_create_lite() does not get a hold on the owner module so we
   150			 * need to do it here.  Note that sock_release() uses sock->ops to
   151			 * determine if it needs to decrement the reference count.  So set
   152			 * sock->ops after calling accept() in case that fails.  And there's
   153			 * no need to do try_module_get() as the listener should have a hold
   154			 * already.
   155			 */
   156			new_sock->ops = listen_sock->ops;
   157			__module_get(new_sock->ops->owner);
   158	
   159			rds_tcp_keepalive(new_sock);
   160			if (!rds_tcp_tune(new_sock)) {
   161				ret = -EINVAL;
   162				goto out;
   163			}
   164	
   165			inet = inet_sk(new_sock->sk);
   166		}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

