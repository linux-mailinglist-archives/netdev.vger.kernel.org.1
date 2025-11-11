Return-Path: <netdev+bounces-237463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D2C4BBEA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 07:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F84188E491
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9CE346A1B;
	Tue, 11 Nov 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBEaOfZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58D2874F1;
	Tue, 11 Nov 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844041; cv=none; b=PRvTwJB0MeK+gjFaFdO24yth4OrFouTsR9MGQyOVMciE6Qvi16DoBsd3O/l1FcF0phRu3/Rsef+U+/Kmf3pkQ/nQY7IO6JZylRp1vgD7X4WKvcia4B0vtRwHAP8KkhKuFNGBBZIEYwgkYDDx/8O26k5VY4hoGVfG1eCzPvlohtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844041; c=relaxed/simple;
	bh=1ohHqJy3GtnFE3r4lHSgWNj8+fSVY8Y9eoPnFFJARb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHN/F2cwEYPTVff6vRCbB1PPVa8dv1yOmJmjgrHQq62ESwhqMPUhO7AtzzOMuytXiL3FCmp7OvKCfiINJ5bXgAfIJ8TQyq8So3edSQGi4/kZg9URGvf9z+0wHR2AxmTBciw8TBhZ+TX6OS1eefNEDL7QsD5PKxubSWhrU+GRLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBEaOfZQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762844039; x=1794380039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ohHqJy3GtnFE3r4lHSgWNj8+fSVY8Y9eoPnFFJARb0=;
  b=XBEaOfZQY4t4SGAKPSwKmj1mJ8CQX4lgeKALHX7A2pSzrNqudqujJ8Ef
   P7abXLXPXHvzq3AFKQhVRrQRaCq0GN2+/ADDx15AKs8xVCxNogeRsbe8I
   jslNZBaXsf8VuJqVK+oQ8SQCaTiVGNgX2pWxu+OCyojQvl8SdNEShMTPp
   qBc/k1QoN/0R65ZoWxdF7kKok2TgAUkDcIdaIN79riXAvKymAPyr+n5Qh
   Fw163Buye7nXAREFKUhSvh79iadWDsJa0NtZse6rL69HMYaHVLQBXcjM7
   xYMDoImqmJRaksYzTILYu53JegF8Ed9ksT8p+mbBqItc1rENUbwA7PV9V
   A==;
X-CSE-ConnectionGUID: B6XHsDO3S9u1rV+bnfHzfQ==
X-CSE-MsgGUID: XJ2s1zR8Ro+oyrwfdLJ2cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76250134"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="76250134"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 22:53:59 -0800
X-CSE-ConnectionGUID: 7VwVqiR7RH+xabLrGDwc9g==
X-CSE-MsgGUID: xrDE0GSYTLmtCPbuDM4V6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188145796"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Nov 2025 22:53:56 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIiGH-0002sF-1h;
	Tue, 11 Nov 2025 06:53:53 +0000
Date: Tue, 11 Nov 2025 14:52:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] dpll: zl3073x: Cache all reference
 properties in zl3073x_ref
Message-ID: <202511111402.yEyMEeLb-lkp@intel.com>
References: <20251110175818.1571610-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110175818.1571610-5-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Store-raw-register-values-instead-of-parsed-state/20251111-020236
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251110175818.1571610-5-ivecera%40redhat.com
patch subject: [PATCH net-next 4/6] dpll: zl3073x: Cache all reference properties in zl3073x_ref
config: x86_64-randconfig-161-20251111 (https://download.01.org/0day-ci/archive/20251111/202511111402.yEyMEeLb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111402.yEyMEeLb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511111402.yEyMEeLb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dpll/zl3073x/dpll.c: In function 'zl3073x_dpll_pin_phase_offset_check':
>> drivers/dpll/zl3073x/dpll.c:1850:35: warning: variable 'ref' set but not used [-Wunused-but-set-variable]
    1850 |         const struct zl3073x_ref *ref;
         |                                   ^~~


vim +/ref +1850 drivers/dpll/zl3073x/dpll.c

  1836	
  1837	/**
  1838	 * zl3073x_dpll_pin_phase_offset_check - check for pin phase offset change
  1839	 * @pin: pin to check
  1840	 *
  1841	 * Check for the change of DPLL to connected pin phase offset change.
  1842	 *
  1843	 * Return: true on phase offset change, false otherwise
  1844	 */
  1845	static bool
  1846	zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
  1847	{
  1848		struct zl3073x_dpll *zldpll = pin->dpll;
  1849		struct zl3073x_dev *zldev = zldpll->dev;
> 1850		const struct zl3073x_ref *ref;
  1851		unsigned int reg;
  1852		s64 phase_offset;
  1853		u8 ref_id;
  1854		int rc;
  1855	
  1856		ref_id = zl3073x_input_pin_ref_get(pin->id);
  1857		ref = zl3073x_ref_state_get(zldev, ref_id);
  1858	
  1859		/* No phase offset if the ref monitor reports signal errors */
  1860		if (!zl3073x_dev_ref_is_status_ok(zldev, ref_id))
  1861			return false;
  1862	
  1863		/* Select register to read phase offset value depending on pin and
  1864		 * phase monitor state:
  1865		 * 1) For connected pin use dpll_phase_err_data register
  1866		 * 2) For other pins use appropriate ref_phase register if the phase
  1867		 *    monitor feature is enabled.
  1868		 */
  1869		if (pin->pin_state == DPLL_PIN_STATE_CONNECTED)
  1870			reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
  1871		else if (zldpll->phase_monitor)
  1872			reg = ZL_REG_REF_PHASE(ref_id);
  1873		else
  1874			return false;
  1875	
  1876		/* Read measured phase offset value */
  1877		rc = zl3073x_read_u48(zldev, reg, &phase_offset);
  1878		if (rc) {
  1879			dev_err(zldev->dev, "Failed to read ref phase offset: %pe\n",
  1880				ERR_PTR(rc));
  1881	
  1882			return false;
  1883		}
  1884	
  1885		/* Convert to ps */
  1886		phase_offset = div_s64(sign_extend64(phase_offset, 47), 100);
  1887	
  1888		/* Compare with previous value */
  1889		if (phase_offset != pin->phase_offset) {
  1890			dev_dbg(zldev->dev, "%s phase offset changed: %lld -> %lld\n",
  1891				pin->label, pin->phase_offset, phase_offset);
  1892			pin->phase_offset = phase_offset;
  1893	
  1894			return true;
  1895		}
  1896	
  1897		return false;
  1898	}
  1899	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

