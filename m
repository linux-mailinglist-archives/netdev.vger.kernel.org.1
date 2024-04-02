Return-Path: <netdev+bounces-84180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE42895E21
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC311F2237A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAD15E5B5;
	Tue,  2 Apr 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZ6R3ck/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A815E20F
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091261; cv=none; b=MK0vt67/7e/DHuChevaCkWLBRxwEisr5y1CcDycZPrOd0uicAnGSzSxafLDdVyCfUHyU49XwDP3vLUu2r0VPZ7+K6UFgzAGQ0t0yCpEOC3frpj3gxzqStR+deiyNl/JDs6v3axVVjQpngAi5sKgJYUCtzn3rQwXVrUfrQ49J+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091261; c=relaxed/simple;
	bh=0dh4rks8DZA/rerPBvDhaWIFWqaos7zitKUPtS5xdI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEMK/uvG80RQLCJaYY6qafC5nBdw2+j6S2pVbcNyZ236Q6u5lXI1dIxWNiWyBAqyssb9ALnJyoQZfkngVP7rusewwnbkq3c/mVNBIGkW/I94H4vlctj7mCWi1hl2lvLXSp+J7ST/Jnsi3TkSuPtLKIyw+FrHUmJtow986LCdDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZ6R3ck/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712091260; x=1743627260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dh4rks8DZA/rerPBvDhaWIFWqaos7zitKUPtS5xdI8=;
  b=nZ6R3ck/8QwaZ7un8a+Wv2X59Oi9gCa8V0zzo235AAX/C/ZoCsZZoY04
   FfOtdlhNkNUdeLNdCHEykOR/9gKNWifq6C1eiEy5O6vTe+KnLkUF5unG3
   ab5iJATqvt1UEQrBDqA04X+gocN9TrZ6mWWJMRjl3UddB3yqgoDZgMYY6
   f6lBuCQY/uuyNAbzpCySn4SItq7jnX3Ew6qy562Bb46tsvqCBk+BTVMMh
   ejd6PxaVwoRRLUYilEKCJd8oO0N5vXQZh4rMxzqb1xDqg4GzItopNwL9h
   i/1+/PpSditpig9IVooRHVIZ/3a1p4jCGje++7dmJiBTX1EVdkPvnhHfr
   A==;
X-CSE-ConnectionGUID: 2rrvzvYUTp6+R2kQFmGQcQ==
X-CSE-MsgGUID: m6FrZCC2RDeJSWPHzDCk4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7160769"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7160769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:54:19 -0700
X-CSE-ConnectionGUID: 4I50Zde3Rmmq0cv3i9cDCQ==
X-CSE-MsgGUID: 2qdnQGE5TwWDZ4JscXzFzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18306073"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2024 13:54:16 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrl93-0001XZ-3B;
	Tue, 02 Apr 2024 20:54:13 +0000
Date: Wed, 3 Apr 2024 04:53:23 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: support dim profile
 fine-tuning
Message-ID: <202404030423.IyBzs9Jd-lkp@intel.com>
References: <1712059988-7705-4-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712059988-7705-4-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/ethtool-provide-customized-dim-profile-management/20240402-201527
base:   net-next/main
patch link:    https://lore.kernel.org/r/1712059988-7705-4-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v3 3/3] virtio-net: support dim profile fine-tuning
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240403/202404030423.IyBzs9Jd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030423.IyBzs9Jd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030423.IyBzs9Jd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/packet/af_packet.c:86:
>> include/linux/virtio_net.h:15:34: warning: 'rx_eqe_conf' defined but not used [-Wunused-const-variable=]
      15 | static const struct dim_cq_moder rx_eqe_conf[] = {
         |                                  ^~~~~~~~~~~


vim +/rx_eqe_conf +15 include/linux/virtio_net.h

    12	
    13	/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
    14	#define VIRTNET_DIM_RX_PKTS 256
  > 15	static const struct dim_cq_moder rx_eqe_conf[] = {
    16		{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
    17		{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
    18		{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
    19		{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
    20		{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
    21	};
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

