Return-Path: <netdev+bounces-272612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCkSO0uoxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3DB3470B0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8BB3013882
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D3306D2A;
	Fri, 27 Mar 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP3uBAG4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444C3164B7;
	Fri, 27 Mar 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626591; cv=none; b=XfXaijngakmrJvgd88zbxnZ2Qw4jvrD7oEdrdmyIn8j0DzuOB0ZFgBy+hSmEITZtaI1vxBGZ0VdnzxvqXrA03+6AIoqOEYLlW7Tz4cSc6g8IV+3uW53Pcg1Ps6XkphmEXgaiGzdVOPMQYrEg7Fym4sRcqd3KFlfthFBDRAhG7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626591; c=relaxed/simple;
	bh=M+nenQkxk8SdEgDxtuXflZdhUfZnrTKyoQ5HfwuEvFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQI86YVcLDLvq6VZEf/iHbZtMZugkBAAZ9R8pbad3fCrASGU0bEj6KXTmUfywFk+gb40f0bZKJ/+GryLIpxuqX1Y6UUDE/QKhf3DcgJAFuy0BZMwUHRZEROXgbrfw2xQcgvxyLzdyQ2Zs2RBF5eN8gq60Ij4dggKfwArtc0b9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP3uBAG4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774626588; x=1806162588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+nenQkxk8SdEgDxtuXflZdhUfZnrTKyoQ5HfwuEvFU=;
  b=mP3uBAG4SDSU3BVOxoHm2tNOCUtzGinSJtk/2WzMl2iZIvSu1EAU4Z9v
   tilIfHkCq/O4eIVvQ7L6WTqpKqj9yRMy87hWwoFhlI2ZtQbhMV1QEgskm
   COZzFewaVcf4RKq5c1/7hypwCXPwBJercCWfQVOwPZop6x808QCUOaojw
   OmnzQkmCZImTHH65BzV+1Aoq7tbegnOZzRS0aUlZiEnvmNtBmqX4ePcUd
   MNxHxAKdPehD+7iv21DbgWtDHHHQ4IxCS9OqxqEx68MReg+HeheYcFddY
   1qFb03tlImOD+anMqItFd2mFuj5VzBcZN/Eqgsn8yEMlLfEy2Kahy39A4
   A==;
X-CSE-ConnectionGUID: H9CS6T4+RkuUpSxA8GluOg==
X-CSE-MsgGUID: xusTei1QR0OzWhFNwCv9xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75900933"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75900933"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 08:49:47 -0700
X-CSE-ConnectionGUID: rhMmywIISfyt2nMaqFTYlQ==
X-CSE-MsgGUID: oyaYUmESTK+CrBvs8Tvlag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="226952013"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2026 08:49:44 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w69RN-00000000AQ9-0GBY;
	Fri, 27 Mar 2026 15:49:41 +0000
Date: Fri, 27 Mar 2026 23:49:35 +0800
From: kernel test robot <lkp@intel.com>
To: Ujjal Roy <royujjal@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Message-ID: <202603272318.WLQHm8jS-lkp@intel.com>
References: <20260326150742.50289-3-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326150742.50289-3-royujjal@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272612-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B3DB3470B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ujjal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main klassert-ipsec/master linus/master v7.0-rc5 next-20260326]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ujjal-Roy/ipv4-igmp-get-rid-of-IGMPV3_-QQIC-MRC-and-simplify-calculation/20260327-083159
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260326150742.50289-3-royujjal%40gmail.com
patch subject: [PATCH 2/4] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
config: x86_64-randconfig-121-20260327 (https://download.01.org/0day-ci/archive/20260327/202603272318.WLQHm8jS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603272318.WLQHm8jS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603272318.WLQHm8jS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv6/mcast.c: note: in included file:
   include/net/mld.h:32:43: sparse: sparse: array of flexible structures
>> include/net/mld.h:147:30: sparse: sparse: cast to restricted __be16

vim +147 include/net/mld.h

    29	
    30	struct mld2_report {
    31		struct icmp6hdr		mld2r_hdr;
  > 32		struct mld2_grec	mld2r_grec[];
    33	};
    34	
    35	#define mld2r_type		mld2r_hdr.icmp6_type
    36	#define mld2r_resv1		mld2r_hdr.icmp6_code
    37	#define mld2r_cksum		mld2r_hdr.icmp6_cksum
    38	#define mld2r_resv2		mld2r_hdr.icmp6_dataun.un_data16[0]
    39	#define mld2r_ngrec		mld2r_hdr.icmp6_dataun.un_data16[1]
    40	
    41	/* MLDv2 Query */
    42	struct mld2_query {
    43		struct icmp6hdr		mld2q_hdr;
    44		struct in6_addr		mld2q_mca;
    45	#if defined(__LITTLE_ENDIAN_BITFIELD)
    46		__u8			mld2q_qrv:3,
    47					mld2q_suppress:1,
    48					mld2q_resv2:4;
    49	#elif defined(__BIG_ENDIAN_BITFIELD)
    50		__u8			mld2q_resv2:4,
    51					mld2q_suppress:1,
    52					mld2q_qrv:3;
    53	#else
    54	#error "Please fix <asm/byteorder.h>"
    55	#endif
    56		__u8			mld2q_qqic;
    57		__be16			mld2q_nsrcs;
    58		struct in6_addr		mld2q_srcs[];
    59	};
    60	
    61	#define mld2q_type		mld2q_hdr.icmp6_type
    62	#define mld2q_code		mld2q_hdr.icmp6_code
    63	#define mld2q_cksum		mld2q_hdr.icmp6_cksum
    64	#define mld2q_mrc		mld2q_hdr.icmp6_maxdelay
    65	#define mld2q_resv1		mld2q_hdr.icmp6_dataun.un_data16[1]
    66	
    67	/* RFC3810, 5.1.3. Maximum Response Code:
    68	 *
    69	 * If Maximum Response Code >= 32768, Maximum Response Code represents a
    70	 * floating-point value as follows:
    71	 *
    72	 *  0 1 2 3 4 5 6 7 8 9 A B C D E F
    73	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    74	 * |1| exp |          mant         |
    75	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    76	 */
    77	#define MLDV2_MRC_EXP(value)	(((value) >> 12) & 0x0007)
    78	#define MLDV2_MRC_MAN(value)	((value) & 0x0fff)
    79	
    80	/* RFC3810, 5.1.9. QQIC (Querier's Query Interval Code):
    81	 *
    82	 * If QQIC >= 128, QQIC represents a floating-point value as follows:
    83	 *
    84	 *  0 1 2 3 4 5 6 7
    85	 * +-+-+-+-+-+-+-+-+
    86	 * |1| exp | mant  |
    87	 * +-+-+-+-+-+-+-+-+
    88	 */
    89	#define MLDV2_QQIC_EXP(value)	(((value) >> 4) & 0x07)
    90	#define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
    91	
    92	#define MLD_QQIC_MIN_THRESHOLD	128
    93	#define MLD_MRC_MIN_THRESHOLD	32768UL
    94	#define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
    95	
    96	#define MLD_MAX_QUEUE		8
    97	#define MLD_MAX_SKBS		32
    98	
    99	/* V2 exponential field decoding */
   100	
   101	/* Calculate Maximum Response Delay from Maximum Response Code
   102	 *
   103	 * RFC3810, 5.1.3. defines the decoding formula:
   104	 *      0 1 2 3 4 5 6 7 8 9 A B C D E F
   105	 *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   106	 *     |1| exp |          mant         |
   107	 *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   108	 * Maximum Response Delay = (mant | 0x1000) << (exp+3)
   109	 */
   110	static inline unsigned long mldv2_mrd(const struct mld2_query *mlh2)
   111	{
   112		/* RFC3810, relevant sections:
   113		 *  - 5.1.3. Maximum Response Code
   114		 *  - 9.3. Query Response Interval
   115		 */
   116		unsigned long mc_mrc = ntohs(mlh2->mld2q_mrc);
   117	
   118		if (mc_mrc < MLD_MRC_MIN_THRESHOLD) {
   119			return mc_mrc;
   120		} else {
   121			unsigned long mc_man, mc_exp;
   122	
   123			mc_exp = MLDV2_MRC_EXP(mc_mrc);
   124			mc_man = MLDV2_MRC_MAN(mc_mrc);
   125	
   126			return ((mc_man | 0x1000) << (mc_exp + 3));
   127		}
   128	}
   129	
   130	/* Calculate Querier's Query Interval from Querier's Query Interval Code
   131	 *
   132	 * RFC3810, 5.1.9. defines the decoding formula:
   133	 *      0 1 2 3 4 5 6 7
   134	 *     +-+-+-+-+-+-+-+-+
   135	 *     |1| exp | mant  |
   136	 *     +-+-+-+-+-+-+-+-+
   137	 * QQI = (mant | 0x10) << (exp + 3)
   138	 */
   139	static inline unsigned long mldv2_qqi(const struct mld2_query *mlh2)
   140	{
   141		/* RFC3810, relevant sections:
   142		 *  - 5.1.9. QQIC (Querier's Query Interval Code)
   143		 *  - 9.2. Query Interval
   144		 *  - 9.12. Older Version Querier Present Timeout
   145		 *    (the [Query Interval] in the last Query received)
   146		 */
 > 147		unsigned long qqic = ntohs(mlh2->mld2q_qqic);
   148	
   149		if (qqic < MLD_QQIC_MIN_THRESHOLD) {
   150			return qqic;
   151		} else {
   152			unsigned long mc_man, mc_exp;
   153	
   154			mc_exp = MLDV2_QQIC_EXP(qqic);
   155			mc_man = MLDV2_QQIC_MAN(qqic);
   156	
   157			return ((mc_man | 0x10) << (mc_exp + 3));
   158		}
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

