Return-Path: <netdev+bounces-132346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDB991502
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE341C218DB
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF6135A53;
	Sat,  5 Oct 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUDQ+z6A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C17D07D
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728111305; cv=none; b=HpeMaR2lj9Uq7gsF9HyKm77Ysbj9rZ+qbNZ42UL3V6RqOTai9gaKJfGs6NUqPncotNF+lHOkRMSWVYtdPPbydu5X4ag6/jb7Hyt3yi7gmPwWIgjC7klzX4IfAnin1UcTrWC2nbJAHGn5CBX1zRpVcksYuKQ/7+RBVN+mcIKVI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728111305; c=relaxed/simple;
	bh=gAxSir66pjUkLrR2v3FQvq9A3ljFvlMTr5inGp6EPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPQyTNTUd5TxUWdHzNru6zqYSeBxfMrw+O/TEfeTbIw+XNiQLVnmRyT7oLyFRyxqubHxSm7Jg1iECIcWhIk2GSfQ+P3ntLqqAtzPxUpbs9FLZ1ABbQVwk5aGqsmBajZJulq24SPUi5tN9gxjsF60vvaWPyzWcwSFhEUKX7GrZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUDQ+z6A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728111303; x=1759647303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gAxSir66pjUkLrR2v3FQvq9A3ljFvlMTr5inGp6EPCI=;
  b=fUDQ+z6AZNCH8dbMULdaQT3B01vH3Y3l8GF+1QHAtDBh4ZfTAsRKhjyf
   nC+zkxdMmNUWByiFGPHId/Jdfn+huMLEkk3PNMKNLEVkvAtkb1SzgMIAe
   CV01rum+WnSnqwnTKjCNipq7yC/nBeEca9jplOZ1puU00FGcLeykrnm0L
   bHgHBDVY65sUAeAgINDBBgaQxz54g/MmmW5BaNGIGmoMoYkTwMyHj5pab
   Omm+jFTgPFyuwah77TqzNaXU+Ew6ftMPfhR94vX2ZUD+Yh2GM606uxD+T
   tLFQ2M0o1y2jcq3t+rwq7vg7opUmUOmyC9xAqM1wtOuB96QAPOdyPNGjG
   w==;
X-CSE-ConnectionGUID: Y/ACZ7RiRnq6HuKbe2nPBw==
X-CSE-MsgGUID: CR1JeJRGQl2PBiA9CzNynw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="38724271"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="38724271"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 23:55:02 -0700
X-CSE-ConnectionGUID: XnEwvlP9S8yUlVVimWJ/0g==
X-CSE-MsgGUID: vV05ennSQ9KU8HWNTAfVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="74907373"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Oct 2024 23:55:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swygr-0002hP-1Y;
	Sat, 05 Oct 2024 06:54:57 +0000
Date: Sat, 5 Oct 2024 14:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next] ice: Add in/out PTP pin delays
Message-ID: <202410051418.lLY7SXXp-lkp@intel.com>
References: <20241004064733.1362850-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004064733.1362850-2-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build errors:

[auto build test ERROR on f2589ad16e14b7102f1411e3385a2abf07076406]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Add-in-out-PTP-pin-delays/20241004-144802
base:   f2589ad16e14b7102f1411e3385a2abf07076406
patch link:    https://lore.kernel.org/r/20241004064733.1362850-2-karol.kolacinski%40intel.com
patch subject: [PATCH iwl-next] ice: Add in/out PTP pin delays
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241005/202410051418.lLY7SXXp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051418.lLY7SXXp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051418.lLY7SXXp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_cfg_perout':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1784:22: error: redeclaration of 'gpio_pin' with no linkage
    1784 |         unsigned int gpio_pin;
         |                      ^~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp.c:1781:22: note: previous declaration of 'gpio_pin' with type 'unsigned int'
    1781 |         unsigned int gpio_pin, prop_delay;
         |                      ^~~~~~~~
--
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_ptp_init_phc_e810':
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5033:36: error: 'ICE_E810_E830_SYNC_DELAY' undeclared (first use in this function)
    5033 |         ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5033:36: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_ptp_init_phc_e830':
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5341:36: error: 'ICE_E810_E830_SYNC_DELAY' undeclared (first use in this function)
    5341 |         ice_ptp_cfg_sync_delay(hw, ICE_E810_E830_SYNC_DELAY);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/gpio_pin +1784 drivers/net/ethernet/intel/ice/ice_ptp.c

172db5f91d5f7b Maciej Machnikowski 2021-06-16  1766  
5a078a58ade86d Karol Kolacinski    2024-08-30  1767  /**
5a078a58ade86d Karol Kolacinski    2024-08-30  1768   * ice_ptp_cfg_perout - Configure clock to generate periodic wave
5a078a58ade86d Karol Kolacinski    2024-08-30  1769   * @pf: Board private structure
5a078a58ade86d Karol Kolacinski    2024-08-30  1770   * @rq: Periodic output request
5a078a58ade86d Karol Kolacinski    2024-08-30  1771   * @on: Enable/disable flag
5a078a58ade86d Karol Kolacinski    2024-08-30  1772   *
5a078a58ade86d Karol Kolacinski    2024-08-30  1773   * Configure the internal clock generator modules to generate the clock wave of
5a078a58ade86d Karol Kolacinski    2024-08-30  1774   * specified period.
5a078a58ade86d Karol Kolacinski    2024-08-30  1775   *
5a078a58ade86d Karol Kolacinski    2024-08-30  1776   * Return: 0 on success, negative error code otherwise
5a078a58ade86d Karol Kolacinski    2024-08-30  1777   */
5a078a58ade86d Karol Kolacinski    2024-08-30  1778  static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
5a078a58ade86d Karol Kolacinski    2024-08-30  1779  			      int on)
5a078a58ade86d Karol Kolacinski    2024-08-30  1780  {
718647161517f7 Karol Kolacinski    2024-10-04  1781  	unsigned int gpio_pin, prop_delay;
5a078a58ade86d Karol Kolacinski    2024-08-30  1782  	u64 clk, period, start, phase;
5a078a58ade86d Karol Kolacinski    2024-08-30  1783  	struct ice_hw *hw = &pf->hw;
5a078a58ade86d Karol Kolacinski    2024-08-30 @1784  	unsigned int gpio_pin;
5a078a58ade86d Karol Kolacinski    2024-08-30  1785  	int pin_desc_idx;
5a078a58ade86d Karol Kolacinski    2024-08-30  1786  
5a078a58ade86d Karol Kolacinski    2024-08-30  1787  	if (rq->flags & ~PTP_PEROUT_PHASE)
5a078a58ade86d Karol Kolacinski    2024-08-30  1788  		return -EOPNOTSUPP;
5a078a58ade86d Karol Kolacinski    2024-08-30  1789  
5a078a58ade86d Karol Kolacinski    2024-08-30  1790  	pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_PEROUT, rq->index);
5a078a58ade86d Karol Kolacinski    2024-08-30  1791  	if (pin_desc_idx < 0)
5a078a58ade86d Karol Kolacinski    2024-08-30  1792  		return -EIO;
5a078a58ade86d Karol Kolacinski    2024-08-30  1793  
5a078a58ade86d Karol Kolacinski    2024-08-30  1794  	gpio_pin = pf->ptp.ice_pin_desc[pin_desc_idx].gpio[1];
718647161517f7 Karol Kolacinski    2024-10-04  1795  	prop_delay = pf->ptp.ice_pin_desc[pin_desc_idx].delay[1];
5a078a58ade86d Karol Kolacinski    2024-08-30  1796  	period = rq->period.sec * NSEC_PER_SEC + rq->period.nsec;
5a078a58ade86d Karol Kolacinski    2024-08-30  1797  
5a078a58ade86d Karol Kolacinski    2024-08-30  1798  	/* If we're disabling the output or period is 0, clear out CLKO and TGT
5a078a58ade86d Karol Kolacinski    2024-08-30  1799  	 * and keep output level low.
5a078a58ade86d Karol Kolacinski    2024-08-30  1800  	 */
5a078a58ade86d Karol Kolacinski    2024-08-30  1801  	if (!on || !period)
5a078a58ade86d Karol Kolacinski    2024-08-30  1802  		return ice_ptp_write_perout(hw, rq->index, gpio_pin, 0, 0);
5a078a58ade86d Karol Kolacinski    2024-08-30  1803  
5a078a58ade86d Karol Kolacinski    2024-08-30  1804  	if (strncmp(pf->ptp.pin_desc[pin_desc_idx].name, "1PPS", 64) == 0 &&
001459cacff09e Karol Kolacinski    2024-09-30  1805  	    period != NSEC_PER_SEC && hw->mac_type == ICE_MAC_GENERIC) {
5a078a58ade86d Karol Kolacinski    2024-08-30  1806  		dev_err(ice_pf_to_dev(pf), "1PPS pin supports only 1 s period\n");
5a078a58ade86d Karol Kolacinski    2024-08-30  1807  		return -EOPNOTSUPP;
5a078a58ade86d Karol Kolacinski    2024-08-30  1808  	}
5a078a58ade86d Karol Kolacinski    2024-08-30  1809  
5a078a58ade86d Karol Kolacinski    2024-08-30  1810  	if (period & 0x1) {
5a078a58ade86d Karol Kolacinski    2024-08-30  1811  		dev_err(ice_pf_to_dev(pf), "CLK Period must be an even value\n");
5a078a58ade86d Karol Kolacinski    2024-08-30  1812  		return -EIO;
5a078a58ade86d Karol Kolacinski    2024-08-30  1813  	}
5a078a58ade86d Karol Kolacinski    2024-08-30  1814  
5a078a58ade86d Karol Kolacinski    2024-08-30  1815  	start = rq->start.sec * NSEC_PER_SEC + rq->start.nsec;
5a078a58ade86d Karol Kolacinski    2024-08-30  1816  
5a078a58ade86d Karol Kolacinski    2024-08-30  1817  	/* If PTP_PEROUT_PHASE is set, rq has phase instead of start time */
5a078a58ade86d Karol Kolacinski    2024-08-30  1818  	if (rq->flags & PTP_PEROUT_PHASE)
5a078a58ade86d Karol Kolacinski    2024-08-30  1819  		phase = start;
5a078a58ade86d Karol Kolacinski    2024-08-30  1820  	else
5a078a58ade86d Karol Kolacinski    2024-08-30  1821  		div64_u64_rem(start, period, &phase);
5a078a58ade86d Karol Kolacinski    2024-08-30  1822  
5a078a58ade86d Karol Kolacinski    2024-08-30  1823  	/* If we have only phase or start time is in the past, start the timer
5a078a58ade86d Karol Kolacinski    2024-08-30  1824  	 * at the next multiple of period, maintaining phase.
5a078a58ade86d Karol Kolacinski    2024-08-30  1825  	 */
5a078a58ade86d Karol Kolacinski    2024-08-30  1826  	clk = ice_ptp_read_src_clk_reg(pf, NULL);
718647161517f7 Karol Kolacinski    2024-10-04  1827  	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay)
5a078a58ade86d Karol Kolacinski    2024-08-30  1828  		start = div64_u64(clk + period - 1, period) * period + phase;
5a078a58ade86d Karol Kolacinski    2024-08-30  1829  
5a078a58ade86d Karol Kolacinski    2024-08-30  1830  	/* Compensate for propagation delay from the generator to the pin. */
718647161517f7 Karol Kolacinski    2024-10-04  1831  	start -= prop_delay;
5a078a58ade86d Karol Kolacinski    2024-08-30  1832  
5a078a58ade86d Karol Kolacinski    2024-08-30  1833  	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
172db5f91d5f7b Maciej Machnikowski 2021-06-16  1834  }
172db5f91d5f7b Maciej Machnikowski 2021-06-16  1835  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

