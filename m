Return-Path: <netdev+bounces-266871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCK4FXMosmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:44:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67626C5F1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9C830247EA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7D35C1A9;
	Thu, 12 Mar 2026 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTcKTojc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93737CD47;
	Thu, 12 Mar 2026 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283440; cv=none; b=eGmwVGyb41DIdJ0Ccao22eKVcMDbyuZJt5cUZkR3G7qLp0dfZA8PoRWVMtSaQJC2PaZG89pBVfoIEqyNPe58yqpEZ4hXNTQlfuJtBZWmCVbSf1a97BWO9Qu/POY56APvGBBZCHUX0YlJynhqiFG2XX5kK4BThfj8EZ74VNdL8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283440; c=relaxed/simple;
	bh=YX+Hl+T55T++SepgMId5u+VEq+b3QtDDFYNOz+QzAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brFkB4Y+pOjmTcL5WN0lKtLceZsPNOw5J1aUbEQBr1cHz0qv/PBuq33B0OaH26woGBhBuEYIhrUhyLmDKL7ppzDLLMZVeazPd2cUkP900QYvaIOy4ZElVrjFGX5JQn2uJka2vlXm1hbXbtjqZcjQub6jNOcohwGB0k9Qb0yB9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTcKTojc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773283436; x=1804819436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YX+Hl+T55T++SepgMId5u+VEq+b3QtDDFYNOz+QzAB4=;
  b=gTcKTojc4TyZ0otKzpTMC1ZkJ2gBbfUrsaskT+FZiVeg0xVe4rHU0ghA
   OObUxT1qG74TCqFk3qnc77SMcQDO74UgZzb2fj1csXYcaB2G0omskYFwW
   NpLxGB1E/nS95ECkYZ6a1u2+oxgeWJWFVCu1lDalMtCWXtZPalg+zWARK
   +tXoAZgJQze5PbuiF41CnSwHD+Stav2vxpfLd8w8QqJYWhXO5roAiUMWg
   pe1ms2GeUZrTaQk6ejtAJM21n8OAX5GoTORJy9n/Y01hy4NYPtFWiUODg
   s6CF7j8bMXb9l95+F4J3ZBLDg8ANv32ytIqViMY+jf6nKbAu6f0B9wvP/
   w==;
X-CSE-ConnectionGUID: /VGNKFF2Tai4CCqykYJOwg==
X-CSE-MsgGUID: ufXGzb1GS3iDXFe0fyt2+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73382994"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="73382994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:43:56 -0700
X-CSE-ConnectionGUID: zkdaBhb6SeyQBR/C95B9kQ==
X-CSE-MsgGUID: 5NZVoEHIQRahCpG0L1M0/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220623329"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2026 19:43:53 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0W1e-000000001y7-26p2;
	Thu, 12 Mar 2026 02:43:50 +0000
Date: Thu, 12 Mar 2026 10:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk@kernel.org, carl.lee@amd.com, peter.shen@amd.com,
	colin.huang2@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
Message-ID: <202603121049.f2P9Ik4Y-lkp@intel.com>
References: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-266871-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,carl.lee.amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: AA67626C5F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carl,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7109a2155340cc7b21f27e832ece6df03592f2e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Carl-Lee-via-B4-Relay/nfc-nxp-nci-i2c-restore-IRQ-trigger-fallback/20260311-174025
base:   7109a2155340cc7b21f27e832ece6df03592f2e8
patch link:    https://lore.kernel.org/r/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7%40amd.com
patch subject: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260312/202603121049.f2P9Ik4Y-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603121049.f2P9Ik4Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603121049.f2P9Ik4Y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nfc/nxp-nci/i2c.c:311:13: error: call to undeclared function 'irq_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     311 |         irqflags = irq_get_trigger_type(client->irq);
         |                    ^
   1 error generated.


vim +/irq_get_trigger_type +311 drivers/nfc/nxp-nci/i2c.c

   265	
   266	static int nxp_nci_i2c_probe(struct i2c_client *client)
   267	{
   268		struct device *dev = &client->dev;
   269		struct nxp_nci_i2c_phy *phy;
   270		int r;
   271		unsigned long irqflags;
   272	
   273		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
   274			nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
   275			return -ENODEV;
   276		}
   277	
   278		phy = devm_kzalloc(&client->dev, sizeof(struct nxp_nci_i2c_phy),
   279				   GFP_KERNEL);
   280		if (!phy)
   281			return -ENOMEM;
   282	
   283		phy->i2c_dev = client;
   284		i2c_set_clientdata(client, phy);
   285	
   286		r = devm_acpi_dev_add_driver_gpios(dev, acpi_nxp_nci_gpios);
   287		if (r)
   288			dev_dbg(dev, "Unable to add GPIO mapping table\n");
   289	
   290		phy->gpiod_en = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
   291		if (IS_ERR(phy->gpiod_en)) {
   292			nfc_err(dev, "Failed to get EN gpio\n");
   293			return PTR_ERR(phy->gpiod_en);
   294		}
   295	
   296		phy->gpiod_fw = devm_gpiod_get_optional(dev, "firmware", GPIOD_OUT_LOW);
   297		if (IS_ERR(phy->gpiod_fw)) {
   298			nfc_err(dev, "Failed to get FW gpio\n");
   299			return PTR_ERR(phy->gpiod_fw);
   300		}
   301	
   302		r = nxp_nci_probe(phy, &client->dev, &i2c_phy_ops,
   303				  NXP_NCI_I2C_MAX_PAYLOAD, &phy->ndev);
   304		if (r < 0)
   305			return r;
   306	
   307		/* Prefer the trigger type configured by firmware.
   308		 * Some platforms do not provide it, so fall back to the
   309		 * historically used rising-edge trigger.
   310		 */
 > 311		irqflags = irq_get_trigger_type(client->irq);
   312		if (!irqflags)
   313			irqflags = IRQF_TRIGGER_RISING;
   314	
   315		r = request_threaded_irq(client->irq, NULL,
   316					 nxp_nci_i2c_irq_thread_fn,
   317					 irqflags | IRQF_ONESHOT,
   318					 NXP_NCI_I2C_DRIVER_NAME, phy);
   319		if (r < 0)
   320			nfc_err(&client->dev, "Unable to register IRQ handler\n");
   321	
   322		return r;
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

