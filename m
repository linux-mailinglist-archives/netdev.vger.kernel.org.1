Return-Path: <netdev+bounces-262455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G4CFTi4pGlJpwUAu9opvQ
	(envelope-from <netdev+bounces-262455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:05:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A92961D1CC9
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380ED300F5C9
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9963317169;
	Sun,  1 Mar 2026 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk7o7rB/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BB29E114
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772402741; cv=none; b=gC4SkuCxC/2nXLRblPpAyNJhmxOiMNl1pFtmmzNKdBpz5+fu+BKe3/Ys+nHhni2bpHwcCqyw3rloXj71h78wgEo7+5ktRgJUNmDyk2GKcuuIuQHJAG0wZhITkOJHZurGGIUQ3ZAriwoUqRfsQTTaQ3uJ4TQTNIzpatdgpfWQKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772402741; c=relaxed/simple;
	bh=hIFvynwrg0mFOxpjKosbsObtRC54+v13MBvkOJqqoBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umN3EjoWcEUQ9OFhMex7A4dF47MxQvebByrPJ6THnAjum7KvLr/OMEo1r1BL+b8h2ifWuW5tEK/nFrhCtRj68TakvqVjeg56n+gazQIrOc1atOe21l2GP79TUYO8Nqnho8Ld2O4gMsklMhANXl8L1QljTCcSzYKsJCNzx5sd60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk7o7rB/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772402739; x=1803938739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIFvynwrg0mFOxpjKosbsObtRC54+v13MBvkOJqqoBw=;
  b=Hk7o7rB/XycvnwHJ2LTakf22Vzu/EXXwZZLIgFZS4/O8q26rW88yz1cs
   q5ho5mSQsnTgk0AtKeFdNKKq3EDvxbJZu/elY9ihsV0phQwXqHeTLVmG4
   OHi+nwU9WcwSN46pF1+/B6t7aRM/7jccv18FcGoI2a7d+68sG9FDA21Q0
   4aiFhtc8+6iGmYqud5wPO7K6hoS8d85gbIE5Zv6TC5pralWDtO2kN/XSe
   JemMxob6gBnZa2pdhgY4j4g6H9Z0nvc6uNqcyHIkaQlVLfVWiGfn7vWwX
   /l+wv/+R27cgicxKIVGQod+bXHQhdviCdxlrlo1UBR3tMA5hph6HRf2eH
   A==;
X-CSE-ConnectionGUID: bHGwvlEHSUi4Oc5/fBLVfw==
X-CSE-MsgGUID: c0JI0XvkT8O+Af2ltWlk5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84117089"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84117089"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 14:05:39 -0800
X-CSE-ConnectionGUID: yWgy/burTMGtqNyVKEN7/Q==
X-CSE-MsgGUID: Qldj/B5ASb6xWBtw0mY1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="220569555"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2026 14:05:36 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwour-0000000002f-2vnU;
	Sun, 01 Mar 2026 22:05:33 +0000
Date: Mon, 2 Mar 2026 06:05:13 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 7/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_dev_flow_table
Message-ID: <202603020519.4JHxNgoV-lkp@intel.com>
References: <20260301181457.3539105-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301181457.3539105-8-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262455-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: A92961D1CC9
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-add-rps_tag_ptr-type-and-helpers/20260302-021900
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260301181457.3539105-8-edumazet%40google.com
patch subject: [PATCH v2 net-next 7/7] net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260302/202603020519.4JHxNgoV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260302/202603020519.4JHxNgoV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603020519.4JHxNgoV-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/net-sysfs.c: In function 'store_rps_dev_flow_table_cnt':
>> net/core/net-sysfs.c:1104:41: error: implicit declaration of function 'RPS_DEV_FLOW_TABLE_SIZE' [-Wimplicit-function-declaration]
    1104 |                 if (mask > (ULONG_MAX - RPS_DEV_FLOW_TABLE_SIZE(1))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~


vim +/RPS_DEV_FLOW_TABLE_SIZE +1104 net/core/net-sysfs.c

fec5e652e58fa6 Tom Herbert       2010-04-16  1072  
f5acb907dc24c3 Eric Dumazet      2010-04-19  1073  static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
fec5e652e58fa6 Tom Herbert       2010-04-16  1074  					    const char *buf, size_t len)
fec5e652e58fa6 Tom Herbert       2010-04-16  1075  {
5b629854b594cd Eric Dumazet      2026-03-01  1076  	struct rps_dev_flow *table;
5b629854b594cd Eric Dumazet      2026-03-01  1077  	rps_tag_ptr otag, tag_ptr = 0UL;
60b778ce519625 Eric Dumazet      2011-12-24  1078  	unsigned long mask, count;
5b629854b594cd Eric Dumazet      2026-03-01  1079  	size_t sz;
60b778ce519625 Eric Dumazet      2011-12-24  1080  	int rc;
fec5e652e58fa6 Tom Herbert       2010-04-16  1081  
fec5e652e58fa6 Tom Herbert       2010-04-16  1082  	if (!capable(CAP_NET_ADMIN))
fec5e652e58fa6 Tom Herbert       2010-04-16  1083  		return -EPERM;
fec5e652e58fa6 Tom Herbert       2010-04-16  1084  
60b778ce519625 Eric Dumazet      2011-12-24  1085  	rc = kstrtoul(buf, 0, &count);
60b778ce519625 Eric Dumazet      2011-12-24  1086  	if (rc < 0)
60b778ce519625 Eric Dumazet      2011-12-24  1087  		return rc;
fec5e652e58fa6 Tom Herbert       2010-04-16  1088  
fec5e652e58fa6 Tom Herbert       2010-04-16  1089  	if (count) {
60b778ce519625 Eric Dumazet      2011-12-24  1090  		mask = count - 1;
60b778ce519625 Eric Dumazet      2011-12-24  1091  		/* mask = roundup_pow_of_two(count) - 1;
60b778ce519625 Eric Dumazet      2011-12-24  1092  		 * without overflows...
60b778ce519625 Eric Dumazet      2011-12-24  1093  		 */
60b778ce519625 Eric Dumazet      2011-12-24  1094  		while ((mask | (mask >> 1)) != mask)
60b778ce519625 Eric Dumazet      2011-12-24  1095  			mask |= (mask >> 1);
60b778ce519625 Eric Dumazet      2011-12-24  1096  		/* On 64 bit arches, must check mask fits in table->mask (u32),
8e3bff96afa673 stephen hemminger 2013-12-08  1097  		 * and on 32bit arches, must check
8e3bff96afa673 stephen hemminger 2013-12-08  1098  		 * RPS_DEV_FLOW_TABLE_SIZE(mask + 1) doesn't overflow.
60b778ce519625 Eric Dumazet      2011-12-24  1099  		 */
60b778ce519625 Eric Dumazet      2011-12-24  1100  #if BITS_PER_LONG > 32
60b778ce519625 Eric Dumazet      2011-12-24  1101  		if (mask > (unsigned long)(u32)mask)
a0a129f8b6cff5 Xi Wang           2011-12-22  1102  			return -EINVAL;
60b778ce519625 Eric Dumazet      2011-12-24  1103  #else
60b778ce519625 Eric Dumazet      2011-12-24 @1104  		if (mask > (ULONG_MAX - RPS_DEV_FLOW_TABLE_SIZE(1))
a0a129f8b6cff5 Xi Wang           2011-12-22  1105  				/ sizeof(struct rps_dev_flow)) {
fec5e652e58fa6 Tom Herbert       2010-04-16  1106  			/* Enforce a limit to prevent overflow */
fec5e652e58fa6 Tom Herbert       2010-04-16  1107  			return -EINVAL;
fec5e652e58fa6 Tom Herbert       2010-04-16  1108  		}
60b778ce519625 Eric Dumazet      2011-12-24  1109  #endif
5b629854b594cd Eric Dumazet      2026-03-01  1110  		sz = max_t(size_t, sizeof(*table) * (mask + 1),
5b629854b594cd Eric Dumazet      2026-03-01  1111  			   PAGE_SIZE);
5b629854b594cd Eric Dumazet      2026-03-01  1112  		if (sz <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) ||
5b629854b594cd Eric Dumazet      2026-03-01  1113  		    is_power_of_2(sz))
5b629854b594cd Eric Dumazet      2026-03-01  1114  			table = kvmalloc(sz, GFP_KERNEL);
5b629854b594cd Eric Dumazet      2026-03-01  1115  		else
5b629854b594cd Eric Dumazet      2026-03-01  1116  			table = vmalloc(sz);
fec5e652e58fa6 Tom Herbert       2010-04-16  1117  		if (!table)
fec5e652e58fa6 Tom Herbert       2010-04-16  1118  			return -ENOMEM;
5b629854b594cd Eric Dumazet      2026-03-01  1119  		tag_ptr = (rps_tag_ptr)table;
5b629854b594cd Eric Dumazet      2026-03-01  1120  		if (rps_tag_to_log(tag_ptr)) {
5b629854b594cd Eric Dumazet      2026-03-01  1121  			pr_err_once("store_rps_dev_flow_table_cnt() got a non page aligned allocation.\n");
5b629854b594cd Eric Dumazet      2026-03-01  1122  			kvfree(table);
5b629854b594cd Eric Dumazet      2026-03-01  1123  			return -ENOMEM;
5b629854b594cd Eric Dumazet      2026-03-01  1124  		}
5b629854b594cd Eric Dumazet      2026-03-01  1125  		tag_ptr |= (ilog2(mask) + 1);
97bcc5b6f45425 Krishna Kumar     2025-08-25  1126  		for (count = 0; count <= mask; count++) {
5b629854b594cd Eric Dumazet      2026-03-01  1127  			table[count].cpu = RPS_NO_CPU;
5b629854b594cd Eric Dumazet      2026-03-01  1128  			table[count].filter = RPS_NO_FILTER;
97bcc5b6f45425 Krishna Kumar     2025-08-25  1129  		}
6648c65e7ea72c stephen hemminger 2017-08-18  1130  	}
fec5e652e58fa6 Tom Herbert       2010-04-16  1131  
5b629854b594cd Eric Dumazet      2026-03-01  1132  	otag = xchg(&queue->rps_flow_table, tag_ptr);
5b629854b594cd Eric Dumazet      2026-03-01  1133  	if (otag)
5b629854b594cd Eric Dumazet      2026-03-01  1134  		kvfree_rcu_mightsleep(rps_tag_to_table(otag));
fec5e652e58fa6 Tom Herbert       2010-04-16  1135  
fec5e652e58fa6 Tom Herbert       2010-04-16  1136  	return len;
fec5e652e58fa6 Tom Herbert       2010-04-16  1137  }
fec5e652e58fa6 Tom Herbert       2010-04-16  1138  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

