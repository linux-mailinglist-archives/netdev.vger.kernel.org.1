Return-Path: <netdev+bounces-257982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNUVIQQyimkPIQAAu9opvQ
	(envelope-from <netdev+bounces-257982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:14:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703A113FF0
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A01A3008C20
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63411413254;
	Mon,  9 Feb 2026 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghihUtyb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047140FD84
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664450; cv=none; b=SjD2GH1FU1Uga0lUjN7PvSMLQdtf1xontDFsDuitdQXCXLV5i5xu4qPMEudf/nw8wzoBWOcBNTYl8t9kkHFhaa6HGRO4LGsKxFf7TkFZFArhLN7KhfsYzFq1/BprKI+UCawbTGZT6NVZdZkZzXqTFCtwhGm2BrAbb1k2WI6u02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664450; c=relaxed/simple;
	bh=EeRnZ/D6LgXddB+3u6Cdx959SA+lB9fAUyb3gRAYC/c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jdJ/H0u5MwE2HWWWc/zKwodlXJCJa7YGqjZqbY0jZzW6yR27z8s48g1pwUwd1kWn6X4O02DHWVMaMGZOZ1q2+6CpwcoHCkwrhkj8dw0eeSnhJ6dvpRLiYzCJ3mLx97er7CjlIbaEDRPE4gBaX475kK0kxFvzUFbW0fk69xpuOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghihUtyb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770664449; x=1802200449;
  h=date:from:to:cc:subject:message-id;
  bh=EeRnZ/D6LgXddB+3u6Cdx959SA+lB9fAUyb3gRAYC/c=;
  b=ghihUtybMnCXSBrIjw5XSwXFOpYQ1bl5997d1Eoekwhtj5e95SvHRYtu
   u4TqMTSy80IgC349X9XEp9gd78ZLk5awx6UBjOMT6TCtW4JOCZQqZaevW
   wliu1zd2fw5TdT5dcRYQrj1QfeZglfChuGNZul+H5xj6Dn/LC+lDtcm+R
   JYlcVYLjpKWpnKMKMF0x/Z57IFkdmpiEIgwUd7e7q5RPwaJbgDLASM2Ay
   BffLzbszOK1RE0/0VaVNiJy+SlOxgWcjZG/JT+mkGFg8//utBRhPV2lBL
   0RLgAC1R3G2slNbRH/+dvf5amF0pvCKBQOC/VJbmUAooQeFZbqFudlaUH
   Q==;
X-CSE-ConnectionGUID: yK+C/i6VRiyUgqe/Zpzpig==
X-CSE-MsgGUID: x82KIJYNSTW2CufojDeK9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74388159"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="74388159"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:14:00 -0800
X-CSE-ConnectionGUID: V4hXuOPyT8ietd4/4ozq4g==
X-CSE-MsgGUID: hwt6QvPfSSmhPHcv2masmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210815516"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 11:13:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpWhk-00000000oGK-27iT;
	Mon, 09 Feb 2026 19:13:52 +0000
Date: Tue, 10 Feb 2026 03:12:52 +0800
From: kernel test robot <lkp@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Ivan Vecera <ivecera@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [net-next:main 19/22]
 drivers/net/ethernet/intel/ice/ice_dpll.c:3539:45: warning: '%u' directive
 output may be truncated writing between 1 and 8 bytes into a region of size 4
Message-ID: <202602100310.nOvzaILF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257982-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1703A113FF0
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   57be33f85e369ce9f69f61eaa34734e0d3bd47a7
commit: ad1df4f2d591e167bc64b8a7ce6328a2735e3d58 [19/22] ice: dpll: Support E825-C SyncE and dynamic pin discovery
config: microblaze-randconfig-r062-20260209 (https://download.01.org/0day-ci/archive/20260210/202602100310.nOvzaILF-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602100310.nOvzaILF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602100310.nOvzaILF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_dpll.c: In function 'ice_dpll_init':
>> drivers/net/ethernet/intel/ice/ice_dpll.c:3539:45: warning: '%u' directive output may be truncated writing between 1 and 8 bytes into a region of size 4 [-Wformat-truncation=]
      snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
                                                ^~
   drivers/net/ethernet/intel/ice/ice_dpll.c:3539:40: note: directive argument in the range [0, 38347923]
      snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
                                           ^~~~~~~~
   drivers/net/ethernet/intel/ice/ice_dpll.c:3539:3: note: 'snprintf' output between 6 and 13 bytes into a destination of size 8
      snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +3539 drivers/net/ethernet/intel/ice/ice_dpll.c

  3509	
  3510	/**
  3511	 * ice_dpll_init_fwnode_pins - initialize pins from device tree
  3512	 * @pf: board private structure
  3513	 * @pins: pointer to pins array
  3514	 * @start_idx: starting index for pins
  3515	 * @count: number of pins to initialize
  3516	 *
  3517	 * Initialize input pins for E825 RCLK support. The parent pins (rclk0, rclk1)
  3518	 * are expected to be defined by the system firmware (ACPI). This function
  3519	 * allocates them in the dpll subsystem and stores their indices for later
  3520	 * registration with the rclk pin.
  3521	 *
  3522	 * Return:
  3523	 * * 0 - success
  3524	 * * negative - initialization failure reason
  3525	 */
  3526	static int
  3527	ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
  3528				  int start_idx)
  3529	{
  3530		char pin_name[8];
  3531		int i, ret;
  3532	
  3533		pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");
  3534		if (!pf->dplls.wq)
  3535			return -ENOMEM;
  3536	
  3537		for (i = 0; i < pf->dplls.rclk.num_parents; i++) {
  3538			pins[start_idx + i].pf = pf;
> 3539			snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
  3540			ret = ice_dpll_init_fwnode_pin(&pins[start_idx + i], pin_name);
  3541			if (ret)
  3542				goto error;
  3543		}
  3544	
  3545		return 0;
  3546	error:
  3547		while (i--)
  3548			ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
  3549	
  3550		destroy_workqueue(pf->dplls.wq);
  3551	
  3552		return ret;
  3553	}
  3554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

