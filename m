Return-Path: <netdev+bounces-145656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9169D04C9
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F9C282194
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F71D9A6F;
	Sun, 17 Nov 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpQYjO81"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F923AD
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731864190; cv=none; b=fuef8fo73K20ZXc7Tu/lWZYB5v2qpSPTGNKox2SxjSGQEtiOL0VVVuL42rvdzgdBPkgXOGfuEBubX2WW+lMrvG9gYayU09QCnvsFgQN5Z+TLwWjD+dDguNxUGAp1hGL/8hGUXa4+ofkSVsjdgkb9K4Lt2fWKW3nXA0YnoE2HjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731864190; c=relaxed/simple;
	bh=wHEepThs8zD/JYJYBhuibrPXrk564fkO7cnDTP8+w4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH31p8TSkoPf9biBJwCCXBfgC7Pswtpr69EDoCT+zY2TEELnP7NYtCAArzkq1UtAH4MjbKlF1VZWdyl0ubkIOGFI1ks9FF6p48FP48zuK4TRoS/SyxGGOu9W9KFTwsfVKxjYw7vCQivGCgKBZ+UkiRWE7JQi1dtG5lAia4eFEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpQYjO81; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731864189; x=1763400189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHEepThs8zD/JYJYBhuibrPXrk564fkO7cnDTP8+w4Q=;
  b=RpQYjO81Szu0je/+5pL8FtEkRI5htq5kfnWdoaQyVU3oICOA6GeMr8yQ
   EokNjNEM+/UoJUNgKYWvH+CeqlDo/i2o37JNJvgoqiuDlyvKdd0z1kwHN
   99FzjSBO/nmbQcnumVsqiYPNtPzJwKI+6TfQ6kTq/2BW3oPFARoKbpqiJ
   TdspuMHwKd7HUJxHpZkUb34SCckjNActMjyYh9Ki1c+w93zJ6cgBfalI3
   2sUUI7hJM6P8QC+BhDIf76lodCIkbl2HJ/WsEV+kI8+nu1qL6MPDcEg6h
   sUSA35PUznu4l5cozllcro1dgA4kJeu36wcn9sXoQcVPPbYTHBhmMasEv
   Q==;
X-CSE-ConnectionGUID: udLpkJJ9Rt+i2OdQVwZnVQ==
X-CSE-MsgGUID: rdcPsWv8Qlep7MhdktM3zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31198551"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31198551"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 09:23:08 -0800
X-CSE-ConnectionGUID: XFFm+i4RT9+I+kloY4CwAQ==
X-CSE-MsgGUID: DOdYGX7VTDSI9RWpRiGo0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89180128"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2024 09:23:02 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCizC-0001yD-1W;
	Sun, 17 Nov 2024 17:22:58 +0000
Date: Mon, 18 Nov 2024 01:22:39 +0800
From: kernel test robot <lkp@intel.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?unknown-8bit?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Message-ID: <202411180131.xdHcVFlh-lkp@intel.com>
References: <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>

Hi Easwar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Easwar-Hariharan/netfilter-conntrack-Cleanup-timeout-definitions/20241117-003530
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-1-911fb7595e79%40linux.microsoft.com
patch subject: [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout definitions
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241118/202411180131.xdHcVFlh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180131.xdHcVFlh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180131.xdHcVFlh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_proto_sctp.c:43:51: error: implicit declaration of function 'secs_to_jiffies'; did you mean 'nsecs_to_jiffies'? [-Werror=implicit-function-declaration]
      43 |         [SCTP_CONNTRACK_CLOSED]                 = secs_to_jiffies(10),
         |                                                   ^~~~~~~~~~~~~~~
         |                                                   nsecs_to_jiffies
>> net/netfilter/nf_conntrack_proto_sctp.c:43:51: error: initializer element is not constant
   net/netfilter/nf_conntrack_proto_sctp.c:43:51: note: (near initialization for 'sctp_timeouts[1]')
   net/netfilter/nf_conntrack_proto_sctp.c:44:51: error: initializer element is not constant
      44 |         [SCTP_CONNTRACK_COOKIE_WAIT]            = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:44:51: note: (near initialization for 'sctp_timeouts[2]')
   net/netfilter/nf_conntrack_proto_sctp.c:45:51: error: initializer element is not constant
      45 |         [SCTP_CONNTRACK_COOKIE_ECHOED]          = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:45:51: note: (near initialization for 'sctp_timeouts[3]')
   net/netfilter/nf_conntrack_proto_sctp.c:46:51: error: initializer element is not constant
      46 |         [SCTP_CONNTRACK_ESTABLISHED]            = secs_to_jiffies(210),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:46:51: note: (near initialization for 'sctp_timeouts[4]')
   net/netfilter/nf_conntrack_proto_sctp.c:47:51: error: initializer element is not constant
      47 |         [SCTP_CONNTRACK_SHUTDOWN_SENT]          = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:47:51: note: (near initialization for 'sctp_timeouts[5]')
   net/netfilter/nf_conntrack_proto_sctp.c:48:51: error: initializer element is not constant
      48 |         [SCTP_CONNTRACK_SHUTDOWN_RECD]          = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:48:51: note: (near initialization for 'sctp_timeouts[6]')
   net/netfilter/nf_conntrack_proto_sctp.c:49:51: error: initializer element is not constant
      49 |         [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:49:51: note: (near initialization for 'sctp_timeouts[7]')
   net/netfilter/nf_conntrack_proto_sctp.c:50:51: error: initializer element is not constant
      50 |         [SCTP_CONNTRACK_HEARTBEAT_SENT]         = secs_to_jiffies(3),
         |                                                   ^~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_proto_sctp.c:50:51: note: (near initialization for 'sctp_timeouts[8]')
   cc1: some warnings being treated as errors


vim +43 net/netfilter/nf_conntrack_proto_sctp.c

    41	
    42	static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
  > 43		[SCTP_CONNTRACK_CLOSED]			= secs_to_jiffies(10),
    44		[SCTP_CONNTRACK_COOKIE_WAIT]		= secs_to_jiffies(3),
    45		[SCTP_CONNTRACK_COOKIE_ECHOED]		= secs_to_jiffies(3),
    46		[SCTP_CONNTRACK_ESTABLISHED]		= secs_to_jiffies(210),
    47		[SCTP_CONNTRACK_SHUTDOWN_SENT]		= secs_to_jiffies(3),
    48		[SCTP_CONNTRACK_SHUTDOWN_RECD]		= secs_to_jiffies(3),
    49		[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= secs_to_jiffies(3),
    50		[SCTP_CONNTRACK_HEARTBEAT_SENT]		= secs_to_jiffies(3),
    51	};
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

