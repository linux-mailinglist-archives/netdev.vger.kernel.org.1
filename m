Return-Path: <netdev+bounces-290236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WuGQDUiKDmqG/QUAu9opvQ
	(envelope-from <netdev+bounces-290236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:30:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC859ECFF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD18F3023B82
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44331F9B8;
	Thu, 21 May 2026 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1E89Wsq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F61FBC8E;
	Thu, 21 May 2026 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337797; cv=none; b=hd5hfhcGn4b2hEfqpObfyrXwXBzrqJiJYWKlQeJqBeUfk9kC2iDPeQ4gIqIPLBYNuOFrJFW+mQrFEnG5yKTdJQsgvhv1haSmhyGXnFJ6rc0OO+iuInSPJOzBPMqOTemRa1cG2G/66y9FVuoECbjlvPN5n9JW4Dxn5TyGLv9SaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337797; c=relaxed/simple;
	bh=uIvRCcbzxrtdYkOav7HVbZt3CLeBOyzpGDcJnWKnIqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o19YU5TiiDx9vEi7Hmets9YzZfaYjueWC0wmQ4/fdMwOiVN/AHMwzYj5DaXkm37hHsGzrgJmn3uVycOtsrsdfBK50DktFWVs5mv+zI4SFns6YhI7qj6IqGUsnB3rAZabZKnTfL3dQoBqrf/OSGJ/NoYxxcgsOsuPDi+Al5UogwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1E89Wsq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779337794; x=1810873794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uIvRCcbzxrtdYkOav7HVbZt3CLeBOyzpGDcJnWKnIqY=;
  b=j1E89WsqvBN4G9jnlk7xU0x6+qoZNTDTYsNrvnAO4z66vZbAF4OzTqPG
   VXf46vZnsSeFMKNLWp92Vn2uPLAaFJwJ2TyxW6S8aZGfzj/2dqyoE5l5T
   Pa43ygmiM/E/gYGSB235cTt/NyqyOZqwNfgMwKR39P+UEkGhOvukNWoO1
   PVUEVACyhk9DE5qtj3lMdXPU0LI/ooTxrhfgcjWP97zYcq8JKlH8dqvHM
   vgchphaZHJUwhoU6a+gqoKOf69f4jrw2ytZiTPsNav9xgqsxHPlG24a5b
   kYszO2mwwSyK2+5mpF54OJptzapDeZI1XD4ZEprVq9S+KukV+5u5nVa1p
   Q==;
X-CSE-ConnectionGUID: cbMnlAXiSACUmUV5PhT2xA==
X-CSE-MsgGUID: RKDfv4XYS+CXXLHj20y0Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80283222"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80283222"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 21:29:53 -0700
X-CSE-ConnectionGUID: sMH46EwnSIuW5NdBmuYpPQ==
X-CSE-MsgGUID: k9nt8hDcT+GaMoJMkKAUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="242217160"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 20 May 2026 21:29:51 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPv2a-00000000Alh-3la3;
	Thu, 21 May 2026 04:29:48 +0000
Date: Thu, 21 May 2026 06:29:02 +0200
From: kernel test robot <lkp@intel.com>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Tobias Regnery <tobias.regnery@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net: alx: fix possible buffer overflow
Message-ID: <202605210628.C9sdnzRO-lkp@intel.com>
References: <20260520180140.538826-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520180140.538826-1-grandmaster@al2klimov.de>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290236-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[al2klimov.de,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 71BC859ECFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v7.1-rc4 next-20260520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-A-Klimov/net-alx-fix-possible-buffer-overflow/20260521-022058
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260520180140.538826-1-grandmaster%40al2klimov.de
patch subject: [PATCH] net: alx: fix possible buffer overflow
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260521/202605210628.C9sdnzRO-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605210628.C9sdnzRO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605210628.C9sdnzRO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/atheros/alx/main.c: In function 'alx_request_msix':
>> drivers/net/ethernet/atheros/alx/main.c:874:77: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     874 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-rx-%u",
         |                                                                             ^
   drivers/net/ethernet/atheros/alx/main.c:874:25: note: 'snprintf' output between 6 and 25 bytes into a destination of size 24
     874 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-rx-%u",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     875 |                                  netdev->name, np->rxq->queue_idx);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/atheros/alx/main.c:871:77: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     871 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-tx-%u",
         |                                                                             ^
   drivers/net/ethernet/atheros/alx/main.c:871:25: note: 'snprintf' output between 6 and 25 bytes into a destination of size 24
     871 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-tx-%u",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     872 |                                  netdev->name, np->txq->queue_idx);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/atheros/alx/main.c:868:77: warning: '%u' directive output may be truncated writing between 1 and 5 bytes into a region of size between 3 and 18 [-Wformat-truncation=]
     868 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-TxRx-%u",
         |                                                                             ^~
   drivers/net/ethernet/atheros/alx/main.c:868:68: note: directive argument in the range [0, 65535]
     868 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-TxRx-%u",
         |                                                                    ^~~~~~~~~~~~
   drivers/net/ethernet/atheros/alx/main.c:868:25: note: 'snprintf' output between 8 and 27 bytes into a destination of size 24
     868 |                         snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-TxRx-%u",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     869 |                                  netdev->name, np->txq->queue_idx);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +874 drivers/net/ethernet/atheros/alx/main.c

   851	
   852	static int alx_request_msix(struct alx_priv *alx)
   853	{
   854		struct net_device *netdev = alx->dev;
   855		int i, err, vector = 0, free_vector = 0;
   856	
   857		err = request_irq(pci_irq_vector(alx->hw.pdev, 0), alx_intr_msix_misc,
   858				  0, netdev->name, alx);
   859		if (err)
   860			goto out_err;
   861	
   862		for (i = 0; i < alx->num_napi; i++) {
   863			struct alx_napi *np = alx->qnapi[i];
   864	
   865			vector++;
   866	
   867			if (np->txq && np->rxq)
 > 868				snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-TxRx-%u",
   869					 netdev->name, np->txq->queue_idx);
   870			else if (np->txq)
 > 871				snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-tx-%u",
   872					 netdev->name, np->txq->queue_idx);
   873			else if (np->rxq)
 > 874				snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-rx-%u",
   875					 netdev->name, np->rxq->queue_idx);
   876			else
   877				snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-unused",
   878					 netdev->name);
   879	
   880			np->vec_idx = vector;
   881			err = request_irq(pci_irq_vector(alx->hw.pdev, vector),
   882					  alx_intr_msix_ring, 0, np->irq_lbl, np);
   883			if (err)
   884				goto out_free;
   885		}
   886		return 0;
   887	
   888	out_free:
   889		free_irq(pci_irq_vector(alx->hw.pdev, free_vector++), alx);
   890	
   891		vector--;
   892		for (i = 0; i < vector; i++)
   893			free_irq(pci_irq_vector(alx->hw.pdev,free_vector++),
   894				 alx->qnapi[i]);
   895	
   896	out_err:
   897		return err;
   898	}
   899	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

