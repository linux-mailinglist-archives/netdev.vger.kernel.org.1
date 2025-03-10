Return-Path: <netdev+bounces-173549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB64A596C1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05391886F2C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDA22A4EA;
	Mon, 10 Mar 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7r5Wxci"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA42206A6
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614791; cv=none; b=UtNPFHx+sqKHeFgailyeG/E67QVexdRwfOYkKWyz9e8WDHlMSeRQ18PslEmM7mMKzspz3bMavd2UYwhuolP1nLu/DhLe49GkjuUh8+gDkb94C7HwRi04S8NBFq1DGclbUqbODltj8MInI88udmqGS8/yG0eTo+MI2LeUqof+9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614791; c=relaxed/simple;
	bh=O/w5wA572U8ZVaqFgo/awxmCslHGU3ldh7l8AS35QTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx1ChwNb4mYe3EpfTIWJUO7eETaRR05EE7RjheDeVueUzCISFskVrqlNDvWogzLRFtgL+wANtbTKnu5f0US882QhDQ0hFTP5HU+IMPa8DO1MPb7RlbJ27OMwQT2ml0zKRPXtQMEq4e5dDBlsJNennyPUHxxlMrYu5OD5F6S/oFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7r5Wxci; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741614790; x=1773150790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/w5wA572U8ZVaqFgo/awxmCslHGU3ldh7l8AS35QTo=;
  b=Q7r5WxcifHppYxuC83rxl5XaeBhEbFem6z281O1cz0GG4Mr9ybdgZMYW
   p7tnBfRigGM3w2GjT6jHKB1idE5mJrqPVvXyzkQmjjUj2fuoOXv4skw5Z
   1GXB79RA3x9FiAD+Y0wx1XofEOVu+HDgPXksbB3TvFPyTqZRxK5yLs7lE
   bq26+trnUYkrADVfYMlm8Rp5jPF4SR9oFf+2DBakoytvDAltLXv0GPbTi
   Le1Ukki4GRWoeT3ic6b8+0clN2BEwgjVZFJnFgnb3n+cypEKOT9AV7+tF
   SujwN7/WQJkVyNkubp3IfScM2SxR2HXmJHy3oYsql6OXQp5mrm39G7xT1
   Q==;
X-CSE-ConnectionGUID: wZKKSj28ROmiUs+dAE6b5A==
X-CSE-MsgGUID: gX51lje4QKu7mJRStNpzLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53988374"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53988374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 06:53:09 -0700
X-CSE-ConnectionGUID: 4UHsYB7CQku8kdNw7wyn9A==
X-CSE-MsgGUID: Q/lcFYIeRpuL5hsUlAOLXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119715154"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 06:53:06 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trdZ2-0004IC-0W;
	Mon, 10 Mar 2025 13:53:04 +0000
Date: Mon, 10 Mar 2025 21:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() to
 defer refcount updates
Message-ID: <202503102108.U88XuKx1-lkp@intel.com>
References: <20250309173151.2863314-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309173151.2863314-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-frags-add-inet_frag_putn-helper/20250310-013501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250309173151.2863314-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() to defer refcount updates
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250310/202503102108.U88XuKx1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503102108.U88XuKx1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503102108.U88XuKx1-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ieee802154/6lowpan/reassembly.c: In function 'lowpan_frag_rcv':
>> net/ieee802154/6lowpan/reassembly.c:312:23: error: too few arguments to function 'lowpan_frag_queue'
     312 |                 ret = lowpan_frag_queue(fq, skb, frag_type);
         |                       ^~~~~~~~~~~~~~~~~
   net/ieee802154/6lowpan/reassembly.c:86:12: note: declared here
      86 | static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
         |            ^~~~~~~~~~~~~~~~~


vim +/lowpan_frag_queue +312 net/ieee802154/6lowpan/reassembly.c

7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  280  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  281  int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  282  {
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  283  	struct lowpan_frag_queue *fq;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  284  	struct net *net = dev_net(skb->dev);
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  285  	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
f18fa5de5ba7f1d net/ieee802154/6lowpan/reassembly.c Alexander Aring    2018-04-20  286  	struct ieee802154_hdr hdr = {};
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  287  	int err;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  288  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  289  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  290  		goto err;
ae531b9475f62c5 net/ieee802154/reassembly.c         Phoebe Buckheister 2014-03-14  291  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  292  	err = lowpan_get_cb(skb, frag_type, cb);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  293  	if (err < 0)
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  294  		goto err;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  295  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  296  	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  297  		err = lowpan_invoke_frag_rx_handlers(skb);
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  298  		if (err == NET_RX_DROP)
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  299  			goto err;
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  300  	}
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  301  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  302  	if (cb->d_size > IPV6_MIN_MTU) {
6697dabe27e0330 net/ieee802154/reassembly.c         Martin Townsend    2014-08-19  303  		net_warn_ratelimited("lowpan_frag_rcv: datagram size exceeds MTU\n");
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  304  		goto err;
6697dabe27e0330 net/ieee802154/reassembly.c         Martin Townsend    2014-08-19  305  	}
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  306  
72a5e6bb5120d64 net/ieee802154/6lowpan/reassembly.c Alexander Aring    2015-09-02  307  	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  308  	if (fq != NULL) {
aec42e105cebf42 net/ieee802154/6lowpan/reassembly.c Eric Dumazet       2025-03-09  309  		int ret, refs = 1;
4710d806fcb8251 net/ieee802154/reassembly.c         Varka Bhadram      2014-07-02  310  
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  311  		spin_lock(&fq->q.lock);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28 @312  		ret = lowpan_frag_queue(fq, skb, frag_type);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  313  		spin_unlock(&fq->q.lock);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  314  
aec42e105cebf42 net/ieee802154/6lowpan/reassembly.c Eric Dumazet       2025-03-09  315  		inet_frag_putn(&fq->q, refs);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  316  		return ret;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  317  	}
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  318  
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  319  err:
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  320  	kfree_skb(skb);
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  321  	return -1;
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  322  }
7240cdec60b136f net/ieee802154/reassembly.c         Alexander Aring    2014-02-28  323  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

