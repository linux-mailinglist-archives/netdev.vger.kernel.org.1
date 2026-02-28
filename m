Return-Path: <netdev+bounces-262102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPgiLwapomkn4wQAu9opvQ
	(envelope-from <netdev+bounces-262102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 09:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 227071C171F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8B130FC15B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E373E8C54;
	Sat, 28 Feb 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxzUkANM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC73D903F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772267403; cv=none; b=jGbHa0xaoybHmwU5AyQtoc6Zcig/+OeuSAmy3W80juySr2qUyeAcle8pZjxuxTQmjt81kc7flO+WUh3DZA+XuLpxCWSbqpQ+qNHpu+ydNtH8kEIsjnsGmveNy2hJtywLGlGaTYTlNjWv81IpbsFabCSRqbv8yMmGmA10gwAhm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772267403; c=relaxed/simple;
	bh=hXYQE1qbObzmL1O/Q4d36UceSrJjyDNFocNGQZv1ouk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3pY83zre+UDvtxeTkM7b0mhbwheeQ1WOqApniGjGdmZhUevCI5i2zO1+70JuNNYfpVPTmt/L/y/hWRa4a/1Y+QzW6Ce0mWF1r2HzRSZGWuM21WhLkU5iqeEfhbU/U+aqu2zRjtDARcgHarip9OeLkKDhUDH4EfdRGK8oLgtdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxzUkANM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772267401; x=1803803401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXYQE1qbObzmL1O/Q4d36UceSrJjyDNFocNGQZv1ouk=;
  b=fxzUkANM0/z3xTGDoi8BT58U333pAdLK5opb85N/fYuSgnUxo8xiAta+
   70SZ7txOt04kBqFG8zWuht2CIoMY5Z16Ts+pi3MidP5UC7OWoOvaD8FfC
   8JTuBj8NA0lYEP6jM8cIqC+/OF0gzXe0x+FDYZZtIPsisd8+EtFgtPKkb
   XcGEA0tQrXh8ahaUDmzJdpsVkgpRm9ZORMDncs/UZr4HkDaCFxXNTJUnB
   N+VunR6QMqqaKmTXpqaXO0Iwn25Y/tMJ04VgUc+7zR3lQVa+1g0YtSLEL
   d5lLCh4Uamy9AbStQYOmbrX1bPFYunXPDcJyhEmr3vUuqrqIQn7GF1Z+e
   g==;
X-CSE-ConnectionGUID: uuoqmX8uT1KXuhxIUsSsRQ==
X-CSE-MsgGUID: ihxX2r1eQ5mXt1VnTtZ4Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73411088"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73411088"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:30:00 -0800
X-CSE-ConnectionGUID: GeofjTfZRQ+ivhIwMWTDug==
X-CSE-MsgGUID: WV5RXn+PTxSMcd2xPz2TTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221627062"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:29:57 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwFhm-00000000BP1-04k0;
	Sat, 28 Feb 2026 08:29:44 +0000
Date: Sat, 28 Feb 2026 16:28:55 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 4/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_sock_flow_table
Message-ID: <202602281655.561YHaO9-lkp@intel.com>
References: <20260228042503.3726451-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228042503.3726451-5-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-262102-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 227071C171F
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-add-rps_tag_ptr-type-and-helpers/20260228-122855
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260228042503.3726451-5-edumazet%40google.com
patch subject: [PATCH net-next 4/7] net-sysfs: use rps_tag_ptr and remove metadata from rps_sock_flow_table
config: s390-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260228/202602281655.561YHaO9-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281655.561YHaO9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281655.561YHaO9-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/core/net-sysfs.c:28:
>> include/net/rps.h:64:7: error: flexible array member in a struct with no named members
     u32  ents[];
          ^~~~
   include/net/rps.h: In function 'rps_record_sock_flow':
>> include/net/rps.h:72:15: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     unsigned int index = hash & rps_tag_to_mask(tag_ptr);
                  ^~~~~
   include/net/rps.h: In function '_sock_rps_delete_flow':
   include/net/rps.h:124:12: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     u32 hash, index;
               ^~~~~
--
   In file included from net/core/dev.c:164:
>> include/net/rps.h:64:7: error: flexible array member in a struct with no named members
     u32  ents[];
          ^~~~
   include/net/rps.h: In function 'rps_record_sock_flow':
>> include/net/rps.h:72:15: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     unsigned int index = hash & rps_tag_to_mask(tag_ptr);
                  ^~~~~
   include/net/rps.h: In function '_sock_rps_delete_flow':
   include/net/rps.h:124:12: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     u32 hash, index;
               ^~~~~
   net/core/dev.c: In function 'get_rps_cpu':
>> net/core/dev.c:5116:7: warning: variable 'flow_id' set but not used [-Wunused-but-set-variable]
      u32 flow_id;
          ^~~~~~~


vim +64 include/net/rps.h

    41	
    42	/*
    43	 * The rps_dev_flow_table structure contains a table of flow mappings.
    44	 */
    45	struct rps_dev_flow_table {
    46		u8			log;
    47		struct rcu_head		rcu;
    48		struct rps_dev_flow	flows[];
    49	};
    50	#define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
    51	    ((_num) * sizeof(struct rps_dev_flow)))
    52	
    53	/*
    54	 * The rps_sock_flow_table contains mappings of flows to the last CPU
    55	 * on which they were processed by the application (set in recvmsg).
    56	 * Each entry is a 32bit value. Upper part is the high-order bits
    57	 * of flow hash, lower part is CPU number.
    58	 * rps_cpu_mask is used to partition the space, depending on number of
    59	 * possible CPUs : rps_cpu_mask = roundup_pow_of_two(nr_cpu_ids) - 1
    60	 * For example, if 64 CPUs are possible, rps_cpu_mask = 0x3f,
    61	 * meaning we use 32-6=26 bits for the hash.
    62	 */
    63	struct rps_sock_flow_table {
  > 64		u32		ents[];
    65	};
    66	#define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
    67	
    68	#define RPS_NO_CPU 0xffff
    69	
    70	static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
    71	{
  > 72		unsigned int index = hash & rps_tag_to_mask(tag_ptr);
    73		u32 val = hash & ~net_hotdata.rps_cpu_mask;
    74		struct rps_sock_flow_table *table;
    75	
    76		/* We only give a hint, preemption can change CPU under us */
    77		val |= raw_smp_processor_id();
    78	
    79		table = rps_tag_to_table(tag_ptr);
    80		/* The following WRITE_ONCE() is paired with the READ_ONCE()
    81		 * here, and another one in get_rps_cpu().
    82		 */
    83		if (READ_ONCE(table->ents[index]) != val)
    84			WRITE_ONCE(table->ents[index], val);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

