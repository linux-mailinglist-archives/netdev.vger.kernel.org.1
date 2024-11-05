Return-Path: <netdev+bounces-141794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1269BC426
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E39728332B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC6818CBF4;
	Tue,  5 Nov 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k28MlsmI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F36187347;
	Tue,  5 Nov 2024 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779087; cv=none; b=XkHxfyiMoKMFnZonF7lw1XOn1rGscDKgalgIXqWfnQXb56nOCoFiFY0nAfAsGlF8r4ByNB3oQqW+mqLrr7LlrLkVLS8oJkyqcfc2MbvLD6euAFFGMyC9rwpjshkG5O46vppK10YB1mHDDKq2Es+AQXWl+COrozrJHKtqzobCd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779087; c=relaxed/simple;
	bh=NPNcUZZo36LXZhN7ArInvKqqeZ5fQvKuHRmvYyeYDoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/zSQicPGMmqcUAHv54snOzn1ihdeFRA5A3w9PJW7AkSThCOehk+SU4AmlcsWlmGvwxY5I0qyG+G7MMMwnIr7MwMa1JyB4mytsmEvrW3F7rmTgpMQORepZ6VJGoO/ATavq2mwePM71N9bbjreMvOSWP0JlEkWW19ZbBJqFBkY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k28MlsmI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730779086; x=1762315086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NPNcUZZo36LXZhN7ArInvKqqeZ5fQvKuHRmvYyeYDoE=;
  b=k28MlsmIUiJXUGaSGRUmPAYeUmU5CxfpTlzdgzV69XXsxHbRIce6EgD9
   3DjAbgN+bfTeu9SEfKPW53KcrXMXdc74CYfvRUFMmM93ppHkEJ+PoyEY2
   jLyalgRJDhjdcDqCuUsPD/Z8kugra2KtINlkXzOidA0roWt1/hqqiOcPh
   E5PiD8D4MDZyqNErh47vqSwCqXbue8cGuywmpa3mdgIT91c5JaytZWnrx
   ZJTaU0pr4JPkNPNos8D+knV6Bp1krA9EH1oy1rd7RPPrihs/rghkMDs73
   iUtdfCaF/u1FjSepSD6EMAJWIOOmr6PsSpyF2yQX7nDSSgrbocQ06+740
   Q==;
X-CSE-ConnectionGUID: 1PgsTmPlRr+Eie81lJ371g==
X-CSE-MsgGUID: x+wDxqXCRheQ+pTkZGGSYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30666758"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30666758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:58:05 -0800
X-CSE-ConnectionGUID: qKWGGDwHQ6ONsYp/rNiFlA==
X-CSE-MsgGUID: iSeQMICZSqq7uXaOpgQfvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="88433093"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Nov 2024 19:58:02 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Ahc-000laT-0P;
	Tue, 05 Nov 2024 03:58:00 +0000
Date: Tue, 5 Nov 2024 11:57:11 +0800
From: kernel test robot <lkp@intel.com>
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 4/5] net: phy: Makefile: Add makefile support
 for ptp in Microchip phys
Message-ID: <202411051137.XUgYrwtP-lkp@intel.com>
References: <20241104090750.12942-5-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090750.12942-5-divya.koppera@microchip.com>

Hi Divya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Divya-Koppera/net-phy-microchip_ptp-Add-header-file-for-Microchip-ptp-library/20241104-171132
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241104090750.12942-5-divya.koppera%40microchip.com
patch subject: [PATCH net-next 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
config: powerpc64-randconfig-r063-20241105 (https://download.01.org/0day-ci/archive/20241105/202411051137.XUgYrwtP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051137.XUgYrwtP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051137.XUgYrwtP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/phy/microchip_ptp.c:4:
   drivers/net/phy/microchip_ptp.h:197:60: warning: declaration of 'struct phy_device' will not be visible outside of this function [-Wvisibility]
   static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
                                                              ^
   drivers/net/phy/microchip_ptp.h:198:11: error: unknown type name 'u8'
                                                       u8 mmd, u16 clk_base,
                                                       ^
   drivers/net/phy/microchip_ptp.h:198:19: error: unknown type name 'u16'
                                                       u8 mmd, u16 clk_base,
                                                               ^
   drivers/net/phy/microchip_ptp.h:199:11: error: unknown type name 'u16'
                                                       u16 port_base)
                                                       ^
   drivers/net/phy/microchip_ptp.h:205:12: error: unknown type name 'u16'
                                          u16 reg, u16 val, bool enable)
                                          ^
   drivers/net/phy/microchip_ptp.h:205:21: error: unknown type name 'u16'
                                          u16 reg, u16 val, bool enable)
                                                   ^
   drivers/net/phy/microchip_ptp.h:205:30: error: unknown type name 'bool'
                                          u16 reg, u16 val, bool enable)
                                                            ^
   drivers/net/phy/microchip_ptp.h:210:15: error: unknown type name 'irqreturn_t'
   static inline irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock)
                 ^
   drivers/net/phy/microchip_ptp.h:212:9: error: use of undeclared identifier 'IRQ_NONE'
           return IRQ_NONE;
                  ^
   drivers/net/phy/microchip_ptp.c:7:16: warning: declaration of 'enum ptp_fifo_dir' will not be visible outside of this function [-Wvisibility]
                                  enum ptp_fifo_dir dir)
                                       ^
   drivers/net/phy/microchip_ptp.c:7:29: error: variable has incomplete type 'enum ptp_fifo_dir'
                                  enum ptp_fifo_dir dir)
                                                    ^
   drivers/net/phy/microchip_ptp.c:7:16: note: forward declaration of 'enum ptp_fifo_dir'
                                  enum ptp_fifo_dir dir)
                                       ^
   drivers/net/phy/microchip_ptp.c:9:39: error: incomplete definition of type 'struct mchp_ptp_clock'
           struct phy_device *phydev = ptp_clock->phydev;
                                       ~~~~~~~~~^
   drivers/net/phy/microchip_ptp.h:197:22: note: forward declaration of 'struct mchp_ptp_clock'
   static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
                        ^
   drivers/net/phy/microchip_ptp.c:12:22: error: use of undeclared identifier 'MCHP_PTP_FIFO_SIZE'
           for (int i = 0; i < MCHP_PTP_FIFO_SIZE; ++i) {
                               ^
>> drivers/net/phy/microchip_ptp.c:13:8: error: implicit declaration of function 'phy_read_mmd' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
                        ^
>> drivers/net/phy/microchip_ptp.c:13:29: error: implicit declaration of function 'PTP_MMD' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
                                             ^
   drivers/net/phy/microchip_ptp.c:14:14: error: use of undeclared identifier 'PTP_EGRESS_FIFO'
                                     dir == PTP_EGRESS_FIFO ?
                                            ^
>> drivers/net/phy/microchip_ptp.c:15:7: error: implicit declaration of function 'MCHP_PTP_TX_MSG_HEADER2' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                     MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
                                     ^
>> drivers/net/phy/microchip_ptp.c:15:31: error: implicit declaration of function 'BASE_PORT' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                     MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
                                                             ^
>> drivers/net/phy/microchip_ptp.c:16:7: error: implicit declaration of function 'MCHP_PTP_RX_MSG_HEADER2' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                     MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
                                     ^
   drivers/net/phy/microchip_ptp.c:16:7: note: did you mean 'MCHP_PTP_TX_MSG_HEADER2'?
   drivers/net/phy/microchip_ptp.c:15:7: note: 'MCHP_PTP_TX_MSG_HEADER2' declared here
                                     MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
                                     ^
   drivers/net/phy/microchip_ptp.c:20:9: error: implicit declaration of function 'phy_read_mmd' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
                  ^
   drivers/net/phy/microchip_ptp.c:20:30: error: implicit declaration of function 'PTP_MMD' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
                                       ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   2 warnings and 20 errors generated.


vim +/phy_read_mmd +13 drivers/net/phy/microchip_ptp.c

cf630bd2326111 Divya Koppera 2024-11-04   5  
cf630bd2326111 Divya Koppera 2024-11-04   6  static int mchp_ptp_flush_fifo(struct mchp_ptp_clock *ptp_clock,
cf630bd2326111 Divya Koppera 2024-11-04   7  			       enum ptp_fifo_dir dir)
cf630bd2326111 Divya Koppera 2024-11-04   8  {
cf630bd2326111 Divya Koppera 2024-11-04   9  	struct phy_device *phydev = ptp_clock->phydev;
cf630bd2326111 Divya Koppera 2024-11-04  10  	int rc;
cf630bd2326111 Divya Koppera 2024-11-04  11  
cf630bd2326111 Divya Koppera 2024-11-04  12  	for (int i = 0; i < MCHP_PTP_FIFO_SIZE; ++i) {
cf630bd2326111 Divya Koppera 2024-11-04 @13  		rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
cf630bd2326111 Divya Koppera 2024-11-04  14  				  dir == PTP_EGRESS_FIFO ?
cf630bd2326111 Divya Koppera 2024-11-04 @15  				  MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
cf630bd2326111 Divya Koppera 2024-11-04 @16  				  MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
cf630bd2326111 Divya Koppera 2024-11-04  17  		if (rc < 0)
cf630bd2326111 Divya Koppera 2024-11-04  18  			return rc;
cf630bd2326111 Divya Koppera 2024-11-04  19  	}
cf630bd2326111 Divya Koppera 2024-11-04  20  	return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
cf630bd2326111 Divya Koppera 2024-11-04  21  			    MCHP_PTP_INT_STS(BASE_PORT(ptp_clock)));
cf630bd2326111 Divya Koppera 2024-11-04  22  }
cf630bd2326111 Divya Koppera 2024-11-04  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

