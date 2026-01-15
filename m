Return-Path: <netdev+bounces-250343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8CD29374
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6AD300A35A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F672FFDDE;
	Thu, 15 Jan 2026 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys1zqpzl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F662EB87D;
	Thu, 15 Jan 2026 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519167; cv=none; b=g7+7mgXkAm2U1muR6qRdmZWfuJJuifV3t3gKWJJX+747ir5CsTCu3lvbQZvekdYhIsxntlyQ8K4pKcXpKzChGsBgbZOcGO3wRuLlnJVcWguBXSrrdOxJBLECfhn11Qe5EY7NKryJUu8C4Pv+vvNU87WJC5gQFHqQDPhhPmPHa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519167; c=relaxed/simple;
	bh=kwGRF5mURihJe/iQlmz7bEwEkA+zgkfqc7bU0SHLJZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoEFiHbq+wlJlFa5NkelouNyY/upWqdEuYQHbqCX/UL4a6mSM7ayFUVZRFxCIffKrz53Gtb62EWfM1bIjFjwSd2aQCmTNQjOPCNWHWRUHSmJQT6dRQvKV8LeTxVdUXDiWo1rDLeMZhSMmcd1GML+qI2WdjycBlj+S+HX8yR1U80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys1zqpzl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768519166; x=1800055166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwGRF5mURihJe/iQlmz7bEwEkA+zgkfqc7bU0SHLJZc=;
  b=Ys1zqpzldmic0T97luv/oZV2BZmvBuMNJokT+NJZE0sGrVkgYla+CoWK
   0m9pUja5/k3U7fMvszundbcKmx3j9blorwydzRbJrxUbWgEUwOZbpRTfS
   VnwYcU/FBkkvnn8tiqsDHLhdWaqn8se0P3ObA4ec4xjulfrJBRZk+G0/z
   YBp3tOxFJ0+FISUdtyN2stbEWHEgJYBJA1UUK0qJ/bvrt8cpgIOz1uDmu
   ptJ+FQinssHXpVQC46CyBJLBO4KfLqWe1pjzNuWWxkYO+GtXBd4C79cHO
   iD/XewEFkgOacOsZUkrJJigzc4ejVAipqTdiaPynIyHi/weypVDJHLKSM
   Q==;
X-CSE-ConnectionGUID: Of/mdfkrRsCTOoMmyttuYw==
X-CSE-MsgGUID: kIbWcXM+Tymfm4cmdz0Tlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81283361"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="81283361"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:19:25 -0800
X-CSE-ConnectionGUID: I06q/XGzSDitkMj/Do7Ecg==
X-CSE-MsgGUID: EAbpvl4JTUi151xMldnkpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205496892"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 15:19:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgWcZ-00000000K6K-0h7Y;
	Thu, 15 Jan 2026 23:19:19 +0000
Date: Fri, 16 Jan 2026 07:18:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	"Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH net-next 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Message-ID: <202601160729.AzeG6b64-lkp@intel.com>
References: <20260115-ksz8463-ptp-v1-4-bcfe2830cf50@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-ksz8463-ptp-v1-4-bcfe2830cf50@bootlin.com>

Hi Bastien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3adff276e751051e77be4df8d29eab1cf0856fbf]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet-Schneider-Electric/net-dsa-microchip-Add-support-for-KSZ8463-global-irq/20260116-000545
base:   3adff276e751051e77be4df8d29eab1cf0856fbf
patch link:    https://lore.kernel.org/r/20260115-ksz8463-ptp-v1-4-bcfe2830cf50%40bootlin.com
patch subject: [PATCH net-next 4/8] net: dsa: microchip: Add support for KSZ8463's PTP interrupts
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260116/202601160729.AzeG6b64-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160729.AzeG6b64-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160729.AzeG6b64-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz_ptp.c:1187:40: warning: variable 'p' is uninitialized when used here [-Wuninitialized]
    1187 |         ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
         |                                               ^
   drivers/net/dsa/microchip/ksz_ptp.c:1175:7: note: initialize the variable 'p' to silence this warning
    1175 |         int p;
         |              ^
         |               = 0
   1 warning generated.


vim +/p +1187 drivers/net/dsa/microchip/ksz_ptp.c

  1167	
  1168	int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
  1169	{
  1170		struct ksz_device *dev = ds->priv;
  1171		const struct ksz_dev_ops *ops = dev->dev_ops;
  1172		struct ksz_port *port1, *port2;
  1173		struct ksz_irq *ptpirq;
  1174		int ret;
  1175		int p;
  1176	
  1177		port1 = &dev->ports[0];
  1178		port2 = &dev->ports[1];
  1179		ptpirq = &port1->ptpirq;
  1180	
  1181		ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
  1182		if (!ptpirq->irq_num)
  1183			return -EINVAL;
  1184	
  1185		ptpirq->dev = dev;
  1186		ptpirq->nirqs = 4;
> 1187		ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
  1188		ptpirq->reg_status = ops->get_port_addr(p, KSZ8463_PTP_TS_ISR);
  1189		ptpirq->irq0_offset = KSZ8463_PTP_INT_START;
  1190		snprintf(ptpirq->name, sizeof(ptpirq->name), "ptp-irq-%d", p);
  1191	
  1192		ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
  1193							  &ksz_ptp_irq_domain_ops, ptpirq);
  1194		if (!ptpirq->domain)
  1195			return -ENOMEM;
  1196	
  1197		ret = request_threaded_irq(ptpirq->irq_num, NULL, ksz_ptp_irq_thread_fn,
  1198					   IRQF_ONESHOT, ptpirq->name, ptpirq);
  1199		if (ret)
  1200			goto release_domain;
  1201	
  1202		ret = ksz8463_ptp_port_irq_setup(ptpirq, port1,
  1203						 KSZ8463_PTP_PORT1_INT_START - KSZ8463_PTP_INT_START);
  1204		if (ret)
  1205			goto release_irq;
  1206	
  1207		ret = ksz8463_ptp_port_irq_setup(ptpirq, port2,
  1208						 KSZ8463_PTP_PORT2_INT_START - KSZ8463_PTP_INT_START);
  1209		if (ret)
  1210			goto free_port1;
  1211	
  1212		return 0;
  1213	
  1214	free_port1:
  1215		ksz8463_ptp_port_irq_teardown(port1);
  1216	release_irq:
  1217		free_irq(ptpirq->irq_num, ptpirq);
  1218	release_domain:
  1219		irq_domain_remove(ptpirq->domain);
  1220	
  1221		return ret;
  1222	}
  1223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

