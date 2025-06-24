Return-Path: <netdev+bounces-200495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDEEAE5AA6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE96443D9D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01899214801;
	Tue, 24 Jun 2025 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/W7ykKo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39591DEFE6
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750737453; cv=none; b=c7T2JMjQ8hEgd8tHxwKhZGeJ4tJuezUXf4qyBHqgH1cHWcjlEhMn3PKLd7kjStMzuOeD5R5shgbvW7ETCWBkvNmba4yRHhWNrJ6dS0cK4SZlhSgAy8vjwcYHYa7df4qsbxl04BaHRNpXyhnvUybDlMyvxWBR0kJWXeYXvnVbuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750737453; c=relaxed/simple;
	bh=Fs8LraFZdQA097dY2HjMryOtBWhp6iCJS/GhuYtPJ+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWW2Rl7aCAbZO7HuppgFSdaygU35+WYTIsT7zBsDp7hE50Yk2RCvUnFu1DdewMHZw9RDaFlAoBMEryuMbNGOT4MD75ypfEnjGvmtwkLRBvMFKMsNGIhMUsbEMWgS6KY52nE+QxAzp0U+3EW/ydzcUeOuniNn24psTDf4zihCm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/W7ykKo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750737452; x=1782273452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fs8LraFZdQA097dY2HjMryOtBWhp6iCJS/GhuYtPJ+8=;
  b=I/W7ykKoGsa+14j1Ue3OH9e2S4sUS1/AKvmWSsTVbD7fWiBG+e0SMz8r
   yxI0ZIJuF7TaLPJ4VQz2EHDVtgvN1BqSTpB5GuD8y881zQm/fsu0I2cL2
   0ScizzFv2g8r5dj5bUxUBTWOwRSp4vbuoK8hApdLAKS4hzBOsQB8glFke
   8SHlKPGOzTJo1RIsNFta0GDWy+HwaS5h0/BT8BkGATmFH9309POLcG8GP
   YzLD32aPHKQbIFOagZ8E2xtk/AQzL6IEbijXviY7PKjsxJ9Lb3dxXEELP
   3Q3vXYvlNJVvw/jJuhxYxoSzEJExzyG1HTG7RWq271+mS9WVqkFkWO/xK
   Q==;
X-CSE-ConnectionGUID: /OdUZ1BzSse3NmgUy+j0Rw==
X-CSE-MsgGUID: bbNWvMgCR22CHeFCaGeXxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52899995"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52899995"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 20:57:25 -0700
X-CSE-ConnectionGUID: dpjbzf3XS4m7jqMoABnBPw==
X-CSE-MsgGUID: LdtBh5cOTfmlG0yc4B4xVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157282859"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2025 20:57:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTume-000RhP-2T;
	Tue, 24 Jun 2025 03:57:20 +0000
Date: Tue, 24 Jun 2025 11:56:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/13] net: mctp: separate routing database
 from routing operations
Message-ID: <202506241117.wd6sbUKA-lkp@intel.com>
References: <20250619-dev-forwarding-v2-2-3f81801b06c2@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-dev-forwarding-v2-2-3f81801b06c2@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0097c4195b1d0ca57d15979626c769c74747b5a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-don-t-use-source-cb-data-when-forwarding-ensure-pkt_type-is-set/20250619-160339
base:   0097c4195b1d0ca57d15979626c769c74747b5a0
patch link:    https://lore.kernel.org/r/20250619-dev-forwarding-v2-2-3f81801b06c2%40codeconstruct.com.au
patch subject: [PATCH net-next v2 02/13] net: mctp: separate routing database from routing operations
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250624/202506241117.wd6sbUKA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506241117.wd6sbUKA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506241117.wd6sbUKA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mctp/route.c:1554:
   net/mctp/test/route-test.c: In function 'mctp_test_route_input_cloned_frag':
>> net/mctp/test/route-test.c:1091:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1091 | }
         | ^


vim +1091 net/mctp/test/route-test.c

ce1219c3f76bb1 Jeremy Kerr   2024-12-18   983  
f5d83cf0eeb90f Matt Johnston 2025-03-06   984  /* Input route to socket, using a fragmented message created from clones.
f5d83cf0eeb90f Matt Johnston 2025-03-06   985   */
f5d83cf0eeb90f Matt Johnston 2025-03-06   986  static void mctp_test_route_input_cloned_frag(struct kunit *test)
f5d83cf0eeb90f Matt Johnston 2025-03-06   987  {
f5d83cf0eeb90f Matt Johnston 2025-03-06   988  	/* 5 packet fragments, forming 2 complete messages */
f5d83cf0eeb90f Matt Johnston 2025-03-06   989  	const struct mctp_hdr hdrs[5] = {
f5d83cf0eeb90f Matt Johnston 2025-03-06   990  		RX_FRAG(FL_S, 0),
f5d83cf0eeb90f Matt Johnston 2025-03-06   991  		RX_FRAG(0, 1),
f5d83cf0eeb90f Matt Johnston 2025-03-06   992  		RX_FRAG(FL_E, 2),
f5d83cf0eeb90f Matt Johnston 2025-03-06   993  		RX_FRAG(FL_S, 0),
f5d83cf0eeb90f Matt Johnston 2025-03-06   994  		RX_FRAG(FL_E, 1),
f5d83cf0eeb90f Matt Johnston 2025-03-06   995  	};
fb025ae64bd1f2 Jeremy Kerr   2025-06-19   996  	struct mctp_test_pktqueue tpq;
f5d83cf0eeb90f Matt Johnston 2025-03-06   997  	struct mctp_test_dev *dev;
f5d83cf0eeb90f Matt Johnston 2025-03-06   998  	struct sk_buff *skb[5];
f5d83cf0eeb90f Matt Johnston 2025-03-06   999  	struct sk_buff *rx_skb;
fb025ae64bd1f2 Jeremy Kerr   2025-06-19  1000  	struct mctp_dst dst;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1001  	struct socket *sock;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1002  	size_t data_len;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1003  	u8 compare[100];
f5d83cf0eeb90f Matt Johnston 2025-03-06  1004  	u8 flat[100];
f5d83cf0eeb90f Matt Johnston 2025-03-06  1005  	size_t total;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1006  	void *p;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1007  	int rc;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1008  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1009  	/* Arbitrary length */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1010  	data_len = 3;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1011  	total = data_len + sizeof(struct mctp_hdr);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1012  
fb025ae64bd1f2 Jeremy Kerr   2025-06-19  1013  	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1014  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1015  	/* Create a single skb initially with concatenated packets */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1016  	skb[0] = mctp_test_create_skb(&hdrs[0], 5 * total);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1017  	mctp_test_skb_set_dev(skb[0], dev);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1018  	memset(skb[0]->data, 0 * 0x11, skb[0]->len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1019  	memcpy(skb[0]->data, &hdrs[0], sizeof(struct mctp_hdr));
f5d83cf0eeb90f Matt Johnston 2025-03-06  1020  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1021  	/* Extract and populate packets */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1022  	for (int i = 1; i < 5; i++) {
f5d83cf0eeb90f Matt Johnston 2025-03-06  1023  		skb[i] = skb_clone(skb[i - 1], GFP_ATOMIC);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1024  		KUNIT_ASSERT_TRUE(test, skb[i]);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1025  		p = skb_pull(skb[i], total);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1026  		KUNIT_ASSERT_TRUE(test, p);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1027  		skb_reset_network_header(skb[i]);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1028  		memcpy(skb[i]->data, &hdrs[i], sizeof(struct mctp_hdr));
f5d83cf0eeb90f Matt Johnston 2025-03-06  1029  		memset(&skb[i]->data[sizeof(struct mctp_hdr)], i * 0x11, data_len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1030  	}
f5d83cf0eeb90f Matt Johnston 2025-03-06  1031  	for (int i = 0; i < 5; i++)
f5d83cf0eeb90f Matt Johnston 2025-03-06  1032  		skb_trim(skb[i], total);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1033  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1034  	/* SOM packets have a type byte to match the socket */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1035  	skb[0]->data[4] = 0;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1036  	skb[3]->data[4] = 0;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1037  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1038  	skb_dump("pkt1 ", skb[0], false);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1039  	skb_dump("pkt2 ", skb[1], false);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1040  	skb_dump("pkt3 ", skb[2], false);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1041  	skb_dump("pkt4 ", skb[3], false);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1042  	skb_dump("pkt5 ", skb[4], false);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1043  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1044  	for (int i = 0; i < 5; i++) {
f5d83cf0eeb90f Matt Johnston 2025-03-06  1045  		KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1046  		/* Take a reference so we can check refcounts at the end */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1047  		skb_get(skb[i]);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1048  	}
f5d83cf0eeb90f Matt Johnston 2025-03-06  1049  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1050  	/* Feed the fragments into MCTP core */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1051  	for (int i = 0; i < 5; i++) {
fb025ae64bd1f2 Jeremy Kerr   2025-06-19  1052  		rc = mctp_dst_input(&dst, skb[i]);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1053  		KUNIT_EXPECT_EQ(test, rc, 0);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1054  	}
f5d83cf0eeb90f Matt Johnston 2025-03-06  1055  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1056  	/* Receive first reassembled message */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1057  	rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1058  	KUNIT_EXPECT_EQ(test, rc, 0);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1059  	KUNIT_EXPECT_EQ(test, rx_skb->len, 3 * data_len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1060  	rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1061  	for (int i = 0; i < rx_skb->len; i++)
f5d83cf0eeb90f Matt Johnston 2025-03-06  1062  		compare[i] = (i / data_len) * 0x11;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1063  	/* Set type byte */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1064  	compare[0] = 0;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1065  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1066  	KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1067  	KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1068  	kfree_skb(rx_skb);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1069  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1070  	/* Receive second reassembled message */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1071  	rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1072  	KUNIT_EXPECT_EQ(test, rc, 0);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1073  	KUNIT_EXPECT_EQ(test, rx_skb->len, 2 * data_len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1074  	rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1075  	for (int i = 0; i < rx_skb->len; i++)
f5d83cf0eeb90f Matt Johnston 2025-03-06  1076  		compare[i] = (i / data_len + 3) * 0x11;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1077  	/* Set type byte */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1078  	compare[0] = 0;
f5d83cf0eeb90f Matt Johnston 2025-03-06  1079  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1080  	KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1081  	KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1082  	kfree_skb(rx_skb);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1083  
f5d83cf0eeb90f Matt Johnston 2025-03-06  1084  	/* Check input skb refcounts */
f5d83cf0eeb90f Matt Johnston 2025-03-06  1085  	for (int i = 0; i < 5; i++) {
f5d83cf0eeb90f Matt Johnston 2025-03-06  1086  		KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1087  		kfree_skb(skb[i]);
f5d83cf0eeb90f Matt Johnston 2025-03-06  1088  	}
f5d83cf0eeb90f Matt Johnston 2025-03-06  1089  
fb025ae64bd1f2 Jeremy Kerr   2025-06-19  1090  	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
f5d83cf0eeb90f Matt Johnston 2025-03-06 @1091  }
f5d83cf0eeb90f Matt Johnston 2025-03-06  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

