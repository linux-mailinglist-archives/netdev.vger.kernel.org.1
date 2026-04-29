Return-Path: <netdev+bounces-282533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNtxHQmJ8mlEsQEAu9opvQ
	(envelope-from <netdev+bounces-282533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1E49B1D6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D6B301AAB1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08991449EB6;
	Wed, 29 Apr 2026 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkzlbbjH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE443AD506;
	Wed, 29 Apr 2026 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502470; cv=none; b=l96XDK02RnBEqBqPdCMbknpaSWC40YnBxFueLDlKlwzXlF/nWDdNF2acg4WhfFahAFWIX3B2P0tiSEFWcVYGRzW6WDg31XWxULyigsw17zFjbNNo+prCZLwrDIf4R/O2x3KEDN7laC1U4gGXqKpSNnMYRXhu+pu7fMkmDyxvUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502470; c=relaxed/simple;
	bh=pjEW5roKEuWh8zvw1b6sL0B2eJlxoLEgesbCJZq4DFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmH7fH4XctVjGKGoeDCRr1NwOLBb+0iCy3pUBV7ZzFalESa8JFIkkhf2EggQ+kUb/hF4DYoyKcENT4k1NTj8TNQ/LpLcS8xNhrtCEKRpBZhqB/LV45IwavpFCKiUPucoMB6GL9dZqAKsC2+grasn8x2jtoXr8QIK1PLmbe4NLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkzlbbjH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777502468; x=1809038468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pjEW5roKEuWh8zvw1b6sL0B2eJlxoLEgesbCJZq4DFM=;
  b=EkzlbbjHfigclcnn3iZmGFTAlBgV4K4LIyXSqdHZHbOTkJ8dv1MnhW/d
   Q90R2Q/RiMKesMD1isw4jdBbk8vBEV0iq8C0yWEe2/DQKQXqqr23BcwSd
   5Tc7LMAgJ2zCqWYc5IncMTI54x5j7b7eBCOjNatsUpM1jXjwLmuYSJH0H
   CkkEmc7aZ13yZGIEIyfyxSKvn1kRfFSCPokfACPTlysxWHSnD/mB3XX5Y
   p56Zim/LPH5oBUE578z9TKcSI9uEEz9oVf0zEnfimp2BX4O/RSNjPwP96
   ltr0syd7v4jiJNUc04Af0k3QhxK5MNBIKa3OczpWOi1+OPdYMw+WD5Of1
   Q==;
X-CSE-ConnectionGUID: /ljJDGwKTRK4JSP7UjDs9g==
X-CSE-MsgGUID: rtFVALuTT3uebpvDjNIUmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89818777"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89818777"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 15:41:07 -0700
X-CSE-ConnectionGUID: dvnTyNcHTW+Kf0742HLOkw==
X-CSE-MsgGUID: MOIEB+9pT6akLYlqZYsibA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2026 15:41:04 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIDaW-00000000Bbg-4A63;
	Wed, 29 Apr 2026 22:41:00 +0000
Date: Thu, 30 Apr 2026 06:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: wit_yuan <yuanzhaoming901030@126.com>, jk@codeconstruct.com.au
Cc: oe-kbuild-all@lists.linux.dev, yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com, matt@codeconstruct.com.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net:mctp: split mctp hdr version to ver and rsvd
Message-ID: <202604300641.2Ml6rWOe-lkp@intel.com>
References: <20260409125129.9210-1-yuanzhaoming901030@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409125129.9210-1-yuanzhaoming901030@126.com>
X-Rspamd-Queue-Id: E1F1E49B1D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282533-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,126.com,lenovo.com,codeconstruct.com.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com,codeconstruct.com.au];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi wit_yuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wit_yuan/net-mctp-split-mctp-hdr-version-to-ver-and-rsvd/20260414-044431
base:   linus/master
patch link:    https://lore.kernel.org/r/20260409125129.9210-1-yuanzhaoming901030%40126.com
patch subject: [PATCH] net:mctp: split mctp hdr version to ver and rsvd
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260430/202604300641.2Ml6rWOe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300641.2Ml6rWOe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300641.2Ml6rWOe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/kunit/static_stub.h:18,
                    from net/mctp/route.c:20:
   net/mctp/test/route-test.c: In function 'mctp_test_fragment':
>> net/mctp/test/route-test.c:70:39: error: 'typeof' applied to a bit-field
      70 |                 KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
         |                                       ^~~~
   include/kunit/test.h:839:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     839 |         const typeof(left) __left = (left);                                    \
         |                      ^~~~
   include/kunit/test.h:1036:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
    1036 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1033:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
    1033 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   net/mctp/test/route-test.c:70:17: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      70 |                 KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
         |                 ^~~~~~~~~~~~~~~
   net/mctp/test/route-test.c:70:50: error: 'typeof' applied to a bit-field
      70 |                 KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
         |                                                  ^~~
   include/kunit/test.h:840:22: note: in definition of macro 'KUNIT_BASE_BINARY_ASSERTION'
     840 |         const typeof(right) __right = (right);                                 \
         |                      ^~~~~
   include/kunit/test.h:1036:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
    1036 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1033:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
    1033 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   net/mctp/test/route-test.c:70:17: note: in expansion of macro 'KUNIT_EXPECT_EQ'
      70 |                 KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
         |                 ^~~~~~~~~~~~~~~


vim +/typeof +70 net/mctp/test/route-test.c

161eba50e183ed Jeremy Kerr 2021-10-03   19  
161eba50e183ed Jeremy Kerr 2021-10-03   20  static void mctp_test_fragment(struct kunit *test)
161eba50e183ed Jeremy Kerr 2021-10-03   21  {
161eba50e183ed Jeremy Kerr 2021-10-03   22  	const struct mctp_frag_test *params;
161eba50e183ed Jeremy Kerr 2021-10-03   23  	int rc, i, n, mtu, msgsize;
269936db5eb396 Jeremy Kerr 2025-07-02   24  	struct mctp_test_dev *dev;
269936db5eb396 Jeremy Kerr 2025-07-02   25  	struct mctp_dst dst;
161eba50e183ed Jeremy Kerr 2021-10-03   26  	struct sk_buff *skb;
161eba50e183ed Jeremy Kerr 2021-10-03   27  	struct mctp_hdr hdr;
161eba50e183ed Jeremy Kerr 2021-10-03   28  	u8 seq;
161eba50e183ed Jeremy Kerr 2021-10-03   29  
161eba50e183ed Jeremy Kerr 2021-10-03   30  	params = test->param_value;
161eba50e183ed Jeremy Kerr 2021-10-03   31  	mtu = params->mtu;
161eba50e183ed Jeremy Kerr 2021-10-03   32  	msgsize = params->msgsize;
161eba50e183ed Jeremy Kerr 2021-10-03   33  
161eba50e183ed Jeremy Kerr 2021-10-03   34  	hdr.ver = 1;
161eba50e183ed Jeremy Kerr 2021-10-03   35  	hdr.src = 8;
161eba50e183ed Jeremy Kerr 2021-10-03   36  	hdr.dest = 10;
161eba50e183ed Jeremy Kerr 2021-10-03   37  	hdr.flags_seq_tag = MCTP_HDR_FLAG_TO;
161eba50e183ed Jeremy Kerr 2021-10-03   38  
161eba50e183ed Jeremy Kerr 2021-10-03   39  	skb = mctp_test_create_skb(&hdr, msgsize);
161eba50e183ed Jeremy Kerr 2021-10-03   40  	KUNIT_ASSERT_TRUE(test, skb);
161eba50e183ed Jeremy Kerr 2021-10-03   41  
269936db5eb396 Jeremy Kerr 2025-07-02   42  	dev = mctp_test_create_dev();
269936db5eb396 Jeremy Kerr 2025-07-02   43  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
269936db5eb396 Jeremy Kerr 2025-07-02   44  
6ab578739a4c1f Jeremy Kerr 2025-11-26   45  	mctp_test_dst_setup(test, &dst, dev, mtu);
161eba50e183ed Jeremy Kerr 2021-10-03   46  
269936db5eb396 Jeremy Kerr 2025-07-02   47  	rc = mctp_do_fragment_route(&dst, skb, mtu, MCTP_TAG_OWNER);
161eba50e183ed Jeremy Kerr 2021-10-03   48  	KUNIT_EXPECT_FALSE(test, rc);
161eba50e183ed Jeremy Kerr 2021-10-03   49  
6ab578739a4c1f Jeremy Kerr 2025-11-26   50  	n = dev->pkts.qlen;
161eba50e183ed Jeremy Kerr 2021-10-03   51  	KUNIT_EXPECT_EQ(test, n, params->n_frags);
161eba50e183ed Jeremy Kerr 2021-10-03   52  
161eba50e183ed Jeremy Kerr 2021-10-03   53  	for (i = 0;; i++) {
161eba50e183ed Jeremy Kerr 2021-10-03   54  		struct mctp_hdr *hdr2;
161eba50e183ed Jeremy Kerr 2021-10-03   55  		struct sk_buff *skb2;
161eba50e183ed Jeremy Kerr 2021-10-03   56  		u8 tag_mask, seq2;
161eba50e183ed Jeremy Kerr 2021-10-03   57  		bool first, last;
161eba50e183ed Jeremy Kerr 2021-10-03   58  
161eba50e183ed Jeremy Kerr 2021-10-03   59  		first = i == 0;
161eba50e183ed Jeremy Kerr 2021-10-03   60  		last = i == (n - 1);
161eba50e183ed Jeremy Kerr 2021-10-03   61  
6ab578739a4c1f Jeremy Kerr 2025-11-26   62  		skb2 = skb_dequeue(&dev->pkts);
161eba50e183ed Jeremy Kerr 2021-10-03   63  		if (!skb2)
161eba50e183ed Jeremy Kerr 2021-10-03   64  			break;
161eba50e183ed Jeremy Kerr 2021-10-03   65  
161eba50e183ed Jeremy Kerr 2021-10-03   66  		hdr2 = mctp_hdr(skb2);
161eba50e183ed Jeremy Kerr 2021-10-03   67  
161eba50e183ed Jeremy Kerr 2021-10-03   68  		tag_mask = MCTP_HDR_TAG_MASK | MCTP_HDR_FLAG_TO;
161eba50e183ed Jeremy Kerr 2021-10-03   69  
161eba50e183ed Jeremy Kerr 2021-10-03  @70  		KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
161eba50e183ed Jeremy Kerr 2021-10-03   71  		KUNIT_EXPECT_EQ(test, hdr2->src, hdr.src);
161eba50e183ed Jeremy Kerr 2021-10-03   72  		KUNIT_EXPECT_EQ(test, hdr2->dest, hdr.dest);
161eba50e183ed Jeremy Kerr 2021-10-03   73  		KUNIT_EXPECT_EQ(test, hdr2->flags_seq_tag & tag_mask,
161eba50e183ed Jeremy Kerr 2021-10-03   74  				hdr.flags_seq_tag & tag_mask);
161eba50e183ed Jeremy Kerr 2021-10-03   75  
161eba50e183ed Jeremy Kerr 2021-10-03   76  		KUNIT_EXPECT_EQ(test,
161eba50e183ed Jeremy Kerr 2021-10-03   77  				!!(hdr2->flags_seq_tag & MCTP_HDR_FLAG_SOM), first);
161eba50e183ed Jeremy Kerr 2021-10-03   78  		KUNIT_EXPECT_EQ(test,
161eba50e183ed Jeremy Kerr 2021-10-03   79  				!!(hdr2->flags_seq_tag & MCTP_HDR_FLAG_EOM), last);
161eba50e183ed Jeremy Kerr 2021-10-03   80  
161eba50e183ed Jeremy Kerr 2021-10-03   81  		seq2 = (hdr2->flags_seq_tag >> MCTP_HDR_SEQ_SHIFT) &
161eba50e183ed Jeremy Kerr 2021-10-03   82  			MCTP_HDR_SEQ_MASK;
161eba50e183ed Jeremy Kerr 2021-10-03   83  
161eba50e183ed Jeremy Kerr 2021-10-03   84  		if (first) {
161eba50e183ed Jeremy Kerr 2021-10-03   85  			seq = seq2;
161eba50e183ed Jeremy Kerr 2021-10-03   86  		} else {
161eba50e183ed Jeremy Kerr 2021-10-03   87  			seq++;
161eba50e183ed Jeremy Kerr 2021-10-03   88  			KUNIT_EXPECT_EQ(test, seq2, seq & MCTP_HDR_SEQ_MASK);
161eba50e183ed Jeremy Kerr 2021-10-03   89  		}
161eba50e183ed Jeremy Kerr 2021-10-03   90  
161eba50e183ed Jeremy Kerr 2021-10-03   91  		if (!last)
161eba50e183ed Jeremy Kerr 2021-10-03   92  			KUNIT_EXPECT_EQ(test, skb2->len, mtu);
161eba50e183ed Jeremy Kerr 2021-10-03   93  		else
161eba50e183ed Jeremy Kerr 2021-10-03   94  			KUNIT_EXPECT_LE(test, skb2->len, mtu);
161eba50e183ed Jeremy Kerr 2021-10-03   95  
161eba50e183ed Jeremy Kerr 2021-10-03   96  		kfree_skb(skb2);
161eba50e183ed Jeremy Kerr 2021-10-03   97  	}
161eba50e183ed Jeremy Kerr 2021-10-03   98  
6ab578739a4c1f Jeremy Kerr 2025-11-26   99  	mctp_dst_release(&dst);
269936db5eb396 Jeremy Kerr 2025-07-02  100  	mctp_test_destroy_dev(dev);
161eba50e183ed Jeremy Kerr 2021-10-03  101  }
161eba50e183ed Jeremy Kerr 2021-10-03  102  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

