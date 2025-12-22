Return-Path: <netdev+bounces-245728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C00CD643D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9DF53020C6B
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F032B994;
	Mon, 22 Dec 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5f3sGZg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8D32ABF9;
	Mon, 22 Dec 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411726; cv=none; b=DfU9dGA7N25KF80Dp7u5E9b9Ptaq9KLXQKPnFR32rxzssiscRMNGkQEpU2nXvOIeazeYs2WTS1j2zIq3uCzFrp66Rhv++Jzr8eGFm5dI79WgllHYajdm+mFrlJIM8dZSK4sggPsKJLuOPKKkFesJY7TH2BjGkIvZ7leRoeginh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411726; c=relaxed/simple;
	bh=iVUOQTvyAcWMUm5+vyDIUFL9gPJNw55kGB/8CyiS6Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3bD6vTiQ2gFFOagpjIYlCbdN6hSEutTPGEp6iDNFvv1whKvvAyTWjgz3HFB49RBs6LfHY2EfG0qgoIwC0h2sc1XqXbhCJaMoSvMYEgIiIOHxYfJEmNxbvd+cb1ZP5emH5JKwvU4KMf56HAdy3ACMRcDuB1aQVL8vX3Dj6XWqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5f3sGZg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766411725; x=1797947725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iVUOQTvyAcWMUm5+vyDIUFL9gPJNw55kGB/8CyiS6Xw=;
  b=A5f3sGZgg5MqcLHPt47TJllqRc84ZPr4kyBfGAsj/AxOiSwlBDCophrD
   2FQX8k6BV7AiVQ6u1fK4Ostq5yHO+s6m6H+g5k9Q7UIfBSB11DCZXbuiv
   pquOGA/xPOZdzcdzgicquoYNXjCU0WiohLI0IcwQnQ9BlRzsSSeGjPMBu
   pFyS9lj8WadY+2mrBjqV8PEihr2/su92iTnqQCFDa6NbLwZFJfsY7JOLP
   RsW7ElmEiqOlql+cyaeaRPbyTLx3P4a2E9JxIfeIQvLYQ7VVO6Nln3MZx
   K5BEMjJjpT37N2T77EM44ZV7RNYwhBBE2f2DcxYHzag1kQQ+wBCTaVhA2
   Q==;
X-CSE-ConnectionGUID: uDE9yGd1TDedFfBec93Jrg==
X-CSE-MsgGUID: If21tjQcROi5gg6Gqampeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79626641"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="79626641"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 05:55:24 -0800
X-CSE-ConnectionGUID: X0Vl+MZxQImF2H9r2iO1ug==
X-CSE-MsgGUID: NVxBXRpWSZCr2WjBm09GQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="204584115"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 22 Dec 2025 05:55:20 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXgNZ-000000005V2-3P73;
	Mon, 22 Dec 2025 13:55:17 +0000
Date: Mon, 22 Dec 2025 14:54:18 +0100
From: kernel test robot <lkp@intel.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
	hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding
 support by defining required HCI command/event structures.
Message-ID: <202512221453.cZfzdvAS-lkp@intel.com>
References: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>

Hi Naga,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on net-next/main net/main]
[cannot apply to bluetooth/master linus/master v6.16-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naga-Bhavani-Akella/Bluetooth-hci_sync-Initial-LE-Channel-Sounding-support-by-defining-required-HCI-command-event-structures/20251216-202908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20251216113753.3969183-1-naga.akella%40oss.qualcomm.com
patch subject: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding support by defining required HCI command/event structures.
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251222/202512221453.cZfzdvAS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221453.cZfzdvAS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221453.cZfzdvAS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/bluetooth/hci_core.h:35,
                    from net/bluetooth/hci_core.c:39:
>> include/net/bluetooth/hci.h:2430:8: error: redefinition of 'struct hci_cp_le_cs_set_proc_param'
    2430 | struct hci_cp_le_cs_set_proc_param {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/bluetooth/hci.h:2407:8: note: originally defined here
    2407 | struct hci_cp_le_cs_set_proc_param {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2430 include/net/bluetooth/hci.h

  2428	
  2429	#define HCI_OP_LE_CS_SET_PROC_ENABLE		0x2094
> 2430	struct hci_cp_le_cs_set_proc_param {
  2431		__le16  conn_hdl;
  2432		__u8	config_id;
  2433		__u8	enable;
  2434	} __packed;
  2435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

