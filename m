Return-Path: <netdev+bounces-164094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AEA2C947
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3661629B9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21118DB30;
	Fri,  7 Feb 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6wTCIGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389A1802DD
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947036; cv=none; b=iuD2PLcoFYdb5tJLek93t8SHsisF9bRN6f1Ihpu1FKz7XiiK+vEP1+iuJOP2z4djtivxpvo+b+ZdNul1Cyl8AyIlx/xxcsudrO+N25g7xImHADUMhQT7pcucPSyD2CY4Rj0z5sDm9cwX0WgRZhUCCU7URXsx2dG21JK2gX0HhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947036; c=relaxed/simple;
	bh=DkEejrWx0XQokmcY9bvrm0iMZbgql3NhyFtjjmT6C7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWOKEVluk6brl/qmp8dZi7fmtJZMF6iPXeZUHjwKdXVH0FtWnQxZdggKirQKFMG0gcLkJoeYHnM5Ah6B9k/+DWTLX+ON+M/zq8QFL9heCE37yzfNbDiLt+24pcj2aLAwNnIg/wC994MKQZvOmaWyd55xTisQAF7nmxYXMJBZv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6wTCIGZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947035; x=1770483035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DkEejrWx0XQokmcY9bvrm0iMZbgql3NhyFtjjmT6C7s=;
  b=U6wTCIGZRcyFhthlZ2fHiycIpTiwCqtDDtDMxjQulopoZFu0+TG8EOn6
   IFU/+XSqnAhj4VoZPg6eUH5qReAXTtEJK6HUE1k2QJJVf9anEG1QSOM7k
   fnFepHD0txhvq1NBE2wRmieZh0eeiw63tFnW447aBNgx2lpfFkA3BVFrs
   +WxawTC/b/8iDozLByDBycWT7T1mkyukC3PZ+gBHbqzoUjGuzqtofg30v
   iuD6w0wBGzc1nI0KH3FDFYIBZ+/7gbiqFopWSVxSmuf4/omAFoD3yS1Fj
   fnTfXNd/6begQNt868Zaix22DHqYVkx/bo38YI7kMHfgxaahjrh20BUd7
   g==;
X-CSE-ConnectionGUID: wVSAb7xzRtqcN2Wkz8L/tg==
X-CSE-MsgGUID: 803fOglHSHKJ7Jxo51MTiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50215624"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="50215624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:50:34 -0800
X-CSE-ConnectionGUID: 3W97wincTMSapLK1n61aUw==
X-CSE-MsgGUID: pXO2nomhQtitMxxhgehHUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116509262"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 08:50:31 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgRYi-000ycZ-1F;
	Fri, 07 Feb 2025 16:50:28 +0000
Date: Sat, 8 Feb 2025 00:50:06 +0800
From: kernel test robot <lkp@intel.com>
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, Edward Cree <ecree.xilinx@gmail.com>,
	habetsm.xilinx@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] sfc: extend NVRAM MCDI handlers
Message-ID: <202502080054.s619TTmK-lkp@intel.com>
References: <6ad7f4af17c2566ddc53fd247a0d0a790eff02ae.1738881614.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad7f4af17c2566ddc53fd247a0d0a790eff02ae.1738881614.git.ecree.xilinx@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/edward-cree-amd-com/sfc-parse-headers-of-devlink-flash-images/20250207-081201
base:   net-next/main
patch link:    https://lore.kernel.org/r/6ad7f4af17c2566ddc53fd247a0d0a790eff02ae.1738881614.git.ecree.xilinx%40gmail.com
patch subject: [PATCH net-next 2/4] sfc: extend NVRAM MCDI handlers
config: i386-randconfig-002-20250207 (https://download.01.org/0day-ci/archive/20250208/202502080054.s619TTmK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502080054.s619TTmK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502080054.s619TTmK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/mcdi.c:2195:12: warning: 'efx_mcdi_nvram_read' defined but not used [-Wunused-function]
    2195 | static int efx_mcdi_nvram_read(struct efx_nic *efx, unsigned int type,
         |            ^~~~~~~~~~~~~~~~~~~


vim +/efx_mcdi_nvram_read +2195 drivers/net/ethernet/sfc/mcdi.c

45a3fd55acc898 Ben Hutchings 2012-11-28  2194  
45a3fd55acc898 Ben Hutchings 2012-11-28 @2195  static int efx_mcdi_nvram_read(struct efx_nic *efx, unsigned int type,
45a3fd55acc898 Ben Hutchings 2012-11-28  2196  			       loff_t offset, u8 *buffer, size_t length)
45a3fd55acc898 Ben Hutchings 2012-11-28  2197  {
5fb1beeceab857 Bert Kenward  2019-01-16  2198  	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_READ_IN_V2_LEN);
45a3fd55acc898 Ben Hutchings 2012-11-28  2199  	MCDI_DECLARE_BUF(outbuf,
45a3fd55acc898 Ben Hutchings 2012-11-28  2200  			 MC_CMD_NVRAM_READ_OUT_LEN(EFX_MCDI_NVRAM_LEN_MAX));
45a3fd55acc898 Ben Hutchings 2012-11-28  2201  	size_t outlen;
45a3fd55acc898 Ben Hutchings 2012-11-28  2202  	int rc;
45a3fd55acc898 Ben Hutchings 2012-11-28  2203  
45a3fd55acc898 Ben Hutchings 2012-11-28  2204  	MCDI_SET_DWORD(inbuf, NVRAM_READ_IN_TYPE, type);
45a3fd55acc898 Ben Hutchings 2012-11-28  2205  	MCDI_SET_DWORD(inbuf, NVRAM_READ_IN_OFFSET, offset);
45a3fd55acc898 Ben Hutchings 2012-11-28  2206  	MCDI_SET_DWORD(inbuf, NVRAM_READ_IN_LENGTH, length);
5fb1beeceab857 Bert Kenward  2019-01-16  2207  	MCDI_SET_DWORD(inbuf, NVRAM_READ_IN_V2_MODE,
5fb1beeceab857 Bert Kenward  2019-01-16  2208  		       MC_CMD_NVRAM_READ_IN_V2_DEFAULT);
45a3fd55acc898 Ben Hutchings 2012-11-28  2209  
45a3fd55acc898 Ben Hutchings 2012-11-28  2210  	rc = efx_mcdi_rpc(efx, MC_CMD_NVRAM_READ, inbuf, sizeof(inbuf),
45a3fd55acc898 Ben Hutchings 2012-11-28  2211  			  outbuf, sizeof(outbuf), &outlen);
45a3fd55acc898 Ben Hutchings 2012-11-28  2212  	if (rc)
1e0b8120b2aef5 Edward Cree   2013-05-31  2213  		return rc;
45a3fd55acc898 Ben Hutchings 2012-11-28  2214  
45a3fd55acc898 Ben Hutchings 2012-11-28  2215  	memcpy(buffer, MCDI_PTR(outbuf, NVRAM_READ_OUT_READ_BUFFER), length);
45a3fd55acc898 Ben Hutchings 2012-11-28  2216  	return 0;
45a3fd55acc898 Ben Hutchings 2012-11-28  2217  }
45a3fd55acc898 Ben Hutchings 2012-11-28  2218  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

