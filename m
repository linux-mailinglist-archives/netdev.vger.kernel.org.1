Return-Path: <netdev+bounces-105351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF4910977
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C4F1C21662
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E61AF693;
	Thu, 20 Jun 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4KL8xx1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA81AE0AC;
	Thu, 20 Jun 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896463; cv=none; b=q3Yk8MPyN8TjeZt10+Tu3JAtd/y998kqaapKFyPi8qRTq+yf+odG+sjch7+ZrTqbCahCisz5WQNhLCdzSb/gLHhmdJJiGSyKlwmkFQCvcd8/bmCKYD9AO4BPYmPan1q77HV87wc8F7i/4JsLU1vt9d3Tz8vxCLq/6Sw+OoRw84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896463; c=relaxed/simple;
	bh=hchd0yzgV/Lu9QC2uQ3ylV/jLOxjSf3niBC2u+cVng8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjt4rMs7sqH9mCN225Xx6nZ49uWTQJz9OQT3P9o6N04pgNBpj+gTPlzZtK0Z9mupyWd4d2Jck/mX0iTQBMAnKsUFZrRPv/bt+MQ6DxKlKUdrNGrTdcesGNSgqlLz4/00wrA7k7XOLEl/2+CKx16fLqf1Kn8xXktyZPluiSotTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4KL8xx1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718896461; x=1750432461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hchd0yzgV/Lu9QC2uQ3ylV/jLOxjSf3niBC2u+cVng8=;
  b=G4KL8xx1wlRWPmhDPyB3s35Y4wemuEKGYdD/ZV8Kghp1Ysg88tj8CbiO
   1An2EMJrFa6kcZeIHxbdZOS1g4rrpVUo6ptYA1lGK3PzdGzK85TgAYsVM
   VcjVIc0j2etD311/QFg1437vbwrjjyez1yTpNmd0GHZbESC7TSn0Wuc09
   Ted4k+adK7OpZUkMx9BUTdWVrHsWLj32Pe4kx40+NJ7+NrnbRPo3GxvNd
   kT9RaqeU8/WY1t0/9JW8bBRT8pzJvnloZ60zp9X9OvRM/xrRFjF76TRei
   IpjDMmAWbHbDDPyonzBMlx9FIK8VFPcT235lWXbehkehmpDIaJ+jZRY4F
   w==;
X-CSE-ConnectionGUID: H82ERXWYSSWnsRHIT9Xdfg==
X-CSE-MsgGUID: z+jiZ9hrSTKjymliJJTTTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15756670"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15756670"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:14:10 -0700
X-CSE-ConnectionGUID: OkY8lUvwSuq2jPMqeWG5wA==
X-CSE-MsgGUID: /JRLTXRCQlGqqL3nnQ75FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42213460"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 08:14:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKJUD-0007hU-2G;
	Thu, 20 Jun 2024 15:14:05 +0000
Date: Thu, 20 Jun 2024 23:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202406202206.9e7oGmfh-lkp@intel.com>
References: <20240619200552.119080-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619200552.119080-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc4 next-20240619]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240620-040816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240619200552.119080-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
config: arm64-kismet-CONFIG_ACPI-CONFIG_MCTP_TRANSPORT_PCC-0-0 (https://download.01.org/0day-ci/archive/20240620/202406202206.9e7oGmfh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240620/202406202206.9e7oGmfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406202206.9e7oGmfh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ACPI when selected by MCTP_TRANSPORT_PCC
   WARNING: unmet direct dependencies detected for ACPI
     Depends on [n]: ARCH_SUPPORTS_ACPI [=n]
     Selected by [y]:
     - MCTP_TRANSPORT_PCC [=y] && NETDEVICES [=y] && MCTP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

