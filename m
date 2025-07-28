Return-Path: <netdev+bounces-210600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBCB14055
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0704517DDE3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEFB274B3D;
	Mon, 28 Jul 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5vXB/K5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A552741CF;
	Mon, 28 Jul 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720348; cv=none; b=filPMMV0w6yJI5DG6h4FmGPsPfQiyjmxM/cliHCgTh+L9gFh7EYZwYQUbWfXc7g2HK3NZWMAxmg6TdLxJfHJi9d8r+BqxUUA/fweQ4bs9yp34I7xhgg30+r5fkfPk3iOo+XTdA9QurqqZ/qBNe+FHJVFyx0chC/NrebK7Oq+GC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720348; c=relaxed/simple;
	bh=1yb0pqXxD3KNSgQ3Nzfu2dLtSw9BOrCruLTqB2eK/Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppSSBTPb9wfTnzJo8i3STq7bhQZtt/23ojkDGbzskOkdECFONhYoUlcRoi4dAnVWdrCecDSG4dHGVORYQV8tv6nzo+QJfQoVzuMCa43e/qfOckigCZGNHcgKKPar9HpQKbfSfk/egHn/uvPDQiShOCt7+tEtUJ1w6kptoLSz0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5vXB/K5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753720347; x=1785256347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1yb0pqXxD3KNSgQ3Nzfu2dLtSw9BOrCruLTqB2eK/Rs=;
  b=O5vXB/K5B8e5mnczXcQlXfr9MRBinSAkGmrDlg/DTxSt/CDEn0YsnfYo
   GQUOCkPFmJUu0uZ4XxMSMUdCQ6xeeqkekuP/CiktgBpAyhAgxWOolSEWo
   k3He4F1XNytQ9WykB1HCKX212hKAmbEEcjUu7w8fxMG6i4ghZ1tBf+ORZ
   euoZ/rjGVCMbA/c8r15Rz7r3CkpRZ40x+g6tLjIpnZG06kC9rSjrkr0Tb
   Dg/X5NfURd62K+WkJLH7VRTiwvuVMVW4yo0zI5ccB2aafM6BIb52JRIJz
   UM52ojkVWJT5RJa4xZUO2V3pdwGwU4+bT84M/+9dsqHiImzZ8nWNYIj6E
   A==;
X-CSE-ConnectionGUID: GQE7rQM/RaqLFN6KDdoIug==
X-CSE-MsgGUID: Txf1Smw6ToCouWoNe9Rmow==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59797058"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59797058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 09:32:22 -0700
X-CSE-ConnectionGUID: clCZdht2Q72DVqHqxv/Ndg==
X-CSE-MsgGUID: DU6xuo/bTJeRA5tcNERSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166946246"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2025 09:32:16 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugQlp-0000aN-1C;
	Mon, 28 Jul 2025 16:32:13 +0000
Date: Tue, 29 Jul 2025 00:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, git@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vineeth.karumanchi@amd.com
Subject: Re: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload
 command interface
Message-ID: <202507290045.ckQlBy8r-lkp@intel.com>
References: <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722154111.1871292-6-vineeth.karumanchi@amd.com>

Hi Vineeth,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vineeth-Karumanchi/net-macb-Define-ENST-hardware-registers-for-time-aware-scheduling/20250722-234618
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250722154111.1871292-6-vineeth.karumanchi%40amd.com
patch subject: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload command interface
config: i386-randconfig-005-20250728 (https://download.01.org/0day-ci/archive/20250729/202507290045.ckQlBy8r-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290045.ckQlBy8r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290045.ckQlBy8r-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/net/ethernet/cadence/macb.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/cadence/macb.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

