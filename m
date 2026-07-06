Return-Path: <netdev+bounces-305121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5kgGNGjlS2pBcQEAu9opvQ
	(envelope-from <netdev+bounces-305121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:27:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19D713D94
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:27:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SHPP5DuG;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305121-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305121-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B319734D8951
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7F3A961B;
	Mon,  6 Jul 2026 15:28:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A073A900B
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:28:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351714; cv=none; b=IDinFWV0gvxH1UWD2ubaHRc8oIcXLZqkBr0+mnqaJZcZeUOuBY0GaUcCZokOMjpIffNrt63Ru315bhPFm2tkPIj2U65IBPOWjGW6KQ364zAAw57aCKDE5JZY1FCRavnkJtIYggJ/V6hRJ8Beu2l4Z8tLkWe/pFMB7m3qNoDM7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351714; c=relaxed/simple;
	bh=Kx0R10CEtuT7dVwxzZnlGtk8d2BtAd7kwxR4Q9KdOp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odPRdKtBMbzUI1Im09Tp36TIjXltTp/KdF/30UtoUUjc4zCsj555XgXNW/z53BnMeLDQEjNnyCnsIfafCzHA+ANHO9ABL+bYBSB/FUUr/WRV2SliojAHa+4JFhSFQWeq2TNX7U+U6bp6HKKUoNRBwgwMhL0jTHyOjWvbtVSWuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHPP5DuG; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783351712; x=1814887712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kx0R10CEtuT7dVwxzZnlGtk8d2BtAd7kwxR4Q9KdOp0=;
  b=SHPP5DuGhwk3dNMtOkXB+K0b7yop4CuRWyw808+Q93eYU447i5nDjANl
   vpSu81HAoUgfq+/FO8QMzm0HWCYOMVVkAJHY04mAfz/Ws4TCZi655t9KJ
   N+v/ZQTPOW7O/o1zGm8wsIjk9QSEHv+wlCloYKkU9/Sv/SZosz0syadiq
   Ydumest/rdGGgsdd8WP7Dt22lhVPOmyvIDZ2/TZ2vFEKAJ37/xUqPZ478
   uu0VMs3YbWxDwuxc0iaolBBdgNsVDCgvag9xGkFA/js8HYpRwIzA8niuY
   DOUcFm1uhf+jSJ4Sf6KXf5vIuEP8kPxDankAKeAnQmwBPEkONMJNv+pGN
   g==;
X-CSE-ConnectionGUID: Fso6G3xeQBWEvUp3WRe2Xw==
X-CSE-MsgGUID: VroglsgWS++qvWYcYQHiMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83760414"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83760414"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:28:32 -0700
X-CSE-ConnectionGUID: qeSsvuFKQWW/DlBsmwRgrw==
X-CSE-MsgGUID: Q8NX88hiSP+EOWE0QzcwWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283833104"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jul 2026 08:28:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wglEt-00000000EUV-1S9t;
	Mon, 06 Jul 2026 15:28:07 +0000
Date: Mon, 6 Jul 2026 23:27:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: E610: force phy
 link to get down when interface is down
Message-ID: <202607062312.8lqgVLms-lkp@intel.com>
References: <20260706094330.186341-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706094330.186341-1-jedrzej.jagielski@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305121-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B19D713D94

Hi Jedrzej,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Jedrzej-Jagielski/ixgbe-E610-force-phy-link-to-get-down-when-interface-is-down/20260706-180351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260706094330.186341-1-jedrzej.jagielski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: E610: force phy link to get down when interface is down
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260706/202607062312.8lqgVLms-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260706/202607062312.8lqgVLms-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607062312.8lqgVLms-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7572:4: error: call to undeclared function 'e_error'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    7572 |                         e_error(drv, "Cannot set PHY link down\n");
         |                         ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7572:12: error: use of undeclared identifier 'drv'
    7572 |                         e_error(drv, "Cannot set PHY link down\n");
         |                                 ^~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8928:14: warning: division by zero is undefined [-Wdivision-by-zero]
    8928 |         cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_HW_VLAN,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    8929 |                                    IXGBE_ADVTXD_DCMD_VLE);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8932:14: warning: division by zero is undefined [-Wdivision-by-zero]
    8932 |         cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSO,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    8933 |                                    IXGBE_ADVTXD_DCMD_TSE);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8936:14: warning: division by zero is undefined [-Wdivision-by-zero]
    8936 |         cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSTAMP,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    8937 |                                    IXGBE_ADVTXD_MAC_TSTAMP);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8940:14: warning: division by zero is undefined [-Wdivision-by-zero]
    8940 |         cmd_type ^= IXGBE_SET_FLAG(skb->no_fcs, 1, IXGBE_ADVTXD_DCMD_IFCS);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8951:19: warning: division by zero is undefined [-Wdivision-by-zero]
    8951 |         olinfo_status |= IXGBE_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~
    8952 |                                         IXGBE_TX_FLAGS_CSUM,
         |                                         ~~~~~~~~~~~~~~~~~~~~
    8953 |                                         IXGBE_ADVTXD_POPTS_TXSM);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8956:19: warning: division by zero is undefined [-Wdivision-by-zero]
    8956 |         olinfo_status |= IXGBE_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~
    8957 |                                         IXGBE_TX_FLAGS_IPV4,
         |                                         ~~~~~~~~~~~~~~~~~~~~
    8958 |                                         IXGBE_ADVTXD_POPTS_IXSM);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8961:19: warning: division by zero is undefined [-Wdivision-by-zero]
    8961 |         olinfo_status |= IXGBE_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~
    8962 |                                         IXGBE_TX_FLAGS_IPSEC,
         |                                         ~~~~~~~~~~~~~~~~~~~~~
    8963 |                                         IXGBE_ADVTXD_POPTS_IPSEC);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8969:19: warning: division by zero is undefined [-Wdivision-by-zero]
    8969 |         olinfo_status |= IXGBE_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~
    8970 |                                         IXGBE_TX_FLAGS_CC,
         |                                         ~~~~~~~~~~~~~~~~~~
    8971 |                                         IXGBE_ADVTXD_CC);
         |                                         ~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8918:26: note: expanded from macro 'IXGBE_SET_FLAG'
    8918 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   8 warnings and 2 errors generated.


vim +/e_error +7572 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  7544	
  7545	/**
  7546	 * ixgbe_close - Disables a network interface
  7547	 * @netdev: network interface device structure
  7548	 *
  7549	 * Returns 0, this is not allowed to fail
  7550	 *
  7551	 * The close entry point is called when an interface is de-activated
  7552	 * by the OS.  The hardware is still under the drivers control, but
  7553	 * needs to be disabled.  A global MAC reset is issued to stop the
  7554	 * hardware, and all transmit and receive resources are freed.
  7555	 **/
  7556	int ixgbe_close(struct net_device *netdev)
  7557	{
  7558		struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
  7559	
  7560		ixgbe_ptp_stop(adapter);
  7561	
  7562		if (netif_device_present(netdev))
  7563			ixgbe_close_suspend(adapter);
  7564	
  7565		ixgbe_fdir_filter_exit(adapter);
  7566	
  7567		if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE) {
  7568			int err;
  7569	
  7570			err = ixgbe_disable_phy_link(&adapter->hw);
  7571			if (err)
> 7572				e_error(drv, "Cannot set PHY link down\n");
  7573	
  7574			ixgbe_handle_link_down(adapter);
  7575		}
  7576	
  7577		ixgbe_release_hw_control(adapter);
  7578	
  7579		return 0;
  7580	}
  7581	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

