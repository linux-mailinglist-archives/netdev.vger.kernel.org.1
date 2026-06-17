Return-Path: <netdev+bounces-300235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 17o9BIn9Mmpj8QUAu9opvQ
	(envelope-from <netdev+bounces-300235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:03:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2469C493
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OK8FOx6l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E169B300F442
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91137C11C;
	Wed, 17 Jun 2026 20:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251E2EBDDE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 20:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726598; cv=none; b=CCJIo9iPkjTWQ2WflU7tjCik6O1hwQEet1Idg/S40Ib+9lUe+oVMBG54aAxpk7sgiY9dU+OzSO6mO3I1r0zzhY7jtTPMsiDpP66T2/38QBsa+Gf0WKhIyldhu+tl1gMovIvV9UVLehC8yXS9GtSLLiRx5JN14NRfDkYBkxalSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726598; c=relaxed/simple;
	bh=RX26t8axNHR2+20GoC02Y1V789ZRLXoB4J2FYEoPhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQddvg4ndUdZHH5xL077kCE7QuNw6b7FfCM2/De0jWJURV+0wmjby8vKjDEhtR2dcGpRlrKvOMcU4AfrT1k7I1YEDWuSN4Zq6NdcpJH/HwZ/KQ1OnlEpvVpPn0IBrXGxDrV14GtgDO8IV98gMBjwCT4bDaSGv88PBAfNVLZbB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OK8FOx6l; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781726596; x=1813262596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RX26t8axNHR2+20GoC02Y1V789ZRLXoB4J2FYEoPhOI=;
  b=OK8FOx6lyGzj5ocK1xxRLShHn+7nLG7k6S2ONeLeO5S12Adg2fMG/c2W
   s288dO+Kv+5Qw5WUIPxxlzn4ojdaWKUA2Y+OvyRFEWO6ZtfBpxS1e3HP0
   8xtwaXkoqimE77KQS6VbBDV3LT6HizIWbHeWHh1zRqmtXnRVpGIVVgelz
   SuyVamoPQCr6ke/qhP0stHGtoSknG58jHJ3qSuteHRhzBvuZuAPzoz9nu
   00yy80UFeWzpvx/9UqmSAtuvYxKyvTUzyIQ3fE6eJJwCOCnL1Fv+oog9O
   IVN8hesYjVGb8JW9qwWOqno/CguW7FRHyvKHw3X7r42hPhHdxNT65U1o8
   A==;
X-CSE-ConnectionGUID: KDFrm9VkR+qaMBsrQtjh4Q==
X-CSE-MsgGUID: lvnquzDrSXy/W0OSml2WFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82435959"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82435959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 13:03:15 -0700
X-CSE-ConnectionGUID: oZ/Ntua8Tzmscqcny8xYcg==
X-CSE-MsgGUID: BgpdpGDZSzqrbucK7elsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="286268578"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Jun 2026 13:03:12 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZwTc-00000000Uwg-3rli;
	Wed, 17 Jun 2026 20:03:08 +0000
Date: Thu, 18 Jun 2026 04:02:44 +0800
From: kernel test robot <lkp@intel.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	anthony.l.nguyen@intel.com
Cc: oe-kbuild-all@lists.linux.dev, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: Re: [PATCH] e1000: Remove redundant else after return
Message-ID: <202606180301.nRhk5lMR-lkp@intel.com>
References: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-300235-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lovekeshsolanki00@gmail.com,m:anthony.l.nguyen@intel.com,m:oe-kbuild-all@lists.linux.dev,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EA2469C493

Hi Lovekesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lovekesh-Solanki/e1000-Remove-redundant-else-after-return/20260617-051633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260616210008.109635-1-lovekeshsolanki00%40gmail.com
patch subject: [PATCH] e1000: Remove redundant else after return
config: powerpc-randconfig-r073-20260617 (https://download.01.org/0day-ci/archive/20260618/202606180301.nRhk5lMR-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e19d1f51a2c80b63cd8ca95bcc757b7077112808)
smatch: v0.5.0-9185-gbcc58b9c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606180301.nRhk5lMR-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/intel/e1000/e1000_main.c:1551 e1000_setup_tx_resources() warn: inconsistent indenting

Old smatch warnings:
arch/powerpc/include/asm/checksum.h:94 csum_tcpudp_nofold() warn: inconsistent indenting

vim +1551 drivers/net/ethernet/intel/e1000/e1000_main.c

^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1491  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1492  /**
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1493   * e1000_setup_tx_resources - allocate Tx resources (Descriptors)
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1494   * @adapter: board private structure
581d708eb47ccc drivers/net/e1000/e1000_main.c                Mallikarjuna R Chilakala 2005-10-04  1495   * @txdr:    tx descriptor ring (for a specific queue) to setup
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1496   *
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1497   * Return 0 on success, negative on failure
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1498   **/
6479884509e6cd drivers/net/e1000/e1000_main.c                Joe Perches              2008-07-11  1499  static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
581d708eb47ccc drivers/net/e1000/e1000_main.c                Mallikarjuna R Chilakala 2005-10-04  1500  				    struct e1000_tx_ring *txdr)
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1501  {
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1502  	struct pci_dev *pdev = adapter->pdev;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1503  	int size;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1504  
580f321d8498f1 drivers/net/ethernet/intel/e1000/e1000_main.c Florian Westphal         2014-09-03  1505  	size = sizeof(struct e1000_tx_buffer) * txdr->count;
89bf67f1f080c9 drivers/net/e1000/e1000_main.c                Eric Dumazet             2010-11-22  1506  	txdr->buffer_info = vzalloc(size);
14f8dc49532f76 drivers/net/ethernet/intel/e1000/e1000_main.c Joe Perches              2013-02-07  1507  	if (!txdr->buffer_info)
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1508  		return -ENOMEM;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1509  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1510  	/* round up to nearest 4K */
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1511  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1512  	txdr->size = txdr->count * sizeof(struct e1000_tx_desc);
9099cfb9170f35 drivers/net/e1000/e1000_main.c                Milind Arun Choudhary    2007-04-27  1513  	txdr->size = ALIGN(txdr->size, 4096);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1514  
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1515  	txdr->desc = dma_alloc_coherent(&pdev->dev, txdr->size, &txdr->dma,
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1516  					GFP_KERNEL);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1517  	if (!txdr->desc) {
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1518  setup_tx_desc_die:
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1519  		vfree(txdr->buffer_info);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1520  		return -ENOMEM;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1521  	}
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1522  
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1523  	/* Fix for errata 23, can't cross 64kB boundary */
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1524  	if (!e1000_check_64k_bound(adapter, txdr->desc, txdr->size)) {
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1525  		void *olddesc = txdr->desc;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1526  		dma_addr_t olddma = txdr->dma;
feb8f47809fcc6 drivers/net/e1000/e1000_main.c                Emil Tantilov            2010-07-26  1527  		e_err(tx_err, "txdr align check failed: %u bytes at %p\n",
675ad47375c76a drivers/net/e1000/e1000_main.c                Emil Tantilov            2010-04-27  1528  		      txdr->size, txdr->desc);
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1529  		/* Try again, without freeing the previous */
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1530  		txdr->desc = dma_alloc_coherent(&pdev->dev, txdr->size,
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1531  						&txdr->dma, GFP_KERNEL);
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1532  		/* Failed allocation, critical failure */
96838a40f02950 drivers/net/e1000/e1000_main.c                Jesse Brandeburg         2006-01-18  1533  		if (!txdr->desc) {
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1534  			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1535  					  olddma);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1536  			goto setup_tx_desc_die;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1537  		}
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1538  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1539  		if (!e1000_check_64k_bound(adapter, txdr->desc, txdr->size)) {
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1540  			/* give up */
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1541  			dma_free_coherent(&pdev->dev, txdr->size, txdr->desc,
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1542  					  txdr->dma);
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1543  			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1544  					  olddma);
feb8f47809fcc6 drivers/net/e1000/e1000_main.c                Emil Tantilov            2010-07-26  1545  			e_err(probe, "Unable to allocate aligned memory "
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1546  			      "for the transmit descriptor ring\n");
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1547  			vfree(txdr->buffer_info);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1548  			return -ENOMEM;
d66eba46397f54 drivers/net/ethernet/intel/e1000/e1000_main.c Lovekesh Solanki         2026-06-17  1549  		}
2648345fcbadfa drivers/net/e1000/e1000_main.c                Malli Chilakala          2005-04-28  1550  			/* Free old allocation, new allocation was successful */
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27 @1551  			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
b16f53bef9be0a drivers/net/e1000/e1000_main.c                Nick Nunley              2010-04-27  1552  					  olddma);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1553  	}
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1554  	memset(txdr->desc, 0, txdr->size);
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1555  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1556  	txdr->next_to_use = 0;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1557  	txdr->next_to_clean = 0;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1558  
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1559  	return 0;
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1560  }
^1da177e4c3f41 drivers/net/e1000/e1000_main.c                Linus Torvalds           2005-04-16  1561  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

