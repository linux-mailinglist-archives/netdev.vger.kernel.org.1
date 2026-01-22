Return-Path: <netdev+bounces-252214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cElzI4aycWkILgAAu9opvQ
	(envelope-from <netdev+bounces-252214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837E61EFF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4404E2402
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAA466B55;
	Thu, 22 Jan 2026 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFZ4G1On"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C7392C40
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058945; cv=none; b=rID60rv8XEnudY/lR3BPeQlre5b2cXj6eXOshg/y/7QsYOyR3uKU4VrC7YfanyVUtmLWP0Icbvm8FmcDNEHRikML1vra3u95N7nC3RHhLNEdACYa2t9Vdhl/9nIUoT0p3judyYLCOswgCezin9IU74uosEeV+4tANsIYL99Nsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058945; c=relaxed/simple;
	bh=hP8q1GcQAGHznfJlly/EuvMei2lZrgd9YlR+qVlMSqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lln0ZQPZwOxIEokkrVOpcNlt+WRkep7F2Gjtr6ijB+PvhIXazE/FIQvfIvNHYNF4RTGzjZh+2YSCXtz0/JPOZFBYZbjT5JAvQcHor+f8dEMtdONm1lKpwnp3H+cgnROtuTdslA7ORZYWdGB9G93FgPzoodQmgA08a02ZcCQLhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFZ4G1On; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769058942; x=1800594942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hP8q1GcQAGHznfJlly/EuvMei2lZrgd9YlR+qVlMSqg=;
  b=TFZ4G1OnHZNKzcJsIbqfYegA62UQSNzGZPNyje0wBCYlpdE7LG/6AdAg
   67VB9Y9zb93q4xqGHlr/Qikog77RA9Kr4fhFqVeb+zI2z+HULhuiEa9xQ
   1dsj52QPP8cKO5NpZD3VZxd9ylncZxbKCmHZ2zygTv7tUmrRBkmAIG3ys
   pbbc9LHHrmrG4CqjVAYeV2ciSe5QzlFobSEnqP6Na9C31aZe/rF39z4FG
   LgaDcnDaPFpiHQ2ZS+UhLPsNL80BYQYkOweSu+xvW49kPXx5an1nIwsVO
   fsx4SNa2Np+7aXx7iwI6HVa7snqRhrrhbQcdkvgFi1K9ccqhK0/nJDinG
   Q==;
X-CSE-ConnectionGUID: NfO17NcmS3+U4B1fQ5pxJw==
X-CSE-MsgGUID: bUovMYmFTxCwnOqxrw3dmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81014339"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81014339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 21:15:41 -0800
X-CSE-ConnectionGUID: dmtn0ckBQJy4dj+7K1ZqLw==
X-CSE-MsgGUID: Dt4uNYphQyiuB2yZQyaRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206700158"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Jan 2026 21:15:37 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vin2c-00000000STB-3Lx0;
	Thu, 22 Jan 2026 05:15:34 +0000
Date: Thu, 22 Jan 2026 13:15:08 +0800
From: kernel test robot <lkp@intel.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH v4 2/3] tls: add hardware offload key update support
Message-ID: <202601221215.VSoxPBxE-lkp@intel.com>
References: <20260121215727.3994324-3-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215727.3994324-3-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252214-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 8837E61EFF
X-Rspamd-Action: no action

Hi Rishikesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc6 next-20260121]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rishikesh-Jethwani/tls-add-TLS-1-3-hardware-offload-support/20260122-060724
base:   linus/master
patch link:    https://lore.kernel.org/r/20260121215727.3994324-3-rjethwani%40purestorage.com
patch subject: [PATCH v4 2/3] tls: add hardware offload key update support
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260122/202601221215.VSoxPBxE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221215.VSoxPBxE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601221215.VSoxPBxE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/crypto/aead.h:11,
                    from net/tls/tls_device.c:32:
   net/tls/tls_device.c: In function 'tls_set_device_offload':
>> arch/parisc/include/asm/barrier.h:36:28: error: field '__val' declared as a function
      36 |         union { typeof(*p) __val; char __c[1]; } __u =                  \
         |                            ^~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   net/tls/tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~
>> arch/parisc/include/asm/barrier.h:37:28: error: cast specifies function type
      37 |                 { .__val = (__force typeof(*p)) (v) };                  \
         |                            ^
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   net/tls/tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~
--
   In file included from arch/parisc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/crypto/aead.h:11,
                    from tls_device.c:32:
   tls_device.c: In function 'tls_set_device_offload':
>> arch/parisc/include/asm/barrier.h:36:28: error: field '__val' declared as a function
      36 |         union { typeof(*p) __val; char __c[1]; } __u =                  \
         |                            ^~~~~
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~
>> arch/parisc/include/asm/barrier.h:37:28: error: cast specifies function type
      37 |                 { .__val = (__force typeof(*p)) (v) };                  \
         |                            ^
   include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   tls_device.c:1249:25: note: in expansion of macro 'smp_store_release'
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~


vim +/__val +36 arch/parisc/include/asm/barrier.h

fedb8da96355f5f John David Anglin 2018-08-05  32  
e96ebd589debd9a John David Anglin 2020-07-30  33  #define __smp_store_release(p, v)					\
e96ebd589debd9a John David Anglin 2020-07-30  34  do {									\
e96ebd589debd9a John David Anglin 2020-07-30  35  	typeof(p) __p = (p);						\
e96ebd589debd9a John David Anglin 2020-07-30 @36          union { typeof(*p) __val; char __c[1]; } __u =			\
e96ebd589debd9a John David Anglin 2020-07-30 @37                  { .__val = (__force typeof(*p)) (v) };			\
e96ebd589debd9a John David Anglin 2020-07-30  38  	compiletime_assert_atomic_type(*p);				\
e96ebd589debd9a John David Anglin 2020-07-30  39  	switch (sizeof(*p)) {						\
e96ebd589debd9a John David Anglin 2020-07-30  40  	case 1:								\
e96ebd589debd9a John David Anglin 2020-07-30  41  		asm volatile("stb,ma %0,0(%1)"				\
e96ebd589debd9a John David Anglin 2020-07-30  42  				: : "r"(*(__u8 *)__u.__c), "r"(__p)	\
e96ebd589debd9a John David Anglin 2020-07-30  43  				: "memory");				\
e96ebd589debd9a John David Anglin 2020-07-30  44  		break;							\
e96ebd589debd9a John David Anglin 2020-07-30  45  	case 2:								\
e96ebd589debd9a John David Anglin 2020-07-30  46  		asm volatile("sth,ma %0,0(%1)"				\
e96ebd589debd9a John David Anglin 2020-07-30  47  				: : "r"(*(__u16 *)__u.__c), "r"(__p)	\
e96ebd589debd9a John David Anglin 2020-07-30  48  				: "memory");				\
e96ebd589debd9a John David Anglin 2020-07-30  49  		break;							\
e96ebd589debd9a John David Anglin 2020-07-30  50  	case 4:								\
e96ebd589debd9a John David Anglin 2020-07-30  51  		asm volatile("stw,ma %0,0(%1)"				\
e96ebd589debd9a John David Anglin 2020-07-30  52  				: : "r"(*(__u32 *)__u.__c), "r"(__p)	\
e96ebd589debd9a John David Anglin 2020-07-30  53  				: "memory");				\
e96ebd589debd9a John David Anglin 2020-07-30  54  		break;							\
e96ebd589debd9a John David Anglin 2020-07-30  55  	case 8:								\
e96ebd589debd9a John David Anglin 2020-07-30  56  		if (IS_ENABLED(CONFIG_64BIT))				\
e96ebd589debd9a John David Anglin 2020-07-30  57  			asm volatile("std,ma %0,0(%1)"			\
e96ebd589debd9a John David Anglin 2020-07-30  58  				: : "r"(*(__u64 *)__u.__c), "r"(__p)	\
e96ebd589debd9a John David Anglin 2020-07-30  59  				: "memory");				\
e96ebd589debd9a John David Anglin 2020-07-30  60  		break;							\
e96ebd589debd9a John David Anglin 2020-07-30  61  	}								\
e96ebd589debd9a John David Anglin 2020-07-30  62  } while (0)
e96ebd589debd9a John David Anglin 2020-07-30  63  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

