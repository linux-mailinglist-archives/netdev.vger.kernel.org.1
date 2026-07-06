Return-Path: <netdev+bounces-305135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +W2cC/DwS2qJdQEAu9opvQ
	(envelope-from <netdev+bounces-305135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:16:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61E7145FA
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:16:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gp4sPCxu;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305135-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305135-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4307730479EE
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E843AE6E6;
	Mon,  6 Jul 2026 16:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9C39F19E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354221; cv=none; b=LfzuJ3Ex+hJR4v/sb5a6eK6H1P/KcJ6xl09tW0ItVhQW1znZGCr4s9V3gVYWC6IkoixIYkJ7aymccJ5F7EwRlei2HREozSzTGyQZ8z00GFMOgkLDIXDgs6xHet+jKW9dOjZyJSw4PFyn+eFg+u3n+DCiP9ll2OdU96B8o+Fs1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354221; c=relaxed/simple;
	bh=+MpXM3rms7tMeiOwh4i//Jc8YnWa+BFlnkeGhMYW3lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZYk2W+CZyTXLUsIxxrMHM7hIhgZqA08iDfUq2aK9UWwd9sjAYcRrzAXMsx1KXmiqFxLChtIFHHf5+Y+smGwLiUG35mIhlsrNvBa3ZdA/W3Tbum5Uq06UxIoCQZgaJ8EJTLwY3R8QF0Wr4HHLkO+e/ushLV6KDUqzJ9FqoZrwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp4sPCxu; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783354220; x=1814890220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+MpXM3rms7tMeiOwh4i//Jc8YnWa+BFlnkeGhMYW3lw=;
  b=gp4sPCxuRYSbP7d2WAADViCRJt0UeWBCueI+7LutUeBoZDeNvFeIQkYR
   JmzqNwwmmcgqrKS8TSI3hWtCyoiPVqsyNaWzPci86PHnHm28tQor+6oyD
   i6BN17fZwb4+8vV3xTi6SoXm9r3J2hx45SyYkKYfhhA0gR54T6iD6yLgj
   oTp263+VF4aOEJGZPWcyBMLPNdRoXN46gR2iP1ruduYabtyJ0tzk5YbPm
   L3gZdPbpuR38qCnJrwjC8CzAXWQH+PIHqY1GkMnrn4EgNOFCQKa3RySRg
   6EF5nQINLd92YhBc1RigiwKxGVDFQV/+SD1c5idr/mbNCHB7HI52iN7jg
   w==;
X-CSE-ConnectionGUID: uQ33TEdYQHqkRvDRkM0wUg==
X-CSE-MsgGUID: Bb7LVZHwRACF52MBxhsQAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95372048"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95372048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:10:19 -0700
X-CSE-ConnectionGUID: v+mJnvRkRP+cPbTaEaVuPg==
X-CSE-MsgGUID: 85eWajhgR/yxX4+BkyQtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="257331802"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Jul 2026 09:10:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wgltf-00000000EX5-04qL;
	Mon, 06 Jul 2026 16:10:15 +0000
Date: Tue, 7 Jul 2026 00:09:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: E610: force phy
 link to get down when interface is down
Message-ID: <202607070035.qAAqVjGH-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:oe-kbuild-all@lists.linux.dev,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F61E7145FA

Hi Jedrzej,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Jedrzej-Jagielski/ixgbe-E610-force-phy-link-to-get-down-when-interface-is-down/20260706-180351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260706094330.186341-1-jedrzej.jagielski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: E610: force phy link to get down when interface is down
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260707/202607070035.qAAqVjGH-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260707/202607070035.qAAqVjGH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607070035.qAAqVjGH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_close':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7572:25: error: implicit declaration of function 'e_error'; did you mean 'e_err'? [-Wimplicit-function-declaration]
    7572 |                         e_error(drv, "Cannot set PHY link down\n");
         |                         ^~~~~~~
         |                         e_err
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7572:33: error: 'drv' undeclared (first use in this function)
    7572 |                         e_error(drv, "Cannot set PHY link down\n");
         |                                 ^~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7572:33: note: each undeclared identifier is reported only once for each function it appears in


vim +7572 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

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

