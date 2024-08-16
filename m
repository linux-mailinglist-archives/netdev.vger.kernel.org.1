Return-Path: <netdev+bounces-119187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756C95487C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FD8B2310C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969D16F262;
	Fri, 16 Aug 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9zoeyok"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F9156F34
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809837; cv=none; b=lsN/AEcVFy0Js3XRK/kc0yRY2iSvpufsM4EVoHCX2OUvTzRF9XY2t1YGTcflrqtFyiBro7/Htu7Zvt7GDMnMF9Byl4bDCoO4LazVEcYyfTTR3W/2kuD5KupYbznBKWWRycQVt+6jEvw3dBqrMvEsTZ4bkSJdzrVIwh9453NZWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809837; c=relaxed/simple;
	bh=5e5kiXkjoBx2z6g63nwbvFkiN9+y7THshxeuizhe6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rov/hvQu11gGViwlhorI3//MAiY4Yo4k5jxR/lDPV+QSnP/LwN0cKJhaRT4FFSLFHRmLyHen516Q83QlC1pzgH3Hi98kVlgfk5+cfpxSayQoYZVe79aw3Siq/1qP/GbzxG7wVr/ZhMw9tj0TptZ0H+OZhLR4pAbN5F2IkXQZ3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9zoeyok; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723809835; x=1755345835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5e5kiXkjoBx2z6g63nwbvFkiN9+y7THshxeuizhe6n8=;
  b=Z9zoeyokmNr3PNkK5QsqVxFL9EWCGYO2VdTsQf5gkRkh9L5ZBZwgVlUi
   Pk5vEdNn+zfHkBz7RM1GWGS2ecu9rs2a+GGZ9ADUbB+Bh4LXmFuFQeNWG
   I8w1vtVnVHNXYU6CMRTXFEetcEsV3jNak7SyfIidEpgsjZV7Vrpxgl2H+
   kmRkHunUABDEdo56CHol79r1LHnoVTwzVscp2ll445TzqgCEFxjiLYvGJ
   tsgkPMKWg7f8RyM4NzXILgHJG/qxAr94mSla1eBb471+BDGDIGp3l66tk
   RxNwwIlzNJGDB2/xqJZCJQlaheWviT+xGwes2kGMoXF7w8SrTeExFyUMg
   w==;
X-CSE-ConnectionGUID: lzYYcqk+Q/mICtGR4ZcE3g==
X-CSE-MsgGUID: J4rWk/O+SXuP7aMsS6N5+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25969142"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="25969142"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 05:03:54 -0700
X-CSE-ConnectionGUID: 09Y/9+qKTr2WRxmoGKci3g==
X-CSE-MsgGUID: 0PJ3fA3+TQeMGc85mc1v/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="82860137"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Aug 2024 05:03:53 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sevgM-0006OI-2z;
	Fri, 16 Aug 2024 12:03:50 +0000
Date: Fri, 16 Aug 2024 20:03:06 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <202408161934.aQsUDy88-lkp@intel.com>
References: <20240815125905.1667148-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815125905.1667148-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/docs-ABI-update-OCP-TimeCard-sysfs-entries/20240815-210131
base:   net/main
patch link:    https://lore.kernel.org/r/20240815125905.1667148-1-vadfed%40meta.com
patch subject: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty information
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240816/202408161934.aQsUDy88-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408161934.aQsUDy88-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408161934.aQsUDy88-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_tty_show':
>> drivers/ptp/ptp_ocp.c:3360:37: warning: unused variable 'port' [-Wunused-variable]
    3360 |         struct ptp_ocp_serial_port *port;
         |                                     ^~~~


vim +/port +3360 drivers/ptp/ptp_ocp.c

  3354	
  3355	static ssize_t
  3356	ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
  3357	{
  3358		struct dev_ext_attribute *ea = to_ext_attr(attr);
  3359		struct ptp_ocp *bp = dev_get_drvdata(dev);
> 3360		struct ptp_ocp_serial_port *port;
  3361	
  3362		return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
  3363	}
  3364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

