Return-Path: <netdev+bounces-221636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754ACB5149F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB3E16AAA9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7430B512;
	Wed, 10 Sep 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYHfQh/5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037625DCF0
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501802; cv=none; b=OLpT3s7ul+rkhLT4l349ucwy4UVPkXIK+aFjBaI4ro/w27yTTccOjPXHOWUHhpvC6b7GmHEAXIv9Vvv7P58fIqkCyNT7nWSA7Luvnc94EYjmbDwzs9l8kpgVQ4Xkc2z4Epf3CyC6hIABWPw+DNAZQo6XxYGFBI1zboNjCMakCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501802; c=relaxed/simple;
	bh=pBVcJoKXAJZweFQ5rgT41V5OYlFtYV3vyUh3EOiqDFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDcBqkhWkH3JEygGzO+02rnUc7ypEz8mIl5YvplAPDt/NVlbut7TBjN/568fa923vxweUmexB5G8+4uPAVFmcRO8vekdWmk6I0HyxjKn7UvbK8DNe54YZqg95Tfp/Ld7qO2jbp2tRNTcJGeZi5Fya+7GyZDW8eENu/D5Ti7/1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYHfQh/5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757501801; x=1789037801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBVcJoKXAJZweFQ5rgT41V5OYlFtYV3vyUh3EOiqDFQ=;
  b=eYHfQh/5sx033itPEeMEAkTk4zPyc3CeOYJCPhl4U+mfw0NDZ2I6vBeJ
   VyQVJyczkUBeg44i4YGiYF9PTXv4CN2QgCuxPFAnXNK2l5BLtpptnEIPq
   dgLqGRRMkn+4LhQDLsmXcsZL9/5j0wncLU294haWuPq31/9J2sq49oJ9w
   QH1T9BajcZ7gfYsOtjNIT8ewmhw7GlvFm0S9iG3heCrMQZfJNd8pQWLMj
   BSfZ5jhR9/crKAmPmCX601+ktbm5k1k/Pp+Ld9i92WADJ2WqCSAPEz9YU
   iLZCQ+soEbdjM3gNEMu+09Ym9gIpMnR9Uha44JNssnGEt/w6g88R9Hj8r
   Q==;
X-CSE-ConnectionGUID: ZjixZaCcQy2h4G6OmR/0pg==
X-CSE-MsgGUID: UtSedQHEQvKw8XhlaAqMfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77264250"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="77264250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:56:08 -0700
X-CSE-ConnectionGUID: EtKytUnYQpGDa2XuNsiMEQ==
X-CSE-MsgGUID: IElsPQLKR7CLP4Ssup0CjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="197030708"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Sep 2025 03:56:05 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwIUc-0005rB-2p;
	Wed, 10 Sep 2025 10:56:02 +0000
Date: Wed, 10 Sep 2025 18:55:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove
 chip->evcap_config
Message-ID: <202509101826.A1forxFL-lkp@intel.com>
References: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-dsa-mv88e6xxx-remove-mv88e6250_ptp_ops/20250910-034838
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1uw0Xk-00000004IOC-1EJd%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove chip->evcap_config
config: i386-buildonly-randconfig-002-20250910 (https://download.01.org/0day-ci/archive/20250910/202509101826.A1forxFL-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101826.A1forxFL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101826.A1forxFL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/dsa/mv88e6xxx/ptp.c: In function 'mv88e6352_config_eventcap':
>> drivers/net/dsa/mv88e6xxx/ptp.c:182:9: error: 'evcap_config' undeclared (first use in this function); did you mean 'evap_config'?
     182 |         evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
         |         ^~~~~~~~~~~~
         |         evap_config
   drivers/net/dsa/mv88e6xxx/ptp.c:182:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/dsa/mv88e6xxx/ptp.c:178:13: warning: unused variable 'evap_config' [-Wunused-variable]
     178 |         u16 evap_config;
         |             ^~~~~~~~~~~


vim +182 drivers/net/dsa/mv88e6xxx/ptp.c

   168	
   169	/* mv88e6352_config_eventcap - configure TAI event capture
   170	 * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
   171	 * @rising: zero for falling-edge trigger, else rising-edge trigger
   172	 *
   173	 * This will also reset the capture sequence counter.
   174	 */
   175	static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
   176					     int rising)
   177	{
 > 178		u16 evap_config;
   179		u16 cap_config;
   180		int err;
   181	
 > 182		evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
   183			       MV88E6XXX_TAI_CFG_CAP_CTR_START;
   184		if (!rising)
   185			evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
   186	
   187		err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
   188		if (err)
   189			return err;
   190	
   191		if (event == PTP_CLOCK_PPS) {
   192			cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;
   193		} else if (event == PTP_CLOCK_EXTTS) {
   194			/* if STATUS_CAP_TRIG is unset we capture PTP_EVREQ events */
   195			cap_config = 0;
   196		} else {
   197			return -EINVAL;
   198		}
   199	
   200		/* Write the capture config; this also clears the capture counter */
   201		err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS,
   202					  cap_config);
   203	
   204		return err;
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

