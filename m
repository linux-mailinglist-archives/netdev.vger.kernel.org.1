Return-Path: <netdev+bounces-213592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BCB25C20
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E6F188C865
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A3257440;
	Thu, 14 Aug 2025 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhV213J4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8A253B47;
	Thu, 14 Aug 2025 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154055; cv=none; b=SYGlLT/HRIWC0JBjOQMneZhF8OAx2Q8svZN3EP+7nPGH0JIv/k3cnw8D415CAPmXAK7VN5dswri55vd7FiZ9FARxxiktcPKiG3lX0vzz41jeuOlqyk3uyz8++zBhE61H4nY3IVqZAXJxnxXoi2zzXWzgNLRsw8Fas89shae1YlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154055; c=relaxed/simple;
	bh=XvPc8HzjswWuTYiAMjYzuffOvKnIpKNewoQ0Hd37OCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY0C6hgglWBrVKzwhOcPXQH2JpcBEL8roNX1amqCH4Ueeh0iD8uieh4TUSDlrquiK3VmMO4mQD++iOQIG6I2cvIsbCeKDK/lwvCzMCmetxI2xfmEB1kPeP0uFKhRhl+CRdl11lircFSijuCRT20KdPs4RtOCQjF4Jdm5zgGDTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhV213J4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755154054; x=1786690054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XvPc8HzjswWuTYiAMjYzuffOvKnIpKNewoQ0Hd37OCs=;
  b=RhV213J4v/TEtAsd0KYTUFLx9ZvBaQIjzy1SAElEHm3bGQKDBJHadwmZ
   jDoOURWssOoY4EcDjAJVJPgdEsxEE/TH9kKwlPThVALWaiPzFm66DrxTs
   Zr6K6JXOc3+SjoMQlaL8Q2PMbjYxV8L940Twt+e4XGw+w4FbhfSlA3+Qg
   0HpkX9GMr5VRWEpkCojDj1QSNRyFrVgkmyk1S/jDlNg6i+5ubK0ZVsRHo
   oHSjoplAaslTnplhLkGSpeCI9ehnOQjcIsVvhDJtD/Uym8wNYVc+QotjQ
   GgYtTaeC/TkMrJy34vw3DV79Ek8FYtx/EsPNltMR4hvrR7zxqvMU/H4p8
   w==;
X-CSE-ConnectionGUID: K6w0fXObQMyB1nTPLjCyNQ==
X-CSE-MsgGUID: FhufOdhJR1WJINuZRa1v1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57330007"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57330007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:47:33 -0700
X-CSE-ConnectionGUID: JeJVqeKeSaKpD0s+Gaz0qg==
X-CSE-MsgGUID: kVEGrLsDRaK7PJjZKb9Veg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197539847"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2025 23:47:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umRkE-000AfM-0t;
	Thu, 14 Aug 2025 06:47:26 +0000
Date: Thu, 14 Aug 2025 14:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 7/9] bng_en: Register rings with the firmware
Message-ID: <202508141404.DrfpnTy0-lkp@intel.com>
References: <20250813215603.76526-8-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813215603.76526-8-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Add-initial-support-for-RX-and-TX-rings/20250814-004339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250813215603.76526-8-bhargava.marreddy%40broadcom.com
patch subject: [net-next 7/9] bng_en: Register rings with the firmware
config: loongarch-randconfig-r073-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141404.DrfpnTy0-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141404.DrfpnTy0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141404.DrfpnTy0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:768:32: warning: variable 'resp' set but not used [-Wunused-but-set-variable]
     768 |         struct hwrm_ring_free_output *resp;
         |                                       ^
   1 warning generated.


vim +/resp +768 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c

   763	
   764	int hwrm_ring_free_send_msg(struct bnge_net *bn,
   765				    struct bnge_ring_struct *ring,
   766				    u32 ring_type, int cmpl_ring_id)
   767	{
 > 768		struct hwrm_ring_free_output *resp;
   769		struct hwrm_ring_free_input *req;
   770		struct bnge_dev *bd = bn->bd;
   771		int rc;
   772	
   773		rc = bnge_hwrm_req_init(bd, req, HWRM_RING_FREE);
   774		if (rc)
   775			goto exit;
   776	
   777		req->cmpl_ring = cpu_to_le16(cmpl_ring_id);
   778		req->ring_type = ring_type;
   779		req->ring_id = cpu_to_le16(ring->fw_ring_id);
   780	
   781		resp = bnge_hwrm_req_hold(bd, req);
   782		rc = bnge_hwrm_req_send(bd, req);
   783		bnge_hwrm_req_drop(bd, req);
   784	exit:
   785		if (rc) {
   786			netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
   787			return -EIO;
   788		}
   789		return 0;
   790	}
   791	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

