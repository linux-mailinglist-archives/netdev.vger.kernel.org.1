Return-Path: <netdev+bounces-245590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED2CD322F
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A9B3027DB8
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9C274FD3;
	Sat, 20 Dec 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUGs4G0J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82A270ED9;
	Sat, 20 Dec 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244802; cv=none; b=gTmzIy8+7ET+A4BiVP4HkjkWfJj0Wxmer+lUPtR5sZmbDGP8uzYsWVhucbB0C0ya1odshNoQzIFo82FNbnCsm+1KrR0B1jPsSTGFYVnhc6dtCR/CKqq+Y2XvX2EvbCE+0DJhN0ncOy+EjTkoY3HB1sZe0cg0DSeZvh3eCFhGr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244802; c=relaxed/simple;
	bh=psCh1TYkBto3F/c5tTwekWgwUEj/QzB04jmM1OIM3R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPlMg6L2QX5ITNh0juDAKe+L3NAbrLhxuXKa5d3UkM/a+a4dmAkoUtJw8Gdd5CHgwiG5IxLPNYuj3i1cxoAc90TFUyCG+FX/RJQRwjzl7hREG/vsDeSz644XgYtptOGgnNhVVFMVeT7Mr2dHB5eAVsQyjOYelPjshwK++/3Prhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUGs4G0J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766244801; x=1797780801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=psCh1TYkBto3F/c5tTwekWgwUEj/QzB04jmM1OIM3R4=;
  b=KUGs4G0Jhs3Kb6Q2UT51tQc0+NBNiGiC57LKw3gvkQQVlVysvNHs4jCy
   3HT7BU+m0YqbUw0YTZwj7cUnLjJmxjzRq3rC77pqH50PpIE8sOH+rG1g/
   fMMz8H4Py10FtjAYPSvQ9ouG6mBceL74iYlV0grvRo/LY4VotPd1jfcGu
   9zfB89v8egdRfZ7i2idF4wRX9VtvCqEOKWs9S1PoQS4taEpaE4OfFxGOu
   xI6ZX/1XxtKdBS2HMESW7SHg3rzC/p6X9jbB9pERb3//rZSL0FbOgMBNs
   0goPYA1Tijz+O5bGzfiCfDwxTbS79N50fGt+zdHflut4bF4aEey5vwm7t
   w==;
X-CSE-ConnectionGUID: NWXE8YOXQZK8pesBupmMdQ==
X-CSE-MsgGUID: xflPaKTWQ0+lcMQHYBGTMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67927110"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67927110"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:33:20 -0800
X-CSE-ConnectionGUID: nUmViF3vTfuwZeRj+B1kzA==
X-CSE-MsgGUID: H6rRap5ORXi6DqlZSg4bvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="203569341"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2025 07:33:16 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyxG-000000004ks-1V0h;
	Sat, 20 Dec 2025 15:33:14 +0000
Date: Sat, 20 Dec 2025 23:33:07 +0800
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
Message-ID: <202512202215.swPhiL21-lkp@intel.com>
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
config: arm-am200epdkit_defconfig (https://download.01.org/0day-ci/archive/20251220/202512202215.swPhiL21-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202215.swPhiL21-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202215.swPhiL21-lkp@intel.com/

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

