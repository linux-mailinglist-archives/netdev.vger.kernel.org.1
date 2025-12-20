Return-Path: <netdev+bounces-245594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FCECD327D
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 16:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69FD3014A22
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73892749E0;
	Sat, 20 Dec 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwJLZTg7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6752765C5;
	Sat, 20 Dec 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766245464; cv=none; b=RQ/qKRcR4Bs1JBx4GfItl6Ozt3X3CCY2IZWe/bK4GPQOodMzB3A1M2+3hNNRn/7fQ9zUslKuWQS1ES2KecVs13F4imBRjl0EGv/YpcJfeQeHhZ3Mcovz15l/aPRwhqyRqVkRCho+T4rRlGu7oy6V6VlHNNwGgB/HhIxITSKpbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766245464; c=relaxed/simple;
	bh=sPTfzgRAB6RKo0v/+78CZE6GdRZEgXz+wQviLbdQR20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjDFCFt/P/r2OHP95nd7PBrbVrmv8MREk1Aiy1HE/OE/sixofSHP9Ka7c2SsUKwsDfqkHbmviPaB8r0q1JXKGSyVYzdLHcnhnvFBpRyl/4t2yRbPmZ6m9tTyFLqR4a/SkeU2n/p9w09SZzyYP3dTrxmxSaXwka7I8q17lJFL3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwJLZTg7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766245463; x=1797781463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sPTfzgRAB6RKo0v/+78CZE6GdRZEgXz+wQviLbdQR20=;
  b=bwJLZTg7EswXssE31yeY1b0LUhnVUfzs8P3awvmB7CDRYgLnZnMcu4xT
   O5+OwaJLhkhqcKQYNMbglFaSEZaxXMPDFI9UKnOdnTsyzKhVFY0W+ym9W
   9uLC+iMq+woH/pwDFA+HDIqkIdnvxoR4M3NJuWlBV8sYYC9brSWFlQ6s1
   4DIMyPHyxnKIEge6OTGU8JD1Xg7hC38dr2AZ3p24YG0o9o+HicHQS7AXJ
   nY5b43KIraH8ogf3Hw5T0r0pnh+qnFXDIUCwqDR+YWJQ/f/2ZtGs9KNzJ
   /ThpSfj+WrkiObyuQA1MdryY3C7zTT0lphjJC5MybvGzKPpX9EWF8wzMH
   A==;
X-CSE-ConnectionGUID: yvLqZvBUQoeY8iosGI1hvw==
X-CSE-MsgGUID: AUVhemQmQ9mqfRgJA5vRjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="90838742"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="90838742"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:44:22 -0800
X-CSE-ConnectionGUID: wENouVOqQGO/o8GLybGm3A==
X-CSE-MsgGUID: wToCnkxuQL2Ch03L4CHG+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="222597991"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2025 07:44:18 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWz7v-000000004m3-2Tdb;
	Sat, 20 Dec 2025 15:44:15 +0000
Date: Sat, 20 Dec 2025 23:43:43 +0800
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
Message-ID: <202512202353.A3cnxg81-lkp@intel.com>
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
[also build test ERROR on net-next/main net/main linus/master v6.19-rc1]
[cannot apply to bluetooth/master next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naga-Bhavani-Akella/Bluetooth-hci_sync-Initial-LE-Channel-Sounding-support-by-defining-required-HCI-command-event-structures/20251216-202908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20251216113753.3969183-1-naga.akella%40oss.qualcomm.com
patch subject: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding support by defining required HCI command/event structures.
config: x86_64-randconfig-161-20251217 (https://download.01.org/0day-ci/archive/20251220/202512202353.A3cnxg81-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202353.A3cnxg81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202353.A3cnxg81-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/bluetooth/hci_core.c:39:
   In file included from include/net/bluetooth/hci_core.h:35:
>> include/net/bluetooth/hci.h:2430:8: error: redefinition of 'hci_cp_le_cs_set_proc_param'
    2430 | struct hci_cp_le_cs_set_proc_param {
         |        ^
   include/net/bluetooth/hci.h:2407:8: note: previous definition is here
    2407 | struct hci_cp_le_cs_set_proc_param {
         |        ^
   1 error generated.


vim +/hci_cp_le_cs_set_proc_param +2430 include/net/bluetooth/hci.h

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

