Return-Path: <netdev+bounces-145614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD29D01EA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 04:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BCAB21F9B
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266BED515;
	Sun, 17 Nov 2024 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdiJGosl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCBBA3F;
	Sun, 17 Nov 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731812745; cv=none; b=oY6JywFeoS/UTJkpr5plCmvtA4HhPs8xF8YWqN+BeJ2Rtos8cAGAYM1T5GruAVcE6XzBFab2CZxwhQSLV5vi6L9rsM5e9qjKdcr6fZ4SDwDsOcVCtJ/7PDZShrQPU18MRciYdRAhSXlLG1qyZilP9xeSiWEJHoTEvNfcR5rO3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731812745; c=relaxed/simple;
	bh=CHrsYTfEg3BHIhf2gtxsVvuv1Sg6ZU+fanYiVmQxMLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR/fvYbEa8hJURMs3reEoKRXSI2QmczHV+9bto5AVsS6G87XWCcEssMaXygivs4WjCFmTV+21lKjelLvHVv0FGwX2LbM7KcDETJxfIGYwmHOOjz29m314rCo+9nzkU94a13wWb/TcrcLSIvOrM5nZZqvan/qLG/GJMHpVjBCtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdiJGosl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731812742; x=1763348742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHrsYTfEg3BHIhf2gtxsVvuv1Sg6ZU+fanYiVmQxMLU=;
  b=KdiJGoslHYgLV3ORZf6a7WUswimPm5qy2zKY/eZ3+YXCb7rqPBhjG49f
   QqKbj0TzBkk/BpzXHTGlyv79zmJYY5JW2n6GcUbFOAmj0nPMwIT2sbl6j
   r/IUx+CBFamdE/FmnCea6PZeMKzM1oP63LrF7yV/APmL4mo0AIsIbBDrD
   tMY354GDVU5YyS66OJRGd5kSZCDfpkXk80BX/JhASGMkq9S5k65CEDEBW
   gMP58TkYxIkqBIJpNgi+IWykONrEGp2j7Z/sE+YSK7QZhe9wKcqgLbx1s
   0pA8WFIGO3hWUDRv485iGk9O+uJUos9gVfbq4anoeUy3RdNrWMysdS/dA
   Q==;
X-CSE-ConnectionGUID: oqPnFRcgT1OLEKVv27jiMQ==
X-CSE-MsgGUID: GaLYDS3bRFSgcDHnH7ozOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31199853"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31199853"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 19:05:41 -0800
X-CSE-ConnectionGUID: 9AR+ZDSRRySkglu2Zx+FcA==
X-CSE-MsgGUID: AODqRlbGSV6WufBreVf/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88478076"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Nov 2024 19:05:37 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCVbT-0001HR-0T;
	Sun, 17 Nov 2024 03:05:35 +0000
Date: Sun, 17 Nov 2024 11:04:39 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v7 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202411171010.YDEy5wvg-lkp@intel.com>
References: <20241114024928.60004-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114024928.60004-3-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc7 next-20241115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241114-105151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114024928.60004-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH v7 2/2] mctp pcc: Implement MCTP over PCC Transport
config: riscv-kismet-CONFIG_ACPI-CONFIG_MCTP_TRANSPORT_PCC-0-0 (https://download.01.org/0day-ci/archive/20241117/202411171010.YDEy5wvg-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241117/202411171010.YDEy5wvg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171010.YDEy5wvg-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ACPI when selected by MCTP_TRANSPORT_PCC
   WARNING: unmet direct dependencies detected for ACPI
     Depends on [n]: ARCH_SUPPORTS_ACPI [=n]
     Selected by [y]:
     - MCTP_TRANSPORT_PCC [=y] && NETDEVICES [=y] && MCTP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

